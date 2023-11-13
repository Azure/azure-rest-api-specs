import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
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
enum DeadlineType {
  @doc("Default value of Unknown.")
  Unknown,

  @doc("Initiate the operation at the given deadline.")
  InitiateAt,

  @doc("Complete the operation by the given deadline.")
  CompleteBy,
}

@doc("The preferences customers can select to optimize their requests to ScheduledActions")
enum OptimizationPreference {
  @doc("Optimize while considering cost savings")
  Cost,

  @doc("Optimize while considering availability of resources")
  Availability,

  @doc("Optimize while considering a balance of cost and availability")
  CostAvailabilityBalanced,
}

@doc("The kind of operation types that can be performed on virtual machines using ScheduledActions")
enum VmOperationType {
  @doc("The default value for this enum type")
  Unknown,

  @doc("Start operations on the virtual machines")
  Start,

  @doc("Deallocate operations on the virtual machines")
  Deallocate,

  @doc("Hibernate operations on the virtual machines")
  Hibernate,
}

@doc("Values that define the states of operations in Scheduled Actions")
enum OperationState {
  @doc("The default value for the operation state enum")
  Unknown,

  @doc("Operations that are pending scheduling")
  PendingScheduling,

  @doc("Operations that have been scheduled")
  Scheduled,

  @doc("Operations that are waiting to be executed")
  PendingExecution,

  @doc("Operations that are in the process of being executed")
  Executing,

  @doc("Operations that suceeded")
  Succeeded,

  @doc("Operations that have failed")
  Failed,

  @doc("Operations that have been cancelled by the user")
  Cancelled,

  @doc("Operations that are blocked")
  Blocked,
}

// ------------------ Common Values ---------------
alias Params = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;

  @path
  @minLength(1)
  @segment("locations")
  @doc("The location name.")
  locationparameter: string;
};

alias HibernateQueryParam = {
  @doc("Hibernate query for hibernate request")
  @query
  hibernate: boolean = true;
};

// ------------------ Models ---------------
@doc("The schedule details for the user request")
model Schedule {
  #suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Prefer using `utcDateTime` when representing a datetime unless an offset is necessary."
  @doc("The deadline for the operation")
  deadLine: offsetDateTime;

  @doc("The timezone for the operation")
  timeZone: string;

  @doc("The deadlinetype of the operation, this can either be InitiateAt or CompleteBy")
  @extension("x-ms-enum.modelAsString", true)
  deadlineType: DeadlineType = DeadlineType.Unknown;
}

@doc("The resources needed for the user request")
model Resources {
  @doc("The resource ids used for the request")
  ids: Array<string>;
}

@doc("Extra details needed to run the user's request")
model ExecutionParameters {
  @doc("Time to stop retries after in hours")
  stopRetriesAfter?: int32;

  @doc("Details that could optimize the user's request")
  optimizationPreference?: OptimizationPreference;
}

@doc("These describe errors that occur at the resource level")
model ResourceOperationError {
  @doc("Code for the error eg 404, 500")
  errorCode: string;

  @doc("Detailed message about the error")
  errorDetails: string;
}

@doc("These describe errors that occur at the request level")
model RequestError {
  @doc("Code for the error eg 404, 500")
  code: string;

  @doc("Detailed message about the error")
  message: string;
}

@doc("The details of a response from an operation on a resource")
model ResourceOperationDetails {
  @doc("Operation identifier for the unique operation")
  operationId: string;

  @doc("Unique identifier for the resource involved in the operation, eg ArmId")
  resourceId: string;

  @doc("Type of operation performed on the virtual machine")
  @extension("x-ms-enum.modelAsString", true)
  opType: VmOperationType = VmOperationType.Unknown;

  @doc("Subscription id attached to the request")
  subscriptionId: string;

  #suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Prefer using `utcDateTime` when representing a datetime unless an offset is necessary."
  @doc("Deadline for the operation")
  deadline: offsetDateTime;

  @doc("Type of deadline of the operation")
  @extension("x-ms-enum.modelAsString", true)
  deadlineType: DeadlineType = DeadlineType.Unknown;

  @doc("Current state of the operation")
  @extension("x-ms-enum.modelAsString", true)
  state: OperationState = OperationState.Unknown;

  @doc("Timezone for the operation")
  timeZone: string;

  @doc("Operation level errors if they exist")
  resourceOperationError?: ResourceOperationError;

  #suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Prefer using `utcDateTime` when representing a datetime unless an offset is necessary."
  @doc("Time the operation was complete if errors are null")
  completedAt?: offsetDateTime;
}

@doc("High level response from an operation on a resource")
model ResourceOperation {
  @doc("Unique identifier for the resource involved in the operation, eg ArmId")
  resourceId: string;

  @doc("Resource level error code if it exists")
  errorCode?: string;

  @doc("Resource level error details if they exist")
  errorDetails?: string;

  @doc("Details of the operation performed on a resource")
  operation?: ResourceOperationDetails;
}

@doc("Error for the vm operation")
model ErrorInfo {
  @doc("Error code for the error, eg 404")
  errorCode: string;

  @doc("More details about the error")
  errorDetails: string;
}

