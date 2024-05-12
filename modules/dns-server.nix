{ lib, config, self, ... }:

let
  cfg = config.services.selfhosted-dns;
in
{
  options = {
    services.selfhosted-dns = {
      enable = lib.mkEnableOption "Whether to enable self hosted dns server";
    };
  };

  config = lib.mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [ 53 ];
    networking.firewall.allowedUDPPorts = [ 53 ];

    age.secrets.zones-cofob-dev.file = "${self}/secrets/zones/cofob.dev.age";
    age.secrets.zones-cofob-dev.mode = "777";

    services.bind = {
      enable = true;
      zones = {
        "cofob.dev" = {
          master = true;
          file = config.age.secrets.zones-cofob-dev.path;
        };
      };
    };
  };
}
