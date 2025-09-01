import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
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

@@clientName(ApplicationResource, "ServiceFabricManagedApplication", "csharp");
@@clientName(ApplicationTypeResource,
  "ServiceFabricManagedApplicationType",
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
@@clientName(ManagedClusterCodeVersionResult,
  "ServiceFabricManagedClusterVersion",
  "csharp"
);
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
@@clientName(VaultCertificate, "NodeTypeVaultCertificate", "csharp");
@@clientName(DiskType, "ServiceFabricManagedDataDiskType", "csharp");
@@clientName(FrontendConfiguration, "NodeTypeFrontendConfiguration", "csharp");
@@clientName(NodeTypeActionParameters, "NodeTypeActionContent", "csharp");
@@clientName(NodeTypeActionParameters.force, "IsForced", "csharp");
@@clientName(FaultSimulationContent.force, "IsForced", "csharp");
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
@@clientName(ManagedVMSize, "ServiceFabricManagedUnsupportedVmSize", "csharp");
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
@@clientName(EvictionPolicyType, "SpotNodeVmEvictionPolicyType", "csharp");
@@clientName(SecurityType, "ServiceFabricManagedClusterSecurityType", "csharp");
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
