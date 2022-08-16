{
  description = "Firesquare servers configs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    alex-home = {
      url = "github:averyanalex/nixos";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-unstable.follows = "nixpkgs-unstable";
        flake-utils.follows = "flake-utils";
        home-manager.follows = "home-manager";
        agenix.follows = "agenix";
      };
    };

    cofob-home = {
      url = "github:cofob/nixos";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
        agenix.follows = "agenix";
      };
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, flake-utils, agenix, home-manager, alex-home, cofob-home }@attrs:
    {
      nixosConfigurations = {
        example = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = attrs;
          modules = [
            ./example.nix
          ];
        };
        eagle = nixpkgs.lib.nixosSystem {
          specialArgs = attrs;
          system = "x86_64-linux";
          modules = [
            ./eagle.nix
          ];
        };
      };
    } // flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          devShells.default = pkgs.mkShell {
            nativeBuildInputs = [ agenix.defaultPackage.${system} ];
            buildInputs = [ ];
          };
        });
}
