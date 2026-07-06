import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./main.tsp";

using Azure.Core;
using Azure.ClientGenerator.Core;

namespace Microsoft.Kubernetes;

// This RP is using common-types v3, in which the type of this id is still string.
@@scope(Operations.list, "!csharp");
@@alternateType(
  Azure.ResourceManager.CommonTypes.Resource.id,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  Azure.ResourceManager.CommonTypes.TrackedResource.location,
  azureLocation,
  "csharp"
);
@@alternateType(
  ConnectedCluster.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(
  ConnectedClusterProperties.privateLinkScopeResourceId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(AadProfile, "ConnectedClusterAadProfile", "csharp");
@@clientName(AadProfile.enableAzureRBAC, "EnableAzureRbac", "csharp");
@@clientName(AadProfile.adminGroupObjectIDs, "AdminGroupObjectIds", "csharp");
@@clientName(AadProfile.tenantID, "TenantId", "csharp");
@@clientName(AgentError, "ConnectedClusterAgentError", "csharp");
@@clientName(AgentError.time, "OccurredOn", "csharp");
@@clientName(ArcAgentProfile, "ConnectedClusterArcAgentProfile", "csharp");
@@clientName(
  ArcAgentryConfigurations,
  "ConnectedClusterArcAgentryConfiguration",
  "csharp"
);
@@clientName(
  AuthenticationMethod,
  "ClusterUserCredentialAuthenticationMethod",
  "csharp"
);
@@clientName(AuthenticationMethod.AAD, "Aad", "csharp");
@@clientName(AutoUpgradeOptions, "ConnectedClusterAutoUpgradeMode", "csharp");
@@clientName(
  AzureHybridBenefit,
  "ConnectedClusterAzureHybridBenefit",
  "csharp"
);
@@clientName(
  ConnectivityStatus,
  "ConnectedClusterConnectivityStatus",
  "csharp"
);
@@clientName(ConnectedClusterKind.AWS, "Aws", "csharp");
@@clientName(ConnectedClusterKind.GCP, "Gcp", "csharp");
@@clientName(Gateway.enabled, "IsGatewayEnabled", "csharp");
@@clientName(CredentialResult, "ClusterUserCredentialResult", "csharp");
@@clientName(CredentialResults, "ClusterUserCredentialsResult", "csharp");
@@clientName(
  HybridConnectionConfig,
  "ClusterUserCredentialHybridConnectionConfig",
  "csharp"
);
@@clientName(OidcIssuerProfile, "ConnectedClusterOidcIssuerProfile", "csharp");
@@clientName(PrivateLinkState, "ConnectedClusterPrivateLinkState", "csharp");
@@clientName(ProvisioningState, "ConnectedClusterProvisioningState", "csharp");
@@clientName(SecurityProfile, "ConnectedClusterSecurityProfile", "csharp");
@@clientName(SecurityProfile.workloadIdentity, "IsWorkloadIdentity", "csharp");
@@clientName(
  SecurityProfileWorkloadIdentity,
  "ConnectedClusterWorkloadIdentityProfile",
  "csharp"
);
@@clientName(SystemComponent, "ConnectedClusterSystemComponent", "csharp");
@@clientName(
  ListClusterUserCredentialProperties,
  "GetClusterUserCredentialContent",
  "csharp"
);
@@clientName(
  ConnectedClusters.listClusterUserCredential::parameters.body,
  "content",
  "csharp"
);
@@clientName(
  ListClusterUserCredentialProperties.clientProxy,
  "UseClientProxy",
  "csharp"
);
@@clientName(
  HybridConnectionConfig.expirationTime,
  "ExpirationTimeInSeconds",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/client-option" "RBAC roles for provisioning"
@@clientOption(
  ConnectedCluster,
  "resource-rbac-roles",
  #{
    KubernetesClusterAzureArcOnboarding: "34e09817-6cbe-4d01-b1a2-e0eac5743d41",
  },
  "csharp"
);
@@clientName(Microsoft.Kubernetes, "ConnectedKubernetesClient", "javascript");
@@clientName(Microsoft.Kubernetes, "ConnectedKubernetesClient", "python");
