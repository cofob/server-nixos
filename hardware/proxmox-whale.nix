{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ ./proxmox.nix ];

  boot.kernelModules = [ "kvm-intel" ];
}
