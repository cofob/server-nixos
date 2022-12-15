{ ... }:

{
  imports = [
    ../../modules
    ../../hardware/diamond.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "/dev/nvme0n1";

  services.backup.enable = false;

  networking.hostName = "diamond";
}
