{
  description = "Cofob server configs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    flake-utils.url = "github:numtide/flake-utils";

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    bps = {
      url = "github:DomesticMoth/bps";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tg-captcha = {
      url = "github:cofob/captcha";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    cofob-dev.url = "github:cofob/cofob.dev";

    cofob-home.url = "github:cofob/nixos";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , agenix
    , home-manager
    , bps
    , tg-captcha
    , cofob-dev
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
            agenix.packages.${system}.default
            pkgs.nixpkgs-fmt
          ];
        };
      });
}
