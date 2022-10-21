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
      {
        name = "woodpecker";
        ensurePermissions = {
          "DATABASE woodpecker" = "ALL PRIVILEGES";
        };
      }
      {
        name = "grafana";
        ensurePermissions = {
          "DATABASE grafana" = "ALL PRIVILEGES";
        };
      }
      {
        name = "gitea";
        ensurePermissions = {
          "DATABASE gitea" = "ALL PRIVILEGES";
        };
      }
      {
        name = "wiki";
        ensurePermissions = {
          "DATABASE wiki" = "ALL PRIVILEGES";
        };
      }
      {
        name = "maddy";
        ensurePermissions = {
          "DATABASE maddy" = "ALL PRIVILEGES";
        };
      }
    ];
    ensureDatabases = [
      "vaultwarden"
      "woodpecker"
      "grafana"
      "gitea"
      "maddy"
      "wiki"
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
