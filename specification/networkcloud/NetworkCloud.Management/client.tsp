import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using Azure.ClientGenerator.Core;
using Azure.Core;
using Microsoft.NetworkCloud;

@@scope(BareMetalMachines.createOrUpdate, "!csharp");
@@scope(BareMetalMachines.delete, "!csharp");
@@scope(Racks.createOrUpdate, "!csharp");
@@scope(Racks.delete, "!csharp");
@@scope(StorageAppliances.createOrUpdate, "!csharp");
@@scope(StorageAppliances.delete, "!csharp");

// --- go ---
@@clientName(HugepagesSize.`1G`, "OneG", "go");
@@clientName(HugepagesSize.`2M`, "TwoM", "go");
@@alternateType(Azure.ResourceManager.Foundations.ExtendedLocation.type,
  string,
  "go"
);

// --- csharp ---
// Map eTag from spread alias to Azure.ETag? for ApiCompat (property name is 'etag' lowercase)
@@alternateType(AccessBridge.etag, eTag, "csharp");
@@alternateType(AgentPool.etag, eTag, "csharp");
@@alternateType(BareMetalMachine.etag, eTag, "csharp");
@@alternateType(BareMetalMachineKeySet.etag, eTag, "csharp");
@@alternateType(BmcKeySet.etag, eTag, "csharp");
@@alternateType(CloudServicesNetwork.etag, eTag, "csharp");
@@alternateType(Cluster.etag, eTag, "csharp");
@@alternateType(ClusterManager.etag, eTag, "csharp");
@@alternateType(ClusterMetricsConfiguration.etag, eTag, "csharp");
@@alternateType(Console.etag, eTag, "csharp");
@@alternateType(KubernetesCluster.etag, eTag, "csharp");
@@alternateType(KubernetesVersion.etag, eTag, "csharp");
@@alternateType(L2Network.etag, eTag, "csharp");
@@alternateType(L3Network.etag, eTag, "csharp");
@@alternateType(Rack.etag, eTag, "csharp");
@@alternateType(StorageAppliance.etag, eTag, "csharp");
@@alternateType(TrunkedNetwork.etag, eTag, "csharp");
@@alternateType(VirtualMachine.etag, eTag, "csharp");
@@alternateType(Volume.etag, eTag, "csharp");
@@alternateType(KubernetesClusterFeature.etag, eTag, "csharp");
@@alternateType(EntityTagProperty.eTag, eTag, "csharp");

