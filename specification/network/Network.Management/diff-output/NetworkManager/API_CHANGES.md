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

### Changes for `description`

| Path | Change Type | Value |
|------|------------|-------|
| `info.description__added` | added | `APIs to manage web application firewall rules.` |

### Changes for `/providers/microsoft.Management/managementGroups/{managementGroupId}/providers/microsoft.Network/networkManagerConnections`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/providers/microsoft.Management/managementGroups/{managementGroupId}/providers/microsoft.Network/networkManagerConnections__deleted']` | deleted | `{"get":{"operationId":"ManagementGroupNetworkManagerConnections_List","parameters":[{"name":"managem...` |

### Changes for `/providers/microsoft.Management/managementGroups/{managementGroupId}/providers/microsoft.Network/networkManagerConnections/{networkManagerConnectionName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/providers/microsoft.Management/managementGroups/{managementGroupId}/providers/microsoft.Network/networkManagerConnections/{networkManagerConnectionName}__deleted']` | deleted | `{"parameters":[{"$ref":"#/parameters/ManagementGroupIdParameter"},{"$ref":"#/parameters/NetworkManag...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/networkGroups/{networkGroupName}/staticMembers`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/networkGroups/{networkGroupName}/staticMembers__deleted']` | deleted | `{"get":{"operationId":"StaticMembers_List","parameters":[{"name":"networkManagerName","in":"path","r...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/networkGroups/{networkGroupName}/staticMembers/{staticMemberName}`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/networkGroups/{networkGroupName}/staticMembers/{staticMemberName}__deleted']` | deleted | `{"parameters":[{"$ref":"./network.json#/parameters/SubscriptionIdParameter"},{"$ref":"#/parameters/R...` |

### Changes for `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/routingConfigurations/{configurationName}/ruleCollections`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/routingConfigurations/{configurationName}/ruleCollections__deleted']` | deleted | `{"get":{"operationId":"RoutingRuleCollections_List","parameters":[{"name":"networkManagerName","in":...` |

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
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityAdminConfigurations/{configurationName}/ruleCollections__deleted']` | deleted | `{"get":{"operationId":"AdminRuleCollections_List","parameters":[{"$ref":"./networkManager.json#/para...` |

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
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/securityUserConfigurations/{configurationName}/ruleCollections__deleted']` | deleted | `{"get":{"operationId":"SecurityUserRuleCollections_List","parameters":[{"name":"networkManagerName",...` |

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

### Changes for `ActiveBaseSecurityAdminRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ActiveBaseSecurityAdminRule__deleted` | deleted | `{"type":"object","properties":{"id":{"type":"string"},"commitTime":{"type":"string","format":"date-t...` |

### Changes for `ActiveConfigurationParameter`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ActiveConfigurationParameter__deleted` | deleted | `{"type":"object","properties":{"regions":{"type":"array","items":{"type":"string"}},"skipToken":{"ty...` |

### Changes for `ActiveConnectivityConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ActiveConnectivityConfiguration__deleted` | deleted | `{"type":"object","properties":{"commitTime":{"type":"string","format":"date-time"},"region":{"type":...` |

### Changes for `ActiveConnectivityConfigurationsListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ActiveConnectivityConfigurationsListResult__deleted` | deleted | `{"type":"object","properties":{"value":{"type":"array","items":{"$ref":"#/definitions/ActiveConnecti...` |

### Changes for `ActiveDefaultSecurityAdminRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ActiveDefaultSecurityAdminRule__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"./networkManagerSecurityAdminConfiguration.json...` |

### Changes for `ActiveSecurityAdminRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ActiveSecurityAdminRule__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"./networkManagerSecurityAdminConfiguration.json...` |

### Changes for `ActiveSecurityAdminRulesListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ActiveSecurityAdminRulesListResult__deleted` | deleted | `{"type":"object","properties":{"value":{"type":"array","items":{"$ref":"#/definitions/ActiveBaseSecu...` |

### Changes for `AddressPrefixItem`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AddressPrefixItem__deleted` | deleted | `{"type":"object","properties":{"addressPrefix":{"type":"string"},"addressPrefixType":{"type":"string...` |

