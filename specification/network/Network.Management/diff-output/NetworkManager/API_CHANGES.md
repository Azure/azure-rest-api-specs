## Changed Paths

Path: /providers/microsoft.Management/managementGroups/{managementGroupId}/providers/microsoft.Network/networkManagerConnections
Change Type: deleted

Path: /providers/microsoft.Management/managementGroups/{managementGroupId}/providers/microsoft.Network/networkManagerConnections/{networkManagerConnectionName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/networkGroups/{networkGroupName}/staticMembers
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/networkGroups/{networkGroupName}/staticMembers/{staticMemberName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/routingConfigurations/{configurationName}/ruleCollections
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/routingConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/routingConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/routingConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules/{ruleName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}/ruleCollections
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules/{ruleName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityUserConfigurations/{configurationName}/ruleCollections
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityUserConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityUserConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules
Change Type: deleted

Path: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityUserConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules/{ruleName}
Change Type: deleted

## Swagger Changes

### Changes for `tags`

| Path | Change Type | Value |
|------|------------|-------|
| `tags__added` | added | `[{"name":"NetworkManagers"},{"name":"NetworkManagerConnections"},{"name":"ConnectivityConfigurations...` |

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `info.description__added` | added | `APIs to manage web application firewall rules.` |

### Changes for `/providers/microsoft.Management/managementGroups/{managementGroupId}/providers/microsoft.Network/networkManagerConnections`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/providers/microsoft.Management/managementGroups/{managementGroupId}/providers/microsoft.Network/networkManagerConnections__deleted']` | deleted | `{"get":{"operationId":"ManagementGroupNetworkManagerConnections_List","tags":["NetworkManagerConnect...` |

### Changes for `/providers/microsoft.Management/managementGroups/{managementGroupId}/providers/microsoft.Network/networkManagerConnections/{networkManagerConnectionName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/providers/microsoft.Management/managementGroups/{managementGroupId}/providers/microsoft.Network/networkManagerConnections/{networkManagerConnectionName}__deleted']` | deleted | `{"parameters":[{"$ref":"#/parameters/ManagementGroupIdParameter"},{"$ref":"#/parameters/NetworkManag...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/networkGroups/{networkGroupName}/staticMembers`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/networkGroups/{networkGroupName}/staticMembers__deleted']` | deleted | `{"get":{"operationId":"StaticMembers_List","tags":["StaticMembers"],"parameters":[{"name":"networkMa...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/networkGroups/{networkGroupName}/staticMembers/{staticMemberName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/networkGroups/{networkGroupName}/staticMembers/{staticMemberName}__deleted']` | deleted | `{"parameters":[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/R...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/routingConfigurations/{configurationName}/ruleCollections`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/routingConfigurations/{configurationName}/ruleCollections__deleted']` | deleted | `{"get":{"operationId":"RoutingRuleCollections_List","tags":["RoutingRuleCollections"],"parameters":[...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/routingConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/routingConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}__deleted']` | deleted | `{"parameters":[{"$ref":"../../../../../common-types/resource-management/v5/types.json#/parameters/Ap...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/routingConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/routingConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules__deleted']` | deleted | `{"parameters":[{"$ref":"../../../../../common-types/resource-management/v5/types.json#/parameters/Ap...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/routingConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules/{ruleName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/routingConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules/{ruleName}__deleted']` | deleted | `{"parameters":[{"$ref":"../../../../../common-types/resource-management/v5/types.json#/parameters/Ap...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}/ruleCollections`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}/ruleCollections__deleted']` | deleted | `{"get":{"operationId":"AdminRuleCollections_List","tags":["AdminRuleCollections"],"parameters":[{"$r...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}__deleted']` | deleted | `{"parameters":[{"$ref":"./network.json#/parameters/ApiVersionParameter"},{"$ref":"./network.json#/pa...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules__deleted']` | deleted | `{"parameters":[{"$ref":"./network.json#/parameters/ApiVersionParameter"},{"$ref":"./network.json#/pa...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules/{ruleName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules/{ruleName}__deleted']` | deleted | `{"parameters":[{"$ref":"./network.json#/parameters/ApiVersionParameter"},{"$ref":"./network.json#/pa...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityUserConfigurations/{configurationName}/ruleCollections`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityUserConfigurations/{configurationName}/ruleCollections__deleted']` | deleted | `{"get":{"operationId":"SecurityUserRuleCollections_List","tags":["SecurityUserRuleCollections"],"par...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityUserConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityUserConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}__deleted']` | deleted | `{"parameters":[{"$ref":"../../../../../common-types/resource-management/v5/types.json#/parameters/Ap...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityUserConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityUserConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules__deleted']` | deleted | `{"parameters":[{"$ref":"../../../../../common-types/resource-management/v5/types.json#/parameters/Ap...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityUserConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules/{ruleName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityUserConfigurations/{configurationName}/ruleCollections/{ruleCollectionName}/rules/{ruleName}__deleted']` | deleted | `{"parameters":[{"$ref":"../../../../../common-types/resource-management/v5/types.json#/parameters/Ap...` |

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ActiveBaseSecurityAdminRule.properties.kind.$ref__added` | added | `./common.json/definitions/EffectiveAdminRuleKind` |
| `definitions.AddressPrefixItem.properties.addressPrefixType.$ref__added` | added | `./common.json/definitions/AddressPrefixType` |
| `definitions.AdminPropertiesFormat.properties.access.$ref__added` | added | `./common.json/definitions/SecurityConfigurationRuleAccess` |
| `definitions.AdminPropertiesFormat.properties.direction.$ref__added` | added | `./common.json/definitions/SecurityConfigurationRuleDirection` |
| `definitions.AdminPropertiesFormat.properties.protocol.$ref__added` | added | `./common.json/definitions/SecurityConfigurationRuleProtocol` |
| `definitions.AdminPropertiesFormat.properties.provisioningState.$ref__added` | added | `./common.json/definitions/ProvisioningState` |
| `definitions.AdminRuleCollectionPropertiesFormat.properties.provisioningState.$ref__added` | added | `./common.json/definitions/ProvisioningState` |
| `definitions.ConnectivityConfigurationProperties.properties.connectivityCapabilities.$ref__added` | added | `./common.json/definitions/ConnectivityConfigurationPropertiesConnectivityCapabilities` |
| `definitions.ConnectivityConfigurationProperties.properties.connectivityTopology.$ref__added` | added | `./common.json/definitions/ConnectivityTopology` |
| `definitions.ConnectivityConfigurationProperties.properties.deleteExistingPeering.$ref__added` | added | `./common.json/definitions/DeleteExistingPeering` |
| `definitions.ConnectivityConfigurationProperties.properties.isGlobal.$ref__added` | added | `./common.json/definitions/IsGlobal` |
| `definitions.connectivityGroupItem.properties.groupConnectivity.$ref__added` | added | `./common.json/definitions/GroupConnectivity` |
| `definitions.connectivityGroupItem.properties.isGlobal.$ref__added` | added | `./common.json/definitions/IsGlobal` |
| `definitions.connectivityGroupItem.properties.useHubGateway.$ref__added` | added | `./common.json/definitions/UseHubGateway` |
| `definitions.DefaultAdminPropertiesFormat.properties.access.$ref__added` | added | `./common.json/definitions/SecurityConfigurationRuleAccess` |
| `definitions.DefaultAdminPropertiesFormat.properties.direction.$ref__added` | added | `./common.json/definitions/SecurityConfigurationRuleDirection` |
| `definitions.DefaultAdminPropertiesFormat.properties.protocol.$ref__added` | added | `./common.json/definitions/SecurityConfigurationRuleProtocol` |
| `definitions.DefaultAdminPropertiesFormat.properties.provisioningState.$ref__added` | added | `./common.json/definitions/ProvisioningState` |
| `definitions.EffectiveBaseSecurityAdminRule.properties.kind.$ref__added` | added | `./common.json/definitions/EffectiveAdminRuleKind` |
| `definitions.NetworkGroupProperties.properties.memberType.$ref__added` | added | `./common.json/definitions/GroupMemberType` |
| `definitions.NetworkManagerCommit.properties.commitType.$ref__added` | added | `./common.json/definitions/ConfigurationType` |
| `definitions.NetworkManagerDeploymentStatus.properties.deploymentStatus.$ref__added` | added | `./common.json/definitions/DeploymentStatus` |
| `definitions.NetworkManagerDeploymentStatus.properties.deploymentType.$ref__added` | added | `./common.json/definitions/ConfigurationType` |
| `definitions.NetworkManagerDeploymentStatusParameter.properties.deploymentTypes.items.$ref__added` | added | `./common.json/definitions/ConfigurationType` |
| `definitions.NetworkManagerProperties.properties.networkManagerScopeAccesses.items.$ref__added` | added | `./common.json/definitions/ConfigurationType` |
| `definitions.NetworkManagerProperties.properties.networkManagerScopes.$ref__added` | added | `./common.json/definitions/NetworkManagerPropertiesNetworkManagerScopes` |
| `definitions.RoutingRuleCollectionPropertiesFormat.properties.disableBgpRoutePropagation.$ref__added` | added | `./common.json/definitions/DisableBgpRoutePropagation` |
| `definitions.RoutingRuleNextHop.properties.nextHopType.$ref__added` | added | `./common.json/definitions/RoutingRuleNextHopType` |
| `definitions.RoutingRuleRouteDestination.properties.type.$ref__added` | added | `./common.json/definitions/RoutingRuleDestinationType` |
| `definitions.ScopeConnectionProperties.properties.connectionState.$ref__added` | added | `./common.json/definitions/ScopeConnectionState` |
| `definitions.SecurityAdminConfigurationPropertiesFormat.properties.applyOnNetworkIntentPolicyBasedServices.items.$ref__added` | added | `./common.json/definitions/NetworkIntentPolicyBasedService` |
| `definitions.SecurityAdminConfigurationPropertiesFormat.properties.networkGroupAddressSpaceAggregationOption.$ref__added` | added | `./common.json/definitions/AddressSpaceAggregationOption` |
| `definitions.SecurityAdminConfigurationPropertiesFormat.properties.provisioningState.$ref__added` | added | `./common.json/definitions/ProvisioningState` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkManagerConnections'].get.parameters[0].$ref__deleted` | deleted | `./networkManager.json#/parameters/ListTopParameter` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkManagerConnections'].get.parameters[1].$ref__deleted` | deleted | `./networkManager.json#/parameters/ListSkipTokenParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections'].get.parameters[0].$ref__deleted` | deleted | `./networkManager.json#/parameters/NetworkManagerNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections'].get.parameters[1].$ref__deleted` | deleted | `./networkManager.json#/parameters/ListTopParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections'].get.parameters[2].$ref__deleted` | deleted | `./networkManager.json#/parameters/ListSkipTokenParameter` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkManagerConnections'].get.parameters[0].name__added` | added | `$top` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkManagerConnections'].get.parameters[1].name__added` | added | `$skipToken` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections'].get.parameters[0].name__added` | added | `networkManagerName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections'].get.parameters[1].name__added` | added | `$top` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections'].get.parameters[2].name__added` | added | `$skipToken` |

### Changes for `in`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkManagerConnections'].get.parameters[0].in__added` | added | `query` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkManagerConnections'].get.parameters[1].in__added` | added | `query` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections'].get.parameters[1].in__added` | added | `query` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections'].get.parameters[2].in__added` | added | `query` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ActiveBaseSecurityAdminRule.properties.kind.type__deleted` | deleted | `string` |
| `definitions.AddressPrefixItem.properties.addressPrefixType.type__deleted` | deleted | `string` |
| `definitions.AdminPropertiesFormat.properties.access.type__deleted` | deleted | `string` |
| `definitions.AdminPropertiesFormat.properties.direction.type__deleted` | deleted | `string` |
| `definitions.AdminPropertiesFormat.properties.protocol.type__deleted` | deleted | `string` |
| `definitions.AdminPropertiesFormat.properties.provisioningState.type__deleted` | deleted | `string` |
| `definitions.AdminRuleCollectionPropertiesFormat.properties.provisioningState.type__deleted` | deleted | `string` |
| `definitions.ConnectivityConfigurationProperties.properties.connectivityCapabilities.type__deleted` | deleted | `object` |
| `definitions.ConnectivityConfigurationProperties.properties.connectivityTopology.type__deleted` | deleted | `string` |
| `definitions.ConnectivityConfigurationProperties.properties.deleteExistingPeering.type__deleted` | deleted | `string` |
| `definitions.ConnectivityConfigurationProperties.properties.isGlobal.type__deleted` | deleted | `string` |
| `definitions.connectivityGroupItem.properties.groupConnectivity.type__deleted` | deleted | `string` |
| `definitions.connectivityGroupItem.properties.isGlobal.type__deleted` | deleted | `string` |
| `definitions.connectivityGroupItem.properties.useHubGateway.type__deleted` | deleted | `string` |
| `definitions.DefaultAdminPropertiesFormat.properties.access.type__deleted` | deleted | `string` |
| `definitions.DefaultAdminPropertiesFormat.properties.direction.type__deleted` | deleted | `string` |
| `definitions.DefaultAdminPropertiesFormat.properties.protocol.type__deleted` | deleted | `string` |
| `definitions.DefaultAdminPropertiesFormat.properties.provisioningState.type__deleted` | deleted | `string` |
| `definitions.EffectiveBaseSecurityAdminRule.properties.kind.type__deleted` | deleted | `string` |
| `definitions.NetworkGroupProperties.properties.memberType.type__deleted` | deleted | `string` |
| `definitions.NetworkManagerCommit.properties.commitType.type__deleted` | deleted | `string` |
| `definitions.NetworkManagerDeploymentStatus.properties.deploymentStatus.type__deleted` | deleted | `string` |
| `definitions.NetworkManagerDeploymentStatus.properties.deploymentType.type__deleted` | deleted | `string` |
| `definitions.NetworkManagerDeploymentStatusParameter.properties.deploymentTypes.items.type__deleted` | deleted | `string` |
| `definitions.NetworkManagerProperties.properties.networkManagerScopeAccesses.items.type__deleted` | deleted | `string` |
| `definitions.NetworkManagerProperties.properties.networkManagerScopes.type__deleted` | deleted | `object` |
| `definitions.RoutingRuleCollectionPropertiesFormat.properties.disableBgpRoutePropagation.type__deleted` | deleted | `string` |
| `definitions.RoutingRuleNextHop.properties.nextHopType.type__deleted` | deleted | `string` |
| `definitions.RoutingRuleRouteDestination.properties.type.type__deleted` | deleted | `string` |
| `definitions.ScopeConnectionProperties.properties.connectionState.type__deleted` | deleted | `string` |
| `definitions.SecurityAdminConfigurationPropertiesFormat.properties.applyOnNetworkIntentPolicyBasedServices.items.type__deleted` | deleted | `string` |
| `definitions.SecurityAdminConfigurationPropertiesFormat.properties.networkGroupAddressSpaceAggregationOption.type__deleted` | deleted | `string` |
| `definitions.SecurityAdminConfigurationPropertiesFormat.properties.provisioningState.type__deleted` | deleted | `string` |
| `definitions.SecurityUserRulePropertiesFormat.properties.protocol.type__deleted` | deleted | `string` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkManagerConnections'].get.parameters[0].type__added` | added | `integer` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkManagerConnections'].get.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections'].get.parameters[1].type__added` | added | `integer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections'].get.parameters[2].type__added` | added | `string` |

### Changes for `format`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkManagerConnections'].get.parameters[0].format__added` | added | `int32` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections'].get.parameters[1].format__added` | added | `int32` |

