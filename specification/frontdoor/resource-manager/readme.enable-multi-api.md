# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.Network/stable/2019-04-01/frontdoor.json
  - $(this-folder)/Microsoft.Network/stable/2019-04-01/network.json
  - $(this-folder)/Microsoft.Network/preview/2019-03-01-preview/webapplicationfirewall.json
  - $(this-folder)/Microsoft.Network/preview/2018-08-01-preview/frontdoor.json
  - $(this-folder)/Microsoft.Network/preview/2018-08-01-preview/network.json
  - $(this-folder)/Microsoft.Network/preview/2018-08-01-preview/webapplicationfirewall.json
require: $(this-folder)/../../../../profiles/readme.md
```
