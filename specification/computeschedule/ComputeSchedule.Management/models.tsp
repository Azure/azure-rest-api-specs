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

  @added(Microsoft.ComputeSchedule.Versions.`2026-03-01-preview`)
  @doc("Create operations on the resources")
  Create: "Create",

  @added(Microsoft.ComputeSchedule.Versions.`2026-03-01-preview`)
  @doc("Delete operations on the resources")
  Delete: "Delete",

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

  @doc("Operations that have been cancelled by the user")
  Cancelled: "Cancelled",

  @doc("Operations that are blocked")
  Blocked: "Blocked",

  string,
}

@added(Microsoft.ComputeSchedule.Versions.`2026-03-01-preview`)
@doc("The supported operating system types for flex VM creation")
union OsType {
  @doc("Windows operating system")
  Windows: "Windows",

  @doc("Linux operating system")
  Linux: "Linux",

  string,
}

@added(Microsoft.ComputeSchedule.Versions.`2026-03-01-preview`)
@doc("The priority type for VM allocation")
union PriorityType {
  @doc("Regular priority VMs")
  regular: "regular",

  @doc("Spot priority VMs")
  spot: "spot",

  string,
}

@added(Microsoft.ComputeSchedule.Versions.`2026-03-01-preview`)
@doc("The allocation strategy for VM size selection")
union AllocationStrategy {
  @doc("Platform prioritizes VM sizes with the lowest hourly cost")
  LowestPrice: "LowestPrice",

  @doc("Customer specifies a rank for each VM size, platform uses VM sizes in rank order")
  Prioritized: "Prioritized",

  @doc("Platform prioritizes VM sizes with the highest available capacity first")
  CapacityOptimized: "CapacityOptimized",

  string,
}

@added(Microsoft.ComputeSchedule.Versions.`2026-03-01-preview`)
@doc("The distribution strategy for zone allocation")
union DistributionStrategy {
  @doc("Platform attempts to place as many VMs as possible in a single zone, falls back to multiple zones if needed")
  BestEffortSingleZone: "BestEffortSingleZone",

  @doc("Platform uses customer-provided zone rankings to allocate VMs")
  Prioritized: "Prioritized",

  @doc("Platform attempts to evenly distribute VMs across all available zones with best effort")
  BestEffortBalanced: "BestEffortBalanced",

  @doc("Platform must evenly distribute VMs across zones, request is rejected if exact balance cannot be achieved")
  StrictBalanced: "StrictBalanced",

