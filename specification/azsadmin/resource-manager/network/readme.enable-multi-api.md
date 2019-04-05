# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.Network.Admin/preview/2015-06-15/Network.json
  - $(this-folder)/Microsoft.Network.Admin/preview/2015-06-15/LoadBalancers.json
  - $(this-folder)/Microsoft.Network.Admin/preview/2015-06-15/PublicIpAddresses.json
  - $(this-folder)/Microsoft.Network.Admin/preview/2015-06-15/Quotas.json
  - $(this-folder)/Microsoft.Network.Admin/preview/2015-06-15/VirtualNetworks.json
require: $(this-folder)/../../../../../profiles/readme.md
```
