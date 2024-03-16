{ config, pkgs, ... }:

{
  services.postgresql = {
    enable = true;

    ensureUsers = [
      {
        name = "mautrix-telegram";
        ensureDBOwnership = true;
      }
    ];
    ensureDatabases = [
      "mautrix-telegram"
    ];
  };
}
