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
  nixpkgs.config.permittedInsecurePackages = [
    "cinny-unwrapped-4.2.3"
  ];

  services.zerotierone = {
    enable = true;
    joinNetworks = [ "e4da7455b237c59e" ];
  };
  services.tailscale.enable = true;

  networking = {
    hostName = "incognet";
  };
}
