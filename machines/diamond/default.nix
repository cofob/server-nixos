{ ... }:

{
  imports = [
    ../../modules
    ../../hardware/diamond.nix
  ];

  boot.loader.systemd-boot.enable = true;

  services.backup.enable = false;

  networking.hostName = "diamond";
}
