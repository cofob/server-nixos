{ lib, config, ... }:

{
  age.secrets.cf-certs-cofob-dev-cert.file = ../secrets/cf-certs/cofob.dev-cert.age;
  age.secrets.cf-certs-cofob-dev-key.file = ../secrets/cf-certs/cofob.dev-key.age;
  age.secrets.cf-certs-cofob-dev-cert.group = "nginx";
  age.secrets.cf-certs-cofob-dev-key.group = "nginx";
  age.secrets.cf-certs-cofob-dev-cert.owner = "nginx";
  age.secrets.cf-certs-cofob-dev-key.owner = "nginx";

  age.secrets.credentials-ipfs-proxy.file = ../secrets/credentials/ipfs-proxy.age;
  services.ipfs-proxy = {
    enable = true;
    envFile = config.age.secrets.credentials-ipfs-proxy.path;
  };

  services.cofob-ru.enable = true;

  services.fs-nginx = {
    enable = lib.mkDefault true;
    virtualHosts."ipfs.cofob.dev" = {
      locations."/".proxyPass = "http://127.0.0.1:2314/";
      onlyCloudflare = true;
      sslCertificate = config.age.secrets.cf-certs-cofob-dev-cert.path;
      sslCertificateKey = config.age.secrets.cf-certs-cofob-dev-key.path;
    };
    virtualHosts."cofob.dev" = {
      locations."/".proxyPass = "http://127.0.0.1:3000/";
      onlyCloudflare = true;
      sslCertificate = config.age.secrets.cf-certs-cofob-dev-cert.path;
      sslCertificateKey = config.age.secrets.cf-certs-cofob-dev-key.path;
    };
  };
}
