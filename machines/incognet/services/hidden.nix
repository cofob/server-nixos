{ config, ... }:

{
  services.i2pd = {
    enable = true;
    port = 41782;
    proto.http.enable = true;
    proto.httpProxy = {
      enable = true;
      outbound.length = 1;
      inbound.length = 1;
    };
    inTunnels.fastside = {
      enable = true;
      port = 8080;
      inPort = 80;
      address = "127.0.0.1";
      destination = "127.0.0.1";
      outbound.length = 1;
      inbound.length = 1;
    };
  };

  services.tor = {
    enable = true;
    enableGeoIP = false;
    openFirewall = true;
    relay = {
      enable = true;
      role = "relay";
      onionServices.fastside = {
        version = 3;
        map = [{
          port = 80;
          target = {
            addr = "127.0.0.1";
            port = 8080;
          };
        }];
      };
    };
    settings = {
      ContactInfo = "tor@cofob.dev";
      Nickname = "cofob";
      ORPort = 9001;
      ControlPort = 9051;
      BandWidthRate = "1 MBytes";
    };
  };

  services.yggdrasil = {
    enable = true;
    persistentKeys = true;
    settings = {
      IfName = "ygg0";
      NodeInfoPrivacy = true;
      NodeInfo = {
        name = "host.cofob.dev";
      };
      Peers = [
        "tcp://vpn.itrus.su:7991"
        "tcp://s-ams-0.sergeysedoy97.ru:65533"
        "tcp://79.137.194.94:65533"
        "tcp://s-ams-1.sergeysedoy97.ru:65533"
        "tcp://srv.itrus.su:7991"
        "tcp://ygg-msk-1.averyan.ru:8363"
        "tcp://37.186.113.100:1514"
        "tcp://ygg-uplink.thingylabs.io:80"
      ];
    };
  };

  networking.firewall = {
    allowedTCPPorts = [ config.services.i2pd.port ];
    allowedUDPPorts = [ config.services.i2pd.port ];
  };
}
