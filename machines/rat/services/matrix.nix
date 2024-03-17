{ config
, pkgs
, lib
, conduit
, ...
}:

{
  age.secrets.credentials-conduit-config.file = ../../../secrets/credentials/conduit-config.age;
  age.secrets.credentials-conduit-config.mode = "777";
  services.matrix-conduit = {
    enable = true;
    package = conduit.packages.${pkgs.system}.default;
    settings.global.server_name = "cofob.dev"; # makes no differnce, because config is overridden by the config file
  };
  systemd.services.conduit.environment = lib.mkForce { CONDUIT_CONFIG = config.age.secrets.credentials-conduit-config.path; };

  # Matrix bridge
  age.secrets.credentials-mautrix-telegram-config.file = ../../../secrets/credentials/mautrix-telegram-config.age;
  services.mautrix-telegram = {
    enable = true;

    environmentFile = config.age.secrets.credentials-mautrix-telegram-config.path;

    settings = {
      homeserver = {
        address = "http://[::1]:${toString config.services.matrix-conduit.settings.global.port}";
        domain = "cofob.dev";
      };
      appservice = {
        id = "telegram";
        database = "postgresql:///mautrix-telegram?host=/run/postgresql";
      };
      bridge = {
        displayname_template = "{displayname}";
        delivery_receipts = true;
        pinned_tag = "m.favourite";
        archive_tag = "m.lowpriority";
        relaybot.authless_portals = false;
        encryption.allow = true;

        message_formats = {
          "m.text" = "<b>$sender_displayname</b>:<br/>$message";
          "m.notice" = "<b>$sender_displayname</b>:<br/>$message";
          "m.emote" = "* <b>$sender_displayname</b> $message";
          "m.file" = "<b>$sender_displayname</b> sent a file:<br/>$message";
          "m.image" = "<b>$sender_displayname</b> sent an image:<br/>$message";
          "m.audio" = "<b>$sender_displayname</b> sent an audio file:<br/>$message";
          "m.video" = "<b>$sender_displayname</b> sent a video:<br/>$message";
          "m.location" = "<b>$sender_displayname</b> sent a location:<br/>$message";
        };
        state_event_formats = {
          join = "";
          leave = "";
          name_change = "";
        };

        permissions = {
          "*" = "relaybot";
          "cofob.dev" = "full";
          "@i:cofob.dev" = "admin";
        };

        animated_sticker = {
          target = "gif";
          args = {
            width = 256;
            height = 256;
            fps = 30; # only for webm
            background = "020202"; # only for gif, transparency not supported
          };
        };
      };
    };
  };

  systemd.services.mautrix-telegram.path = with pkgs; [
    lottieconverter # for animated stickers conversion, unfree package
    ffmpeg # if converting animated stickers to webm (very slow!)
  ];

  # TURN server
  age.secrets.credentials-coturn-secret.file = ../../../secrets/credentials/coturn-secret.age;
  age.secrets.credentials-coturn-secret.owner = "turnserver";
  age.secrets.credentials-coturn-secret.group = "turnserver";
  services.coturn = {
    enable = true;
    use-auth-secret = true;
    static-auth-secret-file = config.age.secrets.credentials-coturn-secret.path;
    realm = "turn.cofob.dev";
    no-tcp-relay = true;
    cert = "${config.security.acme.certs."turn.cofob.dev".directory}/fullchain.pem";
    pkey = "${config.security.acme.certs."turn.cofob.dev".directory}/privkey.pem";
    extraConfig = ''
      # VoIP traffic is all UDP. There is no reason to let users connect to arbitrary TCP endpoints via the relay.
      no-tcp-relay

      # don't let the relay ever try to connect to private IP address ranges within your network (if any)
      # given the turn server is likely behind your firewall, remember to include any privileged public IPs too.
      denied-peer-ip=10.0.0.0-10.255.255.255
      denied-peer-ip=192.168.0.0-192.168.255.255
      denied-peer-ip=172.16.0.0-172.31.255.255

      # recommended additional local peers to block, to mitigate external access to internal services.
      # https://www.rtcsec.com/article/slack-webrtc-turn-compromise-and-bug-bounty/#how-to-fix-an-open-turn-relay-to-address-this-vulnerability
      no-multicast-peers
      denied-peer-ip=0.0.0.0-0.255.255.255
      denied-peer-ip=100.64.0.0-100.127.255.255
      denied-peer-ip=127.0.0.0-127.255.255.255
      denied-peer-ip=169.254.0.0-169.254.255.255
      denied-peer-ip=192.0.0.0-192.0.0.255
      denied-peer-ip=192.0.2.0-192.0.2.255
      denied-peer-ip=192.88.99.0-192.88.99.255
      denied-peer-ip=198.18.0.0-198.19.255.255
      denied-peer-ip=198.51.100.0-198.51.100.255
      denied-peer-ip=203.0.113.0-203.0.113.255
      denied-peer-ip=240.0.0.0-255.255.255.255

      # special case the turn server itself so that client->TURN->TURN->client flows work
      # this should be one of the turn server's listening IPs
      allowed-peer-ip=89.208.104.77

      # consider whether you want to limit the quota of relayed streams per user (or total) to avoid risk of DoS.
      user-quota=12 # 4 streams per video call, so 12 streams = 3 simultaneous relayed calls per user.
      total-quota=1200
    '';
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;

    virtualHosts = {
      "matrix.cofob.dev" = {
        enableACME = true;
        quic = true;
        http3 = true;
        kTLS = true;
        forceSSL = true;

        locations."/".return = "403";

        locations."/_matrix/" = {
          proxyPass = "http://backend_conduit$request_uri";
          proxyWebsockets = true;
          extraConfig = ''
            proxy_set_header Host $host;
            proxy_buffering off;

            client_max_body_size ${toString config.services.matrix-conduit.settings.global.max_request_size};
          '';
        };

        extraConfig = ''
          merge_slashes off;
        '';
      };
    };

    upstreams = {
      "backend_conduit" = {
        servers = {
          "[::1]:${toString config.services.matrix-conduit.settings.global.port}" = { };
        };
      };
    };
  };

  security.acme.certs."turn.cofob.dev" = {
    reloadServices = [ "coturn" ];
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
  networking.firewall.allowedUDPPorts = [ 443 ];

  services.backup.timers.daily = [
    "matrix-conduit.pxar:${config.services.matrix-conduit.settings.global.database_path}"
    "mautrix-telegram.pxar:/var/lib/mautrix-telegram"
  ];
}