### Changes for `AdminPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AdminPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"description":{"type":"string"},"protocol":{"type":"string","enum":["...` |

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

### Changes for `AdminRuleCollectionPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AdminRuleCollectionPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"description":{"type":"string"},"appliesToGroups":{"type":"array","it...` |

### Changes for `AdminRuleListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AdminRuleListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `BaseAdminRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.BaseAdminRule__deleted` | deleted | `{"type":"object","properties":{"kind":{"type":"string","enum":["Custom","Default"],"x-ms-enum":{"nam...` |

### Changes for `ConfigurationGroup`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConfigurationGroup__deleted` | deleted | `{"type":"object","properties":{"id":{"type":"string"},"properties":{"$ref":"./networkManagerGroup.js...` |

### Changes for `ConnectivityConfigurationProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConnectivityConfigurationProperties__deleted` | deleted | `{"type":"object","properties":{"description":{"type":"string"},"connectivityTopology":{"type":"strin...` |

### Changes for `CrossTenantScopes`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CrossTenantScopes__deleted` | deleted | `{"type":"object","properties":{"tenantId":{"type":"string","readOnly":true},"managementGroups":{"typ...` |

### Changes for `DefaultAdminPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DefaultAdminPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"description":{"type":"string","readOnly":true},"flag":{"type":"strin...` |

### Changes for `DefaultAdminRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DefaultAdminRule__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/DefaultAdminPropertiesFormat","x-...` |

### Changes for `EffectiveBaseSecurityAdminRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EffectiveBaseSecurityAdminRule__deleted` | deleted | `{"type":"object","properties":{"id":{"type":"string"},"configurationDescription":{"type":"string"},"...` |

### Changes for `EffectiveConnectivityConfiguration`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EffectiveConnectivityConfiguration__deleted` | deleted | `{"type":"object","properties":{"id":{"type":"string"},"properties":{"$ref":"./networkManagerConnecti...` |

### Changes for `EffectiveDefaultSecurityAdminRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EffectiveDefaultSecurityAdminRule__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"./networkManagerSecurityAdminConfiguration.json...` |

### Changes for `EffectiveSecurityAdminRule`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EffectiveSecurityAdminRule__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"./networkManagerSecurityAdminConfiguration.json...` |

### Changes for `Hub`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Hub__deleted` | deleted | `{"type":"object","properties":{"resourceId":{"type":"string"},"resourceType":{"type":"string"}}}` |

### Changes for `NetworkGroupProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkGroupProperties__deleted` | deleted | `{"type":"object","properties":{"description":{"type":"string"},"memberType":{"type":"string","enum":...` |

### Changes for `NetworkManagerCommit`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkManagerCommit__deleted` | deleted | `{"type":"object","properties":{"commitId":{"type":"string","readOnly":true},"targetLocations":{"type...` |

### Changes for `NetworkManagerConnectionProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkManagerConnectionProperties__deleted` | deleted | `{"type":"object","properties":{"networkManagerId":{"type":"string"},"connectionState":{"$ref":"./net...` |

### Changes for `NetworkManagerDeploymentStatus`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkManagerDeploymentStatus__deleted` | deleted | `{"type":"object","properties":{"commitTime":{"type":"string","format":"date-time"},"region":{"type":...` |

### Changes for `NetworkManagerDeploymentStatusListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkManagerDeploymentStatusListResult__deleted` | deleted | `{"type":"object","properties":{"value":{"type":"array","items":{"$ref":"#/definitions/NetworkManager...` |

### Changes for `NetworkManagerDeploymentStatusParameter`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkManagerDeploymentStatusParameter__deleted` | deleted | `{"type":"object","properties":{"regions":{"type":"array","items":{"type":"string"}},"deploymentTypes...` |

### Changes for `NetworkManagerEffectiveConnectivityConfigurationListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkManagerEffectiveConnectivityConfigurationListResult__deleted` | deleted | `{"type":"object","properties":{"value":{"type":"array","items":{"$ref":"#/definitions/EffectiveConne...` |

