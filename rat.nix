{ pkgs, config, ... }:

{
  imports = [
    ./modules/modules.nix
    ./hardware/aeza.nix
    ./mounts/aeza.nix
  ];

  age.secrets.credentials-bps.file = ./secrets/credentials/bps.age;
  services.bps = {
    enable = true;
    tokenEnvFile = config.age.secrets.credentials-bps.path;
    for-all-stickers = true;
  };

  age.secrets.credentials-tgcaptcha.file = ./secrets/credentials/tgcaptcha.age;
  services.tg-captcha = {
    enable = true;
    envFile = config.age.secrets.credentials-tgcaptcha.path;
  };

  networking = {
    hostName = "rat";

    nebula-global = {
      enable = true;
      isLighthouse = true;
    };

    defaultGateway = {
      address = "10.0.0.1";
      interface = "ens3";
    };

    interfaces = {
      ens3 = {
        ipv4 = {
          addresses = [{
            address = "89.208.104.77";
            prefixLength = 32;
          }];
        };
      };
    };
  };
}
