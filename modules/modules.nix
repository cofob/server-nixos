{ agenix, ... }:

{
  imports = [
    agenix.nixosModule

    ./acme.nix
    ./common.nix
    ./users.nix
  ];
}
