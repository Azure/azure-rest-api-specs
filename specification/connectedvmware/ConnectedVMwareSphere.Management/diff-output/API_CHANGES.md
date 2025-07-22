## Swagger Changes

### Changes for `x-ms-skip-url-encoding`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/{resourceUri}/providers/Microsoft.ConnectedVMwarevSphere/virtualMachineInstances/default'].patch.parameters[0]['x-ms-skip-url-encoding__deleted']` | deleted | `true` |
| `paths['/{resourceUri}/providers/Microsoft.ConnectedVMwarevSphere/virtualMachineInstances/default'].put.parameters[0]['x-ms-skip-url-encoding__deleted']` | deleted | `true` |
| `paths['/{resourceUri}/providers/Microsoft.ConnectedVMwarevSphere/virtualMachineInstances/default/guestAgents/default'].put.parameters[0]['x-ms-skip-url-encoding__deleted']` | deleted | `true` |

### Changes for `Condition`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Condition__deleted` | deleted | `{"type":"object","properties":{"status":{"type":"string","readOnly":true},"reason":{"type":"string",...` |

### Changes for `VirtualSCSIController`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualSCSIController__deleted` | deleted | `{"type":"object","properties":{"type":{"type":"string","enum":["lsilogic","buslogic","pvscsi","lsilo...` |

### Changes for `operation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.operation__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"isDataAction":{"type":"boolean"},"display":...` |

### Changes for `operationsList`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.operationsList__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"nextLink":{...` |

### Changes for `VirtualScsiController`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualScsiController__added` | added | `{"type":"object","properties":{"type":{"type":"string","enum":["lsilogic","buslogic","pvscsi","lsilo...` |

### Changes for `allOf`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Cluster.allOf__added` | added | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource...` |
| `definitions.Datastore.allOf__added` | added | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource...` |
| `definitions.Host.allOf__added` | added | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource...` |
| `definitions.ResourcePool.allOf__added` | added | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource...` |
| `definitions.VCenter.allOf__added` | added | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource...` |
| `definitions.VirtualMachineTemplate.allOf__added` | added | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource...` |
| `definitions.VirtualNetwork.allOf__added` | added | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource...` |

### Changes for `location`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Cluster.properties.location__deleted` | deleted | `{"type":"string","x-ms-mutability":["create","read"]}` |
| `definitions.Datastore.properties.location__deleted` | deleted | `{"type":"string","x-ms-mutability":["create","read"]}` |
| `definitions.Host.properties.location__deleted` | deleted | `{"type":"string","x-ms-mutability":["create","read"]}` |
| `definitions.ResourcePool.properties.location__deleted` | deleted | `{"type":"string","x-ms-mutability":["create","read"]}` |
| `definitions.VCenter.properties.location__deleted` | deleted | `{"type":"string","x-ms-mutability":["create","read"]}` |
| `definitions.VirtualMachineTemplate.properties.location__deleted` | deleted | `{"type":"string","x-ms-mutability":["create","read"]}` |
| `definitions.VirtualNetwork.properties.location__deleted` | deleted | `{"type":"string","x-ms-mutability":["create","read"]}` |

### Changes for `systemData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Cluster.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../common-types/resource-management/v2/types.json#/definitions/systemData"}` |
| `definitions.Datastore.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../common-types/resource-management/v2/types.json#/definitions/systemData"}` |
| `definitions.Host.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../common-types/resource-management/v2/types.json#/definitions/systemData"}` |
| `definitions.ResourcePool.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../common-types/resource-management/v2/types.json#/definitions/systemData"}` |
| `definitions.VCenter.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../common-types/resource-management/v2/types.json#/definitions/systemData"}` |
| `definitions.VirtualMachineTemplate.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../common-types/resource-management/v2/types.json#/definitions/systemData"}` |
| `definitions.VirtualNetwork.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../common-types/resource-management/v2/types.json#/definitions/systemData"}` |

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Cluster.properties.tags__deleted` | deleted | `{"type":"object","additionalProperties":{"type":"string"}}` |
| `definitions.Datastore.properties.tags__deleted` | deleted | `{"type":"object","additionalProperties":{"type":"string"}}` |
| `definitions.Host.properties.tags__deleted` | deleted | `{"type":"object","additionalProperties":{"type":"string"}}` |
| `definitions.ResourcePool.properties.tags__deleted` | deleted | `{"type":"object","additionalProperties":{"type":"string"}}` |
| `definitions.VCenter.properties.tags__deleted` | deleted | `{"type":"object","additionalProperties":{"type":"string"}}` |
| `definitions.VirtualMachineTemplate.properties.tags__deleted` | deleted | `{"type":"object","additionalProperties":{"type":"string"}}` |
| `definitions.VirtualNetwork.properties.tags__deleted` | deleted | `{"type":"object","additionalProperties":{"type":"string"}}` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Cluster.properties.name__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.Datastore.properties.name__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.Host.properties.name__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.ResourcePool.properties.name__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.VCenter.properties.name__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.VirtualMachineTemplate.properties.name__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.VirtualNetwork.properties.name__deleted` | deleted | `{"type":"string","readOnly":true}` |

