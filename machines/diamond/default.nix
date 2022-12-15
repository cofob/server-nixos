{ ... }:

{
  imports = [
    ../../modules
    ../../hardware/diamond.nix
  ];

  services.backup.enable = false;

  networking.hostName = "diamond";
}
