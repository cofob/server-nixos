{ lib, config, pkgs, ... }:

with lib;

let
  cfg = config.services.fs-monitoring;
in
{
  options = {
    services.fs-monitoring = {
      enable = mkEnableOption "firesquare monitoring";
    };
  };

  config = (mkIf cfg.enable {
    services.grafana = {
      enable = true;
      package = pkgs.unstable.grafana;
      port = 3729;
      domain = "grafana.frsqr.xyz";
      rootUrl = "https://grafana.frsqr.xyz/";
      extraOptions = {
        SECURITY_COOKIE_SECURE = "true";
      };
      database = {
        type = "postgres";
        user = "grafana";
        name = "grafana";
        host = "/run/postgresql";
      };

      provision = {
        enable = true;
        datasources = [
          {
            name = "prometheus";
            type = "prometheus";
            url = "http://127.0.0.1:9090/";
          }
        ];
      };
    };

    services.prometheus = {
      enable = true;
      listenAddress = "127.0.0.1";
      scrapeConfigs = [
        {
          job_name = "prometheus";
          scrape_interval = "1m";
          static_configs = [{
            targets = [ "127.0.0.1:9090" ];
          }];
        }
        {
          job_name = "node";
          scrape_interval = "1m";
          static_configs = [{
            targets = [
              "rat.n.frsqr.xyz:9100"
              "eagle.n.frsqr.xyz:9100"
            ];
          }];
        }
      ];
    };
  }) // {
    services.prometheus.exporters = {
      node = {
        enable = true;
        enabledCollectors = [ "systemd" ];
      };
    };

    networking.firewall.interfaces."nebula.frsqr".allowedTCPPorts = mkIf config.networking.nebula-frsqr.enable [ 9100 ];
  };
}
