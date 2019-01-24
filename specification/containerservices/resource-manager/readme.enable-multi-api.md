# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - >-
    Microsoft.ContainerService/preview/2018-09-30-preview/openShiftManagedClusters.json
  - Microsoft.ContainerService/stable/2017-07-01/containerService.json
  - Microsoft.ContainerService/preview/2018-08-01-preview/managedClusters.json
  - Microsoft.ContainerService/stable/2017-09-30/location.json
  - Microsoft.ContainerService/stable/2018-03-31/managedClusters.json
  - Microsoft.ContainerService/stable/2017-08-31/managedClusters.json
  - Microsoft.ContainerService/stable/2017-01-31/containerService.json
  - Microsoft.ContainerService/stable/2016-09-30/containerService.json
  - Microsoft.ContainerService/stable/2016-03-30/containerService.json
```
