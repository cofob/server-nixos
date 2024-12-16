{ ... }:

{
  imports = [
    ./services

    ./ssh.nix

    ../../modules
    ../../hardware/incognet.nix
    ../../mounts/incognet.nix
  ];

  services.backup.enable = true;
  services.telegram-backup.enable = true;

  nixpkgs.config.allowUnfree = true;
  services.zerotierone = {
    enable = true;
    joinNetworks = [ "e4da7455b237c59e" ];
  };
  services.tailscale.enable = true;

  networking = {
    hostName = "incognet";
  };
}
