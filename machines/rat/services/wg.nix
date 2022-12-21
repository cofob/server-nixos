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
        {
          publicKey = "Dt4rlhaocTBlke1ATvZlKnFgmQtN1cuIp8jTrpr0RFY=";
          allowedIPs = [ "10.100.0.2/32" ];
        }
        {
          publicKey = "ONrFCsu8oi+Fw8X0YViWwIHIzjBJzY1E6SaKEKPKE1o=";
          allowedIPs = [ "10.100.0.3/32" ];
        }
      ];
    };
  };
}
