# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.Insights/preview/v1/AppInsights.json
  - $(this-folder)/Microsoft.Insights/preview/2018-04-20/swagger.json
require: $(this-folder)/../../../../profiles/readme.md
```
