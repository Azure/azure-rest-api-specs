# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - Microsoft.ContainerRegistry/stable/2017-10-01/containerregistry.json
  - Microsoft.ContainerRegistry/stable/2018-09-01/containerregistry_build.json
  - Microsoft.ContainerRegistry/preview/2018-02-01-preview/containerregistry_build.json
  - Microsoft.ContainerRegistry/preview/2017-06-01-preview/containerregistry.json
  - Microsoft.ContainerRegistry/stable/2017-03-01/containerregistry.json
  - Microsoft.ContainerRegistry/preview/2016-06-27-preview/containerregistry.json
require: ../../../../profiles/readme.md
```
