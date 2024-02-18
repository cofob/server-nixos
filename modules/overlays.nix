{ tg-captcha, aeza-assistant, ... }:

{
  nixpkgs.overlays = [
    tg-captcha.overlays.default
    aeza-assistant.overlays.default
  ];
}
