import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";
import "./models.tsp";
import "./virtualMachineProfile.tsp";
import "./launchBulkInstancesOperation.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Compute;

// ============================================================
// Path parameter helpers for BulkCreate.
// Mirrors BulkCreateCustom but binds the bulkCreate
// resource-key segment.
// ============================================================

alias BulkCreateLocationParameter = {
  /** The location name. */
  @path
  @minLength(1)
  @segment("locations")
  @key
  location: azureLocation;
};

alias BulkCreateId = {
  /** The name of the BulkCreate. The value must be an UUID. */
  @path
  @minLength(1)
  @segment("bulkCreate")
  @key
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  name: string;
};

alias BulkCreateDeleteInstancesParameter = {
  /** When true, deletes all virtual machines created by this BulkAction Operation. */
  @query
  deleteInstances?: boolean;
};

alias BulkCreateCommonParams = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ResourceGroupParameter;
};

alias BulkCreateSubscriptionParams = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
};

// ============================================================
// Resource: BulkCreate
//
// The uniform sibling of BulkCreateCustom. Every virtual machine is
// created from the operation-level computeProfile, so there is no
// per-VM or per-VM-size override surface. Because a single operation
// can create up to 10,000 virtual machines, the resource body never
// carries the resolved per-VM resources; callers enumerate them
// through virtualMachinesGetOperationStatus instead.
//
// Reuses the shared enums (ProvisioningState, CapacityType, ...), the
// shared ComputeProfile, PriorityProfile, ZoneAllocationPolicy,
// PartialFulfillmentPolicy, and ExecutionParameters.
// ============================================================

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Bare envelope used as the @listsResource target; shape is documented via LocationBasedBulkCreate."
@added(Versions.`2026-09-06-preview`)
@doc("Envelope properties shared by BulkCreate. Used as the @listsResource target to avoid collision with the interface name.")
model BulkCreateEnvelope {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Zones is a valid envelope property for this resource."
  @doc("Zones in which the BulkCreate is available")
  zones?: Array<string>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Tags free-form object matches the established compute contract."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Tags is a standard ARM resource property."
  @doc("Resource tags.")
  tags?: Record<string>;

  ...ManagedServiceIdentityProperty;
  ...ResourcePlanProperty;
}

@added(Versions.`2026-09-06-preview`)
@doc("Location based BulkCreate resource. The location is part of the resource path.")
model LocationBasedBulkCreate
  is Azure.ResourceManager.ProxyResource<BulkCreateProperties> {
  @doc("The location name.")
  @path
  @minLength(1)
  @segment("locations")
  @key
  @visibility(Lifecycle.Read)
  location: azureLocation;

  ...BulkCreateEnvelope;
}

@added(Versions.`2026-09-06-preview`)
@doc("A VM size that the service may select for a BulkCreate operation.")
model BulkCreateVmSizeProfile {
  @doc("The name of the VM size, eg Standard_D2ads_v5")
  @minLength(1)
  name: string;

  @doc("The rank of this VM size in the priority order, starting at 0, where a lower value is preferred. Used when priorityProfile.allocationStrategy is Prioritized.")
  rank?: int32;
}

