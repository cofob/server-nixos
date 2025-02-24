{ config
, pkgs
, ...
}:

{
  age.secrets.credentials-tgcaptcha.file = ../../../secrets/credentials/tgcaptcha.age;
  services.tg-captcha = {
    enable = true;
    package = pkgs.tg-captcha;
    envFile = config.age.secrets.credentials-tgcaptcha.path;
  };
}
