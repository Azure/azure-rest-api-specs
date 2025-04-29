## Azure CLI

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: peering
  package-name: azure-mgmt-peering
  namespace: azure.mgmt.peering
az-output-folder: $(azure-cli-extension-folder)/src/peering
python-sdk-output-folder: "$(az-output-folder)/azext_peering/vendored_sdks/peering"
directive: 
  - where: 
      group: ^peering peering-service$ 
    set:
      group: peering service
  - where: 
      group: ^peering peering-service-location$ 
    set:
      group: peering service location
  - where: 
      group: ^peering peering-service-country$
    set:
      group: peering service country
  - where: 
      group: ^peering peering-service-provider$
    set:
      group: peering service provider
  - where: 
      group: ^peering peer-asn$
    set:
      group: peering asn
  - where: 
      group: ^peering prefix$
    set:
      group: peering service prefix
  - where: 
      group: ^peering legacy-peering$
    set:
      group: peering legacy
  - where: 
      group: ^peering peering-location$
    set:
      group: peering location
```
