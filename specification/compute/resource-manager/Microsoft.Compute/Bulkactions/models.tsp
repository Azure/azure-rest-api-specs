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
@doc("The deadline behavior for a bulk action.")
union DeadlineType {
  @doc("The deadline behavior is not known.")
  Unknown: "Unknown",

  @doc("Bulk Actions attempts to start the operation at the specified deadline.")
  InitiateAt: "InitiateAt",

  @doc("Bulk Actions attempts to complete the operation by the specified deadline.")
  CompleteBy: "CompleteBy",

  string,
}

@doc("The type of operation performed by Bulk Actions.")
union ResourceOperationType {
  @doc("The operation type is not known.")
  Unknown: "Unknown",

  @doc("Starts the specified virtual machines.")
  Start: "Start",

  @doc("Deallocates the specified virtual machines.")
  Deallocate: "Deallocate",

  @doc("Hibernates the specified virtual machines.")
  Hibernate: "Hibernate",

  @doc("Creates the specified virtual machines.")
  Create: "Create",

  @doc("Deletes the specified virtual machines.")
  Delete: "Delete",

  @added(Microsoft.Compute.Versions.`2026-07-06-preview`)
  @doc("Retrieves virtual machine instance information to verify guest agent health after a start operation.")
  GetInstanceView: "GetInstanceView",

  string,
}

@doc("The current state of a bulk action.")
union OperationState {
  @doc("The operation state is not known.")
  Unknown: "Unknown",

  @doc("The operation is waiting to be scheduled.")
  PendingScheduling: "PendingScheduling",

  @doc("The operation has been scheduled.")
  Scheduled: "Scheduled",

  @doc("The operation is waiting to begin.")
  PendingExecution: "PendingExecution",

  @doc("The operation is in progress.")
  Executing: "Executing",

  @doc("The operation completed successfully.")
  Succeeded: "Succeeded",

  @doc("The operation failed.")
  Failed: "Failed",

  @doc("The operation was canceled by the customer.")
  Cancelled: "Cancelled",

  @doc("The operation cannot currently make progress.")
  Blocked: "Blocked",

  string,
}

// ------------------ Models ---------------
@doc("The virtual machines targeted by a bulk action.")
model Resources {
  @doc("The Azure resource IDs of the target virtual machines.")
  ids: Array<armResourceIdentifier<[
    {
      type: "Microsoft.Compute/virtualMachines";
    }
  ]>>;
}

@added(Microsoft.Compute.Versions.`2026-07-06-preview`)
@doc("A virtual machine and optional customer-provided context for tracking its result.")
model ResourceWithContext {
  @doc("The Azure resource ID of the target virtual machine.")
  resourceId: armResourceIdentifier<[
    {
      type: "Microsoft.Compute/virtualMachines";
    }
  ]>;

  @doc("Opaque customer-provided context returned with the result for this virtual machine. Do not include secrets or personal data.")
  resourceContext: string;
}

