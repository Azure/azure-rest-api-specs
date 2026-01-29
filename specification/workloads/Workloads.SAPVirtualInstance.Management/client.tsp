import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Microsoft.Workloads;

@@clientName(Microsoft.Workloads,
  "WorkloadsSapVirtualInstanceMgmtClient",
  "python"
);
@@clientName(Microsoft.Workloads,
  "WorkloadsSapVirtualInstanceMgmtClient",
  "java"
);

// interfaces
@@clientName(SAPApplicationServerInstances,
  "SapApplicationServerInstances",
  "java"
);
@@clientName(SAPCentralServerInstances, "SapCentralServerInstances", "java");
@@clientName(SAPDatabaseInstances, "SapDatabaseInstances", "java");
@@clientName(SAPVirtualInstances, "SapVirtualInstances", "java");
// unions and models
@@clientName(SAPEnvironmentType, "SapEnvironmentType", "java");
@@clientName(SAPProductType, "SapProductType", "java");
@@clientName(SAPDeploymentType, "SapDeploymentType", "java");
@@clientName(SAPDatabaseType, "SapDatabaseType", "java");
@@clientName(SAPDatabaseScaleMethod, "SapDatabaseScaleMethod", "java");
@@clientName(SAPHighAvailabilityType, "SapHighAvailabilityType", "java");
@@clientName(SAPConfigurationType, "SapConfigurationType", "java");
@@clientName(SAPVirtualInstanceStatus, "SapVirtualInstanceStatus", "java");
@@clientName(SAPHealthState, "SapHealthState", "java");
@@clientName(SAPVirtualInstanceState, "SapVirtualInstanceState", "java");
@@clientName(SAPSoftwareInstallationType,
  "SapSoftwareInstallationType",
  "java"
);
@@clientName(SAPSizingRecommendationRequest,
  "SapSizingRecommendationRequest",
  "java"
);
@@clientName(SAPSizingRecommendationResult,
  "SapSizingRecommendationResult",
  "java"
);
@@clientName(SAPSupportedSkusRequest, "SapSupportedSkusRequest", "java");
@@clientName(SAPSupportedResourceSkusResult,
  "SapSupportedResourceSkusResult",
  "java"
);
@@clientName(SAPSupportedSku, "SapSupportedSku", "java");
@@clientName(SAPDiskConfigurationsRequest,
  "SapDiskConfigurationsRequest",
  "java"
);
@@clientName(SAPDiskConfigurationsResult,
  "SapDiskConfigurationsResult",
  "java"
);
@@clientName(SAPDiskConfiguration, "SapDiskConfiguration", "java");
@@clientName(SAPAvailabilityZoneDetailsRequest,
  "SapAvailabilityZoneDetailsRequest",
  "java"
);
@@clientName(SAPAvailabilityZoneDetailsResult,
  "SapAvailabilityZoneDetailsResult",
  "java"
);
@@clientName(SAPAvailabilityZonePair, "SapAvailabilityZonePair", "java");
@@clientName(SAPVirtualInstanceProperties,
  "SapVirtualInstanceProperties",
  "java"
);
@@clientName(SAPConfiguration, "SapConfiguration", "java");
@@clientName(SAPVirtualInstanceError, "SapVirtualInstanceError", "java");
@@clientName(SAPCentralServerProperties, "SapCentralServerProperties", "java");
@@clientName(SAPDatabaseProperties, "SapDatabaseProperties", "java");
@@clientName(SAPApplicationServerProperties,
  "SapApplicationServerProperties",
  "java"
);
@@clientName(SAPInstallWithoutOSConfigSoftwareConfiguration,
  "SapInstallWithoutOSConfigSoftwareConfiguration",
  "java"
);
@@clientName(SAPApplicationServerInstance,
  "SapApplicationServerInstance",
  "java"
);
@@clientName(SAPCentralServerInstance, "SapCentralServerInstance", "java");
@@clientName(SAPDatabaseInstance, "SapDatabaseInstance", "java");
@@clientName(SAPVirtualInstance, "SapVirtualInstance", "java");
@@clientName(UpdateSAPVirtualInstanceRequest,
  "UpdateSapVirtualInstanceRequest",
  "java"
);
@@clientName(UpdateSAPVirtualInstanceProperties,
  "UpdateSapVirtualInstanceProperties",
  "java"
);
@@clientName(UpdateSAPCentralInstanceRequest,
  "UpdateSapCentralInstanceRequest",
  "java"
);
@@clientName(UpdateSAPDatabaseInstanceRequest,
  "UpdateSapDatabaseInstanceRequest",
  "java"
);
@@clientName(UpdateSAPApplicationInstanceRequest,
  "UpdateSapApplicationInstanceRequest",
  "java"
);

