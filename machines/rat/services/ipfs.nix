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
    "ipfsqr.ru".extraDomainNames = [
      "*.ipfsqr.ru"
      "*.ipfs.ipfsqr.ru"
      "*.ipns.ipfsqr.ru"
      "frsqr.xyz"
      "*.frsqr.xyz"
      "firesquare.ru"
      "*.firesquare.ru"
      "cofob.ru"
      "*.cofob.ru"
    ];
    "rat.frsqr.xyz" = {
      group = "ipfs-cluster";
    };
  };

  services.fs-nginx.virtualHosts."_" = {
    useACMEHost = "ipfsqr.ru";
    locations."/".proxyPass = "http://127.0.0.1:8080/";
    extraConfig = ''
      proxy_cache global_cache;
      proxy_cache_valid 200 301 1d;
      proxy_cache_valid 404 302 30s;
      proxy_cache_use_stale error timeout updating http_500 http_502 http_503 http_504;
      proxy_cache_lock on;
      proxy_cache_revalidate on;
      proxy_cache_background_update on;
      proxy_ignore_headers "Set-Cookie";
      expires max;
      access_log off;
      proxy_cache_key $scheme$proxy_host$request_uri_path;
    '';
  };
}
