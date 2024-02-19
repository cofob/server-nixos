{ lib, pkgs, config, ... }:

{
  config = {
    services.nginx = {
      # Enable QUIC support for nginx
      package = lib.mkDefault pkgs.nginxQuic;

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
    };
  };
}
