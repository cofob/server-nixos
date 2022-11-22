{
  description = "Firesquare servers configs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";

    nur.url = "github:nix-community/NUR";

    pkgs-overlay = {
      url = "github:cofob/nixos-pkgs";
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

    bps.url = "github:DomesticMoth/bps";

    mineflake.url = "github:nix-community/mineflake";

    tg-captcha.url = "github:cofob/captcha";

    erk-archive.url = "github:cofob/erk-archive";

    firesquare-ru.url = "github:cofob/2bu2t-frontend";

    cofob-ru.url = "github:cofob/cofob.ru";

    cofob-home = {
      url = "github:cofob/nixos";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
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
    , erk-archive
    , cofob-ru
    , firesquare-ru
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
