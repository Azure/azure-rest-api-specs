# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - Microsoft.InfrastructureInsights.Admin/preview/2016-05-01/InfrastructureInsights.json
  - Microsoft.InfrastructureInsights.Admin/preview/2016-05-01/Alert.json
  - Microsoft.InfrastructureInsights.Admin/preview/2016-05-01/RegionHealth.json
  - Microsoft.InfrastructureInsights.Admin/preview/2016-05-01/ResourceHealth.json
  - Microsoft.InfrastructureInsights.Admin/preview/2016-05-01/ServiceHealth.json
require: ../../../../../profiles/readme.md
```
