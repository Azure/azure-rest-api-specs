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
@@clientName(KubernetesConfigurationPrivateLinkScopeProperties,
  "PrivateLinkScopeProperties",
  "java"
);
@@clientName(KubernetesConfigurationPrivateLinkScope,
  "PrivateLinkScope",
  "java"
);
@@clientName(Azure.ResourceManager.CommonTypes.PrivateEndpointConnectionProperties,
  "ConnectionProperties",
  "java"
);
@@clientName(Azure.ResourceManager.CommonTypes.PrivateEndpointConnectionProvisioningState,
  "ConnectionProvisioningState",
  "java"
);
@@clientName(Azure.ResourceManager.CommonTypes.PrivateEndpointServiceConnectionStatus,
  "ServiceConnectionStatus",
  "java"
);
@@clientName(KubernetesConfigurationPrivateLinkScopes, "Scopes", "java");
@@clientName(Azure.ResourceManager.CommonTypes.PrivateEndpointConnectionListResult,
  "ConnectionListResult",
  "java"
);
@@clientName(PrivateEndpointConnections, "Connections", "java");
@@clientName(Azure.ResourceManager.CommonTypes.PrivateLinkResourceListResult,
  "ResourceListResult",
  "java"
);
@@clientName(PrivateLinkResources, "Resources", "java");
