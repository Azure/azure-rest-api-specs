# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.ContainerInstance/stable/2018-10-01/containerInstance.json
  - $(this-folder)/Microsoft.ContainerInstance/stable/2018-09-01/containerInstance.json
  - $(this-folder)/Microsoft.ContainerInstance/stable/2018-06-01/containerInstance.json
  - $(this-folder)/Microsoft.ContainerInstance/stable/2018-04-01/containerInstance.json
  - $(this-folder)/Microsoft.ContainerInstance/preview/2018-02-01-preview/containerInstance.json
  - $(this-folder)/Microsoft.ContainerInstance/preview/2017-12-01-preview/containerInstance.json
  - $(this-folder)/Microsoft.ContainerInstance/preview/2017-10-01-preview/containerInstance.json
  - $(this-folder)/Microsoft.ContainerInstance/preview/2017-08-01-preview/containerInstance.json
require: $(this-folder)/../../../../profiles/readme.md
```
