pkgs: inputs: {
  tg-captcha = inputs.tg-captcha.packages.${pkgs.system}.default;
  marzbanbot = inputs.marzbanbot.packages.${pkgs.system}.default;
  cofob-dev = inputs.cofob-dev.packages.${pkgs.system}.default;
  card-tracker-frontend = inputs.balance-tracker.packages.${pkgs.system}.card-tracker-frontend;
  card-tracker-backend = inputs.balance-tracker.packages.${pkgs.system}.card-tracker-backend;
  conduit = inputs.conduit.packages.${pkgs.system}.default;
  bps = let nixpkgs = import inputs.bps.inputs.nixpkgs { system = pkgs.system; }; in nixpkgs.callPackage "${inputs.bps}/package.nix" { };
  tmm = (pkgs.callPackage ./modules/tmm/package.nix { });
  fastside = inputs.fastside.packages.${pkgs.system}.default;
  fastside-services = inputs.fastside.packages.${pkgs.system}.services;
} // (import ./packages/top-level.nix { callPackage = pkgs.callPackage; })
