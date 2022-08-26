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
        "static.ipfsqr.ru" = {
          Paths = ["/ipfs" "/ipns"];
          UseSubdomains = false;
        };
      };
    };
  };

  age.secrets.credentials-gitea.file = ./secrets/credentials/gitea.age;
  services.gitea = {
    enable = true;
    lfs.enable = true;
    dump.enable = true;
    cookieSecure = true;
    domain = "git.frsqr.xyz";
    rootUrl = "https://git.frsqr.xyz/";
    appName = "gitea: Smth here";
    database = {
      type = "postgres";
      passwordFile = config.age.secrets.credentials-gitea.path;
    };
  };

  services.postgresql = {
    enable = true;
    ensureUsers = [
      {
        name = "gitea";
        ensurePermissions = {
          "DATABASE gitea" = "ALL PRIVILEGES";
        };
      }
    ];
    ensureDatabases = [
      "gitea"
    ];
  };

  services.fs-nginx = {
    enable = true;
    virtualHosts = {
      "_" = {
        useACMEHost = "ipfsqr.ru";
        locations."/".proxyPass = "http://localhost:8080/";
      };
      "git.frsqr.xyz" = {
        useACMEHost = "git.frsqr.xyz";
        locations."/".proxyPass = "http://localhost:3000/";
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
      "git.frsqr.xyz" = {};
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
