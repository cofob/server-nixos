{ config, lib, ... }:

{
  config = lib.mkIf (config.security.acme.certs != { }) {
    security.acme = {
      acceptTerms = true;
      defaults = {
        webroot = "/var/lib/acme/acme-challenge";
        email = "i.am@cofob.dev";
      };
    };
  };
}
