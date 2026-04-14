import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./virtualMachineProfile.tsp";
import "./virtualMachineExtension.tsp";
import "./common.tsp";

using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Versioning;

namespace Microsoft.Compute;

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

@doc("The kind of bulk operation that can be performed on resources using Bulkactions API")
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

@doc("Values that define the states of operations in Bulkactions")
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
@doc("The resources needed for the user request")
model Resources {
  @doc("The resource ids used for the request")
  ids: Array<armResourceIdentifier<[
    {
      type: "Microsoft.Compute/virtualMachines";
    }
  ]>>;
}

/**
 * The virtual machine specification for bulk create.
 */
model BulkactionVMSpec {
  /**
   * The marketplace image plan used for the virtual machine.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  plan?: Plan;

  ...Azure.ResourceManager.AvailabilityZonesProperty;

  /**
   * The identity of the virtual machine, if configured.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: VirtualMachineIdentity;

  /**
   * The extended location of the Virtual Machine.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  extendedLocation?: ExtendedLocation;

  @doc("Placement constraints for virtual machine hardware placement - see specification/compute/Compute.Management/models.tsp#Placement")
  placement?: Placement;

  /**
   * Resource tags to apply to the virtual machines created by this bulk action.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  @doc("Describes the properties of a Virtual Machine.")
  vmProperties?: BulkactionVMProfile;
}

/**
 * The flex properties for flexible VM creation.
 */
// ----------- ExecuteCreateFlex ---------
@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
@doc("The supported operating system types for flex VM creation")
union OsType {
  @doc("Windows operating system")
  Windows: "Windows",

  @doc("Linux operating system")
  Linux: "Linux",

  string,
}

@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
@doc("The priority type for VM allocation")
union PriorityType {
  @doc("Regular priority VMs")
  Regular: "Regular",

  @doc("Spot priority VMs")
  Spot: "Spot",

  string,
}

@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
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

@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
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

@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
@doc("A VM size profile with a name and rank for flex VM creation")
model VmSizeProfile {
  @doc("The name of the VM size, eg Standard_D2ads_v5")
  @minLength(1)
  name: string;

  @doc("The rank of this VM size in the priority order")
  rank: int32;
}

@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
@doc("The priority profile for flex VM creation")
model PriorityProfile {
  @doc("The priority type for VM allocation")
  type?: PriorityType;

  @doc("The allocation strategy for VM size selection")
  allocationStrategy?: AllocationStrategy;
}

@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
@doc("A zone preference with a zone identifier and rank")
model ZonePreference {
  @doc("The zone identifier")
  zone: string;

  @doc("The rank of this zone in the priority order")
  rank: int32;
}

@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
@doc("The zone allocation policy for distributing VMs across availability zones")
model ZoneAllocationPolicy {
  @doc("The distribution strategy for zone allocation")
  distributionStrategy?: DistributionStrategy;

  @identifiers(#[])
  @doc("The zone preferences for allocation priority")
  zonePreferences?: Array<ZonePreference>;
}

@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
@doc("The flex properties for flexible VM creation")
model FlexProperties {
  @identifiers(#[])
  @doc("The list of VM size profiles to use for flex creation")
  @minItems(1)
  @maxItems(5)
  vmSizeProfiles: Array<VmSizeProfile>;

  @doc("The operating system type for the VMs")
  osType: OsType;

  @doc("The priority profile for VM allocation")
  priorityProfile: PriorityProfile;

  @doc("The zone allocation policy for distributing VMs across availability zones")
  zoneAllocationPolicy?: ZoneAllocationPolicy;
}

/**
 * Per-VM configuration overrides that can be applied within a bulk virtual machine operation.
 */
model BulkVMConfiguration {
  @doc("Bulk Actions Virtual Machine Profile to configure Virtual Machines - mirrors Microsoft.Compute VirtualMachine structure")
  vmProperties?: BulkactionVMSpec;

  @doc("Virtual Machine Extensions Array to be applied to the Virtual Machines.")
  extensions?: BulkactionVMExtension[];

  @doc("Specifies the Microsoft.Compute API version to use when creating underlying Virtual Machines.")
  computeApiVersion?: string;

  @doc("Identifier for the created virtual machine. If not provided, a name will be generated based on the resource prefix.")
  name?: string;
}

@doc("Resource creation data model")
model ResourceProvisionPayload {
  @doc("Bulk Actions Virtual Machine Profile object that contains VM properties that are common across all VMs in this batch")
  baseProfile?: BulkVMConfiguration;

  @doc("Bulk Actions Virtual Machine Profile array, that contains VM properties that should be overridden for each VM in the batch")
  @identifiers(#[])
  resourceOverrides?: BulkVMConfiguration[];

  @doc("Number of VMs to be created")
  resourceCount: int32;

  @doc("If resourceOverrides doesn't contain \"name\", the service will create a name based on the prefix and ResourceCount, e.g., resourceprefix-0, resourceprefix-1..")
  resourcePrefix?: string;
}

@doc("Resource creation data model with Flex properties for VDI scenarios")
model ResourceProvisionVdiPayload {
  ...ResourceProvisionPayload;

  @doc("Flex properties used for VDI resource creation scenarios")
  flexProperties: FlexProperties;
}

@doc("The retry policy for the user request")
model RetryPolicy {
  @doc("Retry count for user request")
  retryCount?: int32;

  @doc("Retry window in minutes for user request")
  retryWindowInMinutes?: int32;

  @doc("Action to take on failure")
  onFailureAction?: ResourceOperationType;
}

@doc("Extra details needed to run the user's request")
model ExecutionParameters {
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

@doc("Describes the fallback operation that was performed")
model FallbackOperationInfo {
  @doc("The last operation type that was performed as a fallback")
  lastOpType: ResourceOperationType;

  @doc("The status of the fallback operation")
  status: string;

  @doc("The error code if the fallback operation failed")
  error?: ResourceOperationError;
}

@doc("The details of a response from an operation on a resource")
model ResourceOperationDetails {
  @doc("Operation identifier for the unique operation")
  operationId: string;

  @doc("Unique identifier for the resource involved in the operation, for example Azure resource ID")
  resourceId?: Array<armResourceIdentifier<[
    {
      type: "Microsoft.Compute/virtualMachines";
    }
  ]>>;

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

  @doc("Timezone for the operation")
  timezone?: string;

  @doc("Operation level errors if they exist")
  resourceOperationError?: ResourceOperationError;

  @doc("Fallback operation details if a fallback was performed")
  fallbackOperationInfo?: FallbackOperationInfo;

  #suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Prefer using `utcDateTime` when representing a datetime unless an offset is necessary."
  @doc("Time the operation was complete if errors are null")
  completedAt?: offsetDateTime;

  @doc("Retry policy the user can pass")
  retryPolicy?: RetryPolicy;
}

@doc("High level response from an operation on a resource")
model ResourceOperation {
  @doc("Unique identifier for the resource involved in the operation, for example Azure resource ID")
  resourceId?: Array<armResourceIdentifier<[
    {
      type: "Microsoft.Compute/virtualMachines";
    }
  ]>>;

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

  @doc("The timestamp of the error occurrence")
  timestamp?: offsetDateTime;

  @doc("The timestamp of the error occurrence")
  timeStamp?: offsetDateTime;

  @doc("The compute operationid of the Start/Deallocate/Hibernate request")
  azureOperationName?: string;

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
}

@doc("The ExecuteHibernateRequest request for executeHibernate operations")
model ExecuteHibernateRequest {
  @doc("The execution parameters for the request")
  executionParameters: ExecutionParameters;

  @doc("The resources for the request")
  resources: Resources;
}

@doc("The ExecuteStartRequest request for executeStart operations")
model ExecuteStartRequest {
  @doc("The execution parameters for the request")
  executionParameters: ExecutionParameters;

  @doc("The resources for the request")
  resources: Resources;
}

@doc("The ExecuteCreateRequest request for create operations")
model ExecuteCreateRequest {
  @doc("resource creation payload")
  resourceConfigParameters: ResourceProvisionPayload;

  @doc("The execution parameters for the request")
  executionParameters: ExecutionParameters;
}

@doc("The VdiCreateRequest request for create operations")
model ExecuteVdiCreateRequest {
  @doc("resource creation payload")
  resourceConfigParameters: ResourceProvisionVdiPayload;

  @doc("The execution parameters for the request")
  executionParameters: ExecutionParameters;
}

@doc("Per-resource override entry for reimage requests")
model ReimageResourceOverride {
  @doc("The Azure resource ID of the virtual machine for this override")
  resourceId: armResourceIdentifier<[
    {
      type: "Microsoft.Compute/virtualMachines";
    }
  ]>;

  @doc("Per-resource reimage profile override")
  profile: VirtualMachineReimageParameters;
}

@doc("Reimage payload with common profile and per-resource overrides")
model ReimagePayload {
  @doc("Common reimage profile applied to all resources unless overridden")
  baseProfile?: VirtualMachineReimageParameters;

  @identifiers(#[])
  @doc("Per-resource reimage overrides")
  resourceOverrides?: ReimageResourceOverride[];
}

@doc("The ExecuteReimageRequest request for reimage operations")
model ExecuteReimageRequest {
  @doc("The execution parameters for the request")
  executionParameters: ExecutionParameters;

  @doc("The resources for the request")
  resources: Resources;

  @doc("Reimage parameters including base profile and per-resource overrides")
  reimageParameters?: ReimagePayload;
}

@doc("The response from a create request")
model CreateResourceOperationResponse {
  @doc("The description of the operation response")
  description: string;

  @doc("The type of resources used in the create request eg virtual machines")
  type: string;

  @doc("The location of the create request eg westus")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: azureLocation;

  @identifiers(#["resourceId"])
  @doc("The results from the create request if no errors exist")
  results?: Array<ResourceOperation>;
}

@doc("The response from a reimage request")
model ReimageResourceOperationResponse {
  @doc("The description of the operation response")
  description: string;

  @doc("The type of resources used in the reimage request eg virtual machines")
  type: string;

  @doc("The location of the reimage request eg westus")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: azureLocation;

  @identifiers(#["resourceId"])
  @doc("The results from the reimage request if no errors exist")
  results?: Array<ResourceOperation>;
}

@doc("The response from a delete request")
model DeleteResourceOperationResponse {
  @doc("The description of the operation response")
  description: string;

  @doc("The type of resources used in the delete request eg virtual machines")
  type: string;

  @doc("The location of the delete request eg westus")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: azureLocation;

  @identifiers(#["resourceId"])
  @doc("The results from the delete request if no errors exist")
  results?: Array<ResourceOperation>;
}

@doc("The ExecuteDeleteRequest for delete VM operation")
model ExecuteDeleteRequest {
  @doc("The execution parameters for the request")
  executionParameters: ExecutionParameters;

  @doc("The resources for the request")
  resources: Resources;

  @doc("Forced delete resource item")
  forceDeletion?: boolean;
}

// ----------- GetOperationStatus ---------
@doc("This is the request to get operation status using operationids")
model GetOperationStatusRequest {
  @doc("The list of operation ids to get the status of")
  operationIds: Array<string>;
}

@doc("This is the response from a get operations status request")
model GetOperationStatusResponse {
  @identifiers(#["resourceId"])
  @doc("An array of resource operations based on their operation ids")
  results: Array<ResourceOperation>;
}

@doc("Static read response for the singleton bulk VM operations proxy endpoint")
model BulkVmOperationsReadResponse {
  @doc("Indicates the singleton proxy endpoint is reachable")
  status: "Ready";

  @doc("Echoes the singleton proxy resource name")
  name: "bulkVmOperations";
}

// ----------- CancelOperations ---------
@doc("This is the request to cancel running operations in scheduled actions using the operation ids")
model CancelOperationsRequest {
  @doc("The list of operation ids to cancel operations on")
  operationIds: Array<string>;
}

@doc("This is the response from a cancel operations request")
model CancelOperationsResponse {
  @identifiers(#["resourceId"])
  @doc("An array of resource operations that were successfully cancelled")
  results: Array<ResourceOperation>;
}
