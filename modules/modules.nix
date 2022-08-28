{ agenix, home-manager, dnsbot, bps, tg-captcha, ... }:

{
  imports = [
    home-manager.nixosModule
    tg-captcha.nixosModule
    agenix.nixosModule
    dnsbot.nixosModule
    bps.nixosModule

    ./common.nix
    ./users.nix
    ./dns.nix
    ./nginx/default.nix
    ./acme.nix
    ./nebula.nix
    ./nftables.nix
    ./ssh.nix
    ./tmm
  ];
}
