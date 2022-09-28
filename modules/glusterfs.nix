{ lib, config, ... }:

with lib; {
  config = mkIf config.services.glusterfs.enable {
    services.glusterfs = { };
    networking.firewall.interfaces."nebula.frsqr".allowedTCPPorts = [ 24007 24008 24009 ];
    networking.firewall.interfaces."nebula.frsqr".allowedTCPPortRanges = [
      {
        from = 24009;
        to = 24109;
      }
      {
        from = 49152;
        to = 49252;
      }
      {
        from = 38465;
        to = 38467;
      }
    ];
  };
}
