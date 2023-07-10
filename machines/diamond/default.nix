{ ... }:

{
  imports = [
    ../../modules
    ../../hardware/diamond.nix
  ];

  nixpkgs.config.allowUnfree = true;
  services.zerotierone = {
    enable = true;
    joinNetworks = [ "e4da7455b237c59e" ];
  };

  networking = {
    hostName = "diamond";
  };
}
