# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/Fabric.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/EdgeGateway.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/EdgeGatewayPool.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/FabricLocation.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/FileShare.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/InfraRole.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/InfraRoleInstance.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/IpPool.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/LogicalNetwork.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/StoragePool.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/StorageSystem.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/Volume.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/LogicalSubnet.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/MacAddressPool.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/ScaleUnit.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/ScaleUnitNode.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2016-05-01/SlbMuxInstance.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2018-10-01/Drive.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2018-10-01/StorageSubSystem.json
  - $(this-folder)/Microsoft.Fabric.Admin/preview/2018-10-01/Volume.json
require: $(this-folder)/../../../../../profiles/readme.md
```
