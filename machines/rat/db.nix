{ config, pkgs, ... }:

{
  services.postgresql = {
    enable = true;
    ensureUsers = [
      {
        name = "vaultwarden";
        ensurePermissions = {
          "DATABASE vaultwarden" = "ALL PRIVILEGES";
        };
      }
      {
        name = "woodpecker";
        ensurePermissions = {
          "DATABASE woodpecker" = "ALL PRIVILEGES";
        };
      }
      {
        name = "grafana";
        ensurePermissions = {
          "DATABASE grafana" = "ALL PRIVILEGES";
        };
      }
      {
        name = "gitea";
        ensurePermissions = {
          "DATABASE gitea" = "ALL PRIVILEGES";
        };
      }
      {
        name = "wiki";
        ensurePermissions = {
          "DATABASE wiki" = "ALL PRIVILEGES";
        };
      }
      {
        name = "maddy";
        ensurePermissions = {
          "DATABASE maddy" = "ALL PRIVILEGES";
        };
      }
    ];
    ensureDatabases = [
      "vaultwarden"
      "woodpecker"
      "grafana"
      "gitea"
      "maddy"
      "wiki"
    ];
  };

  age.secrets.cockroach-rat-crt.file = ../../secrets/cockroach/rat-crt.age;
  age.secrets.cockroach-rat-key.file = ../../secrets/cockroach/rat-key.age;
  age.secrets.cockroach-rat-crt.owner = config.services.cockroachdb.user;
  age.secrets.cockroach-rat-key.owner = config.services.cockroachdb.user;
  services.cockroachdb = {
    enable = true;
    # package = pkgs.cockroachdb;
    crtFile = config.age.secrets.cockroach-rat-crt.path;
    keyFile = config.age.secrets.cockroach-rat-key.path;
    locality = "country=nl,datacenter=aeza-nl";
    openPorts = true;
    http = {
      port = 8081;
      address = "10.3.7.11";
    };
    listen.address = "10.3.7.11";
    join = "shark.n.frsqr.xyz";
  };
}
