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

    bps = {
      url = "github:DomesticMoth/bps";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tg-captcha = {
      url = "git+https://git.frsqr.xyz/cofob/captcha?ref=main";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
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
      url = "git+https://git.frsqr.xyz/cofob/nixos";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-unstable.follows = "nixpkgs-unstable";
        home-manager.follows = "home-manager";
        agenix.follows = "agenix";
      };
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, flake-utils, agenix, home-manager, bps, tg-captcha, alex-home, cofob-home }@attrs:
    {
      nixosConfigurations = {
        eagle = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = attrs;
          modules = [
            ./eagle.nix
          ];
        };
        rat = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = attrs;
          modules = [
            ./rat.nix
          ];
        };
        beaver = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = attrs;
          modules = [
            ./beaver.nix
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
            buildInputs = [
              agenix.defaultPackage.${system}
              pkgs.nebula
            ];
          };
        });
}
