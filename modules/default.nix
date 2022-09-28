{ agenix, home-manager, bps, tg-captcha, ... }:

{
  imports = [
    home-manager.nixosModule
    tg-captcha.nixosModule
    agenix.nixosModule
    bps.nixosModule

    ./acme.nix
    ./backup.nix
    ./cockroach.nix
    ./cofob-ru
    ./common.nix
    ./dns.nix
    ./glusterfs.nix
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
    ./overlay.nix
    ./ssh.nix
    ./tmm
    ./unstable.nix
    ./users.nix
    ./wiki-js.nix
    ./woodpecker.nix

    ./schedulers.nix
    ./network.nix
  ];
}
