{ lib, config, pkgs, ... }:

{
  services.cofob-dev.enable = true;

  services.nginx = {
    enable = lib.mkDefault true;

    virtualHosts."cofob.dev" = {
      enableACME = true;
      quic = true;
      http3 = true;
      kTLS = true;
      forceSSL = true;
      locations."/".proxyPass = "http://127.0.0.1:3000/";
    };

    virtualHosts."ipfs.cofob.dev" = {
      enableACME = true;
      quic = true;
      http3 = true;
      kTLS = true;
      forceSSL = true;
      locations."/" = {
        return = "301 https://ipfs.io$request_uri";
        extraConfig = ''
          add_header access-control-allow-origin *;
          add_header access-control-allow-headers *;
        '';
      };
    };

    virtualHosts."cofob.gay" = {
      enableACME = true;
      quic = true;
      http3 = true;
      kTLS = true;
      forceSSL = true;
      locations."/".return = "302 https://cofob.dev$request_uri?rainbow";
    };
  };

  networking.firewall = {
    allowedTCPPorts = [ 80 443 ];
    allowedUDPPorts = [ 443 ];
  };
}
