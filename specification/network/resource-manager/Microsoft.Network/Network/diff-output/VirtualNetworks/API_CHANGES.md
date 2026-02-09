## Changed Paths

Path: /subscriptions/{subscriptionId}/providers/microsoft.Network/bgpServiceCommunities
Change Type: deleted

Path: /subscriptions/{subscriptionId}/providers/microsoft.Network/routeFilters
Change Type: deleted

Path: /subscriptions/{subscriptionId}/providers/microsoft.Network/serviceEndpointPolicies
Change Type: deleted

Path: /subscriptions/{subscriptionId}/providers/microsoft.Network/serviceGateways
Change Type: deleted

Path: /subscriptions/{subscriptionId}/providers/microsoft.Network/virtualNetworkAppliances
Change Type: deleted

Path: /subscriptions/{subscriptionId}/providers/microsoft.Network/virtualNetworkTaps
Change Type: deleted

Path: /subscriptions/{subscriptionId}/providers/microsoft.Network/virtualRouters
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/networkInterfaces
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/publicipaddresses
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/virtualMachines/{virtualmachineIndex}/networkInterfaces
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/virtualMachines/{virtualmachineIndex}/networkInterfaces/{networkInterfaceName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/virtualMachines/{virtualmachineIndex}/networkInterfaces/{networkInterfaceName}/ipConfigurations
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/virtualMachines/{virtualmachineIndex}/networkInterfaces/{networkInterfaceName}/ipConfigurations/{ipConfigurationName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/virtualMachines/{virtualmachineIndex}/networkInterfaces/{networkInterfaceName}/ipconfigurations/{ipConfigurationName}/publicipaddresses
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/virtualMachines/{virtualmachineIndex}/networkInterfaces/{networkInterfaceName}/ipconfigurations/{ipConfigurationName}/publicipaddresses/{publicIpAddressName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}/routeFilterRules
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}/routeFilterRules/{ruleName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}/serviceEndpointPolicyDefinitions
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}/serviceEndpointPolicyDefinitions/{serviceEndpointPolicyDefinitionName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceGateways
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceGateways/{serviceGatewayName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceGateways/{serviceGatewayName}/addressLocations
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceGateways/{serviceGatewayName}/services
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceGateways/{serviceGatewayName}/updateAddressLocations
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceGateways/{serviceGatewayName}/updateServices
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkAppliances
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkAppliances/{virtualNetworkApplianceName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkTaps
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkTaps/{tapName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualRouters
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualRouters/{virtualRouterName}
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualRouters/{virtualRouterName}/peerings
Change Type: added

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualRouters/{virtualRouterName}/peerings/{peeringName}
Change Type: added

## Swagger Changes

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `tags__added` | added | `[{"name":"ApplicationSecurityGroups"},{"name":"applicationSecurityGroups"},{"name":"BastionHosts"},{...` |

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.Network/bgpServiceCommunities`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/bgpServiceCommunities__deleted']` | deleted | `{"get":{"operationId":"BgpServiceCommunities_List","tags":["BgpServiceCommunities"],"parameters":[],...` |

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.Network/routeFilters`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/routeFilters__deleted']` | deleted | `{"get":{"operationId":"RouteFilters_List","tags":["RouteFilters"],"parameters":[],"responses":{"200"...` |

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.Network/serviceEndpointPolicies`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/serviceEndpointPolicies__deleted']` | deleted | `{"get":{"operationId":"ServiceEndpointPolicies_List","tags":["ServiceEndpointPolicies"],"parameters"...` |

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.Network/serviceGateways`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/serviceGateways__deleted']` | deleted | `{"get":{"operationId":"ServiceGateways_ListAll","tags":["ServiceGateways"],"parameters":[],"response...` |

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.Network/virtualNetworkAppliances`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/virtualNetworkAppliances__deleted']` | deleted | `{"get":{"operationId":"VirtualNetworkAppliances_ListAll","tags":["VirtualNetworkAppliances"],"parame...` |

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.Network/virtualNetworkTaps`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/virtualNetworkTaps__deleted']` | deleted | `{"get":{"operationId":"VirtualNetworkTaps_ListAll","tags":["VirtualNetworkTaps"],"parameters":[],"re...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/networkInterfaces`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/networkInterfaces__deleted']` | deleted | `{"get":{"operationId":"NetworkInterfaces_ListVirtualMachineScaleSetNetworkInterfaces","tags":["Netwo...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/publicipaddresses`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/publicipaddresses__deleted']` | deleted | `{"get":{"operationId":"PublicIPAddresses_ListVirtualMachineScaleSetPublicIPAddresses","parameters":[...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/virtualMachines/{virtualmachineIndex}/networkInterfaces`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/virtualMachines/{virtualmachineIndex}/networkInterfaces__deleted']` | deleted | `{"get":{"operationId":"NetworkInterfaces_ListVirtualMachineScaleSetVMNetworkInterfaces","tags":["Net...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/virtualMachines/{virtualmachineIndex}/networkInterfaces/{networkInterfaceName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/virtualMachines/{virtualmachineIndex}/networkInterfaces/{networkInterfaceName}__deleted']` | deleted | `{"get":{"operationId":"NetworkInterfaces_GetVirtualMachineScaleSetNetworkInterface","tags":["Network...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/virtualMachines/{virtualmachineIndex}/networkInterfaces/{networkInterfaceName}/ipConfigurations`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/virtualMachines/{virtualmachineIndex}/networkInterfaces/{networkInterfaceName}/ipConfigurations__deleted']` | deleted | `{"get":{"operationId":"NetworkInterfaces_ListVirtualMachineScaleSetIpConfigurations","tags":["Networ...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/virtualMachines/{virtualmachineIndex}/networkInterfaces/{networkInterfaceName}/ipConfigurations/{ipConfigurationName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/virtualMachines/{virtualmachineIndex}/networkInterfaces/{networkInterfaceName}/ipConfigurations/{ipConfigurationName}__deleted']` | deleted | `{"get":{"operationId":"NetworkInterfaces_GetVirtualMachineScaleSetIpConfiguration","tags":["NetworkI...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/virtualMachines/{virtualmachineIndex}/networkInterfaces/{networkInterfaceName}/ipconfigurations/{ipConfigurationName}/publicipaddresses`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/virtualMachines/{virtualmachineIndex}/networkInterfaces/{networkInterfaceName}/ipconfigurations/{ipConfigurationName}/publicipaddresses__deleted']` | deleted | `{"get":{"operationId":"PublicIPAddresses_ListVirtualMachineScaleSetVMPublicIPAddresses","parameters"...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/virtualMachines/{virtualmachineIndex}/networkInterfaces/{networkInterfaceName}/ipconfigurations/{ipConfigurationName}/publicipaddresses/{publicIpAddressName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/virtualMachines/{virtualmachineIndex}/networkInterfaces/{networkInterfaceName}/ipconfigurations/{ipConfigurationName}/publicipaddresses/{publicIpAddressName}__deleted']` | deleted | `{"get":{"operationId":"PublicIPAddresses_GetVirtualMachineScaleSetPublicIPAddress","parameters":[{"n...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters__deleted']` | deleted | `{"get":{"operationId":"RouteFilters_ListByResourceGroup","tags":["RouteFilters"],"parameters":[],"re...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}__deleted']` | deleted | `{"get":{"operationId":"RouteFilters_Get","tags":["RouteFilters"],"parameters":[{"name":"routeFilterN...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}/routeFilterRules`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}/routeFilterRules__deleted']` | deleted | `{"get":{"operationId":"RouteFilterRules_ListByRouteFilter","tags":["RouteFilterRules"],"parameters":...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}/routeFilterRules/{ruleName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeFilters/{routeFilterName}/routeFilterRules/{ruleName}__deleted']` | deleted | `{"get":{"operationId":"RouteFilterRules_Get","tags":["RouteFilterRules"],"parameters":[{"name":"rout...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies__deleted']` | deleted | `{"get":{"operationId":"ServiceEndpointPolicies_ListByResourceGroup","tags":["ServiceEndpointPolicies...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}__deleted']` | deleted | `{"get":{"operationId":"ServiceEndpointPolicies_Get","tags":["ServiceEndpointPolicies"],"parameters":...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}/serviceEndpointPolicyDefinitions`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}/serviceEndpointPolicyDefinitions__deleted']` | deleted | `{"get":{"operationId":"ServiceEndpointPolicyDefinitions_ListByResourceGroup","tags":["ServiceEndpoin...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}/serviceEndpointPolicyDefinitions/{serviceEndpointPolicyDefinitionName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}/serviceEndpointPolicyDefinitions/{serviceEndpointPolicyDefinitionName}__deleted']` | deleted | `{"get":{"operationId":"ServiceEndpointPolicyDefinitions_Get","tags":["serviceEndpointPolicyDefinitio...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceGateways`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceGateways__deleted']` | deleted | `{"get":{"operationId":"ServiceGateways_List","tags":["ServiceGateways"],"parameters":[],"responses":...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceGateways/{serviceGatewayName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceGateways/{serviceGatewayName}__deleted']` | deleted | `{"get":{"operationId":"ServiceGateways_Get","tags":["ServiceGateways"],"parameters":[{"name":"servic...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceGateways/{serviceGatewayName}/addressLocations`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceGateways/{serviceGatewayName}/addressLocations__deleted']` | deleted | `{"get":{"operationId":"ServiceGateways_GetAddressLocations","tags":["ServiceGateways"],"parameters":...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceGateways/{serviceGatewayName}/services`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceGateways/{serviceGatewayName}/services__deleted']` | deleted | `{"get":{"operationId":"ServiceGateways_GetServices","tags":["ServiceGateways"],"parameters":[{"name"...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceGateways/{serviceGatewayName}/updateAddressLocations`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceGateways/{serviceGatewayName}/updateAddressLocations__deleted']` | deleted | `{"post":{"operationId":"ServiceGateways_UpdateAddressLocations","tags":["ServiceGateways"],"paramete...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceGateways/{serviceGatewayName}/updateServices`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/serviceGateways/{serviceGatewayName}/updateServices__deleted']` | deleted | `{"post":{"operationId":"ServiceGateways_UpdateServices","tags":["ServiceGateways"],"parameters":[{"n...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkAppliances`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkAppliances__deleted']` | deleted | `{"get":{"operationId":"VirtualNetworkAppliances_List","tags":["VirtualNetworkAppliances"],"parameter...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkAppliances/{virtualNetworkApplianceName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkAppliances/{virtualNetworkApplianceName}__deleted']` | deleted | `{"get":{"operationId":"VirtualNetworkAppliances_Get","tags":["VirtualNetworkAppliances"],"parameters...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkTaps`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkTaps__deleted']` | deleted | `{"get":{"operationId":"VirtualNetworkTaps_ListByResourceGroup","tags":["VirtualNetworkTaps"],"parame...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkTaps/{tapName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworkTaps/{tapName}__deleted']` | deleted | `{"get":{"operationId":"VirtualNetworkTaps_Get","tags":["VirtualNetworkTap"],"parameters":[{"name":"t...` |

### Changes for `/subscriptions/{subscriptionId}/providers/microsoft.Network/virtualRouters`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/virtualRouters__added']` | added | `{"get":{"operationId":"VirtualRouters_List","tags":["VirtualRouters"],"parameters":[],"responses":{"...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualRouters`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualRouters__added']` | added | `{"get":{"operationId":"VirtualRouters_ListByResourceGroup","tags":["VirtualRouters"],"parameters":[]...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualRouters/{virtualRouterName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualRouters/{virtualRouterName}__added']` | added | `{"get":{"operationId":"VirtualRouters_Get","tags":["VirtualRouters"],"parameters":[{"name":"virtualR...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualRouters/{virtualRouterName}/peerings`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualRouters/{virtualRouterName}/peerings__added']` | added | `{"get":{"operationId":"VirtualRouterPeerings_List","tags":["VirtualRouterPeerings"],"parameters":[{"...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualRouters/{virtualRouterName}/peerings/{peeringName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualRouters/{virtualRouterName}/peerings/{peeringName}__added']` | added | `{"get":{"operationId":"VirtualRouterPeerings_Get","tags":["VirtualRouterPeerings"],"parameters":[{"n...` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DdosProtectionPlan.properties.name__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.InboundSecurityRule.properties.name__deleted` | deleted | `{"type":"string"}` |
| `definitions.NetworkInterfaceIPConfiguration.properties.name__deleted` | deleted | `{"type":"string"}` |
| `definitions.NetworkInterfaceTapConfiguration.properties.name__deleted` | deleted | `{"type":"string"}` |
| `definitions.PrivateEndpointConnection.properties.name__deleted` | deleted | `{"type":"string"}` |
| `definitions.Route.properties.name__deleted` | deleted | `{"type":"string"}` |
| `definitions.SecurityRule.properties.name__deleted` | deleted | `{"type":"string"}` |
| `definitions.Subnet.properties.name__deleted` | deleted | `{"type":"string"}` |
| `definitions.SwapResource.properties.name__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.VirtualApplianceSite.properties.name__deleted` | deleted | `{"type":"string"}` |
| `definitions.VirtualNetworkPeering.properties.name__deleted` | deleted | `{"type":"string"}` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/autoApprovedPrivateLinkServices'].get.parameters[0].name__deleted` | deleted | `location` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/availableDelegations'].get.parameters[0].name__deleted` | deleted | `location` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/availablePrivateEndpointTypes'].get.parameters[0].name__deleted` | deleted | `location` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/availableServiceAliases'].get.parameters[0].name__deleted` | deleted | `location` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/checkDnsNameAvailability'].get.parameters[0].name__deleted` | deleted | `location` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/checkPrivateLinkServiceVisibility'].post.parameters[0].name__deleted` | deleted | `location` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/serviceTagDetails'].get.parameters[0].name__deleted` | deleted | `location` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/serviceTags'].get.parameters[0].name__deleted` | deleted | `location` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/usages'].get.parameters[0].name__deleted` | deleted | `location` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/virtualNetworkAvailableEndpointServices'].get.parameters[0].name__deleted` | deleted | `location` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/autoApprovedPrivateLinkServices'].get.parameters[0].name__deleted` | deleted | `location` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/availableDelegations'].get.parameters[0].name__deleted` | deleted | `location` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/availablePrivateEndpointTypes'].get.parameters[0].name__deleted` | deleted | `location` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/availableServiceAliases'].get.parameters[0].name__deleted` | deleted | `location` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/checkPrivateLinkServiceVisibility'].post.parameters[0].name__deleted` | deleted | `location` |

### Changes for `in`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/autoApprovedPrivateLinkServices'].get.parameters[0].in__deleted` | deleted | `path` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/availableDelegations'].get.parameters[0].in__deleted` | deleted | `path` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/availablePrivateEndpointTypes'].get.parameters[0].in__deleted` | deleted | `path` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/availableServiceAliases'].get.parameters[0].in__deleted` | deleted | `path` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/checkDnsNameAvailability'].get.parameters[0].in__deleted` | deleted | `path` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/checkPrivateLinkServiceVisibility'].post.parameters[0].in__deleted` | deleted | `path` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/serviceTagDetails'].get.parameters[0].in__deleted` | deleted | `path` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/serviceTags'].get.parameters[0].in__deleted` | deleted | `path` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/usages'].get.parameters[0].in__deleted` | deleted | `path` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/virtualNetworkAvailableEndpointServices'].get.parameters[0].in__deleted` | deleted | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/autoApprovedPrivateLinkServices'].get.parameters[0].in__deleted` | deleted | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/availableDelegations'].get.parameters[0].in__deleted` | deleted | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/availablePrivateEndpointTypes'].get.parameters[0].in__deleted` | deleted | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/availableServiceAliases'].get.parameters[0].in__deleted` | deleted | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/checkPrivateLinkServiceVisibility'].post.parameters[0].in__deleted` | deleted | `path` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationSecurityGroupListResult.required__added` | added | `["value"]` |
| `definitions.AutoApprovedPrivateLinkServicesResult.required__added` | added | `["value"]` |
| `definitions.AvailableDelegationsResult.required__added` | added | `["value"]` |
| `definitions.AvailablePrivateEndpointTypesResult.required__added` | added | `["value"]` |
| `definitions.AvailableServiceAliasesResult.required__added` | added | `["value"]` |
| `definitions.BastionActiveSessionListResult.required__added` | added | `["value"]` |
| `definitions.BastionHostListResult.required__added` | added | `["value"]` |
| `definitions.BastionSessionDeleteResult.required__added` | added | `["value"]` |
| `definitions.BastionShareableLinkListResult.required__added` | added | `["value"]` |
| `definitions.CustomIpPrefixListResult.required__added` | added | `["value"]` |
| `definitions.DdosProtectionPlanListResult.required__added` | added | `["value"]` |
| `definitions.DscpConfigurationListResult.required__added` | added | `["value"]` |
| `definitions.EffectiveNetworkSecurityGroupListResult.required__added` | added | `["value"]` |
| `definitions.EffectiveRouteListResult.required__added` | added | `["value"]` |
| `definitions.EndpointServicesListResult.required__added` | added | `["value"]` |
| `definitions.IpAllocationListResult.required__added` | added | `["value"]` |
| `definitions.IpamPoolList.required__added` | added | `["value"]` |
| `definitions.IpGroupListResult.required__added` | added | `["value"]` |
| `definitions.NatGatewayListResult.required__added` | added | `["value"]` |
| `definitions.NetworkInterfaceIPConfigurationListResult.required__added` | added | `["value"]` |
| `definitions.NetworkInterfaceListResult.required__added` | added | `["value"]` |
| `definitions.NetworkInterfaceLoadBalancerListResult.required__added` | added | `["value"]` |
| `definitions.NetworkInterfaceTapConfigurationListResult.required__added` | added | `["value"]` |
| `definitions.NetworkProfileListResult.required__added` | added | `["value"]` |
| `definitions.NetworkSecurityGroupListResult.required__added` | added | `["value"]` |
| `definitions.NetworkVirtualApplianceListResult.required__added` | added | `["value"]` |
| `definitions.NetworkVirtualApplianceSiteListResult.required__added` | added | `["value"]` |
| `definitions.NetworkVirtualApplianceSkuListResult.required__added` | added | `["value"]` |
| `definitions.PoolAssociationList.required__added` | added | `["value"]` |
| `definitions.PrivateDnsZoneGroupListResult.required__added` | added | `["value"]` |
| `definitions.PrivateEndpointConnectionListResult.required__added` | added | `["value"]` |
| `definitions.PrivateEndpointListResult.required__added` | added | `["value"]` |
| `definitions.PrivateLinkServiceListResult.required__added` | added | `["value"]` |
| `definitions.PublicIPAddressListResult.required__added` | added | `["value"]` |
| `definitions.PublicIPPrefixListResult.required__added` | added | `["value"]` |
| `definitions.ReachabilityAnalysisIntentListResult.required__added` | added | `["value"]` |
| `definitions.ReachabilityAnalysisRunListResult.required__added` | added | `["value"]` |
| `definitions.ResourceNavigationLinksListResult.required__added` | added | `["value"]` |
| `definitions.RouteListResult.required__added` | added | `["value"]` |
| `definitions.RouteTableListResult.required__added` | added | `["value"]` |
| `definitions.SecurityPartnerProviderListResult.required__added` | added | `["value"]` |
| `definitions.SecurityRuleListResult.required__added` | added | `["value"]` |
| `definitions.ServiceAssociationLinksListResult.required__added` | added | `["value"]` |
| `definitions.ServiceTagInformationListResult.required__added` | added | `["value"]` |
| `definitions.StaticCidrList.required__added` | added | `["value"]` |
| `definitions.SubnetListResult.required__added` | added | `["value"]` |
| `definitions.UsagesListResult.required__added` | added | `["value"]` |
| `definitions.VerifierWorkspaceListResult.required__added` | added | `["value"]` |
| `definitions.VirtualNetworkDdosProtectionStatusResult.required__added` | added | `["value"]` |
| `definitions.VirtualNetworkListResult.required__added` | added | `["value"]` |
| `definitions.VirtualNetworkListUsageResult.required__added` | added | `["value"]` |
| `definitions.VirtualNetworkPeeringListResult.required__added` | added | `["value"]` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/autoApprovedPrivateLinkServices'].get.parameters[0].required__deleted` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/availableDelegations'].get.parameters[0].required__deleted` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/availablePrivateEndpointTypes'].get.parameters[0].required__deleted` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/availableServiceAliases'].get.parameters[0].required__deleted` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/checkDnsNameAvailability'].get.parameters[0].required__deleted` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/checkPrivateLinkServiceVisibility'].post.parameters[0].required__deleted` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/serviceTagDetails'].get.parameters[0].required__deleted` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/serviceTags'].get.parameters[0].required__deleted` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/usages'].get.parameters[0].required__deleted` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/virtualNetworkAvailableEndpointServices'].get.parameters[0].required__deleted` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/autoApprovedPrivateLinkServices'].get.parameters[0].required__deleted` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/availableDelegations'].get.parameters[0].required__deleted` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/availablePrivateEndpointTypes'].get.parameters[0].required__deleted` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/availableServiceAliases'].get.parameters[0].required__deleted` | deleted | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/checkPrivateLinkServiceVisibility'].post.parameters[0].required__deleted` | deleted | `true` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BastionActiveSession.properties.protocol.type__deleted` | deleted | `string` |
| `definitions.BastionActiveSession.properties.startTime.type__deleted` | deleted | `object` |
| `definitions.BastionHostPropertiesFormat.properties.networkAcls.type__deleted` | deleted | `object` |
| `definitions.CustomIpPrefixPropertiesFormat.properties.commissionedState.type__deleted` | deleted | `string` |
| `definitions.CustomIpPrefixPropertiesFormat.properties.geo.type__deleted` | deleted | `string` |
| `definitions.CustomIpPrefixPropertiesFormat.properties.prefixType.type__deleted` | deleted | `string` |
| `definitions.DdosDetectionRulePropertiesFormat.properties.detectionMode.type__deleted` | deleted | `string` |
| `definitions.DdosProtectionPlan.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.DdosSettings.properties.protectionMode.type__deleted` | deleted | `string` |
| `definitions.DscpConfigurationPropertiesFormat.properties.protocol.type__deleted` | deleted | `string` |
| `definitions.EffectiveNetworkSecurityRule.properties.protocol.type__deleted` | deleted | `string` |
| `definitions.EffectiveRoute.properties.source.type__deleted` | deleted | `string` |
| `definitions.EffectiveRoute.properties.state.type__deleted` | deleted | `string` |
| `definitions.InboundSecurityRule.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.InboundSecurityRuleProperties.properties.ruleType.type__deleted` | deleted | `string` |
| `definitions.InboundSecurityRules.properties.protocol.type__deleted` | deleted | `string` |
| `definitions.IpAllocationPropertiesFormat.properties.type.type__deleted` | deleted | `string` |
| `definitions.IpamPoolPrefixAllocation.properties.pool.type__deleted` | deleted | `object` |
| `definitions.IpamPoolProperties.properties.ipAddressType.items.type__deleted` | deleted | `string` |
| `definitions.IpamPoolProperties.properties.provisioningState.type__deleted` | deleted | `string` |
| `definitions.IPConfigurationPropertiesFormat.properties.privateIPAllocationMethod.type__added` | added | `string` |
| `definitions.IPTraffic.properties.protocols.items.type__deleted` | deleted | `string` |
| `definitions.NatGatewaySku.properties.name.type__deleted` | deleted | `string` |
| `definitions.NetworkInterfaceIPConfiguration.properties.type__deleted` | deleted | `{"type":"string"}` |
| `definitions.NetworkInterfacePropertiesFormat.properties.auxiliaryMode.type__deleted` | deleted | `string` |
| `definitions.NetworkInterfacePropertiesFormat.properties.auxiliarySku.type__deleted` | deleted | `string` |
| `definitions.NetworkInterfacePropertiesFormat.properties.migrationPhase.type__deleted` | deleted | `string` |
| `definitions.NetworkInterfacePropertiesFormat.properties.nicType.type__deleted` | deleted | `string` |
| `definitions.NetworkInterfaceTapConfiguration.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.networkProfile.type__deleted` | deleted | `object` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.nvaInterfaceConfigurations.type__added` | added | `array` |
| `definitions.NvaInterfaceConfigurationsProperties.properties.type.items.type__deleted` | deleted | `string` |
| `definitions.PrivateEndpointConnection.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.PrivateLinkServiceProperties.properties.accessMode.type__deleted` | deleted | `string` |
| `definitions.PublicIPAddressDnsSettings.properties.domainNameLabelScope.type__deleted` | deleted | `string` |
| `definitions.PublicIPAddressPropertiesFormat.properties.deleteOption.type__deleted` | deleted | `string` |
| `definitions.PublicIPAddressPropertiesFormat.properties.migrationPhase.type__deleted` | deleted | `string` |
| `definitions.PublicIPAddressSku.properties.name.type__deleted` | deleted | `string` |
| `definitions.PublicIPAddressSku.properties.tier.type__deleted` | deleted | `string` |
| `definitions.PublicIpDdosProtectionStatusResult.properties.isWorkloadProtected.type__deleted` | deleted | `string` |
| `definitions.PublicIPPrefixSku.properties.name.type__deleted` | deleted | `string` |
| `definitions.PublicIPPrefixSku.properties.tier.type__deleted` | deleted | `string` |
| `definitions.QosDefinition.properties.protocol.type__deleted` | deleted | `string` |
| `definitions.ReachabilityAnalysisIntentProperties.properties.provisioningState.type__deleted` | deleted | `string` |
| `definitions.ReachabilityAnalysisRunProperties.properties.provisioningState.type__deleted` | deleted | `string` |
| `definitions.ReserveCloudServicePublicIpAddressRequest.properties.isRollback.type__deleted` | deleted | `string` |
| `definitions.Route.properties.type__deleted` | deleted | `{"type":"string"}` |
| `definitions.RoutePropertiesFormat.properties.nextHopType.type__deleted` | deleted | `string` |
| `definitions.SecurityPartnerProviderPropertiesFormat.properties.connectionStatus.type__deleted` | deleted | `string` |
| `definitions.SecurityPartnerProviderPropertiesFormat.properties.securityProviderName.type__deleted` | deleted | `string` |
| `definitions.SecurityRule.properties.type__deleted` | deleted | `{"type":"string"}` |
| `definitions.SecurityRulePropertiesFormat.properties.access.type__deleted` | deleted | `string` |
| `definitions.SecurityRulePropertiesFormat.properties.direction.type__deleted` | deleted | `string` |
| `definitions.SecurityRulePropertiesFormat.properties.protocol.type__deleted` | deleted | `string` |
| `definitions.StaticCidrProperties.properties.provisioningState.type__deleted` | deleted | `string` |
| `definitions.Subnet.properties.type__deleted` | deleted | `{"type":"string"}` |
| `definitions.SubnetPropertiesFormat.properties.sharingScope.type__deleted` | deleted | `string` |
| `definitions.SwapResource.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.SwapResourceProperties.properties.slotType.type__deleted` | deleted | `string` |
| `definitions.TrafficDetectionRule.properties.trafficType.type__deleted` | deleted | `string` |
| `definitions.Usage.properties.unit.type__deleted` | deleted | `string` |
| `definitions.VerifierWorkspaceProperties.properties.provisioningState.type__deleted` | deleted | `string` |
| `definitions.VirtualApplianceNetworkInterfaceConfiguration.properties.type.type__deleted` | deleted | `string` |
| `definitions.VirtualApplianceNicProperties.properties.nicType.type__deleted` | deleted | `string` |
| `definitions.VirtualApplianceSite.properties.type__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.VirtualNetworkEncryption.properties.enforcement.type__deleted` | deleted | `string` |
| `definitions.VirtualNetworkPeering.properties.type__deleted` | deleted | `{"type":"string"}` |
| `definitions.VirtualNetworkPeeringPropertiesFormat.properties.peeringState.type__deleted` | deleted | `string` |
| `definitions.VirtualNetworkPeeringPropertiesFormat.properties.peeringSyncLevel.type__deleted` | deleted | `string` |
| `definitions.VirtualNetworkPropertiesFormat.properties.privateEndpointVNetPolicies.type__deleted` | deleted | `string` |
| `definitions.VM.type__added` | added | `object` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/autoApprovedPrivateLinkServices'].get.parameters[0].type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/availableDelegations'].get.parameters[0].type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/availablePrivateEndpointTypes'].get.parameters[0].type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/availableServiceAliases'].get.parameters[0].type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/checkDnsNameAvailability'].get.parameters[0].type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/checkPrivateLinkServiceVisibility'].post.parameters[0].type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/serviceTagDetails'].get.parameters[0].type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/serviceTags'].get.parameters[0].type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/usages'].get.parameters[0].type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/virtualNetworkAvailableEndpointServices'].get.parameters[0].type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/autoApprovedPrivateLinkServices'].get.parameters[0].type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/availableDelegations'].get.parameters[0].type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/availablePrivateEndpointTypes'].get.parameters[0].type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/availableServiceAliases'].get.parameters[0].type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/checkPrivateLinkServiceVisibility'].post.parameters[0].type__deleted` | deleted | `string` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BastionActiveSession.properties.protocol.$ref__added` | added | `./common.json#/definitions/BastionConnectProtocol` |
| `definitions.BastionHostPropertiesFormat.properties.networkAcls.$ref__added` | added | `#/definitions/BastionHostPropertiesFormatNetworkAcls` |
| `definitions.CustomIpPrefixPropertiesFormat.properties.commissionedState.$ref__added` | added | `./common.json#/definitions/CommissionedState` |
| `definitions.CustomIpPrefixPropertiesFormat.properties.geo.$ref__added` | added | `./common.json#/definitions/Geo` |
| `definitions.CustomIpPrefixPropertiesFormat.properties.prefixType.$ref__added` | added | `./common.json#/definitions/CustomIpPrefixType` |
| `definitions.DdosDetectionRulePropertiesFormat.properties.detectionMode.$ref__added` | added | `./common.json#/definitions/DdosDetectionMode` |
| `definitions.DdosSettings.properties.protectionMode.$ref__added` | added | `./common.json#/definitions/DdosSettingsProtectionMode` |
| `definitions.DscpConfigurationPropertiesFormat.properties.protocol.$ref__added` | added | `./common.json#/definitions/ProtocolType` |
| `definitions.EffectiveNetworkSecurityRule.properties.protocol.$ref__added` | added | `./common.json#/definitions/EffectiveSecurityRuleProtocol` |
| `definitions.EffectiveRoute.properties.source.$ref__added` | added | `./common.json#/definitions/EffectiveRouteSource` |
| `definitions.EffectiveRoute.properties.state.$ref__added` | added | `./common.json#/definitions/EffectiveRouteState` |
| `definitions.InboundSecurityRuleProperties.properties.ruleType.$ref__added` | added | `./common.json#/definitions/InboundSecurityRuleType` |
| `definitions.InboundSecurityRules.properties.protocol.$ref__added` | added | `./common.json#/definitions/InboundSecurityRulesProtocol` |
| `definitions.IpAllocationPropertiesFormat.properties.type.$ref__added` | added | `./common.json#/definitions/IpAllocationType` |
| `definitions.IpamPoolPrefixAllocation.properties.pool.$ref__added` | added | `#/definitions/IpamPoolPrefixAllocationPool` |
| `definitions.IpamPoolProperties.properties.ipAddressType.items.$ref__added` | added | `./common.json#/definitions/IpType` |
| `definitions.IpamPoolProperties.properties.provisioningState.$ref__added` | added | `./common.json#/definitions/ProvisioningState` |
| `definitions.IPConfigurationPropertiesFormat.properties.privateIPAllocationMethod.$ref__deleted` | deleted | `./network.json#/definitions/IPAllocationMethod` |
| `definitions.IPTraffic.properties.protocols.items.$ref__added` | added | `./common.json#/definitions/NetworkProtocol` |
| `definitions.NatGatewaySku.properties.name.$ref__added` | added | `./common.json#/definitions/NatGatewaySkuName` |
| `definitions.NetworkInterfacePropertiesFormat.properties.auxiliaryMode.$ref__added` | added | `./common.json#/definitions/NetworkInterfaceAuxiliaryMode` |
| `definitions.NetworkInterfacePropertiesFormat.properties.auxiliarySku.$ref__added` | added | `./common.json#/definitions/NetworkInterfaceAuxiliarySku` |
| `definitions.NetworkInterfacePropertiesFormat.properties.migrationPhase.$ref__added` | added | `./common.json#/definitions/NetworkInterfaceMigrationPhase` |
| `definitions.NetworkInterfacePropertiesFormat.properties.nicType.$ref__added` | added | `./common.json#/definitions/NetworkInterfaceNicType` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.networkProfile.$ref__added` | added | `#/definitions/NetworkVirtualAppliancePropertiesFormatNetworkProfile` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.nvaInterfaceConfigurations.$ref__deleted` | deleted | `#/definitions/NvaInterfaceConfigurations` |
| `definitions.NvaInterfaceConfigurationsProperties.properties.type.items.$ref__added` | added | `./common.json#/definitions/NvaNicType` |
| `definitions.PrivateLinkServiceProperties.properties.accessMode.$ref__added` | added | `./common.json#/definitions/AccessMode` |
| `definitions.PrivateLinkServiceProperties.properties.autoApproval.$ref__added` | added | `#/definitions/PrivateLinkServicePropertiesAutoApproval` |
| `definitions.PrivateLinkServiceProperties.properties.visibility.$ref__added` | added | `#/definitions/PrivateLinkServicePropertiesVisibility` |
| `definitions.PublicIPAddressDnsSettings.properties.domainNameLabelScope.$ref__added` | added | `./common.json#/definitions/PublicIpAddressDnsSettingsDomainNameLabelScope` |
| `definitions.PublicIPAddressPropertiesFormat.properties.deleteOption.$ref__added` | added | `./common.json#/definitions/DeleteOptions` |
| `definitions.PublicIPAddressPropertiesFormat.properties.migrationPhase.$ref__added` | added | `./common.json#/definitions/PublicIPAddressMigrationPhase` |
| `definitions.PublicIPAddressSku.properties.name.$ref__added` | added | `./common.json#/definitions/PublicIPAddressSkuName` |
| `definitions.PublicIPAddressSku.properties.tier.$ref__added` | added | `./common.json#/definitions/PublicIPAddressSkuTier` |
| `definitions.PublicIpDdosProtectionStatusResult.properties.isWorkloadProtected.$ref__added` | added | `./common.json#/definitions/IsWorkloadProtected` |
| `definitions.PublicIPPrefixSku.properties.name.$ref__added` | added | `./common.json#/definitions/PublicIPPrefixSkuName` |
| `definitions.PublicIPPrefixSku.properties.tier.$ref__added` | added | `./common.json#/definitions/PublicIPPrefixSkuTier` |
| `definitions.QosDefinition.properties.protocol.$ref__added` | added | `./common.json#/definitions/ProtocolType` |
| `definitions.ReachabilityAnalysisIntentProperties.properties.provisioningState.$ref__added` | added | `./common.json#/definitions/ProvisioningState` |
| `definitions.ReachabilityAnalysisRunProperties.properties.provisioningState.$ref__added` | added | `./common.json#/definitions/ProvisioningState` |
| `definitions.ReserveCloudServicePublicIpAddressRequest.properties.isRollback.$ref__added` | added | `./common.json#/definitions/IsRollback` |
| `definitions.RoutePropertiesFormat.properties.nextHopType.$ref__added` | added | `./common.json#/definitions/RouteNextHopType` |
| `definitions.SecurityPartnerProviderPropertiesFormat.properties.connectionStatus.$ref__added` | added | `./common.json#/definitions/SecurityPartnerProviderConnectionStatus` |
| `definitions.SecurityPartnerProviderPropertiesFormat.properties.securityProviderName.$ref__added` | added | `./common.json#/definitions/SecurityProviderName` |
| `definitions.SecurityRulePropertiesFormat.properties.access.$ref__added` | added | `./common.json#/definitions/SecurityRuleAccess` |
| `definitions.SecurityRulePropertiesFormat.properties.direction.$ref__added` | added | `./common.json#/definitions/SecurityRuleDirection` |
| `definitions.SecurityRulePropertiesFormat.properties.protocol.$ref__added` | added | `./common.json#/definitions/SecurityRuleProtocol` |
| `definitions.StaticCidrProperties.properties.provisioningState.$ref__added` | added | `./common.json#/definitions/ProvisioningState` |
| `definitions.SubnetPropertiesFormat.properties.sharingScope.$ref__added` | added | `./common.json#/definitions/SharingScope` |
| `definitions.SwapResourceProperties.properties.slotType.$ref__added` | added | `./common.json#/definitions/SlotType` |
| `definitions.TrafficDetectionRule.properties.trafficType.$ref__added` | added | `./common.json#/definitions/DdosTrafficType` |
| `definitions.Usage.properties.unit.$ref__added` | added | `./common.json#/definitions/UsageUnit` |
| `definitions.VerifierWorkspaceProperties.properties.provisioningState.$ref__added` | added | `./common.json#/definitions/ProvisioningState` |
| `definitions.VirtualApplianceNetworkInterfaceConfiguration.properties.type.$ref__added` | added | `./common.json#/definitions/NicTypeInRequest` |
| `definitions.VirtualApplianceNicProperties.properties.nicType.$ref__added` | added | `./common.json#/definitions/NicTypeInResponse` |
| `definitions.VirtualNetworkEncryption.properties.enforcement.$ref__added` | added | `./common.json#/definitions/VirtualNetworkEncryptionEnforcement` |
| `definitions.VirtualNetworkPeeringPropertiesFormat.properties.peeringState.$ref__added` | added | `./common.json#/definitions/VirtualNetworkPeeringState` |
| `definitions.VirtualNetworkPeeringPropertiesFormat.properties.peeringSyncLevel.$ref__added` | added | `./common.json#/definitions/VirtualNetworkPeeringLevel` |
| `definitions.VirtualNetworkPropertiesFormat.properties.privateEndpointVNetPolicies.$ref__added` | added | `./common.json#/definitions/PrivateEndpointVNetPolicies` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/autoApprovedPrivateLinkServices'].get.parameters[0].$ref__added` | added | `../../../../../../common-types/resource-management/v5/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/availableDelegations'].get.parameters[0].$ref__added` | added | `../../../../../../common-types/resource-management/v5/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/availablePrivateEndpointTypes'].get.parameters[0].$ref__added` | added | `../../../../../../common-types/resource-management/v5/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/availableServiceAliases'].get.parameters[0].$ref__added` | added | `../../../../../../common-types/resource-management/v5/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/checkDnsNameAvailability'].get.parameters[0].$ref__added` | added | `../../../../../../common-types/resource-management/v5/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/checkPrivateLinkServiceVisibility'].post.parameters[0].$ref__added` | added | `../../../../../../common-types/resource-management/v5/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/serviceTagDetails'].get.parameters[0].$ref__added` | added | `../../../../../../common-types/resource-management/v5/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/serviceTags'].get.parameters[0].$ref__added` | added | `../../../../../../common-types/resource-management/v5/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/usages'].get.parameters[0].$ref__added` | added | `../../../../../../common-types/resource-management/v5/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/virtualNetworkAvailableEndpointServices'].get.parameters[0].$ref__added` | added | `../../../../../../common-types/resource-management/v5/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/autoApprovedPrivateLinkServices'].get.parameters[0].$ref__added` | added | `../../../../../../common-types/resource-management/v5/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/availableDelegations'].get.parameters[0].$ref__added` | added | `../../../../../../common-types/resource-management/v5/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/availablePrivateEndpointTypes'].get.parameters[0].$ref__added` | added | `../../../../../../common-types/resource-management/v5/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/availableServiceAliases'].get.parameters[0].$ref__added` | added | `../../../../../../common-types/resource-management/v5/types.json#/parameters/LocationParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/checkPrivateLinkServiceVisibility'].post.parameters[0].$ref__added` | added | `../../../../../../common-types/resource-management/v5/types.json#/parameters/LocationParameter` |

