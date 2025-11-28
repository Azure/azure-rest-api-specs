import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.NetworkCloud;

@@clientName(AgentOptions, "NetworkCloudAgentConfiguration", "csharp");

@@alternateType(BareMetalMachineProperties.associatedResourceIds,
  Azure.Core.armResourceIdentifier[],
  "csharp"
);

@@alternateType(BareMetalMachineProperties.clusterId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

@@alternateType(BareMetalMachineProperties.rackId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

@@alternateType(BareMetalMachineProperties.oamIpv4Address,
  Azure.Core.ipV4Address,
  "csharp"
);
@@clientName(BareMetalMachineConfigurationData,
  "BareMetalMachineConfiguration",
  "csharp"
);
@@clientName(BareMetalMachineKeySetProperties.expiration, "ExpireOn", "csharp");
@@alternateType(BareMetalMachineKeySetProperties.jumpHostsAllowed,
  Azure.Core.ipV4Address[],
  "csharp"
);
@@clientName(BareMetalMachineKeySetProperties.lastValidation,
  "LastValidatedOn",
  "csharp"
);
@@clientName(BareMetalMachineKeySetPatchProperties.expiration,
  "ExpireOn",
  "csharp"
);
@@alternateType(BareMetalMachineKeySetPatchProperties.jumpHostsAllowed,
  Azure.Core.ipV4Address,
  "csharp"
);
@@clientName(BmcKeySetProperties.expiration, "ExpireOn", "csharp");
@@clientName(BmcKeySetProperties.lastValidation, "LastValidatedOn", "csharp");
@@clientName(BmcKeySetPatchProperties.expiration, "ExpireOn", "csharp");
@@clientName(BootstrapProtocol.PXE, "Pxe", "csharp");
@@alternateType(ClusterProperties.analyticsWorkspaceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ClusterProperties.clusterManagerId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ClusterProperties.networkFabricId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(ClusterProperties.supportExpiryDate, "SupportExpireOn", "csharp");
@@alternateType(ClusterProperties.supportExpiryDate, utcDateTime, "csharp");
@@clientName(ClusterAvailableUpgradeVersion.supportExpiryDate,
  "SupportExpireOn",
  "csharp"
);
@@alternateType(ClusterAvailableUpgradeVersion.supportExpiryDate,
  utcDateTime,
  "csharp"
);
@@alternateType(ClusterManagerProperties.analyticsWorkspaceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ClusterManagerProperties.fabricControllerId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(CloudServicesNetworkProperties.clusterId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(CloudServicesNetworkProperties.associatedResourceIds,
  Azure.Core.armResourceIdentifier[],
  "csharp"
);
@@alternateType(CloudServicesNetworkProperties.virtualMachinesAssociatedIds,
  Azure.Core.armResourceIdentifier[],
  "csharp"
);

@@alternateType(CloudServicesNetworkProperties.hybridAksClustersAssociatedIds,
  Azure.Core.armResourceIdentifier[],
  "csharp"
);
@@clientName(Console, "NetworkCloudVirtualMachineConsole", "csharp");
@@clientName(ConsoleProperties.expiration, "ExpireOn", "csharp");
@@alternateType(ConsoleProperties.privateLinkServiceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ConsoleProperties.virtualMachineAccessId,
  Azure.Core.uuid,
  "csharp"
);
@@clientName(ConsolePatchProperties.expiration, "ExpireOn", "csharp");
@@clientName(IdentitySelector, "ManagedServiceIdentitySelector", "csharp");
@@clientName(ImageRepositoryCredentials.registryUrl,
  "registryUriString",
  "csharp"
);
@@alternateType(KubernetesClusterProperties.attachedNetworkIds,
  Azure.Core.armResourceIdentifier[],
  "csharp"
);
@@alternateType(KubernetesClusterProperties.clusterId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(KubernetesClusterProperties.connectedClusterId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(KubernetesClusterNode.agentPoolId, "AgentPoolArmId", "csharp");
@@clientName(KubernetesClusterNode.bareMetalMachineId,
  "BareMetalMachineArmId",
  "csharp"
);
@@alternateType(L2NetworkProperties.associatedResourceIds,
  Azure.Core.armResourceIdentifier[],
  "csharp"
);
@@alternateType(L2NetworkProperties.clusterId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(L2NetworkProperties.hybridAksClustersAssociatedIds,
  Azure.Core.armResourceIdentifier[],
  "csharp"
);
@@alternateType(L2NetworkProperties.virtualMachinesAssociatedIds,
  Azure.Core.armResourceIdentifier[],
  "csharp"
);
@@alternateType(L2NetworkAttachmentConfiguration.networkId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(L3NetworkProperties.associatedResourceIds,
  Azure.Core.armResourceIdentifier[],
  "csharp"
);
@@alternateType(L3NetworkProperties.clusterId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(L3NetworkProperties.hybridAksClustersAssociatedIds,
  Azure.Core.armResourceIdentifier[],
  "csharp"
);
@@alternateType(L3NetworkProperties.l3IsolationDomainId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(L3NetworkProperties.virtualMachinesAssociatedIds,
  Azure.Core.armResourceIdentifier[],
  "csharp"
);
@@alternateType(L3NetworkAttachmentConfiguration.networkId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(NetworkAttachment.attachedNetworkId,
  "AttachedNetworkArmId",
  "csharp"
);
@@clientName(NetworkConfiguration,
  "KubernetesClusterNetworkConfiguration",
  "csharp"
);
@@alternateType(NetworkConfiguration.cloudServicesNetworkId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(NetworkConfiguration.cniNetworkId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(NetworkConfiguration.dnsServiceIp,
  Azure.Core.ipV4Address,
  "csharp"
);
@@alternateType(OperationStatusResult.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(OsDisk.diskSizeGB, "DiskSizeInGB", "csharp");
@@alternateType(RackProperties.clusterId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(RackProperties.rackSkuId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(RackDefinition.networkRackId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(RackDefinition.rackSkuId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(StorageApplianceProperties.clusterId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(StorageApplianceProperties.managementIpv4Address,
  Azure.Core.ipV4Address,
  "csharp"
);
@@alternateType(StorageApplianceProperties.rackId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(StorageApplianceConfigurationData,
  "StorageApplianceConfiguration",
  "csharp"
);
@@alternateType(StorageProfile.volumeAttachments,
  Azure.Core.armResourceIdentifier[],
  "csharp"
);
@@alternateType(TrunkedNetworkProperties.clusterId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(TrunkedNetworkProperties.hybridAksClustersAssociatedIds,
  Azure.Core.armResourceIdentifier[],
  "csharp"
);
@@alternateType(TrunkedNetworkProperties.virtualMachinesAssociatedIds,
  Azure.Core.armResourceIdentifier[],
  "csharp"
);
@@alternateType(TrunkedNetworkProperties.isolationDomainIds,
  Azure.Core.armResourceIdentifier[],
  "csharp"
);
@@alternateType(TrunkedNetworkAttachmentConfiguration.networkId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(VirtualMachineProperties.bareMetalMachineId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(VirtualMachineProperties.clusterId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(VirtualMachineProperties.volumes,
  Azure.Core.armResourceIdentifier[],
  "csharp"
);
@@clientName(VirtualMachineProperties.memorySizeGB, "MemorySizeInGB", "csharp");
@@alternateType(VirtualMachinePlacementHint.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(VolumeProperties.sizeMiB, "SizeInMiB", "csharp");
@@clientName(AadConfiguration, "NetworkCloudAadConfiguration", "csharp");
@@clientName(AgentPoolMode, "NetworkCloudAgentPoolMode", "csharp");
@@clientName(AgentPoolPatchParameters, "NetworkCloudAgentPoolPatch", "csharp");
@@clientName(BareMetalMachineKeySetPatchParameters,
  "NetworkCloudBareMetalMachineKeySetPatch",
  "csharp"
);
@@clientName(BmcKeySetPatchParameters, "NetworkCloudBmcKeySetPatch", "csharp");
@@clientName(CloudServicesNetworkPatchParameters,
  "NetworkCloudCloudServicesNetworkPatch",
  "csharp"
);
@@clientName(ClusterManagerPatchParameters,
  "NetworkCloudClusterManagerPatch",
  "csharp"
);
@@clientName(ClusterMetricsConfigurationPatchParameters,
  "NetworkCloudClusterMetricsConfigurationPatch",
  "csharp"
);
@@clientName(ClusterPatchParameters, "NetworkCloudClusterPatch", "csharp");
@@clientName(KubernetesClusterFeaturePatchParameters,
  "NetworkCloudKubernetesClusterFeaturePatch",
  "csharp"
);
@@clientName(AgentPoolPatchParameters, "NetworkCloudAgentPoolPatch", "csharp");
@@clientName(AgentPool, "NetworkCloudAgentPool", "csharp");
@@clientName(KubernetesCluster, "NetworkCloudKubernetesCluster", "csharp");
@@clientName(BareMetalMachine, "NetworkCloudBareMetalMachine", "csharp");
@@clientName(BareMetalMachineKeySet,
  "NetworkCloudBareMetalMachineKeySet",
  "csharp"
);
@@clientName(BmcKeySet, "NetworkCloudBmcKeySet", "csharp");
@@clientName(CloudServicesNetwork,
  "NetworkCloudCloudServicesNetwork",
  "csharp"
);
@@clientName(Cluster, "NetworkCloudCluster", "csharp");
@@clientName(ClusterManager, "NetworkCloudClusterManager", "csharp");
@@clientName(L2Network, "NetworkCloudL2Network", "csharp");
@@clientName(L3Network, "NetworkCloudL3Network", "csharp");
@@clientName(Rack, "NetworkCloudRack", "csharp");
@@clientName(StorageAppliance, "NetworkCloudStorageAppliance", "csharp");
@@clientName(TrunkedNetwork, "NetworkCloudTrunkedNetwork", "csharp");
@@clientName(VirtualMachine, "NetworkCloudVirtualMachine", "csharp");
@@clientName(Volume, "NetworkCloudVolume", "csharp");
@@clientName(ClusterAvailableUpgradeVersion,
  "NetworkCloudClusterAvailableUpgradeVersion",
  "csharp"
);
@@clientName(KubernetesClusterFeature,
  "NetworkCloudKubernetesClusterFeature",
  "csharp"
);
@@clientName(RackSku, "NetworkCloudRackSku", "csharp");
@@clientName(ClusterMetricsConfiguration,
  "NetworkCloudClusterMetricsConfiguration",
  "csharp"
);
@@clientName(NetworkInterface, "NetworkCloudNetworkInterface", "csharp");
@@clientName(Nic, "NetworkCloudNic", "csharp");
@@clientName(OsDisk, "NetworkCloudOSDisk", "csharp");
@@clientName(RackDefinition, "NetworkCloudRackDefinition", "csharp");
@@clientName(SshPublicKey, "NetworkCloudSshPublicKey", "csharp");
@@clientName(StorageProfile, "NetworkCloudStorageProfile", "csharp");
@@clientName(ClusterAvailableUpgradeVersion,
  "ClusterAvailableUpgradeVersion",
  "csharp"
);
@@clientName(OperationStatusResult,
  "NetworkCloudOperationStatusResult",
  "csharp"
);
@@clientName(VirtualMachineBootMethod.BIOS, "Bios", "csharp");
@@clientName(VirtualMachineBootMethod.UEFI, "Uefi", "csharp");
@@clientName(ValidationThreshold.type, "ThresholdType", "csharp");
@@clientName(MachineSkuDiskConnectionType.PCIE, "Pcie", "csharp");
@@clientName(MachineSkuDiskConnectionType.RAID, "Raid", "csharp");
@@clientName(MachineSkuDiskConnectionType.SATA, "Sata", "csharp");
@@clientName(KubernetesPluginType.DPDK, "Dpdk", "csharp");
@@clientName(KubernetesPluginType.IPVLAN, "Ipvlan", "csharp");
@@clientName(KubernetesPluginType.MACVLAN, "Macvlan", "csharp");
@@clientName(KubernetesPluginType.SRIOV, "Sriov", "csharp");
@@alternateType(Azure.ResourceManager.EntityTagProperty.eTag,
  Azure.Core.eTag,
  "csharp"
);
@@alternateType(ClusterProperties.workloadResourceIds,
  Azure.Core.armResourceIdentifier[],
  "csharp"
);
@@clientName(ExtendedLocation.type, "ExtendedLocationType", "csharp");
@@alternateType(BareMetalMachineKeySetPatchProperties.jumpHostsAllowed,
  Azure.Core.ipV4Address[],
  "csharp"
);
@@clientName(HugepagesSize.`1G`, "OneG", "csharp");
@@clientName(HugepagesSize.`2M`, "TwoM", "csharp");
@@clientName(HybridAksPluginType.DPDK, "Dpdk", "csharp");
@@clientName(HybridAksPluginType.SRIOV, "Sriov", "csharp");
@@clientName(MachineDisk.type, "DiskType", "csharp");
@@scope(BareMetalMachines.createOrUpdate, "!csharp");
@@scope(BareMetalMachines.delete, "!csharp");
@@scope(Racks.createOrUpdate, "!csharp");
@@scope(Racks.delete, "!csharp");
@@scope(StorageAppliances.createOrUpdate, "!csharp");
@@scope(StorageAppliances.delete, "!csharp");
@@alternateType(ManagedResourceGroupConfiguration.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@usage(Rack, Usage.input, "csharp");
@@usage(RackSku, Usage.input, "csharp");
@@usage(BareMetalMachine, Usage.input, "csharp");
@@usage(StorageAppliance, Usage.input, "csharp");
