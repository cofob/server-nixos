{ lib, config, ... }:

with lib; {
  services.ipfs = {
    enable = true;
    enableGC = true;
    extraConfig = {
      Gateway.PublicGateways = {
        "ipfsqr.ru" = {
          Paths = [ "/ipfs" "/ipns" ];
          UseSubdomains = true;
        };
        "static.ipfsqr.ru" = {
          Paths = [ "/ipfs" "/ipns" ];
          UseSubdomains = false;
        };
      };
    };
  };

  services.ipfs-cluster = {
    enable = true;
    service = (lib.importJSON ../../modules/ipfs-cluster/service.json) // {
      api.restapi = {
        http_listen_multiaddress = "/ip4/0.0.0.0/tcp/9094";
        ssl_cert_file = "${config.security.acme.certs."rat.frsqr.xyz".directory}/fullchain.pem";
        ssl_key_file = "${config.security.acme.certs."rat.frsqr.xyz".directory}/key.pem";
        basic_auth_credentials.default = "#BASIC_PASSWORD#";
      };
    };
  };
}
