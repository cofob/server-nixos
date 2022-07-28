{ args, config, lib, pkgs, ... }:

{
  imports = [ ./users.nix ];

  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
  };

  system.stateVersion = "22.05";

  users.mutableUsers = false;
}
