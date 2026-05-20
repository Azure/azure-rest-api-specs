import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Microsoft.AzureStackHCI;

@@clientName(Microsoft.AzureStackHCI, "AzureStackHCIVmClient", "python");
@@clientName(Microsoft.AzureStackHCI, "AzureStackHciVmMgmtClient", "java");
@@clientName(Microsoft.AzureStackHCI,
  "AzureStackHCIVMManagementClient",
  "javascript"
);

@@clientName(Route, "HciVmNetworkingRoute", "csharp");
@@clientName(RouteTable, "HciVmNetworkingRouteTable", "csharp");
@@clientName(Subnet, "HciVmNetworkingSubnet", "csharp");
@@clientName(Status, "HciVmOperationStatus", "csharp");
@@clientName(StatusTypes, "HybridMachineAgentInstallationStatusType", "csharp");
@@clientName(SecurityTypes, "HciVmSecurityType", "csharp");
@@clientName(IPPool, "HciVmNetworkingIPPool", "csharp");
@@clientName(ProvisioningStateEnum, "HciVmProvisioningState", "csharp");
@@clientName(StatusLevelTypes, "HciVmStatusLevelType", "csharp");
@@clientName(PowerStateEnum, "HciVmPowerState", "csharp");
@@clientName(ProvisioningAction, "GuestAgentProvisioningAction", "csharp");
@@clientName(SshConfiguration, "HciVmOSProfileSshConfiguration", "csharp");
@@clientName(SshPublicKey, "HciVmOSProfileSshPublicKey", "csharp");
@@clientName(AttestationStatus, "HciVmAttestationStatus", "csharp");
@@clientName(AttestationStatusProperties,
  "HciVmAttestationStatusProperties",
  "csharp"
);
@@clientName(GalleryImage, "HciVmGalleryImage", "csharp");
@@clientName(GalleryImageProperties, "HciVmGalleryImageProperties", "csharp");
@@clientName(GalleryImageProperties.osType, "OSType", "csharp");
@@clientName(GuestAgent, "HciVmGuestAgent", "csharp");
@@clientName(GuestAgentProperties, "HciVmGuestAgentProperties", "csharp");
@@clientName(HybridIdentityMetadata, "HciVmHybridIdentityMetadata", "csharp");
@@clientName(HybridIdentityMetadataProperties,
  "HciVmHybridIdentityMetadataProperties",
  "csharp"
);
@@clientName(LogicalNetwork, "HciVmLogicalNetwork", "csharp");
@@clientName(LogicalNetworkProperties,
  "HciVmLogicalNetworkProperties",
  "csharp"
);
@@clientName(MarketplaceGalleryImage, "HciVmMarketplaceGalleryImage", "csharp");
@@clientName(MarketplaceGalleryImageProperties,
  "HciVmMarketplaceGalleryImageProperties",
  "csharp"
);
@@clientName(MarketplaceGalleryImageProperties.osType, "OSType", "csharp");
@@clientName(NetworkInterface, "HciVmNetworkInterface", "csharp");
@@clientName(NetworkInterfaceProperties,
  "HciVmNetworkInterfaceProperties",
  "csharp"
);
@@clientName(NetworkInterfacesUpdateProperties,
  "HciVmNetworkInterfacePatchProperties",
  "csharp"
);
@@clientName(NetworkSecurityGroup, "HciVmNetworkSecurityGroup", "csharp");
@@clientName(NetworkSecurityGroupProperties,
  "HciVmNetworkSecurityGroupProperties",
  "csharp"
);
@@clientName(SecurityRule, "HciVmSecurityRule", "csharp");
@@clientName(SecurityRuleProperties, "HciVmSecurityRuleProperties", "csharp");
@@clientName(StorageContainer, "HciVmStorageContainer", "csharp");
@@clientName(StorageContainerProperties,
  "HciVmStorageContainerProperties",
  "csharp"
);
@@clientName(VirtualMachineInstance, "HciVmInstance", "csharp");
@@clientName(VirtualMachineInstanceProperties,
  "HciVmInstanceProperties",
  "csharp"
);
@@clientName(VirtualMachineInstanceProperties.createFromLocal,
  "IsCreatingFromLocal",
  "csharp"
);
@@clientName(VirtualMachineInstanceUpdateProperties,
  "HciVmInstancePatchProperties",
  "csharp"
);
@@clientName(VirtualHardDisk, "HciVmVirtualHardDisk", "csharp");
@@clientName(VirtualHardDiskProperties,
  "HciVmVirtualHardDiskProperties",
  "csharp"
);
@@clientName(VirtualHardDiskProperties.blockSizeBytes,
  "BlockSizeInBytes",
  "csharp"
);
@@clientName(VirtualHardDiskProperties.diskSizeGB, "DiskSizeInGB", "csharp");
@@clientName(VirtualHardDiskProperties.logicalSectorBytes,
  "LogicalSectorInBytes",
  "csharp"
);
@@clientName(VirtualHardDiskProperties.physicalSectorBytes,
  "PhysicalSectorInBytes",
  "csharp"
);
@@alternateType(VirtualHardDiskProperties.downloadUrl, url, "csharp");
@@clientName(VirtualHardDiskProperties.createFromLocal,
  "IsCreatingFromLocal",
  "csharp"
);
@@clientName(VirtualHardDisksUpdateProperties,
  "HciVmVirtualHardDiskPatchProperties",
  "csharp"
);
@@clientName(AttestBootIntegrityPropertyEnum,
  "AttestBootIntegrityStatus",
  "csharp"
);
@@clientName(AttestCertPropertyEnum, "AttestCertValidationStatus", "csharp");
@@clientName(AttestDiskSecurityEncryptionTypeEnum.NonPersistedTPM,
  "NonPersistedTpm",
  "csharp"
);
@@clientName(AttestDiskSecurityEncryptionTypeEnum,
  "AttestDiskSecurityEncryptionType",
  "csharp"
);
@@clientName(AttestHealthStatusEnum, "AttestHealthStatus", "csharp");
@@clientName(AttestHWPlatformEnum, "AttestHardwarePlatformType", "csharp");
@@clientName(AttestHWPlatformEnum.SEVSNP, "Sevsnp", "csharp");
@@clientName(AttestSecureBootPropertyEnum, "AttestSecureBootStatus", "csharp");
@@clientName(DiskFileFormat, "HciVmDiskFileFormat", "csharp");
@@clientName(ExtendedLocation, "HciVmExtendedLocation", "csharp");
@@clientName(ExtendedLocationTypes, "HciVmExtendedLocationType", "csharp");
@@clientName(GalleryImageIdentifier, "HciVmGalleryImageIdentifier", "csharp");
@@clientName(GalleryImageStatus, "HciVmGalleryImageStatus", "csharp");
@@clientName(GalleryImageStatusProvisioningStatus,
  "HciVmGalleryImageProvisioningStatus",
  "csharp"
);
@@clientName(GalleryImageVersion, "HciVmGalleryImageVersion", "csharp");
@@clientName(GpuAssignmentTypeEnum, "GpuAssignmentType", "csharp");
@@clientName(GpuAssignmentTypeEnum.GpuDDA, "GpuDda", "csharp");
@@clientName(GuestCredential, "HciVmGuestCredential", "csharp");
@@clientName(GuestAgentInstallStatus.lastStatusChange,
  "LastStatusChangedOn",
  "csharp"
);
@@clientName(HardwareProfileUpdate,
  "HciVmInstanceHardwareProfileUpdate",
  "csharp"
);
@@clientName(HardwareProfileUpdate.memoryMB, "MemoryInMB", "csharp");
@@clientName(HttpProxyConfiguration, "HciVmHttpProxyConfiguration", "csharp");
@@clientName(HyperVGeneration, "HciVmHyperVGeneration", "csharp");
@@clientName(InstanceViewStatus, "HciVmInstanceViewStatus", "csharp");
@@clientName(IpAllocationMethodEnum, "HciVmIPAllocationMethod", "csharp");
@@clientName(IPConfiguration, "HciVmIPConfiguration", "csharp");
@@clientName(IPConfigurationProperties,
  "HciVmIPConfigurationProperties",
  "csharp"
);
@@clientName(IPPoolInfo, "HciVmIPPoolInfo", "csharp");
@@clientName(IPPoolTypeEnum, "HciVmIPPoolType", "csharp");
@@clientName(IPPoolTypeEnum.vippool, "VipPool", "csharp");
@@clientName(LogicalNetworkPropertiesDhcpOptions,
  "HciVmLogicalNetworkDhcpOptions",
  "csharp"
);
@@clientName(LogicalNetworkStatus, "HciVmLogicalNetworkStatus", "csharp");
@@clientName(LogicalNetworkStatusProvisioningStatus,
  "HciVmLogicalNetworkProvisioningStatus",
  "csharp"
);
@@clientName(LogicalNetworkTypeEnum, "HciVmLogicalNetworkType", "csharp");
@@clientName(MarketplaceGalleryImageStatus,
  "HciVmMarketplaceGalleryImageStatus",
  "csharp"
);
@@clientName(MarketplaceGalleryImageStatusProvisioningStatus,
  "HciVmMarketplaceGalleryImageProvisioningStatus",
  "csharp"
);
@@clientName(NetworkInterfaceStatus, "HciVmNetworkInterfaceStatus", "csharp");
@@clientName(NetworkInterfaceStatusProvisioningStatus,
  "HciVmNetworkInterfaceProvisioningStatus",
  "csharp"
);
@@clientName(NetworkSecurityGroupStatus,
  "HciVmNetworkSecurityGroupStatus",
  "csharp"
);
@@clientName(NetworkSecurityGroupStatusProvisioningStatus,
  "HciVmNetworkSecurityGroupProvisioningStatus",
  "csharp"
);
@@clientName(OperatingSystemTypes, "HciVmOSType", "csharp");
@@clientName(OsProfileUpdate, "HciVmOSProfile", "csharp");
@@clientName(OsProfileUpdateLinuxConfiguration,
  "HciVmOSProfileLinuxConfiguration",
  "csharp"
);
@@clientName(OsProfileUpdateWindowsConfiguration,
  "HciVmOSProfileWindowsConfiguration",
  "csharp"
);
@@clientName(SecurityEncryptionType, "HciVmSecurityEncryptionType", "csharp");
@@clientName(SecurityEncryptionType.NonPersistedTPM,
  "NonPersistedTpm",
  "csharp"
);
@@clientName(SecurityRuleAccess, "HciVmSecurityRuleAccess", "csharp");
@@clientName(SecurityRuleDirection, "HciVmSecurityRuleDirection", "csharp");
@@clientName(SecurityRuleProtocol, "HciVmSecurityRuleProtocol", "csharp");
@@clientName(StorageContainerStatus, "HciVmStorageContainerStatus", "csharp");
@@clientName(StorageContainerStatus.availableSizeMB,
  "AvailableSizeInMB",
  "csharp"
);
@@clientName(StorageContainerStatus.containerSizeMB,
  "ContainerSizeInMB",
  "csharp"
);
@@clientName(StorageContainerStatusProvisioningStatus,
  "HciVmStorageContainerProvisioningStatus",
  "csharp"
);
@@clientName(VirtualHardDiskDownloadStatus,
  "HciVmVirtualHardDiskDownloadStatus",
  "csharp"
);
@@clientName(VirtualHardDiskStatus, "HciVmVirtualHardDiskStatus", "csharp");
@@clientName(VirtualHardDiskStatusProvisioningStatus,
  "HciVmVirtualHardDiskProvisioningStatus",
  "csharp"
);
@@clientName(VirtualHardDiskUploadRequest,
  "HciVmVirtualHardDiskUploadContent",
  "csharp"
);
@@clientName(VirtualHardDiskUploadRequest.azureManagedDiskUploadUrl,
  "ManagedDiskUploadUri",
  "csharp"
);
@@alternateType(VirtualHardDiskUploadRequest.azureManagedDiskUploadUrl,
  url,
  "csharp"
);
@@clientName(VirtualHardDiskUploadResponse,
  "HciVmVirtualHardDiskUploadResult",
  "csharp"
);
@@clientName(VirtualHardDiskUploadStatus,
  "HciVmVirtualHardDiskUploadStatus",
  "csharp"
);
@@clientName(VirtualMachineConfigAgentInstanceView,
  "HciVmConfigAgentInstanceView",
  "csharp"
);
@@clientName(VirtualMachineInstancePropertiesHardwareProfile,
  "HciVmInstanceHardwareProfile",
  "csharp"
);
@@clientName(VirtualMachineInstancePropertiesHardwareProfile.memoryMB,
  "MemoryInMB",
  "csharp"
);
@@clientName(VirtualMachineInstancePropertiesHardwareProfileDynamicMemoryConfig,
  "HciVmInstanceHardwareProfileDynamicMemoryConfiguration",
  "csharp"
);
@@clientName(VirtualMachineInstancePropertiesHardwareProfileDynamicMemoryConfig.maximumMemoryMB,
  "MaximumMemoryInMB",
  "csharp"
);
@@clientName(VirtualMachineInstancePropertiesHardwareProfileDynamicMemoryConfig.minimumMemoryMB,
  "MinimumMemoryInMB",
  "csharp"
);
@@clientName(VirtualMachineInstancePropertiesHardwareProfileVirtualMachineGPU,
  "HciVmInstanceHardwareProfileGpuConfiguration",
  "csharp"
);
@@clientName(VirtualMachineInstancePropertiesHardwareProfileVirtualMachineGPU.partitionSizeMB,
  "PartitionSizeInMB",
  "csharp"
);
@@clientName(VirtualMachineInstancePropertiesOsProfile,
  "HciVmInstanceOSProfile",
  "csharp"
);
@@clientName(VirtualMachineInstancePropertiesOsProfileLinuxConfiguration,
  "HciVmInstanceOSProfileLinuxConfiguration",
  "csharp"
);
@@clientName(VirtualMachineInstancePropertiesOsProfileWindowsConfiguration,
  "HciVmInstanceOSProfileWindowsConfiguration",
  "csharp"
);
@@clientName(VirtualMachineInstancePropertiesPlacementProfile,
  "HciVmInstancePlacementProfile",
  "csharp"
);
@@clientName(VirtualMachineInstancePropertiesSecurityProfile,
  "HciVmInstanceSecurityProfile",
  "csharp"
);
@@clientName(VirtualMachineInstancePropertiesSecurityProfile.enableTPM,
  "IsTpmEnabled",
  "csharp"
);
@@clientName(VirtualMachineInstancePropertiesStorageProfile,
  "HciVmInstanceStorageProfile",
  "csharp"
);
@@clientName(VirtualMachineInstancePropertiesStorageProfileOsDisk,
  "HciVmInstanceStorageProfileOSDisk",
  "csharp"
);
@@clientName(VirtualMachineInstancePropertiesStorageProfileOsDisk.osType,
  "OSType",
  "csharp"
);
@@clientName(VirtualMachineInstanceStatus, "HciVmInstanceStatus", "csharp");
@@clientName(VirtualMachineInstanceStatusProvisioningStatus,
  "HciVmInstanceProvisioningStatus",
  "csharp"
);
@@clientName(VmSizeEnum, "HciVmSize", "csharp");
@@clientName(VirtualMachineInstanceManagedDiskParameters,
  "VirtualMachineInstanceManagedDiskContent",
  "csharp"
);
@@clientName(VirtualMachineInstancePropertiesOsProfileLinuxConfiguration.provisionVMAgent,
  "ProvisionVmAgent",
  "csharp"
);
@@clientName(VirtualMachineInstancePropertiesOsProfileLinuxConfiguration.provisionVMConfigAgent,
  "ProvisionVmConfigAgent",
  "csharp"
);
@@clientName(VirtualMachineInstancePropertiesOsProfileWindowsConfiguration.provisionVMAgent,
  "ProvisionVmAgent",
  "csharp"
);
@@clientName(VirtualMachineInstancePropertiesOsProfileWindowsConfiguration.provisionVMConfigAgent,
  "ProvisionVmConfigAgent",
  "csharp"
);
@@clientName(OsProfileUpdateLinuxConfiguration.provisionVMAgent,
  "ProvisionVmAgent",
  "csharp"
);
@@clientName(OsProfileUpdateLinuxConfiguration.provisionVMConfigAgent,
  "ProvisionVmConfigAgent",
  "csharp"
);
@@clientName(OsProfileUpdateWindowsConfiguration.provisionVMAgent,
  "ProvisionVmAgent",
  "csharp"
);
@@clientName(OsProfileUpdateWindowsConfiguration.provisionVMConfigAgent,
  "ProvisionVmConfigAgent",
  "csharp"
);
@@alternateType(VirtualMachineInstanceUpdateRequest.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(HybridIdentityMetadataProperties.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@clientName(NetworkInterfaceArmReference,
  "HciVmNetworkInterfaceArmReference",
  "csharp"
);
@@clientName(VirtualHardDiskArmReference,
  "HciVmVirtualHardDiskArmReference",
  "csharp"
);
@@clientName(LogicalNetworkArmReference,
  "HciVmLogicalNetworkArmReference",
  "csharp"
);
@@clientName(SubnetIpConfigurationReference,
  "HciVmSubnetIPConfigurationReference",
  "csharp"
);
@@clientName(IPConfigurationArmReference,
  "HciVmIPConfigurationArmReference",
  "csharp"
);
@@clientName(VirtualMachineInstanceProperties.hostNodeIpAddress,
  "HostNodeIPAddress",
  "csharp"
);
@@clientName(VirtualMachineInstanceProperties.osProfile, "OSProfile", "csharp");
@@clientName(VirtualMachineInstanceUpdateProperties.osProfile,
  "OSProfile",
  "csharp"
);
@@clientName(VirtualMachineInstancePropertiesStorageProfile.osDisk,
  "OSDisk",
  "csharp"
);
@@clientName(IPPool.ipPoolType, "IPPoolType", "csharp");
@@clientName(RouteProperties.nextHopIpAddress, "nextHopIPAddress", "csharp");
@@clientName(SubnetProperties.ipAllocationMethod,
  "IPAllocationMethod",
  "csharp"
);
@@clientName(SubnetProperties.ipConfigurationReferences,
  "IPConfigurationReferences",
  "csharp"
);
@@clientName(SubnetProperties.ipPools, "IPPools", "csharp");
@@clientName(NetworkInterfaceProperties.ipConfigurations,
  "IPConfigurations",
  "csharp"
);
@@clientName(VirtualNetworkSubnetProperties.ipConfigurations,
  "IPConfigurations",
  "csharp"
);
@@clientName(SecurityTypes.ConfidentialVM, "ConfidentialVm", "csharp");
@@clientName(GalleryImageVersionStorageProfile,
  "HciVmGalleryImageVersionStorageProfile",
  "csharp"
);
@@clientName(GalleryImageVersionStorageProfile.osDiskImage,
  "OSDiskImage",
  "csharp"
);
@@clientName(LoadBalancer, "HciVmLoadBalancer", "csharp");
@@clientName(LoadBalancerProperties, "HciVmLoadBalancerProperties", "csharp");
@@clientName(NatGateway, "HciVmNatGateway", "csharp");
@@clientName(NatGatewayProperties, "HciVmNatGatewayProperties", "csharp");
@@clientName(NatGatewayProperties.inboundNATRules, "InboundNatRules", "csharp");
@@clientName(PublicIPAddress, "HciVmPublicIPAddress", "csharp");
@@clientName(PublicIPAddressProperties,
  "HciVmPublicIPAddressProperties",
  "csharp"
);
@@clientName(VirtualNetwork, "HciVmVirtualNetwork", "csharp");
@@clientName(VirtualNetworkProperties,
  "HciVmVirtualNetworkProperties",
  "csharp"
);
@@clientName(VirtualNetworkSubnet, "HciVmVirtualNetworkSubnet", "csharp");
@@clientName(VirtualNetworkSubnetProperties,
  "HciVmVirtualNetworkSubnetProperties",
  "csharp"
);
@@clientName(BackendAddressPool, "HciVmBackendAddressPool", "csharp");
@@clientName(BackendAddressPoolProperties,
  "HciVmBackendAddressPoolProperties",
  "csharp"
);
@@clientName(FabricConnectionHealthEnum,
  "HciVmFabricConnectionHealthStateType",
  "csharp"
);
@@clientName(FabricIntegrationStateEnum,
  "HciVmFabricIntegrationStateType",
  "csharp"
);
@@clientName(FabricIntegrationStatus, "HciVmFabricIntegrationStatus", "csharp");
@@clientName(FabricIntegrationStatus.lastChecked, "LastCheckedOn", "csharp");
@@clientName(FabricIssue, "HciVmFabricIssue", "csharp");
@@clientName(FabricResourceTypeEnum, "HciVmFabricResourceType", "csharp");
@@clientName(FrontendIPConfiguration, "HciVmFrontendIPConfiguration", "csharp");
@@clientName(FrontendIPConfigurationProperties,
  "HciVmFrontendIPConfigurationProperties",
  "csharp"
);
@@clientName(NetworkInterfaceProperties.bypassSdnPolicies,
  "IsSdnPoliciesBypassed",
  "csharp"
);
@@clientName(NetworkInterfacesUpdateProperties.bypassSdnPolicies,
  "IsSdnPoliciesBypassed",
  "csharp"
);
@@clientName(InboundNATRule, "HciVmInboundNatRule", "csharp");
@@clientName(InboundNATRuleProperties,
  "HciVmInboundNatRuleProperties",
  "csharp"
);
@@clientName(InboundNATRuleProtocol, "HciVmInboundNatRuleProtocol", "csharp");
@@clientName(InboundNATRuleProtocol.TCP, "Tcp", "csharp");
@@clientName(InboundNATRuleProtocol.UDP, "Udp", "csharp");
@@clientName(LoadBalancerBackendAddress,
  "HciVmLoadBalancerBackendAddress",
  "csharp"
);
@@clientName(LoadBalancerBackendAddressProperties,
  "HciVmLoadBalancerBackendAddressProperties",
  "csharp"
);
@@clientName(LoadBalancerBackendAddressProperties.ipAddress,
  "IPAddress",
  "csharp"
);
@@clientName(LoadBalancerBackendAddressAdminState,
  "HciVmLoadBalancerBackendAddressAdminState",
  "csharp"
);
@@clientName(LoadBalancerBackendAddressPoolReference,
  "HciVmLoadBalancerBackendAddressPoolReference",
  "csharp"
);
@@clientName(LoadBalancerFrontendIPConfigurationReference,
  "HciVmLoadBalancerFrontendIPConfigurationReference",
  "csharp"
);
@@clientName(LoadBalancerProbeProtocol,
  "HciVmLoadBalancerProbeProtocol",
  "csharp"
);
@@clientName(LoadBalancerProbeProtocol.HTTP, "Http", "csharp");
@@clientName(LoadBalancerProbeProtocol.TCP, "Tcp", "csharp");
@@clientName(LoadBalancerRule, "HciVmLoadBalancerRule", "csharp");
@@clientName(LoadBalancerRuleProperties,
  "HciVmLoadBalancerRuleProperties",
  "csharp"
);
@@clientName(LoadBalancerRuleSessionPersistenceType,
  "HciVmLoadBalancerRuleSessionPersistenceType",
  "csharp"
);
@@clientName(LoadBalancerRuleTransportProtocol,
  "HciVmLoadBalancerRuleTransportProtocol",
  "csharp"
);
@@clientName(LoadBalancerRuleTransportProtocol.TCP, "Tcp", "csharp");
@@clientName(LoadBalancerRuleTransportProtocol.UDP, "Udp", "csharp");
@@clientName(LoadBalancerStatus, "HciVmLoadBalancerStatus", "csharp");
@@clientName(LoadBalancerStatusProvisioningStatus,
  "HciVmLoadBalancerStatusProvisioningStatus",
  "csharp"
);
@@clientName(NatGatewayStatus, "HciVmNatGatewayStatus", "csharp");
@@clientName(NatGatewayStatusProvisioningStatus,
  "HciVmNatGatewayStatusProvisioningStatus",
  "csharp"
);
@@clientName(Probe, "HciVmLoadBalancerHealthProbe", "csharp");
@@clientName(ProbeProperties,
  "HciVmLoadBalancerHealthProbeProperties",
  "csharp"
);
@@clientName(PublicIPAddressArmReference,
  "HciVmPublicIPAddressArmReference",
  "csharp"
);
@@clientName(PublicIPAddressProperties.ipAddress, "IPAddress", "csharp");
@@clientName(PublicIPAddressProperties.ipAllocationScope,
  "IPAllocationScope",
  "csharp"
);
@@clientName(PublicIPAddressProperties.ipConfiguration,
  "IPConfiguration",
  "csharp"
);
@@clientName(PublicIPAddressType, "HciVmPublicIPAddressType", "csharp");
@@clientName(VirtualNetworkAddressSpace,
  "HciVmVirtualNetworkAddressSpace",
  "csharp"
);
@@clientName(VirtualNetworkStatus, "HciVmVirtualNetworkStatus", "csharp");
@@clientName(VirtualNetworkStatusProvisioningStatus,
  "HciVmVirtualNetworkStatusProvisioningStatus",
  "csharp"
);
@@clientName(VirtualNetworkDhcpOptions,
  "HciVmVirtualNetworkDhcpOptions",
  "csharp"
);
@@clientName(VirtualNetworkSubnetArmReference,
  "HciVmVirtualNetworkSubnetArmReference",
  "csharp"
);
@@clientName(VirtualNetworkSubnetIpConfigurationReference,
  "HciVmVirtualNetworkSubnetIPConfigurationReference",
  "csharp"
);
@@clientName(VirtualNetworkSubnetStatus,
  "HciVmVirtualNetworkSubnetStatus",
  "csharp"
);
@@clientName(VirtualNetworkSubnetStatusProvisioningStatus,
  "HciVmVirtualNetworkSubnetStatusProvisioningStatus",
  "csharp"
);
@@clientName(InterfaceDNSSettings, "HciVmInterfaceDnsSettings", "csharp");
@@clientName(VMDiskSecurityProfile, "HciVmDiskSecurityProfile", "csharp");
@@clientName(GalleryOSDiskImage, "HciVmGalleryOSDiskImage", "csharp");
@@clientName(GalleryImageVersionProperties,
  "HciVmGalleryImageVersionProperties",
  "csharp"
);
@@clientName(GalleryImageStatusDownloadStatus,
  "HciVmGalleryImageDownloadStatus",
  "csharp"
);

// Java
@@clientName(Update, "HciUpdate", "java");
