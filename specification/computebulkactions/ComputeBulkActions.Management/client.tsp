import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core;

namespace Microsoft.ComputeBulkActions;

@@clientName(ExecuteTypeRequest.correlationid, "correlationId", "java");
@@clientName(ExecuteCreateRequest.correlationid, "correlationId", "java");
@@clientName(GetOperationStatusRequest.correlationid, "correlationId", "java");
@@clientName(CancelOperationsRequest.correlationid, "correlationId", "java");
@@clientName(
  Microsoft.ComputeBulkActions,
  "ComputeBulkActionsMgmtClient",
  "python"
);

// =====================================================================
// Critical: Correlationid casing fix (lowercase 'd' → capital 'I' in Id)
// =====================================================================
@@clientName(ExecuteTypeRequest.correlationid, "CorrelationId", "csharp");
@@clientName(ExecuteCreateRequest.correlationid, "CorrelationId", "csharp");
@@clientName(
  GetOperationStatusRequest.correlationid,
  "CorrelationId",
  "csharp"
);
@@clientName(CancelOperationsRequest.correlationid, "CorrelationId", "csharp");

// =====================================================================
// Critical: Request suffix → Content suffix
// =====================================================================
@@clientName(CancelOperationsRequest, "CancelOperationsContent", "csharp");
@@clientName(ExecuteTypeRequest, "ExecuteTypeContent", "csharp");
@@clientName(ExecuteCreateRequest, "ExecuteCreateContent", "csharp");
@@clientName(ExecuteDeallocateRequest, "ExecuteDeallocateContent", "csharp");
@@clientName(ExecuteDeleteRequest, "ExecuteDeleteContent", "csharp");
@@clientName(ExecuteHibernateRequest, "ExecuteHibernateContent", "csharp");
@@clientName(ExecuteStartRequest, "ExecuteStartContent", "csharp");
@@clientName(GetOperationStatusRequest, "GetOperationStatusContent", "csharp");

// =====================================================================
// Critical: Response suffix → Result suffix
// =====================================================================
@@clientName(CancelOperationsResponse, "CancelOperationsResult", "csharp");
@@clientName(
  CreateResourceOperationResponse,
  "CreateResourceOperationResult",
  "csharp"
);
@@clientName(
  DeallocateResourceOperationResponse,
  "DeallocateResourceOperationResult",
  "csharp"
);
@@clientName(
  DeleteResourceOperationResponse,
  "DeleteResourceOperationResult",
  "csharp"
);
@@clientName(GetOperationStatusResponse, "GetOperationStatusResult", "csharp");
@@clientName(
  HibernateResourceOperationResponse,
  "HibernateResourceOperationResult",
  "csharp"
);
@@clientName(
  StartResourceOperationResponse,
  "StartResourceOperationResult",
  "csharp"
);

// =====================================================================
// Critical: Parameters suffix
// =====================================================================
@@clientName(ExecutionParameters, "BulkActionExecutionConfig", "csharp");
@@clientName(ManagedDiskParameters, "ManagedDiskInfo", "csharp");
@@clientName(
  DiskEncryptionSetParameters,
  "DiskEncryptionSetReference",
  "csharp"
);

