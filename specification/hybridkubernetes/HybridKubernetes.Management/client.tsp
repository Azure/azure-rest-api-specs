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
@@clientName(AadProfile.enableAzureRBAC, "EnableAzureRbac", "csharp");
@@clientName(AadProfile.adminGroupObjectIDs, "AdminGroupObjectIds", "csharp");
@@clientName(AadProfile.tenantID, "TenantId", "csharp");
@@clientName(AgentError.time, "OccurredOn", "csharp");
@@clientName(AuthenticationMethod.AAD, "Aad", "csharp");
@@clientName(ConnectedClusterKind.AWS, "Aws", "csharp");
@@clientName(ConnectedClusterKind.GCP, "Gcp", "csharp");
@@clientName(ConnectedClusterProperties.gateway, "IsGateway", "csharp");
@@clientName(ConnectedClusterPatchProperties.gateway, "IsGateway", "csharp");
@@clientName(SecurityProfile.workloadIdentity, "IsWorkloadIdentity", "csharp");
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
@@clientName(Microsoft.Kubernetes, "ConnectedKubernetesClient", "javascript");
@@clientName(Microsoft.Kubernetes, "ConnectedKubernetesClient", "python");
