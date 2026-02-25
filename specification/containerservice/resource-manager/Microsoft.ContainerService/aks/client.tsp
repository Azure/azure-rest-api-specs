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
@@clientName(ManagedClusterOIDCIssuerProfile.issuerURL, "issuerUrl", "java");
@@clientName(TrustedAccessRoleRule.nonResourceURLs, "nonResourceUrls", "java");

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
@@clientName(Snapshot, "AgentPoolSnapshot", "csharp");
@@clientName(SnapshotProperties.enableFIPS, "EnableFips", "csharp");
@@clientName(SnapshotProperties.osSku, "OSSku", "csharp");
@@clientName(SnapshotProperties.osType, "OSType", "csharp");
@@clientName(PrivateLinkResource,
  "ContainerServicePrivateLinkResourceData",
  "csharp"
);
@@clientName(ManagedClusterAddonProfile.enabled, "IsEnabled", "csharp");
@@clientName(ManagedClusterPodIdentityProfile.enabled, "IsEnabled", "csharp");
@@clientName(WindowsGmsaProfile.enabled, "IsEnabled", "csharp");
@@clientName(TimeSpan.start, "StartOn", "csharp");
@@clientName(TimeSpan.end, "EndOn", "csharp");
@@clientName(KubeletConfig.failSwapOn, "FailStartWithSwapOn", "csharp");
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
@@alternateType(ManagedClusterAADProfile.serverAppID, uuid, "csharp");
@@alternateType(ManagedClusterAADProfile.clientAppID, uuid, "csharp");
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
@@clientName(LoadBalancer, "ManagedClusterLoadBalancerData", "csharp");
@@clientName(LoadBalancerProperties,
  "ManagedClusterLoadBalancerProperties",
  "csharp"
);
@@clientName(ManagedClusterAgentPoolProfileProperties.osType,
  "OSType",
  "csharp"
);
@@clientName(ManagedClusterAgentPoolProfileProperties.enableFIPS,
  "EnableFips",
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
@@clientName(ManagedClusterAgentPoolProfileProperties.type,
  "TypePropertiesType",
  "csharp"
);
@@clientName(ManagedClusterAgentPoolProfileProperties.enableUltraSSD,
  "EnableUltraSsd",
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
@@clientName(ManagedClusterPoolUpgradeProfile.osType, "OSType", "csharp");
@@clientName(AgentPoolUpgradeProfileProperties.osType, "OSType", "csharp");
@@clientName(MachineOSProfile.osType, "OSType", "csharp");
@@clientName(MachineOSProfile.osSKU, "OSSku", "csharp");
@@clientName(MachineOSProfile.osDiskSizeGB, "OSDiskSizeInGB", "csharp");
@@clientName(MachineOSProfile.osDiskType, "OSDiskType", "csharp");
@@clientName(MachineOSProfile.enableFIPS, "EnableFips", "csharp");
@@clientName(AgentPoolArtifactStreamingProfile.enabled,
  "IsArtifactStreamingEnabled",
  "csharp"
);
@@clientName(MachineNetworkProperties.vnetSubnetID, "VnetSubnetId", "csharp");
@@clientName(MachineNetworkProperties.podSubnetID, "PodSubnetId", "csharp");
@@clientName(MachineNetworkProperties.nodePublicIPPrefixID,
  "NodePublicIpPrefixId",
  "csharp"
);
@@clientName(GPUInstanceProfile, "GpuInstanceProfile", "csharp");
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
@@clientName(ManagedClusterProperties.privateFQDN, "PrivateFqdn", "csharp");
@@clientName(ManagedClusterProperties.azurePortalFQDN,
  "AzurePortalFqdn",
  "csharp"
);
@@clientName(ManagedClusterProperties.enableRBAC, "EnableRbac", "csharp");
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
@@clientName(PrivateLinkServiceConnectionState.status,
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
@@clientName(ManagedClusterIdentity.type, "ResourceIdentityType", "csharp");
@@clientName(ManagedClusterHTTPProxyConfig,
  "ManagedClusterHttpProxyConfig",
  "csharp"
);
@@clientName(LocalDNSMode, "LocalDnsMode", "csharp");
@@clientName(LocalDNSState, "LocalDnsState", "csharp");
@@clientName(LocalDNSQueryLogging, "LocalDnsQueryLogging", "csharp");
@@clientName(LocalDNSProtocol, "LocalDnsProtocol", "csharp");
@@clientName(LocalDNSForwardDestination,
  "LocalDnsForwardDestination",
  "csharp"
);
@@clientName(LocalDNSForwardPolicy, "LocalDnsForwardPolicy", "csharp");
@@clientName(LocalDNSServeStale, "LocalDnsServeStale", "csharp");
@@clientName(LocalDNSProfile, "LocalDnsProfile", "csharp");
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

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "List operation is pageable for .Net SDK"
@@markAsPageable(PrivateEndpointConnections.list, "csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Ensure backward compatibility for the .NET SDK"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(ManagedNamespace,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Ensure backward compatibility for the .NET SDK"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(AgentPoolAvailableVersions,
  Azure.ResourceManager.Foundations.ProxyResource,
  "csharp"
);

@@scope(ManagedClusters.operationStatusResultList, "!csharp");
@@scope(ManagedClusters.operationStatusResultGet, "!csharp");
@@scope(AgentPools.getByAgentPool, "!csharp");
