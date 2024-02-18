{ config, pkgs, ... }:

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

  services.nginx.virtualHosts."bw.cofob.dev" = {
    locations."/".proxyPass = "http://127.0.0.1:8222/";
    sslCertificate = config.age.secrets.cf-certs-cofob-dev-cert.path;
    sslCertificateKey = config.age.secrets.cf-certs-cofob-dev-key.path;
      extraConfig = ''
        ssl_client_certificate ${pkgs.fetchurl {
          url = "https://developers.cloudflare.com/ssl/static/authenticated_origin_pull_ca.pem";
          sha256 = "0hxqszqfzsbmgksfm6k0gp0hsx9k1gqx24gakxqv0391wl6fsky1";
        }};
        ssl_verify_client on;
      '';
  };

  services.backup.timers.daily = [
    "bitwarden.pxar:/var/lib/bitwarden_rs"
  ];
}
