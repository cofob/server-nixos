{ lib, config, ... }:

with lib; {
  options.services.distributedBuilds = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkIf config.services.distributedBuilds.enable {
    age.secrets.remote-builder.file = ../secrets/credentials/remote-builder.age;

    nix = {
      buildMachines = [
        {
          sshKey = config.age.secrets.remote-builder.path;
          system = "x86_64-linux";
          sshUser = "builder";
          hostName = "beaver.n.frsqr.xyz";
          maxJobs = 3;
        }
      ];

      distributedBuilds = true;
    };
  };
}
