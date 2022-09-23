{ pkgs, lib, config, ... }:

{
  imports = [
    ./modules
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

  services.cofob-ru.enable = true;

  services.ipfs = {
    enable = true;
    enableGC = true;
    extraConfig = {
      Gateway.PublicGateways = {
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

  services.ipfs-cluster = {
    enable = true;
    service = (lib.importJSON ./modules/ipfs-cluster/service.json) // {
      api.restapi = {
        http_listen_multiaddress = "/ip4/0.0.0.0/tcp/9094";
        ssl_cert_file = "${config.security.acme.certs."rat.frsqr.xyz".directory}/fullchain.pem";
        ssl_key_file = "${config.security.acme.certs."rat.frsqr.xyz".directory}/key.pem";
        basic_auth_credentials.default = "#BASIC_PASSWORD#";
      };
    };
  };

  age.secrets.credentials-gitea.file = ./secrets/credentials/gitea.age;
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
      {
        name = "woodpecker";
        ensurePermissions = {
          "DATABASE woodpecker" = "ALL PRIVILEGES";
        };
      }
      {
        name = "wiki";
        ensurePermissions = {
          "DATABASE wiki" = "ALL PRIVILEGES";
        };
      }
    ];
    ensureDatabases = [
      "vaultwarden"
      "woodpecker"
      "wiki"
    ];
  };

  services.vaultwarden = {
    enable = true;
    dbBackend = "sqlite";
    config = {
      domain = "https://bw.frsqr.xyz";
      signupsAllowed = true;
      rocketPort = 8222;
      rocketAddress = "127.0.0.1";
    };
  };

  age.secrets.woodpecker-server.file = ./secrets/credentials/woodpecker-server.age;
  age.secrets.woodpecker-agent.file = ./secrets/credentials/woodpecker-agent.age;
  virtualisation.oci-containers.containers.woodpecker-server = {
    image = "docker.io/woodpeckerci/woodpecker-server:v0.15.3";
    extraOptions = [ "--network=host" ];
    environment = {
      WOODPECKER_OPEN = "true";
      WOODPECKER_HOST = "https://wp.frsqr.xyz";
      WOODPECKER_GITEA = "true";
      WOODPECKER_GITEA_URL = "https://git.frsqr.xyz";
      WOODPECKER_DATABASE_DRIVER = "postgres";
    };
    environmentFiles = [
      config.age.secrets.woodpecker-server.path
      config.age.secrets.woodpecker-agent.path
    ];
  };

  age.secrets.wiki-env.file = ./secrets/wiki-env.age;
  age.secrets.wiki-env.owner = "wiki-js";
  services.wiki-js-fs = {
    enable = true;
    settings = {
      port = 3002;
    };
    environmentFile = config.age.secrets.wiki-env.path;
  };

  services.fs-nginx = {
    enable = true;
    virtualHosts = {
      "_" = {
        useACMEHost = "ipfsqr.ru";
        locations."/".proxyPass = "http://127.0.0.1:8080/";
      };
      "git.frsqr.xyz" = {
        useACMEHost = "frsqr.xyz";
        locations."/".proxyPass = "http://127.0.0.1:3001/";
      };
      "wp.frsqr.xyz" = {
        useACMEHost = "frsqr.xyz";
        locations."/".proxyPass = "http://127.0.0.1:8000/";
      };
      "bw.frsqr.xyz" = {
        useACMEHost = "frsqr.xyz";
        locations."/".proxyPass = "http://127.0.0.1:8222/";
      };
      "cofob.ru" = {
        useACMEHost = "ipfsqr.ru";
        locations."/".proxyPass = "http://127.0.0.1:3000/";
      };
      "tgchess-api.cofob.ru" = {
        useACMEHost = "ipfsqr.ru";
        locations."/".proxyPass = "http://127.0.0.1:8432/";
      };
      "wiki.firesquare.ru" = {
        useACMEHost = "ipfsqr.ru";
        locations."/".proxyPass = "http://127.0.0.1:3002/";
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

  virtualisation.docker.enable = true;

  security.acme = {
    certs = {
      "ipfsqr.ru".extraDomainNames = [
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
      "frsqr.xyz".extraDomainNames = [ "*.frsqr.xyz" ];
      "rat.frsqr.xyz" = {
        group = "ipfs-cluster";
      };
    };
  };

  networking = {
    hostName = "rat";

    nft-firewall.enable = false;

    firewall = {
      trustedInterfaces = [ "lo" ];
      allowedTCPPorts = [ 22 80 443 4001 9094 9096 ];
      allowedUDPPorts = [ 443 4001 ];
    };

    nebula-frsqr = {
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
