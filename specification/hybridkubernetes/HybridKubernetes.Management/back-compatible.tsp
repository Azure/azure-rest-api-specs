import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Kubernetes;

// csharp SDK considers this as a new RP therefore we no longer add this flatten decorator here.
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  ConnectedClusterPatch.properties,
  "!csharp,!javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  ConnectedCluster.properties,
  "!csharp"
);

@@clientName(
  ConnectedClusters.createOrReplace::parameters.resource,
  "ConnectedCluster"
);
@@clientName(
  ConnectedClusters.update::parameters.properties,
  "ConnectedClusterPatch"
);
@@clientName(
  ConnectedClusters.updateAsync::parameters.properties,
  "ConnectedClusterPatch"
);
@@clientName(
  ConnectedClusters.listClusterUserCredential::parameters.body,
  "Properties"
);

// @@clientLocation decorators for operations with @operationId
@@clientLocation(Operations.list, Operations);
@@clientName(Operations.list, "Get", "!javascript");
@@clientLocation(ConnectedClusters.get, "ConnectedCluster", "!javascript");
@@clientLocation(
  ConnectedClusters.createOrReplace,
  "ConnectedCluster",
  "!javascript"
);
@@clientLocation(ConnectedClusters.update, "ConnectedCluster", "!javascript");
@@clientLocation(
  ConnectedClusters.updateAsync,
  "ConnectedCluster",
  "!javascript"
);
@@clientLocation(ConnectedClusters.delete, "ConnectedCluster", "!javascript");
@@clientLocation(
  ConnectedClusters.listByResourceGroup,
  "ConnectedCluster",
  "!javascript"
);
@@clientLocation(
  ConnectedClusters.listBySubscription,
  "ConnectedCluster",
  "!javascript"
);
@@clientLocation(
  ConnectedClusters.listClusterUserCredential,
  "ConnectedCluster",
  "!javascript"
);
@@clientLocation(
  ConnectedClusters.get,
  "ConnectedClusterOperations",
  "javascript"
);
@@clientLocation(
  ConnectedClusters.createOrReplace,
  "ConnectedClusterOperations",
  "javascript"
);
@@clientLocation(
  ConnectedClusters.update,
  "ConnectedClusterOperations",
  "javascript"
);
@@clientLocation(
  ConnectedClusters.updateAsync,
  "ConnectedClusterOperations",
  "javascript"
);
@@clientLocation(
  ConnectedClusters.delete,
  "ConnectedClusterOperations",
  "javascript"
);
@@clientLocation(
  ConnectedClusters.listByResourceGroup,
  "ConnectedClusterOperations",
  "javascript"
);
@@clientLocation(
  ConnectedClusters.listBySubscription,
  "ConnectedClusterOperations",
  "javascript"
);
@@clientLocation(
  ConnectedClusters.listClusterUserCredential,
  "ConnectedClusterOperations",
  "javascript"
);
