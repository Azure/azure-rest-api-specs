import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.AzureFleet;

@doc("An Compute Fleet resource")
model Fleet is TrackedResource<FleetProperties> {
  @doc("The name of the Compute Fleet")
  @key("fleetName")
  @segment("fleets")
  @pattern("^[^_\\W][\\w\\-._]{0,79}(?<![-.])$")
  @path
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Zones is a valid property"
  @doc("Zones in which the Compute Fleet is available")
  zones?: Array<string>;

  ...ManagedServiceIdentityProperty;
  ...ResourcePlanProperty;
}

@doc("Fleet Update Model")
model FleetUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /** Updatable managed service identity */
  identity?: ManagedServiceIdentityUpdate;

  /** Updatable resource plan */
  plan?: ResourcePlanUpdate;

  /** RP-specific updatable properties */
  properties?: FleetProperties;
}

model ManagedServiceIdentityUpdate
  is OptionalProperties<UpdateableProperties<Azure.ResourceManager.CommonTypes.ManagedServiceIdentity>>;

model ResourcePlanUpdate
  is OptionalProperties<UpdateableProperties<Azure.ResourceManager.CommonTypes.Plan>>;

@doc("The status of the current operation.")
@Azure.Core.lroStatus
union ProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Initial creation in progress.")
  Creating: "Creating",

  @doc("Update in progress.")
  Updating: "Updating",

  @doc("Deletion in progress.")
  Deleting: "Deleting",

  @doc("Resource is being migrated from one subscription or resource group to another.")
  Migrating: "Migrating",
}

@doc("Details of the Compute Fleet.")
model FleetProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("Configuration Options for Spot instances in Compute Fleet.")
  spotPriorityProfile?: SpotPriorityProfile;

  @doc("Configuration Options for Regular instances in Compute Fleet.")
  regularPriorityProfile?: RegularPriorityProfile;

  @extension("x-ms-identifiers", [])
  @doc("List of VM sizes supported for Compute Fleet")
  vmSizesProfile: Array<VmSizeProfile>;

  @doc("Compute Profile to use for running user's workloads.")
  computeProfile: ComputeProfile;

  @doc("Specifies the time at which the Compute Fleet is created.")
  @visibility("read")
  timeCreated?: utcDateTime;

  @doc("Specifies the ID which uniquely identifies a Compute Fleet.")
  @visibility("read")
  uniqueId?: string;
}

@doc("Compute Profile to use for running user's workloads.")
model ComputeProfile {
  @doc("""
    Base Virtual Machine Profile Properties to be specified according to "specification/compute/resource-manager/Microsoft.Compute/ComputeRP/stable/{computeApiVersion}/virtualMachineScaleSet.json#/definitions/VirtualMachineScaleSetVMProfile"
    """)
  baseVirtualMachineProfile: BaseVirtualMachineProfile;

  @doc("""
    Specifies the Microsoft.Compute API version to use when creating underlying Virtual Machine scale sets and Virtual Machines.
    The default value will be the latest supported computeApiVersion by Compute Fleet.
    """)
  computeApiVersion?: string;

  @added(Versions.v2024_05_01_preview)
  @doc("""
    Specifies the number of fault domains to use when creating the underlying VMSS.
    A fault domain is a logical group of hardware within an Azure datacenter.
    VMs in the same fault domain share a common power source and network switch.
    If not specified, defaults to 1, which represents "Max Spreading" (using as many fault domains as possible).
    This property cannot be updated.
    """)
  platformFaultDomainCount?: int32;
}

@doc("Specifications about a VM Size. This will also contain the corresponding rank and weight in future.")
model VmSizeProfile {
  @doc("The Sku name (e.g. 'Standard_DS1_v2')")
  name: string;

  @added(Versions.v2024_05_01_preview)
  @doc("""
    The rank of the VM size. This is used with 'RegularPriorityAllocationStrategy.Prioritized'
    The lower the number, the higher the priority. Starting with 0.
    """)
  @minValue(0)
  @maxValue(65535)
  rank?: int32;
}

