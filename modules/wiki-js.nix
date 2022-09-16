{ lib, pkgs, config, ... }:

with lib;

let
  cfg = config.services.wiki-js-fs;

  format = pkgs.formats.json { };

  configFile = format.generate "wiki-js.yml" cfg.settings;
in
{
  options.services.wiki-js-fs = {
    enable = mkEnableOption "wiki-js";

    environmentFile = mkOption {
      type = types.nullOr types.path;
      default = null;
      example = "/root/wiki-js.env";
    };

    stateDirectoryName = mkOption {
      default = "wiki-js";
      type = types.str;
    };

    settings = mkOption {
      default = { };
      type = types.submodule {
        freeformType = format.type;
        options = {
          port = mkOption {
            type = types.port;
            default = 3000;
            description = ''
              TCP port the process should listen to.
            '';
          };

          bindIP = mkOption {
            default = "0.0.0.0";
            type = types.str;
            description = ''
              IPs the service should listen to.
            '';
          };

          db = {
            type = mkOption {
              default = "postgres";
              type = types.enum [ "postgres" "mysql" "mariadb" "mssql" ];
            };
            host = mkOption {
              type = types.str;
              default = "127.0.0.1";
            };
            port = mkOption {
              type = types.port;
              default = 5432;
            };
            db = mkOption {
              default = "wiki";
              type = types.str;
              description = ''
                Name of the database to use.
              '';
            };
            user = mkOption {
              default = "wiki";
              type = types.str;
            };
            pass = mkOption {
              default = "#password#";
              type = types.str;
              description = "DONT CHANGE THIS!";
            };
          };

          logLevel = mkOption {
            default = "info";
            type = types.enum [ "error" "warn" "info" "verbose" "debug" "silly" ];
            description = ''
              Define how much detail is supposed to be logged at runtime.
            '';
          };

          offline = mkEnableOption "offline mode";
        };
      };
    };
  };

  config = mkIf cfg.enable {
    services.wiki-js-fs.settings.dataPath = "/var/lib/${cfg.stateDirectoryName}";
    systemd.services.wiki-js = {
      description = "A modern and powerful wiki app built on Node.js";
      documentation = [ "https://docs.requarks.io/" ];
      wantedBy = [ "multi-user.target" ];

      path = with pkgs; [ coreutils git openssh ];
      preStart = ''
        rm /var/lib/${cfg.stateDirectoryName}/config.yml
        cp ${configFile} /var/lib/${cfg.stateDirectoryName}/config.yml
        chmod 640 /var/lib/${cfg.stateDirectoryName}/config.yml
        # replace password in config file
        sed -i "s/#password#/$DB_PASS/g" /var/lib/${cfg.stateDirectoryName}/config.yml
        ln -sf ${pkgs.wiki-js}/server /var/lib/${cfg.stateDirectoryName}
        ln -sf ${pkgs.wiki-js}/assets /var/lib/${cfg.stateDirectoryName}
        ln -sf ${pkgs.wiki-js}/package.json /var/lib/${cfg.stateDirectoryName}/package.json
      '';

      serviceConfig = {
        EnvironmentFile = mkIf (cfg.environmentFile != null) cfg.environmentFile;
        StateDirectory = cfg.stateDirectoryName;
        WorkingDirectory = "/var/lib/${cfg.stateDirectoryName}";
        User = "wiki-js";
        Group = "wiki-js";
        PrivateTmp = true;
        ExecStart = "${pkgs.nodejs}/bin/node ${pkgs.wiki-js}/server";
      };
    };

    users = {
      users."wiki-js" = {
        isSystemUser = true;
        description = "wiki-js user";
        home = "/var/lib/${cfg.stateDirectoryName}";
        createHome = true;
        group = "wiki-js";
      };

      groups."wiki-js" = { };
    };
  };

  meta.maintainers = with maintainers; [ ma27 ];
}
