{ lib, ... }:

{
  networking.nat = {
    enable = true;
    internalInterfaces = ["ve-+"];
    externalInterface = "ens3";
  };

  containers.perchun-uptime-kuma = {
    ephemeral = true;
    autoStart = true;
    privateNetwork = true;
    hostAddress = "192.168.100.10";
    localAddress = "192.168.100.11";

    bindMounts = {
      "/var/lib/uptime-kuma" = {
        hostPath = "/var/lib/perchun-uptime-kuma";
        isReadOnly = false;
      };
    };
                
    config = { lib, ... }: {
      services.uptime-kuma.enable = true;  
      services.uptime-kuma.settings = { HOST = "0.0.0.0"; };  

      networking = {  
        firewall = {
          enable = true;
          allowedTCPPorts = [ 3001 ];
        };
        useHostResolvConf = lib.mkForce false;
      };  
      services.resolved.enable = true;

      system.stateVersion = "23.11";  
    };
  };

  services.nginx.enable = lib.mkDefault true;
  services.nginx.virtualHosts."kuma.perchun.it" = {
    enableACME = true;
    quic = true;
    http3 = true;
    kTLS = true;
    forceSSL = true;
    locations."/".proxyPass = "http://192.168.100.11:3001/";
  };
}
