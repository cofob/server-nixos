{ pkgs, config, lib, ... }:

{
  boot = {
    cleanTmpDir = true;
    tmpOnTmpfs = true;
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

  system = {
    stateVersion = "22.05";
    autoUpgrade = {
      enable = true;
      allowReboot = false;
      flake = "git+https://git.frsqr.xyz/firesquare/nixos.git?ref=main";
      dates = "4:45";
    };
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      allowed-users = [ "@users" ];
      trusted-users = [ "@wheel" ]
        ++ (lib.optional (config.networking.hostName == "beaver") "builder");
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
      sudo rm -rf /root/.cache && sudo nixos-rebuild switch --flake "git+https://git.frsqr.xyz/firesquare/nixos.git?ref=main"
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
