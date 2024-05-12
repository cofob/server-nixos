{ ... }:

{
  imports = [
    ./services

    ./ssh.nix

    ../../modules
    ../../hardware/incognet.nix
    ../../mounts/incognet.nix
  ];

  services.backup.enable = true;
  services.telegram-backup.enable = true;

  nixpkgs.config.allowUnfree = true;
  services.zerotierone = {
    enable = true;
    joinNetworks = [ "e4da7455b237c59e" ];
  };

  services.selfhosted-dns.enable = true;
  services.bind.extraConfig = ''
    options {
      listen-on port 53 { 23.137.249.154; };
    }
  '';

  networking = {
    hostName = "incognet";
  };
}
