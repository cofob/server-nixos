{ pkgs }:

pkgs.element-web.override {
  conf = {
    default_server_config = {
      "m.homeserver".base_url = "https://matrix.cofob.dev";
      "m.homeserver".server_name = "cofob.dev";
      "m.identity_server".base_url = "https://disabled.cofob.dev";
    };
    integrations_ui_url = "https://disabled.cofob.dev/";
    integrations_rest_url = "https://disabled.cofob.dev/";
    integrations_widgets_urls = [ "https://disabled.cofob.dev/" ];
    jitsi.preferred_domain = "disabled.cofob.dev";
    element_call.url = "https://disabled.cofob.dev";
    map_style_url = "https://disabled.cofob.dev";
  };
}
