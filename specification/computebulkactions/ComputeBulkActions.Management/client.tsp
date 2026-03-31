import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

namespace Microsoft.ComputeBulkActions;

@@clientName(ExecuteTypeRequest.correlationid, "correlationId", "java");
@@clientName(ExecuteCreateRequest.correlationid, "correlationId", "java");
@@clientName(GetOperationStatusRequest.correlationid, "correlationId", "java");
@@clientName(CancelOperationsRequest.correlationid, "correlationId", "java");
@@clientName(Microsoft.ComputeBulkActions,
  "ComputeBulkActionsMgmtClient",
  "python"
);

// =====================================================================
// Critical: Correlationid casing fix (lowercase 'd' → capital 'I' in Id)
// =====================================================================
@@clientName(ExecuteTypeRequest.correlationid, "CorrelationId", "csharp");
@@clientName(ExecuteCreateRequest.correlationid, "CorrelationId", "csharp");
@@clientName(GetOperationStatusRequest.correlationid,
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
@@clientName(CreateResourceOperationResponse,
  "CreateResourceOperationResult",
  "csharp"
);
@@clientName(DeallocateResourceOperationResponse,
  "DeallocateResourceOperationResult",
  "csharp"
);
@@clientName(DeleteResourceOperationResponse,
  "DeleteResourceOperationResult",
  "csharp"
);
@@clientName(GetOperationStatusResponse, "GetOperationStatusResult", "csharp");
@@clientName(HibernateResourceOperationResponse,
  "HibernateResourceOperationResult",
  "csharp"
);
@@clientName(StartResourceOperationResponse,
  "StartResourceOperationResult",
  "csharp"
);

// =====================================================================
// Critical: Parameters suffix
// =====================================================================
@@clientName(ExecutionParameters, "BulkActionExecutionConfig", "csharp");

// =====================================================================
// Warning: Plural enum names → singular
// =====================================================================
@@clientName(CachingTypes, "CachingType", "csharp");
@@clientName(DiskControllerTypes, "DiskControllerType", "csharp");
@@clientName(DiskCreateOptionTypes, "DiskCreateOptionType", "csharp");
@@clientName(DiskDeleteOptionTypes, "DiskDeleteOptionType", "csharp");
@@clientName(DiskDetachOptionTypes, "DiskDetachOptionType", "csharp");
@@clientName(DomainNameLabelScopeTypes, "DomainNameLabelScopeType", "csharp");
@@clientName(IPVersions, "IPVersion", "csharp");
@@clientName(OperatingSystemTypes, "OperatingSystemType", "csharp");
@@clientName(ProtocolTypes, "ProtocolType", "csharp");
@@clientName(SecurityEncryptionTypes, "SecurityEncryptionType", "csharp");
@@clientName(SecurityTypes, "SecurityType", "csharp");
@@clientName(SettingNames, "SettingName", "csharp");
@@clientName(StorageAccountTypes, "StorageAccountType", "csharp");

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
@@clientName(ResourceOperation, "BulkActionResourceOperation", "csharp");

// =====================================================================
// Warning: DateTimeOffset property naming (*On suffix)
// =====================================================================
@@clientName(ResourceOperationDetails.deadline, "DeadlineOn", "csharp");

// =====================================================================
// Warning: Boolean property naming (verb prefix)
// =====================================================================
// AdditionalCapabilities
@@clientName(AdditionalCapabilities.ultraSSDEnabled,
  "IsUltraSsdEnabled",
  "csharp"
);
@@clientName(AdditionalCapabilities.hibernationEnabled,
  "IsHibernationEnabled",
  "csharp"
);

// BootDiagnostics
@@clientName(BootDiagnostics.enabled, "IsEnabled", "csharp");

// DataDisk
@@clientName(DataDisk.toBeDetached, "IsToBeDetached", "csharp");

// DiskEncryptionSettings
@@clientName(DiskEncryptionSettings.enabled, "IsEnabled", "csharp");

// EventGridAndResourceGraph
@@clientName(EventGridAndResourceGraph.enable, "IsEnabled", "csharp");

// ExecuteDeleteRequest (now ExecuteDeleteContent)
@@clientName(ExecuteDeleteRequest.forceDeletion, "IsForceDeletion", "csharp");

// LinuxConfiguration
@@clientName(LinuxConfiguration.disablePasswordAuthentication,
  "IsPasswordAuthenticationDisabled",
  "csharp"
);
@@clientName(LinuxConfiguration.provisionVMAgent,
  "IsVMAgentProvisioned",
  "csharp"
);
@@clientName(LinuxConfiguration.enableVMAgentPlatformUpdates,
  "IsVMAgentPlatformUpdatesEnabled",
  "csharp"
);

// LinuxVMGuestPatchAutomaticByPlatformSettings
@@clientName(LinuxVMGuestPatchAutomaticByPlatformSettings.bypassPlatformSafetyChecksOnUserSchedule,
  "IsBypassPlatformSafetyChecksOnUserSchedule",
  "csharp"
);

// NetworkInterfaceReferenceProperties
@@clientName(NetworkInterfaceReferenceProperties.primary,
  "IsPrimary",
  "csharp"
);

// OSImageNotificationProfile
@@clientName(OSImageNotificationProfile.enable, "IsEnabled", "csharp");

// OSProfile
@@clientName(OSProfile.allowExtensionOperations,
  "IsExtensionOperationsAllowed",
  "csharp"
);
@@clientName(OSProfile.requireGuestProvisionSignal,
  "IsGuestProvisionSignalRequired",
  "csharp"
);

// PatchSettings
@@clientName(PatchSettings.enableHotpatching, "IsHotpatchingEnabled", "csharp");

// ProxyAgentSettings
@@clientName(ProxyAgentSettings.enabled, "IsEnabled", "csharp");
@@clientName(ProxyAgentSettings.addProxyAgentExtension,
  "ShouldAddProxyAgentExtension",
  "csharp"
);

// SecurityProfile
@@clientName(SecurityProfile.encryptionAtHost,
  "IsEncryptionAtHostEnabled",
  "csharp"
);

// TerminateNotificationProfile
@@clientName(TerminateNotificationProfile.enable, "IsEnabled", "csharp");

// UefiSettings
@@clientName(UefiSettings.secureBootEnabled, "IsSecureBootEnabled", "csharp");
@@clientName(UefiSettings.vTpmEnabled, "IsVTpmEnabled", "csharp");

// VMGalleryApplication
@@clientName(VMGalleryApplication.enableAutomaticUpgrade,
  "IsAutomaticUpgradeEnabled",
  "csharp"
);

// VirtualMachineExtensionProperties
@@clientName(VirtualMachineExtensionProperties.autoUpgradeMinorVersion,
  "IsAutoUpgradeMinorVersionEnabled",
  "csharp"
);
@@clientName(VirtualMachineExtensionProperties.enableAutomaticUpgrade,
  "IsAutomaticUpgradeEnabled",
  "csharp"
);
@@clientName(VirtualMachineExtensionProperties.suppressFailures,
  "IsSuppressFailures",
  "csharp"
);

// VirtualMachineNetworkInterfaceConfigurationProperties
@@clientName(VirtualMachineNetworkInterfaceConfigurationProperties.primary,
  "IsPrimary",
  "csharp"
);
@@clientName(VirtualMachineNetworkInterfaceConfigurationProperties.enableAcceleratedNetworking,
  "IsAcceleratedNetworkingEnabled",
  "csharp"
);
@@clientName(VirtualMachineNetworkInterfaceConfigurationProperties.disableTcpStateTracking,
  "IsTcpStateTrackingDisabled",
  "csharp"
);
@@clientName(VirtualMachineNetworkInterfaceConfigurationProperties.enableFpga,
  "IsFpgaEnabled",
  "csharp"
);
@@clientName(VirtualMachineNetworkInterfaceConfigurationProperties.enableIPForwarding,
  "IsIPForwardingEnabled",
  "csharp"
);

// VirtualMachineNetworkInterfaceIPConfigurationProperties
@@clientName(VirtualMachineNetworkInterfaceIPConfigurationProperties.primary,
  "IsPrimary",
  "csharp"
);

// WindowsConfiguration
@@clientName(WindowsConfiguration.provisionVMAgent,
  "IsVMAgentProvisioned",
  "csharp"
);

// WindowsVMGuestPatchAutomaticByPlatformSettings
@@clientName(WindowsVMGuestPatchAutomaticByPlatformSettings.bypassPlatformSafetyChecksOnUserSchedule,
  "IsBypassPlatformSafetyChecksOnUserSchedule",
  "csharp"
);
