{ config, ... }:

{
  age.secrets.credentials-botosusl.file = ../../../secrets/credentials/botosusl.age;

  virtualisation.oci-containers.containers.botosusl = {
    image = "phasecorex/red-discordbot";
    volumes = [
      "/var/lib/botosusl:/data"
    ];
    environmentFiles = [
      config.age.secrets.credentials-botosusl.path
    ];
  };

  services.backup.timers.daily = [
    "botosusl.pxar:/var/lib/botosusl"
  ];
}
