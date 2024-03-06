{ nginxQuic, nginxModules, lib }:

nginxQuic.override {
  modules = lib.unique (nginxQuic.modules ++ [ nginxModules.brotli nginxModules.zstd ]);
  patches = (nginxQuic.patches or [ ]) ++ [
    ./remove-version.patch
  ];
}
