{ config, lib, pkgs, fastside, ... }:

with lib; let
  cfg = config.services.fastside;
in
{
  options.services.fastside = {
    enable = mkEnableOption "Enable fastside";

    port = mkOption {
      type = types.port;
      default = 8080;
      description = "Server port";
    };

    host = mkOption {
      type = types.str;
      default = "127.0.0.1";
      description = "Server host";
    };

    package = mkOption {
      type = types.package;
      default = pkgs.fastside;
      description = "Package to use";
    };

    services = mkOption {
      type = types.path;
      default = pkgs.fastside-services;
      description = "Services package to use";
    };

    config = mkOption {
      type = types.attrs;
      default = { };
      description = "Configuration";
    };

    logLevel = mkOption {
      type = types.str;
      default = "info";
      description = "Log level";
    };
  };

  config.systemd.services = mkIf cfg.enable {
    fastside =
      let
        configFile = pkgs.writers.writeJSON "config.json" cfg.config;
      in
      {
        enable = true;
        description = "fastside website";
        script = "fastside --config ${configFile} --log-level ${cfg.logLevel} serve --listen ${cfg.host}:${toString cfg.port} --services ${cfg.services}";
        path = [ cfg.package ];
        unitConfig = {
          Type = "simple";
        };
        serviceConfig = {
          User = "fastside";
          Group = "fastside";
          Restart = "on-failure";
          RestartSec = "1s";
        };
        wantedBy = [ "multi-user.target" ];
      };
  };

  config.users = mkIf cfg.enable {
    users.fastside = {
      isSystemUser = true;
      description = "fastside website user";
      home = "/var/lib/fastside";
      createHome = true;
      group = "fastside";
    };

    groups.fastside = { };
  };
}
