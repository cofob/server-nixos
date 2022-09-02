{ lib, config, pkgs, ... }:

with lib;

let
  cfg = config.services.backup;
in
{
  options = {
    services.backup = {
      enable = mkEnableOption "Whether to enable proxmox-backup-client backups";

      environment = mkOption {
        type = types.attrsOf types.str;
        default = { };
        description = "Service environment variables";
      };

      envFile = mkOption {
        type = types.path;
        description = "Service environment file secrets path";
      };

      keyFile = mkOption {
        type = types.path;
        description = "Key file path";
      };

      timers = mkOption {
        type = types.attrsOf (types.listOf types.str);
      };
    };
  };

  config.systemd.services =
    let
      obj = mapAttrs
        (timer: paths: {
          name = "backup-${timer}";
          value = {
            path = [ (pkgs.callPackage ../pkgs/proxmox-backup-client { }) ];
            environment = cfg.environment;
            serviceConfig.EnvironmentFile = cfg.envFile;
            script = "proxmox-backup-client backup --keyfile ${cfg.keyFile} ${toString paths}";
            startAt = timer;
          };
        })
        cfg.timers; in
    mkIf cfg.enable (builtins.listToAttrs (map (key: getAttr key obj) (attrNames obj)));
}