### Changes for `headers`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/checkPrivateLinkServiceVisibility'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/microsoft.Compute/cloudServices/{resourceName}/providers/microsoft.Network/cloudServiceSlots/{singletonResource}'].put.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationSecurityGroups/{applicationSecurityGroupName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationSecurityGroups/{applicationSecurityGroupName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts/{bastionHostName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts/{bastionHostName}'].patch.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts/{bastionHostName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts/{bastionHostName}/createShareableLinks'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts/{bastionHostName}/deleteShareableLinks'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts/{bastionHostName}/getActiveSessions'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/customIpPrefixes/{customIpPrefixName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/customIpPrefixes/{customIpPrefixName}'].put.responses.201.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ddosCustomPolicies/{ddosCustomPolicyName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ddosProtectionPlans/{ddosProtectionPlanName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/dscpConfigurations/{dscpConfigurationName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/dscpConfigurations/{dscpConfigurationName}'].put.responses.201.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ipAllocations/{ipAllocationName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ipGroups/{ipGroupsName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ipGroups/{ipGroupsName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/checkPrivateLinkServiceVisibility'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/natGateways/{natGatewayName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/natGateways/{natGatewayName}'].put.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}/effectiveNetworkSecurityGroups'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}/effectiveRouteTable'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}/tapConfigurations/{tapConfigurationName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}/tapConfigurations/{tapConfigurationName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkProfiles/{networkProfileName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}/securityRules/{securityRuleName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}/securityRules/{securityRuleName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/inboundSecurityRules/{ruleCollectionName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/virtualApplianceSites/{siteName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/virtualApplianceSites/{siteName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateEndpoints/{privateEndpointName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateEndpoints/{privateEndpointName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateEndpoints/{privateEndpointName}/privateDnsZoneGroups/{privateDnsZoneGroupName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateEndpoints/{privateEndpointName}/privateDnsZoneGroups/{privateDnsZoneGroupName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateLinkServices/{serviceName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateLinkServices/{serviceName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateLinkServices/{serviceName}/privateEndpointConnections/{peConnectionName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPPrefixes/{publicIpPrefixName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPPrefixes/{publicIpPrefixName}'].put.responses.201.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeTables/{routeTableName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeTables/{routeTableName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeTables/{routeTableName}/routes/{routeName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeTables/{routeTableName}/routes/{routeName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/securityPartnerProviders/{securityPartnerProviderName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/securityPartnerProviders/{securityPartnerProviderName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/ddosProtectionStatus'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}/prepareNetworkPolicies'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}/unprepareNetworkPolicies'].post.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/virtualNetworkPeerings/{virtualNetworkPeeringName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/virtualNetworkPeerings/{virtualNetworkPeeringName}'].put.responses.201.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |

