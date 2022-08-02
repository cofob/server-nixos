{ config, lib, ... }:

{
  config = lib.mkIf (config.security.acme.certs != { }) {
    age.secrets.credentials-cloudflare.file = ./secrets/credentials/cloudflare.age;

    security.acme = {
      acceptTerms = true;
      defaults = {
        email = "admin@firesquare.ru";
        dnsResolver = "1.1.1.1:53";
        dnsProvider = "cloudflare";
        credentialsFile = config.age.secrets.credentials-cloudflare.path;
      };
    };
  };
}
