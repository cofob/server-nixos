{ agenix
, home-manager
, bps
, tg-captcha
, ...
}:

{
  imports = [
    home-manager.nixosModule
    tg-captcha.nixosModules.default
    agenix.nixosModules.default
    bps.nixosModule

    ./acme.nix
    ./backup.nix
    ./telegram-backup.nix
    ./cofob-dev
    ./balance-tracker
    ./common.nix
    ./dns.nix
    ./dev-common.nix
    # ./maddy.nix
    ./nginx-defaults.nix
    ./ssh.nix
    ./tmm
    ./overlays.nix
    ./users.nix
    ./fastside.nix
  ];
}
