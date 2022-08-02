let
  alex = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINF5KDy1T6Z+RlDb+Io3g1uSZ46rhBxhNE39YlG3GPFM";
  cofob = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIETMEzhigdZelWae3V4tQ7/LXsub39SRG2X+jPMeoHMx";
  users = [ alex cofob ];

  diamond = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJPimxmmhXzwCUaWVaB89R6HGJLPP5+EW76h7Qx2WnFY";
  bat = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAmwjRcUhJtAnu3VIkWuY4Gdn4PqFXn1z9K97O21BCFx";
  systems = [ diamond bat ];
in
{
  "secrets/passwords/alex.age".publicKeys = users ++ systems;
  "secrets/passwords/cofob.age".publicKeys = users ++ systems;

  "secrets/credentials/cloudflare.age".publicKeys = users ++ [ bat ];
}
