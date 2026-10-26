import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";
import "./models.tsp";
import "./virtualMachineProfile.tsp";
import "./virtualMachineExtension.tsp";
import "./launchBulkInstancesOperation.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Compute;

// ============================================================
// Path parameter helpers for BulkCreateCustom.
// Mirrors LaunchBulkInstancesOperation but binds the
// bulkCreateCustom resource-key segment.
// ============================================================

alias BulkCreateCustomLocationParameter = {
  /** The Azure region that contains the bulk create custom operations. */
  @path
  @minLength(1)
  @segment("locations")
  @key
  location: azureLocation;
};

alias BulkCreateCustomId = {
  /** The name of the bulk create custom operation. The value must be a UUID. */
  @path
  @minLength(1)
  @segment("bulkCreateCustom")
  @key
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  name: string;
};

alias BulkCreateCustomDeleteInstancesParameter = {
  /** When true, deletes all virtual machines created by this BulkAction Operation. */
  @query
  deleteInstances?: boolean;
};

alias BulkCreateCustomCommonParams = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ResourceGroupParameter;
};

alias BulkCreateCustomSubscriptionParams = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
};

@added(Versions.`2026-08-06-preview`)
@doc("Information about a virtual machine resolved for a BulkCreateCustom operation.")
model BulkCreateCustomVirtualMachineInfo {
  @doc("The resolved Azure virtual machine name.")
  name?: string;

  @doc("The virtual machine size selected for the virtual machine.")
  vmSize?: string;

  @doc("The subscription-relative logical availability zone selected for the virtual machine.")
  zone?: string;
}

@added(Versions.`2026-08-06-preview`)
@doc("A virtual machine resource resolved for a BulkCreateCustom operation.")
model BulkCreateCustomResource {
  @doc("Information about the resolved virtual machine.")
  virtualMachineInfo?: BulkCreateCustomVirtualMachineInfo;
}

// ============================================================
// Resource: BulkCreateCustom
//
// Reuses the shared enums (ProvisioningState, CapacityType,
// VMOperationStatus, ...), the shared ComputeProfile, and ApiError
// defined in launchBulkInstancesOperation.tsp. The properties model is an
// independent clone so the custom resource can diverge later.
// ============================================================

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Bare envelope used as the @listsResource target; shape is documented via LocationBasedBulkCreateCustom."
@doc("Default settings for the virtual machines created by a bulk create custom operation.")
model BulkCreateCustomEnvelope {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Zones is a valid envelope property for this resource."
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("Default availability zones for the virtual machines. An individual virtual machine can override this setting.")
  zones?: Array<string>;

  // Spread the ARM common-types envelope property; versioning and docs are
  // applied below via augment decorators.
  ...ExtendedLocationProperty;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Placement matches the established compute contract and is applied uniformly to every virtual machine created by the operation."
  @added(Versions.`2026-10-06-preview`)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("The availability zone placement constraints applied to the virtual machines created by the BulkCreateCustom operation.")
  placement?: Placement;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Tags free-form object matches the established compute contract."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Tags is a standard ARM resource property."
  @doc("Default tags for the virtual machines created by the operation.")
  tags?: Record<string>;

  ...ManagedServiceIdentityProperty;
  ...ResourcePlanProperty;
}

@@added(
  BulkCreateCustomEnvelope.extendedLocation,
  Versions.`2026-10-06-preview`
);
@@doc(
  BulkCreateCustomEnvelope.extendedLocation,
  "The extended location of the virtual machines created by the BulkCreateCustom operation."
);

@doc("A bulk create custom operation that creates virtual machines with per-virtual-machine settings. The Azure region is specified in the resource path.")
model LocationBasedBulkCreateCustom
  is Azure.ResourceManager.ProxyResource<BulkCreateCustomProperties> {
  @doc("The Azure region in which the virtual machines are created.")
  @path
  @minLength(1)
  @segment("locations")
  @key
  @visibility(Lifecycle.Read)
  location: azureLocation;

  ...BulkCreateCustomEnvelope;
}

