# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.Compute/stable/2018-10-01/compute.json
  - $(this-folder)/Microsoft.Compute/stable/2018-10-01/runCommands.json
  - $(this-folder)/Microsoft.Compute/stable/2017-09-01/skus.json
  - $(this-folder)/Microsoft.Compute/stable/2018-09-30/disk.json
  - $(this-folder)/Microsoft.Compute/stable/2018-06-01/gallery.json
  - $(this-folder)/Microsoft.ContainerService/stable/2017-01-31/containerService.json
  - $(this-folder)/Microsoft.Compute/stable/2018-06-01/disk.json
  - $(this-folder)/Microsoft.Compute/stable/2018-06-01/compute.json
  - $(this-folder)/Microsoft.Compute/stable/2018-06-01/runCommands.json
  - $(this-folder)/Microsoft.Compute/stable/2018-04-01/compute.json
  - $(this-folder)/Microsoft.Compute/stable/2018-04-01/runCommands.json
  - $(this-folder)/Microsoft.Compute/stable/2018-04-01/disk.json
  - $(this-folder)/Microsoft.Compute/stable/2017-12-01/compute.json
  - $(this-folder)/Microsoft.Compute/stable/2017-12-01/runCommands.json
  - $(this-folder)/Microsoft.Compute/stable/2017-03-30/disk.json
  - $(this-folder)/Microsoft.Compute/stable/2017-03-30/compute.json
  - $(this-folder)/Microsoft.Compute/stable/2017-03-30/runCommands.json
  - $(this-folder)/Microsoft.ContainerService/stable/2016-09-30/containerService.json
  - $(this-folder)/Microsoft.Compute/preview/2016-04-30-preview/compute.json
  - $(this-folder)/Microsoft.Compute/preview/2016-04-30-preview/disk.json
  - $(this-folder)/Microsoft.Compute/stable/2016-03-30/compute.json
  - $(this-folder)/Microsoft.ContainerService/stable/2016-03-30/containerService.json
  - $(this-folder)/Microsoft.ContainerService/preview/2015-11-01-preview/containerService.json
  - $(this-folder)/Microsoft.Compute/stable/2015-06-15/compute.json
require: $(this-folder)/../../../../profiles/readme.md
```
