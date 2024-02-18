{ ... }:

{
  imports = [
    ../../modules
    ../../hardware/aeza.nix
    ../../mounts/aeza.nix

    ./services
  ];

  services.nginx.enable = true;

  networking = {
    hostName = "rat";

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
