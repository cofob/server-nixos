{ agenix
, home-manager
, bps
, tg-captcha
, erk-archive
, firesquare-ru
, ...
}:

{
  imports = [
    firesquare-ru.nixosModules.default
    erk-archive.nixosModules.default
    home-manager.nixosModule
    tg-captcha.nixosModule
    agenix.nixosModule
    bps.nixosModule

    ./backup.nix
    ./cockroach.nix
    ./cofob-ru
    ./common.nix
    ./distributed-builds.nix
    ./dns.nix
    ./docker.nix
    ./hosts.nix
    ./infrared.nix
    ./ipfs-cluster
    ./ipfs-proxy.nix
    ./ipfs.nix
    ./maddy.nix
    ./nextcloud.nix
    # ./minecraft
    # ./mineflake.nix
    ./monitoring-client.nix
    ./monitoring.nix
    ./nebula-averyan.nix
    ./nebula-frsqr.nix
    ./network.nix
    ./nftables.nix
    ./nginx
    ./schedulers.nix
    ./ssh.nix
    ./tmm
    ./overlay.nix
    ./unstable.nix
    ./users.nix
    ./wiki-js.nix
    ./woodpecker.nix
  ];
}
