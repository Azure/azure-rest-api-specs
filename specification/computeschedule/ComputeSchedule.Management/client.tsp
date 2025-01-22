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

@@clientName(SubmitDeallocateRequest.correlationid, "correlationId", "csharp");
@@clientName(SubmitStartRequest.correlationid, "correlationId", "csharp");
@@clientName(SubmitHibernateRequest.correlationid, "correlationId", "csharp");
@@clientName(ExecuteDeallocateRequest.correlationid, "correlationId", "csharp");
@@clientName(ExecuteHibernateRequest.correlationid, "correlationId", "csharp");
@@clientName(ExecuteStartRequest.correlationid, "correlationId", "csharp");
@@clientName(GetOperationStatusRequest.correlationid,
  "correlationId",
  "csharp"
);
@@clientName(CancelOperationsRequest.correlationid, "correlationId", "csharp");
@@clientName(Schedule.deadLine, "userRequestDeadline", "csharp");
@@clientName(Schedule.timeZone, "userRequestTimezone", "csharp");
@@clientName(ResourceOperationDetails.timeZone, "operationTimezone", "csharp");
@@clientName(OperationErrorDetails.timeStamp,
  "errorDetailsTimestamp",
  "csharp"
);
