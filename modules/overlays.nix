{ tg-captcha, marzbanbot, aeza-assistant, ... }:

{
  nixpkgs.overlays = [
    tg-captcha.overlays.default
    marzbanbot.overlays.default
    aeza-assistant.overlays.default
  ];
}
