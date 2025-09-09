## Swagger Changes

### Changes for `$ref`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGroup.properties.properties.$ref__added` | added | `#/definitions/ApplicationGroupProperties` |
| `definitions.ArmDisasterRecovery.properties.properties.$ref__added` | added | `#/definitions/ArmDisasterRecoveryProperties` |
| `definitions.AuthorizationRule.properties.properties.$ref__added` | added | `#/definitions/AuthorizationRuleProperties` |
| `definitions.Cluster.properties.properties.$ref__added` | added | `#/definitions/ClusterProperties` |
| `definitions.ConsumerGroup.properties.properties.$ref__added` | added | `#/definitions/ConsumerGroupProperties` |
| `definitions.Destination.properties.properties.$ref__added` | added | `#/definitions/DestinationProperties` |
| `definitions.EHNamespace.properties.properties.$ref__added` | added | `#/definitions/EHNamespaceProperties` |
| `definitions.Eventhub.properties.properties.$ref__added` | added | `#/definitions/EventhubProperties` |
| `definitions.NetworkRuleSet.properties.properties.$ref__added` | added | `#/definitions/NetworkRuleSetProperties` |
| `definitions.NetworkSecurityPerimeterConfigurationProperties.properties.profile.$ref__added` | added | `#/definitions/NetworkSecurityPerimeterConfigurationPropertiesProfile` |
| `definitions.NetworkSecurityPerimeterConfigurationProperties.properties.resourceAssociation.$ref__added` | added | `#/definitions/NetworkSecurityPerimeterConfigurationPropertiesResourceAssociation` |
| `definitions.NspAccessRule.properties.properties.$ref__added` | added | `#/definitions/NspAccessRuleProperties` |
| `definitions.ProvisioningIssue.properties.properties.$ref__added` | added | `#/definitions/ProvisioningIssueProperties` |
| `definitions.SchemaGroup.properties.properties.$ref__added` | added | `#/definitions/SchemaGroupProperties` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}'].delete.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/ClusterNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}'].get.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/ClusterNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}'].patch.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/ClusterNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}'].put.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/ClusterNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}/namespaces'].get.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/ClusterNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}/quotaConfiguration/default'].get.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/ClusterNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}/quotaConfiguration/default'].patch.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/ClusterNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}'].delete.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}'].get.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}'].patch.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}'].put.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups'].get.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].delete.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].delete.parameters[1].$ref__deleted` | deleted | `../../../common/v2/definitions.json#/parameters/ApplicationGroupNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].get.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].get.parameters[1].$ref__deleted` | deleted | `../../../common/v2/definitions.json#/parameters/ApplicationGroupNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].put.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].put.parameters[1].$ref__deleted` | deleted | `../../../common/v2/definitions.json#/parameters/ApplicationGroupNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules'].get.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}'].delete.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}'].delete.parameters[1].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/AuthorizationRuleNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}'].get.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}'].get.parameters[1].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/AuthorizationRuleNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}'].put.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[1].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/AuthorizationRuleNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}/regenerateKeys'].post.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs'].get.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].delete.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].delete.parameters[1].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/AliasNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].get.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].get.parameters[1].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/AliasNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].put.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].put.parameters[1].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/AliasNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules'].get.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules'].get.parameters[1].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/AliasNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}'].get.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}'].get.parameters[1].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/AliasNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}'].get.parameters[2].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/AuthorizationRuleNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[1].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/AliasNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[2].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/AuthorizationRuleNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/breakPairing'].post.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/breakPairing'].post.parameters[1].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/AliasNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/failover'].post.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/failover'].post.parameters[1].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/AliasNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/checkNameAvailability'].post.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs'].get.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs'].get.parameters[1].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/SkipParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs'].get.parameters[2].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/TopParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].delete.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].delete.parameters[1].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/EventHubNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].get.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].get.parameters[1].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/EventHubNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].put.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].put.parameters[1].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/EventHubNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules'].get.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules'].get.parameters[1].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/EventHubNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}'].delete.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}'].delete.parameters[1].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/EventHubNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}'].delete.parameters[2].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/AuthorizationRuleNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}'].get.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}'].get.parameters[1].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/EventHubNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}'].get.parameters[2].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/AuthorizationRuleNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}'].put.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[1].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/EventHubNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[2].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/AuthorizationRuleNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}/regenerateKeys'].post.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups'].get.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups'].get.parameters[1].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/EventHubNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups'].get.parameters[2].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/SkipParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups'].get.parameters[3].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/TopParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].delete.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].delete.parameters[1].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/EventHubNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].delete.parameters[2].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/ConsumerGroupNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].get.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].get.parameters[1].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/EventHubNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].get.parameters[2].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/ConsumerGroupNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].put.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].put.parameters[1].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/EventHubNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].put.parameters[2].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/ConsumerGroupNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/failover'].post.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkRuleSets'].get.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkRuleSets/default'].get.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkRuleSets/default'].put.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations'].get.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations/{resourceAssociationName}'].get.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations/{resourceAssociationName}'].get.parameters[1].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/ResourceAssociationNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations/{resourceAssociationName}/reconcile'].post.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations/{resourceAssociationName}/reconcile'].post.parameters[1].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/ResourceAssociationNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections'].get.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.parameters[1].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/PrivateEndpointConnectionNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[1].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/PrivateEndpointConnectionNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateLinkResources'].get.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups'].get.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups'].get.parameters[1].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/SkipParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups'].get.parameters[2].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/TopParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].delete.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].delete.parameters[1].$ref__deleted` | deleted | `../../../common/v2/definitions.json#/parameters/SchemaGroupNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].get.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].get.parameters[1].$ref__deleted` | deleted | `../../../common/v2/definitions.json#/parameters/SchemaGroupNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].put.parameters[0].$ref__deleted` | deleted | `../../../common/v1/definitions.json#/parameters/NamespaceNameParameter` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].put.parameters[1].$ref__deleted` | deleted | `../../../common/v2/definitions.json#/parameters/SchemaGroupNameParameter` |

