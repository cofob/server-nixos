{ config, ... }:

{
  age.secrets.syncthing-rat-cert.file = ../../secrets/syncthing/rat-cert.age;
  age.secrets.syncthing-rat-key.file = ../../secrets/syncthing/rat-key.age;
  age.secrets.syncthing-rat-cert.owner = "cofob";
  age.secrets.syncthing-rat-key.owner = "cofob";
  services.syncthing = {
    enable = true;
    cert = config.age.secrets.syncthing-rat-cert.path;
    key = config.age.secrets.syncthing-rat-key.path;
    user = "cofob";
    dataDir = "/home/cofob";
    systemService = true;
    guiAddress = "10.3.7.11:8384";
    folders = {
      "/home/cofob/Documents/Dev" = {
        id = "documents-dev";
        devices = [ "bear" "fly" "huawei" ];
        versioning = {
          type = "simple";
          params.keep = "3";
        };
      };
    };
    devices = {
      bear = {
        id = "V4RGEPV-66RY2EP-DKMWW3J-ADAC7TD-CLYEEKM-XZ2YQFJ-AGCHHAP-CZ32XQB";
      };
      fly = {
        id = "FP4SSU3-OZJLAY4-X25CHCU-TK34OZ3-CPY2CK6-CGPFJOS-H4VHSY2-5VTHSA5";
      };
      huawei = {
        id = "V3DPTUO-ESKOTAG-4QK5BH2-ZAVFNQI-RTLGIXX-KBYJ5NM-JPXGRDU-GTTOAQH";
      };
    };
  };
}
