{ ... }:

{
  imports = [
    ../../modules
    ../../hardware/odin.nix
    ../../mounts/odin.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.btrfs.autoScrub.enable = true;

  virtualisation.libvirtd.enable = true;

  nixpkgs.config.allowUnfree = true;
  services.zerotierone = {
    enable = true;
    joinNetworks = [ "e4da7455b237c59e" ];
  };

  networking = {
    hostName = "odin";
  };
}
