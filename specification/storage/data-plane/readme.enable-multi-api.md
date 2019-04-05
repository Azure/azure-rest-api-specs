# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.StorageDataLake/stable/2018-11-09/DataLakeStorage.json
  - $(this-folder)/Microsoft.StorageDataLake/preview/2018-06-17/DataLakeStorage.json
require: $(this-folder)/../../../../profiles/readme.md
```
