import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ClientGenerator.Core;
using Microsoft.Relay;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(RelayUpdateParameters.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Operation.properties);

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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AuthorizationRule.properties
);

@@clientName(HybridConnectionOperationGroup.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(HybridConnection.properties
);

@@clientName(RelayNamespaces.createOrUpdate::parameters.resource, "parameters");
@@clientName(RelayNamespaces.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(RelayNamespace.properties);

@@clientName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PrivateEndpointConnection.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PrivateLinkResource.properties
);

@@clientName(NetworkRuleSets.createOrUpdateNetworkRuleSet::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(NetworkRuleSet.properties);

@@clientName(WcfRelaysOps.createOrUpdate::parameters.resource, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(WcfRelay.properties);

// AuthorizationRules operations
@@clientLocation(AuthorizationRules.getAuthorizationRule, "Namespaces");
@@clientLocation(AuthorizationRules.createOrUpdateAuthorizationRule,
  "Namespaces"
);
@@clientLocation(AuthorizationRules.deleteAuthorizationRule, "Namespaces");
@@clientLocation(AuthorizationRules.listAuthorizationRules, "Namespaces");
@@clientLocation(AuthorizationRules.listKeys, "Namespaces");
@@clientLocation(AuthorizationRules.regenerateKeys, "Namespaces");

// HybridConnectionOperationGroup operations
@@clientLocation(HybridConnectionOperationGroup.get, HybridConnections);
@@clientLocation(HybridConnectionOperationGroup.createOrUpdate,
  HybridConnections
);
@@clientLocation(HybridConnectionOperationGroup.delete, HybridConnections);
@@clientLocation(HybridConnectionOperationGroup.listByNamespace,
  HybridConnections
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
@@clientLocation(WcfRelaysOps.get, WCFRelays);
@@clientLocation(WcfRelaysOps.createOrUpdate, WCFRelays);
@@clientLocation(WcfRelaysOps.delete, WCFRelays);
@@clientLocation(WcfRelaysOps.listByNamespace, WCFRelays);

// NamespacesOperationGroup operations
@@clientLocation(NamespacesOperationGroup.checkNameAvailability, "Namespaces");

@@clientName(Azure.ResourceManager.CommonTypes.Resource,
  "ArmResource",
  "python"
);
