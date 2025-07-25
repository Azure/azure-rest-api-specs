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

@@clientName(Microsoft.ServiceBus.Resource, "ResourceAutogen", "python");

@@clientName(NamespacesOperationGroup.checkNameAvailability::parameters.body,
  "parameters"
);

@@clientName(Encryption.keyVaultProperties, "KeyVaultProperties");
