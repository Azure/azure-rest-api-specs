import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.NetworkCloud;

@@clientName(SecretRotationStatus.k8sSecretName, "k8SSecretName");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(MachineSkuSlot.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(StorageApplianceSkuSlot.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(OperationStatusResult.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AccessBridgePatchParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(BareMetalMachinePatchParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CloudServicesNetworkPatchParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ClusterManagerPatchParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ClusterPatchParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(BareMetalMachineKeySetPatchParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(BmcKeySetPatchParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ClusterMetricsConfigurationPatchParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(KubernetesClusterPatchParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AgentPoolPatchParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(KubernetesClusterFeaturePatchParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RackPatchParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(StorageAppliancePatchParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(VirtualMachinePatchParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ConsolePatchParameters.properties);

@@clientName(AccessBridges.createOrUpdate::parameters.resource, "accessBridge");
@@clientName(AccessBridges.update::parameters.properties,
  "accessBridgeUpdateParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AccessBridge.properties);

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
@@clientName(BareMetalMachines.runDataExtractsRestricted::parameters.body,
  "bareMetalMachineRunDataExtractsRestrictedParameters"
);
@@clientName(BareMetalMachines.runReadCommands::parameters.body,
  "bareMetalMachineRunReadCommandsParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(BareMetalMachine.properties);

@@clientName(CloudServicesNetworks.createOrUpdate::parameters.resource,
  "cloudServicesNetworkParameters"
);
@@clientName(CloudServicesNetworks.update::parameters.properties,
  "cloudServicesNetworkUpdateParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CloudServicesNetwork.properties);

@@clientName(ClusterManagers.createOrUpdate::parameters.resource,
  "clusterManagerParameters"
);
@@clientName(ClusterManagers.update::parameters.properties,
  "clusterManagerUpdateParameters"
);
@@clientName(ClusterManagers.updateRelayPrivateEndpointConnection::parameters.body,
  "clusterManagerUpdateRelayPrivateEndpointConnectionParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ClusterManager.properties);

@@clientName(Clusters.createOrUpdate::parameters.resource, "clusterParameters");
@@clientName(Clusters.update::parameters.properties, "clusterUpdateParameters");
@@clientName(Clusters.continueUpdateVersion::parameters.body,
  "clusterContinueUpdateVersionParameters"
);
@@clientName(Clusters.deploy::parameters.body, "clusterDeployParameters");
@@clientName(Clusters.inspect::parameters.body, "clusterInspectParameters");
@@clientName(Clusters.scanRuntime::parameters.body,
  "ClusterScanRuntimeParameters"
);
@@clientName(Clusters.updateVersion::parameters.body,
  "clusterUpdateVersionParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Cluster.properties);

@@clientName(KubernetesClusters.createOrUpdate::parameters.resource,
  "kubernetesClusterParameters"
);
@@clientName(KubernetesClusters.update::parameters.properties,
  "kubernetesClusterUpdateParameters"
);
@@clientName(KubernetesClusters.restartNode::parameters.body,
  "kubernetesClusterRestartNodeParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(KubernetesCluster.properties);

@@clientName(KubernetesVersions.createOrUpdate::parameters.resource,
  "kubernetesVersionParameters"
);
@@clientName(KubernetesVersions.update::parameters.properties,
  "kubernetesVersionPatchParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(KubernetesVersion.properties);

@@clientName(L2Networks.createOrUpdate::parameters.resource,
  "l2NetworkParameters"
);
@@clientName(L2Networks.update::parameters.properties,
  "l2NetworkUpdateParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(L2Network.properties);

@@clientName(L3Networks.createOrUpdate::parameters.resource,
  "l3NetworkParameters"
);
@@clientName(L3Networks.update::parameters.properties,
  "l3NetworkUpdateParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(L3Network.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RackSku.properties);

@@clientName(Racks.createOrUpdate::parameters.resource, "rackParameters");
@@clientName(Racks.update::parameters.properties, "rackUpdateParameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Rack.properties);

@@clientName(StorageAppliances.createOrUpdate::parameters.resource,
  "storageApplianceParameters"
);
@@clientName(StorageAppliances.update::parameters.properties,
  "storageApplianceUpdateParameters"
);
@@clientName(StorageAppliances.enableRemoteVendorManagement::parameters.body,
  "storageApplianceEnableRemoteVendorManagementParameters"
);
@@clientName(StorageAppliances.runReadCommands::parameters.body,
  "storageApplianceRunReadCommandsParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(StorageAppliance.properties);

@@clientName(TrunkedNetworks.createOrUpdate::parameters.resource,
  "trunkedNetworkParameters"
);
@@clientName(TrunkedNetworks.update::parameters.properties,
  "trunkedNetworkUpdateParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(TrunkedNetwork.properties);

@@clientName(VirtualMachines.createOrUpdate::parameters.resource,
  "virtualMachineParameters"
);
@@clientName(VirtualMachines.update::parameters.properties,
  "virtualMachineUpdateParameters"
);
@@clientName(VirtualMachines.assignRelay::parameters.body,
  "virtualMachineAssignRelayParameters"
);
@@clientName(VirtualMachines.powerOff::parameters.body,
  "virtualMachinePowerOffParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(VirtualMachine.properties);

@@clientName(Volumes.createOrUpdate::parameters.resource, "volumeParameters");
@@clientName(Volumes.update::parameters.properties, "volumeUpdateParameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Volume.properties);

@@clientName(BareMetalMachineKeySets.createOrUpdate::parameters.resource,
  "bareMetalMachineKeySetParameters"
);
@@clientName(BareMetalMachineKeySets.update::parameters.properties,
  "bareMetalMachineKeySetUpdateParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(BareMetalMachineKeySet.properties);

@@clientName(BmcKeySets.createOrUpdate::parameters.resource,
  "bmcKeySetParameters"
);
@@clientName(BmcKeySets.update::parameters.properties,
  "bmcKeySetUpdateParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(BmcKeySet.properties);

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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ClusterMetricsConfiguration.properties);

@@clientName(AgentPools.createOrUpdate::parameters.resource,
  "agentPoolParameters"
);
@@clientName(AgentPools.update::parameters.properties,
  "agentPoolUpdateParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AgentPool.properties);

@@clientName(KubernetesClusterFeatures.createOrUpdate::parameters.resource,
  "kubernetesClusterFeatureParameters"
);
@@clientName(KubernetesClusterFeatures.update::parameters.properties,
  "kubernetesClusterFeatureUpdateParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(KubernetesClusterFeature.properties);

@@clientName(Consoles.createOrUpdate::parameters.resource, "consoleParameters");
@@clientName(Consoles.update::parameters.properties, "consoleUpdateParameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Console.properties);

@@clientLocation(RegisteredSubscriptionsOperationGroup.list,
  "RegisteredSubscriptions"
);
@@clientLocation(RegisteredSubscriptionsOperationGroup.get,
  "RegisteredSubscriptions"
);

@@clientLocation(OperationStatusOperationGroup.get, "OperationStatus");
@@clientLocation(OperationStatusOperationGroup.createOrUpdate,
  "OperationStatus"
);
@@clientLocation(OperationStatusOperationGroup.update, "OperationStatus");
