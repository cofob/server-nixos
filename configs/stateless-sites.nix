{ lib, config, pkgs, ... }:

{
  age.secrets.cf-certs-cofob-dev-cert.file = ../secrets/cf-certs/cofob.dev-cert.age;
  age.secrets.cf-certs-cofob-dev-key.file = ../secrets/cf-certs/cofob.dev-key.age;
  age.secrets.cf-certs-cofob-dev-cert.group = "nginx";
  age.secrets.cf-certs-cofob-dev-key.group = "nginx";
  age.secrets.cf-certs-cofob-dev-cert.owner = "nginx";
  age.secrets.cf-certs-cofob-dev-key.owner = "nginx";

  # services.cofob-dev.enable = true;

  # services.nginx = {
  #   enable = lib.mkDefault true;
  #   virtualHosts."cofob.dev" = {
  #     locations."/".proxyPass = "http://127.0.0.1:3000/";
  #     sslCertificate = config.age.secrets.cf-certs-cofob-dev-cert.path;
  #     sslCertificateKey = config.age.secrets.cf-certs-cofob-dev-key.path;
  #     extraConfig = ''
  #       ssl_client_certificate ${pkgs.fetchurl {
  #         url = "https://developers.cloudflare.com/ssl/static/authenticated_origin_pull_ca.pem";
  #         sha256 = "0hxqszqfzsbmgksfm6k0gp0hsx9k1gqx24gakxqv0391wl6fsky1";
  #       }};
  #       ssl_verify_client on;
  #     '';
  #   };
  # };
}
