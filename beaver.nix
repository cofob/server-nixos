{ pkgs, config, ... }:

{
  imports = [
    ./modules/modules.nix
    ./hardware/proxmox-whale.nix
    ./mounts/proxmox.nix
  ];

  networking = {
    hostName = "beaver";

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
