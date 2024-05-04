{ stdenv, openssl }:

stdenv.mkDerivation {
  pname = "default-ssl-cert";
  version = "1";

  buildInputs = [ openssl ];

  buildPhase = ''
    openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -sha256 -days 3650 -nodes \
      -subj "/C=XX/ST=StateName/L=CityName/O=CompanyName/OU=CompanySectionName/CN=CommonNameOrHostname"
  '';

  installPhase = ''
    mkdir -p $out
    cp cert.pem $out/cert.pem
    cp key.pem $out/key.pem
  '';

  phases = [ "buildPhase" "installPhase" ];
}
