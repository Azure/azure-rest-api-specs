# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.DataLakeStore/stable/2016-11-01/filesystem.json
  - $(this-folder)/Microsoft.DataLakeStore/preview/2015-10-01-preview/filesystem.json
require: $(this-folder)/../../../../profiles/readme.md
```
