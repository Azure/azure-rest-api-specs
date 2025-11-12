## Changed Paths

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/addons
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/addons/{addonName}
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/monitoringConfig
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/monitoringConfig/default
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/roles/{roleName}/addons
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/roles/{roleName}/addons/{addonName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/roles/{roleName}/monitoringConfig
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/roles/{roleName}/monitoringConfig/default
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/securitySettings/default/update
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/update
Change Type: added

## Swagger Changes

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `info.description__added` | added | `// (missing-service-description) Add service description` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/roles/{roleName}/addons`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/roles/{roleName}/addons__deleted']` | deleted | `{"get":{"operationId":"Addons_ListByRole","parameters":[{"name":"deviceName","in":"path","required":...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/roles/{roleName}/addons/{addonName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/roles/{roleName}/addons/{addonName}__deleted']` | deleted | `{"get":{"operationId":"Addons_Get","parameters":[{"name":"deviceName","in":"path","required":true,"t...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/roles/{roleName}/monitoringConfig`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/roles/{roleName}/monitoringConfig__deleted']` | deleted | `{"get":{"operationId":"MonitoringConfig_List","parameters":[{"name":"deviceName","in":"path","requir...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/roles/{roleName}/monitoringConfig/default`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/roles/{roleName}/monitoringConfig/default__deleted']` | deleted | `{"get":{"operationId":"MonitoringConfig_Get","parameters":[{"name":"deviceName","in":"path","require...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/securitySettings/default/update`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/securitySettings/default/update__deleted']` | deleted | `{"post":{"operationId":"Devices_CreateOrUpdateSecuritySettings","parameters":[{"name":"deviceName","...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/addons`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/addons__added']` | added | `{"get":{"operationId":"Addons_ListByRole","parameters":[{"name":"deviceName","in":"path","required":...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/addons/{addonName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/addons/{addonName}__added']` | added | `{"get":{"operationId":"Addons_Get","parameters":[{"name":"deviceName","in":"path","required":true,"t...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/monitoringConfig`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/monitoringConfig__added']` | added | `{"get":{"operationId":"MonitoringConfig_List","parameters":[{"name":"deviceName","in":"path","requir...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/monitoringConfig/default`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/monitoringConfig/default__added']` | added | `{"get":{"operationId":"MonitoringConfig_Get","parameters":[{"name":"deviceName","in":"path","require...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/update`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/update__added']` | added | `{"post":{"operationId":"Devices_CreateOrUpdateSecuritySettings","parameters":[{"name":"deviceName","...` |

### Changes for `x-ms-pageable`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DataBoxEdge/availableSkus'].get['x-ms-pageable__deleted']` | deleted | `{"nextLinkName":"nextLink"}` |

### Changes for `headers`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/bandwidthSchedules/{name}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/bandwidthSchedules/{name}'].put.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/deviceCapacityCheck'].post.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/diagnosticProactiveLogCollectionSettings/default'].put.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/diagnosticRemoteSupportSettings/default'].put.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/downloadUpdates'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/installUpdates'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/orders/default'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/orders/default'].put.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/roles/{name}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/roles/{name}'].put.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/scanForUpdates'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/shares/{name}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/shares/{name}'].put.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/shares/{name}/refresh'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/storageAccountCredentials/{name}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/storageAccountCredentials/{name}'].put.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/storageAccounts/{storageAccountName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/storageAccounts/{storageAccountName}'].put.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/storageAccounts/{storageAccountName}/containers/{containerName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/storageAccounts/{storageAccountName}/containers/{containerName}'].put.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/storageAccounts/{storageAccountName}/containers/{containerName}/refresh'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/triggers/{name}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/triggers/{name}'].put.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/triggerSupportPackage'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/users/{name}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/users/{name}'].put.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |

### Changes for `CloudError`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CloudError__deleted` | deleted | `{"type":"object","properties":{"error":{"$ref":"#/definitions/CloudErrorBody"}},"x-ms-external":true...` |

### Changes for `CloudErrorBody`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CloudErrorBody__deleted` | deleted | `{"type":"object","properties":{"code":{"type":"string"},"message":{"type":"string"},"details":{"type...` |

### Changes for `DataBoxEdgeMoveRequest`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataBoxEdgeMoveRequest__deleted` | deleted | `{"type":"object","properties":{"targetResourceGroup":{"type":"string"},"resources":{"type":"array","...` |

### Changes for `MetricDimension_V1`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MetricDimension_V1__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"displayName":{"type":"string"},"toBeExporte...` |

### Changes for `MetricSpecification_V1`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MetricSpecification_V1__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"displayName":{"type":"string"},"displayDesc...` |

### Changes for `Operation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Operation__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"isDataAction":{"type":"boolean"},"display":...` |

### Changes for `OperationDisplay`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationDisplay__deleted` | deleted | `{"type":"object","properties":{"provider":{"type":"string"},"resource":{"type":"string"},"operation"...` |

### Changes for `OperationProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationProperties__deleted` | deleted | `{"type":"object","properties":{"serviceSpecification":{"$ref":"#/definitions/ServiceSpecification"}}...` |

### Changes for `OperationsList`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationsList__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `ServiceSpecification`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceSpecification__deleted` | deleted | `{"type":"object","properties":{"metricSpecifications":{"type":"array","items":{"$ref":"#/definitions...` |

### Changes for `TypeSpec.Http.NoContentResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['TypeSpec.Http.NoContentResponse__added']` | added | `{"type":"object"}` |

### Changes for `TypeSpec.Http.OkResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['TypeSpec.Http.OkResponse__added']` | added | `{"type":"object"}` |

### Changes for `discriminator`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Addon.discriminator__deleted` | deleted | `kind` |
| `definitions.Role.discriminator__deleted` | deleted | `kind` |
| `definitions.Trigger.discriminator__deleted` | deleted | `kind` |

### Changes for `systemData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Addon.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v2/types.json#/definitions/systemData","...` |
| `definitions.Alert.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v2/types.json#/definitions/systemData","...` |
| `definitions.BandwidthSchedule.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v2/types.json#/definitions/systemData","...` |
| `definitions.Container.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v2/types.json#/definitions/systemData","...` |
| `definitions.DataBoxEdgeDevice.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v2/types.json#/definitions/systemData","...` |
| `definitions.DeviceCapacityInfo.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v2/types.json#/definitions/systemData","...` |
| `definitions.DiagnosticProactiveLogCollectionSettings.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v2/types.json#/definitions/systemData","...` |
| `definitions.DiagnosticRemoteSupportSettings.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v2/types.json#/definitions/systemData","...` |
| `definitions.MonitoringMetricConfiguration.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v2/types.json#/definitions/systemData","...` |
| `definitions.NetworkSettings.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v2/types.json#/definitions/systemData","...` |
| `definitions.Order.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v2/types.json#/definitions/systemData","...` |
| `definitions.Role.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v2/types.json#/definitions/systemData","...` |
| `definitions.Share.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v2/types.json#/definitions/systemData","...` |
| `definitions.StorageAccount.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v2/types.json#/definitions/systemData","...` |
| `definitions.StorageAccountCredential.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v2/types.json#/definitions/systemData","...` |
| `definitions.Trigger.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v2/types.json#/definitions/systemData","...` |
| `definitions.UpdateSummary.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v2/types.json#/definitions/systemData","...` |
| `definitions.User.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../../common-types/resource-management/v2/types.json#/definitions/systemData","...` |

### Changes for `properties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Addon.properties.properties__added` | added | `{"type":"object"}` |
| `definitions.Role.properties.properties__added` | added | `{"type":"object"}` |
| `definitions.Trigger.properties.properties__added` | added | `{"type":"object"}` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AddonList.required__added` | added | `["value"]` |
| `definitions.AlertList.required__added` | added | `["value"]` |
| `definitions.BandwidthSchedulesList.required__added` | added | `["value"]` |
| `definitions.ContainerList.required__added` | added | `["value"]` |
| `definitions.DataBoxEdgeDevice.required__deleted` | deleted | `["location"]` |
| `definitions.DataBoxEdgeDeviceList.required__added` | added | `["value"]` |
| `definitions.DataBoxEdgeSkuList.required__added` | added | `["value"]` |
| `definitions.MonitoringMetricConfigurationList.required__added` | added | `["value"]` |
| `definitions.NodeList.required__added` | added | `["value"]` |
| `definitions.OrderList.required__added` | added | `["value"]` |
| `definitions.RoleList.required__added` | added | `["value"]` |
| `definitions.ShareList.required__added` | added | `["value"]` |
| `definitions.StorageAccountCredentialList.required__added` | added | `["value"]` |
| `definitions.StorageAccountList.required__added` | added | `["value"]` |
| `definitions.TriggerList.required__added` | added | `["value"]` |
| `definitions.UserList.required__added` | added | `["value"]` |

### Changes for `readOnly`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AddonList.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.Alert.properties.properties.readOnly__deleted` | deleted | `true` |
| `definitions.AlertList.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.BandwidthSchedulesList.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.ContainerList.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.DataBoxEdgeDeviceList.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.DataBoxEdgeSkuList.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.Job.properties.properties.readOnly__deleted` | deleted | `true` |
| `definitions.MonitoringMetricConfigurationList.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.NetworkSettings.properties.properties.readOnly__deleted` | deleted | `true` |
| `definitions.NodeList.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.OrderList.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.RoleList.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.ShareList.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.StorageAccountCredentialList.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.StorageAccountList.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.TriggerList.properties.value.readOnly__deleted` | deleted | `true` |
| `definitions.UserList.properties.value.readOnly__deleted` | deleted | `true` |

### Changes for `x-ms-discriminator-value`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ArcAddon['x-ms-discriminator-value__deleted']` | deleted | `ArcForKubernetes` |
| `definitions.CloudEdgeManagementRole['x-ms-discriminator-value__deleted']` | deleted | `CloudEdgeManagement` |
| `definitions.FileEventTrigger['x-ms-discriminator-value__deleted']` | deleted | `FileEvent` |
| `definitions.IoTAddon['x-ms-discriminator-value__deleted']` | deleted | `IotEdge` |
| `definitions.IoTRole['x-ms-discriminator-value__deleted']` | deleted | `IOT` |
| `definitions.KubernetesRole['x-ms-discriminator-value__deleted']` | deleted | `Kubernetes` |
| `definitions.MECRole['x-ms-discriminator-value__deleted']` | deleted | `MEC` |
| `definitions.PeriodicTimerEventTrigger['x-ms-discriminator-value__deleted']` | deleted | `PeriodicTimerEvent` |

### Changes for `id`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ArcAddon.properties.id__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.CloudEdgeManagementRole.properties.id__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.FileEventTrigger.properties.id__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.IoTAddon.properties.id__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.IoTRole.properties.id__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.Job.properties.id__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.KubernetesRole.properties.id__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.MECRole.properties.id__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.PeriodicTimerEventTrigger.properties.id__deleted` | deleted | `{"type":"string","readOnly":true}` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ArcAddon.properties.name__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.CloudEdgeManagementRole.properties.name__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.FileEventTrigger.properties.name__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.IoTAddon.properties.name__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.IoTRole.properties.name__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.Job.properties.name__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.KubernetesRole.properties.name__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.MECRole.properties.name__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.PeriodicTimerEventTrigger.properties.name__deleted` | deleted | `{"type":"string","readOnly":true}` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ArcAddon.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.CloudEdgeManagementRole.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.FileEventTrigger.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.IoTAddon.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.IoTRole.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.Job.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.KubernetesRole.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.MECRole.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.PeriodicTimerEventTrigger.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |

### Changes for `kind`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ArcAddon.properties.kind__added` | added | `{"type":"string","enum":["ArcForKubernetes"],"x-ms-enum":{"modelAsString":false}}` |
| `definitions.CloudEdgeManagementRole.properties.kind__added` | added | `{"type":"string","enum":["CloudEdgeManagement"],"x-ms-enum":{"modelAsString":false}}` |
| `definitions.FileEventTrigger.properties.kind__added` | added | `{"type":"string","enum":["FileEvent"],"x-ms-enum":{"modelAsString":false}}` |
| `definitions.IoTAddon.properties.kind__added` | added | `{"type":"string","enum":["IotEdge"],"x-ms-enum":{"modelAsString":false}}` |
| `definitions.IoTRole.properties.kind__added` | added | `{"type":"string","enum":["IOT"],"x-ms-enum":{"modelAsString":false}}` |
| `definitions.KubernetesRole.properties.kind__added` | added | `{"type":"string","enum":["Kubernetes"],"x-ms-enum":{"modelAsString":false}}` |
| `definitions.MECRole.properties.kind__added` | added | `{"type":"string","enum":["MEC"],"x-ms-enum":{"modelAsString":false}}` |
| `definitions.PeriodicTimerEventTrigger.properties.kind__added` | added | `{"type":"string","enum":["PeriodicTimerEvent"],"x-ms-enum":{"modelAsString":false}}` |

### Changes for `x-ms-secret`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AsymmetricEncryptedSecret.properties.encryptionCertThumbprint['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.GenerateCertResponse.properties.privateKey['x-ms-secret__deleted']` | deleted | `true` |

### Changes for `x-ms-identifiers`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BandwidthScheduleProperties.properties.days.items['x-ms-identifiers__deleted']` | deleted | `[]` |
| `definitions.DataBoxEdgeDeviceProperties.properties.configuredRoleTypes.items['x-ms-identifiers__deleted']` | deleted | `[]` |
| `definitions.DataBoxEdgeSkuList.properties.value['x-ms-identifiers__deleted']` | deleted | `["name","resourceType"]` |

### Changes for `location`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataBoxEdgeDevice.properties.location__deleted` | deleted | `{"type":"string","x-ms-mutability":["create","read"]}` |

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DataBoxEdgeDevice.properties.tags__deleted` | deleted | `{"type":"object","additionalProperties":{"type":"string"}}` |

### Changes for `uniqueItems`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DeviceCapacityRequestInfoProperties.properties.vmPlacementQuery.items.uniqueItems__deleted` | deleted | `false` |

### Changes for `allOf`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Job.allOf__added` | added | `[{"$ref":"../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource"}...` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.Addon.allOf[0].$ref` | `#/definitions/ARMBaseModel` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.Alert.allOf[0].$ref` | `#/definitions/ARMBaseModel` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.BandwidthSchedule.allOf[0].$ref` | `#/definitions/ARMBaseModel` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.Container.allOf[0].$ref` | `#/definitions/ARMBaseModel` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.DataBoxEdgeDevice.allOf[0].$ref` | `#/definitions/ARMBaseModel` | `../../../../../common-types/resource-management/v3/types.json#/definitions/TrackedResource` |
| `definitions.DataBoxEdgeDeviceExtendedInfo.properties.systemData.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/systemData` | `../../../../../common-types/resource-management/v3/types.json#/definitions/systemData` |
| `definitions.DataBoxEdgeDeviceProperties.properties.systemData.$ref` | `../../../../../../common-types/resource-management/v2/types.json#/definitions/systemData` | `../../../../../common-types/resource-management/v3/types.json#/definitions/systemData` |
| `definitions.DeviceCapacityInfo.allOf[0].$ref` | `#/definitions/ARMBaseModel` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.DiagnosticProactiveLogCollectionSettings.allOf[0].$ref` | `#/definitions/ARMBaseModel` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.DiagnosticRemoteSupportSettings.allOf[0].$ref` | `#/definitions/ARMBaseModel` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.MonitoringMetricConfiguration.allOf[0].$ref` | `#/definitions/ARMBaseModel` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.NetworkAdapter.properties.dhcpStatus['x-ms-enum'].name` | `NetworkAdapterDHCPStatus` | `NetworkAdapterDhcpStatus` |
| `definitions.NetworkAdapter.properties.rdmaStatus['x-ms-enum'].name` | `NetworkAdapterRDMAStatus` | `NetworkAdapterRdmaStatus` |
| `definitions.NetworkSettings.allOf[0].$ref` | `#/definitions/ARMBaseModel` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.Order.allOf[0].$ref` | `#/definitions/ARMBaseModel` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.Role.allOf[0].$ref` | `#/definitions/ARMBaseModel` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.Share.allOf[0].$ref` | `#/definitions/ARMBaseModel` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.StorageAccount.allOf[0].$ref` | `#/definitions/ARMBaseModel` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.StorageAccountCredential.allOf[0].$ref` | `#/definitions/ARMBaseModel` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.Trigger.allOf[0].$ref` | `#/definitions/ARMBaseModel` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.UpdateSummary.allOf[0].$ref` | `#/definitions/ARMBaseModel` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.User.allOf[0].$ref` | `#/definitions/ARMBaseModel` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `paths['/providers/microsoft.DataBoxEdge/operations'].get.responses.200.schema.$ref` | `#/definitions/OperationsList` | `../../../../../common-types/resource-management/v3/types.json#/definitions/OperationListResult` |
| `paths['/providers/microsoft.DataBoxEdge/operations'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DataBoxEdge/availableSkus'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}'].delete.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}'].patch.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/alerts'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/alerts/{name}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/bandwidthSchedules'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/bandwidthSchedules/{name}'].delete.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/bandwidthSchedules/{name}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/bandwidthSchedules/{name}'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/deviceCapacityCheck'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/deviceCapacityInfo/default'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/diagnosticProactiveLogCollectionSettings/default'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/diagnosticProactiveLogCollectionSettings/default'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/diagnosticRemoteSupportSettings/default'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/diagnosticRemoteSupportSettings/default'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/downloadUpdates'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/generateCertificate'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/getExtendedInformation'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/installUpdates'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/jobs/{name}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/networkSettings/default'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/nodes'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/operationsStatus/{name}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/orders'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/orders/default'].delete.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/orders/default'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/orders/default'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/orders/default/listDCAccessCode'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/roles'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/roles/{name}'].delete.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/roles/{name}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/roles/{name}'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/scanForUpdates'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/shares'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/shares/{name}'].delete.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/shares/{name}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/shares/{name}'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/shares/{name}/refresh'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/storageAccountCredentials'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/storageAccountCredentials/{name}'].delete.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/storageAccountCredentials/{name}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/storageAccountCredentials/{name}'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/storageAccounts'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/storageAccounts/{storageAccountName}'].delete.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/storageAccounts/{storageAccountName}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/storageAccounts/{storageAccountName}'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/storageAccounts/{storageAccountName}/containers'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/storageAccounts/{storageAccountName}/containers/{containerName}'].delete.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/storageAccounts/{storageAccountName}/containers/{containerName}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/storageAccounts/{storageAccountName}/containers/{containerName}'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/storageAccounts/{storageAccountName}/containers/{containerName}/refresh'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/triggers'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/triggers/{name}'].delete.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/triggers/{name}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/triggers/{name}'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/triggerSupportPackage'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/updateExtendedInformation'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/updateSummary/default'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/uploadCertificate'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/users'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/users/{name}'].delete.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/users/{name}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataBoxEdge/dataBoxEdgeDevices/{deviceName}/users/{name}'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |

