{ config, pkgs, ... }:

{
  age.secrets.credentials-gitea.file = ../../secrets/credentials/gitea.age;
  age.secrets.credentials-gitea.owner = "gitea";
  services.gitea = {
    enable = true;
    package = pkgs.unstable.gitea;
    lfs.enable = true;
    domain = "git.frsqr.xyz";
    rootUrl = "https://git.frsqr.xyz/";
    appName = "firesquare git";
    httpPort = 3001;
    disableRegistration = true;
    cookieSecure = true;
    stateDir = "/gluster/mounts/global/gitea";
    database = {
      type = "postgres";
      passwordFile = config.age.secrets.credentials-gitea.path;
    };
  };
  systemd.services.gitea.requires = [ "glusterd.service" ];
}
