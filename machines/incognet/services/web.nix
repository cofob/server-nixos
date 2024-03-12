{ lib, config, pkgs, useit-src, ... }:

{
  services.cofob-dev.enable = true;
  services.balance-tracker.enable = true;

  services.nginx = {
    enable = lib.mkDefault true;

    virtualHosts."cofob.dev" = {
      enableACME = true;
      quic = true;
      http3 = true;
      kTLS = true;
      forceSSL = true;
      locations = {
        "/".proxyPass = "http://127.0.0.1:3000/";
        "/static/" = {
          alias = "${config.services.cofob-dev.package}/client/static/";
          extraConfig = ''
            gzip_static on;
            brotli_static on;
            add_header cache-control "public, max-age=31536000";
          '';
        };
        "/_app/immutable/" = {
          alias = "${config.services.cofob-dev.package}/client/_app/immutable/";
          extraConfig = ''
            gzip_static on;
            brotli_static on;
            add_header cache-control "public, max-age=31536000, immutable";
          '';
        };
      };
    };

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

    virtualHosts."cofob.gay" = {
      enableACME = true;
      quic = true;
      http3 = true;
      kTLS = true;
      forceSSL = true;
      locations."/".return = "302 https://cofob.dev$request_uri?rainbow";
    };

    virtualHosts."useit.info" = {
      enableACME = true;
      quic = true;
      http3 = true;
      kTLS = true;
      forceSSL = true;
      root = "${useit-src}/site";
    };
  };

  networking.firewall = {
    allowedTCPPorts = [ 80 443 ];
    allowedUDPPorts = [ 443 ];
  };
}
