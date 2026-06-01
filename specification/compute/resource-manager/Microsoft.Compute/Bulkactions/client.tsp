import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Compute;

// Stub declarations for well-known ARM framework types referenced by
// `@@alternateType` directives below. The C# emitter recognizes these symbols
// by their cross-language definition ID (`Azure.ResourceManager.Models.*`) and
// maps them to framework types in the generated .NET SDK; the model bodies are
// intentionally empty.
namespace Azure.ResourceManager.Models {
  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Stub only — body unused; emitter resolves by cross-language definition id."
  model WritableSubResource {}
}

@@clientName(
  VirtualMachineBulkOperations.bulkDeallocate,
  "BulkDeallocateOperation",
  "csharp"
);
@@clientName(
  VirtualMachineBulkOperations.bulkHibernate,
  "BulkHibernateOperation",
  "csharp"
);
@@clientName(
  VirtualMachineBulkOperations.bulkStart,
  "BulkStartOperation",
  "csharp"
);
@@clientName(
  VirtualMachineBulkOperations.bulkGetOperationsStatus,
  "BulkGetOperationsStatus",
  "csharp"
);
@@clientName(
  VirtualMachineBulkOperations.bulkCancel,
  "BulkCancelOperations",
  "csharp"
);
@@clientName(
  VirtualMachineBulkOperations.bulkCreate,
  "BulkCreateOperation",
  "csharp"
);
@@clientName(
  VirtualMachineBulkOperations.bulkDelete,
  "BulkDeleteOperation",
  "csharp"
);
@@clientName(
  VirtualMachineBulkOperations.bulkReimage,
  "BulkReimageOperation",
  "csharp"
);
@@clientName(
  VirtualMachineBulkOperations.bulkVdiFlexCreate,
  "BulkVdiFlexCreateOperation",
  "csharp"
);

@@clientName(CancelOperationsResponse, "CancelOperationsResult", "csharp");
@@clientName(DeadlineType, "ScheduledActionDeadlineType", "csharp");
@@clientName(
  DeallocateResourceOperationResponse,
  "DeallocateResourceOperationResult",
  "csharp"
);
@@clientName(
  DeallocateResourceOperationResponse.type,
  "ResourceType",
  "csharp"
);
@@clientName(
  ExecutionParameters,
  "ScheduledActionExecutionParameterDetail",
  "csharp"
);
@@clientName(GetOperationStatusResponse, "GetOperationStatusResult", "csharp");
@@clientName(
  HibernateResourceOperationResponse,
  "HibernateResourceOperationResult",
  "csharp"
);
@@clientName(HibernateResourceOperationResponse.type, "ResourceType", "csharp");
@@clientName(OperationState, "ScheduledActionOperationState", "csharp");

@@clientName(ResourceOperation, "ResourceOperationResult", "csharp");
@@clientName(Resources, "UserRequestResources", "csharp");
@@clientName(RetryPolicy, "UserRequestRetryPolicy", "csharp");
@@clientName(
  StartResourceOperationResponse,
  "StartResourceOperationResult",
  "csharp"
);
@@clientName(StartResourceOperationResponse.type, "ResourceType", "csharp");
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
  CreateResourceOperationResponse,
  "CreateResourceOperationResult",
  "csharp"
);
@@clientName(ExecuteHibernateRequest, "ExecuteHibernateContent", "csharp");
@@clientName(ExecuteCreateRequest, "ExecuteCreateContent", "csharp");
@@clientName(ExecuteDeallocateRequest, "ExecuteDeallocateContent", "csharp");
@@clientName(ExecuteDeleteRequest, "ExecuteDeleteContent", "csharp");
@@clientName(ExecuteStartRequest, "ExecuteStartContent", "csharp");
@@clientName(GetOperationStatusRequest, "GetOperationStatusContent", "csharp");
@@clientName(CancelOperationsRequest, "CancelOperationsContent", "csharp");
@@clientName(ManagedDiskParameters, "ManagedDiskParametersContent", "csharp");
@@clientName(
  DiskEncryptionSetParameters,
  "DiskEncryptionSetParametersContent",
  "csharp"
);

