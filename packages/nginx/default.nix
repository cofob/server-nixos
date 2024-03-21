{ lib, nginxQuic, nginxModules, modules ? [ ] }:

(nginxQuic.override {
  modules = lib.unique (nginxQuic.modules ++ [ nginxModules.brotli nginxModules.zstd ] ++ modules);
}).overrideAttrs (previousAttrs: {
  patches = [
    ./patches/1-remove-version.patch
  ];
})
