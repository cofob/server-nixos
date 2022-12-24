{ pkgs, config, ... }:

{
  age.secrets.credentials-nextcloud-admin.file = ../../../secrets/credentials/nextcloud-admin.age;
  age.secrets.credentials-nextcloud-admin.owner = "nextcloud";
  age.secrets.credentials-nextcloud-admin.group = "nextcloud";

  services.fs-nextcloud = {
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

  services.fs-nginx.virtualHosts."cloud.frsqr.xyz" = {
    sslCertificate = config.age.secrets.cf-certs-frsqr-xyz-cert.path;
    sslCertificateKey = config.age.secrets.cf-certs-frsqr-xyz-key.path;
    onlyCloudflare = true;
    recommendedTlsSettings = false;
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
