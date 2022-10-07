{ ... }:

{
  imports = [
    ./acme.nix
    ./backup.nix
    ./backup.nix
    ./bots.nix
    ./containers.nix
    ./db.nix
    ./gitea.nix
    ./ipfs.nix
    ./mail.nix
    ./nginx.nix
    ./syncthing.nix

    ../shared/stateless-sites.nix
  ];
}
