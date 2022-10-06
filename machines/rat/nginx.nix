{ config, ... }:

{
  services.fs-nginx = {
    enable = true;
    virtualHosts = {
      "_" = {
        useACMEHost = "ipfsqr.ru";
        locations."/".proxyPass = "http://127.0.0.1:8080/";
      };
      "git.frsqr.xyz" = {
        useACMEHost = "frsqr.xyz";
        locations."/".proxyPass = "http://127.0.0.1:3001/";
      };
      "wp.frsqr.xyz" = {
        useACMEHost = "frsqr.xyz";
        locations."/".proxyPass = "http://127.0.0.1:8000/";
      };
      "bw.frsqr.xyz" = {
        useACMEHost = "frsqr.xyz";
        locations."/".proxyPass = "http://127.0.0.1:8222/";
      };
      "grafana.frsqr.xyz" = {
        useACMEHost = "frsqr.xyz";
        locations."/".proxyPass = "http://127.0.0.1:3729/";
      };
      "wiki.firesquare.ru" = {
        useACMEHost = "ipfsqr.ru";
        locations."/".proxyPass = "http://127.0.0.1:3002/";
      };
      "api.firesquare.ru" = {
        useACMEHost = "ipfsqr.ru";
        locations."/".proxyPass = "http://127.0.0.1:3003/";
      };
    };
  };

  services.vaultwarden = {
    enable = true;
    dbBackend = "sqlite";
    backupDir = "/var/lib/bitwarden_rs/backup";
    config = {
      domain = "https://bw.frsqr.xyz";
      signupsAllowed = false;
      rocketPort = 8222;
      rocketAddress = "127.0.0.1";
    };
  };

  age.secrets.woodpecker-server.file = ../../secrets/credentials/woodpecker-server.age;
  services.woodpecker = {
    enable = true;
    settings = {
      WOODPECKER_OPEN = "true";
      WOODPECKER_HOST = "https://wp.frsqr.xyz";
      WOODPECKER_GITEA = "true";
      WOODPECKER_GITEA_URL = "https://git.frsqr.xyz";
      WOODPECKER_DATABASE_DRIVER = "postgres";
    };
    environmentFile = config.age.secrets.woodpecker-server.path;
  };

  age.secrets.wiki-env.file = ../../secrets/wiki-env.age;
  age.secrets.wiki-env.owner = "wiki-js";
  services.wiki-js-fs = {
    enable = true;
    settings = {
      port = 3002;
    };
    environmentFile = config.age.secrets.wiki-env.path;
  };
}
