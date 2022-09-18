{
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/b1730680-95bb-429d-ae43-4ffff835d0eb";
    fsType = "ext4";
    options = [ "discard" ];
  };

  fileSystems."/tank" = {
    device = "/dev/disk/by-uuid/3ec79259-2e27-42ad-bf0d-4f9ac982b70f";
    fsType = "ext4";
    options = [ "discard" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/510F-2182";
    fsType = "vfat";
  };
}
