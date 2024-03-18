pkgs: inputs: {
  nginx = (pkgs.nginxQuic.override {
    modules = pkgs.lib.unique (pkgs.nginxQuic.modules ++ [ pkgs.nginxModules.brotli pkgs.nginxModules.zstd ]);
  });
  tg-captcha = inputs.tg-captcha.packages.${pkgs.system}.default;
  marzbanbot = inputs.marzbanbot.packages.${pkgs.system}.default;
  aeza-assistant = inputs.aeza-assistant.packages.${pkgs.system}.default;
  cofob-dev = inputs.cofob-dev.packages.${pkgs.system}.default;
  card-tracker-frontend = inputs.balance-tracker.packages.${pkgs.system}.card-tracker-frontend;
  card-tracker-backend = inputs.balance-tracker.packages.${pkgs.system}.card-tracker-backend;
  conduit = inputs.conduit.packages.${pkgs.system}.default;
  bps = (pkgs.callPackage "${inputs.bps}/package.nix" { });
  tmm = (pkgs.callPackage ./modules/tmm/package.nix { });
} // (import ./packages/top-level.nix { callPackage = pkgs.callPackage; })
