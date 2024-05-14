import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Autorest;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.AzureFleet;

@doc("An Azure Compute Fleet resource")
model Fleet is TrackedResource<FleetProperties> {
  @doc("The name of the azure compute fleet")
  @key("fleetName")
  @segment("fleets")
  @pattern("^[^_\\W][\\w-._]{0,79}(?<![-.])$")
  @path
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Zones is a valid property"
  @doc("Zones in which the Azure Compute Fleet is available")
  zones?: Array<string>;

  ...ManagedServiceIdentityProperty;
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
union ProvisioningState {
  string,

  @doc("Initial creation in progress.")
  Creating: "Creating",

  @doc("Update in progress.")
  Updating: "Updating",

  @doc("Resource creation failed.")
  Failed: "Failed",

  @doc("Resource has been created.")
  Succeeded: "Succeeded",

  @doc("Deletion in progress.")
  Deleting: "Deleting",

  @doc("Resource is being migrated from one subscription or resource group to another.")
  Migrating: "Migrating",

  @doc("Resource creation was canceled.")
  Canceled: "Canceled",
}

@doc("Details of the Azure Compute Fleet.")
model FleetProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("Configuration Options for Spot instances in Azure Compute Fleet.")
  spotPriorityProfile?: SpotPriorityProfile;

  @doc("Configuration Options for On-Demand instances in Azure Compute Fleet.")
  regularPriorityProfile?: RegularPriorityProfile;

  @extension("x-ms-identifiers", [])
  @doc("List of VM sizes supported for Azure Compute Fleet")
  vmSizesProfile: Array<VmSizeProfile>;

  @doc("Compute Profile to use for running user's workloads.")
  computeProfile: ComputeProfile;
}

@doc("Compute Profile to use for running user's workloads.")
model ComputeProfile {
  @doc("""
  Azure Compute Fleet will not parse the contents of this. We will use this in the sync path to validate the VM as well as create VMSS templates in the async path. 
  Properties to be specified according to "specification/compute/resource-manager/Microsoft.Compute/ComputeRP/stable/{computeApiVersion}/virtualMachineScaleSet.json#/definitions/VirtualMachineScaleSetVMProfile"
  """)
  baseVirtualMachineProfile: BaseVirtualMachineProfile;

  @doc("""
  Specifies the Microsoft.Compute API version to use when creating VMSS with the virtual machine profile.
  The default value will be the latest supported computeApiVersion by ComputeFleet.
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

@doc("BaseVirtualMachineProfile")
@useRef("../../../../../compute/resource-manager/Microsoft.Compute/ComputeRP/stable/2023-09-01/virtualMachineScaleSet.json#/definitions/VirtualMachineScaleSetVMProfile")
model BaseVirtualMachineProfile {}

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

@doc("Configuration Options for Spot instances in Azure Compute Fleet.")
model SpotPriorityProfile is BasePriorityProfile {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "maxPricePerVM has VM which does not follow camel casing"
  @doc("Price per hour of each Spot VM will never exceed this.")
  maxPricePerVM?: float32;

  @doc("Eviction Policy to follow when evicting Spot VMs.")
  evictionPolicy?: EvictionPolicy;

  @doc("Allocation strategy to follow when determining the sku split for Spot VMs.")
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

@doc("Spot allocation strategy types for Azure Compute Fleet")
union SpotAllocationStrategy {
  string,

  @doc("Default. Sku split will be determined to optimize for both price and capacity.")
  PriceCapacityOptimized: "PriceCapacityOptimized",

  @doc("Sku split will be determined to optimize for price. Note: Capacity will still be considered here but will be given much less weight.")
  LowestPrice: "LowestPrice",

  @doc("Sku split will be determined to optimize for capacity.")
  CapacityOptimized: "CapacityOptimized",
}

@doc("Configuration Options for On-Demand instances in Azure Compute Fleet.")
model RegularPriorityProfile is BasePriorityProfile {
  @doc("Allocation strategy to follow when determining the sku split for On-Demand VMs.")
  allocationStrategy?: RegularPriorityAllocationStrategy;
}

@doc("Ondemand allocation strategy types for Azure Compute Fleet")
union RegularPriorityAllocationStrategy {
  string,

  @doc("Default. Sku split will be determined to optimize for price. Note: Capacity will still be considered here but will be given much less weight.")
  LowestPrice: "LowestPrice",

  @added(Versions.v2024_05_01_preview)
  @doc("Sku split will be determined to optimize for the 'priority' as specified for each vm size.")
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
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Fleet>;
  update is ArmResourcePatchAsync<Fleet, FleetProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Fleet>;
  listByResourceGroup is ArmResourceListByParent<Fleet>;
  listBySubscription is ArmListBySubscription<Fleet>;
}