### Changes for `minimum`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkManagerConnections'].get.parameters[0].minimum__added` | added | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections'].get.parameters[1].minimum__added` | added | `1` |

### Changes for `maximum`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkManagerConnections'].get.parameters[0].maximum__added` | added | `20` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections'].get.parameters[1].maximum__added` | added | `20` |

### Changes for `parameters`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkManagerConnections/{networkManagerConnectionName}'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/NetworkManagerC...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/ResourceGroupNa...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/commit'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/ResourceGroupNa...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/connectivityConfigurations/{configurationName}'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/ApiVersionParameter"},{"$ref":"./network.json#/parameters/Subsc...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/listActiveConnectivityConfigurations'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/ApiVersionParameter"},{"$ref":"./network.json#/parameters/Subsc...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/listActiveSecurityAdminRules'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/ApiVersionParameter"},{"$ref":"./network.json#/parameters/Subsc...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/listDeploymentStatus'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/ResourceGroupNa...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/networkGroups/{networkGroupName}'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/ResourceGroupNa...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/routingConfigurations/{configurationName}'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v5/types.json#/parameters/ApiVersionParame...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections/{scopeConnectionName}'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"./networkManager.json#/param...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/ApiVersionParameter"},{"$ref":"./network.json#/parameters/Subsc...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityUserConfigurations/{configurationName}'].parameters__deleted` | deleted | `[{"$ref":"../../../../../common-types/resource-management/v5/types.json#/parameters/ApiVersionParame...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/listNetworkManagerEffectiveConnectivityConfigurations'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/ResourceGroupNa...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/listNetworkManagerEffectiveSecurityAdminRules'].parameters__deleted` | deleted | `[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/ResourceGroupNa...` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectivityConfigurationListResult.required__added` | added | `["value"]` |
| `definitions.ConnectivityConfigurationProperties.properties.connectivityCapabilities.required__deleted` | deleted | `["connectedGroupPrivateEndpointsScale","connectedGroupAddressOverlap","peeringEnforcement"]` |
| `definitions.NetworkGroupListResult.required__added` | added | `["value"]` |
| `definitions.NetworkManagerConnectionListResult.required__added` | added | `["value"]` |
| `definitions.NetworkManagerListResult.required__added` | added | `["value"]` |
| `definitions.NetworkManagerRoutingConfigurationListResult.required__added` | added | `["value"]` |
| `definitions.ScopeConnectionListResult.required__added` | added | `["value"]` |
| `definitions.SecurityAdminConfigurationListResult.required__added` | added | `["value"]` |
| `definitions.SecurityUserConfigurationListResult.required__added` | added | `["value"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections'].get.parameters[0].required__added` | added | `true` |