### Changes for `id`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Cluster.properties.id__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.Datastore.properties.id__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.Host.properties.id__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.ResourcePool.properties.id__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.VCenter.properties.id__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.VirtualMachineTemplate.properties.id__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.VirtualNetwork.properties.id__deleted` | deleted | `{"type":"string","readOnly":true}` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Cluster.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.Datastore.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.Host.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.ResourcePool.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.VCenter.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.VirtualMachineTemplate.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.VirtualNetwork.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |

### Changes for `x-ms-discriminator-value`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ClusterInventoryItem['x-ms-discriminator-value__deleted']` | deleted | `Cluster` |
| `definitions.DatastoreInventoryItem['x-ms-discriminator-value__deleted']` | deleted | `Datastore` |
| `definitions.HostInventoryItem['x-ms-discriminator-value__deleted']` | deleted | `Host` |
| `definitions.ResourcePoolInventoryItem['x-ms-discriminator-value__deleted']` | deleted | `ResourcePool` |
| `definitions.VirtualMachineInventoryItem['x-ms-discriminator-value__deleted']` | deleted | `VirtualMachine` |
| `definitions.VirtualMachineTemplateInventoryItem['x-ms-discriminator-value__deleted']` | deleted | `VirtualMachineTemplate` |
| `definitions.VirtualNetworkInventoryItem['x-ms-discriminator-value__deleted']` | deleted | `VirtualNetwork` |

### Changes for `properties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ClusterInventoryItem.properties__added` | added | `{"inventoryType":{"type":"string","enum":["Cluster"],"x-ms-enum":{"modelAsString":false}}}` |
| `definitions.VirtualNetworkInventoryItem.properties__added` | added | `{"inventoryType":{"type":"string","enum":["VirtualNetwork"],"x-ms-enum":{"modelAsString":false}}}` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ClusterInventoryItem.required__added` | added | `["inventoryType"]` |
| `definitions.DatastoreInventoryItem.required__added` | added | `["inventoryType"]` |
| `definitions.HostInventoryItem.required__added` | added | `["inventoryType"]` |
| `definitions.ResourcePoolInventoryItem.required__added` | added | `["inventoryType"]` |
| `definitions.VirtualMachineInventoryItem.required__added` | added | `["inventoryType"]` |
| `definitions.VirtualMachineTemplateInventoryItem.required__added` | added | `["inventoryType"]` |
| `definitions.VirtualNetworkInventoryItem.required__added` | added | `["inventoryType"]` |

### Changes for `inventoryType`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DatastoreInventoryItem.properties.inventoryType__added` | added | `{"type":"string","enum":["Datastore"],"x-ms-enum":{"modelAsString":false}}` |
| `definitions.HostInventoryItem.properties.inventoryType__added` | added | `{"type":"string","enum":["Host"],"x-ms-enum":{"modelAsString":false}}` |
| `definitions.ResourcePoolInventoryItem.properties.inventoryType__added` | added | `{"type":"string","enum":["ResourcePool"],"x-ms-enum":{"modelAsString":false}}` |
| `definitions.VirtualMachineInventoryItem.properties.inventoryType__added` | added | `{"type":"string","enum":["VirtualMachine"],"x-ms-enum":{"modelAsString":false}}` |
| `definitions.VirtualMachineTemplateInventoryItem.properties.inventoryType__added` | added | `{"type":"string","enum":["VirtualMachineTemplate"],"x-ms-enum":{"modelAsString":false}}` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GuestAgent.allOf[0].description__deleted` | deleted | `The resource model definition for an Azure Resource Manager proxy resource. It will have everything other than required location and tags.` |
| `definitions.InventoryItem.allOf[0].description__deleted` | deleted | `The resource model definition for an Azure Resource Manager proxy resource. It will have everything other than required location and tags.` |
| `definitions.VirtualMachineInstance.allOf[0].description__deleted` | deleted | `The resource model definition for an Azure Resource Manager proxy resource. It will have everything other than location and tags.` |
| `definitions.VmInstanceHybridIdentityMetadata.allOf[0].description__deleted` | deleted | `The resource model definition for an Azure Resource Manager proxy resource. It will have everything other than required location and tags.` |

### Changes for `x-ms-secret`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GuestCredential.properties.password['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.GuestCredential.properties.privateKey['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.OsProfileForVMInstance.properties.adminPassword['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.VICredential.properties.password['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.WindowsConfiguration.properties.domainUserPassword['x-ms-secret__deleted']` | deleted | `true` |

### Changes for `discriminator`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InventoryItemProperties.discriminator__deleted` | deleted | `inventoryType` |

### Changes for `default`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.StopVirtualMachineOptions.properties.skipShutdown.default__deleted` | deleted | `false` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.GuestAgent.allOf[0].$ref` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.InventoryItem.allOf[0].$ref` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.StorageProfile.properties.scsiControllers.items.$ref` | `#/definitions/VirtualSCSIController` | `#/definitions/VirtualScsiController` |
| `definitions.VirtualMachineInstance.allOf[0].$ref` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.VmInstanceHybridIdentityMetadata.allOf[0].$ref` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `paths['/providers/Microsoft.ConnectedVMwarevSphere/operations'].get.responses.200.schema.$ref` | `#/definitions/operationsList` | `../../../../../common-types/resource-management/v3/types.json#/definitions/OperationListResult` |

