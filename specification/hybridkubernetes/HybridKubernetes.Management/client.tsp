import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Kubernetes;

@@clientName(AadProfile.enableAzureRBAC, "enableAzureRbac");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
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
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ConnectedCluster.properties);