### Changes for `NetworkManagerEffectiveSecurityAdminRulesListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkManagerEffectiveSecurityAdminRulesListResult__deleted` | deleted | `{"type":"object","properties":{"value":{"type":"array","items":{"$ref":"#/definitions/EffectiveBaseS...` |

### Changes for `NetworkManagerProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkManagerProperties__deleted` | deleted | `{"type":"object","properties":{"description":{"type":"string"},"networkManagerScopes":{"type":"objec...` |

### Changes for `NetworkManagerRoutingConfigurationPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkManagerRoutingConfigurationPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"description":{"type":"string"},"provisioningState":{"$ref":"./networ...` |

### Changes for `NetworkManagerRoutingGroupItem`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkManagerRoutingGroupItem__deleted` | deleted | `{"type":"object","properties":{"networkGroupId":{"type":"string"}},"required":["networkGroupId"]}` |

### Changes for `NetworkManagerSecurityGroupItem`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkManagerSecurityGroupItem__deleted` | deleted | `{"type":"object","properties":{"networkGroupId":{"type":"string"}},"required":["networkGroupId"]}` |

### Changes for `PatchObject`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PatchObject__deleted` | deleted | `{"type":"object","properties":{"tags":{"type":"object","additionalProperties":{"type":"string"}}}}` |

### Changes for `QueryRequestOptions`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.QueryRequestOptions__deleted` | deleted | `{"type":"object","properties":{"skipToken":{"type":"string"}}}` |

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

### Changes for `RoutingRuleCollectionPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RoutingRuleCollectionPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"description":{"type":"string"},"provisioningState":{"$ref":"./networ...` |

### Changes for `RoutingRuleListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RoutingRuleListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `RoutingRuleNextHop`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RoutingRuleNextHop__deleted` | deleted | `{"type":"object","properties":{"nextHopType":{"type":"string","enum":["Internet","NoNextHop","Virtua...` |

### Changes for `RoutingRulePropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RoutingRulePropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"description":{"type":"string"},"provisioningState":{"$ref":"./networ...` |

### Changes for `RoutingRuleRouteDestination`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.RoutingRuleRouteDestination__deleted` | deleted | `{"type":"object","properties":{"type":{"type":"string","enum":["AddressPrefix","ServiceTag"],"x-ms-e...` |

### Changes for `ScopeConnectionProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ScopeConnectionProperties__deleted` | deleted | `{"type":"object","properties":{"tenantId":{"type":"string"},"resourceId":{"type":"string"},"connecti...` |

### Changes for `SecurityAdminConfigurationPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecurityAdminConfigurationPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"description":{"type":"string"},"applyOnNetworkIntentPolicyBasedServi...` |

### Changes for `SecurityUserConfigurationPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecurityUserConfigurationPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"description":{"type":"string"},"provisioningState":{"$ref":"./networ...` |

### Changes for `SecurityUserGroupItem`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecurityUserGroupItem__deleted` | deleted | `{"type":"object","properties":{"networkGroupId":{"type":"string"}},"required":["networkGroupId"]}` |

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

### Changes for `SecurityUserRuleCollectionPropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecurityUserRuleCollectionPropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"description":{"type":"string"},"appliesToGroups":{"type":"array","it...` |

### Changes for `SecurityUserRuleListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecurityUserRuleListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `SecurityUserRulePropertiesFormat`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SecurityUserRulePropertiesFormat__deleted` | deleted | `{"type":"object","properties":{"description":{"type":"string"},"protocol":{"$ref":"./networkManagerS...` |

### Changes for `StaticMember`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.StaticMember__deleted` | deleted | `{"type":"object","properties":{"properties":{"$ref":"#/definitions/StaticMemberProperties","x-ms-cli...` |

### Changes for `StaticMemberListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.StaticMemberListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `StaticMemberProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.StaticMemberProperties__deleted` | deleted | `{"type":"object","properties":{"resourceId":{"type":"string"},"region":{"type":"string","readOnly":t...` |

### Changes for `connectivityGroupItem`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.connectivityGroupItem__deleted` | deleted | `{"type":"object","properties":{"networkGroupId":{"type":"string"},"useHubGateway":{"type":"string","...` |

