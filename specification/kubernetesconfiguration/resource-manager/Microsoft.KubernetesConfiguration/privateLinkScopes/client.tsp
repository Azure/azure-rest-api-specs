import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.KubernetesConfiguration;

@@clientName(Microsoft.KubernetesConfiguration,
  "KubernetesConfigurationPrivateLinkScopesMgmtClient",
  "python"
);
@@clientName(Azure.ResourceManager.CommonTypes.PrivateEndpointConnection,
  "ArmPrivateEndpointConnection",
  "python"
);
@@clientName(Microsoft.KubernetesConfiguration,
  "PrivateLinkScopesClient",
  "javascript"
);
@@clientName(Microsoft.KubernetesConfiguration, "ScopeClient", "java");
@@clientLocation(KubernetesConfigurationPrivateLinkScopes.get,
  "Scopes",
  "java"
);
@@clientLocation(KubernetesConfigurationPrivateLinkScopes.createOrUpdate,
  "Scopes",
  "java"
);
@@clientLocation(KubernetesConfigurationPrivateLinkScopes.updateTags,
  "Scopes",
  "java"
);
@@clientLocation(KubernetesConfigurationPrivateLinkScopes.delete,
  "Scopes",
  "java"
);
@@clientLocation(KubernetesConfigurationPrivateLinkScopes.listByResourceGroup,
  "Scopes",
  "java"
);
@@clientLocation(KubernetesConfigurationPrivateLinkScopes.list,
  "Scopes",
  "java"
);
@@clientName(Azure.ResourceManager.CommonTypes.PrivateEndpointConnection,
  "Connection",
  "java"
);
@@clientName(Microsoft.KubernetesConfiguration.PrivateEndpointConnections,
  "Connections",
  "java"
);
@@clientName(Microsoft.KubernetesConfiguration.PrivateLinkResources,
  "Resources",
  "java"
);
