{ ... }:

{
  imports = [
    ../../modules
    ../../hardware/aeza.nix
    ../../mounts/aeza.nix

    ./db.nix
    ./syncthing.nix
    ./services

    ../shared/stateless-sites.nix
  ];

  services.fs-nginx.enable = true;

  services.backup.enable = true;

  networking = {
    hostName = "rat";

    nft-firewall.enable = false;

    firewall = {
      trustedInterfaces = [ "lo" ];
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
