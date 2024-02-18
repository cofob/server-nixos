{
  networking.nat = {
    enable = true;
    internalInterfaces = ["ve-+"];
    externalInterface = "ens3";
  };

  containers.uptime-kuma = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "192.168.100.10";
    localAddress = "192.168.100.11";
                
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
}
