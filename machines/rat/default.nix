{ ... }:

{
  imports = [
    ../../modules
    ../../hardware/aeza.nix
    ../../mounts/aeza.nix

    ./services

    ../../configs/stateless-sites.nix
  ];

  services.nginx.enable = true;

  services.backup.enable = true;

  networking = {
    hostName = "rat";

    nft-firewall.enable = false;

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
