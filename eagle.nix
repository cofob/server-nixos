{ pkgs, config, ... }:

{
  imports = [
    ./modules/modules.nix
    ./hardware/aeza.nix
    ./mounts/aeza.nix
  ];

  age.secrets.nebula-ca.file = ./secrets/nebula/ca-crt.age;
  age.secrets.nebula-key.file = ./secrets/nebula/${config.networking.hostName}-key.age;
  age.secrets.nebula-crt.file = ./secrets/nebula/${config.networking.hostName}-crt.age;
  services.nebula.networks.global = {
    key = config.age.secrets.nebula-key.path;
    cert = config.age.secrets.nebula-crt.path;
    ca = config.age.secrets.nebula-ca.path;
    isLighthouse = true;
    firewall = {
      inbound = [{
        host = "any";
        port = "any";
        proto = "any";
      }];
      outbound = [{
        host = "any";
        port = "any";
        proto = "any";
      }];
    };
  };

  networking = {
    hostName = "eagle";

    defaultGateway = {
      address = "10.0.0.1";
      interface = "ens3";
    };

    interfaces = {
      ens3 = {
        ipv4 = {
          addresses = [{
            address = "185.112.83.178";
            prefixLength = 32;
          }];
        };
      };
    };
  };
}
