{ lib, config, pkgs, useit-src, ... }:

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

    virtualHosts."ipfs.cofob.dev" = {
      enableACME = true;
      quic = true;
      http3 = true;
      kTLS = true;
      forceSSL = true;
      locations."/" = {
        return = "301 https://public-ipfs.cofob.dev$request_uri";
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
