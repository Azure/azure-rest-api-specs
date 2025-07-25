import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Kubernetes;

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ConnectedClusterPatch.properties);

@@clientName(ConnectedClusters.createOrReplace::parameters.resource,
  "ConnectedCluster"
);
@@clientName(ConnectedClusters.update::parameters.properties,
  "ConnectedClusterPatch"
);
@@clientName(ConnectedClusters.listClusterUserCredential::parameters.body,
  "Properties"
);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ConnectedCluster.properties);

@@scope(Operations.list, "!csharp");

// @@clientLocation decorators for operations with @operationId
@@clientLocation(Operations.list, Operations);
@@clientName(Operations.list, "Get");
@@clientLocation(ConnectedClusters.get, "ConnectedCluster", "!csharp");
@@clientLocation(ConnectedClusters.createOrReplace,
  "ConnectedCluster",
  "!csharp"
);
@@clientLocation(ConnectedClusters.update, "ConnectedCluster", "!csharp");
@@clientLocation(ConnectedClusters.delete, "ConnectedCluster", "!csharp");
@@clientLocation(ConnectedClusters.listByResourceGroup,
  "ConnectedCluster",
  "!csharp"
);
@@clientLocation(ConnectedClusters.listBySubscription,
  "ConnectedCluster",
  "!csharp"
);
@@clientLocation(ConnectedClusters.listClusterUserCredential,
  "ConnectedCluster",
  "!csharp"
);
