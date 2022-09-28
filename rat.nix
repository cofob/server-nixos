{ pkgs, lib, config, ... }:

{
  imports = [
    ./modules
    ./hardware/aeza.nix
    ./mounts/aeza.nix
    ./machines/rat
  ];

  services.fs-monitoring.enable = true;

  networking = {
    hostName = "rat";

    nft-firewall.enable = false;

    firewall = {
      trustedInterfaces = [ "lo" ];
      interfaces."nebula.frsqr".allowedTCPPorts = [ 9000 ];
      allowedTCPPorts = [ 4001 9094 9096 ];
      allowedUDPPorts = [ 4001 ];
    };

    nebula-frsqr = {
      enable = true;
      isLighthouse = true;
    };

    defaultGateway = {
      address = "10.0.0.1";
      interface = "ens3";
    };

    interfaces = {
      ens3 = {
        ipv4 = {
          addresses = [{
            address = "89.208.104.77";
            prefixLength = 32;
          }];
        };
      };
    };
  };
}
