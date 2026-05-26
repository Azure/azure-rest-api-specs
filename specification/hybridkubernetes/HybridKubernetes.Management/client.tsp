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
#suppress "@azure-tools/typespec-client-generator-core/client-option" "RBAC roles for provisioning"
#suppress "@azure-tools/typespec-client-generator-core/client-option-requires-scope" "RBAC roles for provisioning"
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
