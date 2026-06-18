import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";
import "./models.tsp";
import "./vmAttributes.tsp";
import "./virtualMachineProfile.tsp";
import "./virtualMachineExtension.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Compute;

// ============================================================
// Path parameter helpers for LaunchBulkInstancesOperation.
// Kept scoped to this file alongside the resource-key alias for
// the launchBulkInstancesOperations and operations segments.
// ============================================================

alias LaunchLocationParameter = {
  /** The location name. */
  @path
  @minLength(1)
  @segment("locations")
  @key
  location: azureLocation;
};

alias LaunchBulkInstancesOperationId = {
  /** The name of the LaunchBulkInstancesOperation. */
  @path
  @minLength(1)
  @segment("launchBulkInstancesOperations")
  @key
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  name: string;
};

alias DeleteInstancesParameter = {
  /** When true, deletes all virtual machines created by this BulkAction Operation. */
  @query
  deleteInstances?: boolean;
};

alias LaunchCommonParams = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ResourceGroupParameter;
};

alias LaunchSubscriptionParams = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
};

alias LaunchCustomParams = {
  ...LaunchCommonParams;
  ...ProviderNamespace<LocationBasedLaunchBulkInstancesOperation>;
  ...LaunchLocationParameter;
  ...LaunchBulkInstancesOperationId;
};

// ============================================================
// Enums
// ============================================================

@Azure.Core.lroStatus
@doc("The status of the LaunchBulkInstancesOperation.")
union ProvisioningState {
  @doc("Initial creation in progress.")
  Creating: "Creating",

  @doc("The operation has completed successfully.")
  Succeeded: "Succeeded",

  @doc("The operation has failed.")
  Failed: "Failed",

  @doc("Deletion in progress.")
  Deleting: "Deleting",

  @doc("The operation has been canceled.")
  Canceled: "Canceled",

  string,
}

@doc("Capacity types for LaunchBulkInstancesOperation.")
union CapacityType {
  @doc("Default. VM is the default capacity type for LaunchBulkInstancesOperation where capacity is provisioned in terms of VMs.")
  VM: "VM",

  @doc("VCpu is the capacity type for LaunchBulkInstancesOperation where capacity is provisioned in terms of VCpus. If VCpu capacity is not exactly divisible by VCpu count in VMSizes, capacity in VCpus will be overprovisioned by default.")
  VCpu: "VCpu",

  string,
}

@doc("Different kind of eviction policies")
union EvictionPolicy {
  @doc("When evicted, the Spot VM will be deleted and the corresponding capacity will be updated to reflect this.")
  Delete: "Delete",

  @doc("When evicted, the Spot VM will be deallocated/stopped")
  Deallocate: "Deallocate",

  string,
}

@doc("Distribution strategies for LaunchBulkInstancesOperation zone allocation policy.")
union ZoneDistributionStrategy {
  @doc("Default. Launch instances in a single zone based on best effort. If capacity is not available, LaunchBulkInstancesOperation can allocate capacity in different zones.")
  BestEffortSingleZone: "BestEffortSingleZone",

  @doc("Launch instances based on zone preferences. Higher priority zones are filled first before allocating to lower priority zones.")
  Prioritized: "Prioritized",

  @doc("Balance launching instances across zones specified based on best effort. If capacity is not available, LaunchBulkInstancesOperation can deviate balancing across all zones.")
  BestEffortBalanced: "BestEffortBalanced",

  @doc("Launch instances across all provided zones, ensuring the difference between any two zones is no more than one instance.")
  StrictBalanced: "StrictBalanced",

  string,
}

@doc("Virtual Machine operation status values.")
union VMOperationStatus {
  @doc("Indicates that the virtual machine is either in the process of being created or is scheduled to be created.")
  Creating: "Creating",

  @doc("Indicates that the cancellation request was successful because the virtual machine had not been created yet.")
  Canceled: "Canceled",

  @doc("Indicates that the cancellation request could not be applied because the virtual machine had already been created.")
  CancelFailedStatusUnknown: "CancelFailedStatusUnknown",

  @doc("Indicates that the virtual machine operation failed.")
  Failed: "Failed",

  @doc("Indicates that the virtual machine operation completed successfully.")
  Succeeded: "Succeeded",

  @doc("Indicates that the virtual machine is being deleted.")
  Deleting: "Deleting",

  @doc("Indicates that the virtual machine operation is being cancelled.")
  Cancelling: "Cancelling",

  string,
}

// ============================================================
// Supporting models
// ============================================================

