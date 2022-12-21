{ ... }:

{
  services.fs-nginx.virtualHosts."cloud.frsqr.xyz" = {
    useACMEHost = "cloud.frsqr.xyz";
    locations."/".proxyPass = "http://10.100.0.2";
  };

  security.acme.certs."cloud.frsqr.xyz" = { };
}
