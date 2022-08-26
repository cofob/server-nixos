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
  age.secrets.credentials-gitea.owner = "gitea";
  services.gitea-fs = {
    enable = true;
    package = pkgs.unstable.gitea;
    lfs.enable = true;
    dump.enable = true;
    domain = "git.frsqr.xyz";
    rootUrl = "https://git.frsqr.xyz/";
    appName = "gitea: Smth here";
    extraConfig = ''
      [database]
      DB_TYPE  = mysql
      HOST     = 127.0.0.1
      NAME     = gitea
      PASSWD   = #dbpass#
      PORT     = 3301
      USER     = gitea
      SCHEMA   =
      SSL_MODE = disable
      CHARSET  = utf8mb4
      PATH     = /var/lib/gitea/data/gitea.db
      LOG_SQL  = false

      [log]
      LEVEL     = info
      ROOT_PATH = /var/lib/gitea/log
      MODE      = console
      ROUTER    = console

      [server]
      DISABLE_SSH      = false
      SSH_PORT         = 22
      SSH_DOMAIN       = localhost
      DOMAIN           = localhost
      HTTP_PORT        = 3000
      ROOT_URL         = https://git.frsqr.xyz/
      LFS_START_SERVER = true
      LFS_JWT_SECRET   = #lfsjwtsecret#
      OFFLINE_MODE     = false

      [service]
      DISABLE_REGISTRATION              = false
      REGISTER_EMAIL_CONFIRM            = false
      ENABLE_NOTIFY_MAIL                = false
      ALLOW_ONLY_EXTERNAL_REGISTRATION  = false
      ENABLE_CAPTCHA                    = false
      REQUIRE_SIGNIN_VIEW               = false
      DEFAULT_KEEP_EMAIL_PRIVATE        = false
      DEFAULT_ALLOW_CREATE_ORGANIZATION = true
      DEFAULT_ENABLE_TIMETRACKING       = true
      NO_REPLY_ADDRESS                  = noreply.localhost

      [session]
      COOKIE_SECURE = true
      PROVIDER      = file

      [repository]
      ROOT = /var/lib/gitea/data/gitea-repositories

      [lfs]
      PATH = /var/lib/gitea/data/lfs

      [mailer]
      ENABLED = false

      [picture]
      DISABLE_GRAVATAR        = false
      ENABLE_FEDERATED_AVATAR = true

      [openid]
      ENABLE_OPENID_SIGNIN = true
      ENABLE_OPENID_SIGNUP = true

      [repository.pull-request]
      DEFAULT_MERGE_STYLE = merge

      [repository.signing]
      DEFAULT_TRUST_MODEL = committer

      [security]
      INSTALL_LOCK       = true
      INTERNAL_TOKEN     = #internaltoken#
      SECRET_KEY         = #secretkey#
      PASSWORD_HASH_ALGO = pbkdf2
    '';
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
