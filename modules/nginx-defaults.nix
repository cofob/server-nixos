{ lib, pkgs, config, ... }:

{
  config = {
    services.nginx = {
      # Enable QUIC support for nginx
      package = pkgs.nginx;

      # Reload service instead of restart on nixos switch
      enableReload = true;
      # Enable QUIC connection migration
      enableQuicBPF = true;

      # Enable recommended settings
      recommendedGzipSettings = true;
      recommendedZstdSettings = true;
      recommendedTlsSettings = true;
      recommendedProxySettings = true;
      recommendedOptimisation = true;
      recommendedBrotliSettings = true;

      # Stub site
      virtualHosts."default" = {
        serverName = "_";
        listen = lib.mkForce [
          {
            addr = "0.0.0.0";
            port = 80;
            extraParameters = [ "default_server" ];
          }
          {
            addr = "[::0]";
            port = 80;
            extraParameters = [ "default_server" ];
          }
          {
            addr = "0.0.0.0";
            port = 443;
            ssl = true;
            extraParameters = [ "default_server" ];
          }
          {
            addr = "[::0]";
            port = 443;
            ssl = true;
            extraParameters = [ "default_server" ];
          }
          {
            addr = "0.0.0.0";
            port = 443;
            extraParameters = [ "default_server" "quic" ];
          }
          {
            addr = "[::0]";
            port = 443;
            extraParameters = [ "default_server" "quic" ];
          }
        ];
        extraConfig = ''
          ssl_certificate ${pkgs.default-ssl-cert}/cert.pem;
          ssl_certificate_key ${pkgs.default-ssl-cert}/key.pem;
        '';
        locations."/".return = "403";
      };
    };
  };
}
