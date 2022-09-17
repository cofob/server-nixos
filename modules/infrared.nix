{ lib, pkgs, config, ... }:

with lib; let
  cfg = config.services.infrared;
in
{
  options.services.infrared = {
    enable = mkEnableOption "If enabled, infrared will be configured";

    hosts = mkOption {
      type = types.attrs;
      default = { };
    };

    datadir = mkOption {
      type = types.path;
      default = "/var/lib/infrared";
    };

    package = mkOption {
      type = types.package;
      default = (pkgs.callPackage ../pkgs/infrared.nix { });
    };
  };

  config = mkIf cfg.enable ({
    systemd.services.infrared = {
      path = [ cfg.package ];
      wantedBy = [ "multi-user.target" ];
      preStart =
        let
          obj = mapAttrs
            (name: data: "ln -sf ${(builtins.toFile "infrared-${name}.json" (builtins.toJSON data))} ${cfg.datadir}/configs/${name}.json")
            cfg.hosts;
        in
        ''
          rm -rf ${cfg.datadir}/configs
          mkdir -p ${cfg.datadir}/configs
          ${concatStringsSep "\n" (map (key: getAttr key obj) (attrNames obj))}
        '';
      script = "infrared";
      serviceConfig = {
        Type = "simple";
        User = "infrared";
        Group = "infrared";
        WorkingDirectory = cfg.datadir;
        ReadWritePaths = [ cfg.datadir ];
        CapabilityBoundingSet = "";
        NoNewPrivileges = true;
        ProtectSystem = "strict";
        ProtectHome = true;
        PrivateTmp = true;
        PrivateDevices = true;
        PrivateUsers = true;
        ProtectHostname = true;
        ProtectClock = true;
        ProtectKernelTunables = true;
        ProtectKernelModules = true;
        ProtectKernelLogs = true;
        ProtectControlGroups = true;
        RestrictAddressFamilies = [ "AF_UNIX AF_INET AF_INET6" ];
        LockPersonality = true;
        RestrictRealtime = true;
        RestrictSUIDSGID = true;
        PrivateMounts = true;
      };
    };

    users = {
      users.infrared = {
        createHome = true;
        isSystemUser = true;
        home = cfg.datadir;
        group = "infrared";
      };

      groups.infrared = { };
    };
  });
}