### Changes for `pattern`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/usages'].get.parameters[0].pattern__deleted` | deleted | `^[-\\w\\._ ]+$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/getBootDiagnosticLogs'].post.parameters[0].pattern__deleted` | deleted | `^[A-Za-z0-9_]+` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/reimage'].post.parameters[0].pattern__deleted` | deleted | `^[A-Za-z0-9_]+` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}/disassociateCloudServiceReservedPublicIp'].post.parameters[0].pattern__deleted` | deleted | `^[A-Za-z0-9][A-Za-z0-9_\\.-]*[A-Za-z0-9_]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}/reserveCloudServicePublicIpAddress'].post.parameters[0].pattern__deleted` | deleted | `^[A-Za-z0-9][A-Za-z0-9_\\.-]*[A-Za-z0-9_]$` |

### Changes for `final-state-schema`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationSecurityGroups/{applicationSecurityGroupName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/ApplicationSecurityGroup` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts/{bastionHostName}'].patch['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/BastionHost` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts/{bastionHostName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/BastionHost` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ddosCustomPolicies/{ddosCustomPolicyName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/DdosCustomPolicy` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ddosProtectionPlans/{ddosProtectionPlanName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/DdosProtectionPlan` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ipAllocations/{ipAllocationName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/IpAllocation` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ipGroups/{ipGroupsName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/IpGroup` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/natGateways/{natGatewayName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/NatGateway` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/NetworkInterface` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}/tapConfigurations/{tapConfigurationName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/NetworkInterfaceTapConfiguration` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/IpamPool` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/NetworkSecurityGroup` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}/securityRules/{securityRuleName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/SecurityRule` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/NetworkVirtualAppliance` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/inboundSecurityRules/{ruleCollectionName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/InboundSecurityRule` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/virtualApplianceSites/{siteName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VirtualApplianceSite` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateEndpoints/{privateEndpointName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/PrivateEndpoint` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateEndpoints/{privateEndpointName}/privateDnsZoneGroups/{privateDnsZoneGroupName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/PrivateDnsZoneGroup` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateLinkServices/{serviceName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/PrivateLinkService` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/PublicIPAddress` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeTables/{routeTableName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/RouteTable` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeTables/{routeTableName}/routes/{routeName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/Route` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/securityPartnerProviders/{securityPartnerProviderName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/SecurityPartnerProvider` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VirtualNetwork` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/Subnet` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/virtualNetworkPeerings/{virtualNetworkPeeringName}'].put['x-ms-long-running-operation-options']['final-state-schema__added']` | added | `#/definitions/VirtualNetworkPeering` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EffectiveNetworkSecurityGroup.properties.tagMap.additionalProperties.description__deleted` | deleted | `List of IP Addresses within the tag (key).` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts/{bastionHostName}/deleteShareableLinksByToken'].post.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}'].delete.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}'].put.responses.201.headers['Azure-AsyncOperation'].description__added` | added | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}/staticCidrs/{staticCidrName}'].delete.responses.202.headers.Location.description__added` | added | `The Location header contains the URL where the status of the long running operation can be checked.` |

