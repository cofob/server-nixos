{ cinny
, stdenv
, gzip
, brotli
}:

in
stdenv.mkDerivation {
  pname = "cinny-compressed";
  version = cinny.version;

  src = cinny;

  buildInputs = [ gzip brotli ];

  buildPhase = ''
    # compress static
    find . -type f -print0 | xargs -0 -I{} -P $(nproc) \
      sh -c "gzip -c --best {} > {}.gz && brotli -c --best {} > {}.br"
  '';

  installPhase = ''
    cp -r . $out
  '';
}
