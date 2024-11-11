{
  boot.initrd.luks.devices = {
    root-4tb = {
      device = "/dev/disk/by-uuid/6ea5590f-c2de-4e92-95d6-187132ae3f56";
      preLVM = true;
    };
    root-6tb = {
      device = "/dev/disk/by-uuid/90d800b6-24f7-4318-b259-ea46782297a4";
      preLVM = true;
    };
  };

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/efaee11c-d64e-40bf-b190-fe77045e1ad3";
      fsType = "btrfs";
      options = [ "compress=zstd" ];
    };

  fileSystems."/data" =
    { device = "/dev/disk/by-uuid/7c12c423-c80a-477a-b781-d754071645e0";
      fsType = "xfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/1205-CEFF";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/551c1b98-b0db-4774-9c82-1abdd6750476"; }
    ];
}
