{ pkgs, config, ... }:

{
  imports = [
    ./modules
    ./hardware/whale-vm.nix
    ./mounts/shark.nix
  ];

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
