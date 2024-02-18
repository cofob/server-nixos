{ lib, fetchFromGitHub, rustPlatform, pkg-config, openssl }:

rustPlatform.buildRustPackage rec {
  pname = "tmm";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "DomesticMoth";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-nupwoSCyVm3QbbvCK4Gm639XkkpQv6ohW0iQTtPZo9c=";
  };

  cargoSha256 = "sha256-L6xRipQ0XbKLXf90IQL9UMM52PJV66zVYcCrVrjJSBE=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];

  meta = with lib; {
    description = "This bot allows you to logically bind two telegram chats so that users who are not in the master cannot be in the slave chat";
    homepage = "https://github.com/DomesticMoth/tmm";
    license = licenses.gpl3Only;
  };
}
