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
  /** The Azure region that contains the bulk create operations. */
  @path
  @minLength(1)
  @segment("locations")
  @key
  location: azureLocation;
};

alias BulkCreateId = {
  /** The name of the bulk create operation. The value must be a UUID. */
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

@added(Versions.`2026-09-06-preview`)
@doc("Settings shared by the virtual machines created by a bulk create operation.")
model BulkCreateEnvelope {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Zones is a valid envelope property for this resource."
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("The availability zones in which to create the virtual machines.")
  zones?: Array<string>;

  // Spread the ARM common-types envelope property; versioning and docs are
  // applied below via augment decorators.
  ...ExtendedLocationProperty;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Placement matches the established compute contract and is applied uniformly to every virtual machine created by the operation."
  @added(Versions.`2026-10-06-preview`)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("The availability zone placement constraints applied to the virtual machines created by the BulkCreate operation.")
  placement?: Placement;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Tags free-form object matches the established compute contract."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Tags is a standard ARM resource property."
  @doc("Tags applied to the virtual machines created by the operation.")
  tags?: Record<string>;

  ...ManagedServiceIdentityProperty;
  ...ResourcePlanProperty;
}

@@added(BulkCreateEnvelope.extendedLocation, Versions.`2026-10-06-preview`);
@@doc(
  BulkCreateEnvelope.extendedLocation,
  "The extended location of the virtual machines created by the BulkCreate operation."
);

@added(Versions.`2026-09-06-preview`)
@doc("A bulk create operation that creates virtual machines from a shared compute profile. The Azure region is specified in the resource path.")
model LocationBasedBulkCreate
  is Azure.ResourceManager.ProxyResource<BulkCreateProperties> {
  @doc("The Azure region in which the virtual machines are created.")
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
@doc("Settings and status for a bulk create operation.")
model BulkCreateProperties {
  @visibility(Lifecycle.Read)
  @doc("The time the bulk create operation was created, in UTC.")
  createdTime?: utcDateTime;

  @visibility(Lifecycle.Read)
  @doc("The provisioning state of the bulk create operation.")
  provisioningState?: ProvisioningState;

  @doc("The requested capacity, measured in the units specified by capacityType.")
  @minValue(1)
  capacity: int32;

  @doc("The unit used to measure capacity: virtual machines or virtual CPUs.")
  capacityType?: CapacityType;

  @removed(Versions.`2026-10-06-preview`)
  @doc("The minimum capacity, expressed in units specified by capacityType, that Azure must be able to allocate for the request to proceed. If Azure cannot allocate at least this capacity with high confidence, the request is rejected with 409 Conflict (InsufficientCapacity) and no VMs are created. Otherwise, Azure allocates as much capacity as possible, up to the requested capacity. Must be greater than 0, less than capacity, and requires partialFulfillmentPolicy.mode to be Enabled.")
  @minValue(1)
  minCapacity?: int32;

  @removed(Versions.`2026-10-06-preview`)
  @doc("Controls how partial fulfillment is handled for a BulkCreate request. When enabled, Azure creates only the VMs or vCPUs it has high confidence can be successfully allocated, instead of attempting the entire request and potentially returning allocation failures.")
  partialFulfillmentPolicy?: PartialFulfillmentPolicy;

  @removed(Versions.`2026-10-06-preview`)
  @doc("Configuration Options for Regular or Spot instances in BulkCreate.")
  priorityProfile: PriorityProfile;

  @removed(Versions.`2026-10-06-preview`)
  @identifiers(#[])
  @doc("List of VM sizes supported for BulkCreate. Every virtual machine is created from the operation-level computeProfile regardless of the size selected, so no per-VM-size override can be supplied here.")
  vmSizesProfile?: Array<BulkCreateVmSizeProfile>;

  @doc("The compute profile applied to every virtual machine created by the operation.")
  computeProfile: ComputeProfile;

  @removed(Versions.`2026-10-06-preview`)
  @doc("Zone Allocation Policy for launching instances.")
  zoneAllocationPolicy?: ZoneAllocationPolicy;

  @doc("Extra parameters that control how the request is executed, including the retry policy.")
  executionParameters?: ExecutionParameters;
}

@added(Versions.`2026-09-06-preview`)
@doc("A page of bulk create operations.")
model BulkCreateListResult {
  @pageItems
  @identifiers(#["id"])
  @doc("The bulk create operations on this page.")
  value: LocationBasedBulkCreate[];

  @nextLink
  @doc("The URL to get the next set of results.")
  nextLink?: url;
}

@added(Versions.`2026-09-06-preview`)
@doc("A page of per-virtual-machine operation statuses for a bulk create operation.")
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
// Routes: BulkCreate interface
// ============================================================

@added(Versions.`2026-09-06-preview`)
@armResourceOperations(#{ allowStaticRoutes: true })
interface BulkCreate {
  @doc("Gets a bulk create operation and its provisioning state.")
  get is ArmResourceRead<
    Resource = LocationBasedBulkCreate,
    Parameters = BulkCreateId,
    Response = ArmResponse<LocationBasedBulkCreate>
  >;

  @doc("Gets the status of an asynchronous bulk create operation.")
  @get
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/bulkCreate/asyncOperations/{asyncOperationId}")
  getAsyncOperationStatus(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    @doc("The Azure region that contains the bulk create operation.")
    @path
    @minLength(1)
    location: azureLocation,

    @doc("The identifier of the asynchronous operation.")
    @path
    @minLength(1)
    @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
    asyncOperationId: string,
  ):
    | ArmResponse<Azure.ResourceManager.CommonTypes.OperationStatusResult>
    | ErrorResponse;

  @renamedFrom(Versions.`2026-10-06`, "createOrUpdate")
  @doc("""
    Creates virtual machines from a shared compute profile.
    The operation runs asynchronously. Use Get Async Operation Status to track its progress
    and Virtual Machines Get Operation Status to retrieve per-virtual-machine results.
    """)
  create is ArmResourceCreateOrUpdateAsync<
    Resource = LocationBasedBulkCreate,
    Parameters = BulkCreateId
  >;

  @removed(Versions.`2026-10-06`)
  @doc("Deletes BulkCreates.")
  delete is ArmResourceDeleteWithoutOkAsync<
    Resource = LocationBasedBulkCreate,
    Parameters = BulkCreateId & BulkCreateDeleteInstancesParameter
  >;

  @removed(Versions.`2026-10-06`)
  @doc("Cancels BulkCreate instances that have not yet launched.")
  cancel is ArmResourceActionNoResponseContentAsync<
    Resource = LocationBasedBulkCreate,
    Request = void,
    Parameters = BulkCreateId
  >;

  @doc("Lists the operation statuses and any errors for the virtual machines in a bulk create operation.")
  @list
  virtualMachinesGetOperationStatus is ArmResourceActionSync<
    Resource = LocationBasedBulkCreate,
    Request = void,
    Response = ArmResponse<BulkCreateOperationStatusListResult>,
    Parameters = BulkCreateId
  >;

  @doc("Lists bulk create operations in the specified resource group and Azure region.")
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

  @doc("Lists bulk create operations in the specified subscription and Azure region.")
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