### Changes for `pattern`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections'].get.parameters[0].pattern__added` | added | `^[0-9a-zA-Z]([0-9a-zA-Z_.-]{0,62}[0-9a-zA-Z_])?$` |

### Changes for `ActiveConnectivityConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ActiveConnectivityConfiguration__deleted` | deleted | `{"type":"object","properties":{"commitTime":{"type":"string","format":"date-time"},"region":{"type":...` |

### Changes for `ActiveDefaultSecurityAdminRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ActiveDefaultSecurityAdminRule__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"./networkManagerSecurityAdminConfiguration.json...` |

### Changes for `ActiveSecurityAdminRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ActiveSecurityAdminRule__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"./networkManagerSecurityAdminConfiguration.json...` |

### Changes for `AdminRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AdminRule__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/AdminPropertiesFormat","x-ms-clie...` |

### Changes for `AdminRuleCollection`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AdminRuleCollection__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/AdminRuleCollectionPropertiesForm...` |

### Changes for `AdminRuleCollectionListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AdminRuleCollectionListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `AdminRuleListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AdminRuleListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `BaseAdminRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BaseAdminRule__deleted` | deleted | `{"type":"object","properties":{"kind":{"type":"string","enum":["Custom","Default"],"x-ms-enum":{"nam...` |

