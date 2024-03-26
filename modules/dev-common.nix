{ config, lib, pkgs, ... }:

with lib; let
  cfg = config.services.dev-common;
in
{
  options.services.dev-common = {
    enable = mkEnableOption "Enable common dev settings";
  };

  config = mkIf cfg.enable {
    virtualisation.docker.enable = true;
    users.users.cofob.extraGroups = [ "docker" ];

    virtualisation.libvirtd.enable = true;

    users.users.vsa = {
      isSystemUser = true;
      group = "vsa";
      extraGroups = [ "libvirtd" "docker" ];
    };
    users.groups.vsa = { };
    users.users.authtest = {
      isNormalUser = true;
    };
    users.users.vsa.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJoom8IYgBFUrr2zvdek84Jqy6U55dEe66Ef0/eQncHL dev1"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGq5rNoRtbYEa3G1uebvsFLieZC/SMq4fNE0SDMooClY dev2"
    ];
    services.openssh.extraConfig = ''
      AuthorizedKeysCommand /vsa
      AuthorizedKeysCommandUser vsa
    '';
  };
}
