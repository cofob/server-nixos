{ config, lib, pkgs, balance-tracker, ... }:

with lib; let
  cfg = config.services.balance-tracker;
in
{
  options.services.balance-tracker = {
    enable = mkEnableOption "Enable balance-tracker website";

    frontend-port = mkOption {
      type = types.port;
      default = 3001;
      description = "Frontend server port";
    };

    frontend-host = mkOption {
      type = types.str;
      default = "127.0.0.1";
      description = "Frontend server host";
    };

    frontend-package = mkOption {
      type = types.package;
      default = balance-tracker.packages.x86_64-linux.card-tracker-frontend;
      description = "Frontend package to use";
    };

    backend-port = mkOption {
      type = types.port;
      default = 3002;
      description = "Backend server port";
    };

    backend-host = mkOption {
      type = types.str;
      default = "127.0.0.1";
      description = "Backend server host";
    };

    backend-package = mkOption {
      type = types.package;
      default = balance-tracker.packages.x86_64-linux.card-tracker-backend;
      description = "Backend package to use";
    };
  };

  config.systemd.services = mkIf cfg.enable {
    balance-tracker-frontend = {
      enable = true;
      description = "balance-tracker website";
      script = "frontend";
      path = [ cfg.frontend-package ];
      unitConfig = {
        Type = "simple";
      };
      environment = {
        PORT = toString cfg.frontend-port;
        HOST = cfg.frontend-host;
      };
      serviceConfig = {
        User = "balance-tracker";
        Group = "balance-tracker";
        Restart = "on-failure";
        RestartSec = "1s";
      };
      wantedBy = [ "multi-user.target" ];
    };

    balance-tracker-backend = {
      enable = true;
      description = "balance-tracker API";
      script = "backend";
      path = [ cfg.backend-package ];
      unitConfig = {
        Type = "simple";
      };
      environment = {
        PORT = toString cfg.backend-port;
        HOST = cfg.backend-host;
      };
      serviceConfig = {
        User = "balance-tracker";
        Group = "balance-tracker";
        Restart = "on-failure";
        RestartSec = "1s";
        WorkingDirectory = "/var/lib/balance-tracker";
      };
      wantedBy = [ "multi-user.target" ];
    };
  };

  config.users = mkIf cfg.enable {
    users.balance-tracker = {
      isSystemUser = true;
      description = "balance-tracker website user";
      home = "/var/lib/balance-tracker";
      createHome = true;
      group = "balance-tracker";
    };

    groups.balance-tracker = { };
  };
}
