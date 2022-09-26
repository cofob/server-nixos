{ pkgs, config, ... }:

{
  imports = [
    ./modules
    ./hardware/whale-vm.nix
    ./mounts/shark.nix
  ];

  virtualisation.docker.enable = true;
  environment.systemPackages = [ pkgs.docker-compose_2 ];
  virtualisation.oci-containers.backend = "docker";

  services.ipfs.enable = true;
  services.ipfs-cluster.enable = true;

  services.fs-minecraft.enable = true;

  services.grafana-image-renderer = {
    enable = true;
    settings.rendering.mode = "reusable";
  };

  services.backup = {
    enable = true;
    timers.weekly = [
      "mineflake.pxar:/var/lib/mineflake"
      "minecraft.pxar:/tank/mc"
    ];
  };

  networking = {
    hostName = "shark";

    nebula-frsqr.enable = true;

    firewall = {
      interfaces."nebula.frsqr".allowedTCPPorts = [ 25565 8081 ];
    };

    nat = {
      enable = true;
      internalInterfaces = [ "ve-+" ];
    };

    defaultGateway = {
      address = "192.168.12.1";
      interface = "enp1s0";
    };

    interfaces = {
      enp1s0 = {
        ipv4 = {
          addresses = [{
            address = "192.168.12.2";
            prefixLength = 24;
          }];
        };
      };
    };
  };
}
