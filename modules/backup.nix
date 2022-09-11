{ lib, config, pkgs, ... }:

with lib;

let
  cfg = config.services.proxmox-backup-client;

  timerConf = {
    time = {
      type = types.str;
      description = "Systemd time";
      default = "daily";
    };
    directories = {
      type = types.listOf types.str;
      description = "Directories to backup";
      default = [ ];
    };
  };
in
{
  options = {
    services.proxmox-backup-client = {
      environment = mkOption {
        type = types.attrsOf types.str;
        default = {
          PBS_FINGERPRINT = "";
        };
        description = "Service environment variables";
      };

      timers = mkOption {
        type = types.attrsOf timerConf;
        description = "Timer config";
        default = { };
      };
    };
  };

  config = {
    age.secrets.credentials-pbs.file = ../secrets/credentials/pbs.age;
    age.secrets.credentials-pbs-key.file = ../secrets/credentials/pbs-key.age;
  } // (mkIf (cfg.timers != { }) {
    systemd.services =
      let
        obj = mapAttrs
          (timer-name: timer-cfg: {
            name = "proxmox-backup-client-${timer-name}";
            value = {
              path = [ pkgs.callPackage ../pkgs/proxmox-backup-client ];
              environment = cfg.environment;
              serviceConfig.EnvironmentFile = config.age.secrets.credentials-pbs.path;
              script = "proxmox-backup-client backup --keyfile ${config.age.secrets.credentials-pbs-key.path} ${toString timer-cfg.directories}";
              startAt = timer-cfg.time;
            };
          })
          cfg.timers;
      in
      (builtins.listToAttrs (map (key: getAttr key obj) (attrNames obj)));
  });
}
