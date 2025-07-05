## Swagger Changes

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.SignalRService/locations/{location}/checkNameAvailability'].post.parameters[0].name__deleted` | deleted | `location` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.SignalRService/locations/{location}/usages'].get.parameters[0].name__deleted` | deleted | `location` |

### Changes for `in`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.SignalRService/locations/{location}/checkNameAvailability'].post.parameters[0].in__deleted` | deleted | `path` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.SignalRService/locations/{location}/usages'].get.parameters[0].in__deleted` | deleted | `path` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CustomCertificateList.required__added` | added | `["value"]` |
| `definitions.CustomDomainList.required__added` | added | `["value"]` |
| `definitions.PrivateEndpointConnectionList.required__added` | added | `["value"]` |
| `definitions.PrivateLinkResourceList.required__added` | added | `["value"]` |
| `definitions.ReplicaList.required__added` | added | `["value"]` |
| `definitions.SharedPrivateLinkResourceList.required__added` | added | `["value"]` |
| `definitions.SignalRResourceList.required__added` | added | `["value"]` |
| `definitions.SignalRUsageList.required__added` | added | `["value"]` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.SignalRService/locations/{location}/checkNameAvailability'].post.parameters[0].required__deleted` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.SignalRService/locations/{location}/usages'].get.parameters[0].required__deleted` | deleted | `true` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.SignalRService/locations/{location}/checkNameAvailability'].post.parameters[0].type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.SignalRService/locations/{location}/usages'].get.parameters[0].type__deleted` | deleted | `string` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.SignalRService/locations/{location}/checkNameAvailability'].post.parameters[0].$ref__added` | added | `../../../../../common-types/resource-management/v5/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.SignalRService/locations/{location}/usages'].get.parameters[0].$ref__added` | added | `../../../../../common-types/resource-management/v5/types.json#/parameters/LocationParameter` |

### Changes for `x-ms-long-running-operation-options`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}'].put['x-ms-long-running-operation-options__deleted']` | deleted | `{"final-state-via":"azure-async-operation"}` |

### Changes for `consumes`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/customCertificates/{certificateName}'].put.consumes__deleted` | deleted | `["application/json","text/json"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/customDomains/{name}'].put.consumes__deleted` | deleted | `["application/json","text/json"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/replicas/{replicaName}'].patch.consumes__deleted` | deleted | `["application/json","text/json"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/replicas/{replicaName}'].put.consumes__deleted` | deleted | `["application/json","text/json"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/replicas/{replicaName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}'].put.consumes__deleted` | deleted | `["application/json","text/json"]` |

### Changes for `schema`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/regenerateKey'].post.responses.202.schema__deleted` | deleted | `{"$ref":"#/definitions/SignalRKeys"}` |

### Changes for `minLength`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/replicas/{replicaName}/sharedPrivateLinkResources'].get.parameters[0].minLength__deleted` | deleted | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/replicas/{replicaName}/sharedPrivateLinkResources'].get.parameters[1].minLength__deleted` | deleted | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/replicas/{replicaName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}'].get.parameters[0].minLength__deleted` | deleted | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/replicas/{replicaName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}'].get.parameters[1].minLength__deleted` | deleted | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/replicas/{replicaName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}'].get.parameters[2].minLength__deleted` | deleted | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/replicas/{replicaName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}'].put.parameters[0].minLength__deleted` | deleted | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/replicas/{replicaName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}'].put.parameters[1].minLength__deleted` | deleted | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/replicas/{replicaName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}'].put.parameters[2].minLength__deleted` | deleted | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/sharedPrivateLinkResources'].get.parameters[0].minLength__deleted` | deleted | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}'].delete.parameters[1].minLength__deleted` | deleted | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}'].get.parameters[1].minLength__deleted` | deleted | `3` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}'].put.parameters[1].minLength__deleted` | deleted | `3` |

### Changes for `maxLength`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/replicas/{replicaName}/sharedPrivateLinkResources'].get.parameters[0].maxLength__deleted` | deleted | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/replicas/{replicaName}/sharedPrivateLinkResources'].get.parameters[1].maxLength__deleted` | deleted | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/replicas/{replicaName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}'].get.parameters[0].maxLength__deleted` | deleted | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/replicas/{replicaName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}'].get.parameters[1].maxLength__deleted` | deleted | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/replicas/{replicaName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}'].get.parameters[2].maxLength__deleted` | deleted | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/replicas/{replicaName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}'].put.parameters[0].maxLength__deleted` | deleted | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/replicas/{replicaName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}'].put.parameters[1].maxLength__deleted` | deleted | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/replicas/{replicaName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}'].put.parameters[2].maxLength__deleted` | deleted | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/sharedPrivateLinkResources'].get.parameters[0].maxLength__deleted` | deleted | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}'].delete.parameters[1].maxLength__deleted` | deleted | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}'].get.parameters[1].maxLength__deleted` | deleted | `63` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}'].put.parameters[1].maxLength__deleted` | deleted | `63` |

