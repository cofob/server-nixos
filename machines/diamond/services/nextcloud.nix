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
    autoUpdateApps.enable = true;
    enableBrokenCiphersForSSE = false;
    caching.redis = true;
    config = {
      dbtype = "pgsql";
      dbport = "5432";
      dbhost = "127.0.0.1";
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

  services.redis.servers."nextcloud" = {
    enable = true;
    requirePass = "secret";
  };

  services.backup.timers.daily = [
    "nextcloud.pxar:${config.services.nextcloud.datadir}"
  ];
}
