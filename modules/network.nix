{
  boot.kernel.sysctl = {
    "net.ipv4.tcp_fastopen" = 3;
    "net.ipv4.tcp_tw_reuse" = 1;
    "net.ipv4.tcp_slow_start_after_idle" = 0;

    "net.ipv4.tcp_keepalive_time" = 60;
    "net.ipv4.tcp_keepalive_intvl" = 10;
    "net.ipv4.tcp_keepalive_probes" = 6;

    "net.ipv4.tcp_mtu_probing" = 1;

    "net.ipv4.tcp_syncookies" = 1; # default value
    "net.ipv4.tcp_rfc1337" = 1;

    "net.ipv4.conf.default.log_martians" = 1;
    "net.ipv4.conf.all.log_martians" = 1;
  };

  # TODO: enable BBR?
  # TODO: enable RPF?
}
