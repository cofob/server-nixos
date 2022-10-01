{ config, ... }:

{
  age.secrets.api-server.file = ../../secrets/credentials/api-server.age;
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
}
