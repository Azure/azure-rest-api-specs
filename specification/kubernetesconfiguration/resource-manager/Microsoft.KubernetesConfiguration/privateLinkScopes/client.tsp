import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.KubernetesConfiguration,
  "KubernetesConfigurationPrivateLinkScopesMgmtClient",
  "python"
);
@@clientName(Microsoft.KubernetesConfiguration,
  "PrivateLinkScopesClient",
  "javascript"
);
@@clientName(Azure.ResourceManager.CommonTypes.PrivateEndpointConnection,
  "ArmPrivateEndpointConnection",
  "python"
);
@@clientName(Microsoft.KubernetesConfiguration, "ScopeClient", "java");
@@clientName(Azure.ResourceManager.CommonTypes.PrivateEndpointConnectionListResult,
  "ConnectionListResult",
  "java"
);
@@clientName(Azure.ResourceManager.CommonTypes.PrivateLinkResourceListResult,
  "ResourceListResult",
  "java"
);
@@clientName(Azure.ResourceManager.CommonTypes.PrivateEndpointConnectionProperties,
  "ConnectionProperties",
  "java"
);
@@clientName(Azure.ResourceManager.CommonTypes.PrivateEndpointServiceConnectionStatus,
  "ServiceConnectionStatus",
  "java"
);
@@clientName(Azure.ResourceManager.CommonTypes.PrivateEndpointConnectionProvisioningState,
  "ConnectionProvisioningState",
  "java"
);
@@clientName(Microsoft.KubernetesConfiguration.KubernetesConfigurationPrivateLinkScope,
  "PrivateLinkScope",
  "java"
);
@@clientName(Microsoft.KubernetesConfiguration.KubernetesConfigurationPrivateLinkScopes,
  "Scopes",
  "java"
);
@@clientName(Microsoft.KubernetesConfiguration.KubernetesConfigurationPrivateLinkScopeProperties,
  "PrivateLinkScopeProperties",
  "java"
);
@@clientName(Microsoft.KubernetesConfiguration.PrivateEndpointConnections,
  "Connections",
  "java"
);
@@clientName(Microsoft.KubernetesConfiguration.PrivateEndpointConnection,
  "Connection",
  "java"
);
@@clientName(Microsoft.KubernetesConfiguration.PrivateLinkResources,
  "Resources",
  "java"
);
