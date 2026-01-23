import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
using Azure.ClientGenerator.Core;
using Microsoft.ServiceFabric;

// we add this model in this namespace in order to replace some models with this model via alternateType decorator
namespace Azure.ResourceManager.Models {
  /** represents a reference to an existing resource by its id */
  model WritableSubResource {
    /** the id */
    id?: armResourceIdentifier;
  }
}

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

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator for backwards compatibility with existing spec"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VMSSExtension.properties);

@@clientName(ApplicationTypes.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ApplicationTypes.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator for backwards compatibility with existing spec"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ApplicationTypeResource.properties
);

@@clientName(ApplicationTypeVersions.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ApplicationTypeVersions.update::parameters.properties,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator for backwards compatibility with existing spec"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ApplicationTypeVersionResource.properties
);

@@clientName(Applications.createOrUpdate::parameters.resource, "parameters");
@@clientName(Applications.update::parameters.properties, "parameters");
@@clientName(Applications.resumeUpgrade::parameters.body, "parameters");
@@clientName(Applications.updateUpgrade::parameters.body, "parameters");
@@clientName(Applications.fetchHealth::parameters.body, "parameters");
@@clientName(Applications.restartDeployedCodePackage::parameters.body,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator for backwards compatibility with existing spec"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ApplicationResource.properties
);

@@clientName(Services.createOrUpdate::parameters.resource, "parameters");
@@clientName(Services.update::parameters.properties, "parameters");
@@clientName(Services.restartReplica::parameters.body, "parameters");

@@clientName(ManagedClusters.createOrUpdate::parameters.resource, "parameters");
@@clientName(ManagedClusters.update::parameters.properties, "parameters");
@@clientName(ManagedClusters.getFaultSimulation::parameters.body, "parameters");
@@clientName(ManagedClusters.startFaultSimulation::parameters.body,
  "parameters"
);
@@clientName(ManagedClusters.stopFaultSimulation::parameters.body,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator for backwards compatibility with existing spec"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ManagedCluster.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator for backwards compatibility with existing spec"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ManagedClusterCodeVersionResult.properties
);

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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator for backwards compatibility with existing spec"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(NodeType.properties);

@@Azure.ResourceManager.identifiers(FaultSimulationListResult.value,
  #["simulationId"]
);

@@scope(OperationResults.get, "!java, !csharp");
@@scope(OperationStatus.get, "!java, !csharp");

@@clientName(ManagedAzResiliencyStatus, "ManagedAzResiliencyStatuses", "java");
@@clientName(ManagedMaintenanceWindowStatus,
  "ManagedMaintenanceWindowStatuses",
  "java"
);
@@clientName(ManagedClusterProperties.adminUserName, "adminUsername", "java");
@@clientName(ManagedClusterProperties.VMImage, "vmImage", "java");
@@clientName(ManagedClusterProperties.enableServicePublicIP,
  "enableServicePublicIp",
  "java"
);
@@clientName(ManagedClusterProperties.publicIPPrefixId,
  "publicIpPrefixId",
  "java"
);
@@clientName(PublicIPAddressConfiguration.publicIPAddressVersion,
  "publicIpAddressVersion",
  "java"
);
@@clientName(IpConfiguration.privateIPAddressVersion,
  "privateIpAddressVersion",
  "java"
);
@@clientName(IpConfiguration.publicIPAddressConfiguration,
  "publicIpAddressConfiguration",
  "java"
);
@@clientName(NodeTypeProperties.enableNodePublicIP,
  "enableNodePublicIp",
  "java"
);
@@clientName(IPAddressType, "IpAddressType", "java");
@@clientName(PublicIPAddressConfiguration,
  "IpConfigurationPublicIpAddressConfiguration",
  "java"
);
@@clientName(PrivateIPAddressVersion, "PrivateIpAddressVersion", "java");
@@clientName(PublicIPAddressVersion, "PublicIpAddressVersion", "java");
@@clientName(VMSSExtension, "VmssExtension", "java");
@@alternateType(VMSSExtensionProperties.settings, unknown, "java");
@@alternateType(VMSSExtensionProperties.protectedSettings, unknown, "java");

@@clientName(PublicIPAddressConfiguration,
  "IPConfigurationPublicIPAddressConfiguration",
  "go, javascript, python"
);

