{ config, pkgs, ... }:

{
  age.secrets.credentials-gitea.file = ../../../secrets/credentials/gitea.age;
  age.secrets.credentials-gitea.owner = "gitea";
  services.gitea = {
    enable = true;
    package = pkgs.unstable.gitea;
    lfs.enable = true;
    domain = "git.frsqr.xyz";
    rootUrl = "https://git.frsqr.xyz/";
    appName = "firesquare git";
    httpPort = 3001;
    disableRegistration = false;
    cookieSecure = true;
    settings = {
      oauth2_client = {
        ENABLE_AUTO_REGISTRATION = true;
      };
    };
    database = {
      type = "postgres";
      passwordFile = config.age.secrets.credentials-gitea.path;
    };
  };

  security.acme.certs."git.frsqr.xyz" = { };

  services.fs-nginx.virtualHosts."git.frsqr.xyz" = {
    useACMEHost = "git.frsqr.xyz";
    locations."/".proxyPass = "http://127.0.0.1:3001/";
  };

  services.backup.timers.daily = [
    "gitea.pxar:${config.services.gitea.stateDir}"
  ];
}
