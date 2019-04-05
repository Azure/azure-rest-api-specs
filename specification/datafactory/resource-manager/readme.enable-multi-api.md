# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.DataFactory/stable/2018-06-01/datafactory.json
  - $(this-folder)/Microsoft.DataFactory/preview/2017-09-01-preview/datafactory.json
require: $(this-folder)/../../../../profiles/readme.md
```
