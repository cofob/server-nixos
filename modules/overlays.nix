{ pkgs, nixpkgs-unstable, ... }@attrs:

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

    (final: prev:
      { mautrix-telegram = final.unstable.mautrix-telegram; })

    (final: prev: import ../overlay.nix final attrs)
  ];
}
