{ agenix, home-manager, bps, tg-captcha, ... }:

{
  imports = [
    home-manager.nixosModule
    tg-captcha.nixosModule
    agenix.nixosModule
    bps.nixosModule

    ./nginx
    ./ipfs-peers.nix
    ./unstable.nix
    ./nftables.nix
    ./common.nix
    ./nebula-frsqr.nix
    ./nebula-averyan.nix
    # ./backup.nix TODO: refactor && fix
    ./infrared.nix
    ./wiki-js.nix
    ./users.nix
    ./acme.nix
    ./cofob-ru
    ./dns.nix
    ./ssh.nix
    ./tmm
  ];
}
