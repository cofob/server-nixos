{ lib
, stdenv
, fetchgit
, fetchurl
, writeShellScriptBin
, perl
, pkg-config
, automake
, autoconf
, which
, fontconfig
, gperf
, nss
, nspr
, bison
, flex
, zip
, unzip
, curl
, gettext
, nasm
, boost
, ant
, cups
, jre17_minimal
, jdk17
, libjpeg
, clucene_core_2
, expat
, libxml2
, librevenge
, libodfgen
, libwpd
, libwpg
, libwps
, libvisio
, libcdr
, libmwaw
, libe-book
, libabw
, libzmf
, lcms
, cppunit
, python3
, libmysqlclient
, postgresql
, glm
, libxslt
, unixODBC
, openldap
, sane-backends
, icu
, xorg
 ,   librdf_redland
,hunspell
, box2d
, mythes
, CoinMP
, libexttextcat
, libepoxy
, cairo
, glib
, gtk3
, bluez5
, gst_all_1
, openjpeg
, abseil-cpp
, poppler
, gpgme
, bsh
, libwebp
, gdb
}:

let
  inherit (lib) getDev getLib flip concatMapStrings;

  jre' = jre17_minimal.override {
    modules = [ "java.base" "java.desktop" "java.logging" "java.sql" ];
  };

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

  # fakecurl = writeShellScriptBin "curl" ''
  #   echo "Requested parameters: $@"
  # '';

  tarballPath = "external/tarballs";

  deps = import ./deps.nix;

  srcs = {
    third_party = map (x:
      (fetchurl {
        inherit (x) url sha256 name;
      }) // {
        inherit (x) md5name md5;
      }) deps;
  };

  lokit = stdenv.mkDerivation rec {
    pname = "lokit";
    version = "1";

    src = core-src;

    postUnpack = ''
      mkdir -v $sourceRoot/${tarballPath}
    '' + (flip concatMapStrings srcs.third_party (f: ''
      ln -sfv ${f} $sourceRoot/${tarballPath}/${f.md5name}
      ln -sfv ${f} $sourceRoot/${tarballPath}/${f.name}
    ''));

    nativeBuildInputs = [ jdk17 gdb ];
    buildInputs = with xorg; [
      fontconfig
      perl
      pkg-config
      automake
      autoconf
      which
      gperf
      cppunit
      nss
      nspr
      bison
      flex
      zip
      unzip
      gettext
      nasm
      cups
      boost
      jre'
      libjpeg
      clucene_core_2
      expat
      libxml2
      librevenge
      libodfgen
      libwpd
      libwpg
      libwps
      libvisio
      libcdr
      libmwaw
      libe-book
      libabw
      libzmf
      lcms
      python3
      libmysqlclient
      postgresql
      glm
      libxslt
      unixODBC
      openldap
      sane-backends
      icu
      libX11
      libXaw
      libXdmcp
      libXext
      libXi
      libXinerama
      libXtst
      libXrender
      xrandr
      libXrandr
      librdf_redland
      hunspell
      box2d
      mythes
      CoinMP
      libexttextcat
      libepoxy
      cairo
      glib
      gtk3
      bluez5
      openjpeg
      abseil-cpp
      poppler
      gpgme
      libwebp
      ant
    ] ++ (with gst_all_1; [
      gst-libav
      gst-plugins-bad
      gst-plugins-base
      gst-plugins-good
      gst-plugins-ugly
      gstreamer
    ]);

    preConfigure = ''
      configureFlagsArray=(
        "--with-parallelism=$NIX_BUILD_CORES"
      );

      NOCONFIGURE=1 ./autogen.sh
    '';

    configureFlags = [
      "--with-boost=${getDev boost}"
      "--with-boost-libdir=${getLib boost}/lib"
      "--with-beanshell-jar=${bsh}"
      "--with-ant-home=${getLib ant}/lib/ant"
      # "--with-beanshell-jar=${bsh}"
      "--with-vendor=NixOS"
      "--disable-report-builder"
      "--disable-online-update"
      "--enable-python=system"
      "--enable-release-build"
      "--enable-epm"
      "--with-system-cairo"
      "--with-system-libs"
      "--with-system-headers"
      "--with-system-openssl"
      "--with-system-libabw"
      "--with-system-libwps"
      "--with-system-openldap"
      "--with-system-coinmp"
      "--with-system-postgresql"

      # Without these, configure does not finish
      "--without-junit"

      # Schema files for validation are not included in the source tarball
      "--without-export-validation"

      # We do tarball prefetching ourselves
      "--disable-fetch-external"

      "--without-system-xmlsec"
      "--without-system-libepubgen"
      "--without-system-libmspub"
      "--without-system-libetonyek"
      "--without-system-libfreehand"
      "--without-system-libpagemaker"
      "--without-system-libqxp"
      "--without-system-libstaroffice"
      "--without-system-dragonbox"
      "--without-system-libfixmath"
      "--without-system-orcus"
      "--without-system-mdds"
      "--without-system-zxing"
      "--without-system-altlinuxhyph"
      "--without-system-lpsolve"
      "--without-system-libnumbertext"
      "--without-system-liblangtag"
      "--without-system-libcmis"

      "--disable-firebird-sdbc"
    ];

    postConfigure = ''
      echo "lo_sources_ver=${version}" > sources.ver
      cp ${./a} ./solenv/bin/install-gdb-printers
      chmod +x ./solenv/bin/install-gdb-printers
    '';

    # buildPhase = ''
    #   head -n 10 ./solenv/bin/install-gdb-printers
    #   fhjdjhkjdsfhkjdsh
    # '';

    installPhase = ''
      cp -a instdir $out
    '';
  };
in
lokit
# lokit
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
