{ ... }:

{
  services.syncthing = {
    enable = true;
    user = "cofob";
    dataDir = "/home/cofob";
    systemService = true;
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
        address = [ "10.3.7.121" ];
      };
      fly = {
        id = "FP4SSU3-OZJLAY4-X25CHCU-TK34OZ3-CPY2CK6-CGPFJOS-H4VHSY2-5VTHSA5";
        address = [ "10.3.7.120" ];
      };
      huawei = {
        id = "V3DPTUO-ESKOTAG-4QK5BH2-ZAVFNQI-RTLGIXX-KBYJ5NM-JPXGRDU-GTTOAQH";
      };
    };
  };
}
