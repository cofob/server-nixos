{ ... }:

{
  imports = [
    ../../modules
    ../../hardware/diamond.nix
    ./services
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "/dev/nvme0n1";

  services.backup.enable = true;

  networking.hostName = "diamond";
}
