import "./main.tsp";
import "./scheduledactionmodels.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";

using Azure.ClientGenerator.Core;
using Microsoft.ComputeSchedule;
using Azure.ResourceManager;
using TypeSpec.Versioning;

@@clientName(Microsoft.ComputeSchedule, "ComputeScheduleMgmtClient", "python");
@@clientName(Microsoft.ComputeSchedule, "ComputeScheduleMgmtClient", "java");
@@clientNamespace(Microsoft.ComputeSchedule,
  "com.azure.resourcemanager.computeschedule",
  "java"
);

@@clientName(CancelOccurrenceRequest, "OccurrenceCancelContent", "csharp");
@@clientName(DelayRequest, "OccurrenceDelayContent", "csharp");
// [DATE001] DateTimeOffset properties should use an "On"/"At" suffix in C#.
@@clientName(DelayRequest.delay, "DelayOn", "csharp");
@@clientName(Language, "NotificationLanguage", "csharp");
@@clientName(Month, "ScheduledActionsScheduleMonth", "csharp");
@@clientName(WeekDay, "ScheduledActionsScheduleWeekDay", "csharp");
@@clientName(NotificationProperties, "NotificationSettings", "csharp");
@@clientName(NotificationProperties.disabled, "IsDisabled", "csharp");

@@clientName(ScheduledActions.virtualMachinesSubmitDeallocate,
  "SubmitVirtualMachineDeallocate",
  "csharp"
);
@@clientName(ScheduledActions.virtualMachinesSubmitHibernate,
  "SubmitVirtualMachineHibernate",
  "csharp"
);

@@clientName(ScheduledActions.virtualMachinesSubmitStart,
  "SubmitVirtualMachineStart",
  "csharp"
);
@@clientName(ScheduledActions.virtualMachinesExecuteDeallocate,
  "ExecuteVirtualMachineDeallocate",
  "csharp"
);
@@clientName(ScheduledActions.virtualMachinesExecuteHibernate,
  "ExecuteVirtualMachineHibernate",
  "csharp"
);
@@clientName(ScheduledActions.virtualMachinesExecuteStart,
  "ExecuteVirtualMachineStart",
  "csharp"
);
@@clientName(ScheduledActions.virtualMachinesGetOperationStatus,
  "GetVirtualMachineOperationStatus",
  "csharp"
);
@@clientName(ScheduledActions.virtualMachinesCancelOperations,
  "CancelVirtualMachineOperations",
  "csharp"
);
@@clientName(ScheduledActions.virtualMachinesGetOperationErrors,
  "GetVirtualMachineOperationErrors",
  "csharp"
);
@@clientName(ScheduledActions.virtualMachinesExecuteCreate,
  "ExecuteVirtualMachineCreateOperation",
  "csharp"
);
@@clientName(ScheduledActions.virtualMachinesExecuteDelete,
  "ExecuteVirtualMachineDeleteOperation",
  "csharp"
);
@@clientName(ScheduledActions.virtualMachinesExecuteCreateFlex,
  "ExecuteVirtualMachineCreateFlexOperation",
  "csharp"
);

