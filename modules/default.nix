{ agenix
, home-manager
, bps
, tg-captcha
, aeza-assistant
, ...
}:

{
  imports = [
    home-manager.nixosModule
    tg-captcha.nixosModules.default
    aeza-assistant.nixosModules.default
    agenix.nixosModules.default
    bps.nixosModule

    ./acme.nix
    ./backup.nix
    ./telegram-backup.nix
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