### Changes for `name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Encryption.properties.keySource['x-ms-enum'].name__deleted` | deleted | `KeySource` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}'].delete.parameters[0].name__added` | added | `clusterName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}'].get.parameters[0].name__added` | added | `clusterName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}'].patch.parameters[0].name__added` | added | `clusterName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}'].put.parameters[0].name__added` | added | `clusterName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}/namespaces'].get.parameters[0].name__added` | added | `clusterName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}/quotaConfiguration/default'].get.parameters[0].name__added` | added | `clusterName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}/quotaConfiguration/default'].patch.parameters[0].name__added` | added | `clusterName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}'].delete.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}'].get.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}'].patch.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}'].put.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups'].get.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].delete.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].delete.parameters[1].name__added` | added | `applicationGroupName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].get.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].get.parameters[1].name__added` | added | `applicationGroupName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].put.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].put.parameters[1].name__added` | added | `applicationGroupName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules'].get.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}'].delete.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}'].delete.parameters[1].name__added` | added | `authorizationRuleName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}'].get.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}'].get.parameters[1].name__added` | added | `authorizationRuleName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}'].put.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[1].name__added` | added | `authorizationRuleName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}/regenerateKeys'].post.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs'].get.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].delete.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].delete.parameters[1].name__added` | added | `alias` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].get.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].get.parameters[1].name__added` | added | `alias` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].put.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].put.parameters[1].name__added` | added | `alias` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules'].get.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules'].get.parameters[1].name__added` | added | `alias` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}'].get.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}'].get.parameters[1].name__added` | added | `alias` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}'].get.parameters[2].name__added` | added | `authorizationRuleName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[1].name__added` | added | `alias` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[2].name__added` | added | `authorizationRuleName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/breakPairing'].post.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/breakPairing'].post.parameters[1].name__added` | added | `alias` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/failover'].post.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/failover'].post.parameters[1].name__added` | added | `alias` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/checkNameAvailability'].post.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs'].get.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs'].get.parameters[1].name__added` | added | `$skip` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs'].get.parameters[2].name__added` | added | `$top` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].delete.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].delete.parameters[1].name__added` | added | `eventHubName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].get.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].get.parameters[1].name__added` | added | `eventHubName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].put.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].put.parameters[1].name__added` | added | `eventHubName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules'].get.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules'].get.parameters[1].name__added` | added | `eventHubName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}'].delete.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}'].delete.parameters[1].name__added` | added | `eventHubName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}'].delete.parameters[2].name__added` | added | `authorizationRuleName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}'].get.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}'].get.parameters[1].name__added` | added | `eventHubName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}'].get.parameters[2].name__added` | added | `authorizationRuleName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}'].put.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[1].name__added` | added | `eventHubName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[2].name__added` | added | `authorizationRuleName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}/regenerateKeys'].post.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups'].get.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups'].get.parameters[1].name__added` | added | `eventHubName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups'].get.parameters[2].name__added` | added | `$skip` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups'].get.parameters[3].name__added` | added | `$top` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].delete.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].delete.parameters[1].name__added` | added | `eventHubName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].delete.parameters[2].name__added` | added | `consumerGroupName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].get.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].get.parameters[1].name__added` | added | `eventHubName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].get.parameters[2].name__added` | added | `consumerGroupName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].put.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].put.parameters[1].name__added` | added | `eventHubName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].put.parameters[2].name__added` | added | `consumerGroupName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/failover'].post.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkRuleSets'].get.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkRuleSets/default'].get.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkRuleSets/default'].put.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations'].get.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations/{resourceAssociationName}'].get.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations/{resourceAssociationName}'].get.parameters[1].name__added` | added | `resourceAssociationName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations/{resourceAssociationName}/reconcile'].post.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations/{resourceAssociationName}/reconcile'].post.parameters[1].name__added` | added | `resourceAssociationName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections'].get.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.parameters[1].name__added` | added | `privateEndpointConnectionName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[1].name__added` | added | `privateEndpointConnectionName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateLinkResources'].get.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups'].get.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups'].get.parameters[1].name__added` | added | `$skip` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups'].get.parameters[2].name__added` | added | `$top` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].delete.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].delete.parameters[1].name__added` | added | `schemaGroupName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].get.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].get.parameters[1].name__added` | added | `schemaGroupName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].put.parameters[0].name__added` | added | `namespaceName` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].put.parameters[1].name__added` | added | `schemaGroupName` |

