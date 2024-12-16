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
  users.users.cofob.extraGroups = [ "libvirt" ];

  nixpkgs.config.allowUnfree = true;
  services.tailscale.enable = true;

  networking = {
    hostName = "odin";
  };
}
