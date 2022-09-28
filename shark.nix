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

  age.secrets.cockroach-shark-crt.file = ./secrets/cockroach/shark-crt.age;
  age.secrets.cockroach-shark-key.file = ./secrets/cockroach/shark-key.age;
  age.secrets.cockroach-shark-crt.owner = config.services.cockroachdb.user;
  age.secrets.cockroach-shark-key.owner = config.services.cockroachdb.user;
  services.cockroachdb = {
    enable = true;
    crtFile = config.age.secrets.cockroach-shark-crt.path;
    keyFile = config.age.secrets.cockroach-shark-key.path;
    locality = "country=ru,datacenter=averyan";
    openPorts = true;
    http.port = 8082;
    listen.address = "10.3.7.40";
    join = "rat.n.frsqr.xyz";
  };

  services.glusterfs.enable = true;

  services.backup = {
    enable = true;
    timers.weekly = [
      "mineflake.pxar:/var/lib/mineflake"
      "minecraft.pxar:/tank/mc"
      "cockroachdb.pxar:/var/lib/cockroachdb"
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
