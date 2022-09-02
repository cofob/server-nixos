{ agenix, home-manager, bps, tg-captcha, ... }:

{
  imports = [
    home-manager.nixosModule
    tg-captcha.nixosModule
    agenix.nixosModule
    bps.nixosModule

    ./common.nix
    ./unstable.nix
    ./users.nix
    ./dns.nix
    ./nginx/default.nix
    ./acme.nix
    ./nebula.nix
    ./nftables.nix
    ./ssh.nix
    ./tmm
    ./ipfs-peers.nix
  ];
}
