{ agenix, home-manager, ... }:

{
  imports = [
    home-manager.nixosModule
    agenix.nixosModule

    ./common.nix
    ./users.nix
    ./dns.nix
    ./nginx/default.nix
    ./acme.nix
    ./nebula.nix
  ];
}
