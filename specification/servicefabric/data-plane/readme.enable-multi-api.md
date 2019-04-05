# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.ServiceFabric/stable/6.2/servicefabric.json
  - $(this-folder)/Microsoft.ServiceFabric/stable/6.3/servicefabric.json
  - $(this-folder)/Microsoft.ServiceFabric/stable/6.4/servicefabric.json
require: $(this-folder)/../../../../profiles/readme.md
```
