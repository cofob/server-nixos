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
    config = {
      dbtype = "pgsql";
      dbport = "5432";
      dbhost = "127.0.0.1";
      dbname = "nextcloud";
      dbuser = "nextcloud";
      adminpassFile = config.age.secrets.credentials-nextcloud-admin.path;
      trustedProxies = [ "10.100.0.1" ];
      overwriteProtocol = "https";
    };
  };

  services.backup.timers.daily = [
    "nextcloud.pxar:${config.services.nextcloud.datadir}"
  ];
}