/**
 * Dotnet Operation and Model Renaming/Retyping
 */
@@scope(Operations.list, "!csharp");

@@alternateType(Azure.ResourceManager.CommonTypes.TrackedResource.id,
  armResourceIdentifier,
  "csharp"
);

@@clientName(ManagedAzResiliencyStatus.get,
  "GetManagedAzResiliencyStatus",
  "csharp"
);
@@clientName(NodeTypeSkus.list, "GetAvailableSkus", "csharp");
@@clientName(ManagedUnsupportedVMSizes.get,
  "GetManagedUnsupportedVmSize",
  "csharp"
);
@@clientName(ManagedUnsupportedVMSizes.list,
  "GetManagedUnsupportedVmSizes",
  "csharp"
);
@@clientName(ManagedClusterVersion.getByEnvironment,
  "GetManagedClusterVersionByEnvironment",
  "csharp"
);
@@clientName(ManagedAzResiliencyStatus.get,
  "GetManagedAzResiliencyStatus",
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding decorator for backwards compatibility with existing spec"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(ApplicationResource,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
@@clientName(ApplicationResource, "ServiceFabricManagedApplication", "csharp");
@@alternateType(ApplicationResource.identity,
  Azure.ResourceManager.Foundations.ManagedServiceIdentity,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding decorator for backwards compatibility with existing spec"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(ApplicationTypeResource,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
@@clientName(ApplicationTypeResource,
  "ServiceFabricManagedApplicationType",
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding decorator for backwards compatibility with existing spec"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(ApplicationTypeVersionResource,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
@@clientName(ApplicationTypeVersionResource,
  "ServiceFabricManagedApplicationTypeVersion",
  "csharp"
);
@@clientName(ApplicationUserAssignedIdentity,
  "ApplicationUserAssignedIdentityInfo",
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding decorator for backwards compatibility with existing spec"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(ManagedClusterCodeVersionResult,
  Azure.ResourceManager.Foundations.ProxyResource,
  "csharp"
);
@@clientName(ManagedClusterCodeVersionResult,
  "ServiceFabricManagedClusterVersion",
  "csharp"
);
@@clientName(ManagedClusterVersionDetails.osType, "OSType", "csharp");
@@clientName(ManagedClusterVersionDetails.supportExpiryUtc,
  "VersionSupportExpireOn",
  "csharp"
);
@@clientName(ManagedCluster, "ServiceFabricManagedCluster", "csharp");
@@clientName(ManagedClusterProperties.addonFeatures, "AddOnFeatures", "csharp");
@@clientName(ManagedClusterProperties.allowRdpAccess,
  "IsRdpAccessAllowed",
  "csharp"
);
@@clientName(ManagedClusterProperties.enableAutoOSUpgrade,
  "IsAutoOSUpgradeEnabled",
  "csharp"
);
@@clientName(ManagedClusterProperties.enableIpv6, "IsIPv6Enabled", "csharp");
@@clientName(ManagedClusterProperties.enableServicePublicIP,
  "IsServicePublicIPEnabled",
  "csharp"
);
@@clientName(ManagedClusterProperties.zonalResiliency,
  "HasZoneResiliency",
  "csharp"
);
@@clientName(ManagedClusterProperties.enableHttpGatewayExclusiveAuthMode,
  "IsHttpGatewayExclusiveAuthModeEnabled",
  "csharp"
);
@@clientName(ManagedClusterProperties.ipTags, "IPTags", "csharp");
@@clientName(ManagedClusterProperties.ipv4Address, "IPv4Address", "csharp");
@@clientName(ManagedClusterProperties.ipv6Address, "IPv6Address", "csharp");
@@clientName(ManagedClusterProperties.VMImage, "VmImage", "csharp");

@@clientName(OsType, "ServiceFabricManagedClusterOSType", "csharp");
@@clientName(Subnet, "ManagedClusterSubnet", "csharp");
@@clientName(Subnet.enableIpv6, "IsIPv6Enabled", "csharp");
@@clientName(AzureActiveDirectory,
  "ManagedClusterAzureActiveDirectory",
  "csharp"
);
@@clientName(ClientCertificate, "ManagedClusterClientCertificate", "csharp");
@@clientName(ClusterState, "ServiceFabricManagedClusterState", "csharp");
@@clientName(ClusterUpgradeCadence, "ManagedClusterUpgradeCadence", "csharp");
@@clientName(ClusterUpgradeMode, "ManagedClusterUpgradeMode", "csharp");
@@clientName(SettingsSectionDescription,
  "ClusterFabricSettingsSection",
  "csharp"
);
@@clientName(SettingsParameterDescription,
  "ClusterFabricSettingsParameterDescription",
  "csharp"
);
@@clientName(IpTag, "ManagedClusterIPTag", "csharp");
@@clientName(IpTag.ipTagType, "IPTagType", "csharp");
@@clientName(LoadBalancingRule, "ManagedClusterLoadBalancingRule", "csharp");
@@clientName(NetworkSecurityRule,
  "ServiceFabricManagedNetworkSecurityRule",
  "csharp"
);
@@clientName(Direction,
  "ServiceFabricManagedNetworkSecurityRuleDirection",
  "csharp"
);
@@clientName(Microsoft.ServiceFabric.Access,
  "ServiceFabricManagedNetworkTrafficAccess",
  "csharp"
);
@@clientName(ManagedResourceProvisioningState,
  "ServiceFabricManagedResourceProvisioningState",
  "csharp"
);
@@clientName(ServiceEndpoint, "ManagedClusterServiceEndpoint", "csharp");
@@clientName(NodeType, "ServiceFabricManagedNodeType", "csharp");
@@clientName(NodeTypeProperties,
  "ServiceFabricManagedNodeTypeProperties",
  "csharp"
);
@@clientName(NodeTypeProperties.zoneBalance, "IsZoneBalanceEnabled", "csharp");
@@clientName(NodeTypeProperties.dataDiskSizeGB, "DataDiskSizeInGB", "csharp");
@@clientName(NodeTypeProperties.enableAcceleratedNetworking,
  "IsAcceleratedNetworkingEnabled",
  "csharp"
);
@@clientName(NodeTypeProperties.enableEncryptionAtHost,
  "IsEncryptionAtHostEnabled",
  "csharp"
);
@@clientName(NodeTypeProperties.enableOverProvisioning,
  "IsOverProvisioningEnabled",
  "csharp"
);
@@clientName(NodeTypeProperties.multiplePlacementGroups,
  "HasMultiplePlacementGroups",
  "csharp"
);
@@clientName(NodeTypeProperties.enableNodePublicIPv6,
  "IsNodePublicIPv6Enabled",
  "csharp"
);
@@clientName(VmApplication, "ServiceFabricManagedVmApplication", "csharp");
@@clientName(VmssDataDisk, "NodeTypeVmssDataDisk", "csharp");
@@clientName(VmssDataDisk.diskSizeGB, "DiskSizeInGB", "csharp");
@@clientName(VMSSExtension, "NodeTypeVmssExtension", "csharp");
@@clientName(VMSSExtensionProperties, "VmssExtensionProperties", "csharp");
@@clientName(VMSSExtensionProperties.enableAutomaticUpgrade,
  "IsAutomaticUpgradeEnabled",
  "csharp"
);
@@clientName(VaultSecretGroup, "NodeTypeVaultSecretGroup", "csharp");
@@alternateType(VaultSecretGroup.sourceVault,
  Azure.ResourceManager.Models.WritableSubResource,
  "csharp"
);
@@clientName(VaultCertificate, "NodeTypeVaultCertificate", "csharp");
@@clientName(DiskType, "ServiceFabricManagedDataDiskType", "csharp");
@@clientName(FrontendConfiguration, "NodeTypeFrontendConfiguration", "csharp");
@@clientName(FrontendConfiguration.ipAddressType, "IPAddressType", "csharp");
@@clientName(NodeTypeActionParameters, "NodeTypeActionContent", "csharp");
@@clientName(NodeTypeActionParameters.force, "IsForced", "csharp");
@@clientName(FaultSimulationContent.force, "IsForced", "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding decorator for backwards compatibility with existing spec"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(ServiceResource,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
@@clientName(ServiceResource, "ServiceFabricManagedService", "csharp");
@@clientName(ServiceResourceProperties, "ManagedServiceProperties", "csharp");
@@clientName(ServiceResourcePropertiesBase,
  "ManagedServiceBaseProperties",
  "csharp"
);
@@clientName(ServiceCorrelation, "ManagedServiceCorrelation", "csharp");
@@clientName(ServiceCorrelationScheme,
  "ManagedServiceCorrelationScheme",
  "csharp"
);
@@clientName(ScalingPolicy, "ManagedServiceScalingPolicy", "csharp");
@@clientName(ScalingMechanism, "ManagedServiceScalingMechanism", "csharp");
@@clientName(ScalingTrigger, "ManagedServiceScalingTrigger", "csharp");
@@clientName(MoveCost, "ServiceFabricManagedServiceMoveCost", "csharp");
@@clientName(ApplicationUpgradePolicy.instanceCloseDelayDuration,
  "InstanceCloseDelayDurationInSeconds",
  "csharp"
);
@@clientName(FailureAction, "PolicyViolationCompensationAction", "csharp");
@@clientName(IPAddressType,
  "NodeTypeFrontendConfigurationIPAddressType",
  "csharp"
);
@@clientName(ProbeProtocol, "ManagedClusterLoadBalanceProbeProtocol", "csharp");
@@clientName(Protocol,
  "ManagedClusterLoadBalancingRuleTransportProtocol",
  "csharp"
);
@@clientName(Partition, "ManagedServicePartitionScheme", "csharp");
@@clientName(NsgProtocol, "ServiceFabricManagedNsgProtocol", "csharp");
@@clientName(NsgProtocol.ah, "AH", "csharp");
@@clientName(PartitionInstanceCountScaleMechanism,
  "PartitionInstanceCountScalingMechanism",
  "csharp"
);
@@clientName(PrivateEndpointNetworkPolicies,
  "ManagedClusterSubnetPrivateEndpointNetworkPoliciesState",
  "csharp"
);
@@clientName(PrivateLinkServiceNetworkPolicies,
  "ManagedClusterSubnetPrivateLinkServiceNetworkPoliciesState",
  "csharp"
);
@@clientName(ServiceLoadMetric, "ManagedServiceLoadMetric", "csharp");
@@clientName(ServiceLoadMetricWeight,
  "ManagedServiceLoadMetricWeight",
  "csharp"
);
@@clientName(ServicePackageActivationMode,
  "ManagedServicePackageActivationMode",
  "csharp"
);
@@clientName(ServicePlacementPolicy, "ManagedServicePlacementPolicy", "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding decorator for backwards compatibility with existing spec"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(ManagedVMSize,
  Azure.ResourceManager.Foundations.ProxyResource,
  "csharp"
);
@@clientName(ManagedVMSize, "ServiceFabricManagedUnsupportedVmSize", "csharp");
@@clientName(ManagedVMSizesResult,
  "ServiceFabricManagedUnsupportedVmSizeListResult",
  "csharp"
);
@@clientName(VMSize, "ServiceFabricManagedVmSizeProperties", "csharp");
@@clientName(AddRemoveIncrementalNamedPartitionScalingMechanism,
  "NamedPartitionAddOrRemoveScalingMechanism",
  "csharp"
);
@@clientName(NodeTypeProperties.enableNodePublicIP,
  "IsNodePublicIPEnabled",
  "csharp"
);
@@clientName(NodeTypeProperties.secureBootEnabled,
  "IsSecureBootEnabled",
  "csharp"
);
@@clientName(NodeTypeProperties.isSpotVM, "IsSpotVm", "csharp");
@@clientName(EvictionPolicyType, "SpotNodeVmEvictionPolicyType", "csharp");
@@clientName(SecurityType, "ServiceFabricManagedClusterSecurityType", "csharp");
@@clientName(SecurityType.ConfidentialVM, "ConfidentialVm", "csharp");
@@clientName(UpdateType, "ServiceFabricManagedClusterUpdateType", "csharp");
@@clientName(ClusterHealthPolicy, "ManagedClusterHealthPolicy", "csharp");
@@clientName(ClusterUpgradePolicy, "ManagedClusterUpgradePolicy", "csharp");
@@clientName(ClusterUpgradeDeltaHealthPolicy,
  "ManagedClusterUpgradeDeltaHealthPolicy",
  "csharp"
);
@@clientName(ClusterMonitoringPolicy,
  "ManagedClusterMonitoringPolicy",
  "csharp"
);
@@clientName(PrivateIPAddressVersion,
  "ServiceFabricManagedClusterPrivateIPAddressVersion",
  "csharp"
);
@@clientName(PublicIPAddressVersion,
  "ServiceFabricManagedClusterPublicIPAddressVersion",
  "csharp"
);
@@clientName(IpConfiguration,
  "ServiceFabricManagedClusterIPConfiguration",
  "csharp"
);
@@clientName(PublicIPAddressConfiguration,
  "ServiceFabricManagedClusterPublicIPAddressConfiguration",
  "csharp"
);
@@clientName(PublicIPAddressConfiguration.ipTags, "IPTags", "csharp");
@@clientName(ManagedMaintenanceWindowStatusContent.lastWindowStatusUpdateAtUTC,
  "LastWindowStatusUpdatedOn",
  "csharp"
);
@@clientName(ManagedMaintenanceWindowStatusContent.lastWindowStartTimeUTC,
  "LastWindowStartOn",
  "csharp"
);
@@clientName(ManagedMaintenanceWindowStatusContent.lastWindowEndTimeUTC,
  "LastWindowEndOn",
  "csharp"
);
@@clientName(VMSSExtensionProperties.type,
  "vmssExtensionPropertiesType",
  "csharp"
);
@@clientName(DiskType.Standard_LRS, "StandardLrs", "csharp");
@@clientName(DiskType.StandardSSD_LRS, "StandardSsdLrs", "csharp");
@@clientName(DiskType.Premium_LRS, "PremiumLrs", "csharp");
@@clientName(DiskType.StandardSSD_ZRS, "PremiumV2Lrs", "csharp");
@@clientName(DiskType.StandardSSD_ZRS, "StandardSsdZrs", "csharp");
@@clientName(DiskType.StandardSSD_ZRS, "PremiumZrs", "csharp");

@@clientName(SecurityEncryptionType,
  "NodeTypeSecurityEncryptionType",
  "csharp"
);
@@clientName(SecurityEncryptionType.DiskWithVMGuestState,
  "DiskWithVmGuestState",
  "csharp"
);
@@clientName(SecurityEncryptionType.VMGuestStateOnly,
  "VmGuestStateOnly",
  "csharp"
);
@@clientName(HealthFilter, "ApplicationFetchHealthFilter ", "csharp");
@@clientName(RestartReplicaRequest,
  "ManagedServiceRestartReplicaContent ",
  "csharp"
);
@@clientName(RestartReplicaRequest.timeout, "TimeoutInSeconds", "csharp");
@@clientName(RestartKind, "ManagedServiceRestartKind", "csharp");
@@clientName(ApplicationFetchHealthRequest.timeout,
  "TimeoutInSeconds",
  "csharp"
);

@@alternateType(ManagedClusterVersion.list::parameters.location,
  azureLocation,
  "csharp"
);
@@alternateType(ManagedClusterVersion.get::parameters.location,
  azureLocation,
  "csharp"
);
@@alternateType(ManagedClusterVersion.getByEnvironment::parameters.location,
  azureLocation,
  "csharp"
);
@@alternateType(ManagedClusterVersion.listByEnvironment::parameters.location,
  azureLocation,
  "csharp"
);
@@alternateType(ManagedUnsupportedVMSizes.get::parameters.location,
  azureLocation,
  "csharp"
);
@@alternateType(ManagedUnsupportedVMSizes.list::parameters.location,
  azureLocation,
  "csharp"
);

@@alternateType(ManagedClusterProperties.clusterId, uuid, "csharp");
@@alternateType(ManagedCluster.etag, eTag, "csharp");
@@alternateType(ManagedClusterProperties.ipv4Address, ipV4Address, "csharp");
@@alternateType(ManagedClusterProperties.ipv6Address, ipV6Address, "csharp");
@@alternateType(Subnet.networkSecurityGroupId, armResourceIdentifier, "csharp");
@@alternateType(FrontendConfiguration.loadBalancerBackendAddressPoolId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(FrontendConfiguration.loadBalancerInboundNatPoolId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(NodeTypeAvailableSku.resourceType, armResourceType, "csharp");
@@alternateType(ResourceAzStatus.resourceType, armResourceType, "csharp");
@@alternateType(ApplicationTypeVersionResourceProperties.appPackageUrl,
  url,
  "csharp"
);
@@alternateType(AzureActiveDirectory.tenantId, uuid, "csharp");
@@alternateType(VaultCertificate.certificateUrl, url, "csharp");
@@alternateType(ServiceEndpoint.locations, azureLocation[], "csharp");
@@alternateType(ManagedClusterProperties.clusterCertificateThumbprints,
  unknown[],
  "csharp"
);
@@alternateType(ClientCertificate.thumbprint, unknown, "csharp");
@@alternateType(ClientCertificate.issuerThumbprint, unknown, "csharp");
@@alternateType(VMSSExtensionProperties.settings, unknown, "csharp");
@@alternateType(VMSSExtensionProperties.protectedSettings, unknown, "csharp");
@@clientName(VmManagedIdentity.userAssignedIdentities,
  "UserAssignedIdentities",
  "csharp"
);
@@alternateType(VmManagedIdentity.userAssignedIdentities,
  armResourceIdentifier[],
  "csharp"
);
@@alternateType(ClusterMonitoringPolicy.healthCheckRetryTimeout,
  string,
  "csharp"
);
@@alternateType(ClusterMonitoringPolicy.upgradeDomainTimeout, string, "csharp");
@@alternateType(ClusterMonitoringPolicy.upgradeTimeout, string, "csharp");
@@alternateType(Microsoft.ServiceFabric.SubResource.id,
  armResourceIdentifier,
  "csharp"
);

@@clientName(AdditionalNetworkInterfaceConfiguration.ipConfigurations,
  "IPConfigurations",
  "csharp"
);
@@clientName(ManagedMaintenanceWindowStatus.get,
  "GetManagedMaintenanceWindowStatus",
  "csharp"
);
@@clientName(ManagedClusterVersion.list, "GetManagedClusterVersions", "csharp");
@@clientName(ManagedClusterVersion.listByEnvironment,
  "GetManagedClusterVersionsByEnvironment",
  "csharp"
);
@@clientName(ManagedClusterVersion.get, "GetManagedClusterVersion", "csharp");
@@clientName(RuntimeUpdateApplicationUpgradeParameters,
  "RuntimeUpdateApplicationUpgradeContent",
  "csharp"
);
@@clientName(RestartDeployedCodePackageRequest,
  "RestartDeployedCodePackageContent",
  "csharp"
);
@@clientName(RuntimeResumeApplicationUpgradeParameters,
  "RuntimeResumeApplicationUpgradeContent",
  "csharp"
);
@@clientName(ApplicationFetchHealthRequest,
  "ApplicationFetchHealthContent",
  "csharp"
);
@@clientName(ManagedApplyMaintenanceWindow.post,
  "PostManagedApplyMaintenanceWindow",
  "csharp"
);
@@clientName(Applications.fetchHealth::parameters.body, "content", "csharp");
@@clientName(Applications.restartDeployedCodePackage::parameters.body,
  "content",
  "csharp"
);
@@clientName(Applications.updateUpgrade::parameters.body, "content", "csharp");
@@clientName(Applications.resumeUpgrade::parameters.body, "content", "csharp");
@@clientName(Applications.update::parameters.properties, "patch", "csharp");
@@clientName(ApplicationTypes.update::parameters.properties, "patch", "csharp");
@@clientName(ApplicationTypeVersions.update::parameters.properties,
  "patch",
  "csharp"
);
@@clientName(ManagedClusters.getFaultSimulation::parameters.body,
  "content",
  "csharp"
);
@@clientName(ManagedClusters.stopFaultSimulation::parameters.body,
  "content",
  "csharp"
);
@@clientName(ManagedClusters.update::parameters.properties, "patch", "csharp");
@@clientName(NodeTypes.deallocate::parameters.body, "content", "csharp");
@@clientName(NodeTypes.deleteNode::parameters.body, "content", "csharp");
@@clientName(NodeTypes.getFaultSimulation::parameters.body,
  "content",
  "csharp"
);
@@clientName(NodeTypes.redeploy::parameters.body, "content", "csharp");
@@clientName(NodeTypes.reimage::parameters.body, "content", "csharp");
@@clientName(NodeTypes.restart::parameters.body, "content", "csharp");
@@clientName(NodeTypes.start::parameters.body, "content", "csharp");
@@clientName(NodeTypes.stopFaultSimulation::parameters.body,
  "content",
  "csharp"
);
@@clientName(NodeTypes.update::parameters.properties, "patch", "csharp");
@@clientName(Services.update::parameters.properties, "patch", "csharp");
