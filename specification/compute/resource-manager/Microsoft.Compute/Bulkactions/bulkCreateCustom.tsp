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
  /** The location name. */
  @path
  @minLength(1)
  @segment("locations")
  @key
  location: azureLocation;
};

alias BulkCreateCustomId = {
  /** The name of the BulkCreateCustom. The value must be an UUID. */
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

// ============================================================
// Resource: BulkCreateCustom
//
// Reuses the shared enums (ProvisioningState, CapacityType,
// VMOperationStatus, ...), the shared ComputeProfile, and ApiError
// defined in launchBulkInstancesOperation.tsp. The properties model is an
// independent clone so the custom resource can diverge later.
// ============================================================

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Bare envelope used as the @listsResource target; shape is documented via LocationBasedBulkCreateCustom."
@doc("Envelope properties shared by BulkCreateCustom. Used as the @listsResource target to avoid collision with the interface name.")
model BulkCreateCustomEnvelope {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Zones is a valid envelope property for this resource."
  @doc("Zones in which the BulkCreateCustom is available")
  zones?: Array<string>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Tags free-form object matches the established compute contract."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Tags is a standard ARM resource property."
  @doc("Resource tags.")
  tags?: Record<string>;

  ...ManagedServiceIdentityProperty;
  ...ResourcePlanProperty;
}

@doc("Location based BulkCreateCustom resource. The location is part of the resource path.")
model LocationBasedBulkCreateCustom
  is Azure.ResourceManager.ProxyResource<BulkCreateCustomProperties> {
  @doc("The location name.")
  @path
  @minLength(1)
  @segment("locations")
  @key
  @visibility(Lifecycle.Read)
  location: azureLocation;

  ...BulkCreateCustomEnvelope;
}

@doc("Override fields shared by per-VM and per-VM-size overrides. Each set field takes precedence over the operation-level value. VM size, zone, priority, eviction policy, and billing are owned by the service and cannot be set here.")
model BulkCreateCustomOverrideBase {
  @doc("VM profile, the same shape as operation-level ComputeProfile.virtualMachineProfile. Overrides the operation-level VM profile.")
  virtualMachineProfile?: BulkactionVMProperties;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Tags free-form object matches the established compute contract."
  @doc("Tags overriding the operation-level tags.")
  tags?: Record<string>;

  @doc("Identity overriding the operation-level identity.")
  identity?: VirtualMachineIdentity;

  @doc("Plan overriding the operation-level plan.")
  plan?: Plan;

  @identifiers(#["name"])
  @doc("Extensions. When non-empty they replace the operation-level extensions; when omitted the operation-level extensions are inherited.")
  extensions?: Array<BulkactionVMExtension>;
}

@doc("A single per-VM override. Extends the shared override fields with a per-VM name.")
model BulkCreateCustomOverride {
  @doc("ARM VM name for this VM. Optional; when omitted the name is generated from the prefix as {prefix}_{index}.")
  virtualMachineName?: string;

  ...BulkCreateCustomOverrideBase;
}

@doc("Groups the per-VM overrides with the name prefix that names any override that does not supply its own VM name.")
model BulkCreateCustomOverridesProfile {
  @doc("Prefix used to build the ARM VM name ({prefix}_{index}) for overrides that omit a virtualMachineName. Required when any override is unnamed and rejected when every override is named.")
  virtualMachineNamePrefix?: string;

  @identifiers(#[])
  @doc("Per-VM overrides. The count is the VM count and must equal capacity. Each override maps to VM index i.")
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

@doc("Details of the BulkCreateCustom.")
model BulkCreateCustomProperties {
  @visibility(Lifecycle.Read)
  @doc("The UTC time the BulkCreateCustom resource was created.")
  createdTime?: utcDateTime;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("Total capacity to achieve. It can be in terms of VMs or vCPUs.")
  @minValue(1)
  capacity: int32;

  @doc("Specifies capacity type for launching instances. It can be in terms of VMs or vCPUs.")
  capacityType?: CapacityType;

  @doc("Configuration Options for Regular or Spot instances in BulkCreateCustom.")
  priorityProfile: BulkCreateCustomPriorityProfile;

  @identifiers(#[])
  @doc("List of VM sizes supported for BulkCreateCustom")
  vmSizesProfile?: Array<BulkCreateCustomVmSizeProfile>;

  @doc("Compute Profile to configure the Virtual Machines.")
  computeProfile: ComputeProfile;

  @doc("Zone Allocation Policy for launching instances.")
  zoneAllocationPolicy?: BulkCreateCustomZoneAllocationPolicy;

  @visibility(Lifecycle.Create, Lifecycle.Update)
  @doc("Per-VM overrides and the shared name prefix, specified when the operation is created.")
  overridesProfile?: BulkCreateCustomOverridesProfile;

  @doc("Extra parameters that control how the request is executed, including the retry policy.")
  executionParameters?: ExecutionParameters;
}

@doc("List of BulkCreateCustom resources.")
model BulkCreateCustomListResult {
  @pageItems
  @identifiers(#["id"])
  @doc("The list of BulkCreateCustom resources.")
  value: LocationBasedBulkCreateCustom[];

  @nextLink
  @doc("The URL to get the next set of results.")
  nextLink?: url;
}

// ============================================================
// Routes: BulkCreateCustom interface (8 operations)
// ============================================================

@added(Versions.`2026-07-06-preview`)
@armResourceOperations(#{ allowStaticRoutes: true })
interface BulkCreateCustom {
  @doc("Gets an instance of BulkCreateCustoms.")
  get is ArmResourceRead<
    Resource = LocationBasedBulkCreateCustom,
    Parameters = BulkCreateCustomId,
    Response = ArmResponse<LocationBasedBulkCreateCustom>
  >;

  @doc("Get the status of an async operation of a BulkCreateCustom.")
  @get
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/bulkCreateCustom/asyncOperations/{asyncOperationId}")
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

  @doc("Creates or updates BulkCreateCustoms.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    Resource = LocationBasedBulkCreateCustom,
    Parameters = BulkCreateCustomId
  >;

  @doc("Deletes BulkCreateCustoms.")
  delete is ArmResourceDeleteWithoutOkAsync<
    Resource = LocationBasedBulkCreateCustom,
    Parameters = BulkCreateCustomId & BulkCreateCustomDeleteInstancesParameter
  >;

  @doc("Cancels BulkCreateCustom instances that have not yet launched.")
  cancel is ArmResourceActionNoResponseContentAsync<
    Resource = LocationBasedBulkCreateCustom,
    Request = void,
    Parameters = BulkCreateCustomId
  >;

  @doc("List BulkCreateCustom resources by resource group.")
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

  @doc("List BulkCreateCustom resources by subscriptionId.")
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
