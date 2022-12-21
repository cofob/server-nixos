let
  cofob = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIETMEzhigdZelWae3V4tQ7/LXsub39SRG2X+jPMeoHMx";
  users = [ cofob ];

  rat = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICIo9EB6kxVzY93JU602tDaEYwmo4+V8d5xoYS3c1+aN";
  diamond = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKI3lWpGU0TE74z0STnC1WuUAUNlMYipvUChSaJ/k0pw";
  systems = [ rat diamond ];

  all = users ++ systems;
in
{
  "secrets/passwords/cofob.age".publicKeys = all;

  "secrets/credentials/cloudflare.age".publicKeys = users ++ [ rat ];
  "secrets/credentials/gitea.age".publicKeys = users ++ [ rat ];
  "secrets/credentials/bps.age".publicKeys = users ++ [ rat ];
  "secrets/credentials/tmm.age".publicKeys = users ++ [ rat ];
  "secrets/credentials/botosusl.age".publicKeys = users ++ [ diamond ];
  "secrets/credentials/tgcaptcha.age".publicKeys = users ++ [ rat ];
  "secrets/credentials/archive-bot.age".publicKeys = users ++ [ rat ];
  "secrets/credentials/api-server.age".publicKeys = users ++ [ rat ];
  "secrets/credentials/pbs.age".publicKeys = all;
  "secrets/credentials/pbs-diamond.age".publicKeys = users ++ [ diamond ];
  "secrets/credentials/pbs-key.age".publicKeys = all;
  "secrets/credentials/ipfs-cluster.age".publicKeys = all;
  "secrets/credentials/remote-builder.age".publicKeys = all;
  "secrets/credentials/maddy.age".publicKeys = users ++ [ rat ];

  "secrets/wg/rat.age".publicKeys = users ++ [ rat ];
  "secrets/wg/diamond.age".publicKeys = users ++ [ diamond ];

  "secrets/syncthing/rat-cert.age".publicKeys = all;
  "secrets/syncthing/rat-key.age".publicKeys = users ++ [ rat ];

  "secrets/wiki-env.age".publicKeys = users ++ [ rat ];
}