@@clientName(CancelOperationsResponse, "CancelOperationsResult", "csharp");
@@clientName(CreateFlexResourceOperationResponse,
  "ScheduledActionCreateFlexResult",
  "csharp"
);
@@clientName(DeadlineType, "ScheduledActionDeadlineType", "csharp");
@@clientName(DeallocateResourceOperationResponse,
  "DeallocateResourceOperationResult",
  "csharp"
);
@@clientName(DeallocateResourceOperationResponse.type,
  "ResourceType",
  "csharp"
);
@@clientName(ExecutionParameters,
  "ScheduledActionExecutionParameterDetail",
  "csharp"
);
@@clientName(GetOperationErrorsResponse, "GetOperationErrorsResult", "csharp");
@@clientName(GetOperationStatusResponse, "GetOperationStatusResult", "csharp");
@@clientName(HibernateResourceOperationResponse,
  "HibernateResourceOperationResult",
  "csharp"
);
@@clientName(HibernateResourceOperationResponse.type, "ResourceType", "csharp");
@@clientName(OperationState, "ScheduledActionOperationState", "csharp");
@@clientName(OptimizationPreference,
  "ScheduledActionOptimizationPreference",
  "csharp"
);
@@clientName(ResourceOperation, "ResourceOperationResult", "csharp");
@@clientName(Resources, "UserRequestResources", "csharp");
@@clientName(RetryPolicy, "UserRequestRetryPolicy", "csharp");
@@clientName(Schedule, "UserRequestSchedule", "csharp");
@@clientName(StartResourceOperationResponse,
  "StartResourceOperationResult",
  "csharp"
);
@@clientName(StartResourceOperationResponse.type, "ResourceType", "csharp");
@@clientName(CreateFlexResourceOperationResponse.type,
  "ResourceType",
  "csharp"
);
@@clientName(ExecuteDeleteRequest.correlationid,
  "correlationId",
  "csharp,javascript"
);
@@clientName(ExecuteDeleteRequest.forceDeletion, "IsForceDeletion", "csharp");
@@clientName(ExecuteCreateRequest.correlationid,
  "correlationId",
  "csharp,javascript"
);
@@clientName(ExecuteCreateFlexRequest.correlationid,
  "correlationId",
  "csharp,javascript"
);
@@clientName(SubmitDeallocateRequest.correlationid,
  "correlationId",
  "csharp,javascript"
);
@@clientName(SubmitStartRequest.correlationid,
  "correlationId",
  "csharp,javascript"
);
@@clientName(SubmitHibernateRequest.correlationid,
  "correlationId",
  "csharp,javascript"
);
@@clientName(ExecuteDeallocateRequest.correlationid,
  "correlationId",
  "csharp,javascript"
);
@@clientName(ExecuteHibernateRequest.correlationid,
  "correlationId",
  "csharp,javascript"
);
@@clientName(ExecuteStartRequest.correlationid,
  "correlationId",
  "csharp,javascript"
);
@@clientName(GetOperationStatusRequest.correlationid,
  "correlationId",
  "csharp,javascript"
);
@@clientName(CancelOperationsRequest.correlationid,
  "correlationId",
  "csharp,javascript"
);
@@clientName(Schedule.deadLine, "userRequestDeadline", "csharp,javascript");
@@clientName(Schedule.timeZone, "userRequestTimezone", "csharp,javascript");
@@clientName(ResourceOperationDetails.timeZone,
  "operationTimezone",
  "csharp,javascript"
);
@@clientName(OperationErrorDetails.timeStamp,
  "errorDetailsTimestamp",
  "csharp,javascript"
);
@@clientName(Versions.`2024-10-01`,
  "$DO_NOT_NORMALIZE$V2024-10-01",
  "javascript"
);
@@clientName(DeleteResourceOperationResponse,
  "DeleteResourceOperationResult",
  "csharp"
);
@@clientName(CreateResourceOperationResponse,
  "CreateResourceOperationResult",
  "csharp"
);
// [SUFFIX006] ScheduledActionResource is not a ResourceData-derived ARM
// resource (it's an item embedded in attach/patch payloads), so it must not
// carry the "Data" suffix in C#.
@@clientName(ScheduledActionResource,
  "ScheduledActionResourceDetails",
  "csharp"
);
// [SUFFIX006] OccurrenceResource has its own Id/Name/Type and does not derive
// from ResourceData -> drop the "Data" suffix.
@@clientName(OccurrenceResource, "OccurrenceDetails", "csharp");
// [RESINFIX001] OccurrenceExtensionResource derives from ResourceData; keep
// the "Data" suffix but drop the redundant "Resource" infix.
@@clientName(OccurrenceExtensionResource, "OccurrenceExtensionData", "csharp");
@@clientName(ResourceOperationResponse,
  "ScheduledActionResourceOperationResult",
  "csharp"
);
@@clientName(ResourceProvisioningState,
  "OccurrenceResourceProvisioningState",
  "csharp"
);
@@clientName(ProvisioningState,
  "ScheduledActionResourceProvisioningState",
  "csharp"
);
@@clientName(Occurrence, "ScheduledActionOccurrence", "csharp");
@@clientName(OccurrenceProperties,
  "ScheduledActionOccurrenceProperties",
  "csharp"
);
@@clientName(OccurrenceState, "ScheduledActionOccurrenceState", "csharp");
@@clientName(ResourceAttachRequest,
  "ScheduledActionResourceAttachContent",
  "csharp"
);
@@clientName(ResourceDetachRequest,
  "ScheduledActionResourceDetachContent",
  "csharp"
);
@@clientName(ResourcePatchRequest, "ScheduledActionResourcePatch", "csharp");
@@clientName(ResourceStatus, "ScheduledActionResourceStatus", "csharp");
@@clientName(ResourceOperationStatus,
  "ScheduledActionResourceOperationStatus",
  "csharp"
);
@@clientName(ResourceType, "ScheduledActionResourceType", "csharp");

