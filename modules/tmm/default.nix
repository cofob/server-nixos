{ config, lib, pkgs, ... }:

with lib; let
  cfg = config.services.tmm;
  toBool = var: if var then "true" else "false";
  tmm = pkgs.callPackage ./package.nix { };
in
{
  options.services.tmm = {
    enable = mkEnableOption "Enable tmm";

    tokenEnvFile = mkOption {
      type = types.path;
      example = "TELOXIDE_TOKEN=111111111:AAAAAAAAAAAAAAAAAAAAAAAA";
      description = "Path to telegram bot token from @botfather (TELOXIDE_TOKEN)";
    };

    log-level = mkOption {
      type = types.enum [ "error" "warn" "info" "debug" "trace" ];
      default = "info";
      description = "Application logging level (RUST_LOG)";
    };

    datadir = mkOption {
      type = types.path;
      default = "/var/lib/tmm";
      description = "Data directory";
    };

    package = mkOption {
      type = types.package;
      default = tmm;
      description = "TMM package to use";
    };
  };

  config.systemd.services = mkIf cfg.enable {
    tmm = {
      enable = true;
      description = "TMM telegram bot";
      environment.RUST_LOG = cfg.log-level;
      unitConfig = {
        Type = "simple";
      };
      serviceConfig = {
        User = "tmm";
        Group = "tmm";
        WorkingDirectory = cfg.datadir;
        ExecStart = "${cfg.package}/bin/tmm";
        Restart = "on-failure";
        RestartSec = "1s";
        EnvironmentFile = cfg.tokenEnvFile;
      };
      wantedBy = [ "multi-user.target" ];
    };
  };

  config.users = mkIf cfg.enable {
    users.tmm = {
      isSystemUser = true;
      description = "TMM user";
      home = cfg.datadir;
      createHome = true;
      group = "tmm";
    };

    groups.tmm = { };
  };
}
