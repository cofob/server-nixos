{
  description = "Firesquare servers configs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";

    flake-utils.url = "github:numtide/flake-utils";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, flake-utils, agenix }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShell = pkgs.mkShell {
          nativeBuildInputs = [ agenix.defaultPackage.${system} ];
          buildInputs = [ ];
        };
      });
}