@@clientName(AllocationStrategy, "ComputeScheduleAllocationStrategy", "csharp");
@@clientName(DistributionStrategy,
  "ComputeScheduleDistributionStrategy",
  "csharp"
);
@@clientName(OsType, "ComputeScheduleOSType", "csharp");
@@clientName(PriorityType, "ComputeSchedulePriorityType", "csharp");
@@clientName(PriorityProfile, "ComputeSchedulePriorityProfile", "csharp");
@@clientName(FlexProperties, "ComputeScheduleFlexProperties", "csharp");
@@clientName(VmSizeProfile, "ComputeScheduleVmSizeProfile", "csharp");
@@clientName(ZonePreference, "ComputeScheduleZonePreference", "csharp");
@@clientName(ZoneAllocationPolicy,
  "ComputeScheduleZoneAllocationPolicy",
  "csharp"
);

@@clientName(UserInitiatedRedeploy.automaticallyApprove,
  "IsAutomaticallyApprovedForRedeploy",
  "csharp"
);
@@clientName(UserInitiatedReboot.automaticallyApprove,
  "IsAutomaticallyApprovedForReboot",
  "csharp"
);
@@clientName(AllInstancesDown.automaticallyApprove,
  "IsAutomaticallyApprovedForAllInstancesDown",
  "csharp"
);

@@clientName(DiskEncryptionSetParameters,
  "ComputeScheduleDiskEncryptionSetConfig",
  "csharp"
);
@@clientName(ManagedDiskParameters,
  "ComputeScheduleManagedDiskConfig",
  "csharp"
);
@@clientName(VirtualMachineReimageParameters,
  "ComputeScheduleVirtualMachineReimageConfig",
  "csharp"
);

@@clientName(OccurrenceExtension.listOccurrenceByVms,
  "GetAssociatedOccurrences",
  "csharp"
);
@@clientName(ScheduledActions.listResources, "GetAttachedResources", "csharp");
@@clientName(Occurrences.listResources, "GetAttachedResources", "csharp");
@@clientName(ScheduledActionExtension.listByVms,
  "GetAssociatedScheduledActions",
  "csharp"
);

@@clientName(ResourceOperationResponse,
  "RecurringActionsResourceOperationResult",
  "javascript,go,python,java"
);
@@clientName(Microsoft.ComputeSchedule.Versions.`2025-05-01`,
  "V2025-05-01",
  "javascript"
);
@@clientName(Microsoft.ComputeSchedule.ActionType, "ScheduledActionType");

@@clientName(SubmitDeallocateRequest, "SubmitDeallocateContent");
@@clientName(ExecuteHibernateRequest, "ExecuteHibernateContent");
@@clientName(CancelOperationsRequest, "CancelOperationsContent");
@@clientName(ExecuteCreateRequest, "ExecuteCreateContent");
@@clientName(ExecuteCreateFlexRequest, "ExecuteCreateFlexContent");
@@clientName(ExecuteDeallocateRequest, "ExecuteDeallocateContent");
@@clientName(ExecuteDeleteRequest, "ExecuteDeleteContent");
@@clientName(ExecuteStartRequest, "ExecuteStartContent");
@@clientName(GetOperationErrorsRequest, "GetOperationErrorsContent");
@@clientName(GetOperationStatusRequest, "GetOperationStatusContent");
@@clientName(SubmitStartRequest, "SubmitStartContent");
@@clientName(SubmitHibernateRequest, "SubmitHibernateContent");
@@clientName(ScheduledActionsExtensionProperties,
  "ScheduledActionsExtensionProperties"
);

