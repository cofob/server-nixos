{ config, ... }:

{
  imports = [
    ../../modules
    ../../hardware/diamond.nix

    ./db.nix

    ./services
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "/dev/nvme0n1";

  age.secrets.credentials-pbs-diamond.file = ../../secrets/credentials/pbs-diamond.age;
  services.backup.enable = true;
  services.backup.envFile = config.age.secrets.credentials-pbs-diamond.path;

  networking.hostName = "diamond";
}
