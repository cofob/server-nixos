{ config, home-manager, alex-home, cofob-home, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.alex = alex-home.nixosModules.home-headless;
  home-manager.users.cofob = cofob-home.nixosModules.home-headless;

  age.secrets.password-alex.file = ../secrets/passwords/alex.age;
  age.secrets.password-cofob.file = ../secrets/passwords/cofob.age;

  users = {
    users = {
      alex = {
        isNormalUser = true;
        description = "Alexander Averyanov";
        extraGroups = [ "wheel" ];
        uid = 1000;
        passwordFile = config.age.secrets.password-alex.path;
        openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINF5KDy1T6Z+RlDb+Io3g1uSZ46rhBxhNE39YlG3GPFM alex@averyan.ru" ];
      };
      cofob = {
        isNormalUser = true;
        description = "Egor Ternovoy";
        extraGroups = [ "wheel" ];
        uid = 1001;
        passwordFile = config.age.secrets.password-cofob.path;
        openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIETMEzhigdZelWae3V4tQ7/LXsub39SRG2X+jPMeoHMx cofob@riseup.net" ];
      };
    };
  };
}
