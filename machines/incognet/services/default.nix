{ ... }:

{
  imports = [
    ./bots.nix
    ./bw.nix
    ./db.nix
    ./web.nix
    ./dns-server
    ./perchun-kuma.nix
  ];
}
