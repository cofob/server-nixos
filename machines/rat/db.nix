{ config, pkgs, ... }:

{
  services.postgresql = {
    enable = true;
    ensureUsers = [
      {
        name = "vaultwarden";
        ensurePermissions = {
          "DATABASE vaultwarden" = "ALL PRIVILEGES";
        };
      }
    ];
    ensureDatabases = [
      "vaultwarden"
    ];
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
