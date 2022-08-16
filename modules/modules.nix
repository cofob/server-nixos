{ agenix, ... }:

{
  imports = [
    agenix.nixosModule

    ./common.nix
    ./nginx/default.nix
    ./acme.nix
  ];
}
