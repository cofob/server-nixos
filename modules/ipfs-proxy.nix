{ lib, config, ipfs-proxy, ... }:

with lib; let
  cfg = config.services.ipfs-proxy;
in
{
  options.services.ipfs-proxy = {
    enable = mkEnableOption "If enabled, ipfs-proxy will be configured";

    envFile = mkOption {
      type = types.path;
      description = "Path to the environment file";
    };

    package = mkOption {
      type = types.package;
      default = ipfs-proxy.packages.x86_64-linux.default;
      defaultText = "pkgs.ipfs-proxy";
      description = "The package to use for ipfs-proxy";
    };
  };

  config = mkIf cfg.enable ({
    systemd.services.ipfs-proxy = {
      path = [ cfg.package ];
      wantedBy = [ "multi-user.target" ];
      script = "ipfs-proxy";
      serviceConfig = {
        Type = "simple";
        EnvironmentFile = cfg.envFile;
      };
    };
  });
}
