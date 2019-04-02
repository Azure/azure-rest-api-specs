# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - Microsoft.Network/stable/2019-04-01/frontdoor.json
  - Microsoft.Network/stable/2019-04-01/network.json
  - Microsoft.Network/preview/2019-03-01-preview/webapplicationfirewall.json
  - Microsoft.Network/preview/2018-08-01-preview/frontdoor.json
  - Microsoft.Network/preview/2018-08-01-preview/network.json
  - Microsoft.Network/preview/2018-08-01-preview/webapplicationfirewall.json
require: ../../../../profiles/readme.md
```