### Changes for `in`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}'].delete.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}'].patch.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}'].put.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}/namespaces'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}/quotaConfiguration/default'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}/quotaConfiguration/default'].patch.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}'].delete.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}'].patch.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}'].put.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].delete.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].delete.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].get.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].put.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].put.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}'].delete.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}'].delete.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}'].get.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}'].put.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}/regenerateKeys'].post.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].delete.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].delete.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].get.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].put.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].put.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules'].get.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}'].get.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}'].get.parameters[2].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[2].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/breakPairing'].post.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/breakPairing'].post.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/failover'].post.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/failover'].post.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/checkNameAvailability'].post.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs'].get.parameters[1].in__added` | added | `query` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs'].get.parameters[2].in__added` | added | `query` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].delete.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].delete.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].get.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].put.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].put.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules'].get.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}'].delete.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}'].delete.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}'].delete.parameters[2].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}'].get.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}'].get.parameters[2].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}'].put.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[2].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}/regenerateKeys'].post.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups'].get.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups'].get.parameters[2].in__added` | added | `query` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups'].get.parameters[3].in__added` | added | `query` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].delete.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].delete.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].delete.parameters[2].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].get.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].get.parameters[2].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].put.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].put.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].put.parameters[2].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/failover'].post.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkRuleSets'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkRuleSets/default'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkRuleSets/default'].put.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations/{resourceAssociationName}'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations/{resourceAssociationName}'].get.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations/{resourceAssociationName}/reconcile'].post.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations/{resourceAssociationName}/reconcile'].post.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateLinkResources'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups'].get.parameters[1].in__added` | added | `query` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups'].get.parameters[2].in__added` | added | `query` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].delete.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].delete.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].get.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].get.parameters[1].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].put.parameters[0].in__added` | added | `path` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].put.parameters[1].in__added` | added | `path` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGroup.properties.properties.required__deleted` | deleted | `["clientAppGroupIdentifier"]` |
| `definitions.ApplicationGroupListResult.required__added` | added | `["value"]` |
| `definitions.ArmDisasterRecoveryListResult.required__added` | added | `["value"]` |
| `definitions.AuthorizationRule.properties.properties.required__deleted` | deleted | `["rights"]` |
| `definitions.AuthorizationRuleListResult.required__added` | added | `["value"]` |
| `definitions.ClusterListResult.required__added` | added | `["value"]` |
| `definitions.ConsumerGroupListResult.required__added` | added | `["value"]` |
| `definitions.EHNamespaceListResult.required__added` | added | `["value"]` |
| `definitions.NetworkRuleSetListResult.required__added` | added | `["value"]` |
| `definitions.PrivateEndpointConnectionListResult.required__added` | added | `["value"]` |
| `definitions.SchemaGroupListResult.required__added` | added | `["value"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}'].delete.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}'].patch.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}'].put.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}'].put.parameters[1].schema.required__deleted` | deleted | `["location"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}/namespaces'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}/quotaConfiguration/default'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}/quotaConfiguration/default'].patch.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}/quotaConfiguration/default'].patch.parameters[1].schema.required__deleted` | deleted | `["settings"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}'].delete.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}'].patch.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}'].put.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}'].put.parameters[1].schema.required__deleted` | deleted | `["location"]` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].delete.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].delete.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].get.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].put.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].put.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}'].delete.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}'].delete.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}'].get.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}'].put.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}/regenerateKeys'].post.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].delete.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].delete.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].get.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].put.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].put.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules'].get.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}'].get.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}'].get.parameters[2].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[2].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/breakPairing'].post.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/breakPairing'].post.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/failover'].post.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/failover'].post.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/checkNameAvailability'].post.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].delete.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].delete.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].get.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].put.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].put.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules'].get.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}'].delete.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}'].delete.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}'].delete.parameters[2].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}'].get.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}'].get.parameters[2].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}'].put.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[2].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}/regenerateKeys'].post.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups'].get.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].delete.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].delete.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].delete.parameters[2].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].get.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].get.parameters[2].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].put.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].put.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].put.parameters[2].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/failover'].post.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkRuleSets'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkRuleSets/default'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkRuleSets/default'].put.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations/{resourceAssociationName}'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations/{resourceAssociationName}'].get.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations/{resourceAssociationName}/reconcile'].post.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations/{resourceAssociationName}/reconcile'].post.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateLinkResources'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].delete.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].delete.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].get.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].get.parameters[1].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].put.parameters[0].required__added` | added | `true` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].put.parameters[1].required__added` | added | `true` |

