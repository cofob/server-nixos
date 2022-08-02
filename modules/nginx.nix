{ config, lib, ... }:

{
  config = lib.mkIf (config.services.nginx.virtualHosts != { }) {
    services.nginx = {
      enable = true;
      # package = pkgs.nginxQuic;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;
      recommendedOptimisation = true;
      clientMaxBodySize = "8g";
    };

    # TODO: auto open ports based on nginx settings
    networking.firewall.allowedTCPPorts = [ 80 443 ];
  };
}
