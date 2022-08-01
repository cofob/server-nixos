{ agenix, ... }:

{
  imports = [
    agenix.nixosModule
    ./users.nix
  ];

  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
  };

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

  networking.nameservers = [ "8.8.8.8" "9.9.9.9" ];

  system = {
    stateVersion = "22.05";
    autoUpgrade = {
      enable = true;
      allowReboot = false;
      flake = "github:fire-square/nixos";
      dates = "4:45";
    };
  };

  nix = {
    useSandbox = true;
    autoOptimiseStore = true;
    readOnlyStore = true;
    allowedUsers = [ "@wheel" "@users" ];
    trustedUsers = [ "@wheel" ];
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d --max-freed $((64 * 1024**3))";
    };
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
  };
}
