{ ... }:

{
  imports = [
    ../../modules
    ../../hardware/aeza.nix
    ../../mounts/aeza.nix

    ./ssh.nix
  ];

  services.dev-common.enable = true;

  nixpkgs.config.allowUnfree = true;
  services.zerotierone = {
    enable = true;
    joinNetworks = [ "e4da7455b237c59e" ];
  };

  networking = {
    hostName = "dev2";

    defaultGateway = {
      address = "10.0.0.1";
      interface = "ens3";
    };
    defaultGateway6 = {
      address = "2a12:5940:d1be::1";
      interface = "ens3";
    };

    interfaces = {
      ens3 = {
        ipv4 = {
          addresses = [{
            address = "185.112.83.58";
            prefixLength = 32;
          }];
        };
        ipv6 = {
          addresses = [{
            address = "2a12:5940:d1be::2";
            prefixLength = 48;
          }];
        };
      };
    };
  };
}
