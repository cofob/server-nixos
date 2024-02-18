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
    ./cofob-dev
    ./common.nix
    ./dns.nix
    # ./maddy.nix
    ./ssh.nix
    ./tmm
    ./overlays.nix
    ./users.nix
  ];
}
