let
  alex = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINF5KDy1T6Z+RlDb+Io3g1uSZ46rhBxhNE39YlG3GPFM";
  cofob = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIETMEzhigdZelWae3V4tQ7/LXsub39SRG2X+jPMeoHMx";
  users = [ alex cofob ];

  diamond = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJPimxmmhXzwCUaWVaB89R6HGJLPP5+EW76h7Qx2WnFY";
  systems = [ diamond ];
in
{
  "secrets/passwords/alex.age".publicKeys = [ alex ] ++ systems;
  "secrets/passwords/cofob.age".publicKeys = [ cofob ] ++ systems;
}
