{ callPackage }:

{
  cinny-cofob-dev = (callPackage ./cinny.nix { });
  element-cofob-dev = (callPackage ./element.nix { });
  default-ssl-cert = (callPackage ./default-ssl-cert.nix { });
  upgrade-system = (callPackage ./upgrade-system.nix { });
  nginx = (callPackage ./nginx { });
  collabora = (callPackage ./collabora.nix { });
}
