import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Microsoft.Compute;

@@clientName(Microsoft.Compute, "ComputeBulkActionsMgmtClient", "python");
@@clientName(NetworkApiVersion.`2020-11-01`, "ENUM_2020_11_01", "python");
@@clientName(NetworkApiVersion.`2022-11-01`, "ENUM_2022_11_01", "python");
@@clientName(
  VirtualMachineBulkOperations.bulkDeallocate,
  "BulkDeallocateOperation",
  "!autorest"
);
@@clientName(
  VirtualMachineBulkOperations.bulkHibernate,
  "BulkHibernateOperation",
  "!autorest"
);
@@clientName(
  VirtualMachineBulkOperations.bulkStart,
  "BulkStartOperation",
  "!autorest"
);
@@clientName(
  VirtualMachineBulkOperations.bulkGetOperationsStatus,
  "BulkGetOperationsStatus",
  "!autorest"
);
@@clientName(
  VirtualMachineBulkOperations.bulkCancel,
  "BulkCancelOperations",
  "!autorest"
);
@@clientName(
  VirtualMachineBulkOperations.bulkCreate,
  "BulkCreateOperation",
  "!autorest"
);
@@clientName(
  VirtualMachineBulkOperations.bulkDelete,
  "BulkDeleteOperation",
  "!autorest"
);
@@clientName(
  VirtualMachineBulkOperations.bulkReimage,
  "BulkReimageOperation",
  "!autorest"
);
@@clientName(
  VirtualMachineBulkOperations.bulkVdiFlexCreate,
  "BulkVdiFlexCreateOperation",
  "!autorest"
);

// Disambiguate LaunchBulkInstancesOperation's custom InnerError from the standard
// Azure.Core.Foundations.InnerError that the folded ScheduledActions error models pull in
// (via Azure.Core.Foundations.Error). Flattening-language SDKs (C#/Java/Python) require unique
// client names; the standard type keeps "InnerError", BA's custom one is renamed.
@@clientName(Microsoft.Compute.InnerError, "BulkInstancesInnerError", "csharp");
@@clientName(Microsoft.Compute.InnerError, "BulkInstancesInnerError", "java");
@@clientName(
  Microsoft.Compute.InnerError,
  "BulkInstancesInnerError",
  "python,go,javascript"
);

@@clientName(CancelOperationsResponse, "CancelBulkOperationsResult", "csharp");
@@clientName(
  CapacityRecommendationParameters,
  "BulkActionsCapacityRecommendationParametersContent",
  "csharp"
);
@@clientName(DeadlineType, "BulkActionDeadlineKind", "csharp");
@@clientName(
  DeallocateResourceOperationResponse,
  "DeallocateResourceOperationResult",
  "csharp"
);
@@clientName(
  DeallocateResourceOperationResponse.type,
  "ResourceTypeName",
  "csharp"
);
@@clientName(
  ExecutionParameters,
  "BulkActionExecutionParameterDetail",
  "csharp"
);
@@clientName(
  GetOperationStatusResponse,
  "GetBulkOperationStatusResult",
  "csharp"
);
@@clientName(
  HibernateResourceOperationResponse,
  "HibernateResourceOperationResult",
  "csharp"
);
@@clientName(
  HibernateResourceOperationResponse.type,
  "ResourceTypeName",
  "csharp"
);
@@clientName(OperationState, "BulkActionOperationState", "csharp");

@@clientName(ResourceOperation, "ComputeBulkOperationResult", "csharp");
@@clientName(Resources, "UserRequestResources", "csharp");
@@clientName(RetryPolicy, "BulkOperationRetryPolicy", "csharp");
@@clientName(
  StartResourceOperationResponse,
  "StartResourceOperationResult",
  "csharp"
);
@@clientName(StartResourceOperationResponse.type, "ResourceTypeName", "csharp");
@@clientName(ExecuteDeleteRequest.forceDeletion, "IsForceDeletion", "csharp");
@@clientName(
  OperationErrorDetails.timeStamp,
  "errorDetailsTimestamp",
  "csharp,javascript,java,python"
);

