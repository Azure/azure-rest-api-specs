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
@@clientName(Azure.ResourceManager.CommonTypes.PrivateEndpointConnection,
  "Connection",
  "java"
);
@@clientName(Microsoft.KubernetesConfiguration,
  "PrivateLinkScopesClient",
  "javascript"
);
@@clientName(Microsoft.KubernetesConfiguration, "ScopeClient", "java");
@@clientName(KubernetesConfigurationPrivateLinkScope,
  "PrivateLinkScope",
  "java"
);
@@clientName(KubernetesConfigurationPrivateLinkScopes, "Scopes", "java");
@@clientName(PrivateEndpointConnections, "Connections", "java");
@@clientName(PrivateEndpointConnection, "PrivateEndpoint", "java");
@@clientName(PrivateLinkResources, "Resources", "java");

@@clientName(Microsoft.KubernetesConfiguration, "ScopeClient", "java");
@@clientName(KubernetesConfigurationPrivateLinkScopes, "ScopesClient", "java");
@@clientName(PrivateEndpointConnection, "PrivateEndpointConnection", "java");