### Changes for `type`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGroup.properties.properties.type__deleted` | deleted | `object` |
| `definitions.ArmDisasterRecovery.properties.properties.type__deleted` | deleted | `object` |
| `definitions.AuthorizationRule.properties.properties.type__deleted` | deleted | `object` |
| `definitions.Cluster.properties.properties.type__deleted` | deleted | `object` |
| `definitions.ConsumerGroup.properties.properties.type__deleted` | deleted | `object` |
| `definitions.Destination.properties.properties.type__deleted` | deleted | `object` |
| `definitions.EHNamespace.properties.properties.type__deleted` | deleted | `object` |
| `definitions.Eventhub.properties.properties.type__deleted` | deleted | `object` |
| `definitions.NetworkRuleSet.properties.properties.type__deleted` | deleted | `object` |
| `definitions.NetworkSecurityPerimeterConfigurationProperties.properties.profile.type__deleted` | deleted | `object` |
| `definitions.NetworkSecurityPerimeterConfigurationProperties.properties.resourceAssociation.type__deleted` | deleted | `object` |
| `definitions.NspAccessRule.properties.properties.type__deleted` | deleted | `object` |
| `definitions.ProvisioningIssue.properties.properties.type__deleted` | deleted | `object` |
| `definitions.SchemaGroup.properties.properties.type__deleted` | deleted | `object` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}'].delete.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}'].patch.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}'].put.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}/namespaces'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}/quotaConfiguration/default'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}/quotaConfiguration/default'].patch.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}'].delete.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}'].patch.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}'].put.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].delete.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].delete.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].get.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].put.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].put.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}'].delete.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}'].delete.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}'].get.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}'].put.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}/regenerateKeys'].post.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].delete.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].delete.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].get.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].put.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].put.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules'].get.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}'].get.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}'].get.parameters[2].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[2].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/breakPairing'].post.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/breakPairing'].post.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/failover'].post.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/failover'].post.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/checkNameAvailability'].post.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs'].get.parameters[1].type__added` | added | `integer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs'].get.parameters[2].type__added` | added | `integer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].delete.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].delete.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].get.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].put.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].put.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules'].get.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}'].delete.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}'].delete.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}'].delete.parameters[2].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}'].get.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}'].get.parameters[2].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}'].put.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[2].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}/regenerateKeys'].post.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups'].get.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups'].get.parameters[2].type__added` | added | `integer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups'].get.parameters[3].type__added` | added | `integer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].delete.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].delete.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].delete.parameters[2].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].get.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].get.parameters[2].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].put.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].put.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].put.parameters[2].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/failover'].post.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkRuleSets'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkRuleSets/default'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkRuleSets/default'].put.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations/{resourceAssociationName}'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations/{resourceAssociationName}'].get.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations/{resourceAssociationName}/reconcile'].post.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations/{resourceAssociationName}/reconcile'].post.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateLinkResources'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups'].get.parameters[1].type__added` | added | `integer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups'].get.parameters[2].type__added` | added | `integer` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].delete.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].delete.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].get.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].get.parameters[1].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].put.parameters[0].type__added` | added | `string` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].put.parameters[1].type__added` | added | `string` |

### Changes for `minLength`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}'].delete.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}'].get.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}'].patch.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}'].put.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}/namespaces'].get.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}/quotaConfiguration/default'].get.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}/quotaConfiguration/default'].patch.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}'].delete.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}'].get.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}'].patch.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}'].put.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups'].get.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].delete.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].delete.parameters[1].minLength__added` | added | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].get.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].get.parameters[1].minLength__added` | added | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].put.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].put.parameters[1].minLength__added` | added | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs'].get.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].delete.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].delete.parameters[1].minLength__added` | added | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].get.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].get.parameters[1].minLength__added` | added | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].put.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].put.parameters[1].minLength__added` | added | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/breakPairing'].post.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/breakPairing'].post.parameters[1].minLength__added` | added | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/failover'].post.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/failover'].post.parameters[1].minLength__added` | added | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/checkNameAvailability'].post.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs'].get.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].delete.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].delete.parameters[1].minLength__added` | added | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].get.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].get.parameters[1].minLength__added` | added | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].put.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].put.parameters[1].minLength__added` | added | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups'].get.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups'].get.parameters[1].minLength__added` | added | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].delete.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].delete.parameters[1].minLength__added` | added | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].delete.parameters[2].minLength__added` | added | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].get.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].get.parameters[1].minLength__added` | added | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].get.parameters[2].minLength__added` | added | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].put.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].put.parameters[1].minLength__added` | added | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].put.parameters[2].minLength__added` | added | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/failover'].post.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkRuleSets'].get.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkRuleSets/default'].get.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkRuleSets/default'].put.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations'].get.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations/{resourceAssociationName}'].get.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations/{resourceAssociationName}/reconcile'].post.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections'].get.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateLinkResources'].get.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups'].get.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].delete.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].delete.parameters[1].minLength__added` | added | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].get.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].get.parameters[1].minLength__added` | added | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].put.parameters[0].minLength__added` | added | `6` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].put.parameters[1].minLength__added` | added | `1` |

### Changes for `maxLength`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}'].delete.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}'].get.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}'].patch.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}'].put.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}/namespaces'].get.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}/quotaConfiguration/default'].get.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}/quotaConfiguration/default'].patch.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}'].delete.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}'].get.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}'].patch.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}'].put.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups'].get.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].delete.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].delete.parameters[1].maxLength__added` | added | `256` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].get.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].get.parameters[1].maxLength__added` | added | `256` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].put.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].put.parameters[1].maxLength__added` | added | `256` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs'].get.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].delete.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].delete.parameters[1].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].get.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].get.parameters[1].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].put.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].put.parameters[1].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/breakPairing'].post.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/breakPairing'].post.parameters[1].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/failover'].post.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/failover'].post.parameters[1].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/checkNameAvailability'].post.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs'].get.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].delete.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].delete.parameters[1].maxLength__added` | added | `256` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].get.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].get.parameters[1].maxLength__added` | added | `256` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].put.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].put.parameters[1].maxLength__added` | added | `256` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups'].get.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups'].get.parameters[1].maxLength__added` | added | `256` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].delete.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].delete.parameters[1].maxLength__added` | added | `256` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].delete.parameters[2].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].get.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].get.parameters[1].maxLength__added` | added | `256` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].get.parameters[2].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].put.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].put.parameters[1].maxLength__added` | added | `256` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].put.parameters[2].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/failover'].post.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkRuleSets'].get.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkRuleSets/default'].get.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkRuleSets/default'].put.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations'].get.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations/{resourceAssociationName}'].get.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations/{resourceAssociationName}/reconcile'].post.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections'].get.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateLinkResources'].get.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups'].get.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].delete.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].delete.parameters[1].maxLength__added` | added | `256` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].get.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].get.parameters[1].maxLength__added` | added | `256` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].put.parameters[0].maxLength__added` | added | `50` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].put.parameters[1].maxLength__added` | added | `256` |

