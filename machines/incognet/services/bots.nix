{ config, pkgs, ... }:

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
    package = pkgs.tg-captcha;
    envFile = config.age.secrets.credentials-tgcaptcha.path;
  };

  age.secrets.credentials-marzbanbot.file = ../../../secrets/credentials/marzbanbot.age;
  services.marzbanbot = {
    enable = true;
    package = pkgs.marzbanbot;
    envFile = config.age.secrets.credentials-marzbanbot.path;
  };

  age.secrets.credentials-aeza-assistant.file = ../../../secrets/credentials/aeza-assistant.age;
  services.aeza-assistant = {
    enable = true;
    package = pkgs.aeza-assistant;
    envFile = config.age.secrets.credentials-aeza-assistant.path;
  };

  services.backup.timers.daily = [
    "tmm.pxar:/var/lib/tmm"
  ];
  services.telegram-backup.timers.daily = [
    "/var/lib/tmm"
  ];
}
