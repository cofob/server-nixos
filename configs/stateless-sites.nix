{ lib, config, ... }:

{
  age.secrets.cf-certs-frsqr-xyz-cert.file = ../secrets/cf-certs/frsqr.xyz-cert.age;
  age.secrets.cf-certs-frsqr-xyz-key.file = ../secrets/cf-certs/frsqr.xyz-key.age;
  age.secrets.cf-certs-frsqr-xyz-cert.group = "nginx";
  age.secrets.cf-certs-frsqr-xyz-key.group = "nginx";
  age.secrets.cf-certs-frsqr-xyz-cert.owner = "nginx";
  age.secrets.cf-certs-frsqr-xyz-key.owner = "nginx";
  age.secrets.cf-certs-cofob-ru-cert.file = ../secrets/cf-certs/cofob.ru-cert.age;
  age.secrets.cf-certs-cofob-ru-key.file = ../secrets/cf-certs/cofob.ru-key.age;
  age.secrets.cf-certs-cofob-ru-cert.group = "nginx";
  age.secrets.cf-certs-cofob-ru-key.group = "nginx";
  age.secrets.cf-certs-cofob-ru-cert.owner = "nginx";
  age.secrets.cf-certs-cofob-ru-key.owner = "nginx";

  age.secrets.credentials-ipfs-proxy.file = ../secrets/credentials/ipfs-proxy.age;
  services.ipfs-proxy = {
    enable = true;
    envFile = config.age.secrets.credentials-ipfs-proxy.path;
  };

  services.cofob-ru.enable = true;

  services.fs-nginx = {
    enable = lib.mkDefault true;
    virtualHosts."ipfs.frsqr.xyz" = {
      locations."/".proxyPass = "http://127.0.0.1:2314/";
      onlyCloudflare = true;
      sslCertificate = config.age.secrets.cf-certs-frsqr-xyz-cert.path;
      sslCertificateKey = config.age.secrets.cf-certs-frsqr-xyz-key.path;
    };
    virtualHosts."cofob.ru" = {
      locations."/".proxyPass = "http://127.0.0.1:3000/";
      onlyCloudflare = true;
      sslCertificate = config.age.secrets.cf-certs-cofob-ru-cert.path;
      sslCertificateKey = config.age.secrets.cf-certs-cofob-ru-key.path;
    };
  };
}
