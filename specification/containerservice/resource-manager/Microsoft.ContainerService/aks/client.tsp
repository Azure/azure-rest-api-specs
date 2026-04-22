import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
using Azure.Core;
using Microsoft.ContainerService;

@@clientName(Microsoft.ContainerService.IPFamily, "IpFamily", "javascript");

// Java specific renaming for backward compatibility
@@clientName(ManagedClusterAPIServerAccessProfile,
  "ManagedClusterApiServerAccessProfile",
  "java"
);
@@clientName(ManagedClusterHTTPProxyConfig,
  "ManagedClusterHttpProxyConfig",
  "java"
);
@@clientName(ManagedClusterIngressProfile.gatewayAPI, "gatewayApi", "java");
@@clientName(ManagedClusterWebAppRoutingGatewayAPIImplementations,
  "ManagedClusterWebAppRoutingGatewayApiImplementations",
  "java"
);
@@clientName(GatewayAPIIstioEnabled, "GatewayApiIstioEnabled", "java");
@@clientName(ManagedClusterIngressProfileWebAppRouting.gatewayAPIImplementations,
  "gatewayApiImplementations",
  "java"
);
@@clientName(ManagedClusterOIDCIssuerProfile.issuerURL, "issuerUrl", "java");
@@clientName(TrustedAccessRoleRule.nonResourceURLs, "nonResourceUrls", "java");
@@clientName(AgentPoolSSHAccess, "AgentPoolSshAccess", "java");
@@clientName(GPUDriver, "GpuDriver", "java");
@@clientName(GPUInstanceProfile, "GpuInstanceProfile", "java");
@@clientName(GPUProfile, "GpuProfile", "java");
@@clientName(IPFamily, "IpFamily", "java");
@@clientName(IPTag, "IpTag", "java");
@@clientName(LocalDNSForwardDestination, "LocalDnsForwardDestination", "java");
@@clientName(LocalDNSForwardPolicy, "LocalDnsForwardPolicy", "java");
@@clientName(LocalDNSMode, "LocalDnsMode", "java");
@@clientName(LocalDNSOverride, "LocalDnsOverride", "java");
@@clientName(LocalDNSProfile, "LocalDnsProfile", "java");
@@clientName(LocalDNSProtocol, "LocalDnsProtocol", "java");
@@clientName(LocalDNSQueryLogging, "LocalDnsQueryLogging", "java");
@@clientName(LocalDNSServeStale, "LocalDnsServeStale", "java");
@@clientName(LocalDNSState, "LocalDnsState", "java");
@@clientName(ManagedClusterAADProfile, "ManagedClusterAadProfile", "java");
@@clientName(ManagedClusterLoadBalancerProfileOutboundIPPrefixes,
  "ManagedClusterLoadBalancerProfileOutboundIpPrefixes",
  "java"
);
@@clientName(ManagedClusterManagedOutboundIPProfile,
  "ManagedClusterManagedOutboundIpProfile",
  "java"
);
@@clientName(ManagedClusterNATGatewayProfile,
  "ManagedClusterNatGatewayProfile",
  "java"
);
@@clientName(ManagedClusterOIDCIssuerProfile,
  "ManagedClusterOidcIssuerProfile",
  "java"
);
@@clientName(ManagedClusterSKU, "ManagedClusterSku", "java");
@@clientName(ManagedClusterSKUName, "ManagedClusterSkuName", "java");
@@clientName(ManagedClusterSKUTier, "ManagedClusterSkuTier", "java");
@@clientName(ManagedClusterStorageProfileBlobCSIDriver,
  "ManagedClusterStorageProfileBlobCsiDriver",
  "java"
);
@@clientName(ManagedClusterStorageProfileDiskCSIDriver,
  "ManagedClusterStorageProfileDiskCsiDriver",
  "java"
);
@@clientName(ManagedClusterStorageProfileFileCSIDriver,
  "ManagedClusterStorageProfileFileCsiDriver",
  "java"
);
@@clientName(OSSKU, "OSSku", "java");
@@clientName(PodIPAllocationMode, "PodIpAllocationMode", "java");

@@clientName(Microsoft.ContainerService, "ContainerServiceClient", "python");
@@clientName(ManagedClusterLoadBalancerProfileManagedOutboundIPs.countIPv6,
  "count_ipv6",
  "python"
);

