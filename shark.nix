{ pkgs, config, ... }:

{
  imports = [
    ./modules
    ./hardware/whale-vm.nix
    ./mounts/shark.nix
  ];

  networking.nft-firewall.enable = false;
  virtualisation.docker.enable = true;
  environment.systemPackages = [ pkgs.docker-compose_2 ];
  virtualisation.oci-containers.backend = "docker";

  services.ipfs.enable = true;
  services.ipfs-cluster.enable = true;

  networking = {
    hostName = "shark";

    nebula-frsqr.enable = true;

    defaultGateway = {
      address = "192.168.12.1";
      interface = "enp1s0";
    };

    interfaces = {
      enp1s0 = {
        ipv4 = {
          addresses = [{
            address = "192.168.12.2";
            prefixLength = 24;
          }];
        };
      };
    };
  };
}
