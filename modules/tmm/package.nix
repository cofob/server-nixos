{ lib, fetchFromGitHub, rustPlatform, pkg-config, openssl }:

rustPlatform.buildRustPackage rec {
  pname = "tmm";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "DomesticMoth";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-K3t1rcghphfJNaMFwwGoPuFKqfZRUGbYCDUEmNZxm18=";
  };

  cargoSha256 = "sha256-gq90jU6FQKwfZQ6pzleYEVSHTo7wECCLOFYkXCadAr0=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];

  meta = with lib; {
    description = "This bot allows you to logically bind two telegram chats so that users who are not in the master cannot be in the slave chat";
    homepage = "https://github.com/DomesticMoth/tmm";
    license = licenses.gpl3Only;
  };
}
