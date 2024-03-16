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

      root = pkgs.element-web.override {
        conf = {
          default_server_config = {
            "m.homeserver".base_url = "https://matrix.cofob.dev";
            "m.homeserver".server_name = "cofob.dev";
            "m.identity_server".base_url = "https://disabled.cofob.dev";
          };
          integrations_ui_url = "https://disabled.cofob.dev/";
          integrations_rest_url = "https://disabled.cofob.dev/";
          integrations_widgets_urls = [ "https://disabled.cofob.dev/" ];
          jitsi.preferred_domain = "disabled.cofob.dev";
          element_call.url = "https://disabled.cofob.dev";
          map_style_url = "https://disabled.cofob.dev";
        };
      };
    };

    virtualHosts."cinny.cofob.dev" = {
      enableACME = true;
      quic = true;
      http3 = true;
      kTLS = true;
      forceSSL = true;

      root = pkgs.cinny.override {
        conf = {
          defaultHomeserver = 0;
          homeserverList = [ "cofob.dev" ];
          allowCustomHomeservers = false;
          hashRouter.enabled = false;
          hashRouter.basename = "/";
        };
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
