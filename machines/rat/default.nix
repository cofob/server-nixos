{ ... }:

{
  imports = [
    ../../modules
    ../../hardware/aeza.nix
    ../../mounts/aeza.nix

    ./services
  ];

  services.nginx.enable = true;

  services.backup.enable = true;
  services.telegram-backup.enable = true;

  networking = {
    hostName = "rat";

    defaultGateway = {
      address = "10.0.0.1";
      interface = "ens3";
    };
    defaultGateway6 = {
      address = "2a0e:d602:1:30b::1";
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
        ipv6 = {
          addresses = [{
            address = "2a0e:d602:1:30b::2";
            prefixLength = 64;
          }];
        };
      };
    };
  };
}
