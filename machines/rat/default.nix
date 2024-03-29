{ ... }:

{
  imports = [
    ../../modules
    ../../hardware/aeza.nix
    ../../mounts/aeza.nix

    ./services

    ./ssh.nix
  ];

  services.nginx.enable = true;

  services.backup.enable = true;
  services.telegram-backup.enable = true;

  services.shared-web.enable = true;

  nixpkgs.config.allowUnfree = true;
  services.zerotierone = {
    enable = true;
    joinNetworks = [ "e4da7455b237c59e" ];
  };

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
