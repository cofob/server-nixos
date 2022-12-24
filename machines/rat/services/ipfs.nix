{ lib, config, ... }:

with lib; {
  services.kubo = {
    enable = true;
    enableGC = true;
  };

  services.ipfs-cluster = {
    enable = true;
    service = (lib.importJSON ../../../modules/ipfs-cluster/service.json) // {
      api.restapi = {
        http_listen_multiaddress = "/ip4/0.0.0.0/tcp/9094";
        ssl_cert_file = "${config.security.acme.certs."rat.frsqr.xyz".directory}/fullchain.pem";
        ssl_key_file = "${config.security.acme.certs."rat.frsqr.xyz".directory}/key.pem";
        basic_auth_credentials.default = "#BASIC_PASSWORD#";
      };
    };
  };

  security.acme.certs = {
    "rat.frsqr.xyz" = {
      group = "ipfs-cluster";
    };
  };
}
