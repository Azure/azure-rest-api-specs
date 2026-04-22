import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.PrivateLinkScopes;

@@clientLocation(AzureMonitorPrivateLinkScopes.get, "PrivateLinkScopes");
@@clientLocation(AzureMonitorPrivateLinkScopes.createOrUpdate,
  "PrivateLinkScopes"
);
@@clientName(AzureMonitorPrivateLinkScopes.createOrUpdate::parameters.resource,
  "AzureMonitorPrivateLinkScopePayload"
);
@@clientLocation(AzureMonitorPrivateLinkScopes.updateTags, "PrivateLinkScopes");
@@clientName(AzureMonitorPrivateLinkScopes.updateTags::parameters.properties,
  "PrivateLinkScopeTags"
);
@@clientLocation(AzureMonitorPrivateLinkScopes.delete, "PrivateLinkScopes");
@@clientLocation(AzureMonitorPrivateLinkScopes.listByResourceGroup,
  "PrivateLinkScopes"
);
@@clientLocation(AzureMonitorPrivateLinkScopes.list, "PrivateLinkScopes");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AzureMonitorPrivateLinkScope.properties);

@@clientName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PrivateEndpointConnection.properties);

@@clientLocation(ScopedResources.get, "PrivateLinkScopedResources");
@@clientLocation(ScopedResources.createOrUpdate, "PrivateLinkScopedResources");
@@clientName(ScopedResources.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(ScopedResources.delete, "PrivateLinkScopedResources");
@@clientLocation(ScopedResources.listByPrivateLinkScope,
  "PrivateLinkScopedResources"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ScopedResource.properties);

@@clientLocation(PrivateLinkScopeOperationStatusOperationGroup.get,
  "PrivateLinkScopeOperationStatus"
);