// =====================================================================
// Warning: Plural enum names → singular
// =====================================================================
@@clientName(CachingTypes, "ComputeBulkActionsCachingType", "csharp");
@@clientName(DiskControllerTypes, "DiskControllerType", "csharp");
@@clientName(DiskCreateOptionTypes, "DiskCreateOptionType", "csharp");
@@clientName(DiskDeleteOptionTypes, "DiskDeleteOptionType", "csharp");
@@clientName(DiskDetachOptionTypes, "DiskDetachOptionType", "csharp");
@@clientName(DomainNameLabelScopeTypes, "DomainNameLabelScopeType", "csharp");
@@clientName(IPVersions, "ComputeBulkActionsIPVersion", "csharp");
@@clientName(
  OperatingSystemTypes,
  "ComputeBulkActionsOperatingSystemType",
  "csharp"
);
@@clientName(ProtocolTypes, "ComputeBulkActionsProtocolType", "csharp");
@@clientName(SecurityEncryptionTypes, "SecurityEncryptionType", "csharp");
@@clientName(SecurityTypes, "ComputeBulkActionsSecurityType", "csharp");
@@clientName(
  SettingNames,
  "AdditionalUnattendContentSettingName",
  "csharp"
);
@@clientName(
  StorageAccountTypes,
  "ComputeBulkActionsStorageAccountType",
  "csharp"
);
@@clientName(DeleteOptions, "ComputeBulkActionsDeleteOption", "csharp");
@@clientName(DiffDiskOptions, "DiffDiskOption", "csharp");

// =====================================================================
// Warning: Acronym casing
// =====================================================================
@@clientName(AcceleratorType.GPU, "Gpu", "csharp");
@@clientName(AcceleratorType.FPGA, "Fpga", "csharp");
@@clientName(LocalStorageDiskType.HDD, "Hdd", "csharp");
@@clientName(LocalStorageDiskType.SSD, "Ssd", "csharp");

// =====================================================================
// Warning: ARM resource identifier types
// =====================================================================
@@alternateType(ApiEntityReference.id, armResourceIdentifier, "csharp");
@@alternateType(SubResource.id, armResourceIdentifier, "csharp");
@@alternateType(
  VMGalleryApplication.packageReferenceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  EncryptionIdentity.userAssignedIdentityResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  HostEndpointSettings.inVMAccessControlProfileReferenceId,
  armResourceIdentifier,
  "csharp"
);

// =====================================================================
// Warning: Ambiguous type names
// =====================================================================
@@clientName(Mode, "ProxyAgentMode", "csharp");
@@clientName(Modes, "HostEndpointMode", "csharp");
@@clientName(ApiError, "ComputeBulkActionsApiError", "csharp");
@@clientName(ApiErrorBase, "ComputeBulkActionsApiErrorBase", "csharp");
@@clientName(InnerError, "ComputeBulkActionsInnerError", "csharp");
@@clientName(SubResource, "ComputeBulkActionsSubResource", "csharp");
@@clientName(RetryPolicy, "BulkActionRetryPolicy", "csharp");
@@clientName(ResourceOperation, "BulkActionResourceOperationInfo", "csharp");
@@clientName(VirtualMachine, "BulkActionVirtualMachineResult", "csharp");
@@clientName(
  AdditionalCapabilities,
  "ComputeBulkActionsAdditionalCapabilities",
  "csharp"
);
@@clientName(BootDiagnostics, "ComputeBulkActionsBootDiagnostics", "csharp");
@@clientName(DataDisk, "ComputeBulkActionsDataDisk", "csharp");
@@clientName(ImageReference, "ComputeBulkActionsImageReference", "csharp");
@@clientName(NetworkProfile, "ComputeBulkActionsNetworkProfile", "csharp");
@@clientName(OSDisk, "ComputeBulkActionsOSDisk", "csharp");
@@clientName(OSProfile, "ComputeBulkActionsOSProfile", "csharp");
@@clientName(PatchSettings, "ComputeBulkActionsPatchSettings", "csharp");
@@clientName(SecurityProfile, "ComputeBulkActionsSecurityProfile", "csharp");
@@clientName(StorageProfile, "ComputeBulkActionsStorageProfile", "csharp");
@@clientName(ProvisioningState, "BulkActionProvisioningState", "csharp");
@@clientName(OperationState, "BulkActionOperationState", "csharp");
@@clientName(
  AllocationStrategy,
  "ComputeBulkActionsAllocationStrategy",
  "csharp"
);
@@clientName(CapacityType, "ComputeBulkActionsCapacityType", "csharp");
@@clientName(DeadlineType, "ComputeBulkActionsDeadlineType", "csharp");
@@clientName(EvictionPolicy, "ComputeBulkActionsEvictionPolicy", "csharp");
@@clientName(
  OptimizationPreference,
  "ComputeBulkActionsOptimizationPreference",
  "csharp"
);
@@clientName(
  VirtualMachineType,
  "ComputeBulkActionsVirtualMachineType",
  "csharp"
);
@@clientName(
  VirtualMachineProfile,
  "ComputeBulkActionsVirtualMachineProfile",
  "csharp"
);
@@clientName(
  VirtualMachineExtension,
  "ComputeBulkActionsVirtualMachineExtension",
  "csharp"
);
@@clientName(
  VirtualMachineExtensionProperties,
  "ComputeBulkActionsVirtualMachineExtensionProperties",
  "csharp"
);
@@clientName(
  LinuxConfiguration,
  "ComputeBulkActionsLinuxConfiguration",
  "csharp"
);
@@clientName(
  WindowsConfiguration,
  "ComputeBulkActionsWindowsConfiguration",
  "csharp"
);
@@clientName(SshPublicKey, "ComputeBulkActionsSshPublicKey", "csharp");
@@clientName(
  NetworkApiVersion,
  "ComputeBulkActionsNetworkApiVersion",
  "csharp"
);
@@clientName(
  NetworkInterfaceReference,
  "ComputeBulkActionsNetworkInterfaceReference",
  "csharp"
);
@@clientName(PriorityProfile, "ComputeBulkActionsPriorityProfile", "csharp");
@@clientName(ZonePreference, "ComputeBulkActionsZonePreference", "csharp");

