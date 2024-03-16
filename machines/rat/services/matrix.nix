{ config
, pkgs
, conduit
, ...
}:

{
  services.matrix-conduit = {
    enable = true;
    package = conduit.packages.${pkgs.system}.default;
    settings.global = {
      server_name = "cofob.dev";
      database_backend = "rocksdb";
    };
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;

    virtualHosts = {
      "matrix.cofob.dev" = {
        enableACME = true;
        quic = true;
        http3 = true;
        kTLS = true;
        forceSSL = true;

        locations."/".return = "403";

        locations."/_matrix/" = {
          proxyPass = "http://backend_conduit$request_uri";
          proxyWebsockets = true;
          extraConfig = ''
            proxy_set_header Host $host;
            proxy_buffering off;

            client_max_body_size ${toString config.services.matrix-conduit.settings.global.max_request_size};
          '';
        };

        extraConfig = ''
          merge_slashes off;
        '';
      };
    };

    upstreams = {
      "backend_conduit" = {
        servers = {
          "[::1]:${toString config.services.matrix-conduit.settings.global.port}" = { };
        };
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
  networking.firewall.allowedUDPPorts = [ 443 ];

  services.backup.timers.daily = [
    "matrix-conduit.pxar:${config.services.matrix-conduit.settings.global.database_path}"
  ];
  services.telegram-backup.timers.hourly = [
    "${config.services.matrix-conduit.settings.global.database_path}"
  ];
}
