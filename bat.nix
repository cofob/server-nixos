{ pkgs, ... }:

{
  imports = [
    ./modules/modules.nix
    ./hardware/aeza.nix
    ./mounts/aeza.nix
  ];

  virtualisation.docker.enable = true;
  users.users.alex.extraGroups = [ "docker" ];
  environment.systemPackages = [ pkgs.docker-compose_2 ];

  security.acme.certs = {
    "nm.frsqr.xyz" = { extraDomainNames = [ "*.nm.frsqr.xyz" ]; };
  };

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
