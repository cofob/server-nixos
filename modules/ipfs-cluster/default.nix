{ lib, config, pkgs, ... }:

with lib; let
  cfg = config.services.ipfs-cluster;
in
{
  options.services.ipfs-cluster = {
    enable = mkEnableOption "Whether to enable IPFS cluster";

    service = mkOption {
      type = types.attrs;
      default = (importJSON ./service.json);
    };

    peers = mkOption {
      type = types.str;
      default = ''
        /ip4/89.208.104.77/tcp/9096/p2p/12D3KooWPCtXz5yueZ3xynEsG4GrP9wkFez8viuEdRoV6ddj7c4J
      '';
    };

    stateDirectoryName = mkOption {
      type = types.str;
      default = "ipfs-cluster";
    };

    environmentFile = mkOption {
      type = types.path;
      default = config.age.secrets.credentials-ipfs-cluster.path;
    };

    package = mkOption {
      type = types.package;
      default = pkgs.ipfs-cluster;
    };
  };

  config = mkIf cfg.enable {
    assertions =
      [{
        assertion = config.services.ipfs.enable;
        message = "IPFS daemon must be enabled";
      }];

    age.secrets.credentials-ipfs-cluster.file = ../../secrets/credentials/ipfs-cluster.age;

    systemd.services.ipfs-cluster = {
      path = [ cfg.package ];
      wants = [ "ipfs.service" ];
      requires = [ "ipfs.service" ];
      wantedBy = [ "multi-user.target" ];
      preStart = ''
        if [ ! -f "identity.json" ]; then
          ipfs-cluster-service --config . init -f
        fi
        cp ${builtins.toFile "service.json" (builtins.toJSON cfg.service)} service.json
        chmod 640 service.json
        sed -i "s/#SECRET#/$SECRET/g" service.json
        rm -f peerstore
        ln -sf ${builtins.toFile "peerstore" cfg.peers} peerstore
      '';
      script = "ipfs-cluster-service --config . daemon";
      serviceConfig = {
        StateDirectory = cfg.stateDirectoryName;
        EnvironmentFile = cfg.environmentFile;
        WorkingDirectory = "/var/lib/${cfg.stateDirectoryName}";
        User = "ipfs-cluster";
        Group = "ipfs-cluster";
        PrivateTmp = true;
      };
    };

    users = {
      users."ipfs-cluster" = {
        isSystemUser = true;
        description = "ipfs-cluster user";
        home = "/var/lib/${cfg.stateDirectoryName}";
        createHome = true;
        group = "ipfs-cluster";
      };

      groups."ipfs-cluster" = { };
    };

    environment.systemPackages = [ cfg.package ];
  };
}
