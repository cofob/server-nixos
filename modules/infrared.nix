{ lib, pkgs, config, ... }:

with lib; let
  cfg = config.services.infrared;
in
{
  options.services.infrared = {
    enable = mkEnableOption "If enabled, infrared will be configured";

    icons = mkOption {
      type = types.attrsOf types.path;
      default = {
        firesquare = pkgs.fetchurl {
          url = "https://static.ipfsqr.ru/ipfs/bafybeibjkfvmmdzkvap7c7be5r2zwuxr7dbl3r23huk5nxywnjtqem5uqq/server-icon.png";
          sha256 = "0dyxha9gmzqn1mdzvkfw0133h5wvawr1fw3s7x06r792zz6k1dr8";
        };
      };
    };

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
            (name: data: "cp ${(builtins.toFile "infrared-${name}.json" (builtins.toJSON data))} ${cfg.datadir}/configs/${name}.json")
            cfg.hosts;
          obj_icons = mapAttrs
            (name: data: "cp ${data} ${cfg.datadir}/icons/${name}.png")
            cfg.icons;
        in
        ''
          rm -rf ${cfg.datadir}/configs
          mkdir -p ${cfg.datadir}/configs
          ${concatStringsSep "\n" (map (key: getAttr key obj) (attrNames obj))}

          rm -rf ${cfg.datadir}/icons
          mkdir -p ${cfg.datadir}/icons
          ${concatStringsSep "\n" (map (key: getAttr key obj_icons) (attrNames obj_icons))}
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
