{ ... }:

{
  services.fs-nginx.virtualHosts."cloud.frsqr.xyz" = {
    useACMEHost = "cloud.frsqr.xyz";
    locations."/".proxyPass = "http://10.100.0.2";
    locations."/".extraConfig = ''
      proxy_set_header Host cloud.frsqr.xyz;
      proxy_set_header X-Real-IP $remote_addr;
    '';
  };

  security.acme.certs."cloud.frsqr.xyz" = { };
}