@@clientName(ManagedClusterPodIdentityProvisioningError.error,
  "ErrorDetail",
  "csharp"
);
@@clientName(Code, "ContainerServiceStateCode", "csharp");
@@clientName(Format, "KubeConfigFormat", "csharp");
@@clientName(Expander, "AutoScaleExpander", "csharp");
@@clientName(KubeletConfig.containerLogMaxSizeMB,
  "ContainerLogMaxSizeInMB",
  "csharp"
);
@@clientName(LinuxOSConfig.swapFileSizeMB, "SwapFileSizeInMB", "csharp");
@@clientName(ManagedClusterAADProfile, "ManagedClusterAadProfile", "csharp");
@@clientName(ManagedClusterAADProfile.adminGroupObjectIDs,
  "AdminGroupObjectIds",
  "csharp"
);
@@clientName(ManagedClusterAADProfile.clientAppID, "ClientAppId", "csharp");
@@clientName(ManagedClusterAADProfile.serverAppID, "ServerAppId", "csharp");
@@clientName(ManagedClusterAADProfile.tenantID, "TenantId", "csharp");
@@clientName(ManagedClusterAADProfile.managed, "IsManagedAadEnabled", "csharp");
@@clientName(ManagedClusterAADProfile.enableAzureRBAC,
  "IsAzureRbacEnabled",
  "csharp"
);
@@clientName(ConnectionStatus,
  "ContainerServicePrivateLinkServiceConnectionStatus",
  "csharp"
);
@@clientName(CredentialResults, "ManagedClusterCredentials", "csharp");
@@clientName(CredentialResult, "ManagedClusterCredential", "csharp");
@@clientName(LicenseType, "WindowsVmLicenseType", "csharp");
@@clientName(ManagedClusterPropertiesAutoScalerProfile,
  "ManagedClusterAutoScalerProfile",
  "csharp"
);
@@clientName(ManagedClusterPropertiesAutoScalerProfile.`scan-interval`,
  "ScanIntervalInSeconds",
  "csharp"
);
@@clientName(Snapshot, "AgentPoolSnapshot", "csharp");
@@clientName(SnapshotProperties.enableFIPS, "IsFipsEnabled", "csharp");
@@clientName(SnapshotProperties.osSku, "OSSku", "csharp");
@@clientName(SnapshotProperties.osType, "OSType", "csharp");
@@clientName(PrivateLinkResource,
  "ContainerServicePrivateLinkResourceData",
  "csharp"
);
@@clientName(PrivateLinkResource.privateLinkServiceID,
  "PrivateLinkServiceId",
  "csharp"
);
@@clientName(PrivateLinkResource.type, "ResourceType", "csharp");
@@alternateType(PrivateLinkResource.id, armResourceIdentifier, "csharp");
@@alternateType(PrivateLinkResource.type, armResourceType, "csharp");
@@clientName(ManagedClusterAddonProfile.enabled, "IsEnabled", "csharp");
@@clientName(ManagedClusterPodIdentityProfile.enabled, "IsEnabled", "csharp");
@@clientName(WindowsGmsaProfile.enabled, "IsEnabled", "csharp");
@@clientName(TimeSpan.start, "StartOn", "csharp");
@@clientName(TimeSpan.end, "EndOn", "csharp");
@@clientName(KubeletConfig.failSwapOn, "ShouldFailStartWithSwapOn", "csharp");
@@clientName(ManagedClusterStorageProfile.diskCSIDriver,
  "DiskCsiDriver",
  "csharp"
);
@@clientName(ManagedClusterStorageProfile.fileCSIDriver,
  "FileCsiDriver",
  "csharp"
);
@@clientName(ManagedClusterStorageProfile.blobCSIDriver,
  "BlobCsiDriver",
  "csharp"
);
@@clientName(ManagedClusterStorageProfileDiskCSIDriver,
  "ManagedClusterStorageProfileDiskCsiDriver",
  "csharp"
);
@@clientName(ManagedClusterStorageProfileDiskCSIDriver.enabled,
  "IsDiskCsiDriverEnabled",
  "csharp"
);
@@clientName(ManagedClusterStorageProfileFileCSIDriver,
  "ManagedClusterStorageProfileFileCsiDriver",
  "csharp"
);
@@clientName(ManagedClusterStorageProfileFileCSIDriver.enabled,
  "IsFileCsiDriverEnabled",
  "csharp"
);
@@clientName(ManagedClusterStorageProfileSnapshotController.enabled,
  "IsSnapshotControllerEnabled",
  "csharp"
);
@@clientName(ManagedClusterStorageProfileBlobCSIDriver,
  "ManagedClusterStorageProfileBlobCsiDriver",
  "csharp"
);
@@clientName(ManagedClusterStorageProfileBlobCSIDriver.enabled,
  "IsBlobCsiDriverEnabled",
  "csharp"
);
@@clientName(KubeletConfig.cpuCfsQuota, "IsCpuCfsQuotaEnabled", "csharp");
@@clientName(OutboundEnvironmentEndpointCollection,
  "OutboundEnvironmentEndpointListResult",
  "csharp"
);
@@clientName(RunCommandRequest, "ManagedClusterRunCommandContent", "csharp");
@@clientName(RunCommandResult, "ManagedClusterRunCommandResult", "csharp");
@@alternateType(UserAssignedIdentity.objectId, uuid, "csharp");
@@alternateType(UserAssignedIdentity.clientId, uuid, "csharp");
@@alternateType(ManagedClusterAADProfile.adminGroupObjectIDs, uuid[], "csharp");
@@alternateType(ManagedClusterAADProfile.serverAppID, uuid, "csharp");
@@alternateType(ManagedClusterAADProfile.clientAppID, uuid, "csharp");
@@alternateType(ManagedClusterAADProfile.tenantID, uuid, "csharp");
@@clientName(ManagedClusterSecurityProfileDefenderSecurityMonitoring.enabled,
  "IsSecurityMonitoringEnabled",
  "csharp"
);
@@clientName(AzureKeyVaultKms,
  "ManagedClusterSecurityProfileKeyVaultKms",
  "csharp"
);
@@clientName(AzureKeyVaultKms.enabled, "IsEnabled", "csharp");
@@clientName(KeyVaultNetworkAccessTypes,
  "ManagedClusterKeyVaultNetworkAccessType",
  "csharp"
);
@@clientName(ManagedClusterOIDCIssuerProfile,
  "ManagedClusterOidcIssuerProfile",
  "csharp"
);
@@clientName(ManagedClusterOIDCIssuerProfile.enabled, "IsEnabled", "csharp");
@@clientName(ManagedClusterOIDCIssuerProfile.issuerURL,
  "IssuerUriInfo",
  "csharp"
);
@@clientName(AbsoluteMonthlySchedule,
  "ContainerServiceMaintenanceAbsoluteMonthlySchedule",
  "csharp"
);
@@clientName(RelativeMonthlySchedule,
  "ContainerServiceMaintenanceRelativeMonthlySchedule",
  "csharp"
);
@@clientName(Type,
  "ContainerServiceMaintenanceRelativeMonthlyScheduleWeekIndex",
  "csharp"
);
@@clientName(Schedule, "ContainerServiceMaintenanceSchedule", "csharp");
@@clientName(WeeklySchedule,
  "ContainerServiceMaintenanceWeeklySchedule",
  "csharp"
);
@@clientName(BackendPoolType,
  "ManagedClusterLoadBalancerBackendPoolType",
  "csharp"
);
@@clientName(ManagedClusterAzureMonitorProfileKubeStateMetrics,
  "ManagedClusterMonitorProfileKubeStateMetrics",
  "csharp"
);
@@clientName(ManagedClusterAzureMonitorProfileMetrics,
  "ManagedClusterMonitorProfileMetrics",
  "csharp"
);
@@clientName(ManagedClusterAzureMonitorProfileMetrics.enabled,
  "IsEnabled",
  "csharp"
);
@@clientName(ManagedClusterSecurityProfileImageCleaner.enabled,
  "IsEnabled",
  "csharp"
);
@@clientName(ManagedClusterWorkloadAutoScalerProfileVerticalPodAutoscaler,
  "ManagedClusterVerticalPodAutoscaler",
  "csharp"
);
@@clientName(ManagedClusterWorkloadAutoScalerProfileVerticalPodAutoscaler.enabled,
  "IsVpaEnabled",
  "csharp"
);
@@clientName(AddonAutoscaling, "ManagedClusterAddonAutoscaling", "csharp");
@@clientName(NodeOSUpgradeChannel,
  "ManagedClusterNodeOSUpgradeChannel",
  "csharp"
);
@@clientName(PortRange, "AgentPoolNetworkPortRange", "csharp");
@@clientName(Protocol, "AgentPoolNetworkPortProtocol", "csharp");
@@clientName(Protocol.TCP, "Tcp", "csharp");
@@clientName(Protocol.UDP, "Udp", "csharp");
@@alternateType(ManagedClusterAgentPoolProfileProperties.capacityReservationGroupID,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(ManagedClusterAgentPoolProfileProperties.capacityReservationGroupID,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(MaintenanceWindow.startDate, string, "csharp");
@@clientName(ManagedCluster.identity, "ClusterIdentity", "csharp");
@@alternateType(Azure.ResourceManager.EntityTagProperty.eTag, eTag, "csharp");
@@clientName(ManagedClusterProperties.resourceUID, "ResourceId", "csharp");
@@alternateType(ManagedClusterProperties.resourceUID,
  armResourceIdentifier,
  "csharp"
);
@@clientName(ManagedClusterProperties.diskEncryptionSetID,
  "DiskEncryptionSetId",
  "csharp"
);
@@clientName(IstioEgressGateway.enabled, "IsEnabled", "csharp");
@@clientName(IstioIngressGateway.enabled, "IsEnabled", "csharp");
@@clientName(ManagedClusterWorkloadAutoScalerProfileKeda.enabled,
  "IsKedaEnabled",
  "csharp"
);
@@clientName(ManagedClusterSecurityProfileWorkloadIdentity.enabled,
  "IsWorkloadIdentityEnabled",
  "csharp"
);
@@clientName(AgentPoolWindowsProfile.disableOutboundNat,
  "IsOutboundNatDisabled",
  "csharp"
);
@@clientName(ManagedNamespace, "ManagedClusterNamespace", "csharp");
@@clientName(NamespaceProperties,
  "ManagedClusterNamespaceProperties",
  "csharp"
);
@@clientName(AdoptionPolicy, "NamespaceAdoptionPolicy", "csharp");
@@clientName(AdvancedNetworking, "ManagedClusterAdvancedNetworking", "csharp");
@@clientName(AdvancedNetworking.enabled, "IsEnabled", "csharp");
@@clientName(AdvancedNetworkingPerformance,
  "ManagedClusterAdvancedNetworkingPerformance",
  "csharp"
);
@@clientName(AccelerationMode,
  "ManagedClusterAdvancedNetworkingAccelerationMode",
  "csharp"
);
@@clientName(AdvancedNetworkingSecurity,
  "ManagedClusterAdvancedNetworkingSecurity",
  "csharp"
);
@@clientName(AdvancedNetworkPolicies,
  "ManagedClusterAdvancedNetworkPolicy",
  "csharp"
);
@@clientName(AdvancedNetworkPolicies.FQDN, "Fqdn", "csharp");
@@clientName(AdvancedNetworkingObservability.enabled,
  "IsObservabilityEnabled",
  "csharp"
);
@@clientName(AgentPoolDeleteMachinesParameter,
  "AgentPoolDeleteMachinesContent",
  "csharp"
);
@@clientName(AgentPoolSecurityProfile.enableVTPM, "IsVtpmEnabled", "csharp");
@@clientName(AgentPoolSecurityProfile.enableSecureBoot,
  "IsSecureBootEnabled",
  "csharp"
);
@@clientName(AgentPoolSSHAccess, "AgentPoolSshAccess", "csharp");
@@clientName(ManagedClusterStaticEgressGatewayProfile.enabled,
  "IsStaticEgressGatewayAddonEnabled",
  "csharp"
);
@@clientName(DeletePolicy, "NamespaceDeletePolicy", "csharp");
@@clientName(GPUProfile, "AgentPoolGpuProfile", "csharp");
@@clientName(GPUDriver, "AgentPoolGpuDriver", "csharp");
@@clientName(NamespaceProvisioningState,
  "ManagedClusterNamespaceProvisioningState",
  "csharp"
);
@@clientName(NetworkPolicies, "NamespaceNetworkPolicies", "csharp");
@@clientName(PolicyRule, "NamespaceNetworkPolicyRule", "csharp");
@@clientName(ResourceQuota, "NamespaceResourceQuota", "csharp");
@@clientName(RestrictionLevel,
  "ManagedClusterNodeResourceGroupRestrictionLevel",
  "csharp"
);
@@clientName(VirtualMachineNodes, "AgentPoolVirtualMachineNodes", "csharp");
@@clientName(ManagedClusterAIToolchainOperatorProfile.enabled,
  "IsAIToolchainOperatorEnabled",
  "csharp"
);
@@clientName(ManagedClusterCostAnalysis.enabled,
  "IsCostAnalysisEnabled",
  "csharp"
);
@@clientName(AdvancedNetworkingSecurity.enabled, "IsEnabled", "csharp");
@@clientName(ManagedClusterIngressProfileWebAppRouting.enabled,
  "IsEnabled",
  "csharp"
);
@@clientName(ContainerServiceNetworkProfile.ipFamilies,
  "NetworkIPFamilies",
  "csharp"
);
@@clientName(TimeSpan, "ContainerServiceTimeSpan", "csharp");
@@clientName(TimeInWeek, "ContainerServiceTimeInWeek", "csharp");
@@clientName(WeekDay, "ContainerServiceWeekDay", "csharp");
@@clientName(OSType, "ContainerServiceOSType", "csharp");
@@clientName(OSDiskType, "ContainerServiceOSDiskType", "csharp");
@@clientName(OSSKU, "ContainerServiceOSSku", "csharp");
@@clientName(OSSKU.CBLMariner, "CblMariner", "csharp");
@@clientName(UserAssignedIdentity,
  "ContainerServiceUserAssignedIdentity",
  "csharp"
);
@@clientName(AgentPool, "ContainerServiceAgentPool", "csharp");
@@clientName(MaintenanceConfiguration,
  "ContainerServiceMaintenanceConfiguration",
  "csharp"
);
@@clientName(ManagedCluster, "ContainerServiceManagedCluster", "csharp");
@@clientName(PublicNetworkAccess,
  "ContainerServicePublicNetworkAccess",
  "csharp"
);
@@clientName(CreationData, "ContainerServiceCreationData", "csharp");
@@clientName(EndpointDependency,
  "ContainerServiceEndpointDependency",
  "csharp"
);
@@clientName(EndpointDetail, "ContainerServiceEndpointDetail", "csharp");
@@clientName(EndpointDetail.ipAddress, "IPAddress", "csharp");
@@alternateType(EndpointDetail.ipAddress, Azure.Core.ipV4Address, "csharp");
@@clientName(LoadBalancerSku, "ContainerServiceLoadBalancerSku", "csharp");
@@clientName(NetworkMode, "ContainerServiceNetworkMode", "csharp");
@@clientName(NetworkPlugin, "ContainerServiceNetworkPlugin", "csharp");
@@clientName(NetworkPolicy, "ContainerServiceNetworkPolicy", "csharp");
@@clientName(OutboundEnvironmentEndpoint,
  "ContainerServiceOutboundEnvironmentEndpoint",
  "csharp"
);
@@clientName(OutboundType, "ContainerServiceOutboundType", "csharp");
@@clientName(OutboundType.managedNATGateway, "ManagedNatGateway", "csharp");
@@clientName(OutboundType.managedNATGatewayV2, "ManagedNatGatewayV2", "csharp");
@@clientName(OutboundType.userAssignedNATGateway,
  "UserAssignedNatGateway",
  "csharp"
);
@@clientName(PrivateLinkResourcesListResult,
  "ContainerServicePrivateLinkResourcesListResult",
  "csharp"
);
@@clientName(TagsObject, "ContainerServiceTagsObject", "csharp");
@@clientName(PowerState, "ContainerServicePowerState", "csharp");
@@clientName(DateSpan, "ContainerServiceDateSpan", "csharp");
@@clientName(IPTag, "ContainerServiceIPTag", "csharp");
@@clientName(IPTag.ipTagType, "IPTagType", "csharp");
@@clientName(MaintenanceWindow, "ContainerServiceMaintenanceWindow", "csharp");
@@clientName(NetworkPluginMode, "ContainerServiceNetworkPluginMode", "csharp");
@@clientName(TrustedAccessRole, "ContainerServiceTrustedAccessRole", "csharp");
@@clientName(TrustedAccessRoleBinding,
  "ContainerServiceTrustedAccessRoleBinding",
  "csharp"
);
@@clientName(TrustedAccessRoleRule,
  "ContainerServiceTrustedAccessRoleRule",
  "csharp"
);
@@clientName(TrustedAccessRoleRule.nonResourceURLs,
  "NonResourceUrls",
  "csharp"
);
@@clientName(TrustedAccessRoleBindingProvisioningState,
  "ContainerServiceTrustedAccessRoleBindingProvisioningState",
  "csharp"
);
@@clientName(Machine, "ContainerServiceMachine", "csharp");
@@clientName(MachineProperties, "ContainerServiceMachineProperties", "csharp");
@@clientName(ArtifactSource, "ContainerServiceArtifactSource", "csharp");
@@clientName(MachineIpAddress, "ContainerServiceMachineIPAddress", "csharp");
@@clientName(MachineIpAddress.ip, "IP", "csharp");
@@clientName(IPFamily, "ContainerServiceIPFamily", "csharp");
@@clientName(JWTAuthenticator, "ManagedClusterJwtAuthenticator", "csharp");
@@clientName(JWTAuthenticatorProperties,
  "ManagedClusterJwtAuthenticatorProperties",
  "csharp"
);
@@clientName(LoadBalancer, "ManagedClusterLoadBalancer", "csharp");
@@clientName(LoadBalancerProperties,
  "ManagedClusterLoadBalancerProperties",
  "csharp"
);
@@clientName(LabelSelector,
  "ManagedClusterLoadBalancerLabelSelector",
  "csharp"
);
@@clientName(LabelSelectorRequirement,
  "ManagedClusterLoadBalancerLabelSelectorRequirement",
  "csharp"
);
@@clientName(ManagedClusterAgentPoolProfileProperties.type,
  "AgentPoolType",
  "csharp"
);
@@clientName(ManagedClusterAgentPoolProfileProperties.osType,
  "OSType",
  "csharp"
);
@@clientName(ManagedClusterAgentPoolProfileProperties.enableFIPS,
  "IsFipsEnabled",
  "csharp"
);
@@clientName(ManagedClusterAgentPoolProfileProperties.enableAutoScaling,
  "IsAutoScalingEnabled",
  "csharp"
);
@@clientName(ManagedClusterAgentPoolProfileProperties.capacityReservationGroupID,
  "CapacityReservationGroupId",
  "csharp"
);
@@clientName(ManagedClusterAgentPoolProfileProperties.hostGroupID,
  "HostGroupId",
  "csharp"
);
@@clientName(ManagedClusterAgentPoolProfileProperties.nodePublicIPPrefixID,
  "NodePublicIPPrefixId",
  "csharp"
);
@@clientName(ManagedClusterAgentPoolProfileProperties.enableNodePublicIP,
  "IsNodePublicIpEnabled",
  "csharp"
);
@@clientName(ManagedClusterAgentPoolProfileProperties.podSubnetID,
  "PodSubnetId",
  "csharp"
);
@@clientName(ManagedClusterAgentPoolProfileProperties.proximityPlacementGroupID,
  "ProximityPlacementGroupId",
  "csharp"
);
@@clientName(ManagedClusterAgentPoolProfileProperties.vnetSubnetID,
  "VnetSubnetId",
  "csharp"
);
@@clientName(ManagedClusterAgentPoolProfileProperties.enableUltraSSD,
  "IsUltraSsdEnabled",
  "csharp"
);
@@clientName(ManagedClusterAgentPoolProfileProperties.enableEncryptionAtHost,
  "IsEncryptionAtHostEnabled",
  "csharp"
);
@@clientName(ManagedClusterAgentPoolProfileProperties.localDNSProfile,
  "LocalDnsProfile",
  "csharp"
);
@@clientName(ManagedClusterAgentPoolProfileProperties.osDiskSizeGB,
  "OSDiskSizeInGB",
  "csharp"
);
@@clientName(ManagedClusterAgentPoolProfileProperties.osDiskType,
  "OSDiskType",
  "csharp"
);
@@clientName(ManagedClusterAgentPoolProfileProperties.osSKU, "OSSku", "csharp");
@@clientName(ManagedClusterAgentPoolProfileProperties.enableOSDiskFullCaching,
  "IsOSDiskFullCachingEnabled",
  "csharp"
);
@@clientName(ManagedClusterPoolUpgradeProfile.osType, "OSType", "csharp");
@@clientName(AgentPoolUpgradeProfileProperties.osType, "OSType", "csharp");
@@clientName(MachineOSProfile.osType, "OSType", "csharp");
@@clientName(MachineOSProfile.osSKU, "OSSku", "csharp");
@@clientName(MachineOSProfile.osDiskSizeGB, "OSDiskSizeInGB", "csharp");
@@clientName(MachineOSProfile.osDiskType, "OSDiskType", "csharp");
@@clientName(MachineOSProfile.enableFIPS, "IsFipsEnabled", "csharp");
@@clientName(AgentPoolArtifactStreamingProfile.enabled,
  "IsArtifactStreamingEnabled",
  "csharp"
);
@@clientName(MachineNetworkProperties.ipAddresses, "IPAddresses", "csharp");
@@clientName(MachineNetworkProperties.vnetSubnetID, "VnetSubnetId", "csharp");
@@clientName(MachineNetworkProperties.podSubnetID, "PodSubnetId", "csharp");
@@clientName(MachineNetworkProperties.nodePublicIPPrefixID,
  "NodePublicIpPrefixId",
  "csharp"
);
@@clientName(MachineNetworkProperties.enableNodePublicIP,
  "IsNodePublicIpEnabled",
  "csharp"
);
@@clientName(GPUInstanceProfile, "GpuInstanceProfile", "csharp");
@@clientName(GPUInstanceProfile.MIG1g, "Mig1G", "csharp");
@@clientName(GPUInstanceProfile.MIG2g, "Mig2G", "csharp");
@@clientName(GPUInstanceProfile.MIG3g, "Mig3G", "csharp");
@@clientName(GPUInstanceProfile.MIG4g, "Mig4G", "csharp");
@@clientName(GPUInstanceProfile.MIG7g, "Mig7G", "csharp");
@@clientName(LocalDNSProfile, "LocalDnsProfile", "csharp");
@@clientName(MaintenanceConfigurationProperties.timeInWeek,
  "TimesInWeek",
  "csharp"
);
@@clientName(MaintenanceConfigurationProperties.notAllowedTime,
  "NotAllowedTimes",
  "csharp"
);
@@clientName(ManagedClusterAPIServerAccessProfile,
  "ManagedClusterApiServerAccessProfile",
  "csharp"
);
@@clientName(ManagedClusterAPIServerAccessProfile.enablePrivateClusterPublicFQDN,
  "IsPrivateClusterPublicFqdnEnabled",
  "csharp"
);
@@clientName(ManagedClusterAPIServerAccessProfile.privateDNSZone,
  "PrivateDnsZone",
  "csharp"
);
@@clientName(ManagedClusterProperties.privateFQDN, "PrivateFqdn", "csharp");
@@clientName(ManagedClusterProperties.azurePortalFQDN,
  "AzurePortalFqdn",
  "csharp"
);
@@clientName(ManagedClusterProperties.enableRBAC, "IsRbacEnabled", "csharp");
@@clientName(ManagedClusterProperties.disableLocalAccounts,
  "IsLocalAccountsDisabled",
  "csharp"
);
@@clientName(ManagedClusterHostedSystemProfile.enabled,
  "IsHostedSystemAddonsEnabled",
  "csharp"
);
@@clientName(ManagedClusterSKU, "ManagedClusterSku", "csharp");
@@clientName(ManagedClusterSKUName, "ManagedClusterSkuName", "csharp");
@@clientName(ManagedClusterSKUTier, "ManagedClusterSkuTier", "csharp");
@@clientName(PrivateEndpointConnection,
  "ContainerServicePrivateEndpointConnection",
  "csharp"
);
@@clientName(PrivateEndpointConnectionProperties,
  "ContainerServicePrivateEndpointConnectionProperties",
  "csharp"
);
@@clientName(PrivateEndpointConnectionProperties.privateLinkServiceConnectionState,
  "ConnectionState",
  "csharp"
);
@@alternateType(PrivateEndpoint.id, armResourceIdentifier, "csharp");
@@alternateType(ManagedCluster.extendedLocation,
  Azure.ResourceManager.CommonTypes.ExtendedLocation,
  "csharp"
);
@@alternateType(MachineProperties.eTag, eTag, "csharp");
@@alternateType(ManagedClusterAgentPoolProfileProperties.eTag, eTag, "csharp");
@@clientName(ManagedClusters.listByResourceGroup, "GetAll", "csharp");
@@clientName(ManagedClusters.list,
  "GetContainerServiceManagedClusters",
  "csharp"
);
@@clientName(ManagedClusters.listClusterAdminCredentials,
  "GetClusterAdminCredentials",
  "csharp"
);
@@clientName(ManagedClusters.listClusterUserCredentials,
  "GetClusterUserCredentials",
  "csharp"
);
@@clientName(ManagedClusters.listClusterMonitoringUserCredentials,
  "GetClusterMonitoringUserCredentials",
  "csharp"
);
@@clientName(ManagedClusters.listOutboundNetworkDependenciesEndpoints,
  "GetOutboundNetworkDependenciesEndpoints",
  "csharp"
);
@@clientName(ManagedClusters.getAvailableAgentPoolVersions,
  "GetAvailableAgentPoolVersions",
  "csharp"
);
@@clientName(ManagedClusters.post, "ResolvePrivateLinkServiceId", "csharp");

namespace Azure.ResourceManager.ContainerService.Models {
  /**
   * Delegated resource properties - internal use only.
   */
  model ManagedClusterDelegatedIdentity {
    /**
     * The ARM resource id of the delegated resource - internal use only.
     */
    resourceId: armResourceIdentifier;

    /**
     * The tenant id of the delegated resource - internal use only.
     */
    tenantId?: uuid;

    /**
     * The delegation id of the referral delegation (optional) - internal use only.
     */
    referralResource: string;

    /**
     * The source resource location - internal use only.
     */
    location?: azureLocation;
  }

  @@alternateType(ManagedClusterIdentity.delegatedResources,
    Record<ManagedClusterDelegatedIdentity>,
    "csharp"
  );
}
@@alternateType(ManagedClusterIdentity.principalId, uuid, "csharp");
@@alternateType(ManagedClusterIdentity.tenantId, uuid, "csharp");
@@alternateType(ManagedClusterIdentity.type,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentityType,
  "csharp"
);
@@clientName(ManagedClusterIdentity.type, "IdentityType", "csharp");
@@clientName(ManagedClusterHTTPProxyConfig,
  "ManagedClusterHttpProxyConfig",
  "csharp"
);
@@clientName(ManagedClusterHTTPProxyConfig.enabled,
  "IsHttpProxyEnabled",
  "csharp"
);
@@clientName(ManagedClusterHTTPProxyConfig.trustedCa, "TrustedCA", "csharp");
@@clientName(LocalDNSMode, "LocalDnsMode", "csharp");
@@clientName(LocalDNSState, "LocalDnsState", "csharp");
@@clientName(LocalDNSQueryLogging, "LocalDnsQueryLogging", "csharp");
@@clientName(LocalDNSProtocol, "LocalDnsProtocol", "csharp");
@@clientName(LocalDNSProtocol.PreferUDP, "PreferUdp", "csharp");
@@clientName(LocalDNSProtocol.ForceTCP, "ForceTcp", "csharp");
@@clientName(LocalDNSForwardDestination,
  "LocalDnsForwardDestination",
  "csharp"
);
@@clientName(LocalDNSForwardDestination.ClusterCoreDNS,
  "ClusterCoreDns",
  "csharp"
);
@@clientName(LocalDNSForwardDestination.VnetDNS, "VnetDns", "csharp");
@@clientName(LocalDNSForwardPolicy, "LocalDnsForwardPolicy", "csharp");
@@clientName(LocalDNSServeStale, "LocalDnsServeStale", "csharp");
@@clientName(LocalDNSProfile, "LocalDnsProfile", "csharp");
@@clientName(LocalDNSProfile.kubeDNSOverrides, "KubeDnsOverrides", "csharp");
@@clientName(LocalDNSProfile.vnetDNSOverrides, "VnetDnsOverrides", "csharp");
@@clientName(LocalDNSOverride, "LocalDnsOverride", "csharp");
@@clientName(AgentPoolAvailableVersionsPropertiesAgentPoolVersionsItem,
  "AgentPoolAvailableVersion",
  "csharp"
);
@@clientName(AgentPoolAvailableVersionsPropertiesAgentPoolVersionsItem.default,
  "IsDefault",
  "csharp"
);
@@clientName(IdentityBinding, "ManagedClusterIdentityBinding", "csharp");
@@clientName(IdentityBindingProperties,
  "ManagedClusterIdentityBindingProperties",
  "csharp"
);
@@clientName(IdentityBindingProvisioningState,
  "ManagedClusterIdentityBindingProvisioningState",
  "csharp"
);
@@clientName(MeshMembership, "ManagedClusterMeshMembership", "csharp");
@@clientName(MeshMembershipProperties,
  "ManagedClusterMeshMembershipProperties",
  "csharp"
);
@@clientName(AgentPoolRecentlyUsedVersion.timestamp, "LastUsedOn", "csharp");
@@clientName(Component, "KubernetesVersionComponent", "csharp");
@@clientName(ComponentsByRelease, "KubernetesVersionComponents", "csharp");
@@clientName(ManagedClusterNATGatewayProfile,
  "ManagedClusterNatGatewayProfile",
  "csharp"
);
@@clientName(DriftAction, "ContainerServiceMachineDriftAction", "csharp");
@@clientName(DriverType, "AgentPoolGpuDriverType", "csharp");
@@clientName(DriverType.GRID, "Grid", "csharp");
@@clientName(DriverType.CUDA, "Cuda", "csharp");
@@clientName(InfrastructureEncryption,
  "KubernetesResourceObjectInfrastructureEncryption",
  "csharp"
);
@@clientName(IpvsScheduler, "ContainerServiceNetworkIpvsScheduler", "csharp");
@@clientName(ContainerServiceNetworkProfileKubeProxyConfigIpvsConfig.tcpTimeoutSeconds,
  "TcpTimeoutInSeconds",
  "csharp"
);
@@clientName(ContainerServiceNetworkProfileKubeProxyConfigIpvsConfig.tcpFinTimeoutSeconds,
  "TcpFinTimeoutInSeconds",
  "csharp"
);
@@clientName(ContainerServiceNetworkProfileKubeProxyConfigIpvsConfig.udpTimeoutSeconds,
  "UdpTimeoutInSeconds",
  "csharp"
);
@@clientName(JWTAuthenticatorClaimMappings,
  "ManagedClusterJwtAuthenticatorClaimMappings",
  "csharp"
);
@@clientName(JWTAuthenticatorExtraClaimMappingExpression,
  "ManagedClusterJwtAuthenticatorExtraClaimMappingExpression",
  "csharp"
);
@@clientName(JWTAuthenticatorIssuer,
  "ManagedClusterJwtAuthenticatorIssuer",
  "csharp"
);
@@clientName(JWTAuthenticatorProvisioningState,
  "ManagedClusterJwtAuthenticatorProvisioningState",
  "csharp"
);
@@clientName(JWTAuthenticatorValidationRule,
  "ManagedClusterJwtAuthenticatorValidationRule",
  "csharp"
);
@@clientName(ManagedClusterPodIdentityProvisioningErrorBody,
  "ManagedClusterPodIdentityProvisioningErrorDetail",
  "csharp"
);

@@clientName(TrustedAccessRolesOperationGroup.list,
  "GetTrustedAccessRoles",
  "csharp"
);
@@clientName(ManagedClusters.privateLinkResourcesList,
  "GetPrivateLinkResources",
  "csharp"
);
@@clientName(ManagedClusters.resetAADProfile, "ResetAadProfile", "csharp");
@@clientName(NodeProvisioningDefaultNodePools,
  "NodeProvisioningDefaultNodePool",
  "csharp"
);
@@clientName(ManagedClusterWindowsProfile.enableCSIProxy,
  "IsCsiProxyEnabled",
  "csharp"
);
@@clientName(Mode, "ContainerServiceNetworkKubeProxyMode", "csharp");
@@clientName(Mode.IPTABLES, "IPTables", "csharp");
@@clientName(Mode.IPVS, "Ipvs", "csharp");
@@clientName(Mode.NFTABLES, "NFTables", "csharp");
@@clientName(PodLinkLocalAccess.IMDS, "Imds", "csharp");
@@clientName(ProxyRedirectionMechanism.CNIChaining, "CniChaining", "csharp");
@@clientName(RebalanceLoadBalancersRequestBody,
  "RebalanceLoadBalancersContent",
  "csharp"
);
@@clientName(SysctlConfig.netIpv4IpLocalPortRange,
  "NetIpv4IPLocalPortRange",
  "csharp"
);
@@clientName(SysctlConfig.netIpv4NeighDefaultGcThresh1,
  "NetIPv4NeighDefaultGcThresh1",
  "csharp"
);
@@clientName(SysctlConfig.netIpv4NeighDefaultGcThresh2,
  "NetIPv4NeighDefaultGcThresh2",
  "csharp"
);
@@clientName(SysctlConfig.netIpv4NeighDefaultGcThresh3,
  "NetIPv4NeighDefaultGcThresh3",
  "csharp"
);
@@clientName(SysctlConfig.netIpv4TcpFinTimeout,
  "NetIPv4TcpFinTimeout",
  "csharp"
);
@@clientName(SysctlConfig.netIpv4TcpkeepaliveIntvl,
  "NetIPv4TcpKeepaliveIntvl",
  "csharp"
);
@@clientName(SysctlConfig.netIpv4TcpKeepaliveProbes,
  "NetIPv4TcpKeepaliveProbes",
  "csharp"
);
@@clientName(SysctlConfig.netIpv4TcpKeepaliveTime,
  "NetIPv4TcpKeepaliveTime",
  "csharp"
);
@@clientName(SysctlConfig.netIpv4TcpMaxSynBacklog,
  "NetIPv4TcpMaxSynBacklog",
  "csharp"
);
@@clientName(SysctlConfig.netIpv4TcpMaxTwBuckets,
  "NetIPv4TcpMaxTwBuckets",
  "csharp"
);
@@clientName(SysctlConfig.netIpv4IpLocalPortRange,
  "NetIPv4IPLocalPortRange ",
  "csharp"
);
@@clientName(SysctlConfig.netIpv4TcpTwReuse,
  "IsNetIpv4TcpTwReuseEnabled",
  "csharp"
);
@@clientName(VmState, "ContainerServiceMachineVmState", "csharp");
@@clientName(WorkloadRuntime.OCIContainer, "OciContainer", "csharp");
@@clientName(UpgradeStrategy, "AgentPoolUpgradeStrategy", "csharp");
@@clientName(ManagedClusterSecurityProfileImageIntegrity.enabled,
  "IsImageIntegrityEnabled",
  "csharp"
);
@@clientName(ManagedClusterSecurityProfileNodeRestriction.enabled,
  "IsNodeRestrictionEnabled",
  "csharp"
);
@@clientName(ContainerServiceNetworkProfileKubeProxyConfig.enabled,
  "IsKubeProxyEnabled",
  "csharp"
);
@@clientName(ManagedClusterSecurityProfileDefenderSecurityGating.enabled,
  "IsSecurityGatingEnabled",
  "csharp"
);
@@clientName(ManagedClusterIngressDefaultDomainProfile.enabled,
  "IsDefaultDomainEnabled",
  "csharp"
);
@@clientName(ManagedClusterIngressProfileApplicationLoadBalancer.enabled,
  "IsApplicationLoadBalancerEnabled",
  "csharp"
);
@@clientName(ManagedClusterAzureMonitorProfileContainerInsights.enabled,
  "IsContainerInsightsEnabled",
  "csharp"
);
@@clientName(ManagedClusterAzureMonitorProfileContainerInsights.disableCustomMetrics,
  "IsCustomMetricsDisabled",
  "csharp"
);
@@clientName(ManagedClusterAzureMonitorProfileContainerInsights.disablePrometheusMetricsScraping,
  "IsPrometheusMetricsScrapingDisabled",
  "csharp"
);
@@clientName(ManagedClusterAzureMonitorProfileAppMonitoringOpenTelemetryMetrics.enabled,
  "IsAppMonitoringOpenTelemetryMetricsEnabled",
  "csharp"
);
@@clientName(ManagedClusterAzureMonitorProfileAppMonitoringOpenTelemetryLogsAndTraces.enabled,
  "IsAppMonitoringOpenTelemetryLogsAndTracesEnabled",
  "csharp"
);
@@clientName(ManagedClusterAzureMonitorProfileAppMonitoringAutoInstrumentation.enabled,
  "IsAppMonitoringAutoInstrumentationEnabled",
  "csharp"
);
@@clientName(ManagedClusterAzureMonitorProfileAppMonitoringAutoInstrumentation.enabled,
  "IsAppMonitoringAutoInstrumentationEnabled",
  "csharp"
);
@@clientName(LoadBalancerProperties.allowServicePlacement,
  "IsServicePlacementAllowed",
  "csharp"
);
@@clientName(MachineSecurityProfile.enableVTPM, "IsVtpmEnabled", "csharp");
@@clientName(MachineSecurityProfile.enableSecureBoot,
  "IsSecureBootEnabled",
  "csharp"
);
@@clientName(MachineSecurityProfile.enableEncryptionAtHost,
  "IsEncryptionAtHostEnabled",
  "csharp"
);
@@clientName(ManagedClusterAPIServerAccessProfile.enablePrivateCluster,
  "IsPrivateClusterEnabled",
  "csharp"
);
@@clientName(ManagedClusterAPIServerAccessProfile.enableVnetIntegration,
  "IsVnetIntegrationEnabled",
  "csharp"
);
@@clientName(ManagedClusterAPIServerAccessProfile.disableRunCommand,
  "IsRunCommandDisabled",
  "csharp"
);
@@clientName(ManagedClusterLoadBalancerProfile.enableMultipleStandardLoadBalancers,
  "IsMultipleStandardLoadBalancersEnabled",
  "csharp"
);
@@clientName(ManagedClusterPodIdentityProfile.allowNetworkPluginKubenet,
  "IsKubenetNetworkPluginAllowed",
  "csharp"
);
@@clientName(ManagedClusterProperties.enableNamespaceResources,
  "IsNamespaceResourcesEnabled",
  "csharp"
);
@@clientName(ManagedClusterPropertiesAutoScalerProfile.`daemonset-eviction-for-empty-nodes`,
  "IsDaemonsetEvictionForEmptyNodesEnabled",
  "csharp"
);
@@clientName(ManagedClusterPropertiesAutoScalerProfile.`daemonset-eviction-for-occupied-nodes`,
  "IsDaemonsetEvictionForOccupiedNodesEnabled",
  "csharp"
);
@@clientName(ManagedClusterPropertiesAutoScalerProfile.`ignore-daemonsets-utilization`,
  "IsDaemonsetsUtilizationIgnored",
  "csharp"
);
@@clientName(ManagedClusterPropertiesForSnapshot.enableRbac,
  "IsRbacEnabled",
  "csharp"
);
@@clientName(ManagedClusterSecurityProfileDefenderSecurityGating.allowSecretAccess,
  "IsSecretAccessAllowed",
  "csharp"
);
@@clientName(UpgradeOverrideSettings.forceUpgrade,
  "IsForceUpgradeEnabled",
  "csharp"
);
@@clientName(ManagedClusterIngressProfile.gatewayAPI, "GatewayApi", "csharp");
@@clientName(MeshMembershipProperties.managedMeshID, "ManagedMeshId", "csharp");
@@clientName(MachineStatus.creationTimestamp, "CreatedOn", "csharp");
@@clientName(NvidiaGPUProfile, "AgentPoolNvidiaGpuProfile", "csharp");
@@clientName(MachineProperties.localDNSProfile, "LocalDnsProfile", "csharp");
@@clientName(ExtendedLocationTypes,
  "ContainerServiceExtendedLocationType",
  "csharp"
);
@@clientName(GatewayAPIIstioEnabled, "GatewayApiIstioMode", "csharp");
@@clientName(ManagedClusterAppRoutingIstio.mode, "IstioMode", "csharp");
@@clientName(MachineHardwareProfile.ultraSsdEnabled,
  "IsUltraSsdEnabled",
  "csharp"
);
@@clientName(ManagedClusterHealthMonitorProfile.enableContinuousControlPlaneAndAddonMonitor,
  "IsContinuousControlPlaneAndAddonMonitorEnabled",
  "csharp"
);
@@clientName(ManagedClusterHealthMonitorProfile.enableOnDemandMonitor,
  "IsOnDemandMonitorEnabled",
  "csharp"
);
@@clientName(ManagementMode, "GpuManagementMode", "csharp");
@@clientName(MigStrategy, "MultiInstanceGpuStrategy", "csharp");
@@clientName(ResourceSku, "ContainerServiceVmSku", "csharp");
@@clientName(ResourceSkuCapabilities,
  "ContainerServiceVmSkuCapabilities",
  "csharp"
);
@@clientName(ResourceSkuCapacity, "ContainerServiceVmSkuCapacity", "csharp");
@@clientName(ResourceSkuCosts, "ContainerServiceVmSkuCosts", "csharp");
@@clientName(ResourceSkuLocationInfo,
  "ContainerServiceVmSkuLocationInfo",
  "csharp"
);
@@clientName(ResourceSkuRestrictionInfo,
  "ContainerServiceVmSkuRestrictionInfo",
  "csharp"
);
@@clientName(ResourceSkuRestrictions,
  "ContainerServiceVmSkuRestrictions",
  "csharp"
);
@@clientName(ResourceSkuZoneDetails,
  "ContainerServiceVmSkuZoneDetails",
  "csharp"
);
@@clientName(ServiceAccountImagePullProfile.enabled, "IsEnabled", "csharp");
@@clientName(TransitEncryptionType.mTLS,
  "ClientCertificateAuthentication",
  "csharp"
);
@@clientName(VmSkusOperationGroup.list, "GetVmSkus", "csharp");
@@clientName(MachineHardwareProfile,
  "ContainerServiceMachineHardwareProfile",
  "csharp"
);
@@clientName(MachineKubernetesProfile,
  "ContainerServiceMachineKubernetesProfile",
  "csharp"
);
@@clientName(MachineNetworkProperties,
  "ContainerServiceMachineNetworkProperties",
  "csharp"
);
@@clientName(MachineOSProfile, "ContainerServiceMachineOSProfile", "csharp");
@@clientName(MachineOSProfileLinuxProfile,
  "ContainerServiceMachineLinuxProfile",
  "csharp"
);
@@clientName(MachineSecurityProfile,
  "ContainerServiceMachineSecurityProfile",
  "csharp"
);
@@clientName(MachineStatus, "ContainerServiceMachineStatus", "csharp");
@@clientName(AutoScaleProfile, "AgentPoolAutoScaleProfile", "csharp");
@@clientName(NetworkProfileForSnapshot,
  "ManagedClusterSnapshotNetworkProfile",
  "csharp"
);
@@clientName(ManagedClusterPropertiesForSnapshot,
  "ManagedClusterSnapshotInfo",
  "csharp"
);
@@clientName(ScaleProfile, "AgentPoolScaleProfile", "csharp");
@@clientName(ManagedClustersOperationGroup.listKubernetesVersions,
  "GetManagedClusterKubernetesVersions",
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "List operation is pageable for .Net SDK"
@@markAsPageable(PrivateEndpointConnections.list, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "List operation is pageable for .Net SDK"
@@markAsPageable(ManagedClusters.privateLinkResourcesList, "csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Ensure backward compatibility for the .NET SDK"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(AgentPoolAvailableVersions,
  Azure.ResourceManager.Foundations.ProxyResource,
  "csharp"
);

@@scope(ManagedClusters.operationStatusResultList, "!csharp");
@@scope(ManagedClusters.operationStatusResultGet, "!csharp");
@@scope(AgentPools.getByAgentPool, "!csharp");
@@scope(Operations.list, "!csharp");

// we add this model in this namespace in order to replace some models with this model via alternateType decorator
namespace Azure.ResourceManager.Models {
  /** represents a reference to an existing resource by its id */
  model WritableSubResource {
    /** the id */
    id?: armResourceIdentifier;
  }
}
@@alternateType(ManagedClusterLoadBalancerProfile.effectiveOutboundIPs,
  Azure.ResourceManager.Models.WritableSubResource[],
  "csharp"
);
@@alternateType(ManagedClusterLoadBalancerProfileOutboundIPPrefixes.publicIPPrefixes,
  Azure.ResourceManager.Models.WritableSubResource[],
  "csharp"
);
@@alternateType(ManagedClusterLoadBalancerProfileOutboundIPs.publicIPs,
  Azure.ResourceManager.Models.WritableSubResource[],
  "csharp"
);
@@alternateType(ManagedClusterNATGatewayProfile.effectiveOutboundIPs,
  Azure.ResourceManager.Models.WritableSubResource[],
  "csharp"
);

// Java: rename properties with uppercase acronyms for backward compatibility
// ManagedClusterAgentPoolProfileProperties
@@clientName(ManagedClusterAgentPoolProfileProperties.vnetSubnetID,
  "vnetSubnetId",
  "java"
);
@@clientName(ManagedClusterAgentPoolProfileProperties.podSubnetID,
  "podSubnetId",
  "java"
);
@@clientName(ManagedClusterAgentPoolProfileProperties.podIPAllocationMode,
  "podIpAllocationMode",
  "java"
);
@@clientName(ManagedClusterAgentPoolProfileProperties.osSKU, "osSku", "java");
@@clientName(ManagedClusterAgentPoolProfileProperties.enableNodePublicIP,
  "enableNodePublicIp",
  "java"
);
@@clientName(ManagedClusterAgentPoolProfileProperties.nodePublicIPPrefixID,
  "nodePublicIpPrefixId",
  "java"
);
@@clientName(ManagedClusterAgentPoolProfileProperties.proximityPlacementGroupID,
  "proximityPlacementGroupId",
  "java"
);
@@clientName(ManagedClusterAgentPoolProfileProperties.enableUltraSSD,
  "enableUltraSsd",
  "java"
);
@@clientName(ManagedClusterAgentPoolProfileProperties.enableFIPS,
  "enableFips",
  "java"
);
@@clientName(ManagedClusterAgentPoolProfileProperties.hostGroupID,
  "hostGroupId",
  "java"
);
@@clientName(ManagedClusterAgentPoolProfileProperties.capacityReservationGroupID,
  "capacityReservationGroupId",
  "java"
);
// AgentPoolNetworkProfile
@@clientName(AgentPoolNetworkProfile.nodePublicIPTags,
  "nodePublicIpTags",
  "java"
);
// AgentPoolGatewayProfile
@@clientName(AgentPoolGatewayProfile.publicIPPrefixSize,
  "publicIpPrefixSize",
  "java"
);
// ContainerServiceNetworkProfile
@@clientName(ContainerServiceNetworkProfile.dnsServiceIP,
  "dnsServiceIp",
  "java"
);
// ManagedClusterLoadBalancerProfile
@@clientName(ManagedClusterLoadBalancerProfile.outboundIPPrefixes,
  "outboundIpPrefixes",
  "java"
);
// ManagedClusterLoadBalancerProfileOutboundIPPrefixes
@@clientName(ManagedClusterLoadBalancerProfileOutboundIPPrefixes.publicIPPrefixes,
  "publicIpPrefixes",
  "java"
);
// ManagedClusterNATGatewayProfile
@@clientName(ManagedClusterNATGatewayProfile.managedOutboundIPProfile,
  "managedOutboundIpProfile",
  "java"
);
@@clientName(ManagedClusterNATGatewayProfile.outboundIPPrefixes,
  "outboundIpPrefixes",
  "java"
);
@@clientName(ManagedClusterNATGatewayProfile.outboundIPs,
  "outboundIps",
  "java"
);
// ManagedClusterAADProfile
@@clientName(ManagedClusterAADProfile.enableAzureRBAC,
  "enableAzureRbac",
  "java"
);
@@clientName(ManagedClusterAADProfile.clientAppID, "clientAppId", "java");
@@clientName(ManagedClusterAADProfile.serverAppID, "serverAppId", "java");
@@clientName(ManagedClusterAADProfile.tenantID, "tenantId", "java");
// ManagedClusterProperties
@@clientName(ManagedClusterProperties.enableRBAC, "enableRbac", "java");
@@clientName(ManagedClusterProperties.diskEncryptionSetID,
  "diskEncryptionSetId",
  "java"
);
// ManagedClusterAPIServerAccessProfile
@@clientName(ManagedClusterAPIServerAccessProfile.authorizedIPRanges,
  "authorizedIpRanges",
  "java"
);
@@clientName(ManagedClusterAPIServerAccessProfile.privateDNSZone,
  "privateDnsZone",
  "java"
);
// PrivateLinkResource
@@clientName(PrivateLinkResource.privateLinkServiceID,
  "privateLinkServiceId",
  "java"
);
// MachineNetworkProperties
@@clientName(MachineNetworkProperties.vnetSubnetID, "vnetSubnetId", "java");
@@clientName(MachineNetworkProperties.podSubnetID, "podSubnetId", "java");
@@clientName(MachineNetworkProperties.nodePublicIPPrefixID,
  "nodePublicIpPrefixId",
  "java"
);
@@clientName(MachineNetworkProperties.enableNodePublicIP,
  "enableNodePublicIp",
  "java"
);
@@clientName(MachineNetworkProperties.nodePublicIPTags,
  "nodePublicIpTags",
  "java"
);
// MachineOSProfile
@@clientName(MachineOSProfile.enableFIPS, "enableFips", "java");
@@clientName(MachineOSProfile.osSKU, "osSku", "java");
// SnapshotProperties
@@clientName(SnapshotProperties.enableFIPS, "enableFips", "java");
// ResourceSkuCosts
@@clientName(ResourceSkuCosts.meterID, "meterId", "java");
// MeshMembershipProperties
@@clientName(MeshMembershipProperties.managedMeshID, "managedMeshId", "java");
// listNodeImageVersions
@@clientLocation(ContainerServiceOperationGroup.listNodeImageVersions,
  ManagedClusters,
  "java"
);
// LocalDNSProfile
@@clientName(LocalDNSProfile.vnetDNSOverrides, "vnetDnsOverrides", "java");
@@clientName(LocalDNSProfile.kubeDNSOverrides, "kubeDnsOverrides", "java");
// ManagedClusterAgentPoolProfileProperties
@@clientName(ManagedClusterAgentPoolProfileProperties.eTag, "etag", "java");
@@clientName(ManagedClusterAgentPoolProfileProperties.localDNSProfile,
  "localDnsProfile",
  "java"
);
// ManagedClusterStorageProfile
@@clientName(ManagedClusterStorageProfile.diskCSIDriver,
  "diskCsiDriver",
  "java"
);
@@clientName(ManagedClusterStorageProfile.fileCSIDriver,
  "fileCsiDriver",
  "java"
);
@@clientName(ManagedClusterStorageProfile.blobCSIDriver,
  "blobCsiDriver",
  "java"
);
// ManagedClusterAPIServerAccessProfile
@@clientName(ManagedClusterAPIServerAccessProfile.enablePrivateClusterPublicFQDN,
  "enablePrivateClusterPublicFqdn",
  "java"
);
// AgentPoolSecurityProfile
@@clientName(AgentPoolSecurityProfile.enableVTPM, "enableVtpm", "java");
// ManagedClusterWindowsProfile
@@clientName(ManagedClusterWindowsProfile.enableCSIProxy,
  "enableCsiProxy",
  "java"
);
// TODO: drop the type replacement upon next major breaking change
@@alternateType(ManagedClusterIdentity.type,
  global.ResourceIdentityType,
  "java"
);
/**
 * The type of identity used for the managed cluster. For more information see [use managed identities in AKS](https://docs.microsoft.com/azure/aks/use-managed-identity).
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Backward compatibility for Java SDK by using enum in place of string union type"
enum ResourceIdentityType {
  /**
   * Use an implicitly created system assigned managed identity to manage cluster resources. Master components in the control plane such as kube-controller-manager will use the system assigned managed identity to manipulate Azure resources.
   */
  SystemAssigned: "SystemAssigned",

  /**
   * Use a user-specified identity to manage cluster resources. Master components in the control plane such as kube-controller-manager will use the specified user assigned managed identity to manipulate Azure resources.
   */
  UserAssigned: "UserAssigned",

  /**
   * Do not use a managed identity for the Managed Cluster, service principal will be used instead.
   */
  None: "None",
}

#suppress "@azure-tools/typespec-client-generator-core/client-option" "https://github.com/Azure/typespec-azure/issues/4090"
#suppress "@azure-tools/typespec-client-generator-core/client-option-requires-scope" "https://github.com/Azure/typespec-azure/issues/4090"
@@clientOption(ManagedCluster,
  "resource-rbac-roles",
  #{
    AzureKubernetesServiceClusterAdminRole: "0ab0b1a8-8aac-4efd-b8c2-3ee1fb270be8",
    AzureKubernetesServiceClusterMonitoringUser: "1afdec4b-e479-420e-99e7-f82237c7c5e6",
    AzureKubernetesServiceClusterUserRole: "4abbcc35-e782-43d8-92c5-2d3f1bd2253f",
    AzureKubernetesServiceContributorRole: "ed7f3fbd-7b88-4dd4-9017-9adb7ce333f8",
    AzureKubernetesServiceRbacAdmin: "3498e952-d568-435e-9b2c-8d77e338d7f7",
    AzureKubernetesServiceRbacClusterAdmin: "b1ff04bb-8a4e-4dc4-8eb5-8693973ce19b",
    AzureKubernetesServiceRbacReader: "7f6c6a51-bcf8-42ba-9220-52d62157d7db",
    AzureKubernetesServiceRbacWriter: "a7ffa36f-339b-4b5c-8bdf-e2c188b2c0eb",
  },
  "csharp"
);
