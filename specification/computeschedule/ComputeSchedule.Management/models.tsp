import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.ComputeSchedule;

// ------------------ Enums ---------------
@doc("The types of deadlines supported by ScheduledActions")
union DeadlineType {
  @doc("Default value of Unknown.")
  Unknown: "Unknown",

  @doc("Initiate the operation at the given deadline.")
  InitiateAt: "InitiateAt",

  @doc("Complete the operation by the given deadline.")
  CompleteBy: "CompleteBy",

  string,
}

@doc("The preferences customers can select to optimize their requests to ScheduledActions")
union OptimizationPreference {
  @doc("Optimize while considering cost savings")
  Cost: "Cost",

  @doc("Optimize while considering availability of resources")
  Availability: "Availability",

  @doc("Optimize while considering a balance of cost and availability")
  CostAvailabilityBalanced: "CostAvailabilityBalanced",

  string,
}

@doc("The kind of operation types that can be performed on resources using ScheduledActions")
union ResourceOperationType {
  @doc("The default value for this enum type")
  Unknown: "Unknown",

  @doc("Start operations on the resources")
  Start: "Start",

  @doc("Deallocate operations on the resources")
  Deallocate: "Deallocate",

  @doc("Hibernate operations on the resources")
  Hibernate: "Hibernate",

  string,
}

@doc("Values that define the states of operations in Scheduled Actions")
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

  @doc("Operations that suceeded")
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
@doc("The schedule details for the user request")
model Schedule {
  #suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Prefer using `utcDateTime` when representing a datetime unless an offset is necessary."
  @added(Microsoft.ComputeSchedule.Versions.`2024-10-01`)
  @doc("The deadline for the operation")
  deadline?: offsetDateTime;

  #suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Prefer using `utcDateTime` when representing a datetime unless an offset is necessary."
  @added(Microsoft.ComputeSchedule.Versions.`2024-08-15-preview`)
  @doc("The deadline for the operation")
  deadLine?: offsetDateTime;

  @added(Microsoft.ComputeSchedule.Versions.`2024-10-01`)
  @doc("The timezone for the operation")
  timezone?: string;

  @added(Microsoft.ComputeSchedule.Versions.`2024-08-15-preview`)
  @doc("The timezone for the operation")
  timeZone?: string;

  @doc("The deadlinetype of the operation, this can either be InitiateAt or CompleteBy")
  deadlineType: DeadlineType = DeadlineType.Unknown;
}

@doc("The resources needed for the user request")
model Resources {
  @doc("The resource ids used for the request")
  ids: Array<armResourceIdentifier>;
}

@added(Microsoft.ComputeSchedule.Versions.`2025-05-01`)
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

  @doc("Unique identifier for the resource involved in the operation, eg ArmId")
  resourceId?: armResourceIdentifier;

  @doc("Type of operation performed on the resources")
  opType?: ResourceOperationType = ResourceOperationType.Unknown;

  @doc("Subscription id attached to the request")
  subscriptionId?: string;

  #suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Prefer using `utcDateTime` when representing a datetime unless an offset is necessary."
  @doc("Deadline for the operation")
  deadline?: offsetDateTime;

  @doc("Type of deadline of the operation")
  deadlineType?: DeadlineType = DeadlineType.Unknown;

  @doc("Current state of the operation")
  state?: OperationState = OperationState.Unknown;

  @added(Microsoft.ComputeSchedule.Versions.`2024-10-01`)
  @doc("Timezone for the operation")
  timezone?: string;

  @added(Microsoft.ComputeSchedule.Versions.`2024-08-15-preview`)
  @doc("Timezone for the operation")
  timeZone?: string;

  @doc("Operation level errors if they exist")
  resourceOperationError?: ResourceOperationError;

  #suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Prefer using `utcDateTime` when representing a datetime unless an offset is necessary."
  @doc("Time the operation was complete if errors are null")
  completedAt?: offsetDateTime;

  @doc("Retry policy the user can pass")
  retryPolicy?: RetryPolicy;
}

@doc("High level response from an operation on a resource")
model ResourceOperation {
  @doc("Unique identifier for the resource involved in the operation, eg ArmId")
  resourceId?: armResourceIdentifier;

  @doc("Resource level error code if it exists")
  errorCode?: string;

  @doc("Resource level error details if they exist")
  errorDetails?: string;

  @doc("Details of the operation performed on a resource")
  operation?: ResourceOperationDetails;
}

#suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Prefer using `utcDateTime` when representing a datetime unless an offset is necessary."
@doc("This defines a list of operation errors associated with a unique operationId")
model OperationErrorDetails {
  @doc("The error code of the operation")
  errorCode: string;

  @doc("The error details of the operation")
  errorDetails: string;

  @added(Microsoft.ComputeSchedule.Versions.`2024-10-01`)
  @doc("The timestamp of the error occurence")
  timestamp?: offsetDateTime;

  @added(Microsoft.ComputeSchedule.Versions.`2024-08-15-preview`)
  @doc("The timestamp of the error occurence")
  timeStamp?: offsetDateTime;

  @added(Microsoft.ComputeSchedule.Versions.`2024-10-01`)
  @doc("The compute operationid of the Start/Deallocate/Hibernate request")
  azureOperationName?: string;

  @added(Microsoft.ComputeSchedule.Versions.`2024-08-15-preview`)
  @doc("The compute operationid of the Start/Deallocate/Hibernate request")
  crpOperationId?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Prefer using `utcDateTime` when representing a datetime unless an offset is necessary."
@doc("This is the first level of operation errors from the request when clients get errors per vm operation")
model OperationErrorsResult {
  @doc("The operationId identifying a vm operation")
  operationId?: string;

  @doc("The creation time of the error result")
  creationTime?: offsetDateTime;

  @doc("The activation time of a vm operation")
  activationTime?: offsetDateTime;

  @doc("The completion time of the operation if the operation was completed")
  completedAt?: offsetDateTime;

  @identifiers(#[])
  @doc("A list of errors associated with the operationid")
  operationErrors?: Array<OperationErrorDetails>;

  @doc("Request level error code")
  requestErrorCode?: string;

  @doc("Request level error details")
  requestErrorDetails?: string;
}

// ----------- SubmitDeallocate ---------
@doc("The deallocate request for resources")
model SubmitDeallocateRequest {
  @doc("The schedule for the request")
  schedule: Schedule;

  @doc("The execution parameters for the request")
  executionParameters: ExecutionParameters;

  @doc("The resources for the request")
  resources: Resources;

  @doc("CorrelationId item")
  correlationid: string;
}

@doc("The response from a deallocate request")
model DeallocateResourceOperationResponse {
  @doc("The description of the operation response")
  description: string;

  @doc("The type of resources used in the deallocate request eg virtual machines")
  type: string;

  @doc("The location of the deallocate request eg westus")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: azureLocation;

  @identifiers(#["resourceId"])
  @doc("The results from the deallocate request if no errors exist")
  results?: Array<ResourceOperation>;
}

// ----------- SubmitStart ---------
@doc("This is the request for start")
model SubmitStartRequest {
  @doc("The schedule for the request")
  schedule: Schedule;

  @doc("The execution parameters for the request")
  executionParameters: ExecutionParameters;

  @doc("The resources for the request")
  resources: Resources;

  @doc("CorrelationId item")
  correlationid: string;
}

@doc("The response from a start request")
model StartResourceOperationResponse {
  @doc("The description of the operation response")
  description: string;

  @doc("The type of resources used in the start request eg virtual machines")
  type: string;

  @doc("The location of the start request eg westus")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: azureLocation;

  @identifiers(#["resourceId"])
  @doc("The results from the start request if no errors exist")
  results?: Array<ResourceOperation>;
}

// ----------- SubmitHibernate ---------
@doc("This is the request for hibernate")
model SubmitHibernateRequest {
  @doc("The schedule for the request")
  schedule: Schedule;

  @doc("The execution parameters for the request")
  executionParameters: ExecutionParameters;

  @doc("The resources for the request")
  resources: Resources;

  @doc("CorrelationId item")
  correlationid: string;
}

@doc("The response from a Hibernate request")
model HibernateResourceOperationResponse {
  @doc("The description of the operation response")
  description: string;

  @doc("The type of resources used in the Hibernate request eg virtual machines")
  type: string;

  @doc("The location of the Hibernate request eg westus")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: azureLocation;

  @identifiers(#["resourceId"])
  @doc("The results from the Hibernate request if no errors exist")
  results?: Array<ResourceOperation>;
}

// ----------- Execute Operations Request ---------
@doc("The ExecuteDeallocateRequest request for executeDeallocate operations")
model ExecuteDeallocateRequest {
  @doc("The execution parameters for the request")
  executionParameters: ExecutionParameters;

  @doc("The resources for the request")
  resources: Resources;

  @doc("CorrelationId item")
  correlationid: string;
}

@doc("The ExecuteHibernateRequest request for executeHibernate operations")
model ExecuteHibernateRequest {
  @doc("The execution parameters for the request")
  executionParameters: ExecutionParameters;

  @doc("The resources for the request")
  resources: Resources;

  @doc("CorrelationId item")
  correlationid: string;
}

@doc("The ExecuteStartRequest request for executeStart operations")
model ExecuteStartRequest {
  @doc("The execution parameters for the request")
  executionParameters: ExecutionParameters;

  @doc("The resources for the request")
  resources: Resources;

  @doc("CorrelationId item")
  correlationid: string;
}

@doc("The ExecuteCreateRequest request for create operations")
@added(Microsoft.ComputeSchedule.Versions.`2025-05-01`)
model ExecuteCreateRequest {
  @doc("resource creation payload")
  resourceConfigParameters: ResourceProvisionPayload;

  @doc("The execution parameters for the request")
  executionParameters: ExecutionParameters;

  @doc("CorrelationId item")
  correlationid?: string;
}

@doc("The response from a create request")
@added(Microsoft.ComputeSchedule.Versions.`2025-05-01`)
model CreateResourceOperationResponse {
  @doc("The description of the operation response")
  description: string;

  @doc("The type of resources used in the create request eg virtual machines")
  type: string;

  @doc("The location of the start request eg westus")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: azureLocation;

  @extension("x-ms-identifiers", #["resourceId"])
  @doc("The results from the start request if no errors exist")
  results?: Array<ResourceOperation>;
}

@doc("The response from a delete request")
@added(Microsoft.ComputeSchedule.Versions.`2025-05-01`)
model DeleteResourceOperationResponse {
  @doc("The description of the operation response")
  description: string;

  @doc("The type of resources used in the delete request eg virtual machines")
  type: string;

  @doc("The location of the start request eg westus")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: azureLocation;

  @extension("x-ms-identifiers", #["resourceId"])
  @doc("The results from the start request if no errors exist")
  results?: Array<ResourceOperation>;
}

@doc("The ExecuteDeleteRequest for delete VM operation")
@added(Microsoft.ComputeSchedule.Versions.`2025-05-01`)
model ExecuteDeleteRequest {
  @doc("The execution parameters for the request")
  executionParameters: ExecutionParameters;

  @doc("The resources for the request")
  resources: Resources;

  @doc("CorrelationId item")
  correlationid?: string;

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
@doc("This is the request to cancel running operations in scheduled actions using the operation ids")
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
