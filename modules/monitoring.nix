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

  config = mkIf cfg.enable {
    services.grafana = {
      enable = true;

      settings = {
        database = {
          type = "postgres";
          user = "grafana";
          name = "grafana";
          host = "/run/postgresql";
        };
        server = {
          http_port = 3729;
          domain = "grafana.frsqr.xyz";
          rootUrl = "https://grafana.frsqr.xyz/";
        };
      };

      provision = {
        enable = true;
        datasources.settings.datasources = [
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
      webExternalUrl = "https://prometheus.frsqr.xyz/";
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
              "10.100.0.1:9100"
              "10.100.0.2:9100"
            ];
          }];
        }
        {
          job_name = "nginx";
          scrape_interval = "10s";
          static_configs = [{
            targets = [
              "localhost:9113"
              "10.100.0.2:9113"
            ];
          }];
        }
        {
          job_name = "postgres";
          scrape_interval = "1m";
          static_configs = [{
            targets = [
              "localhost:9187"
              "10.100.0.2:9187"
            ];
          }];
        }
      ];
    };

    services.fs-nginx.virtualHosts = {
      "grafana.frsqr.xyz" = {
        locations."/".proxyPass = "http://127.0.0.1:3729/";
        onlyCloudflare = true;
        sslCertificate = config.age.secrets.cf-certs-frsqr-xyz-cert.path;
        sslCertificateKey = config.age.secrets.cf-certs-frsqr-xyz-key.path;
      };
      "prometheus.frsqr.xyz" = {
        locations."/".proxyPass = "http://127.0.0.1:9090/";
        onlyCloudflare = true;
        sslCertificate = config.age.secrets.cf-certs-frsqr-xyz-cert.path;
        sslCertificateKey = config.age.secrets.cf-certs-frsqr-xyz-key.path;
      };
    };

    services.backup.timers.daily = [
      "grafana.pxar:${config.services.grafana.dataDir}"
      "prometheus.pxar:${config.services.prometheus.stateDir}"
    ];
  };
}
