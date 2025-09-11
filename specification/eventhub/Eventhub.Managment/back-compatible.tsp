import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.EventHub;

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(FailOver.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(PrivateLinkResource.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Operation.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Destination.properties);

@@clientName(Clusters.createOrUpdate::parameters.resource, "parameters");
@@clientName(Clusters.update::parameters.properties, "parameters");
@@clientLocation(Clusters.patch, "Configuration");
@@clientName(Clusters.patch::parameters.body, "parameters");
@@clientLocation(Clusters.configurationGet, "Configuration");
@@clientName(Clusters.configurationGet, "Get");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(EHNamespace.properties);

@@clientName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(PrivateEndpointConnection.properties);

@@clientLocation(NetworkSecurityPerimeterConfigurations.list,
  "NetworkSecurityPerimeterConfiguration"
);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(NetworkSecurityPerimeterConfiguration.properties);

@@clientLocation(NetworkRuleSets.getNetworkRuleSet, "Namespaces");
@@clientLocation(NetworkRuleSets.createOrUpdateNetworkRuleSet, "Namespaces");
@@clientName(NetworkRuleSets.createOrUpdateNetworkRuleSet::parameters.resource,
  "parameters"
);
@@clientLocation(NetworkRuleSets.listNetworkRuleSet, "Namespaces");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AuthorizationRule.properties);

@@clientName(ConsumerGroups.createOrUpdate::parameters.resource, "parameters");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ArmDisasterRecovery.properties);

@@clientLocation(Eventhubs.get, EventHubs);
@@clientLocation(Eventhubs.createOrUpdate, EventHubs);
@@clientName(Eventhubs.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(Eventhubs.delete, EventHubs);
@@clientLocation(Eventhubs.listByNamespace, EventHubs);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Eventhub.properties);

@@clientLocation(SchemaGroups.get, "SchemaRegistry");
@@clientLocation(SchemaGroups.createOrUpdate, "SchemaRegistry");
@@clientName(SchemaGroups.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(SchemaGroups.delete, "SchemaRegistry");
@@clientLocation(SchemaGroups.listByNamespace, "SchemaRegistry");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ApplicationGroup.properties);

@@clientLocation(ClustersOperationGroup.listAvailableClusterRegion, Clusters);

@@clientLocation(NamespacesOperationGroup.checkNameAvailability, "Namespaces");

@@clientName(NamespacesOperationGroup.checkNameAvailability::parameters.body,
  "parameters"
);
@@clientName(Encryption.keyVaultProperties, "KeyVaultProperties");
@@clientName(KeyVaultProperties.keyName, "KeyName");
@@clientName(KeyVaultProperties.keyVersion, "KeyVersion");
@@clientName(KeyVaultProperties.keyVaultUri, "KeyVaultUri");
@@clientName(UserAssignedIdentityProperties, "userAssignedIdentityProperties");
@@clientName(UserAssignedIdentity.principalId, "PrincipalId");
@@clientName(UserAssignedIdentity.clientId, "ClientId");