@doc("The virtual machines targeted by a bulk action, with customer-provided tracking context.")
@added(Microsoft.Compute.Versions.`2026-07-06-preview`)
model ResourcesWithContext {
  @identifiers(#["resourceId"])
  @doc("The target virtual machines and their customer-provided tracking context.")
  resources: Array<ResourceWithContext>;
}

@added(Microsoft.Compute.Versions.`2026-07-06-preview`)
@doc("Customer-provided context associated with a virtual machine result.")
model ResourceNotificationDetails {
  @doc("Opaque customer-provided context returned with the virtual machine result.")
  resourceContext?: string;
}

/**
 * The flex properties for flexible VM creation.
 */
// ----------- ExecuteCreateFlex ---------
@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
@doc("The operating system type for virtual machines created with flexible allocation preferences.")
union OsType {
  @doc("Windows operating system.")
  Windows: "Windows",

  @doc("Linux operating system.")
  Linux: "Linux",

  string,
}

@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
@doc("The priority type for virtual machine allocation.")
union PriorityType {
  @doc("Regular, non-Spot virtual machines.")
  Regular: "Regular",

  @doc("Azure Spot Virtual Machines.")
  Spot: "Spot",

  string,
}

@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
@doc("The strategy Bulk Actions uses to select a virtual machine size.")
union AllocationStrategy {
  @doc("Bulk Actions prioritizes virtual machine sizes with the lowest hourly cost.")
  LowestPrice: "LowestPrice",

  @doc("Bulk Actions considers virtual machine sizes in the customer-specified rank order.")
  Prioritized: "Prioritized",

  @doc("Bulk Actions prioritizes virtual machine sizes with the highest available capacity.")
  CapacityOptimized: "CapacityOptimized",

  string,
}

@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
@doc("The strategy Bulk Actions uses to distribute virtual machines across availability zones.")
union DistributionStrategy {
  @doc("Bulk Actions attempts to place as many virtual machines as possible in one availability zone and uses additional zones when needed.")
  BestEffortSingleZone: "BestEffortSingleZone",

  @doc("Bulk Actions considers availability zones in the customer-specified rank order.")
  Prioritized: "Prioritized",

  @doc("Bulk Actions attempts to distribute virtual machines evenly across the available zones.")
  BestEffortBalanced: "BestEffortBalanced",

  @doc("Bulk Actions distributes virtual machines evenly across zones and rejects the request when an even distribution cannot be achieved.")
  StrictBalanced: "StrictBalanced",

  string,
}

@added(Microsoft.Compute.Versions.`2026-08-06-preview`)
@doc("Whether the service may launch fewer instances than requested when the full capacity cannot be satisfied.")
union PartialFulfillmentMode {
  @doc("Partial fulfillment is allowed.")
  Enabled: "Enabled",

  @doc("Partial fulfillment is not allowed.")
  Disabled: "Disabled",

  string,
}

@added(Microsoft.Compute.Versions.`2026-08-06-preview`)
@doc("The reason the requested capacity could only be partially fulfilled.")
union PartialFulfillmentReason {
  @doc("The requested capacity could not be fully satisfied due to insufficient capacity in the region.")
  InsufficientCapacity: "InsufficientCapacity",

  @doc("The requested capacity could not be fully satisfied due to insufficient quota in the subscription.")
  InsufficientQuota: "InsufficientQuota",

  @doc("The requested capacity was successfully satisfied without any partial fulfillment.")
  None: "None",

  string,
}

@added(Microsoft.Compute.Versions.`2026-08-06-preview`)
@doc("Controls how partial fulfillment is handled for a BulkCreateCustom request. When enabled, Azure creates only the VMs or vCPUs it has high confidence can be successfully allocated, instead of attempting the entire request and potentially returning allocation failures.")
model PartialFulfillmentPolicy {
  @visibility(Lifecycle.Read)
  @doc("The amount of capacity that was actually attempted, expressed in the units specified by capacityType. When partial fulfillment is enabled, this value can be less than the requested capacity.")
  fulfilledCapacity?: int32;

  @doc("Specifies whether partial fulfillment is allowed. When Enabled, Azure creates as many VMs as it has high confidence can be successfully allocated. When Disabled, Azure attempts to create all requested VMs, which may result into allocation failures.")
  mode?: PartialFulfillmentMode = PartialFulfillmentMode.Enabled;

  @visibility(Lifecycle.Read)
  @doc("Indicates why the fulfilled capacity is less than the requested capacity. Possible values include InsufficientCapacity and InsufficientQuota. Returned only in the create response when partial fulfillment is enabled and the request cannot be fully satisfied.")
  reason?: PartialFulfillmentReason;
}

@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
@doc("A virtual machine size and its selection priority.")
model VmSizeProfile {
  @doc("The virtual machine SKU, for example `Standard_D2ads_v5`.")
  @minLength(1)
  name: string;

  @doc("The customer-defined priority rank for this virtual machine size.")
  rank: int32;
}

@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
@doc("The priority and allocation preferences for virtual machines.")
model PriorityProfile {
  @doc("The priority type for virtual machine allocation.")
  type?: PriorityType;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "maxPricePerVM has VM which does not follow camel casing"
  @doc("The maximum hourly price, in US dollars, for each Spot virtual machine.")
  maxPricePerVM?: float32;

  @doc("The action applied to a Spot virtual machine when Azure evicts it.")
  evictionPolicy?: EvictionPolicy;

  @doc("The strategy used to select a virtual machine size.")
  allocationStrategy?: AllocationStrategy;
}

@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
@doc("An availability zone and its allocation priority.")
model ZonePreference {
  @doc("The availability zone identifier.")
  zone: string;

  @doc("The customer-defined priority rank for this availability zone.")
  rank: int32;
}

@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
@doc("The preferences for distributing virtual machines across availability zones.")
model ZoneAllocationPolicy {
  @doc("The strategy used to distribute virtual machines across availability zones.")
  distributionStrategy?: DistributionStrategy;

  @identifiers(#[])
  @doc("The availability zones and their allocation priorities.")
  zonePreferences?: Array<ZonePreference>;
}

@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
@doc("The allocation preferences for creating virtual machines for a virtual desktop infrastructure workload.")
model FlexProperties {
  @identifiers(#[])
  @doc("The virtual machine sizes that Bulk Actions can use, in customer-defined priority order.")
  @minItems(1)
  @maxItems(5)
  vmSizeProfiles: Array<VmSizeProfile>;

  #suppress "@azure-tools/typespec-client-generator-core/csharp-use-standard-acronyms" "Name kept for backward compatibility"
  @doc("The operating system type for the virtual machines.")
  osType: OsType;

  @doc("The priority and allocation preferences for the virtual machines.")
  priorityProfile: PriorityProfile;

  @doc("The preferences for distributing virtual machines across availability zones.")
  zoneAllocationPolicy?: ZoneAllocationPolicy;

  @added(Microsoft.Compute.Versions.`2026-07-06-preview`)
  @doc("The minimum number of virtual machines that must be created. Bulk Actions rejects the request when it cannot allocate this number.")
  minCapacity?: int32;
}

/**
 * Per-VM configuration overrides that can be applied within a bulk virtual machine operation.
 */
model BulkVMConfiguration {
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

  @doc("The availability zone placement constraints for the virtual machine.")
  placement?: Placement;

  /**
   * Resource tags to apply to the virtual machines created by this bulk action.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  @doc("The configuration properties for the virtual machine.")
  properties?: BulkactionVMProperties;

  @doc("The Microsoft.Compute API version that defines the virtual machine configuration supplied in the request.")
  computeApiVersion?: string;

  @doc("The name of the virtual machine. When omitted, Bulk Actions generates a name from the resource prefix.")
  name?: string;
}

@doc("The shared and per-virtual-machine configuration for a bulk create action.")
model ResourceProvisionPayload {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Free-form JSON object to allow loosely-typed VM configuration passthrough"
  @doc("The virtual machine configuration as a JSON object applied to every virtual machine in the bulk create action.")
  @typeChangedFrom(Versions.`2026-07-06-preview`, BulkVMConfiguration)
  baseProfile?: Record<unknown>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Free-form JSON objects to allow loosely-typed per-VM overrides"
  @doc("The per-virtual-machine configuration overrides for the bulk create action.")
  @identifiers(#[])
  @typeChangedFrom(Versions.`2026-07-06-preview`, BulkVMConfiguration[])
  resourceOverrides?: Record<unknown>[];

  @doc("The number of virtual machines to create.")
  resourceCount: int32;

  @doc("The prefix used by Bulk Actions to generate virtual machine names when a per-virtual-machine override does not specify `name`.")
  resourcePrefix?: string;
}

@doc("The virtual machine configuration and flexible allocation preferences for a virtual desktop infrastructure workload.")
model ResourceProvisionVdiPayload {
  ...ResourceProvisionPayload;

  @doc("The flexible allocation preferences for the virtual desktop infrastructure workload.")
  flexProperties: FlexProperties;
}

@doc("The retry settings for a bulk action.")
model RetryPolicy {
  @doc("The maximum number of retry attempts.")
  retryCount?: int32;

  @doc("The period, in minutes, during which Bulk Actions can retry the operation.")
  retryWindowInMinutes?: int32;

  @doc("The operation that Bulk Actions attempts when the requested operation fails.")
  onFailureAction?: ResourceOperationType;
}

@doc("The execution settings for a bulk action.")
model ExecutionParameters {
  @added(Microsoft.Compute.Versions.`2026-07-06-preview`)
  @doc("The preference used to optimize execution of the bulk action.")
  optimizationPreference?: OptimizationPreference;

  @doc("The retry settings for the bulk action.")
  retryPolicy?: RetryPolicy;

  @added(Microsoft.Compute.Versions.`2026-07-06-preview`)
  @doc("If true, Bulk Actions verifies the virtual machine guest agent health after a start operation. Setting this property to true for any other operation causes the request to fail.")
  verifyVmAgentHealth?: boolean;

  @added(Microsoft.Compute.Versions.`2026-08-06-preview`)
  @doc("Capacity recommendation parameters for the request. When provided on an executeStart request, the service computes placement recommendations only if the VM fails to start due to an allocation failure; the recommendations for the desired sizes and locations are then surfaced in the operation's capacityRecommendation response.")
  capacityRecommendationParameters?: CapacityRecommendationParameters;
}

@added(Microsoft.Compute.Versions.`2026-08-06-preview`)
@doc("The parameters used to request capacity/placement recommendations for a start operation. Placement recommendations are only computed if the VM fails to start due to an allocation failure.")
model CapacityRecommendationParameters {
  @doc("The list of desired Azure regions to be considered for the capacity recommendation")
  desiredLocations?: string[];

  @doc("The list of desired VM sizes (SKUs) to be considered for the capacity recommendation")
  desiredSizes?: string[];

  @doc("Whether the capacity recommendation should be computed per availability zone")
  availabilityZones?: boolean;
}

@doc("An error that occurred while processing one virtual machine.")
model ResourceOperationError {
  @doc("A code that identifies the error.")
  errorCode: string;

  @doc("A message that describes the error.")
  errorDetails: string;
}

@added(Microsoft.Compute.Versions.`2026-07-06-preview`)
@doc("Information about the flexible allocation of a virtual machine.")
model VmAllocationInfo {
  @doc("The virtual machine SKU, for example `Standard_D2ads_v5`.")
  vmSize?: string;

  @doc("The availability zone identifier.")
  zone?: string;
}

@doc("Information about an additional operation attempted after the requested operation did not succeed.")
model FallbackOperationInfo {
  @doc("The type of the additional operation.")
  lastOpType: ResourceOperationType;

  @doc("The status of the additional operation.")
  status: string;

  @doc("The error returned when the additional operation did not succeed.")
  error?: ResourceOperationError;
}

@doc("The status and settings for an operation on one virtual machine.")
model ResourceOperationDetails {
  @doc("The operation ID used to track the action for this virtual machine.")
  operationId: string;

  @doc("The Azure resource ID of the virtual machine.")
  resourceId?: armResourceIdentifier;

  @doc("The type of operation performed on the virtual machine.")
  opType?: ResourceOperationType = ResourceOperationType.Unknown;

  @doc("The subscription ID associated with the bulk action.")
  subscriptionId?: string;

  #suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Prefer using `utcDateTime` when representing a datetime unless an offset is necessary."
  @doc("The requested deadline for the operation.")
  deadline?: offsetDateTime;

  @doc("The behavior associated with the operation deadline.")
  deadlineType?: DeadlineType = DeadlineType.Unknown;

  @doc("The current state of the operation.")
  state?: OperationState = OperationState.Unknown;

  @doc("The time zone used to interpret the operation deadline.")
  timezone?: string;

  @doc("The error returned for the virtual machine, if the operation did not succeed.")
  resourceOperationError?: ResourceOperationError;

  @doc("Information about an additional operation attempted after the requested operation did not succeed.")
  fallbackOperationInfo?: FallbackOperationInfo;

  #suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Prefer using `utcDateTime` when representing a datetime unless an offset is necessary."
  @doc("The date and time when the operation completed.")
  completedAt?: offsetDateTime;

  @doc("The retry settings for the bulk action.")
  retryPolicy?: RetryPolicy;

  @added(Microsoft.Compute.Versions.`2026-07-06-preview`)
  @doc("The customer-provided context associated with the virtual machine result.")
  resourceNotificationDetails?: ResourceNotificationDetails;

  @added(Microsoft.Compute.Versions.`2026-08-06-preview`)
  @doc("The capacity/placement recommendation computed for the operation, if requested")
  capacityRecommendation?: CapacityRecommendation;
}

@added(Microsoft.Compute.Versions.`2026-08-06-preview`)
@doc("The lifecycle status of the capacity recommendation for an operation")
union CapacityRecommendationStatus {
  @doc("The capacity recommendation has not been initiated")
  NotInitiated: "NotInitiated",

  @doc("The capacity recommendation completed successfully")
  Succeeded: "Succeeded",

  @doc("The capacity recommendation failed")
  Failed: "Failed",

  @doc("The capacity recommendation was skipped")
  Skipped: "Skipped",

  string,
}

@added(Microsoft.Compute.Versions.`2026-08-06-preview`)
@doc("A desired VM size (SKU) considered for the capacity recommendation")
model CapacityRecommendationSize {
  @doc("The VM size (SKU) name")
  sku?: string;
}

@added(Microsoft.Compute.Versions.`2026-08-06-preview`)
@doc("The placement score for a given SKU, region and optionally availability zone")
model CapacityRecommendationPlacementScore {
  @doc("The VM size (SKU) name")
  sku?: string;

  @doc("The Azure region")
  region?: string;

  @doc("The availability zone identifier, present only when availabilityZones was requested")
  availabilityZone?: string;

  @doc("The placement score, eg High, Medium or Low")
  score?: string;

  @doc("Whether quota is available for the SKU, region and zone combination")
  isQuotaAvailable?: boolean;
}

@added(Microsoft.Compute.Versions.`2026-08-06-preview`)
@doc("The details of a capacity recommendation")
model CapacityRecommendationDetails {
  @doc("The list of desired Azure regions from the request")
  desiredLocations?: string[];

  @doc("The UTC timestamp of when the recommendation was requested")
  recommendationRequestedAtUtc?: utcDateTime;

  @doc("The list of desired VM sizes from the request")
  @identifiers(#[])
  desiredSizes?: CapacityRecommendationSize[];

  @doc("Whether the response is split by availability zone")
  availabilityZones?: boolean;

  @doc("The array of placement scores per SKU, region and zone")
  @identifiers(#[])
  placementScores?: CapacityRecommendationPlacementScore[];
}

@added(Microsoft.Compute.Versions.`2026-08-06-preview`)
@doc("The capacity/placement recommendation computed for a resource operation")
model CapacityRecommendation {
  @doc("The lifecycle status of the capacity recommendation")
  status: CapacityRecommendationStatus;

  @doc("The error message if the capacity recommendation failed")
  error?: string;

  @doc("The detailed error information if the capacity recommendation failed")
  errorDetails?: string;

  @doc("The details of the capacity recommendation")
  details?: CapacityRecommendationDetails;
}

@added(Microsoft.Compute.Versions.`2026-07-06-preview`)
@doc("Information about a virtual machine.")
model VirtualMachineInfo {
  @doc("The virtual machine SKU, for example `Standard_D2ads_v5`.")
  vmSize?: string;

  @doc("The availability zone identifier.")
  zone?: string;
}

@doc("The result of a bulk action for one virtual machine.")
model ResourceOperation {
  @doc("The Azure resource ID of the virtual machine.")
  resourceId?: armResourceIdentifier;

  @doc("A code that identifies the error for the virtual machine.")
  errorCode?: string;

  @doc("A message that describes the error for the virtual machine.")
  errorDetails?: string;

  @doc("The status and settings for the operation on the virtual machine.")
  operation?: ResourceOperationDetails;

  @added(Microsoft.Compute.Versions.`2026-07-06-preview`)
  @doc("Information about the virtual machine selected for the operation.")
  virtualMachineInfo?: VirtualMachineInfo;
}

#suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Prefer using `utcDateTime` when representing a datetime unless an offset is necessary."
@doc("An error associated with the action for one virtual machine.")
model OperationErrorDetails {
  @doc("A code that identifies the error.")
  errorCode: string;

  @doc("A message that describes the error.")
  errorDetails: string;

  @doc("The date and time when the error occurred.")
  timestamp?: offsetDateTime;

  @doc("The date and time when the error occurred.")
  timeStamp?: offsetDateTime;

  @doc("The Azure Compute operation name associated with the virtual machine operation.")
  azureOperationName?: string;

  @doc("The Azure Compute operation identifier associated with the virtual machine operation.")
  crpOperationId?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-offsetdatetime" "Prefer using `utcDateTime` when representing a datetime unless an offset is necessary."
@doc("The errors returned for one virtual machine operation.")
model OperationErrorsResult {
  @doc("The operation ID used to track the action for this virtual machine.")
  operationId?: string;

  @doc("The date and time when the error result was created.")
  creationTime?: offsetDateTime;

  @doc("The date and time when the virtual machine operation started.")
  activationTime?: offsetDateTime;

  @doc("The date and time when the operation completed.")
  completedAt?: offsetDateTime;

  @identifiers(#[])
  @doc("The errors associated with the action for this virtual machine.")
  operationErrors?: Array<OperationErrorDetails>;

  @doc("A code that identifies the request error.")
  requestErrorCode?: string;

  @doc("A message that describes the request error.")
  requestErrorDetails?: string;
}

@doc("The result of a bulk deallocate action.")
model DeallocateResourceOperationResponse {
  @doc("A description of the bulk action result.")
  description: string;

  @doc("The type of resources targeted by the bulk action.")
  type: string;

  @doc("The Azure region where Bulk Actions processes the request.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: azureLocation;

  @identifiers(#["resourceId"])
  @doc("The result for each virtual machine.")
  results?: Array<ResourceOperation>;
}

@doc("The result of a bulk start action.")
model StartResourceOperationResponse {
  @doc("A description of the bulk action result.")
  description: string;

  @doc("The type of resources targeted by the bulk action.")
  type: string;

  @doc("The Azure region where Bulk Actions processes the request.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: azureLocation;

  @identifiers(#["resourceId"])
  @doc("The result for each virtual machine.")
  results?: Array<ResourceOperation>;
}

@doc("The result of a bulk hibernate action.")
model HibernateResourceOperationResponse {
  @doc("A description of the bulk action result.")
  description: string;

  @doc("The type of resources targeted by the bulk action.")
  type: string;

  @doc("The Azure region where Bulk Actions processes the request.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: azureLocation;

  @identifiers(#["resourceId"])
  @doc("The result for each virtual machine.")
  results?: Array<ResourceOperation>;
}

// ----------- Execute Operations Request ---------
@doc("The virtual machines and execution settings for a bulk deallocate action.")
model ExecuteDeallocateRequest {
  @doc("The execution settings for the bulk action.")
  executionParameters: ExecutionParameters;

  @doc("The target virtual machines. Do not specify this property together with `resourcesWithContext`.")
  @madeOptional(Microsoft.Compute.Versions.`2026-07-06-preview`)
  resources?: Resources;

  @added(Microsoft.Compute.Versions.`2026-07-06-preview`)
  @doc("The target virtual machines with customer-provided tracking context. Do not specify this property together with `resources`.")
  resourcesWithContext?: ResourcesWithContext;
}

@doc("The virtual machines and execution settings for a bulk hibernate action.")
model ExecuteHibernateRequest {
  @doc("The execution settings for the bulk action.")
  executionParameters: ExecutionParameters;

  @doc("The target virtual machines. Do not specify this property together with `resourcesWithContext`.")
  @madeOptional(Microsoft.Compute.Versions.`2026-07-06-preview`)
  resources?: Resources;

  @added(Microsoft.Compute.Versions.`2026-07-06-preview`)
  @doc("The target virtual machines with customer-provided tracking context. Do not specify this property together with `resources`.")
  resourcesWithContext?: ResourcesWithContext;
}

@doc("The virtual machines and execution settings for a bulk start action.")
model ExecuteStartRequest {
  @doc("The execution settings for the bulk action.")
  executionParameters: ExecutionParameters;

  @doc("The target virtual machines. Do not specify this property together with `resourcesWithContext`.")
  @madeOptional(Microsoft.Compute.Versions.`2026-07-06-preview`)
  resources?: Resources;

  @added(Microsoft.Compute.Versions.`2026-07-06-preview`)
  @doc("The target virtual machines with customer-provided tracking context. Do not specify this property together with `resources`.")
  resourcesWithContext?: ResourcesWithContext;
}

@doc("The virtual machine configuration and execution settings for a bulk create action.")
model ExecuteCreateRequest {
  @doc("The shared and per-virtual-machine creation configuration.")
  resourceConfigParameters: ResourceProvisionPayload;

  @doc("The execution settings for the bulk action.")
  executionParameters: ExecutionParameters;
}

@doc("The virtual machine configuration and flexible allocation preferences for a virtual desktop infrastructure workload.")
model ExecuteVdiCreateRequest {
  @doc("The creation configuration and flexible allocation preferences.")
  resourceConfigParameters: ResourceProvisionVdiPayload;

  @doc("The execution settings for the bulk action.")
  executionParameters: ExecutionParameters;
}

@doc("A reimage configuration override for one virtual machine.")
model ReimageResourceOverride {
  @doc("The Azure resource ID of the virtual machine to which the override applies.")
  resourceId: armResourceIdentifier<[
    {
      type: "Microsoft.Compute/virtualMachines";
    }
  ]>;

  @doc("The reimage configuration for this virtual machine.")
  profile: VirtualMachineReimageParameters;
}

@doc("The shared and per-virtual-machine configuration for a bulk reimage action.")
model ReimagePayload {
  @doc("The reimage configuration applied to every virtual machine unless a per-virtual-machine override is provided.")
  baseProfile?: VirtualMachineReimageParameters;

  @identifiers(#[])
  @doc("The reimage configuration overrides for individual virtual machines.")
  resourceOverrides?: ReimageResourceOverride[];
}

@doc("The virtual machines and configuration for a bulk reimage action.")
model ExecuteReimageRequest {
  @doc("The execution settings for the bulk action.")
  executionParameters: ExecutionParameters;

  @doc("The target virtual machines. Do not specify this property together with `resourcesWithContext`.")
  @madeOptional(Microsoft.Compute.Versions.`2026-07-06-preview`)
  resources?: Resources;

  @added(Microsoft.Compute.Versions.`2026-07-06-preview`)
  @doc("The target virtual machines with customer-provided tracking context. Do not specify this property together with `resources`.")
  resourcesWithContext?: ResourcesWithContext;

  @doc("The shared and per-virtual-machine reimage configuration.")
  reimageParameters?: ReimagePayload;
}

@doc("The result of a bulk create action.")
model CreateResourceOperationResponse {
  @doc("A description of the bulk action result.")
  description: string;

  @doc("The type of resources targeted by the bulk action.")
  type: string;

  @doc("The Azure region where Bulk Actions processes the request.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: azureLocation;

  @identifiers(#["resourceId"])
  @doc("The result for each virtual machine.")
  results?: Array<ResourceOperation>;
}

@doc("The result of a bulk reimage action.")
model ReimageResourceOperationResponse {
  @doc("A description of the bulk action result.")
  description: string;

  @doc("The type of resources targeted by the bulk action.")
  type: string;

  @doc("The Azure region where Bulk Actions processes the request.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: azureLocation;

  @identifiers(#["resourceId"])
  @doc("The result for each virtual machine.")
  results?: Array<ResourceOperation>;
}

@doc("The result of a bulk delete action.")
model DeleteResourceOperationResponse {
  @doc("A description of the bulk action result.")
  description: string;

  @doc("The type of resources targeted by the bulk action.")
  type: string;

  @doc("The Azure region where Bulk Actions processes the request.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: azureLocation;

  @identifiers(#["resourceId"])
  @doc("The result for each virtual machine.")
  results?: Array<ResourceOperation>;
}

@doc("The virtual machines and execution settings for a bulk delete action.")
model ExecuteDeleteRequest {
  @doc("The execution settings for the bulk action.")
  executionParameters: ExecutionParameters;

  @doc("The target virtual machines. Do not specify this property together with `resourcesWithContext`.")
  @madeOptional(Microsoft.Compute.Versions.`2026-07-06-preview`)
  resources?: Resources;

  @added(Microsoft.Compute.Versions.`2026-07-06-preview`)
  @doc("The target virtual machines with customer-provided tracking context. Do not specify this property together with `resources`.")
  resourcesWithContext?: ResourcesWithContext;

  @doc("Indicates whether Bulk Actions uses forced deletion for the target virtual machines.")
  forceDeletion?: boolean;
}

// ----------- GetOperationStatus ---------
@doc("The operation for which current status should be returned.")
model GetOperationStatusRequest {
  @doc("The Bulk Action Operation Ids that identify the operations for which current status should be returned.")
  operationIds: Array<string>;
}

@doc("The current results for the requested operations.")
model GetOperationStatusResponse {
  @identifiers(#["resourceId"])
  @doc("The current result for each requested operation.")
  results: Array<ResourceOperation>;
}

@added(Microsoft.Compute.Versions.`2026-08-06-preview`)
@doc("The paged response for virtual machine operation statuses in a BulkCreateCustom operation.")
model BulkCreateCustomOperationStatusListResult {
  @pageItems
  @identifiers(#["resourceId"])
  @doc("The virtual machine operation statuses on this page.")
  results: Array<ResourceOperation>;

  @nextLink
  @doc("The link to the next page of operation statuses.")
  nextLink?: url;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("The singleton endpoint used to access Virtual Machine Bulk Operations.")
model BulkVmOperationsReadResponse {
  @doc("The fully qualified Azure resource ID of the singleton endpoint.")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("The name of the singleton endpoint.")
  @visibility(Lifecycle.Read)
  name: "bulkVmOperations";

  @doc("The Azure resource type of the singleton endpoint.")
  @visibility(Lifecycle.Read)
  type: "Microsoft.Compute/locations/virtualMachines/bulkVmOperations";
}

// ----------- CancelOperations ---------
@doc("The eligible operations to cancel.")
model CancelOperationsRequest {
  @doc("The Bulk Action Operation Ids that identify the operations to cancel.")
  operationIds: Array<string>;
}

@doc("The results of the cancellation requests.")
model CancelOperationsResponse {
  @identifiers(#["resourceId"])
  @doc("The current result for each operation submitted for cancellation.")
  results: Array<ResourceOperation>;
}

// ----------- BulkOperationErrors ---------
@@identifiers(ListBulkOperationErrorsResponse.value, #[]);
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@added(Versions.`2026-07-06-preview`)
@doc("A paged list of recent bulk action errors.")
model ListBulkOperationErrorsResponse is Azure.Core.Page<ResourceOperation>;

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@added(Versions.`2026-07-06-preview`)
@doc("The result of acknowledging errors for specified operations.")
model AcknowledgeBulkOperationErrorsResponse {
  @doc("The Bulk Action Operation Ids that identify operations with acknowledged errors.")
  acknowledged: Array<string>;

  @doc("The Bulk Action Operation Ids that were not found or are no longer available.")
  notFound: Array<string>;

  @doc("The Bulk Action Operation Ids that identify operations with errors that could not be acknowledged.")
  skipped: Array<string>;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@added(Versions.`2026-07-06-preview`)
@doc("The operations for which errors should be acknowledged.")
model AcknowledgeBulkOperationErrorsRequest {
  @doc("The Bulk Action Operation Ids that identify operations for which errors should be acknowledged.")
  operationIds: Array<string>;
}
