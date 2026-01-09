import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ServiceBus;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SBNamespaceUpdateParameters.properties
);

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
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(NamespaceFailoverProperties.properties
);

@@clientLocation(SBNamespaces.get, "Namespaces");
@@clientLocation(SBNamespaces.createOrUpdate, "Namespaces");
@@clientName(SBNamespaces.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(SBNamespaces.update, "Namespaces");
@@clientName(SBNamespaces.update::parameters.properties, "parameters");
@@clientLocation(SBNamespaces.delete, "Namespaces");
@@clientLocation(SBNamespaces.listByResourceGroup, "Namespaces");
@@clientLocation(SBNamespaces.list, "Namespaces");
@@clientLocation(SBNamespaces.failover, "Namespaces");
@@clientName(SBNamespaces.failover::parameters.body, "parameters");
@@clientLocation(SBNamespaces.privateLinkResourcesGet, "PrivateLinkResources");
@@clientName(SBNamespaces.privateLinkResourcesGet, "Get");
@@clientLocation(SBNamespaces.checkNameAvailability, DisasterRecoveryConfigs);
@@clientName(SBNamespaces.checkNameAvailability::parameters.body, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SBNamespace.properties);

@@clientName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PrivateEndpointConnection.properties
);

@@clientLocation(NetworkSecurityPerimeterConfigurations.list,
  "NetworkSecurityPerimeterConfiguration"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(NetworkSecurityPerimeterConfiguration.properties
);

@@clientLocation(ArmDisasterRecoveries.get, DisasterRecoveryConfigs);
@@clientLocation(ArmDisasterRecoveries.createOrUpdate, DisasterRecoveryConfigs);
@@clientName(ArmDisasterRecoveries.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(ArmDisasterRecoveries.delete, DisasterRecoveryConfigs);
@@clientLocation(ArmDisasterRecoveries.list, DisasterRecoveryConfigs);
@@clientLocation(ArmDisasterRecoveries.breakPairing, DisasterRecoveryConfigs);
@@clientLocation(ArmDisasterRecoveries.failOver, DisasterRecoveryConfigs);
@@clientName(ArmDisasterRecoveries.failOver::parameters.body, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ArmDisasterRecovery.properties
);

@@clientName(MigrationConfigs.createAndStartMigration::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(MigrationConfigProperties.properties
);

@@clientLocation(NetworkRuleSets.getNetworkRuleSet, "Namespaces");
@@clientLocation(NetworkRuleSets.createOrUpdateNetworkRuleSet, "Namespaces");
@@clientName(NetworkRuleSets.createOrUpdateNetworkRuleSet::parameters.resource,
  "parameters"
);

@@clientLocation(NetworkRuleSets.listNetworkRuleSets, "Namespaces");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(NetworkRuleSet.properties);

@@clientLocation(SBAuthorizationRules.getAuthorizationRule, "Namespaces");
@@clientLocation(SBAuthorizationRules.createOrUpdateAuthorizationRule,
  "Namespaces"
);
@@clientName(SBAuthorizationRules.createOrUpdateAuthorizationRule::parameters.resource,
  "parameters"
);
@@clientLocation(SBAuthorizationRules.deleteAuthorizationRule, "Namespaces");
@@clientLocation(SBAuthorizationRules.listAuthorizationRules, "Namespaces");
@@clientLocation(SBAuthorizationRules.listKeys, "Namespaces");
@@clientLocation(SBAuthorizationRules.regenerateKeys, "Namespaces");
@@clientName(SBAuthorizationRules.regenerateKeys::parameters.body,
  "parameters"
);
@@clientName(Queues.createOrUpdateAuthorizationRule::parameters.resource,
  "parameters"
);
@@clientName(Queues.regenerateKeys::parameters.body, "parameters");
@@clientName(Topics.createOrUpdateAuthorizationRule::parameters.resource,
  "parameters"
);
@@clientName(Topics.regenerateKeys::parameters.body, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SBAuthorizationRule.properties
);

@@clientLocation(SBQueues.get, Queues);
@@clientLocation(SBQueues.createOrUpdate, Queues);
@@clientName(SBQueues.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(SBQueues.delete, Queues);
@@clientLocation(SBQueues.listByNamespace, Queues);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SBQueue.properties);

@@clientLocation(SBTopics.get, Topics);
@@clientLocation(SBTopics.createOrUpdate, Topics);
@@clientName(SBTopics.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(SBTopics.delete, Topics);
@@clientLocation(SBTopics.listByNamespace, Topics);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SBTopic.properties);

@@clientName(Rules.createOrUpdate::parameters.resource, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Rule.properties);

@@clientLocation(SBSubscriptions.get, "Subscriptions");
@@clientLocation(SBSubscriptions.createOrUpdate, "Subscriptions");
@@clientName(SBSubscriptions.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(SBSubscriptions.delete, "Subscriptions");
@@clientLocation(SBSubscriptions.listByTopic, "Subscriptions");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SBSubscription.properties);

@@clientLocation(NamespacesOperationGroup.checkNameAvailability, "Namespaces");

@@clientName(NamespacesOperationGroup.checkNameAvailability::parameters.body,
  "parameters"
);

@@clientName(Encryption.keyVaultProperties, "KeyVaultProperties");

@@clientName(UserAssignedIdentity.principalId, "PrincipalId");
@@clientName(UserAssignedIdentity.clientId, "ClientId");
