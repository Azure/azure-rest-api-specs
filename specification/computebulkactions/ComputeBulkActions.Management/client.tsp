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
@@clientName(
  CancelOperationsRequest,
  "BulkActionCancelOperationsContent",
  "csharp"
);
@@clientName(ExecuteTypeRequest, "ExecuteTypeContent", "csharp");
@@clientName(ExecuteCreateRequest, "BulkActionExecuteCreateContent", "csharp");
@@clientName(
  ExecuteDeallocateRequest,
  "BulkActionExecuteDeallocateContent",
  "csharp"
);
@@clientName(ExecuteDeleteRequest, "BulkActionExecuteDeleteContent", "csharp");
@@clientName(
  ExecuteHibernateRequest,
  "BulkActionExecuteHibernateContent",
  "csharp"
);
@@clientName(ExecuteStartRequest, "BulkActionExecuteStartContent", "csharp");
@@clientName(
  GetOperationStatusRequest,
  "BulkActionGetOperationStatusContent",
  "csharp"
);

// =====================================================================
// Critical: Response suffix → Result suffix
// =====================================================================
@@clientName(
  CancelOperationsResponse,
  "BulkActionCancelOperationsResult",
  "csharp"
);
@@clientName(
  CreateResourceOperationResponse,
  "BulkActionCreateResourceOperationResult",
  "csharp"
);
@@clientName(
  DeallocateResourceOperationResponse,
  "BulkActionDeallocateResourceOperationResult",
  "csharp"
);
@@clientName(
  DeleteResourceOperationResponse,
  "BulkActionDeleteResourceOperationResult",
  "csharp"
);
@@clientName(
  GetOperationStatusResponse,
  "BulkActionGetOperationStatusResult",
  "csharp"
);
@@clientName(
  HibernateResourceOperationResponse,
  "BulkActionHibernateResourceOperationResult",
  "csharp"
);
@@clientName(
  StartResourceOperationResponse,
  "BulkActionStartResourceOperationResult",
  "csharp"
);

// =====================================================================
// Critical: Parameters suffix
// =====================================================================
@@clientName(ExecutionParameters, "BulkActionExecutionConfig", "csharp");
@@clientName(
  ManagedDiskParameters,
  "ComputeBulkActionsManagedDiskInfo",
  "csharp"
);
@@clientName(
  DiskEncryptionSetParameters,
  "ComputeBulkActionsDiskEncryptionSetReference",
  "csharp"
);

