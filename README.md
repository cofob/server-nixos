# Server NixOS configurations

## Commands

```shell
EDITOR=cat agenix -e secrets/nebula/ca-crt.age > ca.crt
EDITOR=cat agenix -e secrets/nebula/ca-key.age > ca.key
nebula-cert sign -name "alligator" -ip "10.3.7.101/24" -groups "desktop,averyanalex"
```
