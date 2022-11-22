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
        extraGroups = [ "wheel" ];
        uid = 1001;
        passwordFile = config.age.secrets.password-cofob.path;
        openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIETMEzhigdZelWae3V4tQ7/LXsub39SRG2X+jPMeoHMx cofob@riseup.net" ];
      };
    };
  };
}
