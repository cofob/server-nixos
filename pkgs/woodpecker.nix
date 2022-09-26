{ callPackage, buildGoModule, fetchFromGitHub, nodejs, ... }:

let
  bp = callPackage
    (fetchFromGitHub {
      owner = "serokell";
      repo = "nix-npm-buildpackage";
      hash = "sha256-Kg8u2ekU0+MsuLzgKqiaus3HquLLo2Qq+oGbQfIppos=";
      rev = "cab951dd024dd367511d48440de6f93664ee35aa";
    })
    { };

  version = "0.15.4";

  woodpecker-src = fetchFromGitHub {
    repo = "woodpecker";
    owner = "woodpecker-ci";
    rev = "v${version}";
    hash = "sha256-rDQjTSw1exq5jOeTg8R9lceR/2St6Ha0EBMweX5foUQ=";
  };

  woodpecker-web = bp.buildYarnPackage {
    src = "${woodpecker-src}/web";
    installPhase = ''
      yarn build
      cp -r dist $out/
    '';
  };

  woodpecker = buildGoModule rec {
    pname = "woodpecker";
    inherit version;

    src = woodpecker-src;

    preBuild = "cp -r ${woodpecker-web} web/dist";

    vendorSha256 = null;

    doCheck = false;

    meta = {
      description = "Woodpecker is a community fork of the Drone CI system.";
      homepage = "https://github.com/woodpecker-ci/woodpecker";
    };
  };
in
woodpecker
