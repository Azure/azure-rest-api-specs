import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
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

// C# specific renaming from rename-mapping
@@clientName(ManagedClusterPodIdentityProvisioningError.error,
  "ErrorDetail",
  "csharp"
);
@@clientName(AgentPool, "ContainerServiceAgentPool", "csharp");
@@clientName(Machine, "ContainerServiceMachine", "csharp");
@@clientName(MaintenanceConfiguration,
  "ContainerServiceMaintenanceConfiguration",
  "csharp"
);
@@clientName(ManagedCluster, "ContainerServiceManagedCluster", "csharp");
@@clientName(TrustedAccessRoleBinding,
  "ContainerServiceTrustedAccessRoleBinding",
  "csharp"
);
@@clientName(PrivateEndpointConnection,
  "ContainerServicePrivateEndpointConnection",
  "csharp"
);
// @@clientName(ManagedCluster, "ContainerServiceManagedCluster", "csharp");
@@clientName(Code, "ContainerServiceStateCode", "csharp");
@@clientName(Format, "KubeConfigFormat", "csharp");
@@clientName(Expander, "AutoScaleExpander", "csharp");
@@clientName(KubeletConfig.containerLogMaxSizeMB,
  "ContainerLogMaxSizeInMB",
  "csharp"
);
@@clientName(LinuxOSConfig.swapFileSizeMB, "SwapFileSizeInMB", "csharp");
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
@@clientName(SnapshotProperties.osType, "OSType", "csharp");
@@clientName(SnapshotProperties.osSku, "OSSku", "csharp");
@@clientName(SnapshotProperties.enableFIPS, "EnableFips", "csharp");
@@clientName(AgentPoolUpgradeProfileProperties.osType, "OSType", "csharp");
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
@@clientName(ManagedClusterStorageProfileDiskCSIDriver.enabled,
  "IsDiskCsiDriverEnabled",
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
@@clientName(NodeOSUpgradeChannel,
  "ManagedClusterNodeOSUpgradeChannel",
  "csharp"
);
@@clientName(PortRange, "AgentPoolNetworkPortRange", "csharp");
@@clientName(Protocol, "AgentPoolNetworkPortProtocol", "csharp");
@@clientName(ManagedCluster.identity, "ClusterIdentity", "csharp");
@@clientName(Azure.ResourceManager.CommonTypes.DelegatedResource,
  "ManagedClusterDelegatedIdentity",
  "csharp"
);
@@clientName(ManagedClusterProperties.resourceUID, "ResourceID", "csharp");
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
@@clientName(IPFamily, "ContainerServiceIPFamily", "csharp");
@@clientName(ArtifactSource, "ContainerServiceArtifactSource", "csharp");
@@clientName(CreationData, "ContainerServiceCreationData", "csharp");
@@clientName(DateSpan, "ContainerServiceDateSpan", "csharp");
@@clientName(EndpointDependency,
  "ContainerServiceEndpointDependency",
  "csharp"
);
@@clientName(EndpointDetail, "ContainerServiceEndpointDetail", "csharp");
@@clientName(IPTag, "ContainerServiceIPTag", "csharp");
@@clientName(LoadBalancerSku, "ContainerServiceLoadBalancerSku", "csharp");
@@clientName(MachineIpAddress, "ContainerServiceMachineIPAddress", "csharp");
@@clientName(MachineProperties, "ContainerServiceMachineProperties", "csharp");
@@clientName(MaintenanceWindow, "ContainerServiceMaintenanceWindow", "csharp");
@@clientName(NetworkMode, "ContainerServiceNetworkMode", "csharp");
@@clientName(NetworkPlugin, "ContainerServiceNetworkPlugin", "csharp");
@@clientName(NetworkPluginMode, "ContainerServiceNetworkPluginMode", "csharp");
@@clientName(NetworkPolicy, "ContainerServiceNetworkPolicy", "csharp");
@@clientName(OSDiskType, "ContainerServiceOSDiskType", "csharp");
@@clientName(OSSKU, "ContainerServiceOSSku", "csharp");
@@clientName(OSType, "ContainerServiceOSType", "csharp");
@@clientName(OutboundEnvironmentEndpoint,
  "ContainerServiceOutboundEnvironmentEndpoint",
  "csharp"
);
@@clientName(OutboundType, "ContainerServiceOutboundType", "csharp");
@@clientName(PowerState, "ContainerServicePowerState", "csharp");
@@clientName(PublicNetworkAccess,
  "ContainerServicePublicNetworkAccess",
  "csharp"
);
@@clientName(TagsObject, "ContainerServiceTagsObject", "csharp");
@@clientName(TimeInWeek, "ContainerServiceTimeInWeek", "csharp");
@@clientName(TimeSpan, "ContainerServiceTimeSpan", "csharp");
@@clientName(TrustedAccessRole, "ContainerServiceTrustedAccessRole", "csharp");
@@clientName(TrustedAccessRoleBindingProvisioningState,
  "ContainerServiceTrustedAccessRoleBindingProvisioningState",
  "csharp"
);
@@clientName(TrustedAccessRoleRule,
  "ContainerServiceTrustedAccessRoleRule",
  "csharp"
);
@@clientName(UserAssignedIdentity,
  "ContainerServiceUserAssignedIdentity",
  "csharp"
);
@@clientName(NodeProvisioningDefaultNodePools,
  "NodeProvisioningDefaultNodePool",
  "csharp"
);
@@clientName(NetworkPolicies, "NamespaceNetworkPolicies", "csharp");
@@clientName(PolicyRule, "NamespaceNetworkPolicyRule", "csharp");
@@clientName(ResourceQuota, "NamespaceResourceQuota", "csharp");
@@clientName(WeekDay, "ContainerServiceWeekDay", "csharp");
@@clientName(ManagedClusterSKU, "ManagedClusterSku", "csharp");
@@clientName(ManagedClusterOIDCIssuerProfile,
  "ManagedClusterOidcIssuerProfile",
  "csharp"
);
@@clientName(ManagedClusterAADProfile, "ManagedClusterAadProfile", "csharp");
@@clientName(ManagedClusterAPIServerAccessProfile,
  "ManagedClusterApiServerAccessProfile",
  "csharp"
);
@@clientName(ManagedClusterHTTPProxyConfig,
  "ManagedClusterHttpProxyConfig",
  "csharp"
);
@@clientName(GPUInstanceProfile, "GpuInstanceProfile", "csharp");
@@clientName(LocalDNSProfile, "LocalDnsProfile", "csharp");
@@clientName(RestrictionLevel,
  "ManagedClusterNodeResourceGroupRestrictionLevel",
  "csharp"
);
@@clientName(VirtualMachineNodes, "AgentPoolVirtualMachineNodes", "csharp");
@@clientName(LocalDNSMode, "LocalDnsMode", "csharp");
@@clientName(LocalDNSState, "LocalDnsState", "csharp");
@@clientName(LocalDNSOverride, "LocalDnsOverride", "csharp");
@@clientName(LocalDNSForwardDestination,
  "LocalDnsForwardDestination",
  "csharp"
);
@@clientName(LocalDNSForwardPolicy, "LocalDnsForwardPolicy", "csharp");
@@clientName(LocalDNSProtocol, "LocalDnsProtocol", "csharp");
@@clientName(LocalDNSQueryLogging, "LocalDnsQueryLogging", "csharp");
@@clientName(LocalDNSServeStale, "LocalDnsServeStale", "csharp");
@@clientName(ManagedClusterNATGatewayProfile,
  "ManagedClusterNatGatewayProfile",
  "csharp"
);
@@clientName(ManagedClusterSKUName, "ManagedClusterSkuName", "csharp");
@@clientName(ManagedClusterSKUTier, "ManagedClusterSkuTier", "csharp");
@@clientName(AgentPoolAvailableVersionsPropertiesAgentPoolVersionsItem,
  "AgentPoolAvailableVersion",
  "csharp"
);
@@clientName(AgentPoolAvailableVersionsPropertiesAgentPoolVersionsItem.default,
  "IsDefault",
  "csharp"
);
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
@@clientName(ManagedClusters.post, "ResolvePrivateLinkServiceId", "csharp");
@@clientName(ManagedClusters.getAvailableAgentPoolVersions,
  "GetAvailableAgentPoolVersions",
  "csharp"
);
@@clientName(MaintenanceConfigurationProperties.timeInWeek,
  "TimesInWeek",
  "csharp"
);
@@clientName(MaintenanceConfigurationProperties.notAllowedTime,
  "NotAllowedTimes",
  "csharp"
);
@@clientName(ManagedClusterWindowsProfile.enableCSIProxy,
  "IsCsiProxyEnabled",
  "csharp"
);
@@clientName(MachineOSProfile.osDiskSizeGB, "OSDiskSizeInGB", "csharp");
@@clientName(ManagedClusterAgentPoolProfileProperties.osDiskSizeGB,
  "OSDiskSizeInGB",
  "csharp"
);
@@clientName(ManagedClusterPropertiesAutoScalerProfile.`scan-interval`,
  "ScanIntervalInSeconds",
  "csharp"
);
@@alternateType(ManagedClusterAgentPoolProfileProperties.capacityReservationGroupID,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(ManagedClusters.operationStatusResultList,
  "GetOperationStatusResultList",
  "csharp"
);
@@clientName(ManagedClusters.privateLinkResourcesList,
  "GetPrivateLinkResourcesList",
  "csharp"
);
@@alternateType(PrivateLinkResource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(UserAssignedIdentity.objectId, Azure.Core.uuid, "csharp");
@@alternateType(UserAssignedIdentity.clientId, Azure.Core.uuid, "csharp");
@@alternateType(ManagedClusterAADProfile.serverAppID,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(ManagedClusterAADProfile.clientAppID,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(ManagedClusterAADProfile.adminGroupObjectIDs,
  Azure.Core.uuid[],
  "csharp"
);
@@alternateType(ManagedClusterProperties.resourceUID,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ManagedCluster.extendedLocation,
  Azure.ResourceManager.CommonTypes.ExtendedLocation,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(PrivateEndpointConnections.list,
  "csharp"
);
// Resolve namespace conflicts
@@clientLocation(ContainerServiceOperationGroup.listNodeImageVersions,
  "ContainerServices",
  "csharp"
);
@@scope(AgentPools.getByAgentPool, "!csharp");
@@scope(ManagedClusters.operationStatusResultGet, "!csharp");
