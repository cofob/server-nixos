{
  description = "Firesquare servers configs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";
    nur.url = "github:nix-community/NUR";

    pkgs-overlay = {
      url = "git+https://git.frsqr.xyz/firesquare/nur?ref=main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    mineflake = {
      url = "git+https://git.frsqr.xyz/firesquare/mineflake?ref=main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tg-captcha = {
      url = "git+https://git.frsqr.xyz/cofob/captcha?ref=main";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };

    firesquare-ru = {
      url = "git+https://git.frsqr.xyz/firesquare/frontend?ref=main";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };

    cofob-ru = {
      url = "git+https://git.frsqr.xyz/cofob/cofob.ru?ref=main";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };

    alex-home = {
      url = "git+https://git.frsqr.xyz/averyanalex/nixos?ref=main";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-unstable.follows = "nixpkgs-unstable";
        flake-utils.follows = "flake-utils";
        nur.follows = "nur";
        home-manager.follows = "home-manager";
        agenix.follows = "agenix";
      };
    };

    cofob-home = {
      url = "git+https://git.frsqr.xyz/cofob/nixos";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-unstable.follows = "nixpkgs-unstable";
        nur.follows = "nur";
        home-manager.follows = "home-manager";
        agenix.follows = "agenix";
      };
    };
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-unstable
    , flake-utils
    , nur
    , pkgs-overlay
    , agenix
    , home-manager
    , bps
    , mineflake
    , tg-captcha
    , cofob-ru
    , firesquare-ru
    , alex-home
    , cofob-home
    }@attrs:
    {
      nixosConfigurations =
        builtins.mapAttrs
          (key: value: (
            nixpkgs.lib.nixosSystem {
              system = "x86_64-linux";
              specialArgs = attrs;
              modules = [
                ./machines/${key}
              ];
            }
          ))
          (builtins.readDir ./machines);
    } // flake-utils.lib.eachSystem (with flake-utils.lib.system; [ x86_64-linux i686-linux aarch64-linux ])
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
