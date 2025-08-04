import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.NetworkCloud;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MachineSkuSlot.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StorageApplianceSkuSlot.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(OperationStatusResult.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BareMetalMachinePatchParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CloudServicesNetworkPatchParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ClusterPatchParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BareMetalMachineKeySetPatchParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BmcKeySetPatchParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ClusterMetricsConfigurationPatchParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(KubernetesClusterPatchParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AgentPoolPatchParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(KubernetesClusterFeaturePatchParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RackPatchParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StorageAppliancePatchParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachinePatchParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ConsolePatchParameters.properties);

@@clientName(BareMetalMachines.createOrUpdate::parameters.resource,
  "bareMetalMachineParameters"
);
@@clientName(BareMetalMachines.update::parameters.properties,
  "bareMetalMachineUpdateParameters"
);
@@clientName(BareMetalMachines.cordon::parameters.body,
  "bareMetalMachineCordonParameters"
);
@@clientName(BareMetalMachines.powerOff::parameters.body,
  "bareMetalMachinePowerOffParameters"
);
@@clientName(BareMetalMachines.replace::parameters.body,
  "bareMetalMachineReplaceParameters"
);
@@clientName(BareMetalMachines.runCommand::parameters.body,
  "bareMetalMachineRunCommandParameters"
);
@@clientName(BareMetalMachines.runDataExtracts::parameters.body,
  "bareMetalMachineRunDataExtractsParameters"
);
@@clientName(BareMetalMachines.runReadCommands::parameters.body,
  "bareMetalMachineRunReadCommandsParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BareMetalMachine.properties);

@@clientName(CloudServicesNetworks.createOrUpdate::parameters.resource,
  "cloudServicesNetworkParameters"
);
@@clientName(CloudServicesNetworks.update::parameters.properties,
  "cloudServicesNetworkUpdateParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CloudServicesNetwork.properties);

@@clientName(ClusterManagers.createOrUpdate::parameters.resource,
  "clusterManagerParameters"
);
@@clientName(ClusterManagers.update::parameters.properties,
  "clusterManagerUpdateParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ClusterManager.properties);

@@clientName(Clusters.createOrUpdate::parameters.resource, "clusterParameters");
@@clientName(Clusters.update::parameters.properties, "clusterUpdateParameters");
@@clientName(Clusters.continueUpdateVersion::parameters.body,
  "clusterContinueUpdateVersionParameters"
);
@@clientName(Clusters.deploy::parameters.body, "clusterDeployParameters");
@@clientName(Clusters.scanRuntime::parameters.body,
  "ClusterScanRuntimeParameters"
);
@@clientName(Clusters.updateVersion::parameters.body,
  "clusterUpdateVersionParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Cluster.properties);

@@clientName(KubernetesClusters.createOrUpdate::parameters.resource,
  "kubernetesClusterParameters"
);
@@clientName(KubernetesClusters.update::parameters.properties,
  "kubernetesClusterUpdateParameters"
);
@@clientName(KubernetesClusters.restartNode::parameters.body,
  "kubernetesClusterRestartNodeParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(KubernetesCluster.properties);

@@clientName(L2Networks.createOrUpdate::parameters.resource,
  "l2NetworkParameters"
);
@@clientName(L2Networks.update::parameters.properties,
  "l2NetworkUpdateParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(L2Network.properties);

@@clientName(L3Networks.createOrUpdate::parameters.resource,
  "l3NetworkParameters"
);
@@clientName(L3Networks.update::parameters.properties,
  "l3NetworkUpdateParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(L3Network.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RackSku.properties);

@@clientName(Racks.createOrUpdate::parameters.resource, "rackParameters");
@@clientName(Racks.update::parameters.properties, "rackUpdateParameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Rack.properties);

@@clientName(StorageAppliances.createOrUpdate::parameters.resource,
  "storageApplianceParameters"
);
@@clientName(StorageAppliances.update::parameters.properties,
  "storageApplianceUpdateParameters"
);
@@clientName(StorageAppliances.enableRemoteVendorManagement::parameters.body,
  "storageApplianceEnableRemoteVendorManagementParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StorageAppliance.properties);

@@clientName(TrunkedNetworks.createOrUpdate::parameters.resource,
  "trunkedNetworkParameters"
);
@@clientName(TrunkedNetworks.update::parameters.properties,
  "trunkedNetworkUpdateParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TrunkedNetwork.properties);

@@clientName(VirtualMachines.createOrUpdate::parameters.resource,
  "virtualMachineParameters"
);
@@clientName(VirtualMachines.update::parameters.properties,
  "virtualMachineUpdateParameters"
);
@@clientName(VirtualMachines.powerOff::parameters.body,
  "virtualMachinePowerOffParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachine.properties);

@@clientName(Volumes.createOrUpdate::parameters.resource, "volumeParameters");
@@clientName(Volumes.update::parameters.properties, "volumeUpdateParameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Volume.properties);

@@clientName(BareMetalMachineKeySets.createOrUpdate::parameters.resource,
  "bareMetalMachineKeySetParameters"
);
@@clientName(BareMetalMachineKeySets.update::parameters.properties,
  "bareMetalMachineKeySetUpdateParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BareMetalMachineKeySet.properties);

@@clientName(BmcKeySets.createOrUpdate::parameters.resource,
  "bmcKeySetParameters"
);
@@clientName(BmcKeySets.update::parameters.properties,
  "bmcKeySetUpdateParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BmcKeySet.properties);

@@clientLocation(ClusterMetricsConfigurations.get, "MetricsConfigurations");
@@clientLocation(ClusterMetricsConfigurations.createOrUpdate,
  "MetricsConfigurations"
);
@@clientName(ClusterMetricsConfigurations.createOrUpdate::parameters.resource,
  "metricsConfigurationParameters"
);
@@clientLocation(ClusterMetricsConfigurations.update, "MetricsConfigurations");
@@clientName(ClusterMetricsConfigurations.update::parameters.properties,
  "metricsConfigurationUpdateParameters"
);
@@clientLocation(ClusterMetricsConfigurations.delete, "MetricsConfigurations");
@@clientLocation(ClusterMetricsConfigurations.listByCluster,
  "MetricsConfigurations"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ClusterMetricsConfiguration.properties);

@@clientName(AgentPools.createOrUpdate::parameters.resource,
  "agentPoolParameters"
);
@@clientName(AgentPools.update::parameters.properties,
  "agentPoolUpdateParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AgentPool.properties);

@@clientName(KubernetesClusterFeatures.createOrUpdate::parameters.resource,
  "kubernetesClusterFeatureParameters"
);
@@clientName(KubernetesClusterFeatures.update::parameters.properties,
  "kubernetesClusterFeatureUpdateParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(KubernetesClusterFeature.properties);

@@clientName(Consoles.createOrUpdate::parameters.resource, "consoleParameters");
@@clientName(Consoles.update::parameters.properties, "consoleUpdateParameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Console.properties);