@@clientName(
  DeleteResourceOperationResponse,
  "DeleteResourceOperationResult",
  "csharp"
);
@@clientName(
  DeleteResourceOperationResponse.type,
  "ResourceTypeName",
  "csharp"
);
@@clientName(
  CreateResourceOperationResponse,
  "CreateResourceOperationResult",
  "csharp"
);
@@clientName(
  CreateResourceOperationResponse.type,
  "ResourceTypeName",
  "csharp"
);
@@clientName(ExecuteHibernateRequest, "ExecuteHibernateContent", "!autorest");
@@clientName(ExecuteCreateRequest, "ExecuteCreateContent", "!autorest");
@@clientName(ExecuteDeallocateRequest, "ExecuteDeallocateContent", "!autorest");
@@clientName(ExecuteDeleteRequest, "ExecuteDeleteContent", "!autorest");
@@clientName(ExecuteStartRequest, "ExecuteStartContent", "!autorest");
@@clientName(
  GetOperationStatusRequest,
  "GetOperationStatusContent",
  "!autorest"
);
@@clientName(CancelOperationsRequest, "CancelOperationsContent", "!autorest");
@@clientName(
  ManagedDiskParameters,
  "ManagedDiskParametersContent",
  "!autorest"
);
@@clientName(
  DiskEncryptionSetParameters,
  "DiskEncryptionSetParametersContent",
  "!autorest"
);

@@clientName(
  UserInitiatedRedeploy.automaticallyApprove,
  "UserInitiatedRedeployAutomaticallyApprove",
  "!autorest"
);
@@clientName(
  UserInitiatedReboot.automaticallyApprove,
  "UserInitiatedRebootAutomaticallyApprove",
  "!autorest"
);
@@clientName(
  AllInstancesDown.automaticallyApprove,
  "AllInstancesDownAutomaticallyApprove",
  "!autorest"
);
@@clientName(
  ExecuteVdiCreateRequest,
  "BulkActionsExecuteVdiCreateRequestContent",
  "csharp"
);
@@clientName(
  ExecuteReimageRequest,
  "BulkActionsExecuteReimageRequestContent",
  "csharp"
);
@@clientName(
  ReimageResourceOperationResponse,
  "BulkActionsReimageResourceOperationResponseResult",
  "csharp"
);
@@clientName(
  ReimageResourceOperationResponse.type,
  "ResourceTypeName",
  "csharp"
);
@@clientName(
  VirtualMachineReimageParameters,
  "BulkActionsVirtualMachineReimageParametersContent",
  "csharp"
);
@@clientName(
  OSProfileProvisioningData,
  "BulkActionsOsProfileProvisioningContent",
  "csharp"
);

// =====================================================================
// .NET naming convention fixes (C# only)
// =====================================================================
@@clientName(
  BulkCreateCustomResource,
  "BulkCreateCustomResolvedItem",
  "csharp"
);
// Expand "Op" abbreviation to "Operation".
@@clientName(ResourceOperationDetails.opType, "operationKind", "csharp");
@@clientName(FallbackOperationInfo.lastOpType, "lastOperationKind", "csharp");
// Drop redundant type-name prefix; align with FallbackOperationInfo.error.
@@clientName(
  ResourceOperationDetails.resourceOperationError,
  "error",
  "csharp"
);
// Correct .NET casing for TimeZone.
@@clientName(ResourceOperationDetails.timezone, "timeZone", "csharp");

// C# only: expose subscriptionId as Guid? (UUID) while keeping the spec/OpenAPI type as string to avoid ARM GuidUsage lint.
@@alternateType(
  ResourceOperationDetails.subscriptionId,
  Azure.Core.uuid,
  "csharp"
);

@@clientName(ResourceOperationType, "ComputeBulkOperationKind", "csharp");
@@clientName(ResourceOperationDetails, "ComputeBulkOperationDetails", "csharp");
@@clientName(ResourceOperationDetails.deadline, "deadlineOn", "csharp");
@@clientName(ResourceOperationError, "ComputeBulkOperationError", "csharp");

@@clientName(
  FallbackOperationInfo,
  "ComputeBulkFallbackOperationInfo",
  "csharp"
);

// =====================================================================
// Fix: Go SDK Validation incorrectly detects networkApiVersion as an API version
// parameter because its name contains "apiversion". This causes
// the Go emitter to crash with "unexpected constant client side default
// 2026-04-15-preview for field NetworkAPIVersion". Override the heuristic.
// =====================================================================
@@apiVersion(NetworkProfile.networkApiVersion, false, "go");

#suppress "@azure-tools/typespec-client-generator-core/client-option" "Preserve type for public API surface"
#suppress "@azure-tools/typespec-client-generator-core/client-option-requires-scope" "Preserve type for public API surface"
@@clientOption(Resources, "disable-safe-flatten", true, "csharp");

#suppress "@azure-tools/typespec-client-generator-core/client-option" "Preserve type for public API surface"
#suppress "@azure-tools/typespec-client-generator-core/client-option-requires-scope" "Preserve type for public API surface"
@@clientOption(ExecutionParameters, "disable-safe-flatten", true, "csharp");

