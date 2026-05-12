import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.HybridCompute;

@@clientName(Microsoft.HybridCompute,
  "HybridComputeManagementClient",
  "javascript,python"
);

@@alternateType(ServiceExtension.serviceExtensionType, string, "go");

@@alternateType(Azure.ResourceManager.CommonTypes.Identity.type, string, "go");

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
@@alternateType(PublicNetworkAccessType,
  CustomPublicNetworkAccessType,
  "javascript,python,go"
);
@@clientName(CustomPublicNetworkAccessType,
  "PublicNetworkAccessType",
  "javascript,python,go"
);

@@clientName(VMGuestPatchClassification_Windows,
  "VMGuestPatchClassificationWindows",
  "python"
);
@@clientName(VMGuestPatchClassification_Linux,
  "VMGuestPatchClassificationLinux",
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "To mitigate breaking change for legacy Python SDK"
@@Legacy.clientDefaultValue(LicenseProfileNameAlias.licenseProfileName,
  "default",
  "python,csharp"
);
@@Azure.ClientGenerator.Core.alternateType(LicenseProfileNameAlias.licenseProfileName,
  "default"
);
@@clientLocation(Machines.setupExtensions, Microsoft.HybridCompute, "!go");
@@clientLocation(Machines.upgradeExtensions, Microsoft.HybridCompute, "!go");

@@clientLocation(Machines.setupExtensions, "ManagementClient", "go");
@@clientLocation(Machines.upgradeExtensions, "ManagementClient", "go");

// C# backward-compat renames to match GA SDK (AutoRest prepend-rp-prefix + rename-mapping)
@@clientName(CloudMetadata, "HybridComputeCloudMetadata", "csharp");
@@clientName(ConfigurationExtension, "HybridComputeConfigurationExtension", "csharp");
@@clientName(ConnectionDetail, "HybridComputeConnectionDetail", "csharp");
@@clientName(ExtensionValue, "HybridComputeExtensionValue", "csharp");
@@clientName(IpAddress, "HybridComputeIPAddress", "csharp");
@@clientName(License, "HybridComputeLicense", "csharp");
@@clientName(LicenseDetails, "HybridComputeLicenseDetails", "csharp");
@@clientName(LicenseEdition, "HybridComputeLicenseEdition", "csharp");
@@clientName(LicenseState, "HybridComputeLicenseState", "csharp");
@@clientName(LicenseStatus, "HybridComputeLicenseStatus", "csharp");
@@clientName(LicenseTarget, "HybridComputeLicenseTarget", "csharp");
@@clientName(LicenseType, "HybridComputeLicenseType", "csharp");
@@clientName(LinuxParameters, "HybridComputeLinuxParameters", "csharp");
@@clientName(Machine, "HybridComputeMachine", "csharp");
@@clientName(MachineExtension, "HybridComputeMachineExtension", "csharp");
@@clientName(NetworkInterface, "HybridComputeNetworkInterface", "csharp");
@@clientName(NetworkProfile, "HybridComputeNetworkProfile", "csharp");
@@clientName(OSProfile, "HybridComputeOSProfile", "csharp");
@@clientName(OsType, "HybridComputeOSType", "csharp");
@@clientName(PrivateEndpointConnectionProperties, "HybridComputePrivateEndpointConnectionProperties", "csharp");
@@clientName(ProductFeature, "HybridComputeProductFeature", "csharp");
@@clientName(ProvisioningState, "HybridComputeProvisioningState", "csharp");
@@clientName(PublicNetworkAccessType, "HybridComputePublicNetworkAccessType", "csharp");
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
@@clientName(ProvisioningIssueSeverity, "HybridComputeProvisioningIssueSeverity", "csharp");
@@clientName(ProvisioningIssueType, "HybridComputeProvisioningIssueType", "csharp");
@@clientName(LicenseProfile, "HybridComputeLicenseProfile", "csharp");
@@clientName(LicenseProfileUpdate, "HybridComputeLicenseProfileUpdate", "csharp");
@@clientName(ProductFeatureUpdate, "HybridComputeProductFeatureUpdate", "csharp");
@@clientName(Disk, "HybridComputeDisk", "csharp");
@@clientName(HardwareProfile, "HybridComputeHardwareProfile", "csharp");
@@clientName(Processor, "HybridComputeProcessor", "csharp");
@@clientName(ExecutionState, "HybridComputeExecutionState", "csharp");
@@clientName(FirmwareProfile, "HybridComputeFirmwareProfile", "csharp");
@@clientName(AssessmentModeTypes, "AssessmentModeType", "csharp");
@@clientName(PatchModeTypes, "PatchModeType", "csharp");
@@clientName(VMGuestPatchClassification_Windows, "VmGuestPatchClassificationWindow", "csharp");
@@clientName(VMGuestPatchClassification_Linux, "VmGuestPatchClassificationLinux", "csharp");

// C# rename-mapping equivalents
// Note: LocationData is Azure.ResourceManager.CommonTypes.LocationData and cannot be renamed here
// It will be handled as a breaking change in ApiCompatBaseline.txt
@@clientName(OSProfileLinuxConfiguration, "HybridComputeLinuxConfiguration", "csharp");
@@clientName(OSProfileWindowsConfiguration, "HybridComputeWindowsConfiguration", "csharp");
@@clientName(PatchOperationStatus, "MachineOperationStatus", "csharp");
@@clientName(StatusLevelTypes, "HybridComputeStatusLevelType", "csharp");
@@clientName(StatusTypes, "HybridComputeStatusType", "csharp");
@@clientName(PatchSettingsStatus, "HybridComputePatchSettingsStatus", "csharp");
@@clientName(Gateway, "ArcGateway", "csharp");
@@clientName(GatewayType, "ArcGatewayType", "csharp");
@@clientName(GatewayUpdate, "ArcGatewayUpdate", "csharp");
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
@@clientName(PrivateEndpointConnection, "HybridComputePrivateEndpointConnection", "csharp");
@@clientName(PrivateLinkResource, "HybridComputePrivateLinkResource", "csharp");
