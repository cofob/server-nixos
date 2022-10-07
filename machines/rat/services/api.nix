{ config, ... }:

{
  age.secrets.api-server.file = ../../../secrets/credentials/api-server.age;
  virtualisation.oci-containers.containers.api-server = {
    image = "git.frsqr.xyz/firesquare/api:latest";
    extraOptions = [ "--network=host" ];
    environment = {
      PORT = "3003";
    };
    environmentFiles = [
      config.age.secrets.api-server.path
    ];
  };

  security.acme.certs."api.firesquare.ru" = { };

  services.fs-nginx.virtualHosts."api.firesquare.ru" = {
    useACMEHost = "api.firesquare.ru";
    locations."/".proxyPass = "http://127.0.0.1:3003/";
  };
}
