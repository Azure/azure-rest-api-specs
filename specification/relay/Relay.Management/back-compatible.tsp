import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Relay;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RelayUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Operation.properties);

@@clientName(AuthorizationRules.createOrUpdateAuthorizationRule::parameters.resource,
  "parameters"
);
@@clientName(AuthorizationRules.regenerateKeys::parameters.body, "parameters");
@@clientName(HybridConnections.createOrUpdateAuthorizationRule::parameters.resource,
  "parameters"
);
@@clientName(HybridConnections.regenerateKeys::parameters.body, "parameters");
@@clientName(WCFRelays.createOrUpdateAuthorizationRule::parameters.resource,
  "parameters"
);
@@clientName(WCFRelays.regenerateKeys::parameters.body, "parameters");
@@clientName(NamespacesOperationGroup.checkNameAvailability::parameters.body,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AuthorizationRule.properties);

@@clientName(HybridConnectionOperationGroup.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(HybridConnection.properties);

@@clientName(RelayNamespaces.createOrUpdate::parameters.resource, "parameters");
@@clientName(RelayNamespaces.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RelayNamespace.properties);

@@clientName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateEndpointConnection.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateLinkResource.properties);

@@clientName(NetworkRuleSets.createOrUpdateNetworkRuleSet::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NetworkRuleSet.properties);

@@clientName(WcfRelays.createOrUpdate::parameters.resource, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WcfRelay.properties);
