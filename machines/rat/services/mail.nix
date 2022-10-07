{ config, ... }:

{
  age.secrets.credentials-maddy.file = ../../../secrets/credentials/maddy.age;
  age.secrets.credentials-maddy.owner = "maddy";
  services.maddy-fs = {
    enable = true;
    hostname = "mx1.frsqr.xyz";
    primaryDomain = "frsqr.xyz";
    openFirewall = true;
    localDomains = [
      "$(primary_domain)"
      "firesquare.ru"
      "cofob.ru"
      "averyan.ru"
    ];
    environmentFile = config.age.secrets.credentials-maddy.path;
    config = "tls file ${config.security.acme.certs."mx1.frsqr.xyz".directory}/fullchain.pem ${config.security.acme.certs."mx1.frsqr.xyz".directory}/key.pem\n" +
      builtins.readFile ../configs/maddy.txt;
  };

  security.acme.certs."mx1.frsqr.xyz" = {
    group = "maddy";
  };

  services.rspamd.enable = true;
}
