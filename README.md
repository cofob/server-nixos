# Server NixOS configurations

## Nebula VPN

### Servers

- Eagle (proxy): 10.3.7.10
- Rat (proxy, server): 10.3.7.11
- Backup (server, backup): 10.3.7.12
- Beaver (builder): 10.3.7.30
- Whale (server): 10.3.7.20
- Shark (server): 10.3.7.40

### Desktops

#### AveryanAlex

- Hamster: 10.3.7.100
- Alligator: 10.3.7.101

#### Cofob

- Fly: 10.3.7.120
- Bear: 10.3.7.121

### Commands

```shell
EDITOR=cat agenix -e secrets/nebula/ca-crt.age > ca.crt
EDITOR=cat agenix -e secrets/nebula/ca-key.age > ca.key
nebula-cert sign -name "alligator" -ip "10.3.7.101/24" -groups "desktop,averyanalex"
```
