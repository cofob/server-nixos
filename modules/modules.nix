{ agenix, home-manager, bps, ... }:

{
  imports = [
    home-manager.nixosModule
    agenix.nixosModule
    bps.nixosModule

    ./common.nix
    ./users.nix
    ./dns.nix
    ./nginx/default.nix
    ./acme.nix
    ./nebula.nix
    ./nftables.nix
    ./ssh.nix
  ];
}