// CSharp
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SAPApplicationServerInstance.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SAPCentralServerInstance.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SAPDatabaseInstance.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SAPVirtualInstance.properties,
  "csharp"
);

@@clientName(ErrorDefinition, "ErrorInformation", "csharp");

@@clientName(StartRequest, "StartSapInstanceContent", "csharp");

@@clientName(StopRequest, "StopSapInstanceContent", "csharp");

@@clientName(SAPApplicationServerInstances,
  "SapApplicationServerInstances",
  "csharp"
);
@@clientName(SAPCentralServerInstances, "SapCentralServerInstances", "csharp");
@@clientName(SAPDatabaseInstances, "SapDatabaseInstances", "csharp");
@@clientName(SAPVirtualInstances, "SapVirtualInstances", "csharp");
@@clientName(SAPEnvironmentType, "SapEnvironmentType", "csharp");
@@clientName(SAPProductType, "SapProductType", "csharp");
@@clientName(SAPDeploymentType, "SapDeploymentType", "csharp");
@@clientName(SAPDatabaseType, "SapDatabaseType", "csharp");
@@clientName(SAPDatabaseScaleMethod, "SapDatabaseScaleMethod", "csharp");
@@clientName(SAPHighAvailabilityType, "SapHighAvailabilityType", "csharp");
@@clientName(SAPConfigurationType, "SapConfigurationType", "csharp");
@@clientName(SAPVirtualInstanceStatus, "SapVirtualInstanceStatus", "csharp");
@@clientName(SAPHealthState, "SapHealthState", "csharp");
@@clientName(SAPVirtualInstanceState, "SapVirtualInstanceState", "csharp");
@@clientName(SAPSoftwareInstallationType,
  "SapSoftwareInstallationType",
  "csharp"
);
@@clientName(SAPSizingRecommendationRequest,
  "SapSizingRecommendationContent",
  "csharp"
);
@@clientName(SAPSizingRecommendationResult,
  "SapSizingRecommendationResult",
  "csharp"
);
@@clientName(SAPSupportedSkusRequest, "SapSupportedSkusContent", "csharp");
@@clientName(SAPSupportedResourceSkusResult,
  "SapSupportedResourceSkusResult",
  "csharp"
);
@@clientName(SAPSupportedSku, "SapSupportedSku", "csharp");
@@clientName(SAPDiskConfigurationsRequest,
  "SapDiskConfigurationsContent",
  "csharp"
);
@@clientName(SAPDiskConfigurationsResult,
  "SapDiskConfigurationsResult",
  "csharp"
);
@@clientName(SAPDiskConfiguration, "SapDiskConfiguration", "csharp");
@@clientName(SAPAvailabilityZoneDetailsRequest,
  "SapAvailabilityZoneDetailsContent",
  "csharp"
);
@@clientName(SAPAvailabilityZoneDetailsResult,
  "SapAvailabilityZoneDetailsResult",
  "csharp"
);
@@clientName(SAPAvailabilityZonePair, "SapAvailabilityZonePair", "csharp");
@@clientName(SAPVirtualInstanceProperties,
  "SapVirtualInstanceProperties",
  "csharp"
);
@@clientName(SAPConfiguration, "SapConfiguration", "csharp");
@@clientName(SAPVirtualInstanceError, "SapVirtualInstanceError", "csharp");
@@clientName(SAPCentralServerProperties,
  "SapCentralServerProperties",
  "csharp"
);
@@clientName(SAPDatabaseProperties, "SapDatabaseProperties", "csharp");
@@clientName(SAPApplicationServerProperties,
  "SapApplicationServerProperties",
  "csharp"
);
@@clientName(SAPInstallWithoutOSConfigSoftwareConfiguration,
  "SapInstallWithoutOSConfigSoftwareConfiguration",
  "csharp"
);
@@clientName(SAPApplicationServerInstance,
  "SapApplicationServerInstance",
  "csharp"
);
@@clientName(SAPCentralServerInstance, "SapCentralServerInstance", "csharp");
@@clientName(SAPDatabaseInstance, "SapDatabaseInstance", "csharp");
@@clientName(SAPVirtualInstance, "SapVirtualInstance", "csharp");
@@clientName(UpdateSAPVirtualInstanceRequest,
  "UpdateSapVirtualInstanceRequest",
  "csharp"
);
@@clientName(UpdateSAPVirtualInstanceProperties,
  "UpdateSapVirtualInstanceProperties",
  "csharp"
);
@@clientName(UpdateSAPCentralInstanceRequest,
  "UpdateSapCentralInstanceRequest",
  "csharp"
);
@@clientName(UpdateSAPDatabaseInstanceRequest,
  "UpdateSapDatabaseInstanceRequest",
  "csharp"
);
@@clientName(UpdateSAPApplicationInstanceRequest,
  "UpdateSapApplicationInstanceRequest",
  "csharp"
);
@@alternateType(DeployerVmPackages.url, url, "csharp");
@@alternateType(DiscoveryConfiguration.centralServerVmId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(DiskDetails.sizeGB, "sizeInGB", "csharp");
@@clientName(DiskDetails, "SupportedConfigurationsDiskDetails", "csharp");
@@clientName(DiskSku, "SapDiskSku", "csharp");
@@clientName(DiskSkuName, "DiskDetailsDiskSkuName", "csharp");
@@clientName(DiskVolumeConfiguration.sizeGB, "sizeInGB", "csharp");
@@clientName(ErrorDefinition, "SapVirtualInstanceErrorDetail", "csharp");
@@alternateType(ExternalInstallationSoftwareConfiguration.centralServerVmId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(ImageReference, "SapImageReference", "csharp");
@@clientName(LinuxConfiguration, "SapLinuxConfiguration", "csharp");
@@clientName(NamingPatternType, "SapNamingPatternType", "csharp");
@@clientName(OSConfiguration, "SapOSConfiguration", "csharp");
@@clientName(OSProfile, "SapOSProfile", "csharp");
@@clientName(OSType, "SapOSType", "csharp");
@@clientName(SoftwareConfiguration, "SapSoftwareConfiguration", "csharp");
@@clientName(SshConfiguration, "SapSshConfiguration", "csharp");
@@clientName(SshKeyPair, "SapSshKeyPair", "csharp");
@@clientName(SshPublicKey, "SapSshPublicKey", "csharp");
@@clientName(StorageConfiguration, "SapStorageConfiguration", "csharp");
@@clientName(VirtualMachineConfiguration,
  "SapVirtualMachineConfiguration",
  "csharp"
);
@@clientName(WindowsConfiguration, "SapWindowsConfiguration", "csharp");
@@clientName(SAPApplicationServerProperties.subnet, "subnetId", "csharp");
@@alternateType(SAPApplicationServerProperties.subnet,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(SAPVirtualInstanceIdentity,
  "SapVirtualInstanceIdentity",
  "csharp"
);
@@clientName(SAPVirtualInstanceIdentityType,
  "SapVirtualInstanceIdentityType",
  "csharp"
);
@@clientName(SAPVirtualInstanceIdentityProperty,
  "SapVirtualInstanceIdentityProperty",
  "csharp"
);
@@clientName(SAPDatabaseProperties.subnet, "subnetId", "csharp");
@@alternateType(SAPDatabaseProperties.subnet,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(SAPCentralServerProperties.subnet, "subnetId", "csharp");
@@alternateType(SAPCentralServerProperties.subnet,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ApplicationServerConfiguration.subnetId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(ApplicationServerVmDetails.type, "VirtualMachineType", "csharp");
@@alternateType(ApplicationServerVmDetails.virtualMachineId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(CentralServerConfiguration.subnetId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(CentralServerVirtualMachineType.ASCS, "Ascs", "csharp");
@@clientName(CentralServerVirtualMachineType.ERSInactive,
  "ErsInactive",
  "csharp"
);
@@clientName(CentralServerVirtualMachineType.ERS, "Ers", "csharp");
@@clientName(CentralServerVmDetails.type, "VirtualMachineType", "csharp");
@@alternateType(CentralServerVmDetails.virtualMachineId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(DatabaseConfiguration.subnetId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(DatabaseVmDetails.virtualMachineId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(DeployerVmPackages.url, "PackageUri", "csharp");
@@alternateType(DeploymentConfiguration.appLocation,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(DeploymentWithOSConfiguration.appLocation,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(DiscoveryConfiguration.appLocation,
  Azure.Core.azureLocation,
  "csharp"
);
@@clientName(DiskSkuName.Standard_LRS, "StandardLrs", "csharp");
@@clientName(DiskSkuName.Premium_LRS, "PremiumLrs", "csharp");
@@clientName(DiskSkuName.StandardSSD_LRS, "StandardSsdLrs", "csharp");
@@clientName(DiskSkuName.UltraSSD_LRS, "UltraSsdLrs", "csharp");
@@clientName(DiskSkuName.Premium_ZRS, "PremiumZrs", "csharp");
@@clientName(DiskSkuName.StandardSSD_ZRS, "StandardSsdZrs", "csharp");
@@clientName(DiskSkuName.PremiumV2_LRS, "PremiumV2Lrs", "csharp");
@@alternateType(MountFileShareConfiguration.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(MountFileShareConfiguration.id, "FileShareId", "csharp");
@@alternateType(MountFileShareConfiguration.privateEndpointId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(SAPAvailabilityZoneDetailsRequest.appLocation,
  Azure.Core.azureLocation,
  "csharp"
);
@@clientName(SAPDatabaseType.HANA, "Hana", "csharp");
@@clientName(SAPDiskConfigurationsRequest.dbVmSku, "DBVmSku", "csharp");
@@alternateType(SAPDiskConfigurationsRequest.appLocation,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(SAPInstallWithoutOSConfigSoftwareConfiguration.bomUrl,
  url,
  "csharp"
);
@@clientName(SAPProductType.ECC, "Ecc", "csharp");
@@clientName(SAPProductType.S4HANA, "S4Hana", "csharp");
@@alternateType(SAPSizingRecommendationRequest.appLocation,
  Azure.Core.azureLocation,
  "csharp"
);
@@clientName(SAPSizingRecommendationRequest.dbMemory, "DBMemory", "csharp");
@@clientName(SAPSizingRecommendationRequest.dbScaleMethod,
  "DBScaleMethod",
  "csharp"
);
@@clientName(SAPSoftwareInstallationType.SAPInstallWithoutOSConfig,
  "SapInstallWithoutOSConfig",
  "csharp"
);
@@alternateType(SAPSupportedSkusRequest.appLocation,
  Azure.Core.azureLocation,
  "csharp"
);
@@clientName(SAPVirtualInstanceState.ACSSInstallationBlocked,
  "AcssInstallationBlocked",
  "csharp"
);
@@alternateType(ServiceInitiatedSoftwareConfiguration.bomUrl, url, "csharp");
@@clientName(SingleServerConfiguration.dbDiskConfiguration,
  "DBDiskConfiguration",
  "csharp"
);
@@alternateType(SingleServerConfiguration.subnetId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(ThreeTierRecommendationResult.dbVmSku, "DBVmSku", "csharp");
@@clientName(MessageServerProperties.ipAddress, "IPAddress", "csharp");
@@alternateType(MessageServerProperties.ipAddress,
  Azure.Core.ipV4Address,
  "csharp"
);
@@clientName(EnqueueServerProperties.ipAddress, "IPAddress", "csharp");
@@alternateType(EnqueueServerProperties.ipAddress,
  Azure.Core.ipV4Address,
  "csharp"
);
@@clientName(EnqueueReplicationServerProperties.ipAddress,
  "IPAddress",
  "csharp"
);
@@alternateType(EnqueueReplicationServerProperties.ipAddress,
  Azure.Core.ipV4Address,
  "csharp"
);
@@clientName(SAPDatabaseProperties.ipAddress, "IPAddress", "csharp");
@@alternateType(SAPDatabaseProperties.ipAddress,
  Azure.Core.ipV4Address,
  "csharp"
);
@@clientName(SAPApplicationServerProperties.ipAddress, "IPAddress", "csharp");
@@alternateType(SAPApplicationServerProperties.ipAddress,
  Azure.Core.ipV4Address,
  "csharp"
);
@@clientName(NetworkConfiguration.isSecondaryIpEnabled,
  "isSecondaryIPEnabled",
  "csharp"
);
@@clientName(LoadBalancerResourceNames.frontendIpConfigurationNames,
  "frontendIPConfigurationNames",
  "csharp"
);
@@clientName(OsSapConfiguration, "OSSapConfiguration", "csharp");
@@clientName(VirtualMachineResourceNames.osDiskName, "OSDiskName", "csharp");
@@clientName(DeploymentWithOSConfiguration.osSapConfiguration,
  "OSSapConfiguration",
  "csharp"
);
@@clientName(OSProfile.osConfiguration, "OSConfiguration", "csharp");
@@clientName(VirtualMachineConfiguration.osProfile, "OSProfile", "csharp");
@@clientName(SAPVirtualInstances.getSizingRecommendations,
  "getSizingRecommendationsSapVirtualInstance",
  "csharp"
);
@@clientName(SAPVirtualInstances.getSapSupportedSku,
  "getSapSupportedSkuSapVirtualInstance",
  "csharp"
);
@@clientName(SAPVirtualInstances.getDiskConfigurations,
  "getDiskConfigurationsSapVirtualInstance",
  "csharp"
);
@@clientName(SAPVirtualInstances.getAvailabilityZoneDetails,
  "getAvailabilityZoneDetailsSapVirtualInstance",
  "csharp"
);

@@alternateType(LoadBalancerDetails.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

@@alternateType(CentralServerVmDetails.storageDetails,
  Azure.ResourceManager.Models.SubResource[],
  "csharp"
);
@@alternateType(DatabaseVmDetails.storageDetails,
  Azure.ResourceManager.Models.SubResource[],
  "csharp"
);
@@alternateType(ApplicationServerVmDetails.storageDetails,
  Azure.ResourceManager.Models.SubResource[],
  "csharp"
);

// we add this model in this namespace in order to replace some models with this model via alternateType decorator
namespace Azure.ResourceManager.Models {
  /** represents a reference to an existing resource by its id */
  model SubResource {
    /** the id */
    id?: armResourceIdentifier;
  }
}
