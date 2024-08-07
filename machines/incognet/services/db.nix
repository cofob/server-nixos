{ config, pkgs, ... }:

{
  services.postgresql = {
    enable = true;
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
  services.telegram-backup.timers.daily = [
    config.services.postgresql.dataDir
    config.services.postgresqlBackup.location
  ];
}
