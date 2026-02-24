import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.KubernetesConfiguration;

@@clientLocation(KubernetesConfigurationPrivateLinkScopes.get,
  "PrivateLinkScopes",
  "!java"
);
@@clientLocation(KubernetesConfigurationPrivateLinkScopes.createOrUpdate,
  "PrivateLinkScopes",
  "!java"
);
@@clientName(KubernetesConfigurationPrivateLinkScopes.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(KubernetesConfigurationPrivateLinkScopes.updateTags,
  "PrivateLinkScopes",
  "!java"
);
@@clientName(KubernetesConfigurationPrivateLinkScopes.updateTags::parameters.properties,
  "PrivateLinkScopeTags",
  "!java"
);
@@clientLocation(KubernetesConfigurationPrivateLinkScopes.delete,
  "PrivateLinkScopes",
  "!java"
);
@@clientLocation(KubernetesConfigurationPrivateLinkScopes.listByResourceGroup,
  "PrivateLinkScopes",
  "!java"
);
@@clientLocation(KubernetesConfigurationPrivateLinkScopes.list,
  "PrivateLinkScopes",
  "!java"
);

@@clientName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "properties"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PrivateEndpointConnection.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PrivateLinkResource.properties);
