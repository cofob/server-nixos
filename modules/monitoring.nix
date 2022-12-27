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
      pushgateway = {
        enable = true;
        web.external-url = "https://prometheus-push.frsqr.xyz/";
      };
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
        {
          job_name = "nextcloud";
          scrape_interval = "1m";
          static_configs = [{
            targets = [ "localhost:9205" ];
          }];
        }
        {
          job_name = "pushgateway";
          scrape_interval = "1m";
          honor_labels = true;
          static_configs = [{
            targets = [ "localhost:9091" ];
          }];
        }
      ];
    };

    age.secrets.credentials-prometheus-auth.file = ../secrets/credentials/prometheus-auth.age;
    age.secrets.credentials-prometheus-auth.owner = "nginx";
    age.secrets.credentials-prometheus-auth.group = "nginx";
    services.fs-nginx.virtualHosts = {
      "grafana.frsqr.xyz" = {
        locations."/".proxyPass = "http://127.0.0.1:3729/";
        onlyCloudflare = true;
        sslCertificate = config.age.secrets.cf-certs-frsqr-xyz-cert.path;
        sslCertificateKey = config.age.secrets.cf-certs-frsqr-xyz-key.path;
      };
      "prometheus.frsqr.xyz" = {
        locations."/".proxyPass = "http://127.0.0.1:9090/";
        locations."/".basicAuthFile = config.age.secrets.credentials-prometheus-auth.path;
        onlyCloudflare = true;
        sslCertificate = config.age.secrets.cf-certs-frsqr-xyz-cert.path;
        sslCertificateKey = config.age.secrets.cf-certs-frsqr-xyz-key.path;
      };
      "prometheus-push.frsqr.xyz" = {
        locations."/".proxyPass = "http://127.0.0.1:9091/";
        locations."/".basicAuthFile = config.age.secrets.credentials-prometheus-auth.path;
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