### Changes for `headers`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}'].delete.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}'].patch.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}'].put.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}'].delete.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}'].put.responses.202.headers__added` | added | `{"Location":{"type":"string","description":"The Location header contains the URL where the status of...` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations/{resourceAssociationName}/reconcile'].post.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.responses.202.headers__added` | added | `{"Azure-AsyncOperation":{"type":"string","description":"A link to the status monitor"}}` |

### Changes for `pattern`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}'].delete.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}'].get.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}'].patch.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}'].put.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups'].get.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].delete.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].get.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].put.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules'].get.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}'].delete.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}'].get.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}'].put.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}/regenerateKeys'].post.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs'].get.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].delete.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].get.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].put.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules'].get.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}'].get.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/breakPairing'].post.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/failover'].post.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/checkNameAvailability'].post.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs'].get.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].delete.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].get.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].put.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules'].get.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}'].delete.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}'].get.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}'].put.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}/listKeys'].post.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}/regenerateKeys'].post.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups'].get.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].delete.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].get.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].put.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/failover'].post.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkRuleSets'].get.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkRuleSets/default'].get.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkRuleSets/default'].put.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations'].get.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations/{resourceAssociationName}'].get.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations/{resourceAssociationName}/reconcile'].post.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections'].get.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateLinkResources'].get.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups'].get.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].delete.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].get.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].put.parameters[0].pattern__added` | added | `^[a-zA-Z][a-zA-Z0-9-]{6,50}[a-zA-Z0-9]$` |

### Changes for `x-ms-long-running-operation-options`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}'].put['x-ms-long-running-operation-options__deleted']` | deleted | `{"final-state-via":"azure-async-operation"}` |

### Changes for `x-ms-long-running-operation`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}'].put['x-ms-long-running-operation__deleted']` | deleted | `true` |

### Changes for `x-ms-azure-resource`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].put['x-ms-azure-resource__deleted']` | deleted | `true` |

### Changes for `format`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs'].get.parameters[1].format__added` | added | `int32` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs'].get.parameters[2].format__added` | added | `int32` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups'].get.parameters[2].format__added` | added | `int32` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups'].get.parameters[3].format__added` | added | `int32` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups'].get.parameters[1].format__added` | added | `int32` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups'].get.parameters[2].format__added` | added | `int32` |

### Changes for `maximum`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs'].get.parameters[1].maximum__added` | added | `1000` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs'].get.parameters[2].maximum__added` | added | `1000` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups'].get.parameters[2].maximum__added` | added | `1000` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups'].get.parameters[3].maximum__added` | added | `1000` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups'].get.parameters[1].maximum__added` | added | `1000` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups'].get.parameters[2].maximum__added` | added | `1000` |

### Changes for `minimum`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Sku.properties.capacity.minimum__deleted` | deleted | `0` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs'].get.parameters[2].minimum__added` | added | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups'].get.parameters[3].minimum__added` | added | `1` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups'].get.parameters[2].minimum__added` | added | `1` |

### Changes for `azure-AsyncOperation`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/failover'].post.responses.202.headers['azure-AsyncOperation__deleted']` | deleted | `{"type":"string","description":"URI to poll for completion status."}` |

### Changes for `location`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/failover'].post.responses.202.headers.location__deleted` | deleted | `{"type":"string","description":"URI to poll for completion status."}` |

### Changes for `Azure-AsyncOperation`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/failover'].post.responses.202.headers['Azure-AsyncOperation__added']` | added | `{"type":"string","description":"A link to the status monitor"}` |

### Changes for `200`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/failover'].post.responses.200__added` | added | `{"description":"ignore","schema":{"$ref":"#/definitions/FailOver"}}` |

### Changes for `x-ms-pageable`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkRuleSets'].get['x-ms-pageable__added']` | added | `{"nextLinkName":"nextLink"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateLinkResources'].get['x-ms-pageable__added']` | added | `{"nextLinkName":"nextLink"}` |

### Changes for `externalDocs`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections'].get.externalDocs__deleted` | deleted | `{"url":"https://msdn.microsoft.com/en-us/library/azure/mt639412.aspx"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.externalDocs__deleted` | deleted | `{"url":"https://msdn.microsoft.com/en-us/library/azure/mt639389.aspx"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.externalDocs__deleted` | deleted | `{"url":"https://msdn.microsoft.com/en-us/library/azure/mt639379.aspx"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.externalDocs__deleted` | deleted | `{"url":"https://msdn.microsoft.com/en-us/library/azure/mt639408.aspx"}` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateLinkResources'].get.externalDocs__deleted` | deleted | `{"url":"https://msdn.microsoft.com/en-us/library/azure/mt639379.aspx"}` |

