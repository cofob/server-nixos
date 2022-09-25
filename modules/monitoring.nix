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
    };
  };
}
