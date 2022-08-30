{ pkgs, config, ... }:

{
  imports = [
    ./modules/modules.nix
    ./hardware/proxmox-whale.nix
    ./mounts/proxmox.nix
  ];

  networking.nft-firewall.enable = false;
  virtualisation.docker.enable = true;
  virtualisation.oci-containers.backend = "docker";

  age.secrets.woodpecker-agent.file = ./secrets/credentials/woodpecker-agent.age;
  virtualisation.oci-containers.containers.woodpecker-agent = {
    image = "docker.io/woodpeckerci/woodpecker-agent:v0.15.3";
    volumes = [ "/var/run/docker.sock:/var/run/docker.sock" ];
    environment = {
      WOODPECKER_SERVER = "rat.n.frsqr.xyz:9000";
      WOODPECKER_MAX_PROCS = "4";
    };
    environmentFiles = [ config.age.secrets.woodpecker-agent.path ];
  };

  networking = {
    hostName = "beaver";

    nebula-global.enable = true;

    defaultGateway = {
      address = "192.168.20.1";
      interface = "enp6s18";
    };

    interfaces = {
      enp6s18 = {
        ipv4 = {
          addresses = [{
            address = "192.168.20.12";
            prefixLength = 24;
          }];
        };
      };
    };
  };
}
