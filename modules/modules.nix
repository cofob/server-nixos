{ agenix, ... }:

{
  imports = [
    agenix.nixosModule

    ./common.nix
    ./nginx.nix
    ./users.nix
    ./acme.nix
    ./dns.nix
  ];
}
