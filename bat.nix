{ pkgs, ... }:

let
  commonNginxHost = {
    kTLS = true;
    useACMEHost = "nm.frsqr.xyz";
    listen = [{
      addr = "127.0.0.1";
      port = 8443;
      ssl = true;
    }];
    locations."/".proxyWebsockets = true;
  };
in
{
  imports = [
    ./modules/modules.nix
    ./hardware/aeza.nix
    ./mounts/aeza.nix
  ];

  virtualisation.docker.enable = true;
  users.users.alex.extraGroups = [ "docker" ];
  environment.systemPackages = [ pkgs.docker-compose_2 ];

  security.acme.certs = {
    "nm.frsqr.xyz" = { extraDomainNames = [ "*.nm.frsqr.xyz" ]; };
  };

  services.nginx = {
    streamConfig = ''
      map $ssl_preread_server_name $target {
        broker.nm.frsqr.xyz 127.0.0.1:8883;
        api.nm.frsqr.xyz 127.0.0.1:8443;
        dashboard.nm.frsqr.xyz 127.0.0.1:8443;
      }

      server {
        listen 443;

        proxy_connect_timeout 3s;
        proxy_timeout 3s;

        proxy_pass $target;
        ssl_preread on;
      }
    '';
    virtualHosts = {
      "api.nm.frsqr.xyz" = commonNginxHost // { locations."/".proxyPass = "http://127.0.0.1:8081"; };
      "dashboard.nm.frsqr.xyz" = commonNginxHost // { locations."/".proxyPass = "http://127.0.0.1:8080"; };
    };
  };

  networking = {
    hostName = "bat";

    defaultGateway = {
      address = "10.0.0.1";
      interface = "ens3";
    };

    nat.enable = false;
    firewall.enable = false;

    interfaces = {
      ens3 = {
        ipv4 = {
          addresses = [{
            address = "45.142.122.8";
            prefixLength = 32;
          }];
        };
      };
    };
  };
}
