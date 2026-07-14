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
  /** The name of the BulkCreateCustom. */
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

@doc("A single per-VM override. Each set field takes precedence over the operation-level value for that one VM. VM size, zone, priority, eviction policy, and billing are owned by the service and cannot be set here.")
model BulkCreateCustomOverride {
  @doc("ARM VM name for this VM. Optional; when omitted the name is generated from the prefix as {prefix}_{index}.")
  virtualMachineName?: string;

  @doc("Per-VM VM profile, the same shape as operation-level ComputeProfile.virtualMachineProfile. Overrides the operation-level VM profile for this VM.")
  virtualMachineProfile?: BulkactionVMProperties;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Tags free-form object matches the established compute contract."
  @doc("Per-VM tags overriding the operation-level tags.")
  tags?: Record<string>;

  @doc("Per-VM identity overriding the operation-level identity.")
  identity?: VirtualMachineIdentity;

  @doc("Per-VM plan overriding the operation-level plan.")
  plan?: Plan;

  @identifiers(#["name"])
  @doc("Per-VM extensions. When non-empty they replace the operation-level extensions for this VM; when omitted the VM inherits the operation-level extensions.")
  extensions?: Array<BulkactionVMExtension>;
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

  @doc("Optional per-VM-size profile override applied to every VM the service assigns to this size. Reuses the per-VM override shape, but virtualMachineName cannot be set since a size maps to many VMs. virtualMachineProfile is layered beneath any per-VM override; tags, identity, and plan are merged with the per-VM override, with the per-VM value winning.")
  override?: BulkCreateCustomOverride;
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
  priorityProfile: PriorityProfile;

  @identifiers(#[])
  @doc("List of VM sizes supported for BulkCreateCustom")
  vmSizesProfile?: Array<BulkCreateCustomVmSizeProfile>;

  @doc("Compute Profile to configure the Virtual Machines.")
  computeProfile: ComputeProfile;

  @doc("Zone Allocation Policy for launching instances.")
  zoneAllocationPolicy?: ZoneAllocationPolicy;

  @visibility(Lifecycle.Create, Lifecycle.Update)
  @doc("Per-VM overrides and the shared name prefix, specified when the operation is created.")
  overridesProfile?: BulkCreateCustomOverridesProfile;

  @doc("Retry policy the user can pass")
  retryPolicy?: RetryPolicy;
}

@doc("List of BulkCreateCustom resources.")
model BulkCreateCustomListResult {
  @pageItems
  @identifiers(#["id"])
  @doc("The list of BulkCreateCustom resources.")
  value: LocationBasedBulkCreateCustom[];

  @nextLink
  @doc("The URL to get the next set of results.")
  nextLink?: string;
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

  @doc("Get the status of a BulkCreateCustom.")
  @get
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/bulkCreateCustom/asyncOperations/{asyncOperationId}")
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
