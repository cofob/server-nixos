{ agenix, ... }:

{
  imports = [
    agenix.nixosModule

    ./acme.nix
    ./common.nix
    ./nginx.nix
    ./users.nix
  ];
}
