{ config, lib, pkgs, cofob-ru, ... }:

with lib; let
  cfg = config.services.cofob-ru;
in
{
  options.services.cofob-ru = {
    enable = mkEnableOption "Enable cofob.ru website";

    port = mkOption {
      type = types.port;
      default = 3000;
      description = "Server port";
    };

    package = mkOption {
      type = types.package;
      default = cofob-ru.packages.x86_64-linux.default;
      description = "Package to use";
    };
  };

  config.systemd.services = mkIf cfg.enable {
    cofob-ru = {
      enable = true;
      description = "cofob.ru website";
      script = "cofob-ru";
      path = [ cfg.package ];
      unitConfig = {
        Type = "simple";
      };
      serviceConfig = {
        User = "cofob-ru";
        Group = "cofob-ru";
        Restart = "on-failure";
        RestartSec = "1s";
      };
      wantedBy = [ "multi-user.target" ];
    };
  };

  config.users = mkIf cfg.enable {
    users.cofob-ru = {
      isSystemUser = true;
      description = "cofob.ru website user";
      home = "/var/lib/cofob-ru";
      createHome = true;
      group = "cofob-ru";
    };

    groups.cofob-ru = { };
  };
}
