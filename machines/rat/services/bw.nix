{ config, ... }:

{
  services.vaultwarden = {
    enable = true;
    dbBackend = "sqlite";
    backupDir = "/var/lib/bitwarden_rs/backup";
    config = {
      domain = "https://bw.cofob.dev";
      signupsAllowed = false;
      rocketPort = 8222;
      rocketAddress = "127.0.0.1";
    };
  };

  security.acme.certs."bw.cofob.dev" = { };

  services.fs-nginx.virtualHosts."bw.cofob.dev" = {
    useACMEHost = "bw.cofob.dev";
    locations."/".proxyPass = "http://127.0.0.1:8222/";
  };

  services.backup.timers.daily = [
    "bitwarden.pxar:/var/lib/bitwarden_rs"
  ];
}
