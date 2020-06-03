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
    
  test-scenario:
    - name: /PeerAsns/put/Create a peer ASN
      disabled: true
    - name: /Peerings/put/Create an exchange peering
      disabled: true
    - name: /Peerings/put/Create a peering with exchange route server
      disabled: true
    - name: /Peerings/put/Create a direct peering
      disabled: true
    - name: /PeeringServices/put/Create a  peering service
    - name: /RegisteredAsns/put/Create or update a registered ASN for the peering
      disabled: true
    - name: /Prefixes/put/Create or update a prefix for the peering service
      disabled: true
    - name: /RegisteredPrefixes/put/Create or update a registered prefix for the peering
      disabled: true
    - name: /RegisteredPrefixes/get/Get a registered prefix associated with the peering
      disabled: true
    - name: /Prefixes/get/Get a prefix associated with the peering service
      disabled: true
    - name: /RegisteredAsns/get/Get a registered ASN associated with the peering
      disabled: true
    - name: /Prefixes/get/List all the prefixes associated with the peering service
    - name: /RegisteredPrefixes/get/List all the registered prefixes associated with the peering
      disabled: true
    - name: /PeeringServices/get/Get a peering service
    - name: /RegisteredAsns/get/List all the registered ASNs associated with the peering
      disabled: true
    - name: /Peerings/get/Get a peering
      disabled: true
    - name: /PeeringServices/get/List peering services in a resource group
    - name: /Peerings/get/List peerings in a resource group
    - name: /PeerAsns/get/Get a peer ASN
    - name: /PeeringServiceCountries/get/List peering service countries
    - name: /PeeringServiceLocations/get/List peering service locations
    - name: /PeeringServiceProviders/get/List peering service providers
    - name: /PeeringLocations/get/List exchange peering locations
    - name: /PeeringLocations/get/List direct peering locations
    - name: /PeeringServices/get/List peering services in a subscription
    - name: /LegacyPeerings/get/List legacy peerings
    - name: /PeerAsns/get/List peer ASNs in a subscription
    - name: /Peerings/get/List peerings in a subscription
    - name: /Operations/get/List peering operations
    - name: /PeeringServices/patch/Update peering service tags
      disabled: true
    - name: /Peerings/patch/Update peering tags
      disabled: true
    - name: //post/Check if peering service provider is available in customer location
      disabled: true
    - name: /RegisteredPrefixes/delete/Deletes a registered prefix associated with the peering
      disabled: true
    - name: /Prefixes/delete/Delete a prefix associated with the peering service
      disabled: true
    - name: /RegisteredAsns/delete/Deletes a registered ASN associated with the peering
      disabled: true
    - name: /PeeringServices/delete/Delete a peering service
    - name: /Peerings/delete/Delete a peering
      disabled: true
    - name: /PeerAsns/delete/Delete a peer ASN
```