// ResourcesWithContext (added in 2026-07-06-preview) is a single-property model whose inner
// property would safe-flatten into a "Resources" member, colliding with the existing
// UserRequestResources "Resources" on the Execute*Content models. Disable safe-flatten to keep
// it as a distinct type and avoid the duplicate-member (CS0102) build break in the C# SDK.
#suppress "@azure-tools/typespec-client-generator-core/client-option" "Preserve type for public API surface"
#suppress "@azure-tools/typespec-client-generator-core/client-option-requires-scope" "Preserve type for public API surface"
@@clientOption(ResourcesWithContext, "disable-safe-flatten", true, "csharp");

@@clientName(CancelOperationsRequest, "CancelBulkOperationsContent", "csharp");
@@clientName(
  GetOperationStatusRequest,
  "GetBulkOperationStatusContent",
  "csharp"
);

// =====================================================================
// .NET Management SDK review (AZC0030) type-name fixes (C# only)
// =====================================================================
// SUFFIX010: "Update" is reserved for PATCH-body models; this is a merge-patch body.
@@clientName(
  ScheduledActionsScheduleUpdate,
  "ScheduledActionsSchedulePatch",
  "csharp"
);
// SUFFIX004: "Options" is reserved for ClientOptions subclasses.
@@clientName(DeleteOptions, "DeleteConfig", "csharp");
@@clientName(DiffDiskOptions, "DiffDiskConfig", "csharp");
// ACRONYM002: fix "Bulkaction" casing to match the "BulkAction*" prefix used package-wide.
@@clientName(BulkactionVMExtension, "BulkActionVMExtension", "csharp");
// ACRONYM001: 2-letter acronym "Vm" must be uppercase "VM".
@@clientName(
  BulkActionVmExtensionProperties,
  "BulkActionVMExtensionProperties",
  "csharp"
);
// ARMCOMMON001: avoid redefining the ARM-framework "ResourceType"; use a domain-scoped name.
@@clientName(ResourceType, "ScheduledActionsResourceType", "csharp");
// ARMCOMMON001: avoid redefining the ARM-framework "SubResource"; use a domain-scoped name.
// Suffix avoids ending in "Resource", which is reserved for ArmResource-derived types.
@@clientName(SubResource, "ComputeBulkActionsSubResourceInfo", "csharp");
// Contextual naming: "Language" is too generic and collides across packages.
@@clientName(Language, "ScheduledActionLanguage", "csharp");
// Contextual naming: scope the generic "ProvisioningState" to its operation.
@@clientName(
  ProvisioningState,
  "BulkInstancesOperationProvisioningState",
  "csharp"
);

// =====================================================================
// .NET Management SDK review (2nd pass) type-name fixes (C# only)
// =====================================================================
// ACRONYM002: fix "Bulkaction" casing to match the package-wide "BulkAction*" prefix.
@@clientName(BulkactionVMProperties, "BulkActionVMProperties", "csharp");

// ARM common-type conflict: local ResourceIdentityType is shape-identical to
// Azure.ResourceManager.Models.ResourceIdentityType; scope it to avoid ambiguous references.
@@clientName(ResourceIdentityType, "ComputeBulkActionsIdentityType", "csharp");

// ACRONYM001: acronym enum members must be PascalCase. exact() preserves the wire value.
@@clientName(
  AcceleratorType.GPU,
  Azure.ClientGenerator.Core.exact("Gpu"),
  "csharp"
);
@@clientName(
  AcceleratorType.FPGA,
  Azure.ClientGenerator.Core.exact("Fpga"),
  "csharp"
);
@@clientName(
  LocalStorageDiskType.HDD,
  Azure.ClientGenerator.Core.exact("Hdd"),
  "csharp"
);
@@clientName(
  LocalStorageDiskType.SSD,
  Azure.ClientGenerator.Core.exact("Ssd"),
  "csharp"
);