// =====================================================================
// Warning: DateTimeOffset property naming (*On suffix)
// =====================================================================
@@clientName(ResourceOperationDetails.deadline, "DeadlineOn", "csharp");

// =====================================================================
// Warning: Boolean property naming (verb prefix)
// =====================================================================
// AdditionalCapabilities
@@clientName(
  AdditionalCapabilities.ultraSSDEnabled,
  "IsUltraSsdEnabled",
  "csharp"
);
@@clientName(
  AdditionalCapabilities.hibernationEnabled,
  "IsHibernationEnabled",
  "csharp"
);

// BootDiagnostics
@@clientName(BootDiagnostics.enabled, "IsEnabled", "csharp");

// DataDisk
@@clientName(DataDisk.toBeDetached, "IsToBeDetached", "csharp");
@@clientName(
  DataDisk.writeAcceleratorEnabled,
  "IsWriteAcceleratorEnabled",
  "csharp"
);

// DiskEncryptionSettings
@@clientName(DiskEncryptionSettings.enabled, "IsEnabled", "csharp");

// EventGridAndResourceGraph
@@clientName(EventGridAndResourceGraph.enable, "IsEnabled", "csharp");

// ExecuteDeleteRequest (now ExecuteDeleteContent)
@@clientName(ExecuteDeleteRequest.forceDeletion, "IsForceDeletion", "csharp");

// LinuxConfiguration
@@clientName(
  LinuxConfiguration.disablePasswordAuthentication,
  "IsPasswordAuthenticationDisabled",
  "csharp"
);
@@clientName(
  LinuxConfiguration.provisionVMAgent,
  "IsVMAgentProvisioned",
  "csharp"
);
@@clientName(
  LinuxConfiguration.enableVMAgentPlatformUpdates,
  "IsVMAgentPlatformUpdatesEnabled",
  "csharp"
);

// LinuxVMGuestPatchAutomaticByPlatformSettings
@@clientName(
  LinuxVMGuestPatchAutomaticByPlatformSettings.bypassPlatformSafetyChecksOnUserSchedule,
  "IsBypassPlatformSafetyChecksOnUserSchedule",
  "csharp"
);

// NetworkInterfaceReferenceProperties
@@clientName(
  NetworkInterfaceReferenceProperties.primary,
  "IsPrimary",
  "csharp"
);

