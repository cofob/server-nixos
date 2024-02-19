{ pkgs, config, lib, ... }:

{
  boot.tmp = {
    useTmpfs = true;
    cleanOnBoot = true;
  };

  services.fstrim.enable = true;

  environment.pathsToLink = [ "/share/zsh" ];

  security.sudo.wheelNeedsPassword = false;

  users.mutableUsers = false;

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  services.earlyoom.enable = true;

  virtualisation.oci-containers.backend = "docker";

  system = {
    stateVersion = "23.11";
    autoUpgrade = {
      enable = true;
      allowReboot = false;
      flake = "github:cofob/server-nixos";
      dates = "4:45";
    };
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      allowed-users = [ "@users" ];
      trusted-users = [ "@wheel" ];
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://cofob.cachix.org"
      ];
      trusted-public-keys = [
        "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cofob.cachix.org-1:pLP85fVQ2T+bbaggvq03aDdXbQWjY36Gkch14N8mus4="
      ];
    };

    daemonCPUSchedPolicy = "batch";
    daemonIOSchedPriority = 5;

    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';

    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };

    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
  };

  environment.systemPackages = with pkgs; let
    upgrade-system = pkgs.writeScriptBin "upgrade-system" ''
      sudo rm -rf /root/.cache && sudo nixos-rebuild switch --flake "github:cofob/server-nixos"
    '';
  in
  [
    git
    vim
    htop
    ncdu
    tmux
    wget
    ffsend
    pastebinit
    upgrade-system
  ];

  networking.firewall.trustedInterfaces = [ "lo" ];
}
