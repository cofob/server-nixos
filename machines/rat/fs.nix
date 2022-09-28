{ ... }:

{
  services.glusterfs.enable = true;

  fileSystems."/gluster/mounts/global" = {
    device = "rat.n.frsqr.xyz:/gv0";
    fsType = "glusterfs";
    options = [ "defaults" ];
  };
}
