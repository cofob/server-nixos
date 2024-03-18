{ element-web-unwrapped
, stdenv
, gzip
, brotli
, jq
, conf ? {
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
  }
}:

stdenv.mkDerivation {
  pname = "element-web-compressed";
  version = element-web-unwrapped.version;

  src = element-web-unwrapped;

  buildInputs = [ gzip brotli jq ];

  buildPhase = ''
    # add config
    rm config.json
    jq -s '.[0] * $conf' "${element-web-unwrapped}/config.json" --argjson "conf" '${builtins.toJSON conf}' > "config.json"

    # compress static
    find . -type f -print0 | xargs -0 -I{} -P $(nproc) \
      sh -c "gzip -c --best {} > {}.gz && brotli -c --best {} > {}.br"
  '';

  installPhase = ''
    cp -r . $out
  '';
}
