{ config, ... }:

{
  age.secrets.wiki-env.file = ../../../secrets/wiki-env.age;
  age.secrets.wiki-env.owner = "wiki-js";
  services.wiki-js-fs = {
    enable = true;
    settings = {
      port = 3002;
    };
    environmentFile = config.age.secrets.wiki-env.path;
  };

  security.acme.certs."wiki.firesquare.ru" = { };

  services.fs-nginx.virtualHosts."wiki.firesquare.ru" = {
    useACMEHost = "wiki.firesquare.ru";
    locations."/".proxyPass = "http://127.0.0.1:3002/";
  };

  services.backup.timers.daily = [
    "wiki-js.pxar:/var/lib/wiki-js"
  ];
}
