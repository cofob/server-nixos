{
  imports = [ ./proxmox.nix ];

  boot.kernelModules = [ "kvm-intel" ];
}
