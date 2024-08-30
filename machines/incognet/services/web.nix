{ lib, config, pkgs, useit-src, ... }:

{
  services.cofob-dev.enable = true;
  services.balance-tracker.enable = true;
  services.fastside = {
    enable = true;
    logLevel = "info";
    services = "https://raw.githubusercontent.com/cofob/fastside/master/services.json";
    config = {
      proxies = {
        tor = {
          url = "socks5h://127.0.0.1:9050";
        };
        i2p = {
          url = "http://127.0.0.1:4444";
        };
      };
      default_user_config = {
        required_tags = [ "clearnet" "https" "ipv4" ];
        forbidden_tags = [ "cloudflare" ];
      };
      crawler = {
        request_timeout = {
          secs = 10;
          nanos = 0;
        };
      };
    };
  };

  services.nginx = {
    enable = lib.mkDefault true;

    virtualHosts."cofob.dev" = {
      enableACME = true;
      quic = true;
      http3 = true;
      kTLS = true;
      forceSSL = true;
      locations =
        let
          well_known_server = pkgs.writeText "well-known-matrix-server" ''
            {
              "m.server": "matrix.cofob.dev:443"
            }
          '';
          # Build a dervation that stores the content of `${server_name}/.well-known/matrix/client`
          well_known_client = pkgs.writeText "well-known-matrix-client" ''
            {
              "m.homeserver": {
                "base_url": "https://matrix.cofob.dev"
              }
            }
          '';
        in
        {
          # Website config
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

          # Matrix config
          "=/.well-known/matrix/server" = {
            alias = "${well_known_server}";
            extraConfig = ''
              # Set the header since by default NGINX thinks it's just bytes
              default_type application/json;
            '';
          };
          "=/.well-known/matrix/client" = {
            alias = "${well_known_client}";
            extraConfig = ''
              # Set the header since by default NGINX thinks it's just bytes
              default_type application/json;
              # https://matrix.org/docs/spec/client_server/r0.4.0#web-browser-clients
              add_header Access-Control-Allow-Origin "*";
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

    virtualHosts."element.cofob.dev" = {
      enableACME = true;
      quic = true;
      http3 = true;
      kTLS = true;
      forceSSL = true;
      root = pkgs.element-cofob-dev;
      extraConfig = ''
        gzip_static on;
        brotli_static on;
      '';
    };

    virtualHosts."cinny.cofob.dev" = {
      enableACME = true;
      quic = true;
      http3 = true;
      kTLS = true;
      forceSSL = true;
      root = pkgs.cinny-cofob-dev;
      extraConfig = ''
        gzip_static on;
        brotli_static on;
      '';
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

    virtualHosts."fastside.link" = {
      enableACME = true;
      quic = true;
      http3 = true;
      kTLS = true;
      forceSSL = true;
      redirectCode = 307;
      locations."/".proxyPass = "http://127.0.0.1:8080/";
      extraConfig = ''
        merge_slashes off;
      '';
    };

    virtualHosts."fastsi.de" = {
      enableACME = true;
      quic = true;
      http3 = true;
      kTLS = true;
      forceSSL = true;
      redirectCode = 307;
      locations."/".proxyPass = "http://127.0.0.1:8080/";
      extraConfig = ''
        merge_slashes off;
      '';
    };

    virtualHosts."ygg.fastside.link" = {
      listen = [{
        addr = "[200:691d:578e:f10e:e935:f189:aab4:1d98]";
        port = 80;
      }];
      locations."/".proxyPass = "http://127.0.0.1:8080/";
      extraConfig = ''
        merge_slashes off;
      '';
    };

    virtualHosts."cdn.fastside.link" = {
      enableACME = true;
      quic = true;
      http3 = true;
      kTLS = true;
      forceSSL = true;
      redirectCode = 307;
      locations."/".proxyPass = "http://127.0.0.1:8080/";
      extraConfig = ''
        merge_slashes off;
      '';
    };
  };

  networking.firewall = {
    allowedTCPPorts = [ 80 443 ];
    allowedUDPPorts = [ 443 ];
  };
}
