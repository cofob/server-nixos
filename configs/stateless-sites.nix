{ lib, config, ... }:

{
  age.secrets.cf-certs-frsqr-xyz-cert.file = ../secrets/cf-certs/frsqr.xyz-cert.age;
  age.secrets.cf-certs-frsqr-xyz-key.file = ../secrets/cf-certs/frsqr.xyz-key.age;

  age.secrets.credentials-ipfs-proxy.file = ../secrets/credentials/ipfs-proxy.age;
  services.ipfs-proxy = {
    enable = true;
    envFile = config.age.secrets.credentials-ipfs-proxy.path;
  };

  services.fs-nginx = {
    enable = lib.mkDefault true;
    virtualHosts."ipfs.frsqr.xyz" = {
      locations."/".proxyPass = "http://127.0.0.1:2314/";
      onlyCloudflare = true;
      sslCertificate = config.age.secrets.cf-certs-frsqr-xyz-cert.path;
      sslCertificateKey = config.age.secrets.cf-certs-frsqr-xyz-key.path;
    };
  };
}