### Changes for `EventHubListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EventHubListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `Operation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Operation__deleted` | deleted | `{"type":"object","properties":{"name":{"type":"string","readOnly":true},"isDataAction":{"type":"bool...` |

### Changes for `OperationDisplay`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationDisplay__deleted` | deleted | `{"type":"object","properties":{"provider":{"type":"string","readOnly":true},"resource":{"type":"stri...` |

### Changes for `OperationListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.OperationListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `PrivateLinkResourcesListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PrivateLinkResourcesListResult__deleted` | deleted | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `userAssignedIdentityProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.userAssignedIdentityProperties__deleted` | deleted | `{"type":"object","properties":{"userAssignedIdentity":{"type":"string"}},"x-ms-client-flatten":true}` |

### Changes for `ApplicationGroupProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGroupProperties__added` | added | `{"type":"object","properties":{"isEnabled":{"type":"boolean"},"clientAppGroupIdentifier":{"type":"st...` |

### Changes for `ArmDisasterRecoveryProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ArmDisasterRecoveryProperties__added` | added | `{"type":"object","properties":{"provisioningState":{"type":"string","enum":["Accepted","Succeeded","...` |

### Changes for `AuthorizationRuleProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.AuthorizationRuleProperties__added` | added | `{"type":"object","properties":{"rights":{"type":"array","items":{"type":"string","enum":["Manage","S...` |

### Changes for `ClusterProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ClusterProperties__added` | added | `{"type":"object","properties":{"createdAt":{"type":"string","readOnly":true},"provisioningState":{"t...` |

### Changes for `ConsumerGroupProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConsumerGroupProperties__added` | added | `{"type":"object","properties":{"createdAt":{"type":"string","format":"date-time","readOnly":true},"u...` |

### Changes for `DestinationProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DestinationProperties__added` | added | `{"type":"object","properties":{"storageAccountResourceId":{"type":"string"},"blobContainer":{"type":...` |

### Changes for `EHNamespaceProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EHNamespaceProperties__added` | added | `{"type":"object","properties":{"minimumTlsVersion":{"type":"string","enum":["1.0","1.1","1.2","1.3"]...` |

### Changes for `ErrorAdditionalInfo`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ErrorAdditionalInfo__added` | added | `{"type":"object","properties":{"type":{"type":"string","readOnly":true},"info":{"readOnly":true}}}` |

### Changes for `ErrorDetail`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ErrorDetail__added` | added | `{"type":"object","properties":{"code":{"type":"string","readOnly":true},"message":{"type":"string","...` |

### Changes for `ErrorResponse`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ErrorResponse__added` | added | `{"type":"object","properties":{"error":{"$ref":"#/definitions/ErrorDetail"}}}` |

### Changes for `EventhubListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EventhubListResult__added` | added | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `EventhubProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.EventhubProperties__added` | added | `{"type":"object","properties":{"partitionIds":{"type":"array","items":{"type":"string"},"readOnly":t...` |

### Changes for `NetworkRuleSetProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkRuleSetProperties__added` | added | `{"type":"object","properties":{"trustedServiceAccessEnabled":{"type":"boolean"},"defaultAction":{"ty...` |

### Changes for `NetworkSecurityPerimeterConfigurationPropertiesProfile`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkSecurityPerimeterConfigurationPropertiesProfile__added` | added | `{"type":"object","properties":{"name":{"type":"string"},"accessRulesVersion":{"type":"string"},"acce...` |

### Changes for `NetworkSecurityPerimeterConfigurationPropertiesResourceAssociation`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkSecurityPerimeterConfigurationPropertiesResourceAssociation__added` | added | `{"type":"object","properties":{"name":{"type":"string"},"accessMode":{"type":"string","enum":["NoAss...` |

### Changes for `NspAccessRuleProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NspAccessRuleProperties__added` | added | `{"type":"object","properties":{"direction":{"type":"string","enum":["Inbound","Outbound"],"x-ms-enum...` |

### Changes for `NspAccessRulePropertiesSubscriptionsItem`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NspAccessRulePropertiesSubscriptionsItem__added` | added | `{"type":"object","properties":{"id":{"type":"string"}}}` |

### Changes for `PrivateLinkResourceListResult`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.PrivateLinkResourceListResult__added` | added | `{"type":"object","description":"[Placeholder] Discription for page model","properties":{"value":{"ty...` |

### Changes for `ProvisioningIssueProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ProvisioningIssueProperties__added` | added | `{"type":"object","properties":{"issueType":{"type":"string"},"description":{"type":"string"}}}` |

### Changes for `SchemaGroupProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.SchemaGroupProperties__added` | added | `{"type":"object","properties":{"updatedAtUtc":{"type":"string","format":"date-time","readOnly":true}...` |

### Changes for `TrackedResource`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.TrackedResource__added` | added | `{"type":"object","properties":{"tags":{"type":"object","additionalProperties":{"type":"string"}},"lo...` |

### Changes for `UserAssignedIdentityProperties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.UserAssignedIdentityProperties__added` | added | `{"type":"object","properties":{"userAssignedIdentity":{"type":"string"}}}` |