@doc("Contains common properties that are applicable to both Spot and Regular.")
model BasePriorityProfile {
  @doc("Total capacity to achieve. It is currently in terms of number of VMs.")
  @minValue(0)
  capacity?: int32;

  @doc("Minimum capacity to achieve which cannot be updated. If we will not be able to \"guarantee\" minimum capacity, we will reject the request in the sync path itself.")
  @minValue(0)
  minCapacity?: int32;
}

@doc("Configuration Options for Spot instances in Compute Fleet.")
model SpotPriorityProfile is BasePriorityProfile {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "maxPricePerVM has VM which does not follow camel casing"
  @doc("Price per hour of each Spot VM will never exceed this.")
  maxPricePerVM?: float32;

  @doc("Eviction Policy to follow when evicting Spot VMs.")
  evictionPolicy?: EvictionPolicy;

  @doc("Allocation strategy to follow when determining the VM sizes distribution for Spot VMs.")
  allocationStrategy?: SpotAllocationStrategy;

  @added(Versions.v2024_05_01_preview)
  @doc("""
    Flag to enable/disable continuous goal seeking for the desired capacity and restoration of evicted Spot VMs.
    If maintain is enabled, AzureFleetRP will use all VM sizes in vmSizesProfile to create new VMs (if VMs are evicted deleted)
    or update existing VMs with new VM sizes (if VMs are evicted deallocated or failed to allocate due to capacity constraint) in order to achieve the desired capacity.
    Maintain is enabled by default.
    """)
  maintain?: boolean;
}

@doc("Spot allocation strategy types for Compute Fleet")
union SpotAllocationStrategy {
  string,

  @doc("Default. VM sizes distribution will be determined to optimize for both price and capacity.")
  PriceCapacityOptimized: "PriceCapacityOptimized",

  @doc("VM sizes distribution will be determined to optimize for price. Note: Capacity will still be considered here but will be given much less weight.")
  LowestPrice: "LowestPrice",

  @doc("VM sizes distribution will be determined to optimize for capacity.")
  CapacityOptimized: "CapacityOptimized",
}

@doc("Configuration Options for Regular instances in Compute Fleet.")
model RegularPriorityProfile is BasePriorityProfile {
  @doc("Allocation strategy to follow when determining the VM sizes distribution for Regular VMs.")
  allocationStrategy?: RegularPriorityAllocationStrategy;
}

@doc("Regular VM Allocation strategy types for Compute Fleet")
union RegularPriorityAllocationStrategy {
  string,

  @doc("Default. VM sizes distribution will be determined to optimize for price.")
  LowestPrice: "LowestPrice",

  @added(Versions.v2024_05_01_preview)
  @doc("VM sizes distribution will be determined to optimize for the 'priority' as specified for each vm size.")
  Prioritized: "Prioritized",
}

@doc("Different kind of eviction policies")
union EvictionPolicy {
  string,

  @doc("When evicted, the Spot VM will be deleted and the corresponding capacity will be updated to reflect this.")
  Delete: "Delete",

  @doc("When evicted, the Spot VM will be deallocated/stopped")
  Deallocate: "Deallocate",
}

@armResourceOperations
interface Fleets {
  get is ArmResourceRead<Fleet>;
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    Fleet,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;
  @parameterVisibility
  update is ArmCustomPatchAsync<Fleet, FleetUpdate>;
  delete is ArmResourceDeleteWithoutOkAsync<Fleet>;
  listByResourceGroup is ArmResourceListByParent<Fleet>;
  listBySubscription is ArmListBySubscription<Fleet>;
  @autoRoute
  @listsResource(VirtualMachineScaleSet)
  @armResourceList(VirtualMachineScaleSet)
  @get
  @doc("List VirtualMachineScaleSet resources by Fleet")
  listVirtualMachineScaleSets(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,
    ...ProviderNamespace<Fleet>,
    ...ResourceNameParameter<
      Fleet,
      NamePattern = "^[^_\\W][\\w\\-._]{0,79}(?<![-.])$"
    >,
  ): ArmResponse<VirtualMachineScaleSetListResult> | ErrorResponse;
}
