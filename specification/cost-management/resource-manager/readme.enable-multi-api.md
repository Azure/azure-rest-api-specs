# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.CostManagement/stable/2019-01-01/costmanagement.json
  - $(this-folder)/Microsoft.CostManagement/preview/2019-03-01-preview/costmanagement.json
  - $(this-folder)/Microsoft.CostManagement/stable/2018-05-31/costmanagement.json
  - $(this-folder)/Microsoft.CostManagement/preview/2018-08-01-preview/costmanagement.json
  - $(this-folder)/Microsoft.CostManagement/preview/2018-12-01-preview/costmanagement.json
require: $(this-folder)/../../../../profiles/readme.md
```
