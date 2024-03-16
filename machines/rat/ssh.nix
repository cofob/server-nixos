{ config, pkgs, ... }:

{
  # Allow to SSH into the machine over ZeroTier network
  networking.firewall.interfaces.ztwfuehebm.allowedTCPPorts = [ 22 ];
  # Close SSH port
  services.openssh.openFirewall = false;
}