### Changes for `DefaultAdminRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DefaultAdminRule__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/DefaultAdminPropertiesFormat","x-...` |

### Changes for `EffectiveDefaultSecurityAdminRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EffectiveDefaultSecurityAdminRule__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"./networkManagerSecurityAdminConfiguration.json...` |

### Changes for `EffectiveSecurityAdminRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EffectiveSecurityAdminRule__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"./networkManagerSecurityAdminConfiguration.json...` |

### Changes for `RoutingRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RoutingRule__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/RoutingRulePropertiesFormat","x-m...` |

### Changes for `RoutingRuleCollection`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RoutingRuleCollection__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/RoutingRuleCollectionPropertiesFo...` |

### Changes for `RoutingRuleCollectionListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RoutingRuleCollectionListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `RoutingRuleListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RoutingRuleListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `SecurityUserRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecurityUserRule__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/SecurityUserRulePropertiesFormat"...` |

### Changes for `SecurityUserRuleCollection`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecurityUserRuleCollection__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/SecurityUserRuleCollectionPropert...` |

### Changes for `SecurityUserRuleCollectionListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecurityUserRuleCollectionListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `SecurityUserRuleListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecurityUserRuleListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `StaticMember`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.StaticMember__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/StaticMemberProperties","x-ms-cli...` |

