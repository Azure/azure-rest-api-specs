# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.ServiceFabricMesh/preview/2018-09-01-preview/servicefabricmesh.json
  - $(this-folder)/Microsoft.ServiceFabricMesh/preview/2018-07-01-preview/servicefabricmesh.json
require: $(this-folder)/../../../profiles/readme.md
```
