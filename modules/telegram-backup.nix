{ lib, config, pkgs, ... }:

with lib;

let
  cfg = config.services.telegram-backup;
in
{
  options = {
    services.telegram-backup = {
      enable = mkEnableOption "Whether to enable telegram backups";

      gpgKey = mkOption {
        type = types.str;
        default = "5F3D9D3DECE08651DE14D29FACAD4265E193794D";
        description = "Encryption key";
      };

      envFile = mkOption {
        type = types.path;
        default = config.age.secrets.credentials-telegram-backup.path;
        description = "Service environment file secrets path";
      };

      timers = mkOption {
        type = types.attrsOf (types.listOf types.str);
        default = { };
      };
    };
  };

  config =
    let
      obj = mapAttrs
        (timer: paths: {
          name = "telegram-backup-${timer}";
          value = {
            path = with pkgs; [ gnupg curl zip ];
            serviceConfig = {
              User = "root";
              Group = "root";
              EnvironmentFile = cfg.envFile;
            };
            script = ''
              set -e
              set -x

              name='/tmp/${timer}-telegram-backup.zip'

              rm $name || true
              zip -9r "$name" ${toString paths}
              gpg --no-tty --keyserver keys.openpgp.org --recv-keys "${cfg.gpgKey}"
              gpg --batch --trust-model always -o "$name.gpg" --encrypt -r "${cfg.gpgKey}" "$name"
              curl -F document=@"$name.gpg" "https://api.telegram.org/bot$TOKEN/sendDocument?chat_id=$CHAT_ID"

              rm "$name" "$name.gpg" || true
            '';
            startAt = timer;
          };
        })
        cfg.timers;
    in
    mkIf cfg.enable ({
      age.secrets.credentials-telegram-backup.file = ../secrets/credentials/telegram-backup.age;
    } // {
      systemd.services = (builtins.listToAttrs (map (key: getAttr key obj) (attrNames obj)));
    });
}
