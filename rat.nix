{ pkgs, lib, config, ... }:

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

  age.secrets.credentials-tmm.file = ./secrets/credentials/tmm.age;
  services.tmm = {
    enable = true;
    tokenEnvFile = config.age.secrets.credentials-tmm.path;
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
          Paths = [ "/ipfs" "/ipns" ];
          UseSubdomains = true;
        };
        "static.ipfsqr.ru" = {
          Paths = [ "/ipfs" "/ipns" ];
          UseSubdomains = false;
        };
      };
    };
  };

  age.secrets.credentials-gitea.file = ./secrets/credentials/gitea.age;
  age.secrets.credentials-gitea.owner = "gitea";
  services.gitea = {
    enable = true;
    package = pkgs.unstable.gitea;
    lfs.enable = true;
    dump.enable = true;
    domain = "git.frsqr.xyz";
    rootUrl = "https://git.frsqr.xyz/";
    appName = "firesquare git";
    disableRegistration = true;
    cookieSecure = true;
    database = {
      type = "mysql";
      passwordFile = config.age.secrets.credentials-gitea.path;
    };
  };

  services.mysql = {
    enable = true;
    ensureUsers = [
      {
        name = "gitea";
        ensurePermissions = {
          "gitea.*" = "ALL PRIVILEGES";
        };
      }
    ];
    ensureDatabases = [
      "gitea"
    ];
  };

  services.postgresql = {
    enable = true;
    ensureUsers = [
      {
        name = "vaultwarden";
        ensurePermissions = {
          "DATABASE vaultwarden" = "ALL PRIVILEGES";
        };
      }
    ];
    ensureDatabases = [
      "vaultwarden"
    ];
  };

  services.vaultwarden = {
    enable = true;
    dbBackend = "postgresql";
    config = {
      domain = "https://bw.frsqr.xyz";
      signupsAllowed = true;
      rocketPort = 8222;
    };
    environmentFile = pkgs.writeText "vaultwarden-env" ''
      DATABASE_URL='postgres:///vaultwarden?host=/var/run/postgresql'
    '';
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
      "mineflake.ipfsqr.xyz" = {
        useACMEHost = "ipfsqr.ru";
        root = pkgs.fetchzip {
          url = "https://ipfs.io/ipfs/bafybeie26qliticraktjfvtbqq6bmtjl5wedfeba7jc4j6g3xotv7wnlg4/mineflake.tar.gz";
          hash = "sha256-h2Ax9Ixse4WsBCk3WgizwSJraMfIri9IGvO3VuMmxbc=";
        };
      };
    };
  };

  security.acme = {
    certs = {
      "ipfsqr.ru" = {
        extraDomainNames = [
          "*.ipfsqr.ru"
          "*.ipfs.ipfsqr.ru"
          "*.ipns.ipfsqr.ru"
          "frsqr.xyz"
          "*.frsqr.xyz"
          "firesquare.ru"
          "*.firesquare.ru"
          "cofob.ru"
          "*.cofob.ru"
        ];
      };
      "git.frsqr.xyz" = { };
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
