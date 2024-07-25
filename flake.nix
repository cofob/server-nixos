{
  description = "Cofob server configs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    bps.url = "github:DomesticMoth/bps";

    tg-captcha.url = "github:cofob/captcha";

    cofob-dev.url = "github:cofob/cofob.dev";

    balance-tracker = {
      url = "github:cofob/transport-card-balance-tracker";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    cofob-home = {
      url = "github:cofob/nixos";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    useit-src = {
      url = "github:xdettlaff/useit";
      flake = false;
    };

    conduit = {
      url = "gitlab:famedly/conduit";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    fastside.url = "github:cofob/fastside";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , agenix
    , bps
    , tg-captcha
    , cofob-dev
    , balance-tracker
    , cofob-home
    , conduit
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

      overlays.default = final: prev: (import ./overlay.nix final attrs);
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
            pname = "ci-cache";
            version = "0.1.0";
            buildInputs = (
              [
                pkgs.zerotierone # zerotier is unfree and not built in nixpkgs cache
              ] ++
              builtins.attrValues (import ./overlay.nix pkgs attrs)
            );
            phases = [ "installPhase" ];
            installPhase = "echo 'ci-cache' > $out";
          };

          system-cache = pkgs.stdenv.mkDerivation {
            pname = "system-cache";
            version = "0.1.0";
            buildInputs = builtins.map
              (key:
                (nixpkgs.lib.nixosSystem {
                  system = "x86_64-linux";
                  specialArgs = attrs;
                  modules = [
                    ./machines/${key}
                  ];
                }).config.system.build.toplevel
              )
              (builtins.attrNames (builtins.readDir ./machines));
            phases = [ "installPhase" ];
            installPhase = "echo 'system-cache' > $out";
          };
        } // (import ./overlay.nix pkgs attrs);
      });
}
