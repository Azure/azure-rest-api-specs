import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.EventHub;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(FailOver.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PrivateLinkResource.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Operation.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Destination.properties);

@@clientName(Clusters.createOrUpdate::parameters.resource, "parameters");
@@clientName(Clusters.update::parameters.properties, "parameters");
@@clientLocation(Clusters.patch, "Configuration");
@@clientName(Clusters.patch::parameters.body, "parameters");
@@clientLocation(Clusters.configurationGet, "Configuration");
@@clientName(Clusters.configurationGet, "Get");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Cluster.properties);

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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(EHNamespace.properties);

@@clientName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PrivateEndpointConnection.properties
);

@@clientLocation(NetworkSecurityPerimeterConfigurations.list,
  "NetworkSecurityPerimeterConfiguration"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(NetworkSecurityPerimeterConfiguration.properties
);

@@clientLocation(NetworkRuleSets.getNetworkRuleSet, "Namespaces");
@@clientLocation(NetworkRuleSets.createOrUpdateNetworkRuleSet, "Namespaces");
@@clientName(NetworkRuleSets.createOrUpdateNetworkRuleSet::parameters.resource,
  "parameters"
);
@@clientLocation(NetworkRuleSets.listNetworkRuleSet, "Namespaces");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(NetworkRuleSet.properties);

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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AuthorizationRule.properties
);

@@clientName(ConsumerGroups.createOrUpdate::parameters.resource, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ConsumerGroup.properties);

@@clientLocation(ArmDisasterRecoveries.get, DisasterRecoveryConfigs);
@@clientLocation(ArmDisasterRecoveries.createOrUpdate, DisasterRecoveryConfigs);
@@clientName(ArmDisasterRecoveries.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(ArmDisasterRecoveries.delete, DisasterRecoveryConfigs);
@@clientLocation(ArmDisasterRecoveries.list, DisasterRecoveryConfigs);
@@clientLocation(ArmDisasterRecoveries.breakPairing, DisasterRecoveryConfigs);
@@clientLocation(ArmDisasterRecoveries.failOver, DisasterRecoveryConfigs);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ArmDisasterRecovery.properties
);

@@clientLocation(Eventhubs.get, EventHubs);
@@clientLocation(Eventhubs.createOrUpdate, EventHubs);
@@clientName(Eventhubs.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(Eventhubs.delete, EventHubs);
@@clientLocation(Eventhubs.listByNamespace, EventHubs);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Eventhub.properties);

@@clientLocation(SchemaGroups.get, "SchemaRegistry");
@@clientLocation(SchemaGroups.createOrUpdate, "SchemaRegistry");
@@clientName(SchemaGroups.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(SchemaGroups.delete, "SchemaRegistry");
@@clientLocation(SchemaGroups.listByNamespace, "SchemaRegistry");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SchemaGroup.properties);

@@clientLocation(ApplicationGroups.get, "ApplicationGroup");
@@clientLocation(ApplicationGroups.createOrUpdateApplicationGroup,
  "ApplicationGroup"
);
@@clientName(ApplicationGroups.createOrUpdateApplicationGroup::parameters.resource,
  "parameters"
);
@@clientLocation(ApplicationGroups.delete, "ApplicationGroup");
@@clientLocation(ApplicationGroups.listByNamespace, "ApplicationGroup");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ApplicationGroup.properties
);

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

@@clientName(TlsVersion.`1.0`, "ONE0", "python");
@@clientName(TlsVersion.`1.1`, "ONE1", "python");
@@clientName(TlsVersion.`1.2`, "ONE2", "python");
@@clientName(TlsVersion.`1.3`, "ONE3", "python");
@@clientName(TlsVersion.`1.0`, "One0", "javascript");
@@clientName(TlsVersion.`1.1`, "One1", "javascript");
@@clientName(TlsVersion.`1.2`, "One2", "javascript");
@@clientName(TlsVersion.`1.3`, "One3", "javascript");
