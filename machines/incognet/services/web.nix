{ lib, config, pkgs, ... }:

{
  services.shared-web.enable = true;

  services.balance-tracker.enable = true;

  services.nginx = {
    enable = lib.mkDefault true;

    virtualHosts."balance-tracker.cofob.dev" = {
      enableACME = true;
      quic = true;
      http3 = true;
      kTLS = true;
      forceSSL = true;
      # Frontend
      locations."/".proxyPass = "http://127.0.0.1:3002/";
      # API backend
      locations."/balance/".proxyPass = "http://127.0.0.1:3003/balance/";
    };
  };

  networking.firewall = {
    allowedTCPPorts = [ 80 443 ];
    allowedUDPPorts = [ 443 ];
  };
}