@@clientName(
  UserInitiatedRedeploy.automaticallyApprove,
  "UserInitiatedRedeployAutomaticallyApprove",
  "csharp"
);
@@clientName(
  UserInitiatedReboot.automaticallyApprove,
  "UserInitiatedRebootAutomaticallyApprove",
  "csharp"
);
@@clientName(
  AllInstancesDown.automaticallyApprove,
  "AllInstancesDownAutomaticallyApprove",
  "csharp"
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
  "BulkActionsReimageResourceOperationResult",
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
// Fix: Go SDK Validation incorrectly detects networkApiVersion as an API version
// parameter because its name contains "apiversion". This causes
// the Go emitter to crash with "unexpected constant client side default
// 2026-04-15-preview for field NetworkAPIVersion". Override the heuristic.
// =====================================================================
@@apiVersion(NetworkProfile.networkApiVersion, false, "go");

// =====================================================================
// PR #59546 review-bot resolutions (C# emitter only)
// =====================================================================

// Suffix violations (SUFFIX001 / SUFFIX003)
@@clientName(DeleteOptions, "NetworkInterfaceDeleteBehavior", "csharp");
@@clientName(DiffDiskOptions, "DiffDiskOption", "csharp");

// RP prefix — align generic type names with Azure.ResourceManager.Compute SDK
// (ARMCOMMON001). Compute SDK already ships `ComputeAllocationStrategy`,
// `ComputeApiError`, and `ComputeApiErrorBase`; use the same names here so the
// concept is recognizable across the Compute SDK family.
@@clientName(AllocationStrategy, "ComputeAllocationStrategy", "csharp");
@@clientName(ApiError, "ComputeApiError", "csharp");
@@clientName(ApiErrorBase, "ComputeApiErrorBase", "csharp");

// Contextual naming
@@clientName(Mode, "ProxyAgentMode", "csharp");
@@clientName(Modes, "HostEndpointMode", "csharp");
@@clientName(VirtualMachine, "BulkActionsVirtualMachineInfo", "csharp");

// Contextual naming
@@clientName(
  ProvisioningState,
  "LaunchBulkInstancesOperationProvisioningState",
  "csharp"
);
@@clientName(Placement, "ComputeBulkActionsPlacement", "csharp");
@@clientName(FlexProperties, "BulkActionsVdiFlexProperties", "csharp");
@@clientName(SettingNames, "AdditionalUnattendContentSettingName", "csharp");
@@clientName(PatchSettings, "WindowsPatchSettings", "csharp");

// Boolean property prefixes (BOOL001) ---
@@clientName(VirtualMachineReimageParameters.tempDisk, "isTempDisk", "csharp");
@@clientName(DataDisk.toBeDetached, "isToBeDetached", "csharp");
@@clientName(
  LinuxConfiguration.provisionVMAgent,
  "shouldProvisionVmAgent",
  "csharp"
);

@@clientName(
  WindowsConfiguration.provisionVMAgent,
  "shouldProvisionVmAgent",
  "csharp"
);
@@clientName(
  NetworkInterfaceReferenceProperties.primary,
  "isPrimary",
  "csharp"
);
@@clientName(
  VirtualMachineNetworkInterfaceConfigurationProperties.primary,
  "isPrimary",
  "csharp"
);
@@clientName(
  VirtualMachineNetworkInterfaceIPConfigurationProperties.primary,
  "isPrimary",
  "csharp"
);
@@clientName(
  OSProfile.requireGuestProvisionSignal,
  "isGuestProvisionSignalRequired",
  "csharp"
);
@@clientName(
  SecurityProfile.encryptionAtHost,
  "isEncryptionAtHostEnabled",
  "csharp"
);
@@clientName(
  VMGalleryApplication.treatFailureAsDeploymentFailure,
  "shouldTreatFailureAsDeploymentFailure",
  "csharp"
);
@@clientName(
  BulkActionVmExtensionProperties.suppressFailures,
  "shouldSuppressFailures",
  "csharp"
);

// ARM common-type mappings via @@alternateType ---
// SubResource -> WritableSubResource (model-level; fall back to per-property
@@alternateType(
  SubResource,
  Azure.ResourceManager.Models.WritableSubResource,
  "csharp"
);

// Identity types -> ARM framework equivalents.
@@alternateType(
  VirtualMachineIdentity,
  Azure.ResourceManager.Foundations.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(
  UserAssignedIdentitiesValue,
  Azure.ResourceManager.Foundations.UserAssignedIdentity,
  "csharp"
);
@@alternateType(
  ResourceIdentityType,
  Azure.ResourceManager.Foundations.ManagedServiceIdentityType,
  "csharp"
);
