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
    # ./backup.nix TODO: refactor && fix
    ./users.nix
    ./acme.nix
    ./dns.nix
    ./ssh.nix
    ./tmm
  ];
}
