import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.EventHub;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(FailOver.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateLinkResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Operation.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Destination.properties);

@@clientName(Clusters.createOrUpdate::parameters.resource, "parameters");
@@clientName(Clusters.update::parameters.properties, "parameters");
@@clientLocation(Clusters.patch, "Configuration");
@@clientName(Clusters.patch::parameters.body, "parameters");
@@clientLocation(Clusters.configurationGet, "Configuration");
@@clientName(Clusters.configurationGet, "Get");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Cluster.properties);

@@clientLocation(EHNamespaces.get, "Namespaces");
@@clientLocation(EHNamespaces.createOrUpdate, "Namespaces");
@@clientName(EHNamespaces.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(EHNamespaces.update, "Namespaces");
@@clientName(EHNamespaces.update::parameters.properties, "parameters");
@@clientLocation(EHNamespaces.delete, "Namespaces");
@@clientLocation(EHNamespaces.listByResourceGroup, "Namespaces");
@@clientLocation(EHNamespaces.list, "Namespaces");
@@clientLocation(EHNamespaces.failover, "Namespaces");
@@clientName(EHNamespaces.failover::parameters.body, "parameters");
@@clientLocation(EHNamespaces.privateLinkResourcesGet, "PrivateLinkResources");
@@clientName(EHNamespaces.privateLinkResourcesGet, "Get");
@@clientLocation(EHNamespaces.checkNameAvailability, DisasterRecoveryConfigs);
@@clientName(EHNamespaces.checkNameAvailability::parameters.body, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(EHNamespace.properties);

@@clientName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateEndpointConnection.properties);

@@clientLocation(NetworkSecurityPerimeterConfigurations.list,
  "NetworkSecurityPerimeterConfiguration"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NetworkSecurityPerimeterConfiguration.properties);

@@clientLocation(NetworkRuleSets.getNetworkRuleSet, "Namespaces");
@@clientLocation(NetworkRuleSets.createOrUpdateNetworkRuleSet, "Namespaces");
@@clientName(NetworkRuleSets.createOrUpdateNetworkRuleSet::parameters.resource,
  "parameters"
);
@@clientLocation(NetworkRuleSets.listNetworkRuleSet, "Namespaces");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NetworkRuleSet.properties);

@@clientLocation(AuthorizationRules.getAuthorizationRule, "Namespaces");
@@clientLocation(AuthorizationRules.createOrUpdateAuthorizationRule,
  "Namespaces"
);
@@clientName(AuthorizationRules.createOrUpdateAuthorizationRule::parameters.resource,
  "parameters"
);
@@clientLocation(AuthorizationRules.deleteAuthorizationRule, "Namespaces");
@@clientLocation(AuthorizationRules.listAuthorizationRules, "Namespaces");
@@clientLocation(AuthorizationRules.listKeys, "Namespaces");
@@clientLocation(AuthorizationRules.regenerateKeys, "Namespaces");
@@clientName(AuthorizationRules.regenerateKeys::parameters.body, "parameters");
@@clientName(EventHubs.createOrUpdateAuthorizationRule::parameters.resource,
  "parameters"
);
@@clientName(EventHubs.regenerateKeys::parameters.body, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AuthorizationRule.properties);

@@clientName(ConsumerGroups.createOrUpdate::parameters.resource, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ConsumerGroup.properties);

@@clientLocation(ArmDisasterRecoveries.get, DisasterRecoveryConfigs);
@@clientLocation(ArmDisasterRecoveries.createOrUpdate, DisasterRecoveryConfigs);
@@clientName(ArmDisasterRecoveries.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(ArmDisasterRecoveries.delete, DisasterRecoveryConfigs);
@@clientLocation(ArmDisasterRecoveries.list, DisasterRecoveryConfigs);
@@clientLocation(ArmDisasterRecoveries.breakPairing, DisasterRecoveryConfigs);
@@clientLocation(ArmDisasterRecoveries.failOver, DisasterRecoveryConfigs);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ArmDisasterRecovery.properties);

@@clientLocation(Eventhubs.get, EventHubs);
@@clientLocation(Eventhubs.createOrUpdate, EventHubs);
@@clientName(Eventhubs.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(Eventhubs.delete, EventHubs);
@@clientLocation(Eventhubs.listByNamespace, EventHubs);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Eventhub.properties);

@@clientLocation(SchemaGroups.get, "SchemaRegistry");
@@clientLocation(SchemaGroups.createOrUpdate, "SchemaRegistry");
@@clientName(SchemaGroups.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(SchemaGroups.delete, "SchemaRegistry");
@@clientLocation(SchemaGroups.listByNamespace, "SchemaRegistry");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SchemaGroup.properties);

@@clientLocation(ApplicationGroups.get, "ApplicationGroup");
@@clientLocation(ApplicationGroups.createOrUpdateApplicationGroup,
  "ApplicationGroup"
);
@@clientName(ApplicationGroups.createOrUpdateApplicationGroup::parameters.resource,
  "parameters"
);
@@clientLocation(ApplicationGroups.delete, "ApplicationGroup");
@@clientLocation(ApplicationGroups.listByNamespace, "ApplicationGroup");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ApplicationGroup.properties);

@@clientLocation(ClustersOperationGroup.listAvailableClusterRegion, Clusters);

@@clientLocation(NamespacesOperationGroup.checkNameAvailability, "Namespaces");
