import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

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

@@clientName(WcfRelaysOps.createOrUpdate::parameters.resource, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WcfRelay.properties);

// AuthorizationRules operations
@@clientLocation(AuthorizationRules.getAuthorizationRule, "Namespaces");
@@clientLocation(AuthorizationRules.createOrUpdateAuthorizationRule,
  "Namespaces"
);
@@clientLocation(AuthorizationRules.deleteAuthorizationRule, "Namespaces");
@@clientLocation(AuthorizationRules.listAuthorizationRules, "Namespaces");
@@clientLocation(AuthorizationRules.listKeys, "Namespaces");
@@clientLocation(AuthorizationRules.regenerateKeys, "Namespaces");

// HybridConnections authorization operations (no @operationId specified, so use interface name)
@@clientLocation(HybridConnections.getAuthorizationRule, "HybridConnections");
@@clientLocation(HybridConnections.createOrUpdateAuthorizationRule,
  "HybridConnections"
);
@@clientLocation(HybridConnections.deleteAuthorizationRule,
  "HybridConnections"
);
@@clientLocation(HybridConnections.listAuthorizationRules, "HybridConnections");
@@clientLocation(HybridConnections.listKeys, "HybridConnections");
@@clientLocation(HybridConnections.regenerateKeys, "HybridConnections");

// WCFRelays authorization operations
@@clientLocation(WCFRelays.getAuthorizationRule, "WCFRelays");
@@clientLocation(WCFRelays.createOrUpdateAuthorizationRule, "WCFRelays");
@@clientLocation(WCFRelays.deleteAuthorizationRule, "WCFRelays");
@@clientLocation(WCFRelays.listAuthorizationRules, "WCFRelays");
@@clientLocation(WCFRelays.listKeys, "WCFRelays");
@@clientLocation(WCFRelays.regenerateKeys, "WCFRelays");

// HybridConnectionOperationGroup operations
@@clientLocation(HybridConnectionOperationGroup.get, "HybridConnections");
@@clientLocation(HybridConnectionOperationGroup.createOrUpdate,
  "HybridConnections"
);
@@clientLocation(HybridConnectionOperationGroup.delete, "HybridConnections");
@@clientLocation(HybridConnectionOperationGroup.listByNamespace,
  "HybridConnections"
);

// RelayNamespaces operations
@@clientLocation(RelayNamespaces.get, "Namespaces");
@@clientLocation(RelayNamespaces.createOrUpdate, "Namespaces");
@@clientLocation(RelayNamespaces.update, "Namespaces");
@@clientLocation(RelayNamespaces.delete, "Namespaces");
@@clientLocation(RelayNamespaces.listByResourceGroup, "Namespaces");
@@clientLocation(RelayNamespaces.list, "Namespaces");

// NetworkRuleSets operations
@@clientLocation(NetworkRuleSets.getNetworkRuleSet, "Namespaces");
@@clientLocation(NetworkRuleSets.createOrUpdateNetworkRuleSet, "Namespaces");

// WCFRelays operations
@@clientLocation(WcfRelaysOps.get, "WCFRelays");
@@clientLocation(WcfRelaysOps.createOrUpdate, "WCFRelays");
@@clientLocation(WcfRelaysOps.delete, "WCFRelays");
@@clientLocation(WcfRelaysOps.listByNamespace, "WCFRelays");

// NamespacesOperationGroup operations
@@clientLocation(NamespacesOperationGroup.checkNameAvailability, "Namespaces");

// PrivateEndpointConnections operations (no @operationId, using interface name)
@@clientLocation(PrivateEndpointConnections.get, "PrivateEndpointConnections");
@@clientLocation(PrivateEndpointConnections.createOrUpdate,
  "PrivateEndpointConnections"
);
@@clientLocation(PrivateEndpointConnections.delete,
  "PrivateEndpointConnections"
);
@@clientLocation(PrivateEndpointConnections.list, "PrivateEndpointConnections");

// PrivateLinkResources operations (no @operationId, using interface name)
@@clientLocation(PrivateLinkResources.get, "PrivateLinkResources");
@@clientLocation(PrivateLinkResources.list, "PrivateLinkResources");

@@clientName(Azure.ResourceManager.CommonTypes.Resource, "ArmResource", "python");