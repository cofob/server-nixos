{ pkgs, config, ... }:

{
  imports = [
    ./modules
    ./hardware/aeza.nix
    ./mounts/aeza.nix
  ];

  security.acme = {
    certs = {
      "memefinder.ru" = {
        extraDomainNames = [ "*.memefinder.ru" ];
        email = "averyanalex@gmail.com";
        credentialsFile = config.age.secrets.credentials-cloudflare-averyan.path;
      };
    };
  };

  services.fs-nginx = {
    enable = true;
  };

  networking = {
    hostName = "eagle";

    nebula-frsqr = {
      enable = true;
      isLighthouse = true;
    };

    nebula-averyan = {
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
