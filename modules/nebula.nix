{ lib, config, ... }:

with lib;

let
  cfg = config.networking.nebula-global;
in
{
  options = {
    networking.nebula-global = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Whether to enable global nebula network.";
      };
      isLighthouse = mkOption {
        type = types.bool;
        default = false;
        description = "Whether to configure this node as lighthouse.";
      };
      firewall = {
        outbound = mkOption {
          type = types.listOf types.attrs;
          default = [{ port = "any"; proto = "any"; host = "any"; }];
          description = "Firewall rules for outbound traffic.";
          example = [ ];
        };
        inbound = mkOption {
          type = types.listOf types.attrs;
          default = [{ port = "any"; proto = "any"; host = "any"; }];
          description = "Firewall rules for inbound traffic.";
          example = [ ];
        };
      };
    };
  };

  config = mkIf cfg.enable {
    age.secrets.nebula-ca.file = ../secrets/nebula/ca-crt.age;
    age.secrets.nebula-key.file = ../secrets/nebula/${config.networking.hostName}-key.age;
    age.secrets.nebula-crt.file = ../secrets/nebula/${config.networking.hostName}-crt.age;

    services.nebula.networks.global = {
      key = config.age.secrets.nebula-key.path;
      cert = config.age.secrets.nebula-crt.path;
      ca = config.age.secrets.nebula-ca.path;

      isLighthouse = cfg.isLighthouse;

      lighthouses = mkIf (!cfg.isLighthouse) [ "10.3.7.10" ];
      staticHostMap = mkIf (!cfg.isLighthouse) {
        "10.3.7.10" = [
          "185.112.83.178:4242"
        ];
      };

      firewall = cfg.firewall;
    };
  };
}
