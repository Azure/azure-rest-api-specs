import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Kubernetes;

// csharp SDK considers this as a new RP therefore we no longer add this flatten decorator here.
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ConnectedClusterPatch.properties,
  "!csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ConnectedCluster.properties,
  "!csharp"
);

@@clientName(ConnectedClusters.createOrReplace::parameters.resource,
  "ConnectedCluster"
);
@@clientName(ConnectedClusters.update::parameters.properties,
  "ConnectedClusterPatch"
);
@@clientName(ConnectedClusters.updateAsync::parameters.properties,
  "ConnectedClusterPatch"
);
@@clientName(ConnectedClusters.listClusterUserCredential::parameters.body,
  "Properties"
);

// @@clientLocation decorators for operations with @operationId
@@clientLocation(Operations.list, Operations);
@@clientName(Operations.list, "Get");
@@clientLocation(ConnectedClusters.get, "ConnectedCluster");
@@clientLocation(ConnectedClusters.createOrReplace, "ConnectedCluster");
@@clientLocation(ConnectedClusters.update, "ConnectedCluster");
@@clientLocation(ConnectedClusters.updateAsync, "ConnectedCluster");
@@clientLocation(ConnectedClusters.delete, "ConnectedCluster");
@@clientLocation(ConnectedClusters.listByResourceGroup, "ConnectedCluster");
@@clientLocation(ConnectedClusters.listBySubscription, "ConnectedCluster");
@@clientLocation(ConnectedClusters.listClusterUserCredential,
  "ConnectedCluster"
);
