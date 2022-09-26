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
        default = {
          PBS_FINGERPRINT = "88:c0:0e:76:3a:4a:23:95:38:e0:d2:65:d5:37:73:86:dc:94:fa:c3:46:84:c8:e8:0b:85:8d:03:63:f0:fe:87";
        };
        description = "Service environment variables";
      };

      envFile = mkOption {
        type = types.path;
        default = config.age.secrets.credentials-pbs.path;
        description = "Service environment file secrets path";
      };

      keyFile = mkOption {
        type = types.path;
        default = config.age.secrets.credentials-pbs-key.path;
        description = "Key file path";
      };

      timers = mkOption {
        type = types.attrsOf (types.listOf types.str);
      };
    };
  };

  config =
    let
      obj = mapAttrs
        (timer: paths: {
          name = "backup-${timer}";
          value = {
            path = with pkgs; [ proxmox-backup ];
            environment = cfg.environment;
            serviceConfig = {
              User = "root";
              Group = "root";
              EnvironmentFile = cfg.envFile;
            };
            script = "proxmox-backup-client backup --keyfile ${cfg.keyFile} ${toString paths}";
            startAt = timer;
          };
        })
        cfg.timers; in
    mkIf cfg.enable ({
      age.secrets.credentials-pbs.file = ../secrets/credentials/pbs.age;
      age.secrets.credentials-pbs-key.file = ../secrets/credentials/pbs-key.age;
    } // {
      systemd.services = (builtins.listToAttrs (map (key: getAttr key obj) (attrNames obj)));
    });
}
