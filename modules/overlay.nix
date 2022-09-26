{ pkgs-overlay, ... }:

{
  nixpkgs.overlays = [ pkgs-overlay.overlays.default ];
}
