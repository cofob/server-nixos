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
    ./distributed-builds.nix
    ./dns.nix
    ./infrared.nix
    ./ipfs-cluster
    ./ipfs-peers.nix
    ./maddy.nix
    ./minecraft
    ./mineflake.nix
    ./monitoring-client.nix
    ./monitoring.nix
    ./nebula-averyan.nix
    ./nebula-frsqr.nix
    ./network.nix
    ./nftables.nix
    ./nginx
    ./overlay.nix
    ./schedulers.nix
    ./ssh.nix
    ./tmm
    ./unstable.nix
    ./users.nix
    ./wiki-js.nix
    ./woodpecker.nix
  ];
}
