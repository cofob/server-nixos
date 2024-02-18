{ lib, config, pkgs, ... }:

{
  services.cofob-dev.enable = true;

  services.nginx = {
    enable = lib.mkDefault true;

    virtualHosts."cofob.dev" = {
      enableACME = true;
      quic = true;
      forceSSL = true;
      locations."/".proxyPass = "http://127.0.0.1:3000/";
    };

    virtualHosts."cofob.gay" = {
      enableACME = true;
      quic = true;
      forceSSL = true;
      locations."/".return = "302 https://cofob.dev$request_uri?rainbow";
    };
  };

  networking.firewall = {
    allowedTCPPorts = [ 80 443 ];
    allowedUDPPorts = [ 443 ];
  };
}
