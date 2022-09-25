{ config, lib, ... }:

{
  services.prometheus.exporters = {
    node = {
      enable = true;
      enabledCollectors = [ "systemd" ];
    };
  };

  networking.firewall.interfaces."nebula.frsqr".allowedTCPPorts = lib.mkIf config.networking.nebula-frsqr.enable [ 9100 ];
}
