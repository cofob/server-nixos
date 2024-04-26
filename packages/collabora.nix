{ stdenv, fetchgit, writeShellScriptBin, perl, pkg-config, automake, autoconf, which, fontconfig, gperf, nss, nspr, bison, flex, zip, unzip, curl, gettext, nasm }:

let
  core-src = fetchgit {
    url = "https://git.libreoffice.org/core";
    rev = "21b6572814a66527531f993de67a90481f0d66a5";
    sha256 = "sha256-QzgritzkU5mt/SjA3Ssv9pvOXvbLVA2fkRiIfFAO0NE=";
    fetchSubmodules = true;
  };

  co-src = fetchgit {
    url = "https://github.com/CollaboraOnline/online.git";
    rev = "52f00be49062e0d04e5ee29f563067c30bb1b1b9";
    sha256 = "sha256-0aBmvHW7MK3T5QHZpp5kC0sWcgM9XPBxtSZnYX9vgd0=";
    fetchSubmodules = true;
  };

  fakecurl = writeShellScriptBin "curl" ''
    echo "Requested parameters: $@"
  '';

  lokit = stdenv.mkDerivation rec {
    pname = "lokit";
    version = "1";

    src = core-src;

    buildInputs = [ fontconfig ];
    nativeBuildInputs = [ perl pkg-config automake autoconf which gperf nss nspr bison flex zip unzip fakecurl gettext nasm ];

    buildPhase = ''
      echo "lo_sources_ver=${version}" > sources.ver
      ./autogen.sh --with-distro=LibreOfficeOnline
      make -DDO_FETCH_TARBALLS=false
    '';

    installPhase = ''
      cp -a instdir $out
    '';
  };
in
lokit
# in stdenv.mkDerivation {
#   pname = "collabora-online";
#   version = "1"; # TODO

#   srcs = [co-src core-src];
#   sourceRoot = co-src.name;

#   buildPhase = ''
#     ls $src
#     lsfdsf
#   '';
# }