@doc("Settings that override the shared virtual machine configuration.")
model BulkCreateCustomOverrideBase {
  @doc("Virtual machine settings that override the corresponding settings in computeProfile.virtualMachineProfile.")
  virtualMachineProfile?: BulkactionVMProperties;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Tags free-form object matches the established compute contract."
  @doc("Tags overriding the operation-level tags.")
  tags?: Record<string>;

  @doc("Managed identity settings that override the operation-level settings.")
  identity?: VirtualMachineIdentity;

  @doc("Marketplace plan settings that override the operation-level settings.")
  plan?: Plan;

  @identifiers(#["name"])
  @doc("Extensions. When non-empty they replace the operation-level extensions; when omitted the operation-level extensions are inherited.")
  extensions?: Array<BulkactionVMExtension>;
}

@doc("Settings for one virtual machine in a bulk create custom operation.")
model BulkCreateCustomOverride {
  @doc("""
    The virtual machine resource name. If omitted, the name is generated as {prefix}_{index}
    using virtualMachineNamePrefix and the zero-based index in the overrides list.
    """)
  virtualMachineName?: string;

  @added(Versions.`2026-10-06-preview`)
  @doc("The availability zone this VM is created in. Overrides the operation-level zones for this VM only. A null value does not override, so the VM is placed using the operation-level zones; an empty value does override and deploys this VM as a regional (non-zonal) VM.")
  zone?: string;

  @added(Versions.`2026-10-06-preview`)
  @doc("The extended location this VM is created in. Overrides the operation-level extendedLocation for this VM only; when omitted the VM inherits the operation-level extendedLocation.")
  extendedLocation?: ExtendedLocation;

  @added(Versions.`2026-10-06-preview`)
  @doc("The placement constraints applied to this VM. Overrides the operation-level placement for this VM only; when omitted the VM inherits the operation-level placement.")
  placement?: Placement;

  ...BulkCreateCustomOverrideBase;
}

@doc("Per-virtual-machine settings and the prefix used to name virtual machines that do not specify a name.")
model BulkCreateCustomOverridesProfile {
  @doc("""
    Prefix used to generate names as {prefix}_{index}, where index is zero-based.
    Required when any override omits virtualMachineName. Omit this prefix when every override specifies a name.
    """)
  virtualMachineNamePrefix?: string;

  @identifiers(#[])
  @doc("""
    One override entry per virtual machine. The list must be nonempty and its length must equal capacity.
    Each entry must specify at least one value, such as a name, virtual machine profile, or tags.
    """)
  overrides?: Array<BulkCreateCustomOverride>;
}

@doc("A VM size profile entry that may additionally carry an optional per-VM-size profile override. Every VM that the service assigns to this size inherits the override, layered on top of the operation-level base profile and beneath any per-VM override. Present only on the bulkCreateCustom endpoint; the uniform endpoint rejects a non-null override.")
model BulkCreateCustomVmSizeProfile {
  ...VmSizeProfile;

  @doc("Optional per-VM-size profile override applied to every VM the service assigns to this size. A size maps to many VMs, so virtualMachineName is not part of this shape. virtualMachineProfile is layered beneath any per-VM override; tags, identity, and plan are merged with the per-VM override, with the per-VM value winning.")
  override?: BulkCreateCustomOverrideBase;
}

@doc("The allocation strategy for VM size selection in BulkCreateCustom.")
union BulkCreateCustomAllocationStrategy {
  @doc("Platform prioritizes VM sizes with the lowest hourly cost")
  LowestPrice: "LowestPrice",

  @doc("Customer specifies a rank for each VM size, platform uses VM sizes in rank order")
  Prioritized: "Prioritized",

  string,
}

@doc("The distribution strategy for zone allocation in BulkCreateCustom.")
union BulkCreateCustomDistributionStrategy {
  @doc("Platform attempts to place as many VMs as possible in a single zone, falls back to multiple zones if needed")
  BestEffortSingleZone: "BestEffortSingleZone",

  @doc("Platform uses customer-provided zone rankings to allocate VMs")
  Prioritized: "Prioritized",

  @doc("Platform attempts to evenly distribute VMs across all available zones with best effort")
  BestEffortBalanced: "BestEffortBalanced",

  string,
}

@doc("Configuration options for Regular or Spot instances in BulkCreateCustom.")
model BulkCreateCustomPriorityProfile {
  @doc("The priority type for VM allocation")
  type?: PriorityType;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "maxPricePerVM has VM which does not follow camel casing"
  @doc("Price per hour of each Spot VM will never exceed this.")
  maxPricePerVM?: float32;

  @doc("Eviction Policy to follow when evicting Spot VMs.")
  evictionPolicy?: EvictionPolicy;

  @removed(Versions.`2026-10-06-preview`)
  @doc("The allocation strategy for VM size selection")
  allocationStrategy?: BulkCreateCustomAllocationStrategy;
}

@doc("The zone allocation policy for distributing VMs across availability zones in BulkCreateCustom.")
model BulkCreateCustomZoneAllocationPolicy {
  @doc("The distribution strategy for zone allocation. Defaults to BestEffortBalanced.")
  distributionStrategy?: BulkCreateCustomDistributionStrategy = BulkCreateCustomDistributionStrategy.BestEffortBalanced;

  @identifiers(#[])
  @doc("The zone preferences for allocation priority")
  zonePreferences?: Array<ZonePreference>;
}

@doc("Settings and status for a bulk create custom operation.")
model BulkCreateCustomProperties {
  @visibility(Lifecycle.Read)
  @doc("The time the bulk create custom operation was created, in UTC.")
  createdTime?: utcDateTime;

  @visibility(Lifecycle.Read)
  @doc("The provisioning state of the bulk create custom operation.")
  provisioningState?: ProvisioningState;

  @doc("The requested capacity, measured in the units specified by capacityType.")
  @minValue(1)
  capacity: int32;

  @doc("The unit used to measure capacity: virtual machines or virtual CPUs.")
  capacityType?: CapacityType;

  @added(Versions.`2026-08-06-preview`)
  @removed(Versions.`2026-10-06-preview`)
  @doc("The minimum capacity, expressed in units specified by capacityType, that Azure must be able to allocate for the request to proceed. If Azure cannot allocate at least this capacity with high confidence, the request is rejected with 409 Conflict (InsufficientCapacity) and no VMs are created. Otherwise, Azure allocates as much capacity as possible, up to the requested capacity. Must be greater than 0, less than capacity, and requires partialFulfillmentPolicy.mode to be Enabled.")
  @minValue(1)
  minCapacity?: int32;

  @added(Versions.`2026-08-06-preview`)
  @removed(Versions.`2026-10-06-preview`)
  @doc("Controls how partial fulfillment is handled for a BulkCreateCustom request. When enabled, Azure creates only the VMs or vCPUs it has high confidence can be successfully allocated, instead of attempting the entire request and potentially returning allocation failures.")
  partialFulfillmentPolicy?: PartialFulfillmentPolicy;

  @added(Versions.`2026-08-06-preview`)
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  @doc("The names, sizes, and availability zones of the virtual machines resolved for the operation.")
  resources?: Array<BulkCreateCustomResource>;

  @removed(Versions.`2026-10-06-preview`)
  @doc("Configuration Options for Regular or Spot instances in BulkCreateCustom.")
  priorityProfile: BulkCreateCustomPriorityProfile;

  @removed(Versions.`2026-10-06-preview`)
  @identifiers(#[])
  @doc("List of VM sizes supported for BulkCreateCustom")
  vmSizesProfile?: Array<BulkCreateCustomVmSizeProfile>;

  @doc("The shared compute profile used as the base for each virtual machine. Per-virtual-machine overrides take precedence.")
  computeProfile: ComputeProfile;

  @removed(Versions.`2026-10-06-preview`)
  @doc("Zone Allocation Policy for launching instances.")
  zoneAllocationPolicy?: BulkCreateCustomZoneAllocationPolicy;

  @visibility(Lifecycle.Create, Lifecycle.Update)
  @doc("Per-virtual-machine settings and an optional name prefix. Required when creating the operation and not returned in responses.")
  overridesProfile?: BulkCreateCustomOverridesProfile;

  @doc("Extra parameters that control how the request is executed, including the retry policy.")
  executionParameters?: ExecutionParameters;
}

@doc("A page of bulk create custom operations.")
model BulkCreateCustomListResult {
  @pageItems
  @identifiers(#["id"])
  @doc("The bulk create custom operations on this page.")
  value: LocationBasedBulkCreateCustom[];

  @nextLink
  @doc("The URL to get the next set of results.")
  nextLink?: url;
}

// ============================================================
// Routes: BulkCreateCustom interface
// ============================================================

@added(Versions.`2026-07-06-preview`)
@armResourceOperations(#{ allowStaticRoutes: true })
interface BulkCreateCustom {
  @doc("Gets a bulk create custom operation and its provisioning state.")
  get is ArmResourceRead<
    Resource = LocationBasedBulkCreateCustom,
    Parameters = BulkCreateCustomId,
    Response = ArmResponse<LocationBasedBulkCreateCustom>
  >;

  @doc("Gets the status of an asynchronous bulk create custom operation.")
  @get
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/bulkCreateCustom/asyncOperations/{asyncOperationId}")
  getAsyncOperationStatus(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    @doc("The Azure region that contains the bulk create custom operation.")
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
    Creates virtual machines from a shared compute profile with per-virtual-machine overrides.
    Provide one override entry for each requested virtual machine. The operation runs asynchronously.
    Use Get Async Operation Status to track its progress and Virtual Machines Get Operation Status
    to retrieve per-virtual-machine results.
    """)
  create is ArmResourceCreateOrUpdateAsync<
    Resource = LocationBasedBulkCreateCustom,
    Parameters = BulkCreateCustomId
  >;

  @removed(Versions.`2026-10-06`)
  @doc("Deletes BulkCreateCustoms.")
  delete is ArmResourceDeleteWithoutOkAsync<
    Resource = LocationBasedBulkCreateCustom,
    Parameters = BulkCreateCustomId & BulkCreateCustomDeleteInstancesParameter
  >;

  @removed(Versions.`2026-10-06`)
  @doc("Cancels BulkCreateCustom instances that have not yet launched.")
  cancel is ArmResourceActionNoResponseContentAsync<
    Resource = LocationBasedBulkCreateCustom,
    Request = void,
    Parameters = BulkCreateCustomId
  >;

  @added(Versions.`2026-08-06-preview`)
  @doc("Lists the operation statuses and any errors for the virtual machines in a bulk create custom operation.")
  @list
  virtualMachinesGetOperationStatus is ArmResourceActionSync<
    Resource = LocationBasedBulkCreateCustom,
    Request = void,
    Response = ArmResponse<BulkCreateCustomOperationStatusListResult>,
    Parameters = BulkCreateCustomId
  >;

  @doc("Lists bulk create custom operations in the specified resource group and Azure region.")
  @get
  @autoRoute
  @action("bulkCreateCustom")
  @list
  @listsResource(BulkCreateCustomEnvelope)
  @armResourceList(LocationBasedBulkCreateCustom)
  listByResourceGroup(
    ...BulkCreateCustomCommonParams,
    ...ProviderNamespace<LocationBasedBulkCreateCustom>,
    ...BulkCreateCustomLocationParameter,
  ): ArmResponse<BulkCreateCustomListResult> | ErrorResponse;

  @doc("Lists bulk create custom operations in the specified subscription and Azure region.")
  @get
  @autoRoute
  @action("bulkCreateCustom")
  @list
  @listsResource(BulkCreateCustomEnvelope)
  @armResourceList(LocationBasedBulkCreateCustom)
  listBySubscription(
    ...BulkCreateCustomSubscriptionParams,
    ...ProviderNamespace<LocationBasedBulkCreateCustom>,
    ...BulkCreateCustomLocationParameter,
  ): ArmResponse<BulkCreateCustomListResult> | ErrorResponse;
}
