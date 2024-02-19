{ lib, ... }:

{
  virtualisation.oci-containers.containers.perchun-uptime-kuma = {
    image = "docker.io/louislam/uptime-kuma:1@sha256:c326fd83d8da2d8fff3feb0e47433546139513bd823d9accc12977176b05b31f";
    ports = [
      "127.0.0.1:3001:3001"
    ];
    volumes = [
      "/var/lib/perchun-uptime-kuma:/var/lib/uptime-kuma"
    ];
  };

  services.nginx.enable = lib.mkDefault true;
  services.nginx.virtualHosts."kuma.perchun.it" = {
    enableACME = true;
    quic = true;
    http3 = true;
    kTLS = true;
    forceSSL = true;
    locations."/".proxyPass = "http://127.0.0.1:3001/";
  };
}
