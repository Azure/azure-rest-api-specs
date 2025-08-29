import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ServiceBus;

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SBNamespaceUpdateParameters.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(PrivateLinkResource.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Operation.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(FailoverProperties.properties);

@@clientName(SBNamespaces.createOrUpdate::parameters.resource, "parameters");
@@clientName(SBNamespaces.update::parameters.properties, "parameters");
@@clientName(SBNamespaces.checkNameAvailability::parameters.body, "parameters");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SBNamespace.properties);

@@clientName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(PrivateEndpointConnection.properties);

@@clientName(ArmDisasterRecoveries.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ArmDisasterRecoveries.failOver::parameters.body, "parameters");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ArmDisasterRecovery.properties);

@@clientName(MigrationConfigs.createAndStartMigration::parameters.resource,
  "parameters"
);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(MigrationConfigProperties.properties);

@@clientName(NetworkRuleSets.createOrUpdateNetworkRuleSet::parameters.resource,
  "parameters"
);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(NetworkRuleSet.properties);

@@clientName(SBAuthorizationRules.createOrUpdateAuthorizationRule::parameters.resource,
  "parameters"
);
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
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SBAuthorizationRule.properties);

@@clientName(SBQueues.createOrUpdate::parameters.resource, "parameters");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SBQueue.properties);

@@clientName(SBTopics.createOrUpdate::parameters.resource, "parameters");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SBTopic.properties);

@@clientName(Rules.createOrUpdate::parameters.resource, "parameters");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Rule.properties);

@@clientName(SBSubscriptions.createOrUpdate::parameters.resource, "parameters");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SBSubscription.properties);

@@clientName(NamespacesOperationGroup.checkNameAvailability::parameters.body,
  "parameters"
);

@@clientName(Encryption.keyVaultProperties, "KeyVaultProperties");

@@clientName(UserAssignedIdentity.principalId, "PrincipalId");
@@clientName(UserAssignedIdentity.clientId, "ClientId");

@@clientLocation(ArmDisasterRecoveries.get, DisasterRecoveryConfigs);
@@clientLocation(ArmDisasterRecoveries.createOrUpdate, DisasterRecoveryConfigs);
@@clientLocation(ArmDisasterRecoveries.delete, DisasterRecoveryConfigs);
@@clientLocation(ArmDisasterRecoveries.list, DisasterRecoveryConfigs);
@@clientLocation(ArmDisasterRecoveries.breakPairing, DisasterRecoveryConfigs);
@@clientLocation(ArmDisasterRecoveries.failOver, DisasterRecoveryConfigs);

@@clientLocation(NetworkRuleSets.getNetworkRuleSet, "Namespaces");
@@clientLocation(NetworkRuleSets.createOrUpdateNetworkRuleSet, "Namespaces");
@@clientLocation(NetworkRuleSets.listNetworkRuleSets, "Namespaces");

@@clientLocation(NamespacesOperationGroup.checkNameAvailability, "Namespaces");

@@clientLocation(SBAuthorizationRules.getAuthorizationRule, "Namespaces");
@@clientLocation(SBAuthorizationRules.createOrUpdateAuthorizationRule,
  "Namespaces"
);
@@clientLocation(SBAuthorizationRules.deleteAuthorizationRule, "Namespaces");
@@clientLocation(SBAuthorizationRules.listAuthorizationRules, "Namespaces");
@@clientLocation(SBAuthorizationRules.listKeys, "Namespaces");
@@clientLocation(SBAuthorizationRules.regenerateKeys, "Namespaces");

@@clientLocation(SBNamespaces.get, "Namespaces");
@@clientLocation(SBNamespaces.createOrUpdate, "Namespaces");
@@clientLocation(SBNamespaces.update, "Namespaces");
@@clientLocation(SBNamespaces.delete, "Namespaces");
@@clientLocation(SBNamespaces.listByResourceGroup, "Namespaces");
@@clientLocation(SBNamespaces.list, "Namespaces");
@@clientLocation(SBNamespaces.privateLinkResourcesGet, "PrivateLinkResources");
@@clientName(SBNamespaces.privateLinkResourcesGet, "get");
@@clientLocation(SBNamespaces.checkNameAvailability, DisasterRecoveryConfigs);

@@clientLocation(SBQueues.get, Queues);
@@clientLocation(SBQueues.createOrUpdate, Queues);
@@clientLocation(SBQueues.delete, Queues);
@@clientLocation(SBQueues.listByNamespace, Queues);

@@clientLocation(SBSubscriptions.get, "Subscriptions");
@@clientLocation(SBSubscriptions.createOrUpdate, "Subscriptions");
@@clientLocation(SBSubscriptions.delete, "Subscriptions");
@@clientLocation(SBSubscriptions.listByTopic, "Subscriptions");

@@clientLocation(SBTopics.get, Topics);
@@clientLocation(SBTopics.createOrUpdate, Topics);
@@clientLocation(SBTopics.delete, Topics);
@@clientLocation(SBTopics.listByNamespace, Topics);