### Changes for `StaticMemberListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.StaticMemberListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ActiveBaseSecurityAdminRule.properties.kind.enum__deleted` | deleted | `["Custom","Default"]` |
| `definitions.AddressPrefixItem.properties.addressPrefixType.enum__deleted` | deleted | `["IPPrefix","ServiceTag","NetworkGroup"]` |
| `definitions.AdminPropertiesFormat.properties.access.enum__deleted` | deleted | `["Allow","Deny","AlwaysAllow"]` |
| `definitions.AdminPropertiesFormat.properties.direction.enum__deleted` | deleted | `["Inbound","Outbound"]` |
| `definitions.AdminPropertiesFormat.properties.protocol.enum__deleted` | deleted | `["Tcp","Udp","Icmp","Esp","Any","Ah"]` |
| `definitions.AdminPropertiesFormat.properties.provisioningState.enum__deleted` | deleted | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.AdminRuleCollectionPropertiesFormat.properties.provisioningState.enum__deleted` | deleted | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.ConnectivityConfigurationProperties.properties.connectivityTopology.enum__deleted` | deleted | `["HubAndSpoke","Mesh"]` |
| `definitions.ConnectivityConfigurationProperties.properties.deleteExistingPeering.enum__deleted` | deleted | `["False","True"]` |
| `definitions.ConnectivityConfigurationProperties.properties.isGlobal.enum__deleted` | deleted | `["False","True"]` |
| `definitions.connectivityGroupItem.properties.groupConnectivity.enum__deleted` | deleted | `["None","DirectlyConnected"]` |
| `definitions.connectivityGroupItem.properties.isGlobal.enum__deleted` | deleted | `["False","True"]` |
| `definitions.connectivityGroupItem.properties.useHubGateway.enum__deleted` | deleted | `["False","True"]` |
| `definitions.DefaultAdminPropertiesFormat.properties.access.enum__deleted` | deleted | `["Allow","Deny","AlwaysAllow"]` |
| `definitions.DefaultAdminPropertiesFormat.properties.direction.enum__deleted` | deleted | `["Inbound","Outbound"]` |
| `definitions.DefaultAdminPropertiesFormat.properties.protocol.enum__deleted` | deleted | `["Tcp","Udp","Icmp","Esp","Any","Ah"]` |
| `definitions.DefaultAdminPropertiesFormat.properties.provisioningState.enum__deleted` | deleted | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |
| `definitions.EffectiveBaseSecurityAdminRule.properties.kind.enum__deleted` | deleted | `["Custom","Default"]` |
| `definitions.NetworkGroupProperties.properties.memberType.enum__deleted` | deleted | `["VirtualNetwork","Subnet"]` |
| `definitions.NetworkManagerCommit.properties.commitType.enum__deleted` | deleted | `["SecurityAdmin","Connectivity","SecurityUser","Routing"]` |
| `definitions.NetworkManagerDeploymentStatus.properties.deploymentStatus.enum__deleted` | deleted | `["NotStarted","Deploying","Deployed","Failed"]` |
| `definitions.NetworkManagerDeploymentStatus.properties.deploymentType.enum__deleted` | deleted | `["SecurityAdmin","Connectivity","SecurityUser","Routing"]` |
| `definitions.NetworkManagerDeploymentStatusParameter.properties.deploymentTypes.items.enum__deleted` | deleted | `["SecurityAdmin","Connectivity","SecurityUser","Routing"]` |
| `definitions.NetworkManagerProperties.properties.networkManagerScopeAccesses.items.enum__deleted` | deleted | `["SecurityAdmin","Connectivity","SecurityUser","Routing"]` |
| `definitions.RoutingRuleCollectionPropertiesFormat.properties.disableBgpRoutePropagation.enum__deleted` | deleted | `["False","True"]` |
| `definitions.RoutingRuleNextHop.properties.nextHopType.enum__deleted` | deleted | `["Internet","NoNextHop","VirtualAppliance","VirtualNetworkGateway","VnetLocal"]` |
| `definitions.RoutingRuleRouteDestination.properties.type.enum__deleted` | deleted | `["AddressPrefix","ServiceTag"]` |
| `definitions.ScopeConnectionProperties.properties.connectionState.enum__deleted` | deleted | `["Connected","Pending","Conflict","Revoked","Rejected"]` |
| `definitions.SecurityAdminConfigurationPropertiesFormat.properties.applyOnNetworkIntentPolicyBasedServices.items.enum__deleted` | deleted | `["None","All","AllowRulesOnly"]` |
| `definitions.SecurityAdminConfigurationPropertiesFormat.properties.networkGroupAddressSpaceAggregationOption.enum__deleted` | deleted | `["None","Manual"]` |
| `definitions.SecurityAdminConfigurationPropertiesFormat.properties.provisioningState.enum__deleted` | deleted | `["Failed","Succeeded","Canceled","Creating","Updating","Deleting"]` |

