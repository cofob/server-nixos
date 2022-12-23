{ ... }:

{
  imports = [
    ./wg.nix
    ./bots.nix
    ./bw.nix
    #./gitea.nix
    ./proxy.nix
    ./ipfs.nix
    ./ipfs-proxy.nix
    ./mail.nix
    ./wiki-js.nix
  ];
}
