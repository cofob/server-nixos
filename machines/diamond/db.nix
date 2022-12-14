{ config, pkgs, ... }:

{
  services.postgresql = {
    enable = true;
    enableTCPIP = true;
    ensureUsers = [
      {
        name = "nextcloud";
        ensurePermissions = {
          "DATABASE nextcloud" = "ALL PRIVILEGES";
        };
      }
      {
        name = "grafana";
        ensurePermissions = {
          "DATABASE grafana" = "ALL PRIVILEGES";
        };
      }
    ];
    ensureDatabases = [
      "nextcloud"
      "grafana"
    ];
    authentication = ''
      # TYPE  DATABASE        USER            ADDRESS                 METHOD
      local   all             all                                     trust
    '';
  };

  services.postgresqlBackup = {
    enable = true;
    compression = "none";
    backupAll = true;
  };

  services.backup.timers.daily = [
    "postgresql.pxar:${config.services.postgresql.dataDir}"
    "postgresql_dump.pxar:${config.services.postgresqlBackup.location}"
  ];
}
