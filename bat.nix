{ config, pkgs, ... }:

{
  imports =
    [ ./hardware/aeza.nix ./mounts/aeza.nix ./common.nix ];

  networking = {
    hostName = "bat";

    defaultGateway = {
      address = "10.0.0.1";
      interface = "ens3";
    };

    nat.enable = false;
    firewall.enable = false;

    interfaces = {
      ens3 = {
        ipv4 = {
          addresses = [{
            address = "45.142.122.8";
            prefixLength = 32;
          }];
        };
      };
    };
  };
}
