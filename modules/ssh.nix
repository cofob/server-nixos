{ pkgs, ... }:

{
  services.openssh = {
    enable = true;
    openFirewall = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
  };

  environment.systemPackages = [ pkgs.mosh ];
  networking.firewall.allowedUDPPortRanges = [{ from = 60000; to = 61000; }];
}
