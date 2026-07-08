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
import "./launchBulkInstancesOperation.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Compute;

// ============================================================
// Path parameter helpers for CustomLaunchBulkInstancesOperation.
// Mirrors LaunchBulkInstancesOperation but binds the
// customLaunchBulkInstancesOperations resource-key segment.
// ============================================================

alias CustomLaunchLocationParameter = {
  /** The location name. */
  @path
  @minLength(1)
  @segment("locations")
  @key
  location: azureLocation;
};

alias CustomLaunchBulkInstancesOperationId = {
  /** The name of the CustomLaunchBulkInstancesOperation. */
  @path
  @minLength(1)
  @segment("customLaunchBulkInstancesOperations")
  @key
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  name: string;
};

alias CustomDeleteInstancesParameter = {
  /** When true, deletes all virtual machines created by this BulkAction Operation. */
  @query
  deleteInstances?: boolean;
};

alias CustomLaunchCommonParams = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ResourceGroupParameter;
};

alias CustomLaunchSubscriptionParams = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
};

alias CustomLaunchCustomParams = {
  ...CustomLaunchCommonParams;
  ...ProviderNamespace<CustomLocationBasedLaunchBulkInstancesOperation>;
  ...CustomLaunchLocationParameter;
  ...CustomLaunchBulkInstancesOperationId;
};

// ============================================================
// Resource: CustomLaunchBulkInstancesOperation
//
// Reuses the shared enums (ProvisioningState, CapacityType,
// VMOperationStatus, ...), the shared ComputeProfile, ApiError,
// VirtualMachine, and VirtualMachineListResult defined in
// launchBulkInstancesOperation.tsp. The properties model is an
// independent clone so the custom resource can diverge later.
// ============================================================

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Bare envelope used as the @listsResource target; shape is documented via CustomLocationBasedLaunchBulkInstancesOperation."
@doc("Envelope properties shared by CustomLaunchBulkInstancesOperation. Used as the @listsResource target to avoid collision with the interface name.")
model CustomLaunchBulkInstancesOperationEnvelope {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Zones is a valid envelope property for this resource."
  @doc("Zones in which the CustomLaunchBulkInstancesOperation is available")
  zones?: Array<string>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Tags free-form object matches the established compute contract."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Tags is a standard ARM resource property."
  @doc("Resource tags.")
  tags?: Record<string>;

  ...ManagedServiceIdentityProperty;
  ...ResourcePlanProperty;
}

@doc("Location based CustomLaunchBulkInstancesOperation resource. The location is part of the resource path.")
model CustomLocationBasedLaunchBulkInstancesOperation
  is Azure.ResourceManager.ProxyResource<CustomLaunchBulkInstancesOperationProperties> {
  @doc("The location name.")
  @path
  @minLength(1)
  @segment("locations")
  @key
  @visibility(Lifecycle.Read)
  location: azureLocation;

  ...CustomLaunchBulkInstancesOperationEnvelope;
}

