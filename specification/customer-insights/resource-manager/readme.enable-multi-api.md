# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.CustomerInsights/stable/2017-04-26/customer-insights.json
  - $(this-folder)/Microsoft.CustomerInsights/stable/2017-01-01/customer-insights.json
require: $(this-folder)/../../../../profiles/readme.md
```
