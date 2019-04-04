# Multi-API support for AutoRest v3 generators

> see https://aka.ms/autorest

``` yaml $(enable-multi-api)
input-file:
  - Microsoft.Fabric.Admin/preview/2016-05-01/Fabric.json
  - Microsoft.Fabric.Admin/preview/2016-05-01/EdgeGateway.json
  - Microsoft.Fabric.Admin/preview/2016-05-01/EdgeGatewayPool.json
  - Microsoft.Fabric.Admin/preview/2016-05-01/FabricLocation.json
  - Microsoft.Fabric.Admin/preview/2016-05-01/FileShare.json
  - Microsoft.Fabric.Admin/preview/2016-05-01/InfraRole.json
  - Microsoft.Fabric.Admin/preview/2016-05-01/InfraRoleInstance.json
  - Microsoft.Fabric.Admin/preview/2016-05-01/IpPool.json
  - Microsoft.Fabric.Admin/preview/2016-05-01/LogicalNetwork.json
  - Microsoft.Fabric.Admin/preview/2016-05-01/StoragePool.json
  - Microsoft.Fabric.Admin/preview/2016-05-01/StorageSystem.json
  - Microsoft.Fabric.Admin/preview/2016-05-01/Volume.json
  - Microsoft.Fabric.Admin/preview/2016-05-01/LogicalSubnet.json
  - Microsoft.Fabric.Admin/preview/2016-05-01/MacAddressPool.json
  - Microsoft.Fabric.Admin/preview/2016-05-01/ScaleUnit.json
  - Microsoft.Fabric.Admin/preview/2016-05-01/ScaleUnitNode.json
  - Microsoft.Fabric.Admin/preview/2016-05-01/SlbMuxInstance.json
  - Microsoft.Fabric.Admin/preview/2018-10-01/Drive.json
  - Microsoft.Fabric.Admin/preview/2018-10-01/StorageSubSystem.json
  - Microsoft.Fabric.Admin/preview/2018-10-01/Volume.json
require: $(this-folder)/../../../../../profiles/readme.md
```
