import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Microsoft.Compute;

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
@@clientName(VirtualMachineBulkOperations.bulkStart, "BulkStartOperation", "!autorest");
@@clientName(
  VirtualMachineBulkOperations.bulkGetOperationsStatus,
  "BulkGetOperationsStatus",
  "!autorest"
);
@@clientName(VirtualMachineBulkOperations.bulkCancel, "BulkCancelOperations", "!autorest");
@@clientName(VirtualMachineBulkOperations.bulkCreate, "BulkCreateOperation", "!autorest");
@@clientName(VirtualMachineBulkOperations.bulkDelete, "BulkDeleteOperation", "!autorest");
@@clientName(VirtualMachineBulkOperations.bulkReimage, "BulkReimageOperation", "!autorest");
@@clientName(
  VirtualMachineBulkOperations.bulkVdiFlexCreate,
  "BulkVdiFlexCreateOperation",
  "!autorest"
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
@@clientName(ExecuteHibernateRequest, "ExecuteHibernateContent", "!autorest");
@@clientName(ExecuteCreateRequest, "ExecuteCreateContent", "!autorest");
@@clientName(ExecuteDeallocateRequest, "ExecuteDeallocateContent", "!autorest");
@@clientName(ExecuteDeleteRequest, "ExecuteDeleteContent", "!autorest");
@@clientName(ExecuteStartRequest, "ExecuteStartContent", "!autorest");
@@clientName(GetOperationStatusRequest, "GetOperationStatusContent", "!autorest");
@@clientName(CancelOperationsRequest, "CancelOperationsContent", "!autorest");
@@clientName(ManagedDiskParameters, "ManagedDiskParametersContent", "!autorest");
@@clientName(DiskEncryptionSetParameters, "DiskEncryptionSetParametersContent", "!autorest");

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
