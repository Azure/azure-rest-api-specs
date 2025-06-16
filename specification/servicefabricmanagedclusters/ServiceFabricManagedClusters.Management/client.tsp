import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ServiceFabric;

@@clientName(Microsoft.ServiceFabric,
  "ServiceFabricManagedClustersManagementClient",
  "python"
);

@@clientName(Microsoft.ServiceFabric,
  "ServiceFabricManagedClustersMgmtClient",
  "java"
);

@@clientName(Microsoft.ServiceFabric,
  "ServiceFabricManagedClustersManagementClient",
  "javascript"
);

#suppress "deprecated" "@flattenProperty decorator for backwards compatibility with existing spec"
@@flattenProperty(VMSSExtension.properties);

@@clientName(ApplicationTypes.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ApplicationTypes.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator for backwards compatibility with existing spec"
@@flattenProperty(ApplicationTypeResource.properties);

@@clientName(ApplicationTypeVersions.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ApplicationTypeVersions.update::parameters.properties,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator for backwards compatibility with existing spec"
@@flattenProperty(ApplicationTypeVersionResource.properties);

@@clientName(Applications.createOrUpdate::parameters.resource, "parameters");
@@clientName(Applications.update::parameters.properties, "parameters");
@@clientName(Applications.resumeUpgrade::parameters.body, "parameters");
#suppress "deprecated" "@flattenProperty decorator for backwards compatibility with existing spec"
@@flattenProperty(ApplicationResource.properties);

@@clientName(Services.createOrUpdate::parameters.resource, "parameters");
@@clientName(Services.update::parameters.properties, "parameters");

@@clientName(ManagedClusters.createOrUpdate::parameters.resource, "parameters");
@@clientName(ManagedClusters.update::parameters.properties, "parameters");
@@clientName(ManagedClusters.getFaultSimulation::parameters.body, "parameters");
@@clientName(ManagedClusters.startFaultSimulation::parameters.body,
  "parameters"
);
@@clientName(ManagedClusters.stopFaultSimulation::parameters.body,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator for backwards compatibility with existing spec"
@@flattenProperty(ManagedCluster.properties);

#suppress "deprecated" "@flattenProperty decorator for backwards compatibility with existing spec"
@@flattenProperty(ManagedClusterCodeVersionResult.properties);

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
#suppress "deprecated" "@flattenProperty decorator for backwards compatibility with existing spec"
@@flattenProperty(NodeType.properties);

@@Azure.ResourceManager.identifiers(FaultSimulationListResult.value,
  #["simulationId"]
);

@@scope(OperationResults.get, "!java");
@@scope(OperationStatus.get, "!java");
