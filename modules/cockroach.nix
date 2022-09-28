{ lib, config, pkgs, ... }:

with lib; {
  options.services.cockroachdb = {
    crtFile = mkOption {
      type = types.path;
      description = "Path to node crt";
    };
    keyFile = mkOption {
      type = types.path;
      description = "Path to node key";
    };
    rootCrtFile = mkOption {
      type = types.path;
      default = config.age.secrets.cockroach-root-crt.path;
      description = "Path to node crt";
    };
    rootKeyFile = mkOption {
      type = types.path;
      default = config.age.secrets.cockroach-root-key.path;
      description = "Path to node key";
    };
  };

  config = mkIf config.services.cockroachdb.enable {
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "cockroach"
    ];

    services.cockroachdb.certsDir = "/var/lib/cockroachdb/certs";

    age.secrets.cockroach-ca-crt.file = ../secrets/cockroach/ca-crt.age;
    age.secrets.cockroach-root-crt.file = ../secrets/cockroach/root-crt.age;
    age.secrets.cockroach-root-key.file = ../secrets/cockroach/root-key.age;
    age.secrets.cockroach-ca-crt.owner = config.services.cockroachdb.user;
    age.secrets.cockroach-root-crt.owner = config.services.cockroachdb.user;
    age.secrets.cockroach-root-key.owner = config.services.cockroachdb.user;

    systemd.services.cockroachdb-prepare = {
      requiredBy = [ "cockroachdb.service" ];
      wantedBy = [ "cockroachdb.service" ];
      script = ''
        rm -rf certs/
        mkdir certs/
        cp ${config.age.secrets.cockroach-ca-crt.path} certs/ca.crt
        cp ${config.services.cockroachdb.keyFile} certs/node.key
        cp ${config.services.cockroachdb.crtFile} certs/node.crt
        cp ${config.services.cockroachdb.rootKeyFile} certs/client.root.key
        cp ${config.services.cockroachdb.rootCrtFile} certs/client.root.crt
      '';
      serviceConfig = {
        Type = "oneshot";
        StateDirectory = "cockroachdb";
        WorkingDirectory = "/var/lib/cockroachdb";
        User = config.services.cockroachdb.user;
      };
    };
  };
}
