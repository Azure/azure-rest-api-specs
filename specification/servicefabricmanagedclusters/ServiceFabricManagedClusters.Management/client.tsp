import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ServiceFabric;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VmssExtension.properties);

@@clientName(ApplicationTypeResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ApplicationTypeResources.update::parameters.properties,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ApplicationTypeResource.properties);

@@clientName(ApplicationTypeVersionResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ApplicationTypeVersionResources.update::parameters.properties,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ApplicationTypeVersionResource.properties);

@@clientName(ApplicationResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ApplicationResources.update::parameters.properties, "parameters");
@@clientName(ApplicationResources.resumeUpgrade::parameters.body, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ApplicationResource.properties);

@@clientName(ServiceResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ServiceResources.update::parameters.properties, "parameters");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ManagedClusterCodeVersionResult.properties);

@@clientName(ManagedClusters.createOrUpdate::parameters.resource, "parameters");
@@clientName(ManagedClusters.update::parameters.properties, "parameters");
@@clientName(ManagedClusters.getFaultSimulation::parameters.body, "parameters");
@@clientName(ManagedClusters.startFaultSimulation::parameters.body,
  "parameters"
);
@@clientName(ManagedClusters.stopFaultSimulation::parameters.body,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ManagedCluster.properties);

@@clientName(NodeTypes.createOrUpdate::parameters.resource, "parameters");
@@clientName(NodeTypes.update::parameters.properties, "parameters");
@@clientName(NodeTypes.deallocate::parameters.body, "parameters");
@@clientName(NodeTypes.deleteNode::parameters.body, "parameters");
@@clientName(NodeTypes.getFaultSimulation::parameters.body, "parameters");
@@clientName(NodeTypes.redeploy::parameters.body, "parameters");
@@clientName(NodeTypes.reimage::parameters.body, "parameters");
@@clientName(NodeTypes.restart::parameters.body, "parameters");
@@clientName(NodeTypes.start::parameters.body, "parameters");
@@clientName(NodeTypes.startFaultSimulation::parameters.body, "parameters");
@@clientName(NodeTypes.stopFaultSimulation::parameters.body, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NodeType.properties);
