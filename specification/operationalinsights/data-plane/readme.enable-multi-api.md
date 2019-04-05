# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.OperationalInsights/stable/v1/OperationalInsights.json
  - $(this-folder)/Microsoft.OperationalInsights/preview/2017-10-01/swagger.json
require: $(this-folder)/../../../../profiles/readme.md
```
