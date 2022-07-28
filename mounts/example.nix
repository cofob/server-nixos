{ config, lib, pkgs, ... }:

{
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/8c771acb-1838-4c18-97ca-10ef5ad2bd5d";
    fsType = "ext4";
    options = [ "discard" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/42C5-E7F9";
    fsType = "vfat";
  };
}
