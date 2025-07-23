## Swagger Changes

### Changes for `Condition`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Condition__deleted` | deleted | `{"type":"object","properties":{"status":{"type":"string","readOnly":true},"reason":{"type":"string",...` |

### Changes for `operation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.operation__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"isDataAction":{"type":"boolean"},"display":...` |

### Changes for `operationsList`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.operationsList__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"nextLink":{...` |

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

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GuestAgent.allOf[0].description__deleted` | deleted | `The resource model definition for an Azure Resource Manager proxy resource. It will have everything other than required location and tags.` |
| `definitions.InventoryItem.allOf[0].description__deleted` | deleted | `The resource model definition for an Azure Resource Manager proxy resource. It will have everything other than required location and tags.` |
| `definitions.VirtualMachineInstance.allOf[0].description__deleted` | deleted | `The resource model definition for an Azure Resource Manager proxy resource. It will have everything other than location and tags.` |
| `definitions.VmInstanceHybridIdentityMetadata.allOf[0].description__deleted` | deleted | `The resource model definition for an Azure Resource Manager proxy resource. It will have everything other than required location and tags.` |

### Changes for `format`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GuestCredential.properties.password.format__added` | added | `password` |
| `definitions.GuestCredential.properties.privateKey.format__added` | added | `password` |
| `definitions.OsProfileForVMInstance.properties.adminPassword.format__added` | added | `password` |
| `definitions.VICredential.properties.password.format__added` | added | `password` |
| `definitions.WindowsConfiguration.properties.domainUserPassword.format__added` | added | `password` |

### Changes for `x-ms-client-flatten`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InventoryItem.properties.properties['x-ms-client-flatten__deleted']` | deleted | `true` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.GuestAgent.allOf[0].$ref` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.InventoryItem.allOf[0].$ref` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.VirtualMachineInstance.allOf[0].$ref` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.VmInstanceHybridIdentityMetadata.allOf[0].$ref` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `paths['/providers/Microsoft.ConnectedVMwarevSphere/operations'].get.responses.200.schema.$ref` | `#/definitions/operationsList` | `../../../../../common-types/resource-management/v3/types.json#/definitions/OperationListResult` |

