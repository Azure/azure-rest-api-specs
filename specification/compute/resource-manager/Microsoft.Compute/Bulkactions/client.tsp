import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Microsoft.Compute;

@@clientName(VirtualMachineBulkOperations.virtualMachinesBulkDeallocate,
  "ExecuteVirtualMachineDeallocate",
  "csharp"
);
@@clientName(VirtualMachineBulkOperations.virtualMachinesBulkHibernate,
  "ExecuteVirtualMachineHibernate",
  "csharp"
);
@@clientName(VirtualMachineBulkOperations.virtualMachinesBulkStart,
  "ExecuteVirtualMachineStart",
  "csharp"
);
@@clientName(VirtualMachineBulkOperations.virtualMachinesBulkGetOperationStatus,
  "GetVirtualMachineOperationStatus",
  "csharp"
);
@@clientName(VirtualMachineBulkOperations.virtualMachinesBulkCancelOperations,
  "CancelVirtualMachineOperations",
  "csharp"
);
@@clientName(VirtualMachineBulkOperations.virtualMachinesBulkCreate,
  "ExecuteVirtualMachineCreateOperation",
  "csharp"
);
@@clientName(VirtualMachineBulkOperations.virtualMachinesBulkDelete,
  "ExecuteVirtualMachineDeleteOperation",
  "csharp"
);

@@clientName(CancelOperationsResponse, "CancelOperationsResult", "csharp");
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
@@clientName(GetOperationStatusResponse, "GetOperationStatusResult", "csharp");
@@clientName(HibernateResourceOperationResponse,
  "HibernateResourceOperationResult",
  "csharp"
);
@@clientName(HibernateResourceOperationResponse.type, "ResourceType", "csharp");
@@clientName(OperationState, "ScheduledActionOperationState", "csharp");

@@clientName(ResourceOperation, "ResourceOperationResult", "csharp");
@@clientName(Resources, "UserRequestResources", "csharp");
@@clientName(RetryPolicy, "UserRequestRetryPolicy", "csharp");
@@clientName(StartResourceOperationResponse,
  "StartResourceOperationResult",
  "csharp"
);
@@clientName(StartResourceOperationResponse.type, "ResourceType", "csharp");
@@clientName(ExecuteDeleteRequest.forceDeletion, "IsForceDeletion", "csharp");
@@clientName(OperationErrorDetails.timeStamp,
  "errorDetailsTimestamp",
  "csharp,javascript,java,python"
);

@@clientName(DeleteResourceOperationResponse,
  "DeleteResourceOperationResult",
  "csharp"
);
@@clientName(CreateResourceOperationResponse,
  "CreateResourceOperationResult",
  "csharp"
);
@@clientName(ExecuteHibernateRequest, "ExecuteHibernateContent");
@@clientName(ExecuteCreateRequest, "ExecuteCreateContent");
@@clientName(ExecuteDeallocateRequest, "ExecuteDeallocateContent");
@@clientName(ExecuteDeleteRequest, "ExecuteDeleteContent");
@@clientName(ExecuteStartRequest, "ExecuteStartContent");
@@clientName(GetOperationStatusRequest, "GetOperationStatusContent");
@@clientName(CancelOperationsRequest, "CancelOperationsContent");
@@clientName(ManagedDiskParameters, "ManagedDiskParametersContent");
@@clientName(DiskEncryptionSetParameters, "DiskEncryptionSetParametersContent");

@@clientName(UserInitiatedRedeploy.automaticallyApprove,
  "UserInitiatedRedeployAutomaticallyApprove"
);
@@clientName(UserInitiatedReboot.automaticallyApprove,
  "UserInitiatedRebootAutomaticallyApprove"
);
@@clientName(AllInstancesDown.automaticallyApprove,
  "AllInstancesDownAutomaticallyApprove"
);
