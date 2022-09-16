let
  alex = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINF5KDy1T6Z+RlDb+Io3g1uSZ46rhBxhNE39YlG3GPFM";
  cofob = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIETMEzhigdZelWae3V4tQ7/LXsub39SRG2X+jPMeoHMx";
  users = [ alex cofob ];

  diamond = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJPimxmmhXzwCUaWVaB89R6HGJLPP5+EW76h7Qx2WnFY";
  eagle = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILdFLG40/W62LpwPK0PQUSr/3zGNAn5qK4jabXDl9SIM";
  rat = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICIo9EB6kxVzY93JU602tDaEYwmo4+V8d5xoYS3c1+aN";
  beaver = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHKoFVvggf2o3DQsvdAKrfbGMVnly6AmzW/Sebt+1fUW";
  shark = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIuz7EJAfTBL+kG0qRVjbKCPEFtFrpPa4ZP8ZfDxuH5k";
  systems = [ diamond eagle rat shark beaver ];
in
{
  "secrets/passwords/alex.age".publicKeys = users ++ systems;
  "secrets/passwords/cofob.age".publicKeys = users ++ systems;

  "secrets/nebula/ca-crt.age".publicKeys = users ++ systems;
  "secrets/nebula/ca-key.age".publicKeys = users;
  "secrets/nebula/eagle-crt.age".publicKeys = users ++ systems;
  "secrets/nebula/eagle-key.age".publicKeys = users ++ [ eagle ];
  "secrets/nebula/rat-crt.age".publicKeys = users ++ systems;
  "secrets/nebula/rat-key.age".publicKeys = users ++ [ rat ];
  "secrets/nebula/shark-crt.age".publicKeys = users ++ systems;
  "secrets/nebula/shark-key.age".publicKeys = users ++ [ shark ];
  "secrets/nebula/beaver-crt.age".publicKeys = users ++ systems;
  "secrets/nebula/beaver-key.age".publicKeys = users ++ [ beaver ];

  "secrets/nebula-averyan/ca-crt.age".publicKeys = users ++ systems;
  "secrets/nebula-averyan/eagle-crt.age".publicKeys = users ++ systems;
  "secrets/nebula-averyan/eagle-key.age".publicKeys = users ++ [ eagle ];

  "secrets/credentials/cloudflare.age".publicKeys = users ++ [ eagle rat ];
  "secrets/credentials/gitea.age".publicKeys = users ++ [ rat ];
  "secrets/credentials/bps.age".publicKeys = users ++ [ rat ];
  "secrets/credentials/tmm.age".publicKeys = users ++ [ rat ];
  "secrets/credentials/tgcaptcha.age".publicKeys = users ++ [ rat ];
  "secrets/credentials/woodpecker-server.age".publicKeys = users ++ [ rat ];
  "secrets/credentials/woodpecker-agent.age".publicKeys = users ++ [ rat beaver ];
  "secrets/credentials/pbs.age".publicKeys = users ++ systems;
  "secrets/credentials/pbs-key.age".publicKeys = users ++ systems;
}
