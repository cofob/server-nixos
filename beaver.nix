{ pkgs, config, ... }:

{
  imports = [
    ./modules/modules.nix
    ./hardware/proxmox-whale.nix
    ./mounts/proxmox.nix
  ];

  nix.settings.system-features = [
    "big-parallel"
    "kvm"
    "nixos-test"
    "gccarch-haswell"
  ];

  nixpkgs.localSystem = {
    gcc.arch = "haswell";
    gcc.tune = "haswell";
    system = "x86_64-linux";
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
