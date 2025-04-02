import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
using Azure.ClientGenerator.Core;
using Microsoft.ServiceFabric;

@@clientName(ManagedMaintenanceWindowStatusContent,
  "ManagedMaintenanceWindowStatus"
);
@@clientName(ManagedAzResiliencyStatusContent, "ManagedAzResiliencyStatus");

@@clientName(ManagedAzResiliencyStatus, "ManagedAzResiliencyStatuses", "java");
@@clientName(ManagedMaintenanceWindowStatus,
  "ManagedMaintenanceWindowStatuses",
  "java"
);

@@clientName(PublicIPAddressConfiguration,
  "IPConfigurationPublicIPAddressConfiguration",
  "go, java, javascript, python"
);

/**
 * Dotnet Operation and Model Renaming/Retyping
 */
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
@@clientName(ManagedClusterProperties.clusterCertificateThumbprints,
  "-|any",
  "csharp"
);
@@clientName(ManagedClusterProperties.clusterId, "-|uuid", "csharp");
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
@@clientName(ServiceEndpoint.locations, "-|azure-location", "csharp");
@@clientName(NodeType, "ServiceFabricManagedNodeType", "csharp");
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
@@clientName(VmManagedIdentity.userAssignedIdentities, "-|arm-id", "csharp");
@@clientName(NodeTypeActionParameters, "NodeTypeActionContent", "csharp");
@@clientName(NodeTypeActionParameters.force, "IsForced", "csharp");
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
@@clientName(NodeTypeAvailableSku.resourceType, "-|resource-type", "csharp");
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
@@clientName(ResourceAzStatus.resourceType, "-|resource-type", "csharp");
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

@@alternateType(ManagedClusterProperties.clusterId, uuid, "csharp");
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
