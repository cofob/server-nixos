{ config, ... }:

{
  age.secrets.credentials-ipfs-proxy.file = ../../../secrets/credentials/ipfs-proxy.age;

  services.ipfs-proxy = {
    enable = true;
    envFile = config.age.secrets.credentials-ipfs-proxy.path;
  };

  security.acme.certs."ipfs.frsqr.xyz" = { };

  services.fs-nginx.virtualHosts."ipfs.frsqr.xyz" = {
    useACMEHost = "ipfs.frsqr.xyz";
    locations."/".proxyPass = "http://127.0.0.1:2314/";
  };
}