// BOOL001: boolean properties need a verb prefix (Is/Should/Does/etc.).
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
@@clientName(
  ExecutionParameters.verifyVmAgentHealth,
  "ShouldVerifyVmAgentHealth",
  "csharp"
);
@@clientName(VirtualMachineReimageParameters.tempDisk, "IsTempDisk", "csharp");
@@clientName(
  BulkActionVmExtensionProperties.autoUpgradeMinorVersion,
  "IsAutoUpgradeMinorVersion",
  "csharp"
);
@@clientName(
  BulkActionVmExtensionProperties.suppressFailures,
  "IsSuppressFailures",
  "csharp"
);
@@clientName(DataDisk.toBeDetached, "IsToBeDetached", "csharp");
@@clientName(
  DataDisk.writeAcceleratorEnabled,
  "IsWriteAcceleratorEnabled",
  "csharp"
);
@@clientName(
  LinuxConfiguration.provisionVMAgent,
  "IsProvisionVMAgent",
  "csharp"
);
@@clientName(
  LinuxVMGuestPatchAutomaticByPlatformSettings.bypassPlatformSafetyChecksOnUserSchedule,
  "ShouldBypassPlatformSafetyChecksOnUserSchedule",
  "csharp"
);
@@clientName(
  NetworkInterfaceReferenceProperties.primary,
  "IsPrimary",
  "csharp"
);
@@clientName(
  OSDisk.writeAcceleratorEnabled,
  "IsWriteAcceleratorEnabled",
  "csharp"
);
@@clientName(
  OSProfile.requireGuestProvisionSignal,
  "DoesRequireGuestProvisionSignal",
  "csharp"
);
@@clientName(
  ProxyAgentSettings.addProxyAgentExtension,
  "ShouldAddProxyAgentExtension",
  "csharp"
);
@@clientName(
  AllInstancesDown.automaticallyApprove,
  "IsAllInstancesDownAutomaticallyApproved",
  "csharp"
);
@@clientName(SecurityProfile.encryptionAtHost, "IsEncryptionAtHost", "csharp");
@@clientName(UefiSettings.secureBootEnabled, "IsSecureBootEnabled", "csharp");
@@clientName(UefiSettings.vTpmEnabled, "IsVTpmEnabled", "csharp");
@@clientName(
  VirtualMachineNetworkInterfaceConfigurationProperties.primary,
  "IsPrimary",
  "csharp"
);
@@clientName(
  VirtualMachineNetworkInterfaceIPConfigurationProperties.primary,
  "IsPrimary",
  "csharp"
);
@@clientName(
  VMGalleryApplication.treatFailureAsDeploymentFailure,
  "IsTreatFailureAsDeploymentFailure",
  "csharp"
);
@@clientName(
  WindowsConfiguration.provisionVMAgent,
  "IsProvisionVMAgent",
  "csharp"
);
@@clientName(
  WindowsVMGuestPatchAutomaticByPlatformSettings.bypassPlatformSafetyChecksOnUserSchedule,
  "ShouldBypassPlatformSafetyChecksOnUserSchedule",
  "csharp"
);

// =====================================================================
// .NET Management SDK review (AZC0030) suffix fixes (C# only)
// SUFFIX rules: "Request" -> "Content", "Response" -> "Result", "Parameters" -> "Content".
// =====================================================================
@@clientName(
  AcknowledgeBulkOperationErrorsRequest,
  "AcknowledgeBulkOperationErrorsRequestContent",
  "csharp"
);
@@clientName(
  AcknowledgeBulkOperationErrorsResponse,
  "AcknowledgeBulkOperationErrorsResponseResult",
  "csharp"
);
@@clientName(
  CancelOccurrenceRequest,
  "CancelOccurrenceRequestContent",
  "csharp"
);
@@clientName(DelayRequest, "DelayRequestContent", "csharp");
@@clientName(
  ScheduledActionsExecutionParameters,
  "ScheduledActionsExecutionParametersContent",
  "csharp"
);
@@clientName(ResourceAttachRequest, "ResourceAttachRequestContent", "csharp");
@@clientName(ResourceDetachRequest, "ResourceDetachRequestContent", "csharp");
@@clientName(
  ResourceOperationResponse,
  "ResourceOperationResponseResult",
  "csharp"
);
@@clientName(ResourcePatchRequest, "ResourcePatchRequestContent", "csharp");

// Model types must not end in "Resource" (reserved for ArmResource-derived classes);
// these plain models collide with the ScheduledAction/Occurrence ARM resource classes.
@@clientName(
  ScheduledActionResource,
  "ScheduledActionResourceMetadata",
  "csharp"
);
@@clientName(OccurrenceResource, "OccurrenceResourceMetadata", "csharp");
@@clientName(OccurrenceExtensionResource, "OccurrenceExtension", "csharp");

// APIView naming feedback: give the generic single-word resource/model/enum
// names an RP/domain prefix so they are self-descriptive in .NET IntelliSense.
@@clientName(Occurrence, "ScheduledActionOccurrence", "csharp");
@@clientName(DelayRequest.delay, "scheduleAt", "csharp");
@@clientName(Mode, "ProxyAgentMode", "csharp");
@@clientName(Modes, "ImdsAccessControlMode", "csharp");
