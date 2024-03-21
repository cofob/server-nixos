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
    services.openssh.extraConfig = ''
      AuthorizedKeysCommand /vsa
      AuthorizedKeysCommandUser vsa
    '';
  };
}
