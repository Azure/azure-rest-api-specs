import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.KubernetesConfiguration;

@@clientLocation(KubernetesConfigurationPrivateLinkScopes.get,
  "PrivateLinkScopes"
);
@@clientLocation(KubernetesConfigurationPrivateLinkScopes.createOrUpdate,
  "PrivateLinkScopes"
);
@@clientName(KubernetesConfigurationPrivateLinkScopes.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(KubernetesConfigurationPrivateLinkScopes.updateTags,
  "PrivateLinkScopes"
);
@@clientName(KubernetesConfigurationPrivateLinkScopes.updateTags::parameters.properties,
  "PrivateLinkScopeTags"
);
@@clientLocation(KubernetesConfigurationPrivateLinkScopes.delete,
  "PrivateLinkScopes"
);
@@clientLocation(KubernetesConfigurationPrivateLinkScopes.listByResourceGroup,
  "PrivateLinkScopes"
);
@@clientLocation(KubernetesConfigurationPrivateLinkScopes.list,
  "PrivateLinkScopes"
);

@@clientName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "properties"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PrivateEndpointConnection.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PrivateLinkResource.properties);
