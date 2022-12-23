{ ... }:

{
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };

  # virtualisation.oci-containers = {
  #   backend = "docker";
  #   containers.wathtower = {
  #     image = "containrrr/watchtower";
  #     cmd = [ "--cleanup" "--interval" "600" ];
  #     autoStart = true;
  #   };
  # };
}
