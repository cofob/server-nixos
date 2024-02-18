{ ... }:

{
  imports = [
    ./services

    ../../modules
    ../../hardware/incognet.nix
    ../../mounts/incognet.nix
  ];

  services.backup.enable = true;

  nixpkgs.config.allowUnfree = true;
  services.zerotierone = {
    enable = true;
    joinNetworks = [ "e4da7455b237c59e" ];
  };

  networking = {
    hostName = "incognet";
  };
}
