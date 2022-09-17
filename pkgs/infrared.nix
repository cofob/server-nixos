{ buildGoModule, fetchzip, ... }:

buildGoModule rec {
  pname = "infrared";
  version = "1.4.0";

  src = fetchzip {
    url = "https://git.frsqr.xyz/archive/infrared/archive/2ae651f9f2bcd1428f7304338ecd75d30d945241.zip";
    hash = "sha256-k/jKhPshpl8GpeRKlbD3cZvdeVV8n76Sn23vZyTnd3U=";
  };

  vendorSha256 = "sha256-vUKz+Y2ekOGgDROkoSch+feXZhFOvs6hQgR8LIjCkNY=";

  meta = {
    description = "Minecraft reverse proxy, like nginx.";
    homepage = "https://git.frsqr.xyz/archive/infrared";
  };
}
