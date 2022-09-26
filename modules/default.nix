{ agenix, home-manager, bps, tg-captcha, ... }:

{
  imports = [
    home-manager.nixosModule
    tg-captcha.nixosModule
    agenix.nixosModule
    bps.nixosModule

		./overlay.nix
    ./acme.nix
    ./backup.nix
    ./cofob-ru
    ./common.nix
    ./dns.nix
    ./infrared.nix
    ./ipfs-cluster
    ./ipfs-peers.nix
    ./minecraft
    ./mineflake.nix
    ./monitoring-client.nix
    ./monitoring.nix
    ./nebula-averyan.nix
    ./nebula-frsqr.nix
    ./nftables.nix
    ./nginx
    ./ssh.nix
    ./tmm
    ./unstable.nix
    ./users.nix
    ./wiki-js.nix
    ./woodpecker.nix
  ];
}