### Changes for `Azure-AsyncOperation`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}'].put.responses.201.headers['Azure-AsyncOperation__added']` | added | `{"type":"string","format":"uri","description":"A link to the status monitor"}` |

### Changes for `minLength`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}/disassociateCloudServiceReservedPublicIp'].post.parameters[0].minLength__deleted` | deleted | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}/reserveCloudServicePublicIpAddress'].post.parameters[0].minLength__deleted` | deleted | `1` |

### Changes for `maxLength`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}/disassociateCloudServiceReservedPublicIp'].post.parameters[0].maxLength__deleted` | deleted | `80` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}/reserveCloudServicePublicIpAddress'].post.parameters[0].maxLength__deleted` | deleted | `80` |

### Changes for `format`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BastionActiveSession.properties.sessionDurationInMins.format__added` | added | `float` |
| `definitions.IpAllocationPropertiesFormat.properties.prefixLength.format__added` | added | `int32` |
| `definitions.RecordSet.properties.ttl.format__added` | added | `int32` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}/disassociateCloudServiceReservedPublicIp'].post.responses.202.headers['Azure-AsyncOperation'].format__added` | added | `uri` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}/reserveCloudServicePublicIpAddress'].post.responses.202.headers['Azure-AsyncOperation'].format__added` | added | `uri` |

### Changes for `BGPCommunity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BGPCommunity__deleted` | deleted | `{"type":"object","properties":{"serviceSupportedRegion":{"type":"string"},"communityName":{"type":"s...` |

### Changes for `BgpServiceCommunity`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BgpServiceCommunity__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/BgpServiceCommunityPropertiesForm...` |

### Changes for `BgpServiceCommunityListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BgpServiceCommunityListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `BgpServiceCommunityPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BgpServiceCommunityPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"serviceName":{"type":"string"},"bgpCommunities":{"type":"array","ite...` |

### Changes for `GetServiceGatewayAddressLocationsResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GetServiceGatewayAddressLocationsResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `GetServiceGatewayServicesResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.GetServiceGatewayServicesResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `NvaInterfaceConfigurations`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NvaInterfaceConfigurations__deleted` | deleted | `{"type":"array","maxItems":3,"items":{"$ref":"#/definitions/NvaInterfaceConfigurationsProperties"},"...` |

### Changes for `PatchRouteFilter`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PatchRouteFilter__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/RouteFilterPropertiesFormat","x-m...` |

### Changes for `PatchRouteFilterRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PatchRouteFilterRule__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/RouteFilterRulePropertiesFormat",...` |

### Changes for `RouteFilter`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RouteFilter__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/RouteFilterPropertiesFormat","x-m...` |

### Changes for `RouteFilterListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RouteFilterListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `RouteFilterPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RouteFilterPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"rules":{"type":"array","items":{"$ref":"#/definitions/RouteFilterRul...` |

### Changes for `RouteFilterRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RouteFilterRule__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/RouteFilterRulePropertiesFormat",...` |

### Changes for `RouteFilterRuleListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RouteFilterRuleListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `RouteFilterRulePropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RouteFilterRulePropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"access":{"$ref":"./network.json#/definitions/Access"},"routeFilterRu...` |

### Changes for `RouteTargetAddressPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RouteTargetAddressPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"subnet":{"$ref":"./virtualNetwork.json#/definitions/Subnet"},"privat...` |

### Changes for `ServiceEndpointPolicy`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceEndpointPolicy__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ServiceEndpointPolicyPropertiesFo...` |

### Changes for `ServiceEndpointPolicyDefinition`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceEndpointPolicyDefinition__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ServiceEndpointPolicyDefinitionPr...` |

### Changes for `ServiceEndpointPolicyDefinitionListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceEndpointPolicyDefinitionListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `ServiceEndpointPolicyDefinitionPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceEndpointPolicyDefinitionPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"description":{"type":"string"},"service":{"type":"string"},"serviceR...` |

### Changes for `ServiceEndpointPolicyListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceEndpointPolicyListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `ServiceEndpointPolicyPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceEndpointPolicyPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"serviceEndpointPolicyDefinitions":{"type":"array","items":{"$ref":"#...` |

### Changes for `ServiceGateway`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceGateway__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/ServiceGatewayPropertiesFormat","...` |

### Changes for `ServiceGatewayAddress`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceGatewayAddress__deleted` | deleted | `{"type":"object","properties":{"address":{"type":"string"},"services":{"type":"array","items":{"type...` |

### Changes for `ServiceGatewayAddressLocation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceGatewayAddressLocation__deleted` | deleted | `{"type":"object","properties":{"addressLocation":{"type":"string"},"addressUpdateAction":{"type":"st...` |

### Changes for `ServiceGatewayAddressLocationResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceGatewayAddressLocationResponse__deleted` | deleted | `{"type":"object","properties":{"addressLocation":{"type":"string"},"addresses":{"type":"array","item...` |

### Changes for `ServiceGatewayListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceGatewayListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `ServiceGatewayPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceGatewayPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"virtualNetwork":{"$ref":"./virtualNetwork.json#/definitions/VirtualN...` |

### Changes for `ServiceGatewayService`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceGatewayService__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string"},"properties":{"$ref":"#/definitions/ServiceG...` |

### Changes for `ServiceGatewayServicePropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceGatewayServicePropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"serviceType":{"type":"string","enum":["Inbound","Outbound","InboundO...` |

### Changes for `ServiceGatewayServiceRequest`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceGatewayServiceRequest__deleted` | deleted | `{"type":"object","properties":{"isDelete":{"type":"boolean"},"service":{"$ref":"#/definitions/Servic...` |

### Changes for `ServiceGatewaySku`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceGatewaySku__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string","enum":["Standard"],"x-ms-enum":{"name":"Serv...` |

### Changes for `ServiceGatewayUpdateAddressLocationsRequest`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceGatewayUpdateAddressLocationsRequest__deleted` | deleted | `{"type":"object","properties":{"action":{"type":"string","enum":["FullUpdate","PartialUpdate"],"x-ms...` |

### Changes for `ServiceGatewayUpdateServicesRequest`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ServiceGatewayUpdateServicesRequest__deleted` | deleted | `{"type":"object","properties":{"action":{"type":"string","enum":["FullUpdate","PartialUpdate"],"x-ms...` |

### Changes for `VirtualNetworkAppliance`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualNetworkAppliance__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/VirtualNetworkApplianceProperties...` |

### Changes for `VirtualNetworkApplianceIpConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualNetworkApplianceIpConfiguration__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/VirtualNetworkApplianceIpConfigur...` |

### Changes for `VirtualNetworkApplianceIpConfigurationProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualNetworkApplianceIpConfigurationProperties__deleted` | deleted | `{"type":"object","properties":{"privateIPAddress":{"type":"string"},"privateIPAllocationMethod":{"$r...` |

### Changes for `VirtualNetworkApplianceListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualNetworkApplianceListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `VirtualNetworkAppliancePropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualNetworkAppliancePropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"bandwidthInGbps":{"type":"string"},"ipConfigurations":{"type":"array...` |

### Changes for `VirtualNetworkTap`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualNetworkTap__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/VirtualNetworkTapPropertiesFormat...` |

### Changes for `VirtualNetworkTapListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualNetworkTapListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `VirtualNetworkTapPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualNetworkTapPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"networkInterfaceTapConfigurations":{"type":"array","items":{"$ref":"...` |

### Changes for `BastionHostPropertiesFormatNetworkAcls`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BastionHostPropertiesFormatNetworkAcls__added` | added | `{"type":"object","properties":{"ipRules":{"type":"array","items":{"$ref":"#/definitions/IPRule"}}}}` |

### Changes for `IpamPoolPrefixAllocationPool`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IpamPoolPrefixAllocationPool__added` | added | `{"type":"object","properties":{"id":{"type":"string","format":"arm-id"}}}` |

### Changes for `NetworkVirtualAppliancePropertiesFormatNetworkProfile`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkVirtualAppliancePropertiesFormatNetworkProfile__added` | added | `{"type":"object","properties":{"networkInterfaceConfigurations":{"type":"array","items":{"$ref":"#/d...` |

### Changes for `PrivateLinkServicePropertiesAutoApproval`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PrivateLinkServicePropertiesAutoApproval__added` | added | `{"type":"object","allOf":[{"$ref":"#/definitions/ResourceSet"}]}` |

### Changes for `PrivateLinkServicePropertiesVisibility`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PrivateLinkServicePropertiesVisibility__added` | added | `{"type":"object","allOf":[{"$ref":"#/definitions/ResourceSet"}]}` |

### Changes for `VirtualRouter`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualRouter__added` | added | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/VirtualRouterPropertiesFormat","x...` |

### Changes for `VirtualRouterListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualRouterListResult__added` | added | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `VirtualRouterPeering`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualRouterPeering__added` | added | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/VirtualRouterPeeringProperties","...` |

### Changes for `VirtualRouterPeeringListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualRouterPeeringListResult__added` | added | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `VirtualRouterPeeringProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualRouterPeeringProperties__added` | added | `{"type":"object","properties":{"peerAsn":{"type":"integer","format":"int64","minimum":0,"maximum":42...` |

### Changes for `VirtualRouterPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.VirtualRouterPropertiesFormat__added` | added | `{"type":"object","properties":{"virtualRouterAsn":{"type":"integer","format":"int64","minimum":0,"ma...` |

### Changes for `enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BastionActiveSession.properties.protocol.enum__deleted` | deleted | `["SSH","RDP"]` |
| `definitions.CustomIpPrefixPropertiesFormat.properties.commissionedState.enum__deleted` | deleted | `["Provisioning","Provisioned","Commissioning","CommissionedNoInternetAdvertise","Commissioned","Deco...` |
| `definitions.CustomIpPrefixPropertiesFormat.properties.geo.enum__deleted` | deleted | `["GLOBAL","AFRI","APAC","EURO","LATAM","NAM","ME","OCEANIA","AQ"]` |
| `definitions.CustomIpPrefixPropertiesFormat.properties.prefixType.enum__deleted` | deleted | `["Singular","Parent","Child"]` |
| `definitions.DdosDetectionRulePropertiesFormat.properties.detectionMode.enum__deleted` | deleted | `["TrafficThreshold"]` |
| `definitions.DdosSettings.properties.protectionMode.enum__deleted` | deleted | `["VirtualNetworkInherited","Enabled","Disabled"]` |
| `definitions.DscpConfigurationPropertiesFormat.properties.protocol.enum__deleted` | deleted | `["DoNotUse","Icmp","Tcp","Udp","Gre","Esp","Ah","Vxlan","All"]` |
| `definitions.EffectiveNetworkSecurityRule.properties.protocol.enum__deleted` | deleted | `["Tcp","Udp","All"]` |
| `definitions.EffectiveRoute.properties.source.enum__deleted` | deleted | `["Unknown","User","VirtualNetworkGateway","Default"]` |
| `definitions.EffectiveRoute.properties.state.enum__deleted` | deleted | `["Active","Invalid"]` |
| `definitions.InboundSecurityRuleProperties.properties.ruleType.enum__deleted` | deleted | `["AutoExpire","Permanent"]` |
| `definitions.InboundSecurityRules.properties.protocol.enum__deleted` | deleted | `["TCP","UDP"]` |
| `definitions.IpAllocationPropertiesFormat.properties.type.enum__deleted` | deleted | `["Undefined","Hypernet"]` |
| `definitions.IpamPoolProperties.properties.ipAddressType.items.enum__deleted` | deleted | `["IPv4","IPv6"]` |
| `definitions.IpamPoolProperties.properties.provisioningState.enum__deleted` | deleted | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.IPConfigurationPropertiesFormat.properties.privateIPAllocationMethod.enum__added` | added | `["Static","Dynamic"]` |
| `definitions.IPTraffic.properties.protocols.items.enum__deleted` | deleted | `["Any","TCP","UDP","ICMP"]` |
| `definitions.NatGatewaySku.properties.name.enum__deleted` | deleted | `["Standard","StandardV2"]` |
| `definitions.NetworkInterfacePropertiesFormat.properties.auxiliaryMode.enum__deleted` | deleted | `["None","MaxConnections","Floating","AcceleratedConnections"]` |
| `definitions.NetworkInterfacePropertiesFormat.properties.auxiliarySku.enum__deleted` | deleted | `["None","A1","A2","A4","A8"]` |
| `definitions.NetworkInterfacePropertiesFormat.properties.migrationPhase.enum__deleted` | deleted | `["None","Prepare","Commit","Abort","Committed"]` |
| `definitions.NetworkInterfacePropertiesFormat.properties.nicType.enum__deleted` | deleted | `["Standard","Elastic"]` |
| `definitions.NvaInterfaceConfigurationsProperties.properties.type.items.enum__deleted` | deleted | `["PrivateNic","PublicNic","AdditionalPrivateNic","AdditionalPublicNic"]` |
| `definitions.PrivateLinkServiceProperties.properties.accessMode.enum__deleted` | deleted | `["Default","Restricted"]` |
| `definitions.PublicIPAddressDnsSettings.properties.domainNameLabelScope.enum__deleted` | deleted | `["TenantReuse","SubscriptionReuse","ResourceGroupReuse","NoReuse"]` |
| `definitions.PublicIPAddressPropertiesFormat.properties.deleteOption.enum__deleted` | deleted | `["Delete","Detach"]` |
| `definitions.PublicIPAddressPropertiesFormat.properties.migrationPhase.enum__deleted` | deleted | `["None","Prepare","Commit","Abort","Committed"]` |
| `definitions.PublicIPAddressSku.properties.name.enum__deleted` | deleted | `["Basic","Standard","StandardV2"]` |
| `definitions.PublicIPAddressSku.properties.tier.enum__deleted` | deleted | `["Regional","Global"]` |
| `definitions.PublicIpDdosProtectionStatusResult.properties.isWorkloadProtected.enum__deleted` | deleted | `["False","True"]` |
| `definitions.PublicIPPrefixSku.properties.name.enum__deleted` | deleted | `["Standard","StandardV2"]` |
| `definitions.PublicIPPrefixSku.properties.tier.enum__deleted` | deleted | `["Regional","Global"]` |
| `definitions.QosDefinition.properties.protocol.enum__deleted` | deleted | `["DoNotUse","Icmp","Tcp","Udp","Gre","Esp","Ah","Vxlan","All"]` |
| `definitions.ReachabilityAnalysisIntentProperties.properties.provisioningState.enum__deleted` | deleted | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ReachabilityAnalysisRunProperties.properties.provisioningState.enum__deleted` | deleted | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ReserveCloudServicePublicIpAddressRequest.properties.isRollback.enum__deleted` | deleted | `["true","false"]` |
| `definitions.RoutePropertiesFormat.properties.nextHopType.enum__deleted` | deleted | `["VirtualNetworkGateway","VnetLocal","Internet","VirtualAppliance","None"]` |
| `definitions.SecurityPartnerProviderPropertiesFormat.properties.connectionStatus.enum__deleted` | deleted | `["Unknown","PartiallyConnected","Connected","NotConnected"]` |
| `definitions.SecurityPartnerProviderPropertiesFormat.properties.securityProviderName.enum__deleted` | deleted | `["ZScaler","IBoss","Checkpoint"]` |
| `definitions.SecurityRulePropertiesFormat.properties.access.enum__deleted` | deleted | `["Allow","Deny"]` |
| `definitions.SecurityRulePropertiesFormat.properties.direction.enum__deleted` | deleted | `["Inbound","Outbound"]` |
| `definitions.SecurityRulePropertiesFormat.properties.protocol.enum__deleted` | deleted | `["Tcp","Udp","Icmp","Esp","*","Ah"]` |
| `definitions.StaticCidrProperties.properties.provisioningState.enum__deleted` | deleted | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.SubnetPropertiesFormat.properties.sharingScope.enum__deleted` | deleted | `["Tenant","DelegatedServices"]` |
| `definitions.SwapResourceProperties.properties.slotType.enum__deleted` | deleted | `["Production","Staging"]` |
| `definitions.TrafficDetectionRule.properties.trafficType.enum__deleted` | deleted | `["Tcp","Udp","TcpSyn"]` |
| `definitions.Usage.properties.unit.enum__deleted` | deleted | `["Count"]` |
| `definitions.VerifierWorkspaceProperties.properties.provisioningState.enum__deleted` | deleted | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.VirtualApplianceNetworkInterfaceConfiguration.properties.type.enum__deleted` | deleted | `["PublicNic","PrivateNic"]` |
| `definitions.VirtualApplianceNicProperties.properties.nicType.enum__deleted` | deleted | `["PublicNic","PrivateNic","AdditionalNic"]` |
| `definitions.VirtualNetworkEncryption.properties.enforcement.enum__deleted` | deleted | `["DropUnencrypted","AllowUnencrypted"]` |
| `definitions.VirtualNetworkPeeringPropertiesFormat.properties.peeringState.enum__deleted` | deleted | `["Initiated","Connected","Disconnected"]` |
| `definitions.VirtualNetworkPeeringPropertiesFormat.properties.peeringSyncLevel.enum__deleted` | deleted | `["FullyInSync","RemoteNotInSync","LocalNotInSync","LocalAndRemoteNotInSync"]` |
| `definitions.VirtualNetworkPropertiesFormat.properties.privateEndpointVNetPolicies.enum__deleted` | deleted | `["Disabled","Basic"]` |

### Changes for `x-ms-enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BastionActiveSession.properties.protocol['x-ms-enum__deleted']` | deleted | `{"name":"BastionConnectProtocol","modelAsString":true}` |
| `definitions.CustomIpPrefixPropertiesFormat.properties.commissionedState['x-ms-enum__deleted']` | deleted | `{"name":"CommissionedState","modelAsString":true}` |
| `definitions.CustomIpPrefixPropertiesFormat.properties.geo['x-ms-enum__deleted']` | deleted | `{"name":"Geo","modelAsString":true}` |
| `definitions.CustomIpPrefixPropertiesFormat.properties.prefixType['x-ms-enum__deleted']` | deleted | `{"name":"CustomIpPrefixType","modelAsString":true}` |
| `definitions.DdosDetectionRulePropertiesFormat.properties.detectionMode['x-ms-enum__deleted']` | deleted | `{"name":"DdosDetectionMode","modelAsString":true}` |
| `definitions.DdosSettings.properties.protectionMode['x-ms-enum__deleted']` | deleted | `{"name":"DdosSettingsProtectionMode","modelAsString":true}` |
| `definitions.DscpConfigurationPropertiesFormat.properties.protocol['x-ms-enum__deleted']` | deleted | `{"name":"ProtocolType","modelAsString":true}` |
| `definitions.EffectiveNetworkSecurityRule.properties.protocol['x-ms-enum__deleted']` | deleted | `{"name":"EffectiveSecurityRuleProtocol","modelAsString":true}` |
| `definitions.EffectiveRoute.properties.source['x-ms-enum__deleted']` | deleted | `{"name":"EffectiveRouteSource","modelAsString":true}` |
| `definitions.EffectiveRoute.properties.state['x-ms-enum__deleted']` | deleted | `{"name":"EffectiveRouteState","modelAsString":true}` |
| `definitions.InboundSecurityRuleProperties.properties.ruleType['x-ms-enum__deleted']` | deleted | `{"name":"InboundSecurityRuleType","modelAsString":true}` |
| `definitions.InboundSecurityRules.properties.protocol['x-ms-enum__deleted']` | deleted | `{"name":"InboundSecurityRulesProtocol","modelAsString":true}` |
| `definitions.IpAllocationPropertiesFormat.properties.type['x-ms-enum__deleted']` | deleted | `{"name":"IpAllocationType","modelAsString":true}` |
| `definitions.IpamPoolProperties.properties.ipAddressType.items['x-ms-enum__deleted']` | deleted | `{"name":"IpType","modelAsString":true}` |
| `definitions.IpamPoolProperties.properties.provisioningState['x-ms-enum__deleted']` | deleted | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.IPConfigurationPropertiesFormat.properties.privateIPAllocationMethod['x-ms-enum__added']` | added | `{"name":"IPAllocationMethod","modelAsString":true}` |
| `definitions.IPTraffic.properties.protocols.items['x-ms-enum__deleted']` | deleted | `{"name":"NetworkProtocol","modelAsString":true}` |
| `definitions.NatGatewaySku.properties.name['x-ms-enum__deleted']` | deleted | `{"name":"NatGatewaySkuName","modelAsString":true}` |
| `definitions.NetworkInterfacePropertiesFormat.properties.auxiliaryMode['x-ms-enum__deleted']` | deleted | `{"name":"NetworkInterfaceAuxiliaryMode","modelAsString":true}` |
| `definitions.NetworkInterfacePropertiesFormat.properties.auxiliarySku['x-ms-enum__deleted']` | deleted | `{"name":"NetworkInterfaceAuxiliarySku","modelAsString":true}` |
| `definitions.NetworkInterfacePropertiesFormat.properties.migrationPhase['x-ms-enum__deleted']` | deleted | `{"name":"NetworkInterfaceMigrationPhase","modelAsString":true}` |
| `definitions.NetworkInterfacePropertiesFormat.properties.nicType['x-ms-enum__deleted']` | deleted | `{"name":"NetworkInterfaceNicType","modelAsString":true}` |
| `definitions.NvaInterfaceConfigurationsProperties.properties.type.items['x-ms-enum__deleted']` | deleted | `{"name":"NvaNicType","modelAsString":true}` |
| `definitions.PrivateLinkServiceProperties.properties.accessMode['x-ms-enum__deleted']` | deleted | `{"name":"AccessMode","modelAsString":true}` |
| `definitions.PublicIPAddressDnsSettings.properties.domainNameLabelScope['x-ms-enum__deleted']` | deleted | `{"name":"PublicIpAddressDnsSettingsDomainNameLabelScope","modelAsString":false}` |
| `definitions.PublicIPAddressPropertiesFormat.properties.deleteOption['x-ms-enum__deleted']` | deleted | `{"name":"DeleteOptions","modelAsString":true}` |
| `definitions.PublicIPAddressPropertiesFormat.properties.migrationPhase['x-ms-enum__deleted']` | deleted | `{"name":"PublicIPAddressMigrationPhase","modelAsString":true}` |
| `definitions.PublicIPAddressSku.properties.name['x-ms-enum__deleted']` | deleted | `{"name":"PublicIPAddressSkuName","modelAsString":true}` |
| `definitions.PublicIPAddressSku.properties.tier['x-ms-enum__deleted']` | deleted | `{"name":"PublicIPAddressSkuTier","modelAsString":true}` |
| `definitions.PublicIpDdosProtectionStatusResult.properties.isWorkloadProtected['x-ms-enum__deleted']` | deleted | `{"name":"IsWorkloadProtected","modelAsString":true}` |
| `definitions.PublicIPPrefixSku.properties.name['x-ms-enum__deleted']` | deleted | `{"name":"PublicIPPrefixSkuName","modelAsString":true}` |
| `definitions.PublicIPPrefixSku.properties.tier['x-ms-enum__deleted']` | deleted | `{"name":"PublicIPPrefixSkuTier","modelAsString":true}` |
| `definitions.QosDefinition.properties.protocol['x-ms-enum__deleted']` | deleted | `{"name":"ProtocolType","modelAsString":true}` |
| `definitions.ReachabilityAnalysisIntentProperties.properties.provisioningState['x-ms-enum__deleted']` | deleted | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ReachabilityAnalysisRunProperties.properties.provisioningState['x-ms-enum__deleted']` | deleted | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ReserveCloudServicePublicIpAddressRequest.properties.isRollback['x-ms-enum__deleted']` | deleted | `{"name":"IsRollback","modelAsString":true}` |
| `definitions.RoutePropertiesFormat.properties.nextHopType['x-ms-enum__deleted']` | deleted | `{"name":"RouteNextHopType","modelAsString":true}` |
| `definitions.SecurityPartnerProviderPropertiesFormat.properties.connectionStatus['x-ms-enum__deleted']` | deleted | `{"name":"SecurityPartnerProviderConnectionStatus","modelAsString":true}` |
| `definitions.SecurityPartnerProviderPropertiesFormat.properties.securityProviderName['x-ms-enum__deleted']` | deleted | `{"name":"SecurityProviderName","modelAsString":true}` |
| `definitions.SecurityRulePropertiesFormat.properties.access['x-ms-enum__deleted']` | deleted | `{"name":"SecurityRuleAccess","modelAsString":true}` |
| `definitions.SecurityRulePropertiesFormat.properties.direction['x-ms-enum__deleted']` | deleted | `{"name":"SecurityRuleDirection","modelAsString":true}` |
| `definitions.SecurityRulePropertiesFormat.properties.protocol['x-ms-enum__deleted']` | deleted | `{"name":"SecurityRuleProtocol","modelAsString":true}` |
| `definitions.StaticCidrProperties.properties.provisioningState['x-ms-enum__deleted']` | deleted | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.SubnetPropertiesFormat.properties.sharingScope['x-ms-enum__deleted']` | deleted | `{"name":"SharingScope","modelAsString":true}` |
| `definitions.SwapResourceProperties.properties.slotType['x-ms-enum__deleted']` | deleted | `{"name":"SlotType","modelAsString":false}` |
| `definitions.TrafficDetectionRule.properties.trafficType['x-ms-enum__deleted']` | deleted | `{"name":"DdosTrafficType","modelAsString":true}` |
| `definitions.Usage.properties.unit['x-ms-enum__deleted']` | deleted | `{"name":"UsageUnit","modelAsString":true}` |
| `definitions.VerifierWorkspaceProperties.properties.provisioningState['x-ms-enum__deleted']` | deleted | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.VirtualApplianceNetworkInterfaceConfiguration.properties.type['x-ms-enum__deleted']` | deleted | `{"name":"NicTypeInRequest","modelAsString":true}` |
| `definitions.VirtualApplianceNicProperties.properties.nicType['x-ms-enum__deleted']` | deleted | `{"name":"NicTypeInResponse","modelAsString":true}` |
| `definitions.VirtualNetworkEncryption.properties.enforcement['x-ms-enum__deleted']` | deleted | `{"name":"VirtualNetworkEncryptionEnforcement","modelAsString":true}` |
| `definitions.VirtualNetworkPeeringPropertiesFormat.properties.peeringState['x-ms-enum__deleted']` | deleted | `{"name":"VirtualNetworkPeeringState","modelAsString":true}` |
| `definitions.VirtualNetworkPeeringPropertiesFormat.properties.peeringSyncLevel['x-ms-enum__deleted']` | deleted | `{"name":"VirtualNetworkPeeringLevel","modelAsString":true}` |
| `definitions.VirtualNetworkPropertiesFormat.properties.privateEndpointVNetPolicies['x-ms-enum__deleted']` | deleted | `{"name":"PrivateEndpointVNetPolicies","modelAsString":true}` |

### Changes for `properties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BastionHostPropertiesFormat.properties.networkAcls.properties__deleted` | deleted | `{"ipRules":{"type":"array","description":"Sets the IP ACL rules for Developer Bastion Host.","items"...` |
| `definitions.Container.properties__deleted` | deleted | `{}` |
| `definitions.IpamPoolPrefixAllocation.properties.pool.properties__deleted` | deleted | `{"id":{"type":"string","format":"arm-id","description":"Resource id of the associated Azure IpamPool...` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.networkProfile.properties__deleted` | deleted | `{"networkInterfaceConfigurations":{"type":"array","items":{"$ref":"#/definitions/VirtualApplianceNet...` |

### Changes for `readOnly`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BreakOutCategoryPolicies.properties.allow.readOnly__deleted` | deleted | `false` |
| `definitions.BreakOutCategoryPolicies.properties.default.readOnly__deleted` | deleted | `false` |
| `definitions.BreakOutCategoryPolicies.properties.optimize.readOnly__deleted` | deleted | `false` |
| `definitions.DdosSettings.properties.ddosProtectionPlan.readOnly__deleted` | deleted | `false` |
| `definitions.DdosSettings.properties.protectionMode.readOnly__deleted` | deleted | `false` |
| `definitions.InboundSecurityRuleProperties.properties.rules.readOnly__deleted` | deleted | `false` |
| `definitions.InboundSecurityRules.properties.appliesOn.readOnly__deleted` | deleted | `false` |
| `definitions.InboundSecurityRules.properties.destinationPortRanges.readOnly__deleted` | deleted | `false` |
| `definitions.InternetIngressPublicIpsProperties.properties.id.readOnly__deleted` | deleted | `false` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.additionalNics.readOnly__deleted` | deleted | `false` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.bootStrapConfigurationBlobs.readOnly__deleted` | deleted | `false` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.cloudInitConfiguration.readOnly__deleted` | deleted | `false` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.cloudInitConfigurationBlobs.readOnly__deleted` | deleted | `false` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.internetIngressPublicIps.readOnly__deleted` | deleted | `false` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.networkProfile.readOnly__deleted` | deleted | `false` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.nvaSku.readOnly__deleted` | deleted | `false` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.sshPublicKey.readOnly__deleted` | deleted | `false` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.virtualApplianceAsn.readOnly__deleted` | deleted | `false` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.virtualHub.readOnly__deleted` | deleted | `false` |
| `definitions.NvaInterfaceConfigurationsProperties.properties.subnet.readOnly__deleted` | deleted | `false` |
| `definitions.NvaInVnetSubnetReferenceProperties.properties.id.readOnly__deleted` | deleted | `false` |
| `definitions.Office365PolicyProperties.properties.breakOutCategories.readOnly__deleted` | deleted | `false` |
| `definitions.PrivateLinkServiceProperties.properties.destinationIPAddress.readOnly__deleted` | deleted | `false` |
| `definitions.VirtualApplianceAdditionalNicProperties.properties.hasPublicIp.readOnly__deleted` | deleted | `false` |
| `definitions.VirtualApplianceAdditionalNicProperties.properties.name.readOnly__deleted` | deleted | `false` |
| `definitions.VirtualApplianceIPConfiguration.readOnly__deleted` | deleted | `false` |
| `definitions.VirtualApplianceIPConfigurationProperties.readOnly__deleted` | deleted | `false` |
| `definitions.VirtualApplianceNetworkInterfaceConfiguration.readOnly__deleted` | deleted | `false` |
| `definitions.VirtualApplianceNetworkInterfaceConfigurationProperties.readOnly__deleted` | deleted | `false` |
| `definitions.VirtualApplianceSiteProperties.properties.addressPrefix.readOnly__deleted` | deleted | `false` |
| `definitions.VirtualApplianceSiteProperties.properties.o365Policy.readOnly__deleted` | deleted | `false` |
| `definitions.VirtualApplianceSkuProperties.properties.bundledScaleUnit.readOnly__deleted` | deleted | `false` |
| `definitions.VirtualApplianceSkuProperties.properties.marketPlaceVersion.readOnly__deleted` | deleted | `false` |
| `definitions.VirtualApplianceSkuProperties.properties.vendor.readOnly__deleted` | deleted | `false` |
| `definitions.VirtualNetworkPropertiesFormat.properties.privateEndpointVNetPolicies.readOnly__deleted` | deleted | `false` |

### Changes for `allOf`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DdosProtectionPlan.allOf__added` | added | `[{"$ref":"./common.json#/definitions/ResourceWithReadOnlyID"}]` |
| `definitions.PrivateLinkServiceProperties.properties.autoApproval.allOf__deleted` | deleted | `[{"$ref":"#/definitions/ResourceSet"}]` |
| `definitions.PrivateLinkServiceProperties.properties.visibility.allOf__deleted` | deleted | `[{"$ref":"#/definitions/ResourceSet"}]` |
| `definitions.SwapResource.allOf__added` | added | `[{"$ref":"./common.json#/definitions/ProxyResourceWithReadOnlyID"}]` |

### Changes for `id`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DdosProtectionPlan.properties.id__deleted` | deleted | `{"type":"string","readOnly":true}` |
| `definitions.SwapResource.properties.id__deleted` | deleted | `{"type":"string","readOnly":true}` |

### Changes for `location`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DdosProtectionPlan.properties.location__deleted` | deleted | `{"type":"string"}` |

### Changes for `default`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.IpAllocationPropertiesFormat.properties.prefixType.default__deleted` | deleted | `null` |
| `definitions.SubnetPropertiesFormat.properties.sharingScope.default__deleted` | deleted | `null` |
| `definitions.VirtualNetworkPeeringPropertiesFormat.properties.remoteBgpCommunities.default__deleted` | deleted | `null` |
| `definitions.VirtualNetworkPeeringPropertiesFormat.properties.remoteVirtualNetworkEncryption.default__deleted` | deleted | `null` |
| `definitions.VirtualNetworkPropertiesFormat.properties.bgpCommunities.default__deleted` | deleted | `null` |
| `definitions.VirtualNetworkPropertiesFormat.properties.ddosProtectionPlan.default__deleted` | deleted | `null` |
| `definitions.VirtualNetworkPropertiesFormat.properties.encryption.default__deleted` | deleted | `null` |

### Changes for `maxItems`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.nvaInterfaceConfigurations.maxItems__added` | added | `3` |

### Changes for `items`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.nvaInterfaceConfigurations.items__added` | added | `{"$ref":"#/definitions/NvaInterfaceConfigurationsProperties"}` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.ApplicationSecurityGroup.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json#/definitions/Resource` |
| `definitions.ApplicationSecurityGroupPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.BastionHost.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json#/definitions/Resource` |
| `definitions.BastionHostIPConfiguration.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.BastionHostIPConfigurationPropertiesFormat.properties.privateIPAllocationMethod.$ref` | `./network.json#/definitions/IPAllocationMethod` | `./common.json#/definitions/IPAllocationMethod` |
| `definitions.BastionHostIPConfigurationPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.BastionHostIPConfigurationPropertiesFormat.properties.publicIPAddress.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.BastionHostIPConfigurationPropertiesFormat.properties.subnet.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.BastionHostPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.BastionHostPropertiesFormat.properties.virtualNetwork.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.Container.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ContainerNetworkInterface.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ContainerNetworkInterfaceConfiguration.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ContainerNetworkInterfaceConfigurationPropertiesFormat.properties.containerNetworkInterfaces.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ContainerNetworkInterfaceConfigurationPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.ContainerNetworkInterfaceIpConfigurationPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.ContainerNetworkInterfacePropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.CustomIpPrefix.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json#/definitions/Resource` |
| `definitions.CustomIpPrefix.properties.extendedLocation.$ref` | `./network.json#/definitions/ExtendedLocation` | `./common.json#/definitions/ExtendedLocation` |
| `definitions.CustomIpPrefixPropertiesFormat.properties.childCustomIpPrefixes.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.CustomIpPrefixPropertiesFormat.properties.customIpPrefixParent.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.CustomIpPrefixPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.CustomIpPrefixPropertiesFormat.properties.publicIpPrefixes.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.DdosCustomPolicy.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json#/definitions/Resource` |
| `definitions.DdosCustomPolicyPropertiesFormat.properties.frontEndIpConfiguration.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.DdosCustomPolicyPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.DdosDetectionRule.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.DdosDetectionRulePropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.DdosProtectionPlanPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.DdosProtectionPlanPropertiesFormat.properties.publicIPAddresses.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.DdosProtectionPlanPropertiesFormat.properties.virtualNetworks.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.DdosSettings.properties.ddosProtectionPlan.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.Delegation.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.DelegationProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.DscpConfiguration.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json#/definitions/Resource` |
| `definitions.DscpConfigurationPropertiesFormat.properties.associatedNetworkInterfaces.items.$ref` | `./networkInterface.json#/definitions/NetworkInterface` | `#/definitions/NetworkInterface` |
| `definitions.DscpConfigurationPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.EffectiveNetworkSecurityGroup.properties.networkSecurityGroup.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.EffectiveNetworkSecurityGroup.properties.tagMap.type` | `string` | `object` |
| `definitions.EffectiveNetworkSecurityGroupAssociation.properties.networkInterface.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.EffectiveNetworkSecurityGroupAssociation.properties.networkManager.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.EffectiveNetworkSecurityGroupAssociation.properties.subnet.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.EffectiveNetworkSecurityRule.properties.access.$ref` | `./networkSecurityGroup.json#/definitions/SecurityRuleAccess` | `./common.json#/definitions/SecurityRuleAccess` |
| `definitions.EffectiveNetworkSecurityRule.properties.direction.$ref` | `./networkSecurityGroup.json#/definitions/SecurityRuleDirection` | `./common.json#/definitions/SecurityRuleDirection` |
| `definitions.EffectiveRoute.properties.nextHopType.$ref` | `./routeTable.json#/definitions/RouteNextHopType` | `./common.json#/definitions/RouteNextHopType` |
| `definitions.EndpointServiceResult.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.InboundSecurityRule.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResourceModel` |
| `definitions.InboundSecurityRuleProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.IpAllocation.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json#/definitions/Resource` |
| `definitions.IpAllocationPropertiesFormat.properties.prefixType.$ref` | `./network.json#/definitions/IPVersion` | `./common.json#/definitions/IPVersion` |
| `definitions.IpAllocationPropertiesFormat.properties.subnet.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.IpAllocationPropertiesFormat.properties.virtualNetwork.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.IpamPool.allOf[0].$ref` | `./network.json#/definitions/CommonTrackedResource` | `./common.json#/definitions/CommonTrackedResource` |
| `definitions.IPConfiguration.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.IPConfigurationProfile.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.IPConfigurationProfilePropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.IPConfigurationProfilePropertiesFormat.properties.subnet.$ref` | `./virtualNetwork.json#/definitions/Subnet` | `#/definitions/Subnet` |
| `definitions.IPConfigurationPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.IPConfigurationPropertiesFormat.properties.publicIPAddress.$ref` | `./publicIpAddress.json#/definitions/PublicIPAddress` | `#/definitions/PublicIPAddress` |
| `definitions.IPConfigurationPropertiesFormat.properties.subnet.$ref` | `./virtualNetwork.json#/definitions/Subnet` | `#/definitions/Subnet` |
| `definitions.IpGroup.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json#/definitions/Resource` |
| `definitions.IpGroupPropertiesFormat.properties.firewallPolicies.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.IpGroupPropertiesFormat.properties.firewalls.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.IpGroupPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.NatGateway.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json#/definitions/Resource` |
| `definitions.NatGatewayPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.NatGatewayPropertiesFormat.properties.publicIpAddresses.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.NatGatewayPropertiesFormat.properties.publicIpAddressesV6.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.NatGatewayPropertiesFormat.properties.publicIpPrefixes.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.NatGatewayPropertiesFormat.properties.publicIpPrefixesV6.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.NatGatewayPropertiesFormat.properties.serviceGateway.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.NatGatewayPropertiesFormat.properties.sourceVirtualNetwork.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.NatGatewayPropertiesFormat.properties.subnets.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.NetworkIntentPolicy.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json#/definitions/Resource` |
| `definitions.NetworkInterface.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json#/definitions/Resource` |
| `definitions.NetworkInterface.properties.extendedLocation.$ref` | `./network.json#/definitions/ExtendedLocation` | `./common.json#/definitions/ExtendedLocation` |
| `definitions.NetworkInterfaceIPConfiguration.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResourceModel` |
| `definitions.NetworkInterfaceIPConfigurationPropertiesFormat.properties.applicationSecurityGroups.items.$ref` | `./applicationSecurityGroup.json#/definitions/ApplicationSecurityGroup` | `#/definitions/ApplicationSecurityGroup` |
| `definitions.NetworkInterfaceIPConfigurationPropertiesFormat.properties.gatewayLoadBalancer.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.NetworkInterfaceIPConfigurationPropertiesFormat.properties.privateIPAddressVersion.$ref` | `./network.json#/definitions/IPVersion` | `./common.json#/definitions/IPVersion` |
| `definitions.NetworkInterfaceIPConfigurationPropertiesFormat.properties.privateIPAllocationMethod.$ref` | `./network.json#/definitions/IPAllocationMethod` | `./common.json#/definitions/IPAllocationMethod` |
| `definitions.NetworkInterfaceIPConfigurationPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.NetworkInterfaceIPConfigurationPropertiesFormat.properties.publicIPAddress.$ref` | `./publicIpAddress.json#/definitions/PublicIPAddress` | `#/definitions/PublicIPAddress` |
| `definitions.NetworkInterfaceIPConfigurationPropertiesFormat.properties.subnet.$ref` | `./virtualNetwork.json#/definitions/Subnet` | `#/definitions/Subnet` |
| `definitions.NetworkInterfaceIPConfigurationPropertiesFormat.properties.virtualNetworkTaps.items.$ref` | `./virtualNetworkTap.json#/definitions/VirtualNetworkTap` | `./networkGateway.json#/definitions/VirtualNetworkTap` |
| `definitions.NetworkInterfacePropertiesFormat.properties.dscpConfiguration.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.NetworkInterfacePropertiesFormat.properties.networkSecurityGroup.$ref` | `./networkSecurityGroup.json#/definitions/NetworkSecurityGroup` | `#/definitions/NetworkSecurityGroup` |
| `definitions.NetworkInterfacePropertiesFormat.properties.privateEndpoint.$ref` | `./privateEndpoint.json#/definitions/PrivateEndpoint` | `#/definitions/PrivateEndpoint` |
| `definitions.NetworkInterfacePropertiesFormat.properties.privateLinkService.$ref` | `./privateLinkService.json#/definitions/PrivateLinkService` | `#/definitions/PrivateLinkService` |
| `definitions.NetworkInterfacePropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.NetworkInterfacePropertiesFormat.properties.virtualMachine.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.NetworkInterfaceTapConfiguration.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResourceModel` |
| `definitions.NetworkInterfaceTapConfigurationPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.NetworkInterfaceTapConfigurationPropertiesFormat.properties.virtualNetworkTap.$ref` | `./virtualNetworkTap.json#/definitions/VirtualNetworkTap` | `./networkGateway.json#/definitions/VirtualNetworkTap` |
| `definitions.NetworkProfile.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json#/definitions/Resource` |
| `definitions.NetworkProfilePropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.NetworkSecurityGroup.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json#/definitions/Resource` |
| `definitions.NetworkSecurityGroupPropertiesFormat.properties.networkInterfaces.items.$ref` | `./networkInterface.json#/definitions/NetworkInterface` | `#/definitions/NetworkInterface` |
| `definitions.NetworkSecurityGroupPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.NetworkSecurityGroupPropertiesFormat.properties.subnets.items.$ref` | `./virtualNetwork.json#/definitions/Subnet` | `#/definitions/Subnet` |
| `definitions.NetworkVirtualAppliance.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json#/definitions/Resource` |
| `definitions.NetworkVirtualAppliance.properties.identity.$ref` | `./network.json#/definitions/ManagedServiceIdentity` | `./common.json#/definitions/ManagedServiceIdentity` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.inboundSecurityRules.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.virtualApplianceConnections.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.virtualApplianceSites.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.NetworkVirtualAppliancePropertiesFormat.properties.virtualHub.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.NetworkVirtualApplianceSku.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json#/definitions/Resource` |
| `definitions.PrivateDnsZoneGroup.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.PrivateDnsZoneGroupPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.PrivateEndpoint.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json#/definitions/Resource` |
| `definitions.PrivateEndpoint.properties.extendedLocation.$ref` | `./network.json#/definitions/ExtendedLocation` | `./common.json#/definitions/ExtendedLocation` |
| `definitions.PrivateEndpointConnection.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResourceModel` |
| `definitions.PrivateEndpointConnectionProperties.properties.privateEndpoint.$ref` | `./privateEndpoint.json#/definitions/PrivateEndpoint` | `#/definitions/PrivateEndpoint` |
| `definitions.PrivateEndpointConnectionProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.PrivateEndpointProperties.properties.applicationSecurityGroups.items.$ref` | `./applicationSecurityGroup.json#/definitions/ApplicationSecurityGroup` | `#/definitions/ApplicationSecurityGroup` |
| `definitions.PrivateEndpointProperties.properties.networkInterfaces.items.$ref` | `./networkInterface.json#/definitions/NetworkInterface` | `#/definitions/NetworkInterface` |
| `definitions.PrivateEndpointProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.PrivateEndpointProperties.properties.subnet.$ref` | `./virtualNetwork.json#/definitions/Subnet` | `#/definitions/Subnet` |
| `definitions.PrivateLinkService.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json#/definitions/Resource` |
| `definitions.PrivateLinkService.properties.extendedLocation.$ref` | `./network.json#/definitions/ExtendedLocation` | `./common.json#/definitions/ExtendedLocation` |
| `definitions.PrivateLinkServiceConnection.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.PrivateLinkServiceConnectionProperties.properties.privateLinkServiceConnectionState.$ref` | `./privateLinkService.json#/definitions/PrivateLinkServiceConnectionState` | `#/definitions/PrivateLinkServiceConnectionState` |
| `definitions.PrivateLinkServiceConnectionProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.PrivateLinkServiceIpConfiguration.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.PrivateLinkServiceIpConfigurationProperties.properties.privateIPAddressVersion.$ref` | `./network.json#/definitions/IPVersion` | `./common.json#/definitions/IPVersion` |
| `definitions.PrivateLinkServiceIpConfigurationProperties.properties.privateIPAllocationMethod.$ref` | `./network.json#/definitions/IPAllocationMethod` | `./common.json#/definitions/IPAllocationMethod` |
| `definitions.PrivateLinkServiceIpConfigurationProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.PrivateLinkServiceIpConfigurationProperties.properties.subnet.$ref` | `./virtualNetwork.json#/definitions/Subnet` | `#/definitions/Subnet` |
| `definitions.PrivateLinkServiceProperties.properties.networkInterfaces.items.$ref` | `./networkInterface.json#/definitions/NetworkInterface` | `#/definitions/NetworkInterface` |
| `definitions.PrivateLinkServiceProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.PublicIPAddress.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json#/definitions/Resource` |
| `definitions.PublicIPAddress.properties.extendedLocation.$ref` | `./network.json#/definitions/ExtendedLocation` | `./common.json#/definitions/ExtendedLocation` |
| `definitions.PublicIPAddressPropertiesFormat.properties.ipConfiguration.$ref` | `./networkInterface.json#/definitions/IPConfiguration` | `#/definitions/IPConfiguration` |
| `definitions.PublicIPAddressPropertiesFormat.properties.natGateway.$ref` | `./natGateway.json#/definitions/NatGateway` | `#/definitions/NatGateway` |
| `definitions.PublicIPAddressPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.PublicIPAddressPropertiesFormat.properties.publicIPAddressVersion.$ref` | `./network.json#/definitions/IPVersion` | `./common.json#/definitions/IPVersion` |
| `definitions.PublicIPAddressPropertiesFormat.properties.publicIPAllocationMethod.$ref` | `./network.json#/definitions/IPAllocationMethod` | `./common.json#/definitions/IPAllocationMethod` |
| `definitions.PublicIPAddressPropertiesFormat.properties.publicIPPrefix.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.PublicIPPrefix.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json#/definitions/Resource` |
| `definitions.PublicIPPrefix.properties.extendedLocation.$ref` | `./network.json#/definitions/ExtendedLocation` | `./common.json#/definitions/ExtendedLocation` |
| `definitions.PublicIPPrefixPropertiesFormat.properties.customIPPrefix.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.PublicIPPrefixPropertiesFormat.properties.ipTags.items.$ref` | `./publicIpAddress.json#/definitions/IpTag` | `#/definitions/IpTag` |
| `definitions.PublicIPPrefixPropertiesFormat.properties.loadBalancerFrontendIpConfiguration.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.PublicIPPrefixPropertiesFormat.properties.natGateway.$ref` | `./natGateway.json#/definitions/NatGateway` | `#/definitions/NatGateway` |
| `definitions.PublicIPPrefixPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.PublicIPPrefixPropertiesFormat.properties.publicIPAddressVersion.$ref` | `./network.json#/definitions/IPVersion` | `./common.json#/definitions/IPVersion` |
| `definitions.ReachabilityAnalysisIntent.allOf[0].$ref` | `./network.json#/definitions/CommonProxyResource` | `./common.json#/definitions/CommonProxyResource` |
| `definitions.ReachabilityAnalysisIntent.properties.systemData.$ref` | `./network.json#/definitions/SystemData` | `../../../../../../common-types/resource-management/v5/types.json#/definitions/systemData` |
| `definitions.ReachabilityAnalysisRun.allOf[0].$ref` | `./network.json#/definitions/CommonProxyResource` | `./common.json#/definitions/CommonProxyResource` |
| `definitions.ReachabilityAnalysisRun.properties.systemData.$ref` | `./network.json#/definitions/SystemData` | `../../../../../../common-types/resource-management/v5/types.json#/definitions/systemData` |
| `definitions.RecordSet.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.ResourceNavigationLink.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ResourceNavigationLinkFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.Route.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResourceModel` |
| `definitions.RoutePropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.RouteTable.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json#/definitions/Resource` |
| `definitions.RouteTablePropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.RouteTablePropertiesFormat.properties.subnets.items.$ref` | `./virtualNetwork.json#/definitions/Subnet` | `#/definitions/Subnet` |
| `definitions.SecurityPartnerProvider.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json#/definitions/Resource` |
| `definitions.SecurityPartnerProviderPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.SecurityPartnerProviderPropertiesFormat.properties.virtualHub.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.SecurityRule.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResourceModel` |
| `definitions.SecurityRulePropertiesFormat.properties.destinationApplicationSecurityGroups.items.$ref` | `./applicationSecurityGroup.json#/definitions/ApplicationSecurityGroup` | `#/definitions/ApplicationSecurityGroup` |
| `definitions.SecurityRulePropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.SecurityRulePropertiesFormat.properties.sourceApplicationSecurityGroups.items.$ref` | `./applicationSecurityGroup.json#/definitions/ApplicationSecurityGroup` | `#/definitions/ApplicationSecurityGroup` |
| `definitions.ServiceAssociationLink.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ServiceAssociationLinkPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.ServiceDelegationPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.ServiceEndpointPropertiesFormat.properties.networkIdentifier.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.ServiceEndpointPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.StaticCidr.allOf[0].$ref` | `./network.json#/definitions/CommonProxyResource` | `./common.json#/definitions/CommonProxyResource` |
| `definitions.Subnet.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResourceModel` |
| `definitions.SubnetPropertiesFormat.properties.ipAllocations.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.SubnetPropertiesFormat.properties.ipConfigurationProfiles.items.$ref` | `./networkProfile.json#/definitions/IPConfigurationProfile` | `#/definitions/IPConfigurationProfile` |
| `definitions.SubnetPropertiesFormat.properties.ipConfigurations.items.$ref` | `./networkInterface.json#/definitions/IPConfiguration` | `#/definitions/IPConfiguration` |
| `definitions.SubnetPropertiesFormat.properties.natGateway.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.SubnetPropertiesFormat.properties.networkSecurityGroup.$ref` | `./networkSecurityGroup.json#/definitions/NetworkSecurityGroup` | `#/definitions/NetworkSecurityGroup` |
| `definitions.SubnetPropertiesFormat.properties.privateEndpoints.items.$ref` | `./privateEndpoint.json#/definitions/PrivateEndpoint` | `#/definitions/PrivateEndpoint` |
| `definitions.SubnetPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.SubnetPropertiesFormat.properties.routeTable.$ref` | `./routeTable.json#/definitions/RouteTable` | `#/definitions/RouteTable` |
| `definitions.SubnetPropertiesFormat.properties.serviceEndpointPolicies.items.$ref` | `./serviceEndpointPolicy.json#/definitions/ServiceEndpointPolicy` | `./expressRoute.json#/definitions/ServiceEndpointPolicy` |
| `definitions.SubnetPropertiesFormat.properties.serviceGateway.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.VerifierWorkspace.allOf[0].$ref` | `./network.json#/definitions/CommonTrackedResource` | `./common.json#/definitions/CommonTrackedResource` |
| `definitions.VerifierWorkspace.properties.systemData.$ref` | `./network.json#/definitions/SystemData` | `../../../../../../common-types/resource-management/v5/types.json#/definitions/systemData` |
| `definitions.VirtualApplianceSite.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResourceModel` |
| `definitions.VirtualApplianceSiteProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.VirtualNetwork.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json#/definitions/Resource` |
| `definitions.VirtualNetwork.properties.extendedLocation.$ref` | `./network.json#/definitions/ExtendedLocation` | `./common.json#/definitions/ExtendedLocation` |
| `definitions.VirtualNetworkDdosProtectionStatusResult.properties.value.items.$ref` | `./publicIpAddress.json#/definitions/PublicIpDdosProtectionStatusResult` | `#/definitions/PublicIpDdosProtectionStatusResult` |
| `definitions.VirtualNetworkPeering.allOf[0].$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResourceModel` |
| `definitions.VirtualNetworkPeeringPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.VirtualNetworkPeeringPropertiesFormat.properties.remoteVirtualNetwork.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.VirtualNetworkPropertiesFormat.properties.ddosProtectionPlan.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.VirtualNetworkPropertiesFormat.properties.defaultPublicNatGateway.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.VirtualNetworkPropertiesFormat.properties.ipAllocations.items.$ref` | `./network.json#/definitions/SubResource` | `./common.json#/definitions/SubResource` |
| `definitions.VirtualNetworkPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json#/definitions/NetworkProvisioningState` |
| `definitions.VM.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json#/definitions/Resource` |
| `info.description` | `The Microsoft Azure Network management API provides a RESTful set of web services that interact with Microsoft Azure Networks service to manage your network resources. The API has entities that capture the relationship between an end user and the Microsoft Azure Networks service.` | `APIs to manage web application firewall rules.` |
| `info.title` | `NetworkManagementClient` | `WebApplicationFirewallManagement` |
| `info.version` | `2018-10-01` | `2025-05-01` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/applicationSecurityGroups'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/bastionHosts'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/customIpPrefixes'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/ddosProtectionPlans'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/dscpConfigurations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/ipAllocations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/ipGroups'].get.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `./common.json#/definitions/Error` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/autoApprovedPrivateLinkServices'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/availableDelegations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/availablePrivateEndpointTypes'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/availableServiceAliases'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/checkDnsNameAvailability'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/checkPrivateLinkServiceVisibility'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/serviceTagDetails'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/serviceTags'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/usages'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/locations/{location}/virtualNetworkAvailableEndpointServices'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/natGateways'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkInterfaces'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkProfiles'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkSecurityGroups'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkVirtualAppliances'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkVirtualApplianceSkus'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkVirtualApplianceSkus/{skuName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/privateEndpoints'].get.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `./common.json#/definitions/Error` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/privateLinkServices'].get.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `./common.json#/definitions/Error` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/publicIPAddresses'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/publicIPPrefixes'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/routeTables'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/securityPartnerProviders'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/virtualNetworks'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/microsoft.Compute/cloudServices/{resourceName}/providers/microsoft.Network/cloudServiceSlots'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/microsoft.Compute/cloudServices/{resourceName}/providers/microsoft.Network/cloudServiceSlots/{singletonResource}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/microsoft.Compute/cloudServices/{resourceName}/providers/microsoft.Network/cloudServiceSlots/{singletonResource}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/cloudServices/{cloudServiceName}/networkInterfaces'].get.responses.200.schema.$ref` | `./networkInterface.json#/definitions/NetworkInterfaceListResult` | `#/definitions/NetworkInterfaceListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/cloudServices/{cloudServiceName}/networkInterfaces'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/cloudServices/{cloudServiceName}/publicipaddresses'].get.responses.200.schema.$ref` | `./publicIpAddress.json#/definitions/PublicIPAddressListResult` | `#/definitions/PublicIPAddressListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/cloudServices/{cloudServiceName}/publicipaddresses'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/cloudServices/{cloudServiceName}/roleInstances/{roleInstanceName}/networkInterfaces'].get.responses.200.schema.$ref` | `./networkInterface.json#/definitions/NetworkInterfaceListResult` | `#/definitions/NetworkInterfaceListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/cloudServices/{cloudServiceName}/roleInstances/{roleInstanceName}/networkInterfaces'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/cloudServices/{cloudServiceName}/roleInstances/{roleInstanceName}/networkInterfaces/{networkInterfaceName}'].get.responses.200.schema.$ref` | `./networkInterface.json#/definitions/NetworkInterface` | `#/definitions/NetworkInterface` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/cloudServices/{cloudServiceName}/roleInstances/{roleInstanceName}/networkInterfaces/{networkInterfaceName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/cloudServices/{cloudServiceName}/roleInstances/{roleInstanceName}/networkInterfaces/{networkInterfaceName}/ipconfigurations/{ipConfigurationName}/publicipaddresses'].get.responses.200.schema.$ref` | `./publicIpAddress.json#/definitions/PublicIPAddressListResult` | `#/definitions/PublicIPAddressListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/cloudServices/{cloudServiceName}/roleInstances/{roleInstanceName}/networkInterfaces/{networkInterfaceName}/ipconfigurations/{ipConfigurationName}/publicipaddresses'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/cloudServices/{cloudServiceName}/roleInstances/{roleInstanceName}/networkInterfaces/{networkInterfaceName}/ipconfigurations/{ipConfigurationName}/publicipaddresses/{publicIpAddressName}'].get.responses.200.schema.$ref` | `./publicIpAddress.json#/definitions/PublicIPAddress` | `#/definitions/PublicIPAddress` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/cloudServices/{cloudServiceName}/roleInstances/{roleInstanceName}/networkInterfaces/{networkInterfaceName}/ipconfigurations/{ipConfigurationName}/publicipaddresses/{publicIpAddressName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationSecurityGroups'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationSecurityGroups/{applicationSecurityGroupName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationSecurityGroups/{applicationSecurityGroupName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationSecurityGroups/{applicationSecurityGroupName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationSecurityGroups/{applicationSecurityGroupName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/applicationSecurityGroups/{applicationSecurityGroupName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts/{bastionHostName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts/{bastionHostName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts/{bastionHostName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts/{bastionHostName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts/{bastionHostName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts/{bastionHostName}/createShareableLinks'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts/{bastionHostName}/deleteShareableLinks'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts/{bastionHostName}/deleteShareableLinksByToken'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts/{bastionHostName}/disconnectActiveSessions'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts/{bastionHostName}/getActiveSessions'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/bastionHosts/{bastionHostName}/getShareableLinks'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/customIpPrefixes'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/customIpPrefixes/{customIpPrefixName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/customIpPrefixes/{customIpPrefixName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/customIpPrefixes/{customIpPrefixName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/customIpPrefixes/{customIpPrefixName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/customIpPrefixes/{customIpPrefixName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ddosCustomPolicies/{ddosCustomPolicyName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ddosCustomPolicies/{ddosCustomPolicyName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ddosCustomPolicies/{ddosCustomPolicyName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ddosCustomPolicies/{ddosCustomPolicyName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ddosCustomPolicies/{ddosCustomPolicyName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ddosCustomPolicies/{ddosCustomPolicyName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ddosProtectionPlans'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ddosProtectionPlans/{ddosProtectionPlanName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ddosProtectionPlans/{ddosProtectionPlanName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ddosProtectionPlans/{ddosProtectionPlanName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ddosProtectionPlans/{ddosProtectionPlanName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ddosProtectionPlans/{ddosProtectionPlanName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ddosProtectionPlans/{ddosProtectionPlanName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/dscpConfigurations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/dscpConfigurations/{dscpConfigurationName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/dscpConfigurations/{dscpConfigurationName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/dscpConfigurations/{dscpConfigurationName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ipAllocations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ipAllocations/{ipAllocationName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ipAllocations/{ipAllocationName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ipAllocations/{ipAllocationName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ipAllocations/{ipAllocationName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ipAllocations/{ipAllocationName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ipAllocations/{ipAllocationName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ipGroups'].get.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `./common.json#/definitions/Error` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ipGroups/{ipGroupsName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `./common.json#/definitions/Error` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ipGroups/{ipGroupsName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `./common.json#/definitions/Error` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ipGroups/{ipGroupsName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ipGroups/{ipGroupsName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `./common.json#/definitions/Error` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/ipGroups/{ipGroupsName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `./common.json#/definitions/Error` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/autoApprovedPrivateLinkServices'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/availableDelegations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/availablePrivateEndpointTypes'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/availableServiceAliases'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/locations/{location}/checkPrivateLinkServiceVisibility'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/natGateways'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/natGateways/{natGatewayName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/natGateways/{natGatewayName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/natGateways/{natGatewayName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/natGateways/{natGatewayName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/natGateways/{natGatewayName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}/effectiveNetworkSecurityGroups'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}/effectiveRouteTable'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}/ipConfigurations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}/ipConfigurations/{ipConfigurationName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}/loadBalancers'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}/tapConfigurations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}/tapConfigurations/{tapConfigurationName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}/tapConfigurations/{tapConfigurationName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkInterfaces/{networkInterfaceName}/tapConfigurations/{tapConfigurationName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools'].get.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `./common.json#/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `./common.json#/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `./common.json#/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `./common.json#/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `./common.json#/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}/getPoolUsage'].post.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `./common.json#/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}/listAssociatedResources'].post.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `./common.json#/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}/staticCidrs'].get.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `./common.json#/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}/staticCidrs/{staticCidrName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `./common.json#/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}/staticCidrs/{staticCidrName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `./common.json#/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/ipamPools/{poolName}/staticCidrs/{staticCidrName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `./common.json#/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces'].get.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `./common.json#/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `./common.json#/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `./common.json#/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `./common.json#/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `./common.json#/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}/reachabilityAnalysisIntents'].get.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `./common.json#/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}/reachabilityAnalysisIntents/{reachabilityAnalysisIntentName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `./common.json#/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}/reachabilityAnalysisIntents/{reachabilityAnalysisIntentName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `./common.json#/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}/reachabilityAnalysisIntents/{reachabilityAnalysisIntentName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `./common.json#/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}/reachabilityAnalysisRuns'].get.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `./common.json#/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}/reachabilityAnalysisRuns/{reachabilityAnalysisRunName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}/reachabilityAnalysisRuns/{reachabilityAnalysisRunName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `./common.json#/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}/reachabilityAnalysisRuns/{reachabilityAnalysisRunName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `./common.json#/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/verifierWorkspaces/{workspaceName}/reachabilityAnalysisRuns/{reachabilityAnalysisRunName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `./common.json#/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkProfiles'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkProfiles/{networkProfileName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkProfiles/{networkProfileName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkProfiles/{networkProfileName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkProfiles/{networkProfileName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkProfiles/{networkProfileName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityGroups'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}/defaultSecurityRules'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}/defaultSecurityRules/{defaultSecurityRuleName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}/securityRules'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}/securityRules/{securityRuleName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}/securityRules/{securityRuleName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}/securityRules/{securityRuleName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}'].put.responses.201.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/getBootDiagnosticLogs'].post.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/getBootDiagnosticLogs'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/inboundSecurityRules/{ruleCollectionName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/inboundSecurityRules/{ruleCollectionName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/reimage'].post.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/reimage'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/restart'].post.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/restart'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/virtualApplianceSites'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/virtualApplianceSites/{siteName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/virtualApplianceSites/{siteName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/virtualApplianceSites/{siteName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateEndpoints'].get.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `./common.json#/definitions/Error` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateEndpoints/{privateEndpointName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `./common.json#/definitions/Error` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateEndpoints/{privateEndpointName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `./common.json#/definitions/Error` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateEndpoints/{privateEndpointName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `./common.json#/definitions/Error` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateEndpoints/{privateEndpointName}/privateDnsZoneGroups'].get.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateEndpoints/{privateEndpointName}/privateDnsZoneGroups/{privateDnsZoneGroupName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateEndpoints/{privateEndpointName}/privateDnsZoneGroups/{privateDnsZoneGroupName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateEndpoints/{privateEndpointName}/privateDnsZoneGroups/{privateDnsZoneGroupName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateLinkServices'].get.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `./common.json#/definitions/Error` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateLinkServices/{serviceName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `./common.json#/definitions/Error` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateLinkServices/{serviceName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `./common.json#/definitions/Error` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateLinkServices/{serviceName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `./common.json#/definitions/Error` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateLinkServices/{serviceName}/privateEndpointConnections'].get.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `./common.json#/definitions/Error` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateLinkServices/{serviceName}/privateEndpointConnections/{peConnectionName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `./common.json#/definitions/Error` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateLinkServices/{serviceName}/privateEndpointConnections/{peConnectionName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `./common.json#/definitions/Error` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/privateLinkServices/{serviceName}/privateEndpointConnections/{peConnectionName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/Error` | `./common.json#/definitions/Error` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}/ddosProtectionStatus'].post.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}/ddosProtectionStatus'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}/disassociateCloudServiceReservedPublicIp'].post.responses.202.headers.Location.description` | `URL for determining when an operation has completed. Send a GET request to the URL in Location header.
The URI should return a 202 until the operation reaches a terminal state and 200 once it reaches a terminal state.

For more info: https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/Addendum.md#202-accepted-and-location-headers` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}/disassociateCloudServiceReservedPublicIp'].post.responses.202.headers['Azure-AsyncOperation'].description` | `URL for checking the ongoing status of the operation.
To get the status of the asynchronous operation, send a GET request to the URL in Azure-AsyncOperation header value.

For more info: https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/Addendum.md#asynchronous-operations` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}/disassociateCloudServiceReservedPublicIp'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}/reserveCloudServicePublicIpAddress'].post.responses.202.headers.Location.description` | `URL for determining when an operation has completed. Send a GET request to the URL in Location header.
The URI should return a 202 until the operation reaches a terminal state and 200 once it reaches a terminal state.

For more info: https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/Addendum.md#202-accepted-and-location-headers` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}/reserveCloudServicePublicIpAddress'].post.responses.202.headers['Azure-AsyncOperation'].description` | `URL for checking the ongoing status of the operation.
To get the status of the asynchronous operation, send a GET request to the URL in Azure-AsyncOperation header value.

For more info: https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/Addendum.md#asynchronous-operations` | `A link to the status monitor` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPAddresses/{publicIpAddressName}/reserveCloudServicePublicIpAddress'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPPrefixes'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPPrefixes/{publicIpPrefixName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPPrefixes/{publicIpPrefixName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPPrefixes/{publicIpPrefixName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPPrefixes/{publicIpPrefixName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/publicIPPrefixes/{publicIpPrefixName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeTables'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeTables/{routeTableName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeTables/{routeTableName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeTables/{routeTableName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeTables/{routeTableName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeTables/{routeTableName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeTables/{routeTableName}/routes'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeTables/{routeTableName}/routes/{routeName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeTables/{routeTableName}/routes/{routeName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/routeTables/{routeTableName}/routes/{routeName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/securityPartnerProviders'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/securityPartnerProviders/{securityPartnerProviderName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/securityPartnerProviders/{securityPartnerProviderName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/securityPartnerProviders/{securityPartnerProviderName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/securityPartnerProviders/{securityPartnerProviderName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/securityPartnerProviders/{securityPartnerProviderName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}'].patch.parameters[1].schema.$ref` | `./network.json#/definitions/TagsObject` | `./common.json#/definitions/TagsObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/checkIPAddressAvailability'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/ddosProtectionStatus'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}/prepareNetworkPolicies'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}/resourceNavigationLinks'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}/serviceAssociationLinks'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}/unprepareNetworkPolicies'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/usages'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/virtualNetworkPeerings'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/virtualNetworkPeerings/{virtualNetworkPeeringName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/virtualNetworkPeerings/{virtualNetworkPeeringName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/virtualNetworkPeerings/{virtualNetworkPeeringName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json#/definitions/CloudError` |