### Changes for `etag`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkManagerConnection.properties.etag__deleted` | deleted | `{"type":"string","readOnly":true}` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.ConnectivityConfiguration.allOf[0].$ref` | `./network.json#/definitions/ChildResource` | `./common.json/definitions/ChildResource` |
| `definitions.ConnectivityConfiguration.properties.properties.$ref` | `#/definitions/ConnectivityConfigurationProperties` | `./common.json/definitions/ConnectivityConfigurationProperties` |
| `definitions.ConnectivityConfiguration.properties.systemData.$ref` | `./network.json#/definitions/SystemData` | `../../../../../common-types/resource-management/v5/types.json#/definitions/systemData` |
| `definitions.NetworkGroup.allOf[0].$ref` | `./network.json#/definitions/ChildResource` | `./common.json/definitions/ChildResource` |
| `definitions.NetworkGroup.properties.properties.$ref` | `#/definitions/NetworkGroupProperties` | `./common.json/definitions/NetworkGroupProperties` |
| `definitions.NetworkGroup.properties.systemData.$ref` | `./network.json#/definitions/SystemData` | `../../../../../common-types/resource-management/v5/types.json#/definitions/systemData` |
| `definitions.NetworkManager.allOf[0].$ref` | `./network.json#/definitions/Resource` | `./common.json/definitions/Resource` |
| `definitions.NetworkManager.properties.properties.$ref` | `#/definitions/NetworkManagerProperties` | `./common.json/definitions/NetworkManagerProperties` |
| `definitions.NetworkManager.properties.systemData.$ref` | `./network.json#/definitions/SystemData` | `../../../../../common-types/resource-management/v5/types.json#/definitions/systemData` |
| `definitions.NetworkManagerConnection.allOf[0].$ref` | `./network.json#/definitions/ChildResource` | `./common.json/definitions/ChildResource` |
| `definitions.NetworkManagerConnection.properties.properties.$ref` | `#/definitions/NetworkManagerConnectionProperties` | `./common.json/definitions/NetworkManagerConnectionProperties` |
| `definitions.NetworkManagerConnection.properties.systemData.$ref` | `./network.json#/definitions/SystemData` | `../../../../../common-types/resource-management/v5/types.json#/definitions/systemData` |
| `definitions.NetworkManagerRoutingConfiguration.allOf[0].$ref` | `./network.json#/definitions/ChildResource` | `./common.json/definitions/ChildResource` |
| `definitions.NetworkManagerRoutingConfiguration.properties.properties.$ref` | `#/definitions/NetworkManagerRoutingConfigurationPropertiesFormat` | `./common.json/definitions/NetworkManagerRoutingConfigurationPropertiesFormat` |
| `definitions.NetworkManagerRoutingConfiguration.properties.systemData.$ref` | `./network.json#/definitions/SystemData` | `../../../../../common-types/resource-management/v5/types.json#/definitions/systemData` |
| `definitions.ScopeConnection.allOf[0].$ref` | `./network.json#/definitions/ChildResource` | `./common.json/definitions/ChildResource` |
| `definitions.ScopeConnection.properties.properties.$ref` | `#/definitions/ScopeConnectionProperties` | `./common.json/definitions/ScopeConnectionProperties` |
| `definitions.ScopeConnection.properties.systemData.$ref` | `./network.json#/definitions/SystemData` | `../../../../../common-types/resource-management/v5/types.json#/definitions/systemData` |
| `definitions.SecurityAdminConfiguration.allOf[0].$ref` | `./network.json#/definitions/ChildResource` | `./common.json/definitions/ChildResource` |
| `definitions.SecurityAdminConfiguration.properties.properties.$ref` | `#/definitions/SecurityAdminConfigurationPropertiesFormat` | `./common.json/definitions/SecurityAdminConfigurationPropertiesFormat` |
| `definitions.SecurityAdminConfiguration.properties.systemData.$ref` | `./network.json#/definitions/SystemData` | `../../../../../common-types/resource-management/v5/types.json#/definitions/systemData` |
| `definitions.SecurityUserConfiguration.allOf[0].$ref` | `./network.json#/definitions/ChildResource` | `./common.json/definitions/ChildResource` |
| `definitions.SecurityUserConfiguration.properties.properties.$ref` | `#/definitions/SecurityUserConfigurationPropertiesFormat` | `./common.json/definitions/SecurityUserConfigurationPropertiesFormat` |
| `definitions.SecurityUserConfiguration.properties.systemData.$ref` | `./network.json#/definitions/SystemData` | `../../../../../common-types/resource-management/v5/types.json#/definitions/systemData` |
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
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}'].patch.parameters[1].schema.$ref` | `#/definitions/PatchObject` | `./common.json/definitions/PatchObject` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}'].patch.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/commit'].post.parameters[1].schema.$ref` | `#/definitions/NetworkManagerCommit` | `./common.json/definitions/NetworkManagerCommit` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/commit'].post.responses.200.schema.$ref` | `#/definitions/NetworkManagerCommit` | `./common.json/definitions/NetworkManagerCommit` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/commit'].post.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/commit'].post.responses.202.schema.$ref` | `#/definitions/NetworkManagerCommit` | `./common.json/definitions/NetworkManagerCommit` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/commit'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/connectivityConfigurations'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/connectivityConfigurations/{configurationName}'].delete.responses.202.headers.Location.description` | `The URL of the resource used to check the status of the asynchronous operation.` | `The Location header contains the URL where the status of the long running operation can be checked.` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/connectivityConfigurations/{configurationName}'].delete.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/connectivityConfigurations/{configurationName}'].get.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/connectivityConfigurations/{configurationName}'].put.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/listActiveConnectivityConfigurations'].post.parameters[2].schema.$ref` | `#/definitions/ActiveConfigurationParameter` | `./common.json/definitions/ActiveConfigurationParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/listActiveConnectivityConfigurations'].post.responses.200.schema.$ref` | `#/definitions/ActiveConnectivityConfigurationsListResult` | `./common.json/definitions/ActiveConnectivityConfigurationsListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/listActiveConnectivityConfigurations'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/listActiveSecurityAdminRules'].post.parameters[2].schema.$ref` | `#/definitions/ActiveConfigurationParameter` | `./common.json/definitions/ActiveConfigurationParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/listActiveSecurityAdminRules'].post.responses.200.schema.$ref` | `#/definitions/ActiveSecurityAdminRulesListResult` | `./common.json/definitions/ActiveSecurityAdminRulesListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/listActiveSecurityAdminRules'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/listDeploymentStatus'].post.parameters[2].schema.$ref` | `#/definitions/NetworkManagerDeploymentStatusParameter` | `./common.json/definitions/NetworkManagerDeploymentStatusParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/networkManagers/{networkManagerName}/listDeploymentStatus'].post.responses.200.schema.$ref` | `#/definitions/NetworkManagerDeploymentStatusListResult` | `./common.json/definitions/NetworkManagerDeploymentStatusListResult` |
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
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/listNetworkManagerEffectiveConnectivityConfigurations'].post.parameters[2].schema.$ref` | `./networkManagerGroup.json#/definitions/QueryRequestOptions` | `./common.json/definitions/QueryRequestOptions` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/listNetworkManagerEffectiveConnectivityConfigurations'].post.responses.200.schema.$ref` | `#/definitions/NetworkManagerEffectiveConnectivityConfigurationListResult` | `./common.json/definitions/NetworkManagerEffectiveConnectivityConfigurationListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/listNetworkManagerEffectiveConnectivityConfigurations'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/listNetworkManagerEffectiveSecurityAdminRules'].post.parameters[2].schema.$ref` | `./networkManagerGroup.json#/definitions/QueryRequestOptions` | `./common.json/definitions/QueryRequestOptions` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/listNetworkManagerEffectiveSecurityAdminRules'].post.responses.200.schema.$ref` | `#/definitions/NetworkManagerEffectiveSecurityAdminRulesListResult` | `./common.json/definitions/NetworkManagerEffectiveSecurityAdminRulesListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Network/virtualNetworks/{virtualNetworkName}/listNetworkManagerEffectiveSecurityAdminRules'].post.responses.default.schema.$ref` | `./network.json#/definitions/CloudError` | `./common.json/definitions/CloudError` |