@doc("Compute Profile to configure the Virtual Machines.")
model ComputeProfile {
  @doc("Base Virtual Machine Profile Properties to be specified according to specification/compute/resource-manager/Microsoft.Compute/ComputeRP/stable/{computeApiVersion}/virtualMachine.json#/definitions/VirtualMachineProperties")
  virtualMachineProfile: BulkactionVMProperties;

  @identifiers(#["name"])
  @doc("Virtual Machine Extensions Array to be specified according to specification/compute/resource-manager/Microsoft.Compute/ComputeRP/stable/{computeApiVersion}/virtualMachine.json#/definitions/VirtualMachineExtension")
  extensions?: Array<BulkactionVMExtension>;

  @doc("Specifies the Microsoft.Compute API version to use when creating underlying Virtual Machines. The default value will be the latest supported computeApiVersion by LaunchBulkInstancesOperation.")
  computeApiVersion?: string;
}

@doc("API error base.")
model ApiErrorBase {
  @doc("The error code.")
  code?: string;

  @doc("The target of the particular error.")
  target?: string;

  @doc("The error message.")
  message?: string;
}

@doc("Inner error details.")
model InnerError {
  @doc("The exception type.")
  exceptionType?: string;

  @doc("The internal error message or exception dump.")
  errorDetail?: string;
}

@doc("ApiError for Fleet")
model ApiError is ApiErrorBase {
  @identifiers(#["message", "target"])
  @doc("The API error details")
  details?: Array<ApiErrorBase>;

  @doc("The API inner error")
  innererror?: InnerError;
}

@doc("A virtual machine launched by a LaunchBulkInstancesOperation.")
model VirtualMachine {
  @doc("The name of the virtual machine.")
  @key("virtualMachineName")
  @segment("virtualMachines")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The compute RP resource id of the virtual machine. subscriptions/{subId}/resourceGroups/{rgName}/providers/Microsoft.Compute/virtualMachines/{vmName}")
  @visibility(Lifecycle.Read)
  id: armResourceIdentifier;

  @doc("Type of the virtual machine")
  @visibility(Lifecycle.Read)
  type?: string;

  @doc("Represents the operationStatus of the virtual machine in response to the last operation performed on it by the LaunchBulkInstancesOperation.")
  @visibility(Lifecycle.Read)
  operationStatus: VMOperationStatus;

  @doc("Error information when operationStatus is Failed.")
  @visibility(Lifecycle.Read)
  error?: ApiError;
}

@doc("The response of a virtual machine list operation.")
model VirtualMachineListResult {
  @pageItems
  @doc("The Virtual Machine items on this page.")
  value: Array<VirtualMachine>;

  @nextLink
  @doc("The link to the next page of items.")
  nextLink?: url;
}

// ============================================================
// Resource: LaunchBulkInstancesOperation
// ============================================================

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Bare envelope used as the @listsResource target; shape is documented via LocationBasedLaunchBulkInstancesOperation."
@doc("Envelope properties shared by LaunchBulkInstancesOperation. Used as the @listsResource target to avoid collision with the interface name.")
model LaunchBulkInstancesOperationEnvelope {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Zones is a valid envelope property for this resource."
  @doc("Zones in which the LaunchBulkInstancesOperation is available")
  zones?: Array<string>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Tags free-form object matches the established compute contract."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Tags is a standard ARM resource property."
  @doc("Resource tags.")
  tags?: Record<string>;

  ...ManagedServiceIdentityProperty;
  ...ResourcePlanProperty;
}

@doc("Location based LaunchBulkInstancesOperation resource. The location is part of the resource path.")
model LocationBasedLaunchBulkInstancesOperation
  is Azure.ResourceManager.ProxyResource<LaunchBulkInstancesOperationProperties> {
  @doc("The location name.")
  @path
  @minLength(1)
  @segment("locations")
  @key
  @visibility(Lifecycle.Read)
  location: azureLocation;

  ...LaunchBulkInstancesOperationEnvelope;
}

@doc("Details of the LaunchBulkInstancesOperation.")
model LaunchBulkInstancesOperationProperties {
  @visibility(Lifecycle.Read)
  @doc("The UTC time the LaunchBulkInstancesOperation resource was created.")
  createdTime?: utcDateTime;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("Total capacity to achieve. It can be in terms of VMs or vCPUs.")
  @minValue(1)
  capacity: int32;

  @doc("Specifies capacity type for launching instances. It can be in terms of VMs or vCPUs.")
  capacityType?: CapacityType;

  @doc("Configuration Options for Regular or Spot instances in LaunchBulkInstancesOperation.")
  priorityProfile: PriorityProfile;

  @identifiers(#[])
  @doc("List of VM sizes supported for LaunchBulkInstancesOperation")
  vmSizesProfile?: Array<VmSizeProfile>;

  @doc("Attributes to launch instances.")
  vmAttributes?: VMAttributes;

  @doc("Compute Profile to configure the Virtual Machines.")
  computeProfile: ComputeProfile;

  @doc("Zone Allocation Policy for launching instances.")
  zoneAllocationPolicy?: ZoneAllocationPolicy;

  @doc("Retry policy the user can pass")
  retryPolicy?: RetryPolicy;
}

@doc("List of LaunchBulkInstancesOperation resources.")
model LaunchBulkInstancesOperationListResult {
  @pageItems
  @identifiers(#["id"])
  @doc("The list of LaunchBulkInstancesOperation resources.")
  value: LocationBasedLaunchBulkInstancesOperation[];

  @nextLink
  @doc("The URL to get the next set of results.")
  nextLink?: string;
}

// ============================================================
// Routes: BulkActions interface (8 operations)
// ============================================================

@removed(Versions.`2026-06-06`)
@armResourceOperations(#{ allowStaticRoutes: true })
interface LaunchBulkInstancesOperation {
  @doc("Gets an instance of LaunchBulkInstancesOperations.")
  get is ArmResourceRead<
    Resource = LocationBasedLaunchBulkInstancesOperation,
    Parameters = LaunchBulkInstancesOperationId,
    Response = ArmResponse<LocationBasedLaunchBulkInstancesOperation>
  >;

  @doc("Get the status of a LaunchBulkInstancesOperation.")
  @get
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/launchBulkInstancesOperations/asyncOperations/{asyncOperationId}")
  getOperationStatus(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    @doc("The location name.")
    @path
    @minLength(1)
    location: azureLocation,

    @doc("The async operation id.")
    @path
    @minLength(1)
    @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
    asyncOperationId: string,
  ):
    | ArmResponse<Azure.ResourceManager.CommonTypes.OperationStatusResult>
    | ErrorResponse;

  @doc("Creates or updates LaunchBulkInstancesOperations.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    Resource = LocationBasedLaunchBulkInstancesOperation,
    Parameters = LaunchBulkInstancesOperationId
  >;

  @doc("Deletes LaunchBulkInstancesOperations.")
  delete is ArmResourceDeleteWithoutOkAsync<
    Resource = LocationBasedLaunchBulkInstancesOperation,
    Parameters = LaunchBulkInstancesOperationId & DeleteInstancesParameter
  >;

  @doc("Cancels LaunchBulkInstancesOperation instances that have not yet launched.")
  cancel is ArmResourceActionNoResponseContentAsync<
    Resource = LocationBasedLaunchBulkInstancesOperation,
    Request = void,
    Parameters = LaunchBulkInstancesOperationId
  >;

  @doc("List LaunchBulkInstancesOperation resources by resource group.")
  @get
  @autoRoute
  @action("launchBulkInstancesOperations")
  @list
  @listsResource(LaunchBulkInstancesOperationEnvelope)
  @armResourceList(LocationBasedLaunchBulkInstancesOperation)
  listByResourceGroup(
    ...LaunchCommonParams,
    ...ProviderNamespace<LocationBasedLaunchBulkInstancesOperation>,
    ...LaunchLocationParameter,
  ): ArmResponse<LaunchBulkInstancesOperationListResult> | ErrorResponse;

  @doc("List LaunchBulkInstancesOperation resources by subscriptionId.")
  @get
  @autoRoute
  @action("launchBulkInstancesOperations")
  @list
  @listsResource(LaunchBulkInstancesOperationEnvelope)
  @armResourceList(LocationBasedLaunchBulkInstancesOperation)
  listBySubscription(
    ...LaunchSubscriptionParams,
    ...ProviderNamespace<LocationBasedLaunchBulkInstancesOperation>,
    ...LaunchLocationParameter,
  ): ArmResponse<LaunchBulkInstancesOperationListResult> | ErrorResponse;

  @doc("List VirtualMachine resources of a LaunchBulkInstancesOperation.")
  @autoRoute
  @listsResource(VirtualMachine)
  @armResourceList(VirtualMachine)
  @list
  @get
  listVirtualMachines(
    ...LaunchCustomParams,

    @doc("Filter expression to filter the virtual machines.")
    @query
    $filter?: string,

    @doc("Skip token for pagination. Uses the token from a previous response to fetch the next page of results.")
    @query
    $skiptoken?: string,
  ): ArmResponse<VirtualMachineListResult> | ErrorResponse;
}
