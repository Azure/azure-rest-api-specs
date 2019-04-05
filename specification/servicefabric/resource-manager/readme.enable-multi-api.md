# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.ServiceFabric/stable/2018-02-01/cluster.json
  - $(this-folder)/Microsoft.ServiceFabric/preview/2017-07-01-preview/application.json
  - $(this-folder)/Microsoft.ServiceFabric/preview/2017-07-01-preview/servicefabric.json
  - $(this-folder)/Microsoft.ServiceFabric/stable/2016-09-01/servicefabric.json
require: $(this-folder)/../../../../profiles/readme.md
```
