{ config, ... }:

{
  # pub: k8XDvqLf9eZzVkY0NpAU3TXgisDAsOOtg+wImiootA8=
  age.secrets.wg-rat.file = ../../../secrets/wg/rat.age;

  networking.firewall = {
    allowedUDPPorts = [ 51820 ];
  };

  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "10.100.0.1/24" ];
      listenPort = 51820;
      privateKeyFile = config.age.secrets.wg-rat.path;

      peers = [
        # Diamond
        {
          publicKey = "Dt4rlhaocTBlke1ATvZlKnFgmQtN1cuIp8jTrpr0RFY=";
          allowedIPs = [ "10.100.0.2/32" ];
        }
        # Backup
        {
          publicKey = "ONrFCsu8oi+Fw8X0YViWwIHIzjBJzY1E6SaKEKPKE1o=";
          allowedIPs = [ "10.100.0.3/32" ];
        }
        # Whale (averyan)
        {
          publicKey = "gd+tQKIbvpP3KnTMdE9y8ZPMvaT44d7d3tlvDRocjVU=";
          allowedIPs = [ "10.100.0.4/32" ];
        }
        # Cofob
        {
          publicKey = "/CXzueQeO1PuPG3eLjMNnArc75apmVLvYuP095NLVF4=";
          allowedIPs = [ "10.100.0.100/32" ];
        }
      ];
    };
  };
}
