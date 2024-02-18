{ tg-captcha, ... }:

{
  nixpkgs.overlays = [ tg-captcha.overlays.default ];
}