### Changes for `systemData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGroup.properties.systemData__deleted` | deleted | `{"$ref":"../../../common/v1/definitions.json#/definitions/systemData","readOnly":true}` |
| `definitions.ArmDisasterRecovery.properties.systemData__deleted` | deleted | `{"$ref":"../../../common/v1/definitions.json#/definitions/systemData","readOnly":true}` |
| `definitions.AuthorizationRule.properties.systemData__deleted` | deleted | `{"$ref":"../../../common/v1/definitions.json#/definitions/systemData","readOnly":true}` |
| `definitions.Cluster.properties.systemData__deleted` | deleted | `{"$ref":"../../../common/v1/definitions.json#/definitions/systemData","readOnly":true}` |
| `definitions.ConsumerGroup.properties.systemData__deleted` | deleted | `{"$ref":"../../../common/v1/definitions.json#/definitions/systemData","readOnly":true}` |
| `definitions.EHNamespace.properties.systemData__deleted` | deleted | `{"$ref":"../../../common/v1/definitions.json#/definitions/systemData","readOnly":true}` |
| `definitions.Eventhub.properties.systemData__deleted` | deleted | `{"$ref":"../../../common/v1/definitions.json#/definitions/systemData","readOnly":true}` |
| `definitions.NetworkRuleSet.properties.systemData__deleted` | deleted | `{"$ref":"../../../common/v1/definitions.json#/definitions/systemData","readOnly":true}` |
| `definitions.PrivateEndpointConnection.properties.systemData__deleted` | deleted | `{"$ref":"../../../common/v1/definitions.json#/definitions/systemData","readOnly":true}` |
| `definitions.SchemaGroup.properties.systemData__deleted` | deleted | `{"$ref":"../../../common/v1/definitions.json#/definitions/systemData","readOnly":true}` |

### Changes for `properties`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ApplicationGroup.properties.properties.properties__deleted` | deleted | `{"isEnabled":{"type":"boolean","description":"Determines if Application Group is allowed to create c...` |
| `definitions.ArmDisasterRecovery.properties.properties.properties__deleted` | deleted | `{"provisioningState":{"type":"string","description":"Provisioning state of the Alias(Disaster Recove...` |
| `definitions.AuthorizationRule.properties.properties.properties__deleted` | deleted | `{"rights":{"type":"array","description":"The rights associated with the rule.","items":{"type":"stri...` |
| `definitions.Cluster.properties.properties.properties__deleted` | deleted | `{"createdAt":{"type":"string","description":"The UTC time when the Event Hubs Cluster was created.",...` |
| `definitions.ConsumerGroup.properties.properties.properties__deleted` | deleted | `{"createdAt":{"type":"string","format":"date-time","description":"Exact time the message was created...` |
| `definitions.Destination.properties.properties.properties__deleted` | deleted | `{"storageAccountResourceId":{"type":"string","description":"Resource id of the storage account to be...` |
| `definitions.EHNamespace.properties.properties.properties__deleted` | deleted | `{"minimumTlsVersion":{"type":"string","description":"The minimum TLS version for the cluster to supp...` |
| `definitions.Eventhub.properties.properties.properties__deleted` | deleted | `{"partitionIds":{"type":"array","description":"Current number of shards on the Event Hub.","items":{...` |
| `definitions.NetworkRuleSet.properties.properties.properties__deleted` | deleted | `{"trustedServiceAccessEnabled":{"type":"boolean","description":"Value that indicates whether Trusted...` |
| `definitions.NetworkSecurityPerimeterConfigurationProperties.properties.profile.properties__deleted` | deleted | `{"name":{"type":"string","description":"Name of the resource"},"accessRulesVersion":{"type":"string"...` |
| `definitions.NetworkSecurityPerimeterConfigurationProperties.properties.resourceAssociation.properties__deleted` | deleted | `{"name":{"type":"string","description":"Name of the resource association"},"accessMode":{"type":"str...` |
| `definitions.NspAccessRule.properties.properties.properties__deleted` | deleted | `{"direction":{"type":"string","description":"Direction of Access Rule","enum":["Inbound","Outbound"]...` |
| `definitions.ProvisioningIssue.properties.properties.properties__deleted` | deleted | `{"issueType":{"type":"string","description":"Type of Issue"},"description":{"type":"string","descrip...` |
| `definitions.SchemaGroup.properties.properties.properties__deleted` | deleted | `{"updatedAtUtc":{"type":"string","format":"date-time","description":"Exact time the Schema Group was...` |

### Changes for `x-ms-client-flatten`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ConfidentialCompute['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.Encryption['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.Identity['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.NWRuleSetIpRules['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.NWRuleSetVirtualNetworkRules['x-ms-client-flatten__deleted']` | deleted | `true` |
| `definitions.PlatformCapabilities['x-ms-client-flatten__deleted']` | deleted | `true` |

### Changes for `x-ms-client-name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.Encryption.properties.keyVaultProperties['x-ms-client-name__deleted']` | deleted | `KeyVaultProperties` |
| `definitions.KeyVaultProperties.properties.keyName['x-ms-client-name__deleted']` | deleted | `KeyName` |
| `definitions.KeyVaultProperties.properties.keyVaultUri['x-ms-client-name__deleted']` | deleted | `KeyVaultUri` |
| `definitions.KeyVaultProperties.properties.keyVersion['x-ms-client-name__deleted']` | deleted | `KeyVersion` |
| `definitions.UserAssignedIdentity.properties.clientId['x-ms-client-name__deleted']` | deleted | `ClientId` |
| `definitions.UserAssignedIdentity.properties.principalId['x-ms-client-name__deleted']` | deleted | `PrincipalId` |

