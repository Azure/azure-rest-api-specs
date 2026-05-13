import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.KubernetesConfiguration;

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
@@clientName(KubernetesConfigurationPrivateLinkScope,
  "PrivateLinkScope",
  "java"
);
@@clientName(KubernetesConfigurationPrivateLinkScopes, "Scopes", "java");
@@clientName(KubernetesConfigurationPrivateLinkScopeProperties,
  "PrivateLinkScopeProperties",
  "java"
);
@@clientName(PrivateEndpointConnections, "Connections", "java");
@@clientName(PrivateEndpointConnection, "Connection", "java");
@@clientName(PrivateLinkResources, "Resources", "java");

// C# type customizations for backward compatibility
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(KubernetesConfigurationPrivateLinkScopeProperties.clusterResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(KubernetesConfigurationPrivateLinkScopeProperties.privateLinkScopeId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(Azure.ResourceManager.CommonTypes.PrivateEndpoint.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(ProvisioningState,
  "KubernetesConfigurationPrivateLinkScopeProvisioningState",
  "csharp"
);
@@clientName(PublicNetworkAccessType,
  "KubernetesConfigurationPrivateLinkScopePublicNetworkAccessType",
  "csharp"
);
@@clientName(PrivateLinkResource,
  "KubernetesConfigurationPrivateLinkResource",
  "csharp"
);
@@clientName(PrivateEndpointConnection,
  "KubernetesConfigurationPrivateEndpointConnection",
  "csharp"
);

// C# fixes: mark single-page list operations as pageable for correct Collection generation
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required for correct Collection generation in C#"
@@Legacy.markAsPageable(Microsoft.KubernetesConfiguration.PrivateLinkResources.listByPrivateLinkScope,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required for correct Collection generation in C#"
@@Legacy.markAsPageable(Microsoft.KubernetesConfiguration.PrivateEndpointConnections.listByPrivateLinkScope,
  "csharp"
);
