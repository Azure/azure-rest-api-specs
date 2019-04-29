# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.Network/stable/2018-05-01/dns.json
  - $(this-folder)/Microsoft.Network/preview/2018-03-01-preview/dns.json
  - $(this-folder)/Microsoft.Network/stable/2017-10-01/dns.json
  - $(this-folder)/Microsoft.Network/stable/2017-09-01/dns.json
  - $(this-folder)/Microsoft.Network/stable/2016-04-01/dns.json
  - $(this-folder)/Microsoft.Network/preview/2015-05-04-preview/dns.json
require: $(this-folder)/../../../profiles/readme.md
```
