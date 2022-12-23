{ lib, config, ... }:

with lib; {
  services.kubo = {
    enable = true;
    enableGC = true;
    settings = {
      Gateway.PublicGateways = {
        "ipfsqr.ru" = {
          Paths = [ "/ipfs" ];
          UseSubdomains = false;
        };
      };
    };
  };

  services.ipfs-cluster = {
    enable = true;
    service = (lib.importJSON ../../../modules/ipfs-cluster/service.json) // {
      api.restapi = {
        http_listen_multiaddress = "/ip4/127.0.0.1/tcp/9094";
        ssl_cert_file = "${config.security.acme.certs."rat.frsqr.xyz".directory}/fullchain.pem";
        ssl_key_file = "${config.security.acme.certs."rat.frsqr.xyz".directory}/key.pem";
        basic_auth_credentials.default = "#BASIC_PASSWORD#";
      };
    };
  };

  age.secrets.credentials-ipfs-proxy.file = ../../../secrets/credentials/ipfs-proxy.age;
  services.ipfs-proxy = {
    enable = true;
    envFile = config.age.secrets.credentials-ipfs-proxy.path;
  };

  security.acme.certs = {
    "ipfs.frsqr.xyz" = { };
    "rat.frsqr.xyz" = {
      group = "ipfs-cluster";
    };
  };

  services.fs-nginx.virtualHosts."ipfs.frsqr.xyz" = {
    useACMEHost = "ipfs.frsqr.xyz";
    locations."/".proxyPass = "http://127.0.0.1:2314/";
    onlyCloudflare = true;
  };
}
