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

  services.fs-nginx.virtualHosts."bw.cofob.dev" = {
    onlyCloudflare = true;
    locations."/".proxyPass = "http://127.0.0.1:8222/";
    sslCertificate = config.age.secrets.cf-certs-cofob-dev-cert.path;
    sslCertificateKey = config.age.secrets.cf-certs-cofob-dev-key.path;
  };

  services.backup.timers.daily = [
    "bitwarden.pxar:/var/lib/bitwarden_rs"
  ];
}
