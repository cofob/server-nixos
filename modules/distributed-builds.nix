{ lib, config, ... }:

with lib; {
  options.services.distributedBuilds = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkIf (config.services.distributedBuilds.enable && config.networking.hostName != "beaver") {
    age.secrets.remote-builder.file = ../secrets/credentials/remote-builder.age;

    programs.ssh.knownHosts =
      let
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHKoFVvggf2o3DQsvdAKrfbGMVnly6AmzW/Sebt+1fUW"; in
      {
        "beaver".publicKey = key;
      };

    nix = {
      buildMachines = [
        {
          sshKey = config.age.secrets.remote-builder.path;
          system = "x86_64-linux";
          sshUser = "builder";
          hostName = "beaver";
          maxJobs = 3;
          supportedFeatures = [
            "big-parallel"
          ];
        }
      ];

      distributedBuilds = true;
    };
  };
}