### Changes for `readOnly`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.NetworkSecurityPerimeter.readOnly__deleted` | deleted | `true` |
| `definitions.NetworkSecurityPerimeterConfiguration.readOnly__deleted` | deleted | `true` |
| `definitions.NetworkSecurityPerimeterConfigurationProperties.properties.networkSecurityPerimeter.readOnly__added` | added | `true` |
| `definitions.NetworkSecurityPerimeterConfigurationProperties.readOnly__deleted` | deleted | `true` |
| `definitions.NspAccessRule.readOnly__deleted` | deleted | `true` |
| `definitions.ProvisioningIssue.readOnly__deleted` | deleted | `true` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `definitions.ApplicationGroup.allOf[0].$ref` | `../../../common/v2/definitions.json#/definitions/ProxyResource` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.ArmDisasterRecovery.allOf[0].$ref` | `../../../common/v2/definitions.json#/definitions/ProxyResource` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.AuthorizationRule.allOf[0].$ref` | `../../../common/v2/definitions.json#/definitions/ProxyResource` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.Cluster.allOf[0].$ref` | `../../../common/v1/definitions.json#/definitions/TrackedResource` | `#/definitions/TrackedResource` |
| `definitions.ConsumerGroup.allOf[0].$ref` | `../../../common/v2/definitions.json#/definitions/ProxyResource` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.EHNamespace.allOf[0].$ref` | `../../../common/v1/definitions.json#/definitions/TrackedResource` | `#/definitions/TrackedResource` |
| `definitions.Eventhub.allOf[0].$ref` | `../../../common/v2/definitions.json#/definitions/ProxyResource` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.KeyVaultProperties.properties.identity.$ref` | `#/definitions/userAssignedIdentityProperties` | `#/definitions/UserAssignedIdentityProperties` |
| `definitions.NetworkRuleSet.allOf[0].$ref` | `../../../common/v2/definitions.json#/definitions/ProxyResource` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.NetworkSecurityPerimeterConfiguration.allOf[0].$ref` | `../../../common/v2/definitions.json#/definitions/ProxyResource` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.PrivateEndpointConnection.allOf[0].$ref` | `../../../common/v2/definitions.json#/definitions/ProxyResource` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `definitions.SchemaGroup.allOf[0].$ref` | `../../../common/v2/definitions.json#/definitions/ProxyResource` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ProxyResource` |
| `paths['/providers/microsoft.EventHub/operations'].get.responses.200.schema.$ref` | `#/definitions/OperationListResult` | `../../../../../common-types/resource-management/v3/types.json#/definitions/OperationListResult` |
| `paths['/providers/microsoft.EventHub/operations'].get.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.EventHub/availableClusterRegions'].get.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.EventHub/checkNameAvailability'].post.parameters[0].name` | `parameters` | `body` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.EventHub/checkNameAvailability'].post.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.EventHub/clusters'].get.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/microsoft.EventHub/namespaces'].get.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters'].get.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}'].delete.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}'].get.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}'].patch.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}'].put.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}/namespaces'].get.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}/quotaConfiguration/default'].get.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/clusters/{clusterName}/quotaConfiguration/default'].patch.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces'].get.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}'].delete.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}'].get.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}'].patch.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}'].put.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups'].get.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].delete.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].get.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/applicationGroups/{applicationGroupName}'].put.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules'].get.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}'].delete.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}'].get.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}'].put.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}/listKeys'].post.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/authorizationRules/{authorizationRuleName}/regenerateKeys'].post.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs'].get.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].delete.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].get.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}'].put.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules'].get.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}'].get.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/authorizationRules/{authorizationRuleName}/listKeys'].post.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/breakPairing'].post.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/{alias}/failover'].post.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/disasterRecoveryConfigs/checkNameAvailability'].post.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs'].get.responses.200.schema.$ref` | `#/definitions/EventHubListResult` | `#/definitions/EventhubListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs'].get.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].delete.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].get.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}'].put.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules'].get.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}'].delete.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}'].get.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}'].put.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}/listKeys'].post.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/authorizationRules/{authorizationRuleName}/regenerateKeys'].post.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups'].get.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].delete.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].get.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/eventhubs/{eventHubName}/consumergroups/{consumerGroupName}'].put.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/failover'].post.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkRuleSets'].get.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkRuleSets/default'].get.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkRuleSets/default'].put.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations'].get.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations/{resourceAssociationName}'].get.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations/{resourceAssociationName}/reconcile'].post.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections'].get.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].delete.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].get.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateEndpointConnections/{privateEndpointConnectionName}'].put.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateLinkResources'].get.responses.200.schema.$ref` | `#/definitions/PrivateLinkResourcesListResult` | `#/definitions/PrivateLinkResourceListResult` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/privateLinkResources'].get.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups'].get.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].delete.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].get.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventHub/namespaces/{namespaceName}/schemagroups/{schemaGroupName}'].put.responses.default.schema.$ref` | `../../../common/v2/definitions.json#/definitions/ErrorResponse` | `../../../../../common-types/resource-management/v3/types.json#/definitions/ErrorResponse` |

