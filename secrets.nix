let
  cofob = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIETMEzhigdZelWae3V4tQ7/LXsub39SRG2X+jPMeoHMx";
  users = [ cofob ];

  rat = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICIo9EB6kxVzY93JU602tDaEYwmo4+V8d5xoYS3c1+aN";
  incognet = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFRUCX14C3h5mYR+mO8OygGVY/KY5JMo7mWU9QX6Ti7o";

  dev1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMWazK81Hk2EbgoCZCiEFqOUDYMaN/V0Xj34II8O4rqQ";
  dev2 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICEd2S0Zx0SmlAAf4Hrj3yEEGUu/FdVe7pGctu/+wNqo";

  systems = [ rat incognet ];
  foreign-systems = [ dev1 dev2 ];

  all = users ++ systems;
in
{
  "secrets/passwords/cofob.age".publicKeys = all ++ foreign-systems;

  # Tg bots
  "secrets/credentials/bps.age".publicKeys = users ++ [ incognet ];
  "secrets/credentials/tmm.age".publicKeys = users ++ [ incognet ];
  "secrets/credentials/tgcaptcha.age".publicKeys = users ++ [ incognet ];
  "secrets/credentials/marzbanbot.age".publicKeys = users ++ [ incognet ];
  "secrets/credentials/aeza-assistant.age".publicKeys = users ++ [ incognet ];

  "secrets/credentials/pbs.age".publicKeys = all;
  "secrets/credentials/pbs-key.age".publicKeys = all;
  "secrets/credentials/telegram-backup.age".publicKeys = all;
  "secrets/credentials/cloudflare.age".publicKeys = all;
  "secrets/credentials/conduit-config.age".publicKeys = users ++ [ rat ];
  "secrets/credentials/coturn-secret.age".publicKeys = users ++ [ rat ];
  "secrets/credentials/mautrix-telegram-config.age".publicKeys = users ++ [ rat ];
  "secrets/credentials/pleroma.age".publicKeys = users ++ [ rat ];
  "secrets/credentials/pleroma-db-password.age".publicKeys = users ++ [ rat ];

  "secrets/zones/cofob.dev.age".publicKeys = users ++ [ incognet rat ];
}
