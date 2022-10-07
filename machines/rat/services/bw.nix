{ ... }:

{
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

  security.acme.certs."bw.frsqr.xyz" = { };

  services.fs-nginx.virtualHosts."bw.frsqr.xyz" = {
    useACMEHost = "bw.frsqr.xyz";
    locations."/".proxyPass = "http://127.0.0.1:8222/";
  };

  services.backup.timers.daily = [
    "bitwarden.pxar:/var/lib/bitwarden_rs"
  ];
}
