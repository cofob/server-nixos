{ cinny
, stdenv
, gzip
, brotli
, conf ? {
    defaultHomeserver = 0;
    homeserverList = [ "cofob.dev" ];
    allowCustomHomeservers = true;
    hashRouter.enabled = true;
    hashRouter.basename = "/";
  }
}:

let
  cinny-configured = cinny.override {
    conf = conf;
  };
in
stdenv.mkDerivation {
  pname = "cinny-compressed";
  version = cinny-configured.version;

  src = cinny-configured;

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
