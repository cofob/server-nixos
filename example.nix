{ args, config, lib, pkgs, ... }:

{
  imports = [ ./common.nix ./mounts/example.nix ./hardware/proxmox-whale.nix ];
}
