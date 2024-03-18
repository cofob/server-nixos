{ modulesPath, ... }:

{
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];

  boot.initrd.availableKernelModules = [
    "ata_piix"
    "uhci_hcd"
    "virtio_pci"
    "virtio_blk"
  ];
  boot.kernelModules = [ "kvm-amd" ];

  hardware.enableRedistributableFirmware = false;

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
}