// OSImageNotificationProfile
@@clientName(OSImageNotificationProfile.enable, "IsEnabled", "csharp");

// OSDisk
@@clientName(
  OSDisk.writeAcceleratorEnabled,
  "IsWriteAcceleratorEnabled",
  "csharp"
);

// OSProfile
@@clientName(
  OSProfile.allowExtensionOperations,
  "IsExtensionOperationsAllowed",
  "csharp"
);
@@clientName(
  OSProfile.requireGuestProvisionSignal,
  "IsGuestProvisionSignalRequired",
  "csharp"
);

// PatchSettings
@@clientName(PatchSettings.enableHotpatching, "IsHotpatchingEnabled", "csharp");

// ProxyAgentSettings
@@clientName(ProxyAgentSettings.enabled, "IsEnabled", "csharp");
@@clientName(
  ProxyAgentSettings.addProxyAgentExtension,
  "ShouldAddProxyAgentExtension",
  "csharp"
);

// SecurityProfile
@@clientName(
  SecurityProfile.encryptionAtHost,
  "IsEncryptionAtHostEnabled",
  "csharp"
);

// TerminateNotificationProfile
@@clientName(TerminateNotificationProfile.enable, "IsEnabled", "csharp");

// UefiSettings
@@clientName(UefiSettings.secureBootEnabled, "IsSecureBootEnabled", "csharp");
@@clientName(UefiSettings.vTpmEnabled, "IsVTpmEnabled", "csharp");

// VMGalleryApplication
@@clientName(
  VMGalleryApplication.enableAutomaticUpgrade,
  "IsAutomaticUpgradeEnabled",
  "csharp"
);
@@clientName(
  VMGalleryApplication.treatFailureAsDeploymentFailure,
  "ShouldTreatFailureAsDeploymentFailure",
  "csharp"
);

// VirtualMachineExtensionProperties
@@clientName(
  VirtualMachineExtensionProperties.autoUpgradeMinorVersion,
  "IsAutoUpgradeMinorVersionEnabled",
  "csharp"
);
@@clientName(
  VirtualMachineExtensionProperties.enableAutomaticUpgrade,
  "IsAutomaticUpgradeEnabled",
  "csharp"
);
@@clientName(
  VirtualMachineExtensionProperties.suppressFailures,
  "IsSuppressFailures",
  "csharp"
);

// VirtualMachineNetworkInterfaceConfigurationProperties
@@clientName(
  VirtualMachineNetworkInterfaceConfigurationProperties.primary,
  "IsPrimary",
  "csharp"
);
@@clientName(
  VirtualMachineNetworkInterfaceConfigurationProperties.enableAcceleratedNetworking,
  "IsAcceleratedNetworkingEnabled",
  "csharp"
);
@@clientName(
  VirtualMachineNetworkInterfaceConfigurationProperties.disableTcpStateTracking,
  "IsTcpStateTrackingDisabled",
  "csharp"
);
@@clientName(
  VirtualMachineNetworkInterfaceConfigurationProperties.enableFpga,
  "IsFpgaEnabled",
  "csharp"
);
@@clientName(
  VirtualMachineNetworkInterfaceConfigurationProperties.enableIPForwarding,
  "IsIPForwardingEnabled",
  "csharp"
);

// VirtualMachineNetworkInterfaceIPConfigurationProperties
@@clientName(
  VirtualMachineNetworkInterfaceIPConfigurationProperties.primary,
  "IsPrimary",
  "csharp"
);

// WindowsConfiguration
@@clientName(
  WindowsConfiguration.provisionVMAgent,
  "IsVMAgentProvisioned",
  "csharp"
);

// WindowsVMGuestPatchAutomaticByPlatformSettings
@@clientName(
  WindowsVMGuestPatchAutomaticByPlatformSettings.bypassPlatformSafetyChecksOnUserSchedule,
  "IsBypassPlatformSafetyChecksOnUserSchedule",
  "csharp"
);
