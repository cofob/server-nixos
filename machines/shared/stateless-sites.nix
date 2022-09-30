{ ... }:

{
  services.fs-nginx = {
    virtualHosts = {
      "firesquare.ru" = {
        useACMEHost = "firesquare.ru";
        locations."/".proxyPass = "http://127.0.0.1:3004/";
      };
      "cofob.ru" = {
        useACMEHost = "cofob.ru";
        locations."/".proxyPass = "http://127.0.0.1:3000/";
      };
    };
  };

  security.acme = {
    certs = {
      "firesquare.ru" = { };
      "cofob.ru" = { };
    };
  };

  services.firesquare-ru = {
    enable = true;
    port = 3004;
  };

  services.cofob-ru.enable = true;
}
