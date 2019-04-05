# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.InfrastructureInsights.Admin/preview/2016-05-01/InfrastructureInsights.json
  - $(this-folder)/Microsoft.InfrastructureInsights.Admin/preview/2016-05-01/Alert.json
  - $(this-folder)/Microsoft.InfrastructureInsights.Admin/preview/2016-05-01/RegionHealth.json
  - $(this-folder)/Microsoft.InfrastructureInsights.Admin/preview/2016-05-01/ResourceHealth.json
  - $(this-folder)/Microsoft.InfrastructureInsights.Admin/preview/2016-05-01/ServiceHealth.json
require: $(this-folder)/../../../../../profiles/readme.md
```
