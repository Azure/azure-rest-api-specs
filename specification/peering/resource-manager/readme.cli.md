## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  cli-name: peering
  cmd-override:
    "^.*[/]peerasns[/].*$": "peering asn"
    "^.*[/]peerings[/].*$": "peering"
    "^.*[/]legacypeerings$": "peering legacy"
    "^.*[/]peeringlocations$": "peering location"
    "^.*[/]peeringservicelocations$": "peering service location"
    "^.*[/]peeringserviceproviders$": "peering service provider"
    "^.*[/]peeringservices([/][^/]*)?$": "peering service"
    "^.*[/]peeringservices[/].*prefixes.*$": "peering service prefix"
    "^.*[/]operations$": "-"
  namespace: azure.mgmt.peering
  package-name: azure-mgmt-peering
  debug: true
  adjustments:
    "/sku": "Sku*/"
    "/properties/exchange": "Exchange*/"
    "/properties/direct": "Direct*/"
    "/properties/peercontactinfo": "*/"
    
  test-setup:
    - name: Create or Update a service with all parameters
```
