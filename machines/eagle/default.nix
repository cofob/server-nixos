{ pkgs, config, ... }:

{
  imports = [
    ../../modules
    ../../hardware/aeza.nix
    ../../mounts/aeza.nix

    ../../configs/stateless-sites.nix
  ];

  security.acme = {
    certs = {
      "memefinder.ru" = {
        extraDomainNames = [ "*.memefinder.ru" ];
        email = "averyanalex@gmail.com";
        credentialsFile = config.age.secrets.credentials-cloudflare-averyan.path;
      };
    };
  };

  services.fs-nginx = {
    enable = true;
    virtualHosts = {
      "memefinder.ru" = {
        useACMEHost = "memefinder.ru";
        locations."/".proxyPass = "http://10.3.7.40:3010/";
        locations."/api/".proxyPass = "http://10.3.7.40:3020/";
        locations."/api/static/".proxyPass = "http://10.3.7.40:3030/";
      };
    };
  };

  services.infrared = {
    enable = true;
    hosts =
      let
        offline = {
          versionName = "1.18.2";
          protocolNumber = 760;
          maxPlayers = 0;
          playersOnline = 0;
          iconPath = "/var/lib/infrared/icons/firesquare.png";
        };

        default = {
          listenTo = ":25565";
          proxyTo = "shark.n.frsqr.xyz:25565";
          proxyProtocol = true;
          disconnectMessage = "{{username}}, cервер сейчас недоступен!\nПроверь дискорд для большей информации!";
          offlineStatus = offline // { motd = "Сервер сейчас недоступен\n -> firesquare.ru"; };
        };
      in
      {
        main = default // { domainName = "firesquare.ru"; };
        srv = default // { domainName = "minecraft-proxy.frsqr.xyz"; };
        default = {
          domainName = "default";
          listenTo = ":25565";
          proxyTo = "127.0.0.1:1";
          timeout = 1;
          disconnectMessage = "Сервер не найден\nПопробуй зайти через firesquare.ru";
          offlineStatus = offline // {
            motd = "Сервер не найден\n -> firesquare.ru";
          };
        };
      };
  };

  services.yggdrasil = {
    enable = true;
    persistentKeys = true;
    config = {
      Listen = [ "tls://0.0.0.0:8362" ];
      Peers = [
        "tls://ygg.loskiq.ru:17314"
        "tls://kazi.peer.cofob.ru:18001"
        "tls://yggno.de:18227"
        "tls://box.paulll.cc:13338"
      ];
      IfName = "ygg0";
    };
  };

  networking.firewall.allowedTCPPorts = [ 8362 25565 ];

  networking = {
    hostName = "eagle";

    nebula-frsqr = {
      enable = true;
      isLighthouse = true;
    };

    nebula-averyan = {
      enable = true;
      isLighthouse = true;
    };

    defaultGateway = {
      address = "10.0.0.1";
      interface = "ens3";
    };

    interfaces = {
      ens3 = {
        ipv4 = {
          addresses = [{
            address = "185.112.83.178";
            prefixLength = 32;
          }];
        };
      };
    };
  };
}