@doc("A single per-VM override. Each set field takes precedence over the operation-level value for that one VM. VM size, zone, priority, eviction policy, and billing are owned by the service and cannot be set here.")
model CustomLaunchBulkInstanceOverride {
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
model CustomOverridesProfile {
  @doc("Prefix used to build the ARM VM name ({prefix}_{index}) for overrides that omit a virtualMachineName. Required when any override is unnamed and rejected when every override is named.")
  virtualMachineNamePrefix?: string;

  @identifiers(#[])
  @doc("Per-VM overrides. The count is the VM count and must equal capacity. Each override maps to VM index i.")
  overrides?: Array<CustomLaunchBulkInstanceOverride>;
}

@doc("Details of the CustomLaunchBulkInstancesOperation.")
model CustomLaunchBulkInstancesOperationProperties {
  @visibility(Lifecycle.Read)
  @doc("The UTC time the CustomLaunchBulkInstancesOperation resource was created.")
  createdTime?: utcDateTime;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("Total capacity to achieve. It can be in terms of VMs or vCPUs.")
  @minValue(1)
  capacity: int32;

  @doc("Specifies capacity type for launching instances. It can be in terms of VMs or vCPUs.")
  capacityType?: CapacityType;

  @doc("Configuration Options for Regular or Spot instances in CustomLaunchBulkInstancesOperation.")
  priorityProfile: PriorityProfile;

  @identifiers(#[])
  @doc("List of VM sizes supported for CustomLaunchBulkInstancesOperation")
  vmSizesProfile?: Array<VmSizeProfile>;

  @doc("Attributes to launch instances.")
  vmAttributes?: VMAttributes;

  @doc("Compute Profile to configure the Virtual Machines.")
  computeProfile: ComputeProfile;

  @doc("Zone Allocation Policy for launching instances.")
  zoneAllocationPolicy?: ZoneAllocationPolicy;

  @visibility(Lifecycle.Create, Lifecycle.Update)
  @doc("Per-VM overrides and the shared name prefix, specified when the operation is created. Present only on the customLaunchBulkInstancesOperations endpoint; the uniform launchBulkInstancesOperations endpoint does not accept it. Input only: it is not returned in GET or create responses, so a GET-then-PUT update must re-supply it to retain the per-VM overrides.")
  overridesProfile?: CustomOverridesProfile;

  @doc("Retry policy the user can pass")
  retryPolicy?: RetryPolicy;
}

@doc("List of CustomLaunchBulkInstancesOperation resources.")
model CustomLaunchBulkInstancesOperationListResult {
  @pageItems
  @identifiers(#["id"])
  @doc("The list of CustomLaunchBulkInstancesOperation resources.")
  value: CustomLocationBasedLaunchBulkInstancesOperation[];

  @nextLink
  @doc("The URL to get the next set of results.")
  nextLink?: string;
}

// ============================================================
// Routes: CustomLaunchBulkInstancesOperation interface (8 operations)
// ============================================================

@added(Versions.`2026-07-06-preview`)
@armResourceOperations(#{ allowStaticRoutes: true })
interface CustomLaunchBulkInstancesOperation {
  @doc("Gets an instance of CustomLaunchBulkInstancesOperations.")
  get is ArmResourceRead<
    Resource = CustomLocationBasedLaunchBulkInstancesOperation,
    Parameters = CustomLaunchBulkInstancesOperationId,
    Response = ArmResponse<CustomLocationBasedLaunchBulkInstancesOperation>
  >;

  @doc("Get the status of a CustomLaunchBulkInstancesOperation.")
  @get
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/customLaunchBulkInstancesOperations/asyncOperations/{asyncOperationId}")
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

  @doc("Creates or updates CustomLaunchBulkInstancesOperations.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    Resource = CustomLocationBasedLaunchBulkInstancesOperation,
    Parameters = CustomLaunchBulkInstancesOperationId
  >;

  @doc("Deletes CustomLaunchBulkInstancesOperations.")
  delete is ArmResourceDeleteWithoutOkAsync<
    Resource = CustomLocationBasedLaunchBulkInstancesOperation,
    Parameters = CustomLaunchBulkInstancesOperationId &
      CustomDeleteInstancesParameter
  >;

  @doc("Cancels CustomLaunchBulkInstancesOperation instances that have not yet launched.")
  cancel is ArmResourceActionNoResponseContentAsync<
    Resource = CustomLocationBasedLaunchBulkInstancesOperation,
    Request = void,
    Parameters = CustomLaunchBulkInstancesOperationId
  >;

  @doc("List CustomLaunchBulkInstancesOperation resources by resource group.")
  @get
  @autoRoute
  @action("customLaunchBulkInstancesOperations")
  @list
  @listsResource(CustomLaunchBulkInstancesOperationEnvelope)
  @armResourceList(CustomLocationBasedLaunchBulkInstancesOperation)
  listByResourceGroup(
    ...CustomLaunchCommonParams,
    ...ProviderNamespace<CustomLocationBasedLaunchBulkInstancesOperation>,
    ...CustomLaunchLocationParameter,
  ): ArmResponse<CustomLaunchBulkInstancesOperationListResult> | ErrorResponse;

  @doc("List CustomLaunchBulkInstancesOperation resources by subscriptionId.")
  @get
  @autoRoute
  @action("customLaunchBulkInstancesOperations")
  @list
  @listsResource(CustomLaunchBulkInstancesOperationEnvelope)
  @armResourceList(CustomLocationBasedLaunchBulkInstancesOperation)
  listBySubscription(
    ...CustomLaunchSubscriptionParams,
    ...ProviderNamespace<CustomLocationBasedLaunchBulkInstancesOperation>,
    ...CustomLaunchLocationParameter,
  ): ArmResponse<CustomLaunchBulkInstancesOperationListResult> | ErrorResponse;

  @doc("List VirtualMachine resources of a CustomLaunchBulkInstancesOperation.")
  @autoRoute
  @listsResource(VirtualMachine)
  @armResourceList(VirtualMachine)
  @list
  @get
  listVirtualMachines(
    ...CustomLaunchCustomParams,

    @doc("Filter expression to filter the virtual machines.")
    @query
    $filter?: string,

    @doc("Skip token for pagination. Uses the token from a previous response to fetch the next page of results.")
    @query
    $skiptoken?: string,
  ): ArmResponse<VirtualMachineListResult> | ErrorResponse;
}
