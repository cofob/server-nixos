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

    tg-captcha.url = "github:cofob/captcha";

    marzbanbot.url = "github:cofob/marzbanbot";

    aeza-assistant.url = "github:cofob/aeza-assistant";

    cofob-dev.url = "github:cofob/cofob.dev";

    cofob-home.url = "github:cofob/nixos";

    useit-src = {
      url = "github:xdettlaff/useit";
      flake = false;
    };
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , agenix
    , bps
    , tg-captcha
    , cofob-dev
    , cofob-home
    , ...
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
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            agenix.packages.${system}.default
            pkgs.nixpkgs-fmt
          ];
        };

        packages = {
          ci-cache = pkgs.stdenv.mkDerivation {
            name = "ci-cache";
            version = "0.1.0";
            buildInputs = [
              pkgs.zerotierone
              (pkgs.nginxQuic.override {
                modules = pkgs.lib.unique (pkgs.nginxQuic.modules ++ [pkgs.nginxModules.brotli pkgs.nginxModules.zstd]);
              })
              tg-captcha.packages.${system}.default
              cofob-dev.packages.${system}.default
              (pkgs.callPackage "${bps}/package.nix" { })
              (pkgs.callPackage ./modules/tmm/package.nix { })
            ];
            phases = [ "installPhase" ];
            installPhase = "echo 'ci-cache' > $out";
          };
        };
      });
}
