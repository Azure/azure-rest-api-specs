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

  @added(Versions.v2024_11_01)
  @doc("Attribute based Fleet.")
  vmAttributes?: VMAttributes;

  @added(Versions.v2024_11_01)
  @doc("Represents the configuration for additional locations where Fleet resources may be deployed.")
  additionalLocationsProfile?: AdditionalLocationsProfile;

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

  @added(Versions.v2024_11_01)
  @doc("""
    Specifies VMSS and VM API entity models support two additional capabilities as of today: ultraSSDEnabled and hibernationEnabled.
    ultraSSDEnabled: Enables UltraSSD_LRS storage account type on the VMSS VMs.
    hibernationEnabled: Enables the hibernation capability on the VMSS VMs.
    Default value is null if not specified. This property cannot be updated once set.
    """)
  additionalVirtualMachineCapabilities?: AdditionalCapabilities;
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

@added(Versions.v2024_11_01)
@doc("AdditionalCapabilities for VM.")
model AdditionalCapabilities {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "ultraSSDEnabled which does not follow camel casing"
  @doc("""
    The flag that enables or disables a capability to have one or more managed data disks with UltraSSD_LRS storage account type on the VM or VMSS. 
    Managed disks with storage account type UltraSSD_LRS can be added to a virtual machine or virtual machine scale set only if this property is enabled.
    """)
  ultraSSDEnabled?: boolean;

  @doc("The flag that enables or disables hibernation capability on the VM.")
  hibernationEnabled?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "VMAttributeMinMax which does not follow camel casing"
@added(Versions.v2024_11_01)
@doc("While retrieving VMSizes from CRS, Min = 0 (uint.MinValue) if not specified, Max = 4294967295 (uint.MaxValue) if not specified. This allows to filter VMAttributes on all available VMSizes.")
model VMAttributeMinMax {
  @doc("Min VMSize from CRS, Min = 0 (uint.MinValue) if not specified.")
  min?: int32;

  @doc("Maz VMSize from CRS, Max = 4294967295 (uint.MaxValue) if not specified.")
  max?: int32;
}

@added(Versions.v2024_11_01)
@doc("VMSizes supported by Azure VMs. Included is a union of Excluded and Required.")
union VMAttributeSupport {
  string,

  @doc("All VMSizes having the feature support will be excluded.")
  Excluded: "Excluded",

  @doc("SDD DiskType.")
  Included: "Included",

  @doc("VMSizes that have the feature support and that do not have the feature support will be used.")
  Required: "Required",
}

@added(Versions.v2024_11_01)
@doc("VMCategories defined for Azure VMs.")
union VMCategory {
  string,

  @doc("GeneralPurpose VM.")
  GeneralPurpose: "GeneralPurpose",

  @doc("ComputeOptimized VM.")
  ComputeOptimized: "ComputeOptimized",

  @doc("MemoryOptimized VM.")
  MemoryOptimized: "MemoryOptimized",

  @doc("StorageOptimized VM.")
  StorageOptimized: "StorageOptimized",

  @doc("GpuAccelerated VM.")
  GpuAccelerated: "GpuAccelerated",

  @doc("FpgaAccelerated VM.")
  FpgaAccelerated: "FpgaAccelerated",
}

@added(Versions.v2024_11_01)
@doc("Architecture types supported by Azure VMs.")
union CpuManufacturer {
  string,

  @doc("Intel CPU.")
  Intel: "Intel",

  @doc("AMD CPU.")
  AMD: "AMD",
}

@added(Versions.v2024_11_01)
@doc("Different kind of Local storage disk types supported by Azure VMs.")
union LocalStorageDiskType {
  string,

  @doc("HDD DiskType.")
  HDD: "HDD",

  @doc("SDD DiskType.")
  SSD: "SSD",
}

@added(Versions.v2024_11_01)
@doc("Architecture types supported by Azure VMs.")
union ArchitectureType {
  string,

  @doc("Intel Architecture")
  Intel: "Intel",

  @doc("AMD Architecture")
  AMD: "AMD",
}

@added(Versions.v2024_11_01)
@doc("Gpu manufacturers supported by Azure VMs.")
union GpuManufacturer {
  string,

  @doc("Intel GpuType")
  Intel: "Intel",

  @doc("AMD GpuType")
  AMD: "AMD",

  @doc("Nvidia GpuType")
  Nvidia: "Nvidia",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "VMAttributes which does not follow camel casing"
@added(Versions.v2024_11_01)
@doc("VMAttributes that will be used to filter VMSizes which will be used to build Fleet.")
model VMAttributes {
  @doc("The range of vCpuCount specified from Min to Max. Must be specified if VMAttributes are specified, either Min or Max is required if specified.")
  vCpuCount: VMAttributeMinMax;

  @doc("The range of memory specified from Min to Max. Must be specified if VMAttributes are specified, either Min or Max is required if specified.")
  memoryInMiB: VMAttributeMinMax;

  @doc("Specifies whether the VMSize supporting local storage should be used to build Fleet or not.")
  localStorageSupport?: VMAttributeSupport;

  @extension("x-ms-identifiers", [])
  @doc("The local storage disk types specified as a list. If gpuSupport is Excluded, this VMAttribute can not be used.")
  localStorageDiskType: Array<LocalStorageDiskType>;

  @doc("The range of local storage in GB specified from Min to Max.")
  localStorageInGB: VMAttributeMinMax;

  @extension("x-ms-identifiers", [])
  @doc("The local storage disk types specified as a list.")
  localStorageDiskTypes: Array<LocalStorageDiskType>;

  @doc("The range of data disk count specified from Min to Max. Optional parameter. Either Min or Max is required if specified.")
  dataDiskCount: VMAttributeMinMax;

  @doc("The range of network interface count specified from Min to Max. Optional parameter. Either Min or Max is required if specified.")
  networkInterfaceCount: VMAttributeMinMax;

  @doc("The range of network bandwidth in Mbps specified from Min to Max. Optional parameter. Either Min or Max is required if specified.")
  networkBandwidthInMbps: VMAttributeMinMax;

  @doc("Specifies whether the VMSize supporting RDMA (Remote Direct Memory Access) should be used to build Fleet or not.")
  rdmaSupport?: VMAttributeSupport;

  @doc("The range of RDMA (Remote Direct Memory Access) network interface count specified from Min to Max. Optional parameter. Either Min or Max is required if specified.")
  rdmaNetworkInterfaceCount: VMAttributeMinMax;

  @doc("Specifies whether the VMSize supporting GPU should be used to build Fleet or not.")
  gpuSupport?: VMAttributeSupport;

  @extension("x-ms-identifiers", [])
  @doc("The GPU manufacturers specified as a list. gpuSupport should be set to Included or Required to use this VMAttribute. Default GPU manufacturers if not specified are ANY of the valid values.")
  gpuManufacturers: Array<GpuManufacturer>;

  @extension("x-ms-identifiers", [])
  @doc("The VM category specified as a list. Optional parameter.")
  vmCategories: Array<VMCategory>;

  @extension("x-ms-identifiers", [])
  @doc("The VM architecture types specified as a list. Optional parameter.")
  architectureTypes: Array<ArchitectureType>;

  @extension("x-ms-identifiers", [])
  @doc("The VM CPU manufacturers specified as a list. Optional parameter.")
  cpuManufacturers: Array<CpuManufacturer>;

  @doc("Specifies whether the VMSize supporting burstable capability should be used to build Fleet or not.")
  burstableSupport?: VMAttributeSupport;

  @extension("x-ms-identifiers", [])
  @doc("Specifies which VMSizes should be excluded while building Fleet. Optional parameter.")
  excludedVMSizes: Array<string>;
}

@added(Versions.v2024_11_01)
@doc("Represents the profile for a single additional location in the Fleet. The location and the (optional).")
model LocationProfile {
  @doc("The ARM location name of the additional region.")
  location: string;

  @doc("""
    Base Virtual Machine Profile Properties to be specified according to "specification/compute/resource-manager/Microsoft.Compute/ComputeRP/stable/{computeApiVersion}/virtualMachineScaleSet.json#/definitions/VirtualMachineScaleSetVMProfile"
    """)
  virtualMachineProfileOverride: BaseVirtualMachineProfile;
}

@added(Versions.v2024_11_01)
@doc("Represents the configuration for additional locations where Fleet resources may be deployed.")
model AdditionalLocationsProfile {
  @extension("x-ms-identifiers", [])
  @doc("The list of location profiles.")
  locationProfiles: Array<LocationProfile>;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "VMAttributesList which does not follow camel casing"
@added(Versions.v2024_11_01)
@doc("List of VMAttributes that will be used to filter VMSizes which will be used to build Fleet.")
model VMAttributesList {
  @extension("x-ms-identifiers", [])
  @doc("List of VMAttributes that will be used to filter VMSizes which will be used to build Fleet.")
  vmAttributes: Array<VMAttributes>;
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
