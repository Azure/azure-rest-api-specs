import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.EventHub;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(FailOver.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateLinkResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NetworkSecurityPerimeterConfiguration.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Destination.properties);

@@clientName(Clusters.createOrUpdate::parameters.resource, "parameters");
@@clientName(Clusters.update::parameters.properties, "parameters");
@@clientName(Clusters.patch::parameters.body, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Cluster.properties);

@@clientName(EHNamespaces.createOrUpdate::parameters.resource, "parameters");
@@clientName(EHNamespaces.update::parameters.properties, "parameters");
@@clientName(EHNamespaces.failover::parameters.body, "parameters");
@@clientName(EHNamespaces.checkNameAvailability::parameters.body, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(EHNamespace.properties);

@@clientName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateEndpointConnection.properties);

@@clientName(NetworkRuleSets.createOrUpdateNetworkRuleSet::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NetworkRuleSet.properties);

@@clientName(AuthorizationRules.createOrUpdateAuthorizationRule::parameters.resource,
  "parameters"
);
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

@@clientName(ArmDisasterRecoveries.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ArmDisasterRecovery.properties);

@@clientName(Eventhubs.createOrUpdate::parameters.resource, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Eventhub.properties);

@@clientName(SchemaGroups.createOrUpdate::parameters.resource, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SchemaGroup.properties);

@@clientName(ApplicationGroups.createOrUpdateApplicationGroup::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ApplicationGroup.properties);
