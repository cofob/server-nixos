{ ... }:

{
  services.backup = {
    enable = true;
    timers.daily = [
      "postgresql.pxar:/var/lib/postgresql/14"
      "mysql.pxar:/var/lib/mysql"
      "gitea.pxar:/var/lib/gitea"
      "wiki-js.pxar:/var/lib/wiki-js"
      "bitwarden.pxar:/var/lib/bitwarden_rs"
      "cockroachdb.pxar:/var/lib/cockroachdb"
    ];
  };
}
