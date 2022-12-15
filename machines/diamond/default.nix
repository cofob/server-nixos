{ ... }:

{
  imports = [
    ../../modules
    ../../hardware/diamond.nix
  ];

  services.backup.enable = true;

  networking.hostName = "diamond";
}