@doc("High level result from getting an operation status or cancelling an operation on a virtual machine")
model VmOperationResult {
  @doc("Error code if it exists")
  errorCode?: string;

  @doc("More details of the error if it exists")
  errorDetails?: string;

  @doc("Unique id for the virtual machine involved in the operation")
  vmId?: string;

  @doc("Unique id for the operation performed on the virtual machine")
  operationId: string;

  @doc("More details on the operation performed on the vm")
  vmOperation?: VmOperation;
}

@doc("Details of result from getting an operation status or cancelling an operation on a virtual machine")
model VmOperation {
  @doc("The type of operation scheduled for the virtual machine, ie start/deallocate/hibernate")
  @extension("x-ms-enum.modelAsString", true)
  opType: VmOperationType = VmOperationType.Unknown;

  @doc("Subscription Id attached to the request")
  subscriptionId: string;

  @doc("Unique id for the operation")
  id: string;

  @doc("Unique id for the virtual machine")
  vmId: string;

  @doc("Deadline for the user selected operation")
  deadlineUtc: utcDateTime;

  @doc("Time for activation of the operation")
  activationTime: utcDateTime;

  @doc("Type of deadline used in the operation ie InitiateAt/CompleteBy")
  @extension("x-ms-enum.modelAsString", true)
  deadlineType: DeadlineType = DeadlineType.Unknown;

  @doc("Current state of the operation")
  @extension("x-ms-enum.modelAsString", true)
  state: OperationState = OperationState.Unknown;

  @doc("Errors in the vm operation")
  error?: ErrorInfo;

  @doc("Time the operation was completed if no error occured")
  completedAt?: utcDateTime;
}

// ----------- SubmitDeallocate ---------
@doc("The deallocate request for resources")
model SubmitDeallocateRequest {
  ...Schedule;
  ...ExecutionParameters;
  ...Resources;

  @doc("Correlationid item")
  correlationid: string;
}

@doc("The response from a deallocate request")
model DeallocateResourceOperationResponse {
  @doc("The description of the operation response")
  description: string;

  @doc("The type of resources used in the deallocate request eg virtual machines")
  type: string;

  @doc("The location of the deallocate request eg westus")
  @extension("x-ms-mutability", ["read", "create"])
  location: string;

  @extension("x-ms-identifiers", ["resourceId"])
  @doc("The results from the deallocate request if no errors exist")
  results?: ResourceOperation[];

  @doc("Request level error if it exists")
  error?: RequestError;
}

// ----------- SubmitStart ---------
@doc("This is the request for start")
model SubmitStartRequest {
  ...Schedule;
  ...ExecutionParameters;
  ...Resources;

  @doc("Correlationid item")
  correlationid: string;
}

@doc("The response from a start request")
model StartResourceOperationResponse {
  @doc("The description of the operation response")
  description: string;

  @doc("The type of resources used in the start request eg virtual machines")
  type: string;

  @doc("The location of the start request eg westus")
  @extension("x-ms-mutability", ["read", "create"])
  location: string;

  @extension("x-ms-identifiers", ["resourceId"])
  @doc("The results from the start request if no errors exist")
  results?: Array<ResourceOperation>;

  @doc("Request level error if it exists")
  error?: RequestError;
}

// ----------- SubmitHibernate ---------
@doc("This is the request for hibernate")
model SubmitHibernateRequest {
  ...Schedule;
  ...ExecutionParameters;
  ...Resources;

  @doc("Correlationid item")
  correlationid: string;
}

@doc("The response from a Hibernate request")
model HibernateResourceOperationResponse {
  @doc("The description of the operation response")
  description: string;

  @doc("The type of resources used in the Hibernate request eg virtual machines")
  type: string;

  @doc("The location of the Hibernate request eg westus")
  @extension("x-ms-mutability", ["read", "create"])
  location: string;

  @extension("x-ms-identifiers", ["resourceId"])
  @doc("The results from the Hibernate request if no errors exist")
  results?: Array<ResourceOperation>;

  @doc("Request level error if it exists")
  error?: RequestError;
}

// ----------- GetOperationStatus ---------
@doc("This is the request to get operation status using operationids")
model GetOperationStatusRequest {
  @doc("The list of operation ids to get the status of")
  operationIds: Array<string>;

  @doc("Correlationid item")
  correlationid: string;
}

@doc("This is the response from a get operations status request")
model GetOperationStatusResponse {
  @extension("x-ms-identifiers", ["operationId"])
  @doc("An array of vm operations based on their operation ids")
  results: VmOperationResult[];
}

// ----------- CancelOperations ---------
@doc("This is the request to cancel running operations in scheduled actions using the operation ids")
model CancelOperationsRequest {
  @doc("The list of operation ids to cancel operations on")
  operationIds: Array<string>;

  @doc("Correlationid item")
  correlationid: string;
}

@doc("This is the response from a cancel operations request")
model CancelOperationsResponse {
  @extension("x-ms-identifiers", ["operationId"])
  @doc("An array of vm operations that were successfully cancelled")
  results: VmOperationResult[];
}

@doc("This is the default error for requests made with ScheduledActions")
@error
model RequestLevelError {
  @doc("Description of the request that failed, ie SubmitDeallocateRequest/SubmitStartRequest/SubmitHibernateRequest")
  description: string;

  @doc("The type of resources used in the request")
  type: string;

  @doc("The location of the resource used in the request")
  @extension("x-ms-mutability", ["read", "create"])
  location: string;

  @doc("The error details")
  error: RequestError;
}
