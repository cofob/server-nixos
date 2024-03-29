{ firefox-unwrapped, fetchurl, stdenv }:

let
  original-src = firefox-unwrapped.src;
  src = stdenv.mkDerivation {
    pname = "furryfox-source";
    version = "1";
    src = original-src;
    buildPhase = ''
      find . -type f -exec sed -i 's/firefox/furryfox/g' {} +
      find . -type f -name "*firefox*" -exec bash -c 'mv "$1" "''${1//firefox/furryfox}"' _ {} \;
      find . -depth -name "*firefox*" -exec bash -c 'mv "$1" "''${1//firefox/furryfox}"' _ {} \;
    '';
    installPhase = ''
      cp -r . $out
    '';
    phases = [ "unpackPhase" "buildPhase" "installPhase" ];
  };
in
firefox-unwrapped.overrideAttrs (p: {
  pname = "furryfox";
  inherit src;
  checkPhase = "";
})
