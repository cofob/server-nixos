{ config, ... }:

{
  # pub: Dt4rlhaocTBlke1ATvZlKnFgmQtN1cuIp8jTrpr0RFY=
  age.secrets.wg-diamond.file = ../../../secrets/wg/diamond.age;

  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "10.100.0.2/24" ];
      privateKeyFile = config.age.secrets.wg-diamond.path;

      peers = [
        {
          publicKey = "k8XDvqLf9eZzVkY0NpAU3TXgisDAsOOtg+wImiootA8=";
          allowedIPs = [ "10.100.0.1/24" ];
          endpoint = "rat.frsqr.xyz:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
