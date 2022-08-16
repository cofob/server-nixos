{ lib, config, ... }:

with lib;

let
  fw-cfg = config.networking.firewall;
  nft-cfg = config.networking.nft-firewall;

  defaultInterface = { default = mapAttrs (name: value: fw-cfg.${name}) commonOptions; };
  allInterfaces = defaultInterface // fw-cfg.interfaces;
in
{
  options = {
    networking.nft-firewall = {
      enable = mkOption {
        type = types.bool;
        default = true;
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

          ${flip concatMapStrings fw-cfg.trustedInterfaces (iface: ''
            iifname ${iface} accept
          '')}

          ${optionalString fw-cfg.allowPing ''
            icmp type echo-request ${optionalString (fw-cfg.pingLimit != null)
              "limit rate ${fw-cfg.pingLimit} "
            }accept
            icmpv6 type echo-request ${optionalString (fw-cfg.pingLimit != null)
              "limit rate ${fw-cfg.pingLimit} "
            }accept
          ''}

          ${concatStrings (mapAttrsToList (iface: fw-cfg:
            concatMapStrings (port:
              ''
                tcp dport ${toString port} ${optionalString (iface != "default") "iifname ${iface}"} accept
              ''
            ) fw-cfg.allowedTCPPorts
          ) allInterfaces)}

          ${concatStrings (mapAttrsToList (iface: fw-cfg:
            concatMapStrings (port:
              ''
                udp dport ${toString port} ${optionalString (iface != "default") "iifname ${iface}"} accept
              ''
            ) fw-cfg.allowedUDPPorts
          ) allInterfaces)}

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