@@clientName(AgentOptions, "NetworkCloudAgentConfiguration", "csharp");
@@alternateType(BareMetalMachineProperties.associatedResourceIds,
  armResourceIdentifier[],
  "csharp"
);
@@alternateType(BareMetalMachineProperties.clusterId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(BareMetalMachineProperties.rackId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(BareMetalMachineProperties.oamIpv4Address,
  ipV4Address,
  "csharp"
);
@@clientName(BareMetalMachineProperties.caCertificate,
  "CACertificate",
  "csharp"
);
@@clientName(BareMetalMachineConfigurationData,
  "BareMetalMachineConfiguration",
  "csharp"
);
@@clientName(AccessBridge, "NetworkCloudAccessBridge", "csharp");
@@clientName(KubernetesVersion, "NetworkCloudKubernetesVersion", "csharp");
@@clientName(DeploymentType, "NetworkCloudDeploymentType", "csharp");
@@clientName(BareMetalMachineKeySetProperties.expiration, "ExpireOn", "csharp");
@@alternateType(BareMetalMachineKeySetProperties.jumpHostsAllowed,
  ipV4Address[],
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
  ipV4Address,
  "csharp"
);
@@clientName(BmcKeySetProperties.expiration, "ExpireOn", "csharp");
@@clientName(BmcKeySetProperties.lastValidation, "LastValidatedOn", "csharp");
@@clientName(BmcKeySetPatchProperties.expiration, "ExpireOn", "csharp");
@@clientName(BootstrapProtocol.PXE, "Pxe", "csharp");
@@alternateType(ClusterProperties.analyticsWorkspaceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(ClusterProperties.clusterManagerId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(ClusterProperties.networkFabricId,
  armResourceIdentifier,
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
  armResourceIdentifier,
  "csharp"
);
@@alternateType(ClusterManagerProperties.fabricControllerId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(CloudServicesNetworkProperties.clusterId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(CloudServicesNetworkProperties.associatedResourceIds,
  armResourceIdentifier[],
  "csharp"
);
@@alternateType(CloudServicesNetworkProperties.virtualMachinesAssociatedIds,
  armResourceIdentifier[],
  "csharp"
);
@@alternateType(CloudServicesNetworkProperties.hybridAksClustersAssociatedIds,
  armResourceIdentifier[],
  "csharp"
);
@@clientName(Console, "NetworkCloudVirtualMachineConsole", "csharp");
@@clientName(ConsoleProperties.expiration, "ExpireOn", "csharp");
@@alternateType(ConsoleProperties.privateLinkServiceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(ConsoleProperties.virtualMachineAccessId, uuid, "csharp");
@@clientName(ConsolePatchProperties.expiration, "ExpireOn", "csharp");
@@clientName(IdentitySelector, "ManagedServiceIdentitySelector", "csharp");
@@clientName(ImageRepositoryCredentials.registryUrl,
  "registryUriString",
  "csharp"
);
@@alternateType(KubernetesClusterProperties.attachedNetworkIds,
  armResourceIdentifier[],
  "csharp"
);
@@alternateType(KubernetesClusterProperties.clusterId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(KubernetesClusterProperties.connectedClusterId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(KubernetesClusterNode.agentPoolId, "AgentPoolArmId", "csharp");
@@clientName(KubernetesClusterNode.bareMetalMachineId,
  "BareMetalMachineArmId",
  "csharp"
);
@@alternateType(L2NetworkProperties.associatedResourceIds,
  armResourceIdentifier[],
  "csharp"
);
@@alternateType(L2NetworkProperties.clusterId, armResourceIdentifier, "csharp");
@@alternateType(L2NetworkProperties.hybridAksClustersAssociatedIds,
  armResourceIdentifier[],
  "csharp"
);
@@alternateType(L2NetworkProperties.l2IsolationDomainId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(L2NetworkProperties.virtualMachinesAssociatedIds,
  armResourceIdentifier[],
  "csharp"
);
@@alternateType(L2NetworkAttachmentConfiguration.networkId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(L3NetworkProperties.associatedResourceIds,
  armResourceIdentifier[],
  "csharp"
);
@@alternateType(L3NetworkProperties.clusterId, armResourceIdentifier, "csharp");
@@alternateType(L3NetworkProperties.hybridAksClustersAssociatedIds,
  armResourceIdentifier[],
  "csharp"
);
@@alternateType(L3NetworkProperties.l3IsolationDomainId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(L3NetworkProperties.virtualMachinesAssociatedIds,
  armResourceIdentifier[],
  "csharp"
);
@@alternateType(L3NetworkAttachmentConfiguration.networkId,
  armResourceIdentifier,
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
  armResourceIdentifier,
  "csharp"
);
@@alternateType(NetworkConfiguration.cniNetworkId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(NetworkConfiguration.dnsServiceIp, ipV4Address, "csharp");
@@alternateType(OperationStatusResult.id, armResourceIdentifier, "csharp");
@@clientName(OsDisk.diskSizeGb, "DiskSizeInGB", "csharp");
@@alternateType(RackProperties.clusterId, armResourceIdentifier, "csharp");
@@alternateType(RackProperties.rackSkuId, armResourceIdentifier, "csharp");
@@alternateType(RackDefinition.networkRackId, armResourceIdentifier, "csharp");
@@alternateType(RackDefinition.rackSkuId, armResourceIdentifier, "csharp");
@@clientName(StorageApplianceProperties.caCertificate,
  "CACertificate",
  "csharp"
);
@@alternateType(StorageApplianceProperties.clusterId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(StorageApplianceProperties.managementIpv4Address,
  ipV4Address,
  "csharp"
);
@@alternateType(StorageApplianceProperties.rackId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(StorageApplianceConfigurationData,
  "StorageApplianceConfiguration",
  "csharp"
);
@@alternateType(StorageProfile.volumeAttachments,
  armResourceIdentifier[],
  "csharp"
);
@@alternateType(TrunkedNetworkProperties.clusterId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(TrunkedNetworkProperties.hybridAksClustersAssociatedIds,
  armResourceIdentifier[],
  "csharp"
);
@@alternateType(TrunkedNetworkProperties.virtualMachinesAssociatedIds,
  armResourceIdentifier[],
  "csharp"
);
@@alternateType(TrunkedNetworkProperties.isolationDomainIds,
  armResourceIdentifier[],
  "csharp"
);
@@alternateType(TrunkedNetworkAttachmentConfiguration.networkId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(VirtualMachineProperties.bareMetalMachineId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(VirtualMachineProperties.clusterId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(VirtualMachineProperties.volumes,
  armResourceIdentifier[],
  "csharp"
);
@@clientName(VirtualMachineProperties.memorySizeGb, "MemorySizeInGB", "csharp");
@@alternateType(VirtualMachinePlacementHint.resourceId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(VolumeProperties.sizeMiB, "SizeInMiB", "csharp");
@@clientName(VolumeProperties.allocatedSizeMiB, "AllocatedInSizeMiB", "csharp");
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
@@alternateType(ClusterProperties.workloadResourceIds,
  armResourceIdentifier[],
  "csharp"
);
@@clientName(Azure.ResourceManager.Foundations.ExtendedLocation.type,
  "ExtendedLocationType",
  "csharp"
);
@@alternateType(BareMetalMachineKeySetPatchProperties.jumpHostsAllowed,
  ipV4Address[],
  "csharp"
);
@@clientName(HugepagesSize.`1G`, "OneG", "csharp");
@@clientName(HugepagesSize.`2M`, "TwoM", "csharp");
@@clientName(HybridAksPluginType.DPDK, "Dpdk", "csharp");
@@clientName(HybridAksPluginType.SRIOV, "Sriov", "csharp");
@@clientName(MachineDisk.type, "DiskType", "csharp");
@@alternateType(ManagedResourceGroupConfiguration.location,
  azureLocation,
  "csharp"
);
@@usage(Rack, Usage.input, "csharp");
@@usage(RackSku, Usage.input, "csharp");
@@usage(BareMetalMachine, Usage.input, "csharp");
@@usage(StorageAppliance, Usage.input, "csharp");
@@clientName(ActionState, "NetworkCloudActionState", "csharp");
@@clientName(ActionState.endTime, "EndOn", "csharp");
@@clientName(ActionStateStatus, "NetworkCloudActionStateStatus", "csharp");
@@clientName(CertificateInfo, "NetworkCloudCertificateInfo", "csharp");
@@clientName(StepState, "NetworkCloudStepState", "csharp");
@@clientName(StepState.endTime, "EndOn", "csharp");
@@clientName(StepState.startTime, "StartOn", "csharp");
@@clientName(StepStateStatus, "NetworkCloudStepStateStatus", "csharp");
@@alternateType(ActionState.endTime, utcDateTime, "csharp");
@@alternateType(StepState.endTime, utcDateTime, "csharp");
@@alternateType(StepState.startTime, utcDateTime, "csharp");
@@clientName(BareMetalMachineCordonParameters,
  "BareMetalMachineCordonContent",
  "csharp"
);
@@clientName(BareMetalMachinePowerOffParameters,
  "BareMetalMachinePowerOffContent",
  "csharp"
);
@@clientName(BareMetalMachineReplaceParameters,
  "BareMetalMachineReplaceContent",
  "csharp"
);
@@clientName(BareMetalMachineRunCommandParameters,
  "BareMetalMachineRunCommandContent",
  "csharp"
);
@@clientName(BareMetalMachineRunDataExtractsParameters,
  "BareMetalMachineRunDataExtractsContent",
  "csharp"
);
@@clientName(BareMetalMachineRunReadCommandsParameters,
  "BareMetalMachineRunReadCommandsContent",
  "csharp"
);
@@clientName(ClusterContinueUpdateVersionParameters,
  "ClusterContinueUpdateVersionContent",
  "csharp"
);
@@clientName(ClusterDeployParameters, "ClusterDeployContent", "csharp");
@@clientName(ClusterScanRuntimeParameters,
  "ClusterScanRuntimeContent",
  "csharp"
);
@@clientName(ClusterUpdateVersionParameters,
  "ClusterUpdateVersionContent",
  "csharp"
);
@@clientName(KubernetesClusterRestartNodeParameters,
  "KubernetesClusterRestartNodeContent",
  "csharp"
);
@@clientName(StorageApplianceEnableRemoteVendorManagementParameters,
  "StorageApplianceEnableRemoteVendorManagementContent",
  "csharp"
);
@@clientName(StorageApplianceRunReadCommandsParameters,
  "StorageApplianceRunReadCommandsContent",
  "csharp"
);
@@clientName(VirtualMachineAssignRelayParameters,
  "VirtualMachineAssignRelayContent",
  "csharp"
);
@@clientName(VirtualMachinePowerOffParameters,
  "VirtualMachinePowerOffContent",
  "csharp"
);
@@clientName(CloudServicesNetworkEnableDefaultEgressEndpoints,
  "CloudServicesNetworkEnableDefaultEgressEndpoint",
  "csharp"
);
@@clientName(IpAddressPool, "IPAddressPool", "csharp");
@@clientName(IpAllocationType, "IPAllocationType", "csharp");
@@clientName(OsDiskCreateOption, "OSDiskCreateOption", "csharp");
@@clientName(OsDiskDeleteOption, "OSDiskDeleteOption", "csharp");
@@clientName(RelayType, "VirtualMachineAssignRelayType", "csharp");
@@clientName(BareMetalMachineKeySetSpec.osGroupName, "OSGroupName", "csharp");
@@clientName(BareMetalMachineStatus.oamIpv4Address, "OamIPv4Address", "csharp");
@@clientName(BareMetalMachineStatus.oamIpv6Address, "OamIPv6Address", "csharp");
@@clientName(BareMetalMachineStatus.osImage, "OSImage", "csharp");
@@clientName(BgpAdvertisement.ipAddressPools, "IPAddressPools", "csharp");
@@clientName(BgpServiceLoadBalancerConfiguration.ipAddressPools,
  "IPAddressPools",
  "csharp"
);
@@clientName(IpAddressPool.onlyUseHostIps, "OnlyUseHostIPs", "csharp");
@@clientName(L3NetworkSpec.ipAllocationType, "IPAllocationType", "csharp");
@@clientName(L3NetworkSpec.ipv4ConnectedPrefix,
  "IPv4ConnectedPrefix",
  "csharp"
);
@@clientName(L3NetworkSpec.ipv6ConnectedPrefix,
  "IPv6ConnectedPrefix",
  "csharp"
);
@@clientName(NetworkAttachment.ipAllocationMethod,
  "IPAllocationMethod",
  "csharp"
);
@@clientName(NetworkAttachment.ipv4Address, "IPv4Address", "csharp");
@@clientName(NetworkAttachment.ipv6Address, "IPv6Address", "csharp");
@@clientName(NetworkConfiguration.dnsServiceIp, "DnsServiceIP", "csharp");
@@clientName(L2ServiceLoadBalancerConfiguration.ipAddressPools,
  "L2ServiceLoadBalancerIPAddressPools",
  "csharp"
);
@@clientName(StorageApplianceStatus.caCertificate, "CACertificate", "csharp");
@@clientName(StorageApplianceStatus.managementIpv4Address,
  "ManagementIPv4Address",
  "csharp"
);
@@clientName(StorageProfile.osDisk, "OSDisk", "csharp");
@@clientName(ClusterInspectParameters, "ClusterInspectContent", "csharp");
@@clientName(ClusterManagerUpdateRelayPrivateEndpointConnectionParameters,
  "ClusterManagerUpdateRelayPrivateEndpointConnectionContent",
  "csharp"
);
@@clientName(FilterDevices, "NetworkCloudFilterDevices", "csharp");
@@clientName(TransportProtocol.TCP, "Tcp", "csharp");
@@clientName(TransportProtocol.UDP, "Udp", "csharp");
@@clientName(VolumeSpec.sizeMiB, "AllocatedInSizeMiB", "csharp");
@@clientName(VolumeStatus.allocatedSizeMiB, "AllocatedInSizeMiB", "csharp");
