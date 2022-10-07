{ ... }:

{
  services.fs-monitoring.enable = true;

  security.acme.certs."grafana.frsqr.xyz" = { };

  services.fs-nginx.virtualHosts."grafana.frsqr.xyz" = {
    useACMEHost = "grafana.frsqr.xyz";
    locations."/".proxyPass = "http://127.0.0.1:3729/";
  };
}
