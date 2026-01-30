## Swagger Changes

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/setLoadBalancerFrontendPublicIpAddresses'].post.tags__deleted` | deleted | `["LoadBalancers"]` |
| `tags__added` | added | `[{"name":"LoadBalancers"},{"name":"BackendAddressPools"},{"name":"FrontendIPConfigurations"},{"name"...` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BackendAddressPool.properties.name__deleted` | deleted | `{"type":"string"}` |
| `definitions.FrontendIPConfiguration.properties.name__deleted` | deleted | `{"type":"string"}` |
| `definitions.InboundNatRule.properties.name__deleted` | deleted | `{"type":"string"}` |
| `definitions.LoadBalancingRule.properties.name__deleted` | deleted | `{"type":"string"}` |
| `definitions.OutboundRule.properties.name__deleted` | deleted | `{"type":"string"}` |
| `definitions.Probe.properties.name__deleted` | deleted | `{"type":"string"}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/setLoadBalancerFrontendPublicIpAddresses'].post.parameters[0].name__deleted` | deleted | `location` |

### Changes for `in`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/setLoadBalancerFrontendPublicIpAddresses'].post.parameters[0].in__deleted` | deleted | `path` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.InboundNatRuleListResult.required__added` | added | `["value"]` |
| `definitions.LoadBalancerBackendAddressPoolListResult.required__added` | added | `["value"]` |
| `definitions.LoadBalancerFrontendIPConfigurationListResult.required__added` | added | `["value"]` |
| `definitions.LoadBalancerListResult.required__added` | added | `["value"]` |
| `definitions.LoadBalancerLoadBalancingRuleListResult.required__added` | added | `["value"]` |
| `definitions.LoadBalancerOutboundRuleListResult.required__added` | added | `["value"]` |
| `definitions.LoadBalancerProbeListResult.required__added` | added | `["value"]` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/setLoadBalancerFrontendPublicIpAddresses'].post.parameters[0].required__deleted` | deleted | `true` |

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
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/setLoadBalancerFrontendPublicIpAddresses'].post.parameters[0].type__deleted` | deleted | `string` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BackendAddressPoolPropertiesFormat.properties.syncMode.$ref__added` | added | `./common.json#/definitions/SyncMode` |
| `definitions.GatewayLoadBalancerTunnelInterface.properties.protocol.$ref__added` | added | `./common.json#/definitions/GatewayLoadBalancerTunnelProtocol` |
| `definitions.GatewayLoadBalancerTunnelInterface.properties.type.$ref__added` | added | `./common.json#/definitions/GatewayLoadBalancerTunnelInterfaceType` |
| `definitions.InboundNatPoolPropertiesFormat.properties.protocol.$ref__added` | added | `./common.json#/definitions/TransportProtocol` |
| `definitions.InboundNatRulePortMapping.properties.protocol.$ref__added` | added | `./common.json#/definitions/TransportProtocol` |
| `definitions.InboundNatRulePropertiesFormat.properties.protocol.$ref__added` | added | `./common.json#/definitions/TransportProtocol` |
| `definitions.LoadBalancerBackendAddressPropertiesFormat.properties.adminState.$ref__added` | added | `./common.json#/definitions/LoadBalancerBackendAddressAdminState` |
| `definitions.LoadBalancerPropertiesFormat.properties.scope.$ref__added` | added | `./common.json#/definitions/LoadBalancerScope` |
| `definitions.LoadBalancerSku.properties.name.$ref__added` | added | `./common.json#/definitions/LoadBalancerSkuName` |
| `definitions.LoadBalancerSku.properties.tier.$ref__added` | added | `./common.json#/definitions/LoadBalancerSkuTier` |
| `definitions.LoadBalancingRulePropertiesFormat.properties.loadDistribution.$ref__added` | added | `./common.json#/definitions/LoadDistribution` |
| `definitions.LoadBalancingRulePropertiesFormat.properties.protocol.$ref__added` | added | `./common.json#/definitions/TransportProtocol` |
| `definitions.OutboundRulePropertiesFormat.properties.protocol.$ref__added` | added | `./common.json#/definitions/LoadBalancerOutboundRuleProtocol` |
| `definitions.ProbePropertiesFormat.properties.noHealthyBackendsBehavior.$ref__added` | added | `./common.json#/definitions/ProbeNoHealthyBackendsBehavior` |
| `definitions.ProbePropertiesFormat.properties.protocol.$ref__added` | added | `./common.json#/definitions/ProbeProtocol` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/setLoadBalancerFrontendPublicIpAddresses'].post.parameters[0].$ref__added` | added | `../../../../../common-types/resource-management/v5/types.json#/parameters/LocationParameter` |

### Changes for `headers`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/setLoadBalancerFrontendPublicIpAddresses'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/backendAddressPools/{backendPoolName}/queryInboundNatRulePortMapping'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/backendAddressPools/{backendAddressPoolName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/backendAddressPools/{backendAddressPoolName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/inboundNatRules/{inboundNatRuleName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/inboundNatRules/{inboundNatRuleName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |

