import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./main.tsp";

using Azure.Core;
using Azure.ClientGenerator.Core;

namespace Microsoft.Kubernetes;

// This RP is using common-types v3, in which the type of this id is still string.
@@scope(Operations.list, "!csharp");
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(Azure.ResourceManager.CommonTypes.TrackedResource.location,
  azureLocation,
  "csharp"
);
@@alternateType(ConnectedCluster.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@clientName(Microsoft.Kubernetes, "ConnectedKubernetesClient", "javascript");
