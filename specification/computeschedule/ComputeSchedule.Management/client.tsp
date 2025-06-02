import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ComputeSchedule;

@@clientName(Microsoft.ComputeSchedule, "ComputeScheduleMgmt", "python");
@@clientName(Microsoft.ComputeSchedule, "ComputeScheduleMgmtClient", "java");
@@clientNamespace(Microsoft.ComputeSchedule,
  "com.azure.resourcemanager.computeschedule",
  "java"
);

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
