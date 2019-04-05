# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.OperationalInsights/preview/2015-11-01-preview/OperationalInsights.json
  - $(this-folder)/Microsoft.OperationalInsights/stable/2015-03-20/OperationalInsights.json
require: $(this-folder)/../../../../profiles/readme.md
```
