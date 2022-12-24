{ pkgs, config, ... }:

{
  age.secrets.credentials-nextcloud-admin.file = ../../../secrets/credentials/nextcloud-admin.age;
  age.secrets.credentials-nextcloud-admin.owner = "nextcloud";
  age.secrets.credentials-nextcloud-admin.group = "nextcloud";

  services.nextcloud = {
    enable = true;
    https = true;
    package = pkgs.nextcloud25;
    hostName = "cloud.frsqr.xyz";
    enableBrokenCiphersForSSE = false;
    caching.redis = true;
    extraAppsEnable = true;
    extraApps = with pkgs.nextcloud25Packages.apps; {
      inherit tasks polls onlyoffice notes deck;
    };
    config = {
      dbtype = "pgsql";
      dbport = 0;
      dbhost = "/run/postgresql";
      dbname = "nextcloud";
      dbuser = "nextcloud";
      adminpassFile = config.age.secrets.credentials-nextcloud-admin.path;
      trustedProxies = [ "10.100.0.1" ];
      overwriteProtocol = "https";
      extraTrustedDomains = [ "10.100.0.2" ];
    };
    extraOptions = {
      redis = {
        host = "/run/redis-nextcloud/redis.sock";
        port = 0;
        dbindex = 0;
        password = "secret";
        timeout = 1.5;
      };
    };
  };

  services.nginx.virtualHosts."cloud.frsqr.xyz" =
    let
      cert = pkgs.fetchurl {
        url = "https://developers.cloudflare.com/ssl/static/authenticated_origin_pull_ca.pem";
        sha256 = "0hxqszqfzsbmgksfm6k0gp0hsx9k1gqx24gakxqv0391wl6fsky1";
      };
    in
    {
      sslCertificate = config.age.secrets.cf-certs-frsqr-xyz-cert.path;
      sslCertificateKey = config.age.secrets.cf-certs-frsqr-xyz-key.path;
      listen = [
        { port = 8443; addr = "0.0.0.0"; }
      ];
      extraConfig = ''
        ssl_client_certificate ${cert};
        ssl_verify_client on;
      '';
    };

  networking.firewall.allowedTCPPorts = [ 8443 ];

  services.redis.servers."nextcloud" = {
    enable = true;
    requirePass = "secret";
  };

  services.backup.timers.daily = [
    "nextcloud.pxar:${config.services.nextcloud.datadir}"
  ];
}
