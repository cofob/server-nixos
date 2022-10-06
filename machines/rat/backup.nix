{ config, ... }:

{
  services.backup = {
    enable = true;
    timers.daily = [
      "postgresql.pxar:${config.services.postgresql.dataDir}"
      "postgresql_dump.pxar:${config.services.postgresqlBackup.location}"
      "gitea.pxar:${config.services.gitea.stateDir}"
      "wiki-js.pxar:/var/lib/wiki-js"
      "bitwarden.pxar:/var/lib/bitwarden_rs"
      "cockroachdb.pxar:/var/lib/cockroachdb"
    ];
  };

  services.postgresqlBackup = {
    enable = true;
    compression = "none";
    backupAll = true;
  };
}
