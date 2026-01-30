## Changed Paths

Path: /subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/setLoadBalancerFrontendPublicIpAddresses
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/backendAddressPools/{backendPoolName}/queryInboundNatRulePortMapping
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/loadBalancingRules/{loadBalancingRuleName}/health
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/backendAddressPools
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/backendAddressPools/{backendAddressPoolName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/frontendIPConfigurations
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/frontendIPConfigurations/{frontendIPConfigurationName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/inboundNatRules
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/inboundNatRules/{inboundNatRuleName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/loadBalancingRules
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/loadBalancingRules/{loadBalancingRuleName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/outboundRules
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/outboundRules/{outboundRuleName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/probes
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/probes/{probeName}
Change Type: deleted

## Swagger Changes

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/setLoadBalancerFrontendPublicIpAddresses`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/setLoadBalancerFrontendPublicIpAddresses__deleted']` | deleted | `{"post":{"operationId":"LoadBalancers_SwapPublicIpAddresses","parameters":[{"name":"location","in":"...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/backendAddressPools`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/backendAddressPools__deleted']` | deleted | `{"get":{"operationId":"LoadBalancerBackendAddressPools_List","parameters":[{"name":"loadBalancerName...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/backendAddressPools/{backendAddressPoolName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/backendAddressPools/{backendAddressPoolName}__deleted']` | deleted | `{"get":{"operationId":"LoadBalancerBackendAddressPools_Get","parameters":[{"name":"loadBalancerName"...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/backendAddressPools/{backendPoolName}/queryInboundNatRulePortMapping`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/backendAddressPools/{backendPoolName}/queryInboundNatRulePortMapping__deleted']` | deleted | `{"post":{"operationId":"LoadBalancers_ListInboundNatRulePortMappings","parameters":[{"name":"groupNa...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/frontendIPConfigurations`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/frontendIPConfigurations__deleted']` | deleted | `{"get":{"operationId":"LoadBalancerFrontendIPConfigurations_List","parameters":[{"name":"loadBalance...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/frontendIPConfigurations/{frontendIPConfigurationName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/frontendIPConfigurations/{frontendIPConfigurationName}__deleted']` | deleted | `{"get":{"operationId":"LoadBalancerFrontendIPConfigurations_Get","parameters":[{"name":"loadBalancer...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/inboundNatRules`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/inboundNatRules__deleted']` | deleted | `{"get":{"operationId":"InboundNatRules_List","parameters":[{"name":"loadBalancerName","in":"path","r...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/inboundNatRules/{inboundNatRuleName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/inboundNatRules/{inboundNatRuleName}__deleted']` | deleted | `{"get":{"operationId":"InboundNatRules_Get","parameters":[{"name":"loadBalancerName","in":"path","re...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/loadBalancingRules`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/loadBalancingRules__deleted']` | deleted | `{"get":{"operationId":"LoadBalancerLoadBalancingRules_List","parameters":[{"name":"loadBalancerName"...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/loadBalancingRules/{loadBalancingRuleName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/loadBalancingRules/{loadBalancingRuleName}__deleted']` | deleted | `{"get":{"operationId":"LoadBalancerLoadBalancingRules_Get","parameters":[{"name":"loadBalancerName",...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/loadBalancingRules/{loadBalancingRuleName}/health`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/loadBalancingRules/{loadBalancingRuleName}/health__deleted']` | deleted | `{"post":{"operationId":"LoadBalancerLoadBalancingRules_Health","parameters":[{"name":"groupName","in...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/outboundRules`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/outboundRules__deleted']` | deleted | `{"get":{"operationId":"LoadBalancerOutboundRules_List","parameters":[{"name":"loadBalancerName","in"...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/outboundRules/{outboundRuleName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/outboundRules/{outboundRuleName}__deleted']` | deleted | `{"get":{"operationId":"LoadBalancerOutboundRules_Get","parameters":[{"name":"loadBalancerName","in":...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/probes`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/probes__deleted']` | deleted | `{"get":{"operationId":"LoadBalancerProbes_List","parameters":[{"name":"loadBalancerName","in":"path"...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/probes/{probeName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/probes/{probeName}__deleted']` | deleted | `{"get":{"operationId":"LoadBalancerProbes_Get","parameters":[{"name":"loadBalancerName","in":"path",...` |

### Changes for `headers`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |

### Changes for `final-state-schema`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/LoadBalancer` |

### Changes for `LoadBalancerBackendAddressPoolListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LoadBalancerBackendAddressPoolListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `LoadBalancerFrontendIPConfigurationListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LoadBalancerFrontendIPConfigurationListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `LoadBalancerLoadBalancingRuleListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LoadBalancerLoadBalancingRuleListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `LoadBalancerOutboundRuleListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LoadBalancerOutboundRuleListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `LoadBalancerProbeListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LoadBalancerProbeListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BackendAddressPool.properties.name__deleted` | deleted | `{"type":"string"}` |
| `definitions.FrontendIPConfiguration.properties.name__deleted` | deleted | `{"type":"string"}` |
| `definitions.InboundNatRule.properties.name__deleted` | deleted | `{"type":"string"}` |
| `definitions.LoadBalancingRule.properties.name__deleted` | deleted | `{"type":"string"}` |
| `definitions.OutboundRule.properties.name__deleted` | deleted | `{"type":"string"}` |
| `definitions.Probe.properties.name__deleted` | deleted | `{"type":"string"}` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BackendAddressPool.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.BackendAddressPoolPropertiesFormat.properties.syncMode.type__deleted` | deleted | `string` |
| `definitions.FrontendIPConfiguration.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.GatewayLoadBalancerTunnelInterface.properties.protocol.type__deleted` | deleted | `string` |
| `definitions.GatewayLoadBalancerTunnelInterface.properties.type.type__deleted` | deleted | `string` |
| `definitions.InboundNatPoolPropertiesFormat.properties.protocol.type__deleted` | deleted | `string` |
| `definitions.InboundNatRule.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.InboundNatRulePortMapping.properties.protocol.type__deleted` | deleted | `string` |
| `definitions.InboundNatRulePropertiesFormat.properties.protocol.type__deleted` | deleted | `string` |
| `definitions.LoadBalancerBackendAddressPropertiesFormat.properties.adminState.type__deleted` | deleted | `string` |
| `definitions.LoadBalancerPropertiesFormat.properties.scope.type__deleted` | deleted | `string` |
| `definitions.LoadBalancerSku.properties.name.type__deleted` | deleted | `string` |
| `definitions.LoadBalancerSku.properties.tier.type__deleted` | deleted | `string` |
| `definitions.LoadBalancingRule.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.LoadBalancingRulePropertiesFormat.properties.loadDistribution.type__deleted` | deleted | `string` |
| `definitions.LoadBalancingRulePropertiesFormat.properties.protocol.type__deleted` | deleted | `string` |
| `definitions.OutboundRule.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.OutboundRulePropertiesFormat.properties.protocol.type__deleted` | deleted | `string` |
| `definitions.Probe.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.ProbePropertiesFormat.properties.noHealthyBackendsBehavior.type__deleted` | deleted | `string` |
| `definitions.ProbePropertiesFormat.properties.protocol.type__deleted` | deleted | `string` |

### Changes for `enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BackendAddressPoolPropertiesFormat.properties.syncMode.enum__deleted` | deleted | `["Automatic","Manual"]` |
| `definitions.GatewayLoadBalancerTunnelInterface.properties.protocol.enum__deleted` | deleted | `["None","Native","VXLAN"]` |
| `definitions.GatewayLoadBalancerTunnelInterface.properties.type.enum__deleted` | deleted | `["None","Internal","External"]` |
| `definitions.InboundNatPoolPropertiesFormat.properties.protocol.enum__deleted` | deleted | `["Udp","Tcp","All","Quic"]` |
| `definitions.InboundNatRulePortMapping.properties.protocol.enum__deleted` | deleted | `["Udp","Tcp","All","Quic"]` |
| `definitions.InboundNatRulePropertiesFormat.properties.protocol.enum__deleted` | deleted | `["Udp","Tcp","All","Quic"]` |
| `definitions.LoadBalancerBackendAddressPropertiesFormat.properties.adminState.enum__deleted` | deleted | `["None","Up","Down"]` |
| `definitions.LoadBalancerPropertiesFormat.properties.scope.enum__deleted` | deleted | `["Public","Private"]` |
| `definitions.LoadBalancerSku.properties.name.enum__deleted` | deleted | `["Basic","Standard","Gateway"]` |
| `definitions.LoadBalancerSku.properties.tier.enum__deleted` | deleted | `["Regional","Global"]` |
| `definitions.LoadBalancingRulePropertiesFormat.properties.loadDistribution.enum__deleted` | deleted | `["Default","SourceIP","SourceIPProtocol"]` |
| `definitions.LoadBalancingRulePropertiesFormat.properties.protocol.enum__deleted` | deleted | `["Udp","Tcp","All","Quic"]` |
| `definitions.OutboundRulePropertiesFormat.properties.protocol.enum__deleted` | deleted | `["Tcp","Udp","All"]` |
| `definitions.ProbePropertiesFormat.properties.noHealthyBackendsBehavior.enum__deleted` | deleted | `["AllProbedDown","AllProbedUp"]` |
| `definitions.ProbePropertiesFormat.properties.protocol.enum__deleted` | deleted | `["Http","Tcp","Https"]` |

### Changes for `x-ms-enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BackendAddressPoolPropertiesFormat.properties.syncMode['x-ms-enum__deleted']` | deleted | `{"name":"SyncMode","modelAsString":true}` |
| `definitions.GatewayLoadBalancerTunnelInterface.properties.protocol['x-ms-enum__deleted']` | deleted | `{"name":"GatewayLoadBalancerTunnelProtocol","modelAsString":true}` |
| `definitions.GatewayLoadBalancerTunnelInterface.properties.type['x-ms-enum__deleted']` | deleted | `{"name":"GatewayLoadBalancerTunnelInterfaceType","modelAsString":true}` |
| `definitions.InboundNatPoolPropertiesFormat.properties.protocol['x-ms-enum__deleted']` | deleted | `{"name":"TransportProtocol","modelAsString":true}` |
| `definitions.InboundNatRulePortMapping.properties.protocol['x-ms-enum__deleted']` | deleted | `{"name":"TransportProtocol","modelAsString":true}` |
| `definitions.InboundNatRulePropertiesFormat.properties.protocol['x-ms-enum__deleted']` | deleted | `{"name":"TransportProtocol","modelAsString":true}` |
| `definitions.LoadBalancerBackendAddressPropertiesFormat.properties.adminState['x-ms-enum__deleted']` | deleted | `{"name":"LoadBalancerBackendAddressAdminState","modelAsString":true}` |
| `definitions.LoadBalancerPropertiesFormat.properties.scope['x-ms-enum__deleted']` | deleted | `{"name":"LoadBalancerScope","modelAsString":true}` |
| `definitions.LoadBalancerSku.properties.name['x-ms-enum__deleted']` | deleted | `{"name":"LoadBalancerSkuName","modelAsString":true}` |
| `definitions.LoadBalancerSku.properties.tier['x-ms-enum__deleted']` | deleted | `{"name":"LoadBalancerSkuTier","modelAsString":true}` |
| `definitions.LoadBalancingRulePropertiesFormat.properties.loadDistribution['x-ms-enum__deleted']` | deleted | `{"name":"LoadDistribution","modelAsString":true}` |
| `definitions.LoadBalancingRulePropertiesFormat.properties.protocol['x-ms-enum__deleted']` | deleted | `{"name":"TransportProtocol","modelAsString":true}` |
| `definitions.OutboundRulePropertiesFormat.properties.protocol['x-ms-enum__deleted']` | deleted | `{"name":"LoadBalancerOutboundRuleProtocol","modelAsString":true}` |
| `definitions.ProbePropertiesFormat.properties.noHealthyBackendsBehavior['x-ms-enum__deleted']` | deleted | `{"name":"ProbeNoHealthyBackendsBehavior","modelAsString":true}` |
| `definitions.ProbePropertiesFormat.properties.protocol['x-ms-enum__deleted']` | deleted | `{"name":"ProbeProtocol","modelAsString":true}` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BackendAddressPoolPropertiesFormat.properties.syncMode.$ref__added` | added | `./common.json/definitions/SyncMode` |
| `definitions.GatewayLoadBalancerTunnelInterface.properties.protocol.$ref__added` | added | `./common.json/definitions/GatewayLoadBalancerTunnelProtocol` |
| `definitions.GatewayLoadBalancerTunnelInterface.properties.type.$ref__added` | added | `./common.json/definitions/GatewayLoadBalancerTunnelInterfaceType` |
| `definitions.InboundNatPoolPropertiesFormat.properties.protocol.$ref__added` | added | `./common.json/definitions/TransportProtocol` |
| `definitions.InboundNatRulePortMapping.properties.protocol.$ref__added` | added | `./common.json/definitions/TransportProtocol` |
| `definitions.InboundNatRulePropertiesFormat.properties.protocol.$ref__added` | added | `./common.json/definitions/TransportProtocol` |
| `definitions.LoadBalancerBackendAddressPropertiesFormat.properties.adminState.$ref__added` | added | `./common.json/definitions/LoadBalancerBackendAddressAdminState` |
| `definitions.LoadBalancerPropertiesFormat.properties.scope.$ref__added` | added | `./common.json/definitions/LoadBalancerScope` |
| `definitions.LoadBalancerSku.properties.name.$ref__added` | added | `./common.json/definitions/LoadBalancerSkuName` |
| `definitions.LoadBalancerSku.properties.tier.$ref__added` | added | `./common.json/definitions/LoadBalancerSkuTier` |
| `definitions.LoadBalancingRulePropertiesFormat.properties.loadDistribution.$ref__added` | added | `./common.json/definitions/LoadDistribution` |
| `definitions.LoadBalancingRulePropertiesFormat.properties.protocol.$ref__added` | added | `./common.json/definitions/TransportProtocol` |
| `definitions.OutboundRulePropertiesFormat.properties.protocol.$ref__added` | added | `./common.json/definitions/LoadBalancerOutboundRuleProtocol` |
| `definitions.ProbePropertiesFormat.properties.noHealthyBackendsBehavior.$ref__added` | added | `./common.json/definitions/ProbeNoHealthyBackendsBehavior` |
| `definitions.ProbePropertiesFormat.properties.protocol.$ref__added` | added | `./common.json/definitions/ProbeProtocol` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InboundNatRuleListResult.required__added` | added | `["value"]` |
| `definitions.LoadBalancerListResult.required__added` | added | `["value"]` |

### Changes for `x-ms-azure-resource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LoadBalancerBackendAddressPropertiesFormat.properties.ipAddress['x-ms-azure-resource__deleted']` | deleted | `false` |

### Changes for `readOnly`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.LoadBalancerBackendAddressPropertiesFormat.properties.loadBalancerFrontendIPConfiguration.readOnly__deleted` | deleted | `false` |

### Changes for `format`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OutboundRulePropertiesFormat.properties.idleTimeoutInMinutes.format__added` | added | `int32` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.BackendAddressPool.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResourceModel` |
| `definitions.BackendAddressPoolPropertiesFormat.properties.backendIPConfigurations.items.$ref` | `./networkInterface.json#/definitions/NetworkInterfaceIPConfiguration` | `./virtualNetwork.json/definitions/NetworkInterfaceIPConfiguration` |
| `definitions.BackendAddressPoolPropertiesFormat.properties.inboundNatRules.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.BackendAddressPoolPropertiesFormat.properties.loadBalancingRules.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.BackendAddressPoolPropertiesFormat.properties.outboundRule.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.BackendAddressPoolPropertiesFormat.properties.outboundRules.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.BackendAddressPoolPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.BackendAddressPoolPropertiesFormat.properties.virtualNetwork.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.FrontendIPConfiguration.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResourceModel` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.gatewayLoadBalancer.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.inboundNatPools.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.inboundNatRules.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.loadBalancingRules.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.outboundRules.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.privateIPAddressVersion.$ref` | `./network.json#/definitions/IPVersion` | `./common.json/definitions/IPVersion` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.privateIPAllocationMethod.$ref` | `./network.json#/definitions/IPAllocationMethod` | `./common.json/definitions/IPAllocationMethod` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.publicIPAddress.$ref` | `./publicIpAddress.json#/definitions/PublicIPAddress` | `./virtualNetwork.json/definitions/PublicIPAddress` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.publicIPPrefix.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.subnet.$ref` | `./virtualNetwork.json#/definitions/Subnet` | `./virtualNetwork.json/definitions/Subnet` |
| `definitions.InboundNatPool.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.InboundNatPoolPropertiesFormat.properties.frontendIPConfiguration.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.InboundNatPoolPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.InboundNatRule.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResourceModel` |
| `definitions.InboundNatRulePropertiesFormat.properties.backendAddressPool.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.InboundNatRulePropertiesFormat.properties.backendIPConfiguration.$ref` | `./networkInterface.json#/definitions/NetworkInterfaceIPConfiguration` | `./virtualNetwork.json/definitions/NetworkInterfaceIPConfiguration` |
| `definitions.InboundNatRulePropertiesFormat.properties.frontendIPConfiguration.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.InboundNatRulePropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.LoadBalancer.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json/definitions/Resource` |
| `definitions.LoadBalancer.properties.extendedLocation.$ref` | `./network.json#/definitions/ExtendedLocation` | `./common.json/definitions/ExtendedLocation` |
| `definitions.LoadBalancerBackendAddressPropertiesFormat.properties.loadBalancerFrontendIPConfiguration.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.LoadBalancerBackendAddressPropertiesFormat.properties.networkInterfaceIPConfiguration.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.LoadBalancerBackendAddressPropertiesFormat.properties.subnet.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.LoadBalancerBackendAddressPropertiesFormat.properties.virtualNetwork.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.LoadBalancerPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.LoadBalancerVipSwapRequestFrontendIPConfigurationProperties.properties.publicIPAddress.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.LoadBalancingRule.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResourceModel` |
| `definitions.LoadBalancingRulePropertiesFormat.properties.backendAddressPool.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.LoadBalancingRulePropertiesFormat.properties.backendAddressPools.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.LoadBalancingRulePropertiesFormat.properties.frontendIPConfiguration.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.LoadBalancingRulePropertiesFormat.properties.probe.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.LoadBalancingRulePropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.OutboundRule.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResourceModel` |
| `definitions.OutboundRulePropertiesFormat.properties.backendAddressPool.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.OutboundRulePropertiesFormat.properties.frontendIPConfigurations.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.OutboundRulePropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.Probe.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResourceModel` |
| `definitions.ProbePropertiesFormat.properties.loadBalancingRules.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `definitions.ProbePropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.QueryInboundNatRulePortMappingRequest.properties.ipConfiguration.$ref` | `./network.json#/definitions/SubResource` | `./common.json/definitions/SubResource` |
| `info.description` | `The Microsoft Azure Network management API provides a RESTful set of web services that interact with Microsoft Azure Networks service to manage your network resources. The API has entities that capture the relationship between an end user and the Microsoft Azure Networks service.` | `APIs to manage web application firewall rules.` |
| `info.title` | `NetworkManagementClient` | `WebApplicationFirewallManagement` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/loadBalancers'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/migrateToIpBased'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/networkInterfaces'].get.responses.200.schema.$ref` | `./networkInterface.json#/definitions/NetworkInterfaceListResult` | `./virtualNetwork.json/definitions/NetworkInterfaceListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/networkInterfaces'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |

