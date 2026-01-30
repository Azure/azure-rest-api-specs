import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
using Azure.ResourceManager;
using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

namespace Microsoft.ComputeBulkActions;

// --------------- Request Body Naming ---------------

@@clientName(BulkActions.virtualMachinesSubmitDeallocate::parameters.body,
  "requestBody"
);
@@doc(BulkActions.virtualMachinesSubmitDeallocate::parameters.body,
  "The request body"
);
@@clientName(BulkActions.virtualMachinesSubmitHibernate::parameters.body,
  "requestBody"
);
@@doc(BulkActions.virtualMachinesSubmitHibernate::parameters.body,
  "The request body"
);
@@clientName(BulkActions.virtualMachinesSubmitStart::parameters.body,
  "requestBody"
);
@@doc(BulkActions.virtualMachinesSubmitStart::parameters.body,
  "The request body"
);
@@clientName(BulkActions.virtualMachinesExecuteDeallocate::parameters.body,
  "requestBody"
);
@@doc(BulkActions.virtualMachinesExecuteDeallocate::parameters.body,
  "The request body"
);
@@clientName(BulkActions.virtualMachinesExecuteHibernate::parameters.body,
  "requestBody"
);
@@doc(BulkActions.virtualMachinesExecuteHibernate::parameters.body,
  "The request body"
);
@@clientName(BulkActions.virtualMachinesExecuteStart::parameters.body,
  "requestBody"
);
@@doc(BulkActions.virtualMachinesExecuteStart::parameters.body,
  "The request body"
);
@@clientName(BulkActions.virtualMachinesExecuteCreate::parameters.body,
  "requestBody"
);
@@doc(BulkActions.virtualMachinesExecuteCreate::parameters.body,
  "The request body"
);
@@clientName(BulkActions.virtualMachinesExecuteDelete::parameters.body,
  "requestBody"
);
@@doc(BulkActions.virtualMachinesExecuteDelete::parameters.body,
  "The request body"
);
@@clientName(BulkActions.virtualMachinesGetOperationStatus::parameters.body,
  "requestBody"
);
@@doc(BulkActions.virtualMachinesGetOperationStatus::parameters.body,
  "The request body"
);
@@clientName(BulkActions.virtualMachinesCancelOperations::parameters.body,
  "requestBody"
);
@@doc(BulkActions.virtualMachinesCancelOperations::parameters.body,
  "The request body"
);
@@clientName(BulkActions.virtualMachinesGetOperationErrors::parameters.body,
  "requestBody"
);
@@doc(BulkActions.virtualMachinesGetOperationErrors::parameters.body,
  "The request body"
);

// ------------------ Enums ---------------
@doc("The types of deadlines supported by Bulkactions")
union DeadlineType {
  @doc("Default value of Unknown.")
  Unknown: "Unknown",

  @doc("Initiate the operation at the given deadline.")
  InitiateAt: "InitiateAt",

  @doc("Complete the operation by the given deadline.")
  CompleteBy: "CompleteBy",

  string,
}

@doc("The preferences customers can select to optimize their requests to Bulkactions")
union OptimizationPreference {
  @doc("Optimize while considering cost savings")
  Cost: "Cost",

  @doc("Optimize while considering availability of resources")
  Availability: "Availability",

  @doc("Optimize while considering a balance of cost and availability")
  CostAvailabilityBalanced: "CostAvailabilityBalanced",

  string,
}

@doc("The kind of operation types that can be performed on resources eg Virtual Machines, using BulkActions")
union ResourceOperationType {
  @doc("The default value for this enum type")
  Unknown: "Unknown",

  @doc("Start operations on the resources")
  Start: "Start",

  @doc("Deallocate operations on the resources")
  Deallocate: "Deallocate",

  @doc("Hibernate operations on the resources")
  Hibernate: "Hibernate",

  @doc("Create operations on the resources")
  Create: "Create",

  @doc("Delete operations on the resources")
  Delete: "Delete",

  string,
}

@doc("Values that define the states of operations in BulkActions")
union OperationState {
  @doc("The default value for the operation state enum")
  Unknown: "Unknown",

  @doc("Operations that are pending scheduling")
  PendingScheduling: "PendingScheduling",

  @doc("Operations that have been scheduled")
  Scheduled: "Scheduled",

  @doc("Operations that are waiting to be executed")
  PendingExecution: "PendingExecution",

  @doc("Operations that are in the process of being executed")
  Executing: "Executing",

  @doc("Operations that succeeded")
  Succeeded: "Succeeded",

  @doc("Operations that have failed")
  Failed: "Failed",

  @doc("Operations that have been Cancelled by the user")
  Cancelled: "Cancelled",

  @doc("Operations that are blocked")
  Blocked: "Blocked",

  string,
}

// ------------------ Models ---------------
@doc("Describes the fallback operation that was performed")
model FallbackOperation {
  @doc("The last operation type that was performed as a fallback")
  lastOpType?: ResourceOperationType;

  @doc("The status of the fallback operation")
  status?: string;
}

@doc("The schedule details for the user request")
model Schedule {
  #suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Prefer using `offsetDateTime` when representing a datetime."
  @doc("The deadline for the operation")
  deadline?: offsetDateTime;

  @doc("The timezone for the operation")
  timezone?: string;

  @doc("The deadlinetype of the operation, this can either be InitiateAt or CompleteBy")
  deadlineType: DeadlineType = DeadlineType.Unknown;
}

@doc("The resources needed for the user request")
model Resources {
  @doc("The resource ids used for the request")
  ids: Array<armResourceIdentifier<[
    {
      type: "Microsoft.Compute/vm";
    }
  ]>>;
}

@doc("The resources needed for the user request with the correlationId")
model ResourceWithContext {
  @doc("The resource ids used for the request")
  id: armResourceIdentifier<[
    {
      type: "Microsoft.Compute/vm";
    }
  ]>;

  @doc("The operational context of the resourceId")
  context: string;
}

@doc("The resources needed for the user request with the context for tracking purposes")
model ResourcesWithContext {
  @doc("The resource ids used for the request")
  ids: Array<ResourceWithContext>;
}

@doc("Resource creation data model")
model ResourceProvisionPayload {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "reviewed this with ARM, we are a pass through to compute RP and doing any property specific validation, compute RP will do that."
  @doc("JSON object that contains VM properties that are common across all VMs in this batch (if you want to create 100 VMs in this request, and they all have same vmSize, then include vmSize in baseProfile)")
  baseProfile?: Record<unknown>;

  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "reviewed this with ARM, we are a pass through to compute RP and doing any property specific validation, compute RP will do that."
  @doc("JSON array, that contains VM properties that should to be overridden for each VM in the batch (if you want to create 100 VMs, they all need a distinct computerName property, you pass computerNames for each VM in batch in this array), service will merge baseProfile with VM specific overrides and create a merged VMProfile.")
  resourceOverrides?: Record<unknown>[];

  @doc("Number of VMs to be created")
  resourceCount: int32;

  @doc("if resourceOverrides doesn't contain \"name\", service will create name based of prefix and ResourceCount e.g. resourceprefix-0,resourceprefix-1..")
  resourcePrefix?: string;
}

@doc("The retry policy for the user request")
model RetryPolicy {
  @doc("Retry count for user request")
  retryCount?: int32;

  @doc("Retry window in minutes for user request")
  retryWindowInMinutes?: int32;

  @removed(Microsoft.ComputeBulkActions.Versions.`2026-02-01-preview`)
  @doc("Action to take on failed retries for user request")
  onFailureAction?: ResourceOperationType;
}

@doc("Extra details needed to run the user's request")
model ExecutionParameters {
  @doc("Details that could optimize the user's request")
  optimizationPreference?: OptimizationPreference;

  @doc("Retry policy the user can pass")
  retryPolicy?: RetryPolicy;
}

@doc("These describe errors that occur at the resource level")
model ResourceOperationError {
  @doc("Code for the error eg 404, 500")
  errorCode: string;

  @doc("Detailed message about the error")
  errorDetails: string;
}

@doc("The details of a response from an operation on a resource")
model ResourceOperationDetails {
  @doc("Operation identifier for the unique operation")
  operationId: string;

  @doc("Unique identifier for the resource involved in the operation, eg Azure Resource Manager ID")
  resourceId?: armResourceIdentifier<[
    {
      type: "Microsoft.Compute/vm";
    }
  ]>;

  @doc("Type of operation performed on the resources")
  opType?: ResourceOperationType = ResourceOperationType.Unknown;

  @doc("Subscription id attached to the request")
  subscriptionId?: string;

  #suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Prefer using `offsetDateTime` when representing a datetime."
  @doc("Deadline for the operation")
  deadline?: offsetDateTime;

  @doc("Type of deadline of the operation")
  deadlineType?: DeadlineType = DeadlineType.Unknown;

  @doc("Current state of the operation")
  state?: OperationState = OperationState.Unknown;

  @doc("Timezone for the operation")
  timezone?: string;

  @doc("Operation level errors if they exist")
  resourceOperationError?: ResourceOperationError;

  #suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Prefer using `offsetDateTime` when representing a datetime."
  @doc("Time the operation was complete if errors are null")
  completedAt?: offsetDateTime;

  @doc("Retry policy the user can pass")
  retryPolicy?: RetryPolicy;

  @removed(Microsoft.ComputeBulkActions.Versions.`2026-02-01-preview`)
  @doc("Resource notification details.")
  resourceNotificationDetails?: ResourceNotificationDetails;

  @removed(Microsoft.ComputeBulkActions.Versions.`2026-02-01-preview`)
  @doc("Fallback operation details if a fallback was performed")
  fallbackOperation?: FallbackOperation;
}

@doc("Top level response from an operation on a resource")
model ResourceOperation {
  @doc("Unique identifier for the resource involved in the operation, eg Azure Resource Manager ID")
  resourceId?: armResourceIdentifier<[
    {
      type: "Microsoft.Compute/vm";
    }
  ]>;

  @doc("Resource level error code if it exists")
  errorCode?: string;

  @doc("Resource level error details if they exist")
  errorDetails?: string;

  @doc("Details of the operation performed on a resource")
  operation?: ResourceOperationDetails;
}

#suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Prefer using `offsetDateTime` when representing a datetime."
@doc("This defines a list of operation errors associated with a unique operationId")
model OperationErrorDetails {
  @doc("The error code of the operation")
  errorCode: string;

  @doc("The error details of the operation")
  errorDetails: string;

  @doc("The timestamp of the error occurrence")
  timestamp?: offsetDateTime;

  @doc("The compute operationid of the Start/Deallocate/Hibernate request")
  azureOperationName?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Prefer using `offsetDateTime` when representing a datetime."
@doc("This is the first level of operation errors from the request when clients get errors per vm operation")
model OperationErrorsResult {
  @doc("The operationId identifying a vm operation")
  operationId?: string;

  @doc("The creation time of the error result, returned in UTC datetimeoffset format")
  creationTime?: offsetDateTime;

  @doc("The activation time of a Virtual Machine operation, returned in UTC datetimeoffset format")
  activationTime?: offsetDateTime;

  @doc("The completion time of the operation if the operation was completed, returned in UTC datetimeoffset format")
  completedAt?: offsetDateTime;

  @identifiers(#[])
  @doc("A list of errors associated with the operationid")
  operationErrors?: Array<OperationErrorDetails>;

  @doc("Request level error code")
  requestErrorCode?: string;

  @doc("Request level error details")
  requestErrorDetails?: string;
}

// ------------------ Common Models ---------------
@doc("The common request model for power operations")
model ResourceNotificationDetails {
  @doc("Operation context for notification tracking")
  operationContext?: string;
}

@doc("The submit-type request for power operations")
model SubmitTypeRequest {
  @doc("The schedule for the request")
  schedule: Schedule;

  @doc("The execution parameters for the request")
  executionParameters: ExecutionParameters;

  @doc("The resources for the request")
  resources?: Resources;

  @removed(Microsoft.ComputeBulkActions.Versions.`2026-02-01-preview`)
  @doc("The resources for the request with operation context information needed for notification tracking.")
  resourcesWithContext?: ResourcesWithContext;

  @doc("CorrelationId item")
  correlationid: string;
}

@doc("The execute-type request for power operations")
model ExecuteTypeRequest {
  @doc("The execution parameters for the request")
  executionParameters: ExecutionParameters;

  @doc("The resources for the request")
  resources?: Resources;

  @removed(Microsoft.ComputeBulkActions.Versions.`2026-02-01-preview`)
  @doc("The resources for the request with operation context information")
  resourcesWithContext?: ResourcesWithContext;

  @doc("CorrelationId item")
  correlationid: string;
}

@doc("Common model for operation response")
model OperationResponse {
  @doc("The description of the operation response")
  description: string;

  @doc("The type of resources used in the request eg virtual machines")
  type: string;

  @doc("The location of the request eg westus")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: azureLocation;

  @identifiers(#["resourceId"])
  @doc("The results from the request.")
  results?: Array<ResourceOperation>;
}

// ----------- SubmitDeallocate ---------
@doc("The deallocate request for resources")
model SubmitDeallocateRequest {
  ...SubmitTypeRequest;
}

@doc("The response from a deallocate request")
model DeallocateResourceOperationResponse {
  ...OperationResponse;
}

// ----------- SubmitStart ---------
@doc("This is the request for start")
model SubmitStartRequest {
  ...SubmitTypeRequest;
}

@doc("The response from a start request")
model StartResourceOperationResponse {
  ...OperationResponse;
}

// ----------- SubmitHibernate ---------
@doc("This is the request for hibernate")
model SubmitHibernateRequest {
  ...SubmitTypeRequest;
}

@doc("The response from a Hibernate request")
model HibernateResourceOperationResponse {
  ...OperationResponse;
}

// ----------- Execute Operations Request ---------
@doc("The ExecuteDeallocateRequest request for executeDeallocate operations")
model ExecuteDeallocateRequest {
  ...ExecuteTypeRequest;
}

@doc("The ExecuteHibernateRequest request for executeHibernate operations")
model ExecuteHibernateRequest {
  ...ExecuteTypeRequest;
}

@doc("The ExecuteStartRequest request for executeStart operations")
model ExecuteStartRequest {
  ...ExecuteTypeRequest;
}

@doc("The ExecuteCreateRequest request for create operations")
model ExecuteCreateRequest {
  @doc("resource creation payload")
  resourceConfigParameters: ResourceProvisionPayload;

  @doc("The execution parameters for the request")
  executionParameters: ExecutionParameters;

  @doc("CorrelationId item")
  correlationid?: string;
}

@doc("The response from a create request")
model CreateResourceOperationResponse {
  ...OperationResponse;
}

@doc("The response from a delete request")
model DeleteResourceOperationResponse {
  ...OperationResponse;
}

@doc("The ExecuteDeleteRequest for delete VM operation")
model ExecuteDeleteRequest {
  ...ExecuteTypeRequest;

  @doc("Forced delete resource item")
  forceDeletion?: boolean;
}

// ----------- GetOperationStatus ---------
@doc("This is the request to get operation status using operationids")
model GetOperationStatusRequest {
  @doc("The list of operation ids to get the status of")
  operationIds: Array<string>;

  @doc("CorrelationId item")
  correlationid: string;
}

@doc("This is the response from a get operations status request")
model GetOperationStatusResponse {
  @identifiers(#["resourceId"])
  @doc("An array of resource operations based on their operation ids")
  results: Array<ResourceOperation>;
}

// ----------- CancelOperations ---------
@doc("This is the request to cancel running operations in bulkactions using the operation ids")
model CancelOperationsRequest {
  @doc("The list of operation ids to cancel operations on")
  operationIds: Array<string>;

  @doc("CorrelationId item")
  correlationid: string;
}

@doc("This is the response from a cancel operations request")
model CancelOperationsResponse {
  @identifiers(#["resourceId"])
  @doc("An array of resource operations that were successfully cancelled")
  results: Array<ResourceOperation>;
}

// ----------- GetOperationErrors ---------
@doc("This is the request to get errors per vm operations")
model GetOperationErrorsRequest {
  @doc("The list of operation ids to query errors of")
  operationIds: Array<string>;
}

@doc("This is the response from a get operations errors request")
model GetOperationErrorsResponse {
  @identifiers(#["operationId"])
  @doc("An array of operationids and their corresponding errors if any")
  results: Array<OperationErrorsResult>;
}
