

``` yaml

library-name: ArcScVmm
# default tag is a preview version
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/ba936cf8f3b4720dc025837281241fdc903f7e4d/specification/scvmm/resource-manager/readme.md
skip-csproj: true
modelerfour:
  flatten-payloads: false

format-by-name-rules:
  'tenantId': 'uuid'
  'etag': 'etag'
  'location': 'azure-location'
  '*Uri': 'Uri'
  '*Uris': 'Uri'


rename-mapping:
  AvailabilitySet: ScVmmAvailabilitySet
  Cloud: ScVmmCloud
  VMMServer: ScVmmServer
  VirtualMachine: ScVmmVirtualMachine
  VirtualMachineTemplate: ScVmmVirtualMachineTemplate
  VirtualNetwork: ScVmmVirtualNetwork

directive:
  - from: swagger-document
    where: $.definitions.InventoryItem.properties.properties
    transform: $["x-ms-client-flatten"] = false;
```