// =====================================================================
// Warning: Plural enum names → singular
// =====================================================================
@@clientName(CachingTypes, "ComputeBulkActionsCachingType", "csharp");
@@clientName(
  DiskControllerTypes,
  "ComputeBulkActionsDiskControllerType",
  "csharp"
);
@@clientName(
  DiskCreateOptionTypes,
  "ComputeBulkActionsDiskCreateOptionType",
  "csharp"
);
@@clientName(
  DiskDeleteOptionTypes,
  "ComputeBulkActionsDiskDeleteOptionType",
  "csharp"
);
@@clientName(
  DiskDetachOptionTypes,
  "ComputeBulkActionsDiskDetachOptionType",
  "csharp"
);
@@clientName(
  DomainNameLabelScopeTypes,
  "ComputeBulkActionsDomainNameLabelScopeType",
  "csharp"
);
@@clientName(IPVersions, "ComputeBulkActionsIPVersion", "csharp");
@@clientName(
  OperatingSystemTypes,
  "ComputeBulkActionsOperatingSystemType",
  "csharp"
);
@@clientName(ProtocolTypes, "ComputeBulkActionsProtocolType", "csharp");
@@clientName(
  SecurityEncryptionTypes,
  "ComputeBulkActionsSecurityEncryptionType",
  "csharp"
);
@@clientName(SecurityTypes, "ComputeBulkActionsSecurityType", "csharp");
@@clientName(
  SettingNames,
  "ComputeBulkActionsAdditionalUnattendContentSettingName",
  "csharp"
);
@@clientName(
  StorageAccountTypes,
  "ComputeBulkActionsStorageAccountType",
  "csharp"
);
@@clientName(DeleteOptions, "ComputeBulkActionsDeleteOption", "csharp");
@@clientName(DiffDiskOptions, "ComputeBulkActionsDiffDiskOption", "csharp");

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
@@clientName(LocationBasedLaunchBulkInstancesOperation, "BulkAction", "csharp");
@@clientName(Mode, "ComputeBulkActionsProxyAgentMode", "csharp");
@@clientName(Modes, "ComputeBulkActionsHostEndpointMode", "csharp");
@@clientName(ApiError, "ComputeBulkActionsApiError", "csharp");
@@clientName(ApiError.innererror, "InnerError", "csharp");
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
@@clientName(
  ResourceOperationDetails,
  "BulkActionResourceOperationDetails",
  "csharp"
);
@@clientName(
  ResourceOperationError,
  "BulkActionResourceOperationError",
  "csharp"
);
@@clientName(
  ResourceOperationType,
  "BulkActionResourceOperationType",
  "csharp"
);
@@clientName(
  ResourceProvisionPayload,
  "BulkActionResourceProvisionPayload",
  "csharp"
);
@@clientName(VMOperationStatus, "BulkActionVMOperationStatus", "csharp");
@@clientName(
  AcceleratorManufacturer,
  "ComputeBulkActionsAcceleratorManufacturer",
  "csharp"
);
@@clientName(AcceleratorType, "ComputeBulkActionsAcceleratorType", "csharp");
@@clientName(ArchitectureType, "ComputeBulkActionsArchitectureType", "csharp");
@@clientName(CpuManufacturer, "ComputeBulkActionsCpuManufacturer", "csharp");
@@clientName(ComputeProfile, "BulkActionComputeProfile", "csharp");
@@clientName(
  HostEndpointSettings,
  "ComputeBulkActionsHostEndpointSettings",
  "csharp"
);
@@clientName(
  ProxyAgentSettings,
  "ComputeBulkActionsProxyAgentSettings",
  "csharp"
);
@@clientName(
  DiskEncryptionSettings,
  "ComputeBulkActionsDiskEncryptionSettings",
  "csharp"
);
@@clientName(
  KeyVaultKeyReference,
  "ComputeBulkActionsKeyVaultKeyReference",
  "csharp"
);
@@clientName(
  KeyVaultSecretReference,
  "ComputeBulkActionsKeyVaultSecretReference",
  "csharp"
);
@@clientName(
  PublicIPAddressSku,
  "ComputeBulkActionsPublicIPAddressSku",
  "csharp"
);
@@clientName(
  PublicIPAddressSkuName,
  "ComputeBulkActionsPublicIPAddressSkuName",
  "csharp"
);
@@clientName(
  PublicIPAddressSkuTier,
  "ComputeBulkActionsPublicIPAddressSkuTier",
  "csharp"
);
@@clientName(
  PublicIPAllocationMethod,
  "ComputeBulkActionsPublicIPAllocationMethod",
  "csharp"
);
@@clientName(
  NetworkInterfaceAuxiliaryMode,
  "ComputeBulkActionsNetworkInterfaceAuxiliaryMode",
  "csharp"
);
@@clientName(
  NetworkInterfaceAuxiliarySku,
  "ComputeBulkActionsNetworkInterfaceAuxiliarySku",
  "csharp"
);
@@clientName(
  NetworkInterfaceReferenceProperties,
  "ComputeBulkActionsNetworkInterfaceReferenceProperties",
  "csharp"
);
@@clientName(
  ScheduledEventsPolicy,
  "ComputeBulkActionsScheduledEventsPolicy",
  "csharp"
);
@@clientName(
  ScheduledEventsProfile,
  "ComputeBulkActionsScheduledEventsProfile",
  "csharp"
);
@@clientName(
  TerminateNotificationProfile,
  "ComputeBulkActionsTerminateNotificationProfile",
  "csharp"
);
@@clientName(VaultCertificate, "ComputeBulkActionsVaultCertificate", "csharp");
@@clientName(VaultSecretGroup, "ComputeBulkActionsVaultSecretGroup", "csharp");
@@clientName(VMCategory, "ComputeBulkActionsVMCategory", "csharp");
@@clientName(
  ZoneAllocationPolicy,
  "ComputeBulkActionsZoneAllocationPolicy",
  "csharp"
);
@@clientName(
  ZoneDistributionStrategy,
  "ComputeBulkActionsZoneDistributionStrategy",
  "csharp"
);
@@clientName(
  AdditionalUnattendContent,
  "ComputeBulkActionsAdditionalUnattendContent",
  "csharp"
);
@@clientName(
  DiffDiskPlacement,
  "ComputeBulkActionsDiffDiskPlacement",
  "csharp"
);
@@clientName(DiffDiskSettings, "ComputeBulkActionsDiffDiskSettings", "csharp");
@@clientName(
  EventGridAndResourceGraph,
  "ComputeBulkActionsEventGridAndResourceGraph",
  "csharp"
);
@@clientName(HyperVGeneration, "ComputeBulkActionsHyperVGeneration", "csharp");
@@clientName(
  LaunchBulkInstancesOperationProperties,
  "ComputeBulkActionsLaunchBulkInstancesOperationProperties",
  "csharp"
);
@@clientName(
  LinuxPatchAssessmentMode,
  "ComputeBulkActionsLinuxPatchAssessmentMode",
  "csharp"
);
@@clientName(
  LinuxPatchSettings,
  "ComputeBulkActionsLinuxPatchSettings",
  "csharp"
);
@@clientName(
  LinuxVMGuestPatchAutomaticByPlatformRebootSetting,
  "ComputeBulkActionsLinuxVMGuestPatchAutomaticByPlatformRebootSetting",
  "csharp"
);
@@clientName(
  LinuxVMGuestPatchAutomaticByPlatformSettings,
  "ComputeBulkActionsLinuxVMGuestPatchAutomaticByPlatformSettings",
  "csharp"
);
@@clientName(
  LinuxVMGuestPatchMode,
  "ComputeBulkActionsLinuxVMGuestPatchMode",
  "csharp"
);
@@clientName(
  LocalStorageDiskType,
  "ComputeBulkActionsLocalStorageDiskType",
  "csharp"
);
@@clientName(
  OSImageNotificationProfile,
  "ComputeBulkActionsOSImageNotificationProfile",
  "csharp"
);
@@clientName(UefiSettings, "ComputeBulkActionsUefiSettings", "csharp");
@@clientName(
  VirtualMachineIpTag,
  "ComputeBulkActionsVirtualMachineIpTag",
  "csharp"
);
@@clientName(
  VirtualMachineNetworkInterfaceConfiguration,
  "ComputeBulkActionsVirtualMachineNetworkInterfaceConfiguration",
  "csharp"
);
@@clientName(
  VirtualMachineNetworkInterfaceConfigurationProperties,
  "ComputeBulkActionsVirtualMachineNetworkInterfaceConfigurationProperties",
  "csharp"
);
@@clientName(
  VirtualMachineNetworkInterfaceIPConfiguration,
  "ComputeBulkActionsVirtualMachineNetworkInterfaceIPConfiguration",
  "csharp"
);
@@clientName(
  VirtualMachineNetworkInterfaceIPConfigurationProperties,
  "ComputeBulkActionsVirtualMachineNetworkInterfaceIPConfigurationProperties",
  "csharp"
);
@@clientName(
  VirtualMachinePublicIPAddressConfiguration,
  "ComputeBulkActionsVirtualMachinePublicIPAddressConfiguration",
  "csharp"
);
@@clientName(
  VirtualMachinePublicIPAddressConfigurationProperties,
  "ComputeBulkActionsVirtualMachinePublicIPAddressConfigurationProperties",
  "csharp"
);
@@clientName(
  VirtualMachinePublicIPAddressDnsSettingsConfiguration,
  "ComputeBulkActionsVirtualMachinePublicIPAddressDnsSettingsConfiguration",
  "csharp"
);
@@clientName(
  VMAttributeMinMaxDouble,
  "ComputeBulkActionsVMAttributeMinMaxDouble",
  "csharp"
);
@@clientName(
  VMAttributeMinMaxInteger,
  "ComputeBulkActionsVMAttributeMinMaxInteger",
  "csharp"
);
@@clientName(VMAttributes, "ComputeBulkActionsVMAttributes", "csharp");
@@clientName(
  VMAttributeSupport,
  "ComputeBulkActionsVMAttributeSupport",
  "csharp"
);
@@clientName(
  VMDiskSecurityProfile,
  "ComputeBulkActionsVMDiskSecurityProfile",
  "csharp"
);
@@clientName(
  VMGalleryApplication,
  "ComputeBulkActionsVMGalleryApplication",
  "csharp"
);
@@clientName(VmSizeProfile, "ComputeBulkActionsVmSizeProfile", "csharp");
@@clientName(
  WindowsPatchAssessmentMode,
  "ComputeBulkActionsWindowsPatchAssessmentMode",
  "csharp"
);
@@clientName(
  WindowsVMGuestPatchAutomaticByPlatformRebootSetting,
  "ComputeBulkActionsWindowsVMGuestPatchAutomaticByPlatformRebootSetting",
  "csharp"
);
@@clientName(
  WindowsVMGuestPatchAutomaticByPlatformSettings,
  "ComputeBulkActionsWindowsVMGuestPatchAutomaticByPlatformSettings",
  "csharp"
);
@@clientName(
  WindowsVMGuestPatchMode,
  "ComputeBulkActionsWindowsVMGuestPatchMode",
  "csharp"
);
@@clientName(WinRMListener, "ComputeBulkActionsWinRMListener", "csharp");

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

// ScheduledEventsPolicy flattened properties
@@clientName(
  UserInitiatedRedeploy.automaticallyApprove,
  "IsRedeployAutomaticallyApproved",
  "csharp"
);
@@clientName(
  UserInitiatedReboot.automaticallyApprove,
  "IsRebootAutomaticallyApproved",
  "csharp"
);
@@clientName(
  AllInstancesDown.automaticallyApprove,
  "IsAllInstancesDownAutomaticallyApproved",
  "csharp"
);

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