### Changes for `x-ms-enum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ActiveBaseSecurityAdminRule.properties.kind['x-ms-enum__deleted']` | deleted | `{"name":"EffectiveAdminRuleKind","modelAsString":true}` |
| `definitions.AddressPrefixItem.properties.addressPrefixType['x-ms-enum__deleted']` | deleted | `{"name":"AddressPrefixType","modelAsString":true}` |
| `definitions.AdminPropertiesFormat.properties.access['x-ms-enum__deleted']` | deleted | `{"name":"SecurityConfigurationRuleAccess","modelAsString":true}` |
| `definitions.AdminPropertiesFormat.properties.direction['x-ms-enum__deleted']` | deleted | `{"name":"SecurityConfigurationRuleDirection","modelAsString":true}` |
| `definitions.AdminPropertiesFormat.properties.protocol['x-ms-enum__deleted']` | deleted | `{"name":"SecurityConfigurationRuleProtocol","modelAsString":true}` |
| `definitions.AdminPropertiesFormat.properties.provisioningState['x-ms-enum__deleted']` | deleted | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.AdminRuleCollectionPropertiesFormat.properties.provisioningState['x-ms-enum__deleted']` | deleted | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.ConnectivityConfigurationProperties.properties.connectivityTopology['x-ms-enum__deleted']` | deleted | `{"name":"ConnectivityTopology","modelAsString":true}` |
| `definitions.ConnectivityConfigurationProperties.properties.deleteExistingPeering['x-ms-enum__deleted']` | deleted | `{"name":"DeleteExistingPeering","modelAsString":true}` |
| `definitions.ConnectivityConfigurationProperties.properties.isGlobal['x-ms-enum__deleted']` | deleted | `{"name":"IsGlobal","modelAsString":true}` |
| `definitions.connectivityGroupItem.properties.groupConnectivity['x-ms-enum__deleted']` | deleted | `{"name":"GroupConnectivity","modelAsString":true}` |
| `definitions.connectivityGroupItem.properties.isGlobal['x-ms-enum__deleted']` | deleted | `{"name":"IsGlobal","modelAsString":true}` |
| `definitions.connectivityGroupItem.properties.useHubGateway['x-ms-enum__deleted']` | deleted | `{"name":"UseHubGateway","modelAsString":true}` |
| `definitions.DefaultAdminPropertiesFormat.properties.access['x-ms-enum__deleted']` | deleted | `{"name":"SecurityConfigurationRuleAccess","modelAsString":true}` |
| `definitions.DefaultAdminPropertiesFormat.properties.direction['x-ms-enum__deleted']` | deleted | `{"name":"SecurityConfigurationRuleDirection","modelAsString":true}` |
| `definitions.DefaultAdminPropertiesFormat.properties.protocol['x-ms-enum__deleted']` | deleted | `{"name":"SecurityConfigurationRuleProtocol","modelAsString":true}` |
| `definitions.DefaultAdminPropertiesFormat.properties.provisioningState['x-ms-enum__deleted']` | deleted | `{"name":"ProvisioningState","modelAsString":true}` |
| `definitions.EffectiveBaseSecurityAdminRule.properties.kind['x-ms-enum__deleted']` | deleted | `{"name":"EffectiveAdminRuleKind","modelAsString":true}` |
| `definitions.NetworkGroupProperties.properties.memberType['x-ms-enum__deleted']` | deleted | `{"name":"GroupMemberType","modelAsString":true}` |
| `definitions.NetworkManagerCommit.properties.commitType['x-ms-enum__deleted']` | deleted | `{"name":"ConfigurationType","modelAsString":true}` |
| `definitions.NetworkManagerDeploymentStatus.properties.deploymentStatus['x-ms-enum__deleted']` | deleted | `{"name":"DeploymentStatus","modelAsString":true}` |
| `definitions.NetworkManagerDeploymentStatus.properties.deploymentType['x-ms-enum__deleted']` | deleted | `{"name":"ConfigurationType","modelAsString":true}` |
| `definitions.NetworkManagerDeploymentStatusParameter.properties.deploymentTypes.items['x-ms-enum__deleted']` | deleted | `{"name":"ConfigurationType","modelAsString":true}` |
| `definitions.NetworkManagerProperties.properties.networkManagerScopeAccesses.items['x-ms-enum__deleted']` | deleted | `{"name":"ConfigurationType","modelAsString":true}` |
| `definitions.RoutingRuleCollectionPropertiesFormat.properties.disableBgpRoutePropagation['x-ms-enum__deleted']` | deleted | `{"name":"DisableBgpRoutePropagation","modelAsString":true}` |
| `definitions.RoutingRuleNextHop.properties.nextHopType['x-ms-enum__deleted']` | deleted | `{"name":"RoutingRuleNextHopType","modelAsString":true}` |
| `definitions.RoutingRuleRouteDestination.properties.type['x-ms-enum__deleted']` | deleted | `{"name":"RoutingRuleDestinationType","modelAsString":true}` |
| `definitions.ScopeConnectionProperties.properties.connectionState['x-ms-enum__deleted']` | deleted | `{"name":"ScopeConnectionState","modelAsString":true}` |
| `definitions.SecurityAdminConfigurationPropertiesFormat.properties.applyOnNetworkIntentPolicyBasedServices.items['x-ms-enum__deleted']` | deleted | `{"name":"NetworkIntentPolicyBasedService","modelAsString":true}` |
| `definitions.SecurityAdminConfigurationPropertiesFormat.properties.networkGroupAddressSpaceAggregationOption['x-ms-enum__deleted']` | deleted | `{"name":"AddressSpaceAggregationOption","modelAsString":true}` |
| `definitions.SecurityAdminConfigurationPropertiesFormat.properties.provisioningState['x-ms-enum__deleted']` | deleted | `{"name":"ProvisioningState","modelAsString":true}` |