### Changes for `Dimension`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Dimension__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"displayName":{"type":"string"},"internalNam...` |

### Changes for `LogSpecification`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LogSpecification__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"displayName":{"type":"string"}}}` |

### Changes for `MetricSpecification`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.MetricSpecification__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"displayName":{"type":"string"},"displayDesc...` |

### Changes for `Operation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Operation__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"isDataAction":{"type":"boolean"},"display":...` |

### Changes for `OperationDisplay`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationDisplay__deleted` | deleted | `{"type":"object","properties":{"provider":{"type":"string"},"resource":{"type":"string"},"operation"...` |

### Changes for `OperationList`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationList__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `OperationProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationProperties__deleted` | deleted | `{"type":"object","properties":{"serviceSpecification":{"$ref":"#/definitions/ServiceSpecification"}}...` |

### Changes for `ServiceSpecification`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceSpecification__deleted` | deleted | `{"type":"object","properties":{"metricSpecifications":{"type":"array","items":{"$ref":"#/definitions...` |

### Changes for `Azure.ResourceManager.ArmResponse<SignalRKeys>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<SignalRKeys>__added']` | added | `{"type":"object","properties":{"body":{"$ref":"#/definitions/SignalRKeys"}},"required":["body"]}` |

### Changes for `TypeSpec.Http.NoContentResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['TypeSpec.Http.NoContentResponse__added']` | added | `{"type":"object"}` |

### Changes for `maxItems`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationFirewallSettings.properties.clientConnectionCountRules.maxItems__deleted` | deleted | `10` |
| `definitions.ApplicationFirewallSettings.properties.clientTrafficControlRules.maxItems__deleted` | deleted | `10` |
| `definitions.SignalRNetworkACLs.properties.ipRules.maxItems__deleted` | deleted | `30` |

### Changes for `minimum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationFirewallSettings.properties.maxClientConnectionLifetimeInSeconds.minimum__deleted` | deleted | `0` |
| `definitions.RouteSettings.properties.connectionBalanceWeight.minimum__deleted` | deleted | `0` |
| `definitions.RouteSettings.properties.latencyWeight.minimum__deleted` | deleted | `0` |
| `definitions.RouteSettings.properties.serverBalanceWeight.minimum__deleted` | deleted | `0` |
| `definitions.ThrottleByJwtCustomClaimRule.properties.maxCount.minimum__deleted` | deleted | `0` |
| `definitions.ThrottleByJwtSignatureRule.properties.maxCount.minimum__deleted` | deleted | `0` |
| `definitions.ThrottleByUserIdRule.properties.maxCount.minimum__deleted` | deleted | `0` |
| `definitions.TrafficThrottleByJwtCustomClaimRule.properties.maxInboundMessageBytes.minimum__deleted` | deleted | `0` |
| `definitions.TrafficThrottleByJwtSignatureRule.properties.maxInboundMessageBytes.minimum__deleted` | deleted | `0` |
| `definitions.TrafficThrottleByUserIdRule.properties.maxInboundMessageBytes.minimum__deleted` | deleted | `0` |

### Changes for `x-ms-secret`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SignalRKeys.properties.primaryConnectionString['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.SignalRKeys.properties.primaryKey['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.SignalRKeys.properties.secondaryConnectionString['x-ms-secret__deleted']` | deleted | `true` |
| `definitions.SignalRKeys.properties.secondaryKey['x-ms-secret__deleted']` | deleted | `true` |

### Changes for `default`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SignalRProperties.properties.disableAadAuth.default__deleted` | deleted | `false` |
| `definitions.SignalRProperties.properties.disableLocalAuth.default__deleted` | deleted | `false` |
| `definitions.SignalRTlsSettings.properties.clientCertEnabled.default__deleted` | deleted | `false` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `paths['/providers/Microsoft.SignalRService/operations'].get.responses.200.schema.$ref` | `#/definitions/OperationList` | `../../../../../common-types/resource-management/v5/types.json#/definitions/OperationListResult` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.SignalRService/locations/{location}/checkNameAvailability'].post.parameters[1].name` | `parameters` | `body` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/customDomains/{name}'].put['x-ms-long-running-operation-options']['final-state-via']` | `azure-async-operation` | `original-uri` |

