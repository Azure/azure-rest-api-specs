# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.Kusto/stable/2019-01-21/kusto.json
  - $(this-folder)/Microsoft.Kusto/preview/2018-09-07-preview/kusto.json
  - $(this-folder)/Microsoft.Kusto/preview/2017-09-07-privatepreview/kusto.json
require: $(this-folder)/../../../../profiles/readme.md
```