@added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@doc("Represents a scheduled action resource input for write operations.")
model ScheduledActionResourceInput {
  @doc("""
    The ARM Id of the resource.
    "subscriptions/{subId}/resourceGroups/{rgName}/providers/Microsoft.Compute/virtualMachines/{vmName}"
    """)
  resourceId: ValidScheduledActionResourceId;

  @doc("The desired notification settings for the specified resource.")
  @Azure.ResourceManager.identifiers(#["destination"])
  notificationSettings?: Array<NotificationProperties>;
}

@added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@doc("Request model to attach a list of scheduled action resources.")
model ResourceAttachRequestInput {
  @doc("List of resources to be attached/patched")
  @identifiers(#["resourceId"])
  resources: Array<ScheduledActionResourceInput>;
}

@added(Microsoft.ComputeSchedule.Versions.`2025-04-15-preview`)
@doc("Request model perform a resource operation in a list of resources")
model ResourcePatchRequestInput {
  @doc("The list of resources we watch to patch")
  @identifiers(#["resourceId"])
  resources: Array<ScheduledActionResourceInput>;
}

@@alternateType(ScheduledActions.attachResources::parameters.body,
  ResourceAttachRequestInput,
  "javascript"
);

@@alternateType(ScheduledActions.patchResources::parameters.body,
  ResourcePatchRequestInput,
  "javascript"
);

// =====================================================================
// Fix: NetworkApiVersion enum members with dashes cause Python SyntaxError
// (ENUM_2020 - 11 - 01 instead of ENUM_2020_11_01)
// =====================================================================
@@clientName(NetworkApiVersion.`2020-11-01`, "V2020_11_01", "python");
@@clientName(NetworkApiVersion.`2022-11-01`, "V2022_11_01", "python");

// =====================================================================
// Fix: Go SDK Validation incorrectly detects networkApiVersion as an API version
// parameter because its name contains "apiversion". This causes
// the Go emitter to crash with "unexpected constant client side default
// 2026-04-15-preview for field NetworkAPIVersion". Override the heuristic.
// =====================================================================
@@apiVersion(NetworkProfile.networkApiVersion, false, "go");

// =====================================================================
// C# naming alignment with Azure.ResourceManager.Compute SDK
// =====================================================================
@@clientName(AdditionalCapabilities.ultraSSDEnabled,
  "UltraSsdEnabled",
  "csharp"
);
@@clientName(LinuxConfiguration.provisionVMAgent, "ProvisionVmAgent", "csharp");
@@clientName(WindowsConfiguration.provisionVMAgent,
  "ProvisionVmAgent",
  "csharp"
);
@@clientName(UefiSettings.secureBootEnabled, "IsSecureBootEnabled", "csharp");
@@clientName(UefiSettings.vTpmEnabled, "IsVirtualTpmEnabled", "csharp");
@@clientName(LinuxConfiguration.disablePasswordAuthentication,
  "IsPasswordAuthenticationDisabled",
  "csharp"
);
@@clientName(LinuxConfiguration.enableVMAgentPlatformUpdates,
  "IsVmAgentPlatformUpdatesEnabled",
  "csharp"
);
@@clientName(WindowsConfiguration.enableAutomaticUpdates,
  "IsAutomaticUpdatesEnabled",
  "csharp"
);
@@clientName(StorageProfile.osDisk, "OSDisk", "csharp");
@@clientName(OSDisk.osType, "OSType", "csharp");
@@clientName(ScheduledEventsProfile.osImageNotificationProfile,
  "OSImageNotificationProfile",
  "csharp"
);

@@alternateType(ApiEntityReference.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// ARM Resource IDs -> ResourceIdentifier
@@alternateType(SubResource.id, Azure.Core.armResourceIdentifier, "csharp");

// String URIs -> System.Uri
@@alternateType(VirtualHardDisk.uri, url, "csharp");
@@alternateType(BootDiagnostics.storageUri, url, "csharp");
@@alternateType(KeyVaultSecretReference.secretUrl, url, "csharp");
@@alternateType(KeyVaultKeyReference.keyUrl, url, "csharp");
@@alternateType(WinRMListener.certificateUrl, url, "csharp");
@@alternateType(VaultCertificate.certificateUrl, url, "csharp");

// =====================================================================
// C# type renames: Prefix core VM types with "VirtualMachine" to match
// Azure.ResourceManager.Compute SDK naming conventions
// =====================================================================
@@clientName(OSDisk, "VirtualMachineOSDisk", "csharp");
@@clientName(OSProfile, "VirtualMachineOSProfile", "csharp");
@@clientName(DataDisk, "VirtualMachineDataDisk", "csharp");
@@clientName(NetworkProfile, "VirtualMachineNetworkProfile", "csharp");
@@clientName(StorageProfile, "VirtualMachineStorageProfile", "csharp");
@@clientName(HardwareProfile, "VirtualMachineHardwareProfile", "csharp");
@@clientName(VmSizeProperties, "VirtualMachineSizeProperties", "csharp");
@@clientName(NetworkInterfaceReference,
  "VirtualMachineNetworkInterfaceReference",
  "csharp"
);

// =====================================================================
// C# type renames: Match Compute SDK type names
// =====================================================================
@@clientName(SshPublicKey, "SshPublicKeyConfiguration", "csharp");
@@clientName(BulkActionVMProperties,
  "BulkActionVirtualMachineProperties",
  "csharp"
);
@@clientName(BulkActionVMExtension, "BulkActionVmExtension", "csharp");
@@clientName(BulkActionVmExtensionProperties,
  "BulkActionVirtualMachineExtensionProperties",
  "csharp"
);
@@clientName(NetworkInterfaceReferenceProperties,
  "VirtualMachineNetworkInterfaceReferenceProperties",
  "csharp"
);
@@clientName(OccurrenceExtensionProperties,
  "ScheduledActionOccurrenceExtensionProperties",
  "csharp"
);
@@clientName(FallbackOperationInfo, "ScheduledActionFallbackInfo", "csharp");
@@clientName(Modes, "HostEndpointSettingsMode", "csharp");

// =====================================================================
// C# enum renames: Singular names to match Compute SDK conventions
// =====================================================================
@@clientName(CachingTypes, "CachingType", "csharp");
@@clientName(SecurityTypes, "SecurityType", "csharp");
@@clientName(OperatingSystemTypes, "OperatingSystemType", "csharp");
@@clientName(DiskControllerTypes, "DiskControllerType", "csharp");
@@clientName(DiskCreateOptionTypes, "DiskCreateOptionType", "csharp");
@@clientName(DiskDeleteOptionTypes, "DiskDeleteOptionType", "csharp");
@@clientName(DiskDetachOptionTypes, "DiskDetachOptionType", "csharp");
@@clientName(IPVersions, "IPVersion", "csharp");
@@clientName(ProtocolTypes, "WinRMListenerProtocolType", "csharp");
@@clientName(DomainNameLabelScopeTypes, "DomainNameLabelScopeType", "csharp");
@@clientName(SecurityEncryptionTypes, "SecurityEncryptionType", "csharp");
@@clientName(StorageAccountTypes, "StorageAccountType", "csharp");
@@clientName(SettingNames, "SettingName", "csharp");

// =====================================================================
// C# property renames: Match Compute SDK property names
// =====================================================================
@@clientName(ImageReference.sharedGalleryImageId,
  "SharedGalleryImageUniqueId",
  "csharp"
);

// =====================================================================
// [ARMCOMMON001] Use framework ManagedServiceIdentity instead of local
// VirtualMachineIdentity / UserAssignedIdentitiesValue / ResourceIdentityType
// =====================================================================
@@alternateType(BulkVMConfiguration.identity,
  Azure.ResourceManager.Foundations.ManagedServiceIdentity,
  "csharp"
);

// =====================================================================
// [ARMCOMMON001] Use framework WritableSubResource for SubResource-typed
// properties (wire format stays { "id": "..." })
// =====================================================================

// Define the model in the Azure.ResourceManager.Models namespace so
// @@alternateType can reference it for C# SDK generation.
namespace Azure.ResourceManager.Models {
  /** Represents a reference to an existing resource by its id. */
  model WritableSubResource {
    /** The resource id. */
    id?: Azure.Core.armResourceIdentifier;
  }
}

@@alternateType(KeyVaultSecretReference.sourceVault,
  Azure.ResourceManager.Models.WritableSubResource,
  "csharp"
);
@@alternateType(KeyVaultKeyReference.sourceVault,
  Azure.ResourceManager.Models.WritableSubResource,
  "csharp"
);
@@alternateType(VaultSecretGroup.sourceVault,
  Azure.ResourceManager.Models.WritableSubResource,
  "csharp"
);

// =====================================================================
// [ACRONYM001] C# acronym casing: "VM" should be "Vm" (PascalCase per
// .NET Framework Design Guidelines for two-letter acronyms in compound
// identifiers). Aligns with Azure.ResourceManager.Compute SDK naming.
// =====================================================================
@@clientName(BulkVMConfiguration, "BulkVmConfiguration", "csharp");
@@clientName(VMGalleryApplication, "VmGalleryApplication", "csharp");
@@clientName(LinuxVMGuestPatchMode, "LinuxVmGuestPatchMode", "csharp");
@@clientName(LinuxVMGuestPatchAutomaticByPlatformSettings,
  "LinuxVmGuestPatchAutomaticByPlatformSettings",
  "csharp"
);
@@clientName(LinuxVMGuestPatchAutomaticByPlatformRebootSetting,
  "LinuxVmGuestPatchAutomaticByPlatformRebootSetting",
  "csharp"
);
@@clientName(WindowsVMGuestPatchMode, "WindowsVmGuestPatchMode", "csharp");
@@clientName(WindowsVMGuestPatchAutomaticByPlatformSettings,
  "WindowsVmGuestPatchAutomaticByPlatformSettings",
  "csharp"
);
@@clientName(WindowsVMGuestPatchAutomaticByPlatformRebootSetting,
  "WindowsVmGuestPatchAutomaticByPlatformRebootSetting",
  "csharp"
);
// VMDiskSecurityProfile -> VirtualMachineDiskSecurityProfile to match the
// type name used by Azure.ResourceManager.Compute.
@@clientName(VMDiskSecurityProfile,
  "VirtualMachineDiskSecurityProfile",
  "csharp"
);
