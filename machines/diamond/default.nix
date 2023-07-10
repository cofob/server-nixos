{ ... }:

{
  imports = [
    ../../modules
    ../../hardware/diamond.nix
  ];

  services.zerotierone = {
    enable = true;
    joinNetworks = [ "e4da7455b237c59e" ];
  };

  networking = {
    hostName = "diamond";
  };
}