  string,
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

// ------------------ Models ---------------
@doc("The schedule details for the user request")
model Schedule {
  #suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Prefer using `utcDateTime` when representing a datetime unless an offset is necessary."
  @doc("The deadline for the operation")
  deadLine: offsetDateTime;

  @doc("The timezone for the operation")
  timeZone: string;

  @doc("The deadlinetype of the operation, this can either be InitiateAt or CompleteBy")
  deadlineType: DeadlineType = DeadlineType.Unknown;
}

@doc("The resources needed for the user request")
model Resources {
  @doc("The resource ids used for the request")
  @typeChangedFrom(Versions.`2026-03-01-preview`, Array<string>)
  ids: Array<armResourceIdentifier>;
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
  @typeChangedFrom(Versions.`2026-03-01-preview`, string)
  resourceId: armResourceIdentifier;

  @doc("Type of operation performed on the resources")
  opType: ResourceOperationType = ResourceOperationType.Unknown;

  @doc("Subscription id attached to the request")
  subscriptionId: string;

  #suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Prefer using `utcDateTime` when representing a datetime unless an offset is necessary."
  @doc("Deadline for the operation")
  deadline: offsetDateTime;

  @doc("Type of deadline of the operation")
  deadlineType: DeadlineType = DeadlineType.Unknown;

  @doc("Current state of the operation")
  state: OperationState = OperationState.Unknown;

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
  @typeChangedFrom(Versions.`2026-03-01-preview`, string)
  resourceId?: armResourceIdentifier;

  @doc("Resource level error code if it exists")
  errorCode?: string;

  @doc("Resource level error details if they exist")
  errorDetails?: string;

  @doc("Details of the operation performed on a resource")
  operation?: ResourceOperationDetails;
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
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: string;

  @Azure.ResourceManager.identifiers(#["resourceId"])
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
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: string;

  @Azure.ResourceManager.identifiers(#["resourceId"])
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
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: string;

  @Azure.ResourceManager.identifiers(#["resourceId"])
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

  @doc("Correlationid item")
  correlationid: string;
}

@doc("The ExecuteHibernateRequest request for executeHibernate operations")
model ExecuteHibernateRequest {
  @doc("The execution parameters for the request")
  executionParameters: ExecutionParameters;

  @doc("The resources for the request")
  resources: Resources;

  @doc("Correlationid item")
  correlationid: string;
}

@doc("The ExecuteStartRequest request for executeStart operations")
model ExecuteStartRequest {
  @doc("The execution parameters for the request")
  executionParameters: ExecutionParameters;

  @doc("The resources for the request")
  resources: Resources;

  @doc("Correlationid item")
  correlationid: string;
}

// ----------- ExecuteCreate ---------
@added(Microsoft.ComputeSchedule.Versions.`2026-03-01-preview`)
@doc("Resource creation data model")
model ResourceProvisionPayload {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "reviewed this with ARM, we are a pass through to compute RP and doing any property specific validation, compute RP will do that."
  @doc("JSON object that contains VM properties that are common across all VMs in this batch")
  baseProfile?: Record<unknown>;

  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "reviewed this with ARM, we are a pass through to compute RP and doing any property specific validation, compute RP will do that."
  @doc("JSON array that contains VM properties that should be overridden for each VM in the batch")
  resourceOverrides?: Record<unknown>[];

  @doc("The number of resources to create")
  resourceCount: int32;

  @doc("if resourceOverrides doesn't contain \"name\", service will create name based of prefix and ResourceCount e.g. resourceprefix-0,resourceprefix-1..")
  resourcePrefix?: string;
}

@added(Microsoft.ComputeSchedule.Versions.`2026-03-01-preview`)
@doc("The ExecuteCreateRequest request for create operations")
model ExecuteCreateRequest {
  @doc("resource creation payload")
  resourceConfigParameters: ResourceProvisionPayload;

  @doc("The execution parameters for the request")
  executionParameters: ExecutionParameters;

  @doc("Correlationid item")
  correlationid?: string;
}

@added(Microsoft.ComputeSchedule.Versions.`2026-03-01-preview`)
@doc("The response from a create request")
model CreateResourceOperationResponse {
  @doc("The description of the operation response")
  description: string;

  @doc("The type of resources used in the create request eg virtual machines")
  type: string;

  @doc("The location of the start request eg westus")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: string;

  @Azure.ResourceManager.identifiers(#["resourceId"])
  @doc("The results from the start request if no errors exist")
  results?: Array<ResourceOperation>;
}

// ----------- ExecuteDelete ---------
@added(Microsoft.ComputeSchedule.Versions.`2026-03-01-preview`)
@doc("The ExecuteDeleteRequest for delete VM operation")
model ExecuteDeleteRequest {
  @doc("The execution parameters for the request")
  executionParameters: ExecutionParameters;

  @doc("The resources for the request")
  resources: Resources;

  @doc("Correlationid item")
  correlationid?: string;

  @doc("Forced delete resource item")
  forceDeletion?: boolean;
}

@added(Microsoft.ComputeSchedule.Versions.`2026-03-01-preview`)
@doc("The response from a delete request")
model DeleteResourceOperationResponse {
  @doc("The description of the operation response")
  description: string;

  @doc("The type of resources used in the delete request eg virtual machines")
  type: string;

  @doc("The location of the start request eg westus")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: string;

  @Azure.ResourceManager.identifiers(#["resourceId"])
  @doc("The results from the delete request if no errors exist")
  results?: Array<ResourceOperation>;
}

// ----------- ExecuteCreateFlex ---------
@added(Microsoft.ComputeSchedule.Versions.`2026-03-01-preview`)
@doc("A VM size profile with a name and rank for flex VM creation")
model VmSizeProfile {
  @doc("The name of the VM size, eg Standard_D2ads_v5")
  @minLength(1)
  name: string;

  @doc("The rank of this VM size in the priority order")
  rank: int32;
}

@added(Microsoft.ComputeSchedule.Versions.`2026-03-01-preview`)
@doc("The priority profile for flex VM creation")
model PriorityProfile {
  @doc("The priority type for VM allocation")
  type?: PriorityType;

  @doc("The allocation strategy for VM size selection")
  allocationStrategy?: AllocationStrategy;
}

@added(Microsoft.ComputeSchedule.Versions.`2026-03-01-preview`)
@doc("A zone preference with a zone identifier and rank")
model ZonePreference {
  @doc("The zone identifier")
  zone: string;

  @doc("The rank of this zone in the priority order")
  rank: int32;
}

@added(Microsoft.ComputeSchedule.Versions.`2026-03-01-preview`)
@doc("The zone allocation policy for distributing VMs across availability zones")
model ZoneAllocationPolicy {
  @doc("The distribution strategy for zone allocation")
  distributionStrategy?: DistributionStrategy;

  @identifiers(#[])
  @doc("The zone preferences for allocation priority")
  zonePreferences?: Array<ZonePreference>;
}

@added(Microsoft.ComputeSchedule.Versions.`2026-03-01-preview`)
@doc("The flex properties for flexible VM creation")
model FlexProperties {
  @identifiers(#[])
  @doc("The list of VM size profiles to use for flex creation")
  @minItems(1)
  @maxItems(10)
  vmSizeProfiles: Array<VmSizeProfile>;

  @doc("The operating system type for the VMs")
  osType: OsType;

  @doc("The priority profile for VM allocation")
  priorityProfile: PriorityProfile;

  @doc("The zone allocation policy for distributing VMs across availability zones")
  zoneAllocationPolicy?: ZoneAllocationPolicy;
}

@added(Microsoft.ComputeSchedule.Versions.`2026-03-01-preview`)
@doc("Resource creation data model for flex VM provisioning")
model ResourceProvisionFlexPayload {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "reviewed this with ARM, we are a pass through to compute RP and doing any property specific validation, compute RP will do that."
  @doc("JSON object that contains VM properties that are common across all VMs in this batch")
  baseProfile?: Record<unknown>;

  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "reviewed this with ARM, we are a pass through to compute RP and doing any property specific validation, compute RP will do that."
  @doc("JSON array that contains VM properties that should be overridden for each VM in the batch")
  resourceOverrides?: Record<unknown>[];

  @doc("Number of VMs to be created")
  resourceCount: int32;

  @doc("If resourceOverrides doesn't contain name, service will create name based on prefix and resourceCount")
  resourcePrefix?: string;

  @doc("The flex properties for flexible VM creation")
  flexProperties: FlexProperties;
}

@added(Microsoft.ComputeSchedule.Versions.`2026-03-01-preview`)
@doc("The ExecuteCreateFlexRequest request for executeCreateFlex operations")
model ExecuteCreateFlexRequest {
  @doc("Resource creation payload with flex properties")
  resourceConfigParameters: ResourceProvisionFlexPayload;

  @doc("The execution parameters for the request")
  executionParameters: ExecutionParameters;

  @doc("Correlationid item")
  correlationid?: string;
}

@added(Microsoft.ComputeSchedule.Versions.`2026-03-01-preview`)
@doc("The response from a create flex request")
model CreateFlexResourceOperationResponse {
  @doc("The description of the operation response")
  description: string;

  @doc("The type of resources used in the create flex request eg virtual machines")
  type: string;

  @doc("The location of the create flex request eg westus")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: string;

  @Azure.ResourceManager.identifiers(#["resourceId"])
  @doc("The results from the create flex request if no errors exist")
  results?: Array<ResourceOperation>;
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
  @Azure.ResourceManager.identifiers(#["resourceId"])
  @doc("An array of resource operations based on their operation ids")
  results: Array<ResourceOperation>;
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
  @Azure.ResourceManager.identifiers(#["resourceId"])
  @doc("An array of resource operations that were successfully cancelled")
  results: Array<ResourceOperation>;
}

// ----------- GetOperationErrors ---------
@added(Microsoft.ComputeSchedule.Versions.`2026-03-01-preview`)
@doc("This is the request to get errors per vm operations")
model GetOperationErrorsRequest {
  @doc("The list of operation ids to query errors of")
  operationIds: Array<string>;
}

@added(Microsoft.ComputeSchedule.Versions.`2026-03-01-preview`)
@doc("This is the response from a get operations errors request")
model GetOperationErrorsResponse {
  @Azure.ResourceManager.identifiers(#[])
  @doc("An array of errors based on the operationids")
  results: Array<OperationErrorsResult>;
}

#suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Prefer using `utcDateTime` when representing a datetime unless an offset is necessary."
@added(Microsoft.ComputeSchedule.Versions.`2026-03-01-preview`)
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

  @Azure.ResourceManager.identifiers(#[])
  @doc("A list of errors associated with the operationId")
  operationErrors?: Array<OperationErrorDetails>;

  @doc("Request level error code")
  requestErrorCode?: string;

  @doc("Request level error details")
  requestErrorDetails?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Prefer using `utcDateTime` when representing a datetime unless an offset is necessary."
@added(Microsoft.ComputeSchedule.Versions.`2026-03-01-preview`)
@doc("This describes errors per vm during an operation")
model OperationErrorDetails {
  @doc("The error code of the operation")
  errorCode: string;

  @doc("The error details of the operation")
  errorDetails: string;

  @doc("The timestamp of the error occurrence")
  timestamp?: offsetDateTime;

  @doc("The compute operationId of the Start/Deallocate/Hibernate request")
  azureOperationName?: string;
}

@@identifiers(Azure.Core.Foundations.Error.details, #[]);
