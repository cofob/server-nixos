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

  services.ipfs = {
    enable = true;
    enableGC = true;
    extraConfig.Gateway = {
      PublicGateways = {
        "ipfsqr.ru" = {
          Paths = ["/ipfs" "/ipns"];
          UseSubdomains = true;
        };
        "ipfs.ipfsqr.ru" = {
          Paths = ["/ipfs" "/ipns"];
          UseSubdomains = false;
        };
      };
    };
  };

  services.fs-nginx = {
    enable = true;
    virtualHosts = {
      "*" = {
        useACMEHost = "ipfsqr.ru";
        locations."/".proxyPass = "http://localhost:8080/";
      };
    };
  };

  security.acme = {
    certs = {
      "ipfsqr.ru" = { extraDomainNames = [
        "*.ipfsqr.ru"
        "*.ipfs.ipfsqr.ru"
        "*.ipns.ipfsqr.ru"
        "frsqr.xyz"
        "*.frsqr.xyz"
        "firesquare.ru"
        "*.firesquare.ru"
        "cofob.ru"
        "*.cofob.ru"
      ]; };
    };
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
