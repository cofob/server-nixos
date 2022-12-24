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

    nginx = {
      enable = true;
    };
  };

  networking.firewall.interfaces."wg0".allowedTCPPorts = [ 9100 9113 ];
}
