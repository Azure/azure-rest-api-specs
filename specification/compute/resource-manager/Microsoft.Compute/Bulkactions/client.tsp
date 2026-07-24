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
@@clientName(Microsoft.Compute.InnerError, "BulkInstancesInnerError", "python");

@@clientName(CancelOperationsResponse, "CancelBulkOperationsResult", "csharp");
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

@@clientName(CancelOperationsRequest, "CancelBulkOperationsContent", "csharp");
@@clientName(
  GetOperationStatusRequest,
  "GetBulkOperationStatusContent",
  "csharp"
);
