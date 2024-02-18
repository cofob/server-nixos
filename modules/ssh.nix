{ pkgs, ... }:

{
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings.PermitRootLogin = "no";
    settings.PasswordAuthentication = false;
  };
}
