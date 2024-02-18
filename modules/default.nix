{ agenix
, home-manager
, bps
, tg-captcha
, ...
}:

{
  imports = [
    home-manager.nixosModule
    tg-captcha.nixosModule
    agenix.nixosModules.default
    bps.nixosModule

    ./acme.nix
    ./backup.nix
    ./cofob-dev
    ./common.nix
    ./dns.nix
    # ./maddy.nix
    ./nftables.nix
    ./ssh.nix
    ./tmm
    ./users.nix
  ];
}