### Changes for `properties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectivityConfigurationProperties.properties.connectivityCapabilities.properties__deleted` | deleted | `{"connectedGroupPrivateEndpointsScale":{"type":"string","description":"Option indicating the scale o...` |
| `definitions.NetworkManagerProperties.properties.networkManagerScopes.properties__deleted` | deleted | `{"managementGroups":{"type":"array","description":"List of management groups.","items":{"type":"stri...` |

### Changes for `etag`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkManagerConnection.properties.etag__deleted` | deleted | `{"type":"string","readOnly":true}` |

### Changes for `readOnly`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkManagerConnectionProperties.properties.connectionState.readOnly__added` | added | `true` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.ActiveBaseSecurityAdminRule.properties.ruleCollectionAppliesToGroups.items.$ref` | `./networkManagerSecurityAdminConfiguration.json#/definitions/NetworkManagerSecurityGroupItem` | `#/definitions/NetworkManagerSecurityGroupItem` |
| `definitions.ActiveBaseSecurityAdminRule.properties.ruleGroups.items.$ref` | `./networkManagerEffectiveConfiguration.json#/definitions/ConfigurationGroup` | `#/definitions/ConfigurationGroup` |
| `definitions.ActiveConnectivityConfigurationsListResult.properties.value.items.$ref` | `#/definitions/ActiveConnectivityConfiguration` | `./common.json/definitions/ActiveConnectivityConfiguration` |
| `definitions.ConfigurationGroup.properties.properties.$ref` | `./networkManagerGroup.json#/definitions/NetworkGroupProperties` | `#/definitions/NetworkGroupProperties` |
| `definitions.ConnectivityConfiguration.allOf[0].$ref` | `./network.json#/definitions/ChildResource` | `./common.json/definitions/ChildResource` |
| `definitions.ConnectivityConfiguration.properties.systemData.$ref` | `./network.json#/definitions/SystemData` | `../../../../../common-types/resource-management/v5/types.json#/definitions/systemData` |
| `definitions.ConnectivityConfigurationProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.EffectiveBaseSecurityAdminRule.properties.ruleCollectionAppliesToGroups.items.$ref` | `./networkManagerSecurityAdminConfiguration.json#/definitions/NetworkManagerSecurityGroupItem` | `#/definitions/NetworkManagerSecurityGroupItem` |
| `definitions.EffectiveConnectivityConfiguration.properties.properties.$ref` | `./networkManagerConnectivityConfiguration.json#/definitions/ConnectivityConfigurationProperties` | `#/definitions/ConnectivityConfigurationProperties` |
| `definitions.NetworkGroup.allOf[0].$ref` | `./network.json#/definitions/ChildResource` | `./common.json/definitions/ChildResource` |
| `definitions.NetworkGroup.properties.systemData.$ref` | `./network.json#/definitions/SystemData` | `../../../../../common-types/resource-management/v5/types.json#/definitions/systemData` |
| `definitions.NetworkGroupProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.NetworkManager.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json/definitions/Resource` |
| `definitions.NetworkManager.properties.systemData.$ref` | `./network.json#/definitions/SystemData` | `../../../../../common-types/resource-management/v5/types.json#/definitions/systemData` |
| `definitions.NetworkManagerConnection.allOf[0].$ref` | `./network.json#/definitions/ChildResource` | `./common.json/definitions/ChildResource` |
| `definitions.NetworkManagerConnection.properties.systemData.$ref` | `./network.json#/definitions/SystemData` | `../../../../../common-types/resource-management/v5/types.json#/definitions/systemData` |
| `definitions.NetworkManagerConnectionProperties.properties.connectionState.$ref` | `./networkManagerScopeConnection.json#/definitions/ConnectionState` | `./common.json/definitions/ScopeConnectionState` |
| `definitions.NetworkManagerProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.NetworkManagerRoutingConfiguration.allOf[0].$ref` | `./network.json#/definitions/ChildResource` | `./common.json/definitions/ChildResource` |
| `definitions.NetworkManagerRoutingConfiguration.properties.systemData.$ref` | `./network.json#/definitions/SystemData` | `../../../../../common-types/resource-management/v5/types.json#/definitions/systemData` |
| `definitions.NetworkManagerRoutingConfigurationPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.RoutingRuleCollectionPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.RoutingRulePropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.ScopeConnection.allOf[0].$ref` | `./network.json#/definitions/ChildResource` | `./common.json/definitions/ChildResource` |
| `definitions.ScopeConnection.properties.systemData.$ref` | `./network.json#/definitions/SystemData` | `../../../../../common-types/resource-management/v5/types.json#/definitions/systemData` |
| `definitions.SecurityAdminConfiguration.allOf[0].$ref` | `./network.json#/definitions/ChildResource` | `./common.json/definitions/ChildResource` |
| `definitions.SecurityAdminConfiguration.properties.systemData.$ref` | `./network.json#/definitions/SystemData` | `../../../../../common-types/resource-management/v5/types.json#/definitions/systemData` |
| `definitions.SecurityUserConfiguration.allOf[0].$ref` | `./network.json#/definitions/ChildResource` | `./common.json/definitions/ChildResource` |
| `definitions.SecurityUserConfiguration.properties.systemData.$ref` | `./network.json#/definitions/SystemData` | `../../../../../common-types/resource-management/v5/types.json#/definitions/systemData` |
| `definitions.SecurityUserConfigurationPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.SecurityUserRuleCollectionPropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.SecurityUserRulePropertiesFormat.properties.destinations.items.$ref` | `./networkManagerSecurityAdminConfiguration.json#/definitions/AddressPrefixItem` | `#/definitions/AddressPrefixItem` |
| `definitions.SecurityUserRulePropertiesFormat.properties.direction.$ref` | `./networkManagerSecurityAdminConfiguration.json#/definitions/SecurityConfigurationRuleDirection` | `./common.json/definitions/SecurityConfigurationRuleDirection` |
| `definitions.SecurityUserRulePropertiesFormat.properties.protocol.$ref` | `./networkManagerSecurityAdminConfiguration.json#/definitions/RuleProtocol` | `./common.json/definitions/SecurityConfigurationRuleProtocol` |
| `definitions.SecurityUserRulePropertiesFormat.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `definitions.SecurityUserRulePropertiesFormat.properties.sources.items.$ref` | `./networkManagerSecurityAdminConfiguration.json#/definitions/AddressPrefixItem` | `#/definitions/AddressPrefixItem` |
| `definitions.StaticMemberProperties.properties.provisioningState.$ref` | `./network.json#/definitions/ProvisioningState` | `./common.json/definitions/NetworkProvisioningState` |
| `info.title` | `SecurityUserConfiguration` | `WebApplicationFirewallManagement` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkManagerConnections'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkManagerConnections/{networkManagerConnectionName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkManagerConnections/{networkManagerConnectionName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkManagerConnections/{networkManagerConnectionName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.Network/networkManagers'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/commit'].post.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/commit'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/connectivityConfigurations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/connectivityConfigurations/{configurationName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/connectivityConfigurations/{configurationName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/connectivityConfigurations/{configurationName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/connectivityConfigurations/{configurationName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/listActiveConnectivityConfigurations'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/listActiveSecurityAdminRules'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/listDeploymentStatus'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/networkGroups'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/networkGroups/{networkGroupName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/networkGroups/{networkGroupName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/networkGroups/{networkGroupName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/networkGroups/{networkGroupName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/routingConfigurations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/routingConfigurations/{configurationName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/routingConfigurations/{configurationName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/routingConfigurations/{configurationName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/routingConfigurations/{configurationName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections/{scopeConnectionName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections/{scopeConnectionName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/scopeConnections/{scopeConnectionName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `./common.json/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `./common.json/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `./common.json/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CommonErrorResponse` | `./common.json/definitions/CommonErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityUserConfigurations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityUserConfigurations/{configurationName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityUserConfigurations/{configurationName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityUserConfigurations/{configurationName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityUserConfigurations/{configurationName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/listNetworkManagerEffectiveConnectivityConfigurations'].post.parameters[2].schema.$ref` | `./networkManagerGroup.json#/definitions/QueryRequestOptions` | `#/definitions/QueryRequestOptions` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/listNetworkManagerEffectiveConnectivityConfigurations'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/listNetworkManagerEffectiveSecurityAdminRules'].post.parameters[2].schema.$ref` | `./networkManagerGroup.json#/definitions/QueryRequestOptions` | `#/definitions/QueryRequestOptions` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/listNetworkManagerEffectiveSecurityAdminRules'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |

