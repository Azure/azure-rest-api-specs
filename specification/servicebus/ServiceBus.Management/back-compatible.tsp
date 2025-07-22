import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ServiceBus;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SBNamespaceUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateLinkResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Operation.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(FailoverProperties.properties);

@@clientName(SBNamespaces.createOrUpdate::parameters.resource, "parameters");
@@clientName(SBNamespaces.update::parameters.properties, "parameters");
@@clientName(SBNamespaces.checkNameAvailability::parameters.body, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SBNamespace.properties);

@@clientName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateEndpointConnection.properties);

@@clientName(ArmDisasterRecoveries.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ArmDisasterRecoveries.failOver::parameters.body, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ArmDisasterRecovery.properties);

@@clientName(MigrationConfigs.createAndStartMigration::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MigrationConfigProperties.properties);

@@clientName(NetworkRuleSets.createOrUpdateNetworkRuleSet::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
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
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SBAuthorizationRule.properties);

@@clientName(SBQueues.createOrUpdate::parameters.resource, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SBQueue.properties);

@@clientName(SBTopics.createOrUpdate::parameters.resource, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SBTopic.properties);

@@clientName(Rules.createOrUpdate::parameters.resource, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Rule.properties);

@@clientName(SBSubscriptions.createOrUpdate::parameters.resource, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SBSubscription.properties);

@@clientName(Microsoft.ServiceBus.Resource, "ResourceAutogen", "python");
