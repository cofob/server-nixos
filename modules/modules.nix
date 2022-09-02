{ agenix, home-manager, bps, tg-captcha, ... }:

{
  imports = [
    home-manager.nixosModule
    tg-captcha.nixosModule
    agenix.nixosModule
    bps.nixosModule

    ./nginx/default.nix
    ./ipfs-peers.nix
    ./unstable.nix
    ./nftables.nix
    ./common.nix
    ./nebula.nix
    ./backup.nix
    ./users.nix
    ./acme.nix
    ./dns.nix
    ./ssh.nix
    ./tmm
  ];
}
