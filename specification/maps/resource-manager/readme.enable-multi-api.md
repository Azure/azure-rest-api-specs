# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.Maps/stable/2017-01-01-preview/maps-management.json
  - $(this-folder)/Microsoft.Maps/stable/2018-05-01/maps-management.json
require: $(this-folder)/../../../../profiles/readme.md
```
