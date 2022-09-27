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

  services.fs-monitoring.enable = true;

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
        name = "grafana";
        ensurePermissions = {
          "DATABASE grafana" = "ALL PRIVILEGES";
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
      "grafana"
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
  services.woodpecker = {
    enable = true;
    settings = {
      WOODPECKER_OPEN = "true";
      WOODPECKER_HOST = "https://wp.frsqr.xyz";
      WOODPECKER_GITEA = "true";
      WOODPECKER_GITEA_URL = "https://git.frsqr.xyz";
      WOODPECKER_DATABASE_DRIVER = "postgres";
    };
    environmentFile = config.age.secrets.woodpecker-server.path;
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

  age.secrets.cockroach-rat-crt.file = ./secrets/cockroach/rat-crt.age;
  age.secrets.cockroach-rat-key.file = ./secrets/cockroach/rat-key.age;
  age.secrets.cockroach-root-crt.file = ./secrets/cockroach/root-crt.age;
  age.secrets.cockroach-root-key.file = ./secrets/cockroach/root-key.age;
  age.secrets.cockroach-rat-crt.owner = config.services.cockroachdb.user;
  age.secrets.cockroach-rat-key.owner = config.services.cockroachdb.user;
  age.secrets.cockroach-root-crt.owner = config.services.cockroachdb.user;
  age.secrets.cockroach-root-key.owner = config.services.cockroachdb.user;
  services.cockroachdb = {
    enable = true;
    crtFile = config.age.secrets.cockroach-rat-crt.path;
    keyFile = config.age.secrets.cockroach-rat-key.path;
    rootCrtFile = config.age.secrets.cockroach-root-crt.path;
    rootKeyFile = config.age.secrets.cockroach-root-key.path;
    locality = "country=nl,datacenter=aeza-nl";
    openPorts = true;
    http = {
      port = 8081;
      address = "10.3.7.11";
    };
    listen.address = "10.3.7.11";
    join = "shark.n.frsqr.xyz";
  };

  age.secrets.api-server.file = ./secrets/credentials/api-server.age;
  virtualisation.oci-containers.containers.api-server = {
    image = "git.frsqr.xyz/firesquare/pyapi:latest";
    extraOptions = [ "--network=host" ];
    environment = {
      PORT = "3003";
    };
    environmentFiles = [
      config.age.secrets.api-server.path
    ];
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
      "grafana.frsqr.xyz" = {
        useACMEHost = "frsqr.xyz";
        locations."/".proxyPass = "http://127.0.0.1:3729/";
      };
      "cofob.ru" = {
        useACMEHost = "ipfsqr.ru";
        locations."/".proxyPass = "http://127.0.0.1:3000/";
      };
      "wiki.firesquare.ru" = {
        useACMEHost = "ipfsqr.ru";
        locations."/".proxyPass = "http://127.0.0.1:3002/";
      };
      "api.firesquare.ru" = {
        useACMEHost = "ipfsqr.ru";
        locations."/".proxyPass = "http://127.0.0.1:3003/";
      };
    };
  };

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

  services.backup = {
    enable = true;
    timers.weekly = [
      "postgresql.pxar:/var/lib/postgresql/14"
      "mysql.pxar:/var/lib/mysql"
      "gitea.pxar:/var/lib/gitea"
      "wiki-js.pxar:/var/lib/wiki-js"
      "bitwarden.pxar:/var/lib/bitwarden_rs"
      "cockroachdb.pxar:/var/lib/cockroachdb"
    ];
  };

  networking = {
    hostName = "rat";

    nft-firewall.enable = false;

    firewall = {
      trustedInterfaces = [ "lo" ];
      interfaces."nebula.frsqr".allowedTCPPorts = [ 9000 ];
      allowedTCPPorts = [ 4001 9094 9096 ];
      allowedUDPPorts = [ 4001 ];
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
