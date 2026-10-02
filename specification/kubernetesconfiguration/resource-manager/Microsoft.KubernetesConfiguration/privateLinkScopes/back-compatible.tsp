import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.KubernetesConfiguration;

@@clientLocation(
  KubernetesConfigurationPrivateLinkScopes.get,
  "PrivateLinkScopes",
  "!java,!csharp"
);
@@clientLocation(
  KubernetesConfigurationPrivateLinkScopes.createOrUpdate,
  "PrivateLinkScopes",
  "!java,!csharp"
);
@@clientName(
  KubernetesConfigurationPrivateLinkScopes.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(
  KubernetesConfigurationPrivateLinkScopes.updateTags,
  "PrivateLinkScopes",
  "!java,!csharp"
);
@@clientName(
  KubernetesConfigurationPrivateLinkScopes.updateTags::parameters.properties,
  "PrivateLinkScopeTags",
  "!java"
);
@@clientLocation(
  KubernetesConfigurationPrivateLinkScopes.delete,
  "PrivateLinkScopes",
  "!java,!csharp"
);
@@clientLocation(
  KubernetesConfigurationPrivateLinkScopes.listByResourceGroup,
  "PrivateLinkScopes",
  "!java,!csharp"
);
@@clientLocation(
  KubernetesConfigurationPrivateLinkScopes.list,
  "PrivateLinkScopes",
  "!java,!csharp"
);

@@clientLocation(
  KubernetesConfigurationPrivateLinkScopes.get,
  "PrivateLinkScopesOperations",
  "csharp"
);
@@clientLocation(
  KubernetesConfigurationPrivateLinkScopes.createOrUpdate,
  "PrivateLinkScopesOperations",
  "csharp"
);
@@clientLocation(
  KubernetesConfigurationPrivateLinkScopes.updateTags,
  "PrivateLinkScopesOperations",
  "csharp"
);
@@clientLocation(
  KubernetesConfigurationPrivateLinkScopes.delete,
  "PrivateLinkScopesOperations",
  "csharp"
);
@@clientLocation(
  KubernetesConfigurationPrivateLinkScopes.listByResourceGroup,
  "PrivateLinkScopesOperations",
  "csharp"
);
@@clientLocation(
  KubernetesConfigurationPrivateLinkScopes.list,
  "PrivateLinkScopesOperations",
  "csharp"
);

@@clientName(
  PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "properties"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PrivateEndpointConnection.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PrivateLinkResource.properties);
