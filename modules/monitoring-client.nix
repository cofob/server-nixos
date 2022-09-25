{ config, lib, ... }:

{
  services.prometheus.exporters = {
    node = {
      enable = true;
      enabledCollectors = [
        "buddyinfo"
        "ksmd"
        "mountstats"
        "processes"
        "qdisc"
        "systemd"
        "tcpstat"
      ];
    };
  };

  networking.firewall.interfaces."nebula.frsqr".allowedTCPPorts = lib.mkIf config.networking.nebula-frsqr.enable [ 9100 ];
}
