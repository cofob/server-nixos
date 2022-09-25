{ lib, config, ... }:

with lib;

let
  fw-cfg = config.networking.firewall;
  nft-cfg = config.networking.nft-firewall;

  defaultInterface = { default = mapAttrs (name: value: fw-cfg.${name}) commonOptions; };
  allInterfaces = defaultInterface // fw-cfg.interfaces;

  commonOptions = {
    allowedTCPPorts = mkOption {
      type = types.listOf types.port;
      default = [ ];
      apply = canonicalizePortList;
      example = [ 22 80 ];
      description =
        ''
          List of TCP ports on which incoming connections are
          accepted.
        '';
    };

    allowedTCPPortRanges = mkOption {
      type = types.listOf (types.attrsOf types.port);
      default = [ ];
      example = [{ from = 8999; to = 9003; }];
      description =
        ''
          A range of TCP ports on which incoming connections are
          accepted.
        '';
    };

    allowedUDPPorts = mkOption {
      type = types.listOf types.port;
      default = [ ];
      apply = canonicalizePortList;
      example = [ 53 ];
      description =
        ''
          List of open UDP ports.
        '';
    };

    allowedUDPPortRanges = mkOption {
      type = types.listOf (types.attrsOf types.port);
      default = [ ];
      example = [{ from = 60000; to = 61000; }];
      description =
        ''
          Range of open UDP ports.
        '';
    };
  };
in
{
  options = {
    networking.nft-firewall = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Whether to enable nftables based firewall.";
      };
    };
  };

  config.networking = mkIf nft-cfg.enable {
    firewall = {
      enable = false;
      trustedInterfaces = [ "lo" ];
    };

    nat.enable = false;

    nftables.enable = true;

    nftables.ruleset = ''
      table inet filter {
        chain output {
          type filter hook output priority 100;
          accept
        }

        chain input {
          type filter hook input priority 0;

          # Accept all traffic on the trusted interfaces.
          ${flip concatMapStrings fw-cfg.trustedInterfaces (iface: ''
            iifname ${iface} accept
          '')}

          # Accept packets from established or related connections.
          ct state { established, related } accept

          # Accept connections to the allowed TCP ports.
          ${concatStrings (mapAttrsToList (iface: fw-cfg:
            concatMapStrings (port:
              ''
                tcp dport ${toString port} ${optionalString (iface != "default") "iifname ${iface}"} accept
              ''
            ) fw-cfg.allowedTCPPorts
          ) allInterfaces)}

          # Accept connections to the allowed TCP port ranges.
          ${concatStrings (mapAttrsToList (iface: fw-cfg:
            concatMapStrings (rangeAttr:
              let range = toString rangeAttr.from + "-" + toString rangeAttr.to; in
              ''
                tcp dport ${range} ${optionalString (iface != "default") "iifname ${iface}"} accept
              ''
            ) fw-cfg.allowedTCPPortRanges
          ) allInterfaces)}

          # Accept packets on the allowed UDP ports.
          ${concatStrings (mapAttrsToList (iface: fw-cfg:
            concatMapStrings (port:
              ''
                udp dport ${toString port} ${optionalString (iface != "default") "iifname ${iface}"} accept
              ''
            ) fw-cfg.allowedUDPPorts
          ) allInterfaces)}

          # Accept connections to the allowed UDP port ranges.
          ${concatStrings (mapAttrsToList (iface: fw-cfg:
            concatMapStrings (rangeAttr:
              let range = toString rangeAttr.from + "-" + toString rangeAttr.to; in
              ''
                udp dport ${range} ${optionalString (iface != "default") "iifname ${iface}"} accept
              ''
            ) fw-cfg.allowedUDPPortRanges
          ) allInterfaces)}

          # Optionally respond to ICMP pings.
          ${optionalString fw-cfg.allowPing ''
            icmp type echo-request ${optionalString (fw-cfg.pingLimit != null)
              "limit rate ${fw-cfg.pingLimit} "
            }accept
            icmpv6 type echo-request ${optionalString (fw-cfg.pingLimit != null)
              "limit rate ${fw-cfg.pingLimit} "
            }accept
          ''}

          accept
        }

        chain forward {
          type filter hook forward priority 0;

          accept

          counter drop
        }
      }

      table ip nat {
        chain prerouting {
          type nat hook prerouting priority dstnat; policy accept;
        }

        chain postrouting {
          type nat hook postrouting priority srcnat; policy accept;
        }
      }
    '';
  };
}
