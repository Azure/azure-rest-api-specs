import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
using Microsoft.HybridCompute;

@@clientName(
  Microsoft.HybridCompute,
  "HybridComputeManagementClient",
  "javascript,python"
);

@@alternateType(ServiceExtension.serviceExtensionType, string, "go");

@@alternateType(Azure.ResourceManager.CommonTypes.Identity.type, string, "go");

@@alternateType(Disk.id, Azure.Core.armResourceIdentifier, "csharp");

@@alternateType(
  NetworkInterface.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

@@clientName(FirmwareProfile.type, "FirmwareProfileType", "csharp");
@@clientName(RunCommandInputParameter, "RunCommandInputContent", "csharp");
@@clientName(ExtensionType, "HybridComputeExtensionType", "csharp");
@@clientName(IdentityKeyStore, "HybridComputeIdentityKeyStore", "csharp");
@@clientName(OperationValue, "HybridComputeOperationValue", "csharp");
@@clientName(
  OperationValueDisplay,
  "HybridComputeOperationValueDisplay",
  "csharp"
);
@@clientName(ServiceExtension, "HybridComputeServiceExtension", "csharp");
@@clientName(
  ServiceExtensionPublicNetworkAccess,
  "HybridComputeServiceExtensionPublicNetworkAccess",
  "csharp"
);

/**
 * The network access policy to determine if Azure Arc agents can use public Azure Arc service endpoints. Defaults to disabled (access to Azure Arc services only via private link).
 */
union CustomPublicNetworkAccessType {
  string,

  /**
   * Allows Azure Arc agents to communicate with Azure Arc services over both public (internet) and private endpoints.
   */
  Enabled: "Enabled",

  /**
   * Does not allow Azure Arc agents to communicate with Azure Arc services over public (internet) endpoints. The agents must use the private link.
   */
  Disabled: "Disabled",

  /**
   * Azure Arc agent communication with Azure Arc services over public (internet) is enforced by Network Security Perimeter (NSP).
   */
  SecuredByPerimeter: "SecuredByPerimeter",
}
@@alternateType(
  PublicNetworkAccessType,
  CustomPublicNetworkAccessType,
  "javascript,python,go,csharp"
);
@@clientName(
  CustomPublicNetworkAccessType,
  "PublicNetworkAccessType",
  "javascript,python,go"
);
@@clientName(
  CustomPublicNetworkAccessType,
  "HybridComputePublicNetworkAccessType",
  "csharp"
);

@@clientName(
  VMGuestPatchClassification_Windows,
  "VMGuestPatchClassificationWindows",
  "python"
);
@@clientName(
  VMGuestPatchClassification_Linux,
  "VMGuestPatchClassificationLinux",
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "To mitigate breaking change for legacy Python SDK"
@@Legacy.clientDefaultValue(
  LicenseProfileNameAlias.licenseProfileName,
  "default",
  "python,csharp"
);
@@Azure.ClientGenerator.Core.alternateType(
  LicenseProfileNameAlias.licenseProfileName,
  "default"
);
@@clientLocation(Machines.setupExtensions, Microsoft.HybridCompute, "!go");
@@clientLocation(Machines.upgradeExtensions, Microsoft.HybridCompute, "!go");

@@clientLocation(Machines.setupExtensions, "ManagementClient", "go");
@@clientLocation(Machines.upgradeExtensions, "ManagementClient", "go");

@@clientName(
  Machines.getValidationDetailsForMachine,
  "GetValidationDetailsForMachinePrivateLinkScope",
  "csharp"
);

// C# backward-compat renames to match GA SDK (AutoRest prepend-rp-prefix + rename-mapping)
@@clientName(CloudMetadata, "HybridComputeCloudMetadata", "csharp");
@@clientName(
  ConfigurationExtension,
  "HybridComputeConfigurationExtension",
  "csharp"
);
@@clientName(ConnectionDetail, "HybridComputeConnectionDetail", "csharp");
@@clientName(ExtensionValue, "HybridComputeExtensionValue", "csharp");
@@clientName(ExtensionValueV2, "HybridComputeExtensionValueV2", "csharp");
@@clientName(ExtensionPublisher, "HybridComputeExtensionPublisher", "csharp");
@@clientName(IpAddress, "HybridComputeIPAddress", "csharp");
@@clientName(License, "HybridComputeLicense", "csharp");
@@clientName(LicenseDetails, "HybridComputeLicenseDetails", "csharp");
@@clientName(LicenseEdition, "HybridComputeLicenseEdition", "csharp");
@@clientName(LicenseState, "HybridComputeLicenseState", "csharp");
@@clientName(LicenseStatus, "HybridComputeLicenseStatus", "csharp");
@@clientName(LicenseTarget, "HybridComputeLicenseTarget", "csharp");
@@clientName(LicenseType, "HybridComputeLicenseType", "csharp");
@@clientName(LinuxParameters, "HybridComputeLinuxParameters", "csharp");
@@clientName(
  Azure.ResourceManager.CommonTypes.LocationData,
  "HybridComputeLocation",
  "csharp"
);
@@clientName(Machine, "HybridComputeMachine", "csharp");
@@clientName(MachineExtension, "HybridComputeMachineExtension", "csharp");
@@clientName(MachineRunCommand, "HybridComputeMachineRunCommand", "csharp");
@@clientName(NetworkInterface, "HybridComputeNetworkInterface", "csharp");
@@clientName(NetworkProfile, "HybridComputeNetworkProfile", "csharp");
@@clientName(OSProfile, "HybridComputeOSProfile", "csharp");
@@clientName(OsType, "HybridComputeOSType", "csharp");
@@clientName(
  PrivateEndpointConnectionProperties,
  "HybridComputePrivateEndpointConnectionProperties",
  "csharp"
);
@@clientName(ProductFeature, "HybridComputeProductFeature", "csharp");
@@clientName(ProvisioningState, "HybridComputeProvisioningState", "csharp");
@@clientName(
  PublicNetworkAccessType,
  "HybridComputePublicNetworkAccessType",
  "csharp"
);
@@clientName(ResourceUpdate, "HybridComputeResourceUpdate", "csharp");
@@clientName(Subnet, "HybridComputeSubnet", "csharp");
@@clientName(ServiceStatus, "HybridComputeServiceStatus", "csharp");
@@clientName(ServiceStatuses, "HybridComputeServiceStatuses", "csharp");
@@clientName(WindowsParameters, "HybridComputeWindowsParameters", "csharp");
@@clientName(AccessMode, "HybridComputeAccessMode", "csharp");
@@clientName(ResourceAssociation, "HybridComputeResourceAssociation", "csharp");
@@clientName(AccessRule, "HybridComputeAccessRule", "csharp");
@@clientName(AccessRuleDirection, "HybridComputeAccessRuleDirection", "csharp");
@@clientName(ProgramYear, "HybridComputeProgramYear", "csharp");
@@clientName(ProvisioningIssue, "HybridComputeProvisioningIssue", "csharp");
@@clientName(
  ProvisioningIssueSeverity,
  "HybridComputeProvisioningIssueSeverity",
  "csharp"
);
@@clientName(
  ProvisioningIssueType,
  "HybridComputeProvisioningIssueType",
  "csharp"
);
@@clientName(LicenseProfile, "HybridComputeLicenseProfile", "csharp");
@@clientName(
  LicenseProfileUpdate,
  "HybridComputeLicenseProfilePatch",
  "csharp"
);
@@clientName(
  ProductFeatureUpdate,
  "HybridComputeProductFeatureUpdate",
  "csharp"
);
@@clientName(Disk, "HybridComputeDisk", "csharp");
@@clientName(HardwareProfile, "HybridComputeHardwareProfile", "csharp");
@@clientName(Processor, "HybridComputeProcessor", "csharp");
@@clientName(ExecutionState, "HybridComputeExecutionState", "csharp");
@@clientName(FirmwareProfile, "HybridComputeFirmwareProfile", "csharp");
@@clientName(AssessmentModeTypes, "AssessmentModeType", "csharp");
@@clientName(PatchModeTypes, "PatchModeType", "csharp");
@@clientName(
  VMGuestPatchClassification_Windows,
  "VmGuestPatchClassificationWindow",
  "csharp"
);
@@clientName(
  VMGuestPatchClassification_Linux,
  "VmGuestPatchClassificationLinux",
  "csharp"
);

// C# rename-mapping equivalents
@@clientName(
  OSProfileLinuxConfiguration,
  "HybridComputeLinuxConfiguration",
  "csharp"
);
@@clientName(
  OSProfileWindowsConfiguration,
  "HybridComputeWindowsConfiguration",
  "csharp"
);
@@clientName(PatchOperationStatus, "MachineOperationStatus", "csharp");
@@clientName(StatusLevelTypes, "HybridComputeStatusLevelType", "csharp");
@@clientName(StatusTypes, "HybridComputeStatusType", "csharp");
@@clientName(PatchSettingsStatus, "HybridComputePatchSettingsStatus", "csharp");
@@clientName(Gateway, "ArcGateway", "csharp");
@@clientName(GatewayType, "ArcGatewayType", "csharp");
@@clientName(GatewayUpdate, "ArcGatewayPatch", "csharp");
@@clientName(Settings, "ArcSettings", "csharp");
@@clientName(VMGuestPatchRebootStatus, "VmGuestPatchRebootStatus", "csharp");
@@clientName(VMGuestPatchRebootSetting, "VmGuestPatchRebootSetting", "csharp");

// Enum member renames for C# backward-compat
@@clientName(LicenseType.ESU, "Esu", "csharp");
@@clientName(LicenseEdition.Datacenter, "DataCenter", "csharp");
@@clientName(LicenseDetails.type, "LicenseCoreType", "csharp");

// Property renames for C# backward-compat
@@clientName(MachineProperties.osProfile, "OSProfile", "csharp");
@@clientName(MachineUpdateProperties.osProfile, "OSProfile", "csharp");
@@clientName(Machines.networkProfileGet, "GetNetworkProfile", "csharp");
@@clientName(
  PrivateEndpointConnection,
  "HybridComputePrivateEndpointConnection",
  "csharp"
);
@@clientName(PrivateLinkResource, "HybridComputePrivateLinkResource", "csharp");

// ArcKindEnum backward-compat value casing (old SDK used PascalCase for acronyms)
@@clientName(ArcKindEnum.AVS, "Avs", "csharp");
@@clientName(ArcKindEnum.HCI, "Hci", "csharp");
@@clientName(ArcKindEnum.SCVMM, "ScVmm", "csharp");
@@clientName(ArcKindEnum.EPS, "Eps", "csharp");
@@clientName(ArcKindEnum.GCP, "Gcp", "csharp");
@@clientName(ArcKindEnum.AWS, "Aws", "csharp");

// Type rename: MachineInstallPatchesParameters -> MachineInstallPatchesContent
@@clientName(
  MachineInstallPatchesParameters,
  "MachineInstallPatchesContent",
  "csharp"
);

@@alternateType(InstanceViewTypes, string, "csharp");

// MachineProperties OS property renames (old AutoRest SDK used all-caps prefix)
@@clientName(MachineProperties.adFqdn, "ADFqdn", "csharp");
@@clientName(MachineProperties.mssqlDiscovered, "MSSqlDiscovered", "csharp");
@@clientName(MachineProperties.osEdition, "OSEdition", "csharp");
@@clientName(MachineProperties.osName, "OSName", "csharp");
@@clientName(MachineProperties.osSku, "OSSku", "csharp");
@@clientName(MachineProperties.osType, "OSType", "csharp");
@@clientName(MachineProperties.osVersion, "OSVersion", "csharp");

// AgentUpgrade property renames
@@clientName(
  AgentUpgrade.enableAutomaticUpgrade,
  "IsAutomaticUpgradeEnabled",
  "csharp"
);
@@clientName(AgentUpgrade.lastAttemptTimestamp, "LastAttemptedOn", "csharp");

// PatchSettings.enableHotpatching -> IsHotpatchingEnabled (shared by Windows and Linux)
@@clientName(PatchSettings.enableHotpatching, "IsHotpatchingEnabled", "csharp");

// ConfigurationExtension.type -> ConfigurationExtensionType
@@clientName(
  ConfigurationExtension.type,
  "ConfigurationExtensionType",
  "csharp"
);

// ConnectionDetail.privateIpAddress -> PrivateIPAddress
@@clientName(ConnectionDetail.privateIpAddress, "PrivateIPAddress", "csharp");

// IpAddress.ipAddressVersion -> IPAddressVersion
@@clientName(IpAddress.ipAddressVersion, "IPAddressVersion", "csharp");

// NetworkInterface.ipAddresses -> IPAddresses
@@clientName(NetworkInterface.ipAddresses, "IPAddresses", "csharp");

// LicenseStatus enum member renames
@@clientName(LicenseStatus.OOBGrace, "OobGrace", "csharp");
@@clientName(LicenseStatus.OOTGrace, "OotGrace", "csharp");

// EsuServerType.Datacenter -> DataCenter
@@clientName(EsuServerType.Datacenter, "DataCenter", "csharp");

// LicenseProfileProductType enum member rename
@@clientName(
  LicenseProfileProductType.WindowsIoTEnterprise,
  "WindowsIotEnterprise",
  "csharp"
);

// PatchServiceUsed enum member renames
@@clientName(PatchServiceUsed.APT, "Apt", "csharp");
@@clientName(PatchServiceUsed.WU_WSUS, "WUWsus", "csharp");
@@clientName(PatchServiceUsed.YUM, "Yum", "csharp");

// PrivateEndpointConnectionProperties.privateLinkServiceConnectionState -> ConnectionState
@@clientName(
  PrivateEndpointConnectionProperties.privateLinkServiceConnectionState,
  "ConnectionState",
  "csharp"
);

// MachineAssessPatchesResult property renames
@@clientName(
  MachineAssessPatchesResult.rebootPending,
  "IsRebootPending",
  "csharp"
);
@@clientName(MachineAssessPatchesResult.osType, "OSType", "csharp");
@@clientName(MachineInstallPatchesResult.osType, "OSType", "csharp");

// MachineExtension type property renames (old AutoRest SDK used model-qualified names)
@@clientName(
  MachineExtensionProperties.type,
  "MachineExtensionPropertiesType",
  "csharp"
);
@@clientName(
  MachineExtensionInstanceView.type,
  "MachineExtensionInstanceViewType",
  "csharp"
);
@@clientName(
  MachineExtensionUpdateProperties.type,
  "MachineExtensionUpdatePropertiesType",
  "csharp"
);

// LicenseProfileMachineInstanceView.softwareAssuranceCustomer -> IsSoftwareAssuranceCustomer
@@clientName(
  LicenseProfileMachineInstanceViewSoftwareAssurance.softwareAssuranceCustomer,
  "IsSoftwareAssuranceCustomer",
  "csharp"
);

// uuid alternate types: old AutoRest SDK generated Guid? for uuid-formatted fields
@@alternateType(LicenseProperties.tenantId, Azure.Core.uuid, "csharp");
@@alternateType(MachineProperties.vmId, Azure.Core.uuid, "csharp");
@@alternateType(MachineProperties.vmUuid, Azure.Core.uuid, "csharp");

// armResourceIdentifier alternate type: old AutoRest SDK generated ResourceIdentifier for gatewayId
@@alternateType(
  GatewayProperties.gatewayId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// C# API review naming/type fixes for new TypeSpec-generated surface
@@alternateType(
  MachineProperties.hardwareResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(SetupExtensionRequest, "SetupExtensionContent", "csharp");

// MachineRunCommandData backward compatibility with the existing SDK API.
@@alternateType(MachineRunCommandProperties.outputBlobUri, url, "csharp");
@@alternateType(MachineRunCommandProperties.errorBlobUri, url, "csharp");
@@clientName(
  MachineRunCommandProperties.asyncExecution,
  "IsAsyncExecution",
  "csharp"
);

// C# backward compatibility with the checked-in .NET API listings.
@@clientName(ExtensionsStatusLevelTypes, "ExtensionsStatusLevelType", "csharp");
@@alternateType(MachineRunCommandScriptSource.scriptUri, url, "csharp");
@@alternateType(RunCommandManagedIdentity.clientId, Azure.Core.uuid, "csharp");
@@alternateType(RunCommandManagedIdentity.objectId, Azure.Core.uuid, "csharp");

// C# backward-compat fixes for ApiCompat issues found during MPG migration.
@@alternateType(
  PrivateEndpointProperty.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  PrivateEndpointConnectionDataModel.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the previous .NET resource-data shape for backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  PrivateEndpointConnectionDataModel,
  Azure.ResourceManager.Foundations.ProxyResource,
  "csharp"
);

@@usage(PrivateLinkResource, Usage.input | Usage.output, "csharp");
@@usage(PrivateLinkResourceProperties, Usage.input | Usage.output, "csharp");
@@usage(
  LicenseProfileMachineInstanceView,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(
  LicenseProfileMachineInstanceViewSoftwareAssurance,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(
  LicenseProfileArmProductProfileProperties,
  Usage.input | Usage.output,
  "csharp"
);
