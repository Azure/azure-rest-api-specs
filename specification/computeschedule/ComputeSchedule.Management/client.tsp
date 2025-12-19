import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ComputeSchedule;
using Azure.ResourceManager;

@@clientName(Microsoft.ComputeSchedule, "ComputeScheduleMgmtClient", "python");
@@clientName(Microsoft.ComputeSchedule, "ComputeScheduleMgmtClient", "java");
@@clientNamespace(Microsoft.ComputeSchedule,
  "com.azure.resourcemanager.computeschedule",
  "java"
);

@@clientName(CancelOccurrenceRequest, "OccurrenceCancelContent", "csharp");
@@clientName(DelayRequest, "OccurrenceDelayContent", "csharp");
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
@@clientName(ExecuteDeleteRequest.correlationid,
  "correlationId",
  "csharp,javascript"
);
@@clientName(ExecuteDeleteRequest.forceDeletion, "IsForceDeletion", "csharp");
@@clientName(ExecuteCreateRequest.correlationid,
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
@@clientName(ScheduledActionResource, "ScheduledActionResourceData", "csharp");
@@clientName(OccurrenceResource, "OccurrenceResourceData", "csharp");
@@clientName(OccurrenceExtensionResource,
  "OccurrenceExtensionResourceData",
  "csharp"
);
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
@@clientName(ResourcePatchRequest,
  "ScheduledActionResourcePatchContent",
  "csharp"
);
@@clientName(ResourceStatus, "ScheduledActionResourceStatus", "csharp");
@@clientName(ResourceOperationStatus,
  "ScheduledActionResourceOperationStatus",
  "csharp"
);
@@clientName(ResourceType, "ScheduledActionResourceType", "csharp");

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
