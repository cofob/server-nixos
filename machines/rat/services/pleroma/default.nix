{ config
, pkgs
, lib
, conduit
, self
, ...
}:

{
  age.secrets.credentials-pleroma.file = "${self}/secrets/credentials/pleroma.age";
  age.secrets.credentials-pleroma.owner = "pleroma";
  age.secrets.credentials-pleroma.group = "pleroma";
  services.pleroma = {
    enable = true;
    secretConfigFile = config.age.secrets.credentials-pleroma.path;
    configs = [
      ''
        import Config

        config :pleroma, :instance,
          name: "social.cofob.dev",
          email: "cofob@riseup.net",
          notify_email: "nonotify@example.com",
          limit: 5000,
          registrations_open: true

        config :pleroma, :media_proxy,
          enabled: true,
          redirect_on_failure: true

        config :pleroma, :database, rum_enabled: false
        config :pleroma, :instance, static_dir: "/var/lib/pleroma/static"
        config :pleroma, Pleroma.Uploaders.Local, uploads: "/var/lib/pleroma/uploads"

        # Enable Strict-Transport-Security
        config :pleroma, :http_security,
          sts: true

        config :pleroma, configurable_from_database: false

        config :pleroma, Pleroma.Upload, filters: [Pleroma.Upload.Filter.Exiftool.StripLocation, Pleroma.Upload.Filter.Exiftool.ReadDescription, Pleroma.Upload.Filter.AnonymizeFilename, Pleroma.Upload.Filter.Dedupe]
      ''
    ];
  };
  systemd.services.pleroma.path = [ pkgs.exiftool ];

  age.secrets.credentials-pleroma-db-password.file = "${self}/secrets/credentials/pleroma-db-password.age";
  age.secrets.credentials-pleroma-db-password.owner = "postgres";
  systemd.services.postgresql-db-pleroma-setup = {
    requiredBy = [ "pleroma.service" ];
    after = [ "postgresql.service" ];
    path = with pkgs; [ config.services.postgresql.package replace-secret ];
    serviceConfig = {
      RuntimeDirectory = "postgresql-db-pleroma-setup";
      RuntimeDirectoryMode = "700";
      Type = "oneshot";
      User = "postgres";
    };
    script = ''
      # set bash options for early fail and error output
      set -o errexit -o pipefail -o nounset -o errtrace -o xtrace
      shopt -s inherit_errexit
      # Copy SQL template into temporary folder. The value of RuntimeDirectory is written into
      # environment variable RUNTIME_DIRECTORY by systemd.
      install --mode 600 ${./db-init.sql} "$RUNTIME_DIRECTORY/init.sql"
      # fill SQL template with passwords
      replace-secret @DB_PASSWORD@ ${config.age.secrets.credentials-pleroma-db-password.path} "$RUNTIME_DIRECTORY/init.sql"
      # run filled SQL template
      psql pleroma --file "$RUNTIME_DIRECTORY/init.sql"
    '';
  };

  services.nginx = {
    enable = lib.mkDefault true;

    proxyCachePath.pleroma_media_cache = {
      enable = true;
      levels = "1:2";
      maxSize = "10g";
      inactive = "720m";
      useTempPath = false;
      keysZoneName = "pleroma_media_cache";
      keysZoneSize = "10m";
    };

    virtualHosts."social.cofob.dev" = {
      enableACME = true;
      quic = true;
      http3 = true;
      kTLS = true;
      forceSSL = true;

      locations."/".proxyPass = "http://backend_pleroma";
      locations."~ ^/(media|proxy)" = {
        proxyPass = "http://backend_pleroma";
        extraConfig = ''
          proxy_cache        pleroma_media_cache;
          proxy_cache_key    $host$uri$is_args$args;
          proxy_cache_valid  200 206 301 304 1h;
          proxy_cache_lock   on;
          proxy_ignore_client_abort on;
          proxy_buffering    on;
          chunked_transfer_encoding on;
        '';
      };
    };

    upstreams = {
      "backend_pleroma" = {
        servers = {
          "127.0.0.1:4000" = { };
        };
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
  networking.firewall.allowedUDPPorts = [ 443 ];

  services.backup.timers.daily = [
    "pleroma.pxar:${config.services.pleroma.stateDir}"
  ];
}
