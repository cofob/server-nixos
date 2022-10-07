{ config, ... }:

{
  age.secrets.woodpecker-server.file = ../../../secrets/credentials/woodpecker-server.age;
  services.woodpecker = {
    enable = true;
    settings = {
      WOODPECKER_OPEN = "true";
      WOODPECKER_HOST = "https://wp.frsqr.xyz";
      WOODPECKER_GITEA = "true";
      WOODPECKER_GITEA_URL = "https://git.frsqr.xyz";
      WOODPECKER_DATABASE_DRIVER = "postgres";
    };
    environmentFile = config.age.secrets.woodpecker-server.path;
  };

  security.acme.certs."wp.frsqr.xyz" = { };

  services.fs-nginx.virtualHosts."wp.frsqr.xyz" = {
    useACMEHost = "wp.frsqr.xyz";
    locations."/".proxyPass = "http://127.0.0.1:8000/";
  };

  networking.firewall.interfaces."nebula.frsqr".allowedTCPPorts = [ 9000 ];
}
