{ mineflake, config, pkgs, ... }:

{
  imports = [
    mineflake.nixosModules.default
  ];

  config = {
    nixpkgs.overlays = [ mineflake.overlays.default ];
  };
}
