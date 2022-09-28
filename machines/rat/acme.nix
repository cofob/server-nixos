{ ... }:

{
  security.acme = {
    certs = {
      "ipfsqr.ru".extraDomainNames = [
        "*.ipfsqr.ru"
        "*.ipfs.ipfsqr.ru"
        "*.ipns.ipfsqr.ru"
        "frsqr.xyz"
        "*.frsqr.xyz"
        "firesquare.ru"
        "*.firesquare.ru"
        "cofob.ru"
        "*.cofob.ru"
      ];
      "frsqr.xyz".extraDomainNames = [ "*.frsqr.xyz" ];
      "rat.frsqr.xyz" = {
        group = "ipfs-cluster";
      };
    };
  };
}
