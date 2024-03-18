{ ... }:

{
  imports = [
    ../../modules
    ../../hardware/aeza.nix
    ../../mounts/aeza.nix

    ./ssh.nix
  ];

  services.dev-common.enable = true;

  services.openvscode-server = {
    enable = true;
    user = "cofob";
    port = 1337;
    host = "172.26.10.253";
  };
  networking.firewall.interfaces.ztwfuehebm.allowedTCPPorts = [ 1337 ];

  nixpkgs.config.allowUnfree = true;
  services.zerotierone = {
    enable = true;
    joinNetworks = [ "e4da7455b237c59e" ];
  };

  networking = {
    hostName = "dev1";

    defaultGateway = {
      address = "10.0.0.1";
      interface = "ens3";
    };
    defaultGateway6 = {
      address = "2a12:5940:d0df::1";
      interface = "ens3";
    };

    interfaces = {
      ens3 = {
        ipv4 = {
          addresses = [{
            address = "45.142.122.234";
            prefixLength = 32;
          }];
        };
        ipv6 = {
          addresses = [{
            address = "2a12:5940:d0df::2";
            prefixLength = 48;
          }];
        };
      };
    };
  };
}
