{ lib, config, ... }:

{
  age.secrets.cf-certs-cofob-dev-cert.file = ../secrets/cf-certs/cofob.dev-cert.age;
  age.secrets.cf-certs-cofob-dev-key.file = ../secrets/cf-certs/cofob.dev-key.age;
  age.secrets.cf-certs-cofob-dev-cert.group = "nginx";
  age.secrets.cf-certs-cofob-dev-key.group = "nginx";
  age.secrets.cf-certs-cofob-dev-cert.owner = "nginx";
  age.secrets.cf-certs-cofob-dev-key.owner = "nginx";

  services.cofob-ru.enable = true;
  security.acme.certs."cofob.dev" = { };

  services.fs-nginx = {
    enable = lib.mkDefault true;
    virtualHosts."cofob.dev" = {
      useACMEHost = "cofob.dev";
      locations."/".proxyPass = "http://127.0.0.1:3000/";
    };
  };
}
