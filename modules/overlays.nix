{ pkgs, nixpkgs-unstable, ... }:

{
  nixpkgs.overlays = [
    (final: prev:
      {
        unstable = import nixpkgs-unstable {
          system = pkgs.system;
          # config.allowUnfree = true;
        };
      }
    )
  ];
}
