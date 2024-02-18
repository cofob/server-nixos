let
  cofob = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIETMEzhigdZelWae3V4tQ7/LXsub39SRG2X+jPMeoHMx";
  users = [ cofob ];

  rat = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICIo9EB6kxVzY93JU602tDaEYwmo4+V8d5xoYS3c1+aN";
  incognet = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFRUCX14C3h5mYR+mO8OygGVY/KY5JMo7mWU9QX6Ti7o";
  systems = [ rat incognet ];

  all = users ++ systems;
in
{
  "secrets/passwords/cofob.age".publicKeys = all;

  # Tg bots
  "secrets/credentials/bps.age".publicKeys = users ++ [ incognet ];
  "secrets/credentials/tmm.age".publicKeys = users ++ [ incognet ];
  "secrets/credentials/tgcaptcha.age".publicKeys = users ++ [ incognet ];
  "secrets/credentials/aeza-assistant.age".publicKeys = users ++ [ incognet ];

  "secrets/credentials/pbs.age".publicKeys = all;
  "secrets/credentials/pbs-key.age".publicKeys = all;
  "secrets/credentials/telegram-backup.age".publicKeys = all;
  "secrets/credentials/cloudflare.age".publicKeys = all;
  "secrets/credentials/maddy.age".publicKeys = users ++ [ rat ];
}