@added(Versions.`2026-09-06-preview`)
@doc("Details of the BulkCreate.")
model BulkCreateProperties {
  @visibility(Lifecycle.Read)
  @doc("The UTC time the BulkCreate resource was created.")
  createdTime?: utcDateTime;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("Total capacity to achieve. It can be in terms of VMs or vCPUs.")
  @minValue(1)
  capacity: int32;

  @doc("Specifies capacity type for launching instances. It can be in terms of VMs or vCPUs.")
  capacityType?: CapacityType;

  @doc("The minimum capacity, expressed in units specified by capacityType, that Azure must be able to allocate for the request to proceed. If Azure cannot allocate at least this capacity with high confidence, the request is rejected with 409 Conflict (InsufficientCapacity) and no VMs are created. Otherwise, Azure allocates as much capacity as possible, up to the requested capacity. Must be greater than 0, less than capacity, and requires partialFulfillmentPolicy.mode to be Enabled.")
  @minValue(1)
  minCapacity?: int32;

  @doc("Controls how partial fulfillment is handled for a BulkCreate request. When enabled, Azure creates only the VMs or vCPUs it has high confidence can be successfully allocated, instead of attempting the entire request and potentially returning allocation failures.")
  partialFulfillmentPolicy?: PartialFulfillmentPolicy;

  @doc("Configuration Options for Regular or Spot instances in BulkCreate.")
  priorityProfile: PriorityProfile;

  @identifiers(#[])
  @doc("List of VM sizes supported for BulkCreate. Every virtual machine is created from the operation-level computeProfile regardless of the size selected, so no per-VM-size override can be supplied here.")
  vmSizesProfile?: Array<BulkCreateVmSizeProfile>;

  @doc("Compute Profile to configure the Virtual Machines. Applied uniformly to every virtual machine created by the operation.")
  computeProfile: ComputeProfile;

  @doc("Zone Allocation Policy for launching instances.")
  zoneAllocationPolicy?: ZoneAllocationPolicy;

  @doc("Extra parameters that control how the request is executed, including the retry policy.")
  executionParameters?: ExecutionParameters;
}

@added(Versions.`2026-09-06-preview`)
@doc("List of BulkCreate resources.")
model BulkCreateListResult {
  @pageItems
  @identifiers(#["id"])
  @doc("The list of BulkCreate resources.")
  value: LocationBasedBulkCreate[];

  @nextLink
  @doc("The URL to get the next set of results.")
  nextLink?: url;
}

@added(Versions.`2026-09-06-preview`)
@doc("The paged response for virtual machine operation statuses in a BulkCreate operation.")
model BulkCreateOperationStatusListResult {
  @pageItems
  @identifiers(#["resourceId"])
  @doc("The virtual machine operation statuses on this page.")
  results: Array<ResourceOperation>;

  @nextLink
  @doc("The link to the next page of operation statuses.")
  nextLink?: url;
}

// ============================================================
// Routes: BulkCreate interface (8 operations)
// ============================================================

@added(Versions.`2026-09-06-preview`)
@armResourceOperations(#{ allowStaticRoutes: true })
interface BulkCreate {
  @doc("Gets an instance of BulkCreates.")
  get is ArmResourceRead<
    Resource = LocationBasedBulkCreate,
    Parameters = BulkCreateId,
    Response = ArmResponse<LocationBasedBulkCreate>
  >;

  @doc("Get the status of an async operation of a BulkCreate.")
  @get
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/bulkCreate/asyncOperations/{asyncOperationId}")
  getAsyncOperationStatus(
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

  @doc("Creates or updates BulkCreates.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    Resource = LocationBasedBulkCreate,
    Parameters = BulkCreateId
  >;

  @doc("Deletes BulkCreates.")
  delete is ArmResourceDeleteWithoutOkAsync<
    Resource = LocationBasedBulkCreate,
    Parameters = BulkCreateId & BulkCreateDeleteInstancesParameter
  >;

  @doc("Cancels BulkCreate instances that have not yet launched.")
  cancel is ArmResourceActionNoResponseContentAsync<
    Resource = LocationBasedBulkCreate,
    Request = void,
    Parameters = BulkCreateId
  >;

  @doc("Gets the operation status for virtual machines in a BulkCreate operation.")
  @list
  virtualMachinesGetOperationStatus is ArmResourceActionSync<
    Resource = LocationBasedBulkCreate,
    Request = void,
    Response = ArmResponse<BulkCreateOperationStatusListResult>,
    Parameters = BulkCreateId
  >;

  @doc("List BulkCreate resources by resource group.")
  @get
  @autoRoute
  @action("bulkCreate")
  @list
  @listsResource(BulkCreateEnvelope)
  @armResourceList(LocationBasedBulkCreate)
  listByResourceGroup(
    ...BulkCreateCommonParams,
    ...ProviderNamespace<LocationBasedBulkCreate>,
    ...BulkCreateLocationParameter,
  ): ArmResponse<BulkCreateListResult> | ErrorResponse;

  @doc("List BulkCreate resources by subscriptionId.")
  @get
  @autoRoute
  @action("bulkCreate")
  @list
  @listsResource(BulkCreateEnvelope)
  @armResourceList(LocationBasedBulkCreate)
  listBySubscription(
    ...BulkCreateSubscriptionParams,
    ...ProviderNamespace<LocationBasedBulkCreate>,
    ...BulkCreateLocationParameter,
  ): ArmResponse<BulkCreateListResult> | ErrorResponse;
}
