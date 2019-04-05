# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.ContainerService/preview/2018-09-30-preview/openShiftManagedClusters.json
  - $(this-folder)/Microsoft.ContainerService/stable/2017-07-01/containerService.json
  - $(this-folder)/Microsoft.ContainerService/stable/2019-02-01/managedClusters.json
  - $(this-folder)/Microsoft.ContainerService/stable/2017-09-30/location.json
  - $(this-folder)/Microsoft.ContainerService/preview/2018-08-01-preview/managedClusters.json
  - $(this-folder)/Microsoft.ContainerService/stable/2018-03-31/managedClusters.json
  - $(this-folder)/Microsoft.ContainerService/stable/2017-08-31/managedClusters.json
  - $(this-folder)/Microsoft.ContainerService/stable/2017-01-31/containerService.json
  - $(this-folder)/Microsoft.ContainerService/stable/2016-09-30/containerService.json
  - $(this-folder)/Microsoft.ContainerService/stable/2016-03-30/containerService.json
require: $(this-folder)/../../../../profiles/readme.md
```