### Changes for `final-state-schema`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/LoadBalancer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/backendAddressPools/{backendAddressPoolName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/BackendAddressPool` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/inboundNatRules/{inboundNatRuleName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/InboundNatRule` |

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
| `definitions.BackendAddressPool.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResourceModel` |
| `definitions.BackendAddressPoolPropertiesFormat.properties.backendIPConfigurations.items.$ref` | `./networkInterface.json#/definitions/NetworkInterfaceIPConfiguration` | `./virtualNetwork.json#/definitions/NetworkInterfaceIPConfiguration` |
| `definitions.BackendAddressPoolPropertiesFormat.properties.inboundNatRules.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.BackendAddressPoolPropertiesFormat.properties.loadBalancingRules.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.BackendAddressPoolPropertiesFormat.properties.outboundRule.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.BackendAddressPoolPropertiesFormat.properties.outboundRules.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.BackendAddressPoolPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.BackendAddressPoolPropertiesFormat.properties.virtualNetwork.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.FrontendIPConfiguration.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResourceModel` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.gatewayLoadBalancer.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.inboundNatPools.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.inboundNatRules.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.loadBalancingRules.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.outboundRules.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.privateIPAddressVersion.$ref` | `./network.json#/definitions/IPVersion` | `./common.json#/definitions/IPVersion` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.privateIPAllocationMethod.$ref` | `./network.json#/definitions/IPAllocationMethod` | `./common.json#/definitions/IPAllocationMethod` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.publicIPAddress.$ref` | `./publicIpAddress.json#/definitions/PublicIPAddress` | `./virtualNetwork.json#/definitions/PublicIPAddress` |
| `definitions.FrontendIPConfigurationPropertiesFormat.properties.publicIPPrefix.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.InboundNatPool.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.InboundNatPoolPropertiesFormat.properties.frontendIPConfiguration.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.InboundNatPoolPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.InboundNatRule.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResourceModel` |
| `definitions.InboundNatRulePropertiesFormat.properties.backendAddressPool.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.InboundNatRulePropertiesFormat.properties.backendIPConfiguration.$ref` | `./networkInterface.json#/definitions/NetworkInterfaceIPConfiguration` | `./virtualNetwork.json#/definitions/NetworkInterfaceIPConfiguration` |
| `definitions.InboundNatRulePropertiesFormat.properties.frontendIPConfiguration.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.InboundNatRulePropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.LoadBalancer.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json#/definitions/Resource` |
| `definitions.LoadBalancer.properties.extendedLocation.$ref` | `./network.json#/definitions/ExtendedLocation` | `./common.json#/definitions/ExtendedLocation` |
| `definitions.LoadBalancerBackendAddressPropertiesFormat.properties.loadBalancerFrontendIPConfiguration.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.LoadBalancerBackendAddressPropertiesFormat.properties.networkInterfaceIPConfiguration.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.LoadBalancerBackendAddressPropertiesFormat.properties.subnet.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.LoadBalancerBackendAddressPropertiesFormat.properties.virtualNetwork.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.LoadBalancerPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.LoadBalancerVipSwapRequestFrontendIPConfigurationProperties.properties.publicIPAddress.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.LoadBalancingRule.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResourceModel` |
| `definitions.LoadBalancingRulePropertiesFormat.properties.backendAddressPool.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.LoadBalancingRulePropertiesFormat.properties.backendAddressPools.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.LoadBalancingRulePropertiesFormat.properties.frontendIPConfiguration.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.LoadBalancingRulePropertiesFormat.properties.probe.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.LoadBalancingRulePropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.OutboundRule.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResourceModel` |
| `definitions.OutboundRulePropertiesFormat.properties.backendAddressPool.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.OutboundRulePropertiesFormat.properties.frontendIPConfigurations.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.OutboundRulePropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.Probe.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResourceModel` |
| `definitions.ProbePropertiesFormat.properties.loadBalancingRules.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ProbePropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.QueryInboundNatRulePortMappingRequest.properties.ipConfiguration.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `info.description` | `The Microsoft Azure Network management API provides a RESTful set of web services that interact with Microsoft Azure Networks service to manage your network resources. The API has entities that capture the relationship between an end user and the Microsoft Azure Networks service.` | `APIs to manage web application firewall rules.` |
| `info.title` | `NetworkManagementClient` | `WebApplicationFirewallManagement` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/loadBalancers'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/setLoadBalancerFrontendPublicIpAddresses'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/backendAddressPools/{backendPoolName}/queryInboundNatRulePortMapping'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/loadBalancingRules/{loadBalancingRuleName}/health'].post.responses.202.headers.Location.description` | `URI to query the status of the long-running operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/loadBalancingRules/{loadBalancingRuleName}/health'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/migrateToIpBased'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/backendAddressPools'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/backendAddressPools/{backendAddressPoolName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/backendAddressPools/{backendAddressPoolName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/backendAddressPools/{backendAddressPoolName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/frontendIPConfigurations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/frontendIPConfigurations/{frontendIPConfigurationName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/inboundNatRules'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/inboundNatRules/{inboundNatRuleName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/inboundNatRules/{inboundNatRuleName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/inboundNatRules/{inboundNatRuleName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/loadBalancingRules'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/loadBalancingRules/{loadBalancingRuleName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/networkInterfaces'].get.responses.200.schema.$ref` | `./networkInterface.json#/definitions/NetworkInterfaceListResult` | `./virtualNetwork.json#/definitions/NetworkInterfaceListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/networkInterfaces'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/outboundRules'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/outboundRules/{outboundRuleName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/probes'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/loadBalancers/{loadBalancerName}/probes/{probeName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |

