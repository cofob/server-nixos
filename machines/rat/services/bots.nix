{ config, erk-archive, ... }:

{
  age.secrets.credentials-bps.file = ../../../secrets/credentials/bps.age;
  services.bps = {
    enable = true;
    tokenEnvFile = config.age.secrets.credentials-bps.path;
  };

  age.secrets.credentials-tmm.file = ../../../secrets/credentials/tmm.age;
  services.tmm = {
    enable = true;
    tokenEnvFile = config.age.secrets.credentials-tmm.path;
  };

  age.secrets.credentials-tgcaptcha.file = ../../../secrets/credentials/tgcaptcha.age;
  services.tg-captcha = {
    enable = true;
    envFile = config.age.secrets.credentials-tgcaptcha.path;
  };

  age.secrets.credentials-archive-bot.file = ../../../secrets/credentials/archive-bot.age;
  services.archive-bot = {
    enable = true;
    domain = "https://archivebot.frsqr.xyz";
    environment = config.age.secrets.credentials-archive-bot.path;
  };

  security.acme.certs."archivebot.frsqr.xyz" = { };

  services.fs-nginx.virtualHosts."archivebot.frsqr.xyz" = {
    useACMEHost = "archivebot.frsqr.xyz";
    locations."/".root = "${erk-archive.packages.x86_64-linux.static}";
  };
}
