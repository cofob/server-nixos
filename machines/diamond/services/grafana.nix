{ config, prom-exporters, ... }:

{
  services.fs-monitoring.enable = true;

  age.secrets.credentials-w3-exporter.file = ../../../secrets/credentials/w3-exporter.age;
  systemd.services.w3-exporter = {
    description = "W3 Exporter";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      ExecStart = "${prom-exporters.packages.x86_64-linux.web3-storage}/bin/web3-storage";
      Restart = "always";
      RestartSec = 5;
      EnvironmentFile = config.age.secrets.credentials-w3-exporter.path;
    };
  };
}
