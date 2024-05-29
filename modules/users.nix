{ config, home-manager, cofob-home, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.cofob = cofob-home.nixosModules.home-headless;

  age.secrets.password-cofob.file = ../secrets/passwords/cofob.age;

  users = {
    users = {
      cofob = {
        isNormalUser = true;
        description = "Egor Ternovoy";
        extraGroups = [ "wheel" "libvirtd" ];
        uid = 1001;
        hashedPasswordFile = config.age.secrets.password-cofob.path;
        openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJsSKOtKRM9+bvCs6iioOrcayMdsdwaQN/lJAQJkXE+w cofob@riseup.net" ];
      };
    };
  };
}
