{ agenix, ... }:

{
  imports = [
    agenix.nixosModule

    ./common.nix
    ./nginx.nix
    ./acme.nix
  ];
}
