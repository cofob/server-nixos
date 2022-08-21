{ pkgs, config, ... }:

{
  imports = [
    ./modules/modules.nix
    ./hardware/aeza.nix
    ./mounts/aeza.nix
  ];

  services.fs-nginx = {
    enable = true;
  };

  age.secrets.credentials-bps.file = secrets/credentials/bps.age;
  services.bps = {
    enable = true;
    tokenEnvFile = config.age.secrets.credentials-bps.path;
    for-all-stickers = true;
  };

  networking = {
    hostName = "eagle";

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
            address = "185.112.83.178";
            prefixLength = 32;
          }];
        };
      };
    };
  };
}
