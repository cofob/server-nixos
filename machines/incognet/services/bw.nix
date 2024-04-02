{ config, lib, pkgs, ... }:

{
  services.vaultwarden = {
    enable = true;
    dbBackend = "sqlite";
    backupDir = "/var/lib/bitwarden_rs/backup";
    config = {
      domain = "https://bw.cofob.dev";
      signupsAllowed = true;
      rocketPort = 8222;
      rocketAddress = "127.0.0.1";
    };
  };

  services.nginx.enable = lib.mkDefault true;
  services.nginx.virtualHosts."bw.cofob.dev" = {
    enableACME = true;
    quic = true;
    forceSSL = true;
    locations."/".proxyPass = "http://127.0.0.1:8222/";
  };

  services.backup.timers.daily = [
    "bitwarden.pxar:/var/lib/bitwarden_rs"
  ];
  services.telegram-backup.timers.hourly = [
    "/var/lib/bitwarden_rs"
  ];
}
