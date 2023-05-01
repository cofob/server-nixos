{ config, ... }:

{
  services.fs-nginx.virtualHosts."alice-gpt.cofob.dev" = {
    onlyCloudflare = true;
    locations."/".proxyPass = "http://127.0.0.1:5000/";
    sslCertificate = config.age.secrets.cf-certs-cofob-dev-cert.path;
    sslCertificateKey = config.age.secrets.cf-certs-cofob-dev-key.path;
  };
}
