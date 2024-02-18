{ config, lib, pkgs, cofob-dev, ... }:

with lib; let
  cfg = config.services.cofob-dev;
in
{
  options.services.cofob-dev = {
    enable = mkEnableOption "Enable cofob.dev website";

    port = mkOption {
      type = types.port;
      default = 3000;
      description = "Server port";
    };

    package = mkOption {
      type = types.package;
      default = cofob-dev.packages.x86_64-linux.default;
      description = "Package to use";
    };
  };

  config.systemd.services = mkIf cfg.enable {
    cofob-dev = {
      enable = true;
      description = "cofob.dev website";
      script = "cofob-dev";
      path = [ cfg.package ];
      unitConfig = {
        Type = "simple";
      };
      serviceConfig = {
        User = "cofob-dev";
        Group = "cofob-dev";
        Restart = "on-failure";
        RestartSec = "1s";
      };
      wantedBy = [ "multi-user.target" ];
    };
  };

  config.users = mkIf cfg.enable {
    users.cofob-dev = {
      isSystemUser = true;
      description = "cofob.dev website user";
      home = "/var/lib/cofob-dev";
      createHome = true;
      group = "cofob-dev";
    };

    groups.cofob-dev = { };
  };
}
