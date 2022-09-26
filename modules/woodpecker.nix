{ lib, pkgs, config, ... }:

with lib;

let
  cfg = config.services.woodpecker;
in
{
  options.services.woodpecker = {
    enable = mkEnableOption "woodpecker";

    environmentFile = mkOption {
      type = types.path;
    };

    settings = mkOption {
      type = types.attrs;
    };

    stateDirectoryName = mkOption {
      default = "woodpecker";
      type = types.str;
    };
  };

  config = mkIf cfg.enable {
    systemd.services.woodpecker = {
      wantedBy = [ "multi-user.target" ];

      path = with pkgs; [ (callPackage ../pkgs/woodpecker.nix { }) ];

      environment = cfg.settings;
      script = "server";
      wants = [ "postgresql.service" ];
      requires = [ "postgresql.service" ];

      serviceConfig = {
        EnvironmentFile = cfg.environmentFile;
        StateDirectory = cfg.stateDirectoryName;
        WorkingDirectory = "/var/lib/${cfg.stateDirectoryName}";
        User = "woodpecker";
        Group = "woodpecker";
        PrivateTmp = true;
        Restart = "on-failure";
        RestartSec = "5s";
      };
    };

    users = {
      users."woodpecker" = {
        isSystemUser = true;
        description = "woodpecker user";
        home = "/var/lib/${cfg.stateDirectoryName}";
        createHome = true;
        group = "woodpecker";
      };

      groups."woodpecker" = { };
    };
  };
}
