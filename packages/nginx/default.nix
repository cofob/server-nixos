{ lib, nginxQuic, nginxModules, modules ? [ ] }:

(nginxQuic.overrideAttrs (previousAttrs: {
  extraPatches = [ ./patches/1-remove-version.patch ];
})).override {
  modules = lib.unique (nginxQuic.modules ++ [ nginxModules.brotli nginxModules.zstd ] ++ modules);
}
