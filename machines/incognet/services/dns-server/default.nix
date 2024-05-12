{ ... }:

{
  services.selfhosted-dns.enable = true;
  services.bind.configFile = ./config;
}
