import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Microsoft.Compute;

@@clientName(VirtualMachineBulkOperations.virtualMachinesExecuteDeallocate,
  "ExecuteVirtualMachineDeallocate",
  "csharp"
);
@@clientName(VirtualMachineBulkOperations.virtualMachinesExecuteHibernate,
  "ExecuteVirtualMachineHibernate",
  "csharp"
);
@@clientName(VirtualMachineBulkOperations.virtualMachinesExecuteStart,
  "ExecuteVirtualMachineStart",
  "csharp"
);
@@clientName(VirtualMachineBulkOperations.virtualMachinesGetOperationStatus,
  "GetVirtualMachineOperationStatus",
  "csharp"
);
@@clientName(VirtualMachineBulkOperations.virtualMachinesCancelOperations,
  "CancelVirtualMachineOperations",
  "csharp"
);
@@clientName(VirtualMachineBulkOperations.virtualMachinesExecuteCreate,
  "ExecuteVirtualMachineCreateOperation",
  "csharp"
);
@@clientName(VirtualMachineBulkOperations.virtualMachinesExecuteDelete,
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
@@clientName(ExecuteDeleteRequest.correlationid,
  "correlationId",
  "csharp,javascript,java,python"
);
@@clientName(ExecuteDeleteRequest.forceDeletion, "IsForceDeletion", "csharp");
@@clientName(ExecuteCreateRequest.correlationid,
  "correlationId",
  "csharp,javascript,java,python"
);
@@clientName(ExecuteDeallocateRequest.correlationid,
  "correlationId",
  "csharp,javascript,java,python"
);
@@clientName(ExecuteHibernateRequest.correlationid,
  "correlationId",
  "csharp,javascript,java,python"
);
@@clientName(ExecuteStartRequest.correlationid,
  "correlationId",
  "csharp,javascript,java,python"
);
@@clientName(GetOperationStatusRequest.correlationid,
  "correlationId",
  "csharp,javascript,java,python"
);
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
