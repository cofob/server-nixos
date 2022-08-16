{ pkgs, ... }:

{
  imports = [
    ./modules/modules.nix
    ./hardware/aeza.nix
    ./mounts/aeza.nix
  ];

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
