import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./virtualMachineProfile.tsp";
import "./virtualMachines.tsp";
import "./virtualMachineExtension.tsp";
import "./scheduledactionmodel.tsp";

using Http;
using Rest;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.ComputeBulkActions;

// ------------------ Common Values ---------------
alias CommonParams = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ResourceGroupParameter;
};

alias LocationParameter = {
  /** The location name. */
  @path
  @minLength(1)
  @segment("locations")
  @key
  location: azureLocation;
};

alias OperationParameter = {
  /** The async operation id. */
  @path
  @minLength(1)
  @segment("operations")
  @key
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  id: string;
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

alias SubscriptionParams = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
};

alias CustomParams = {
  ...CommonParams;
  ...ProviderNamespace<LaunchBulkInstancesOperation>;
  ...LocationParameter;
  ...ResourceNameParameter<
    LaunchBulkInstancesOperation,
    NamePattern = "^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$"
  >;
};

// ------------------ Union --------------- //
@doc("The status of the LaunchBulkInstancesOperation.")
@Azure.Core.lroStatus
union ProvisioningState {
  string,

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
}

@doc("Capacity types for LaunchBulkInstancesOperation.")
union CapacityType {
  string,

  @doc("Default. VM is the default capacity type for LaunchBulkInstancesOperation where capacity is provisioned in terms of VMs.")
  VM: "VM",

  @doc("VCpu is the capacity type for LaunchBulkInstancesOperation where capacity is provisioned in terms of VCpus. If VCpu capacity is not exactly divisible by VCpu count in VMSizes, capacity in VCpus will be overprovisioned by default.")
  VCpu: "VCpu",
}

@doc("Specifies the priority type of virtual machines to launch.")
union VirtualMachineType {
  string,

  @doc("Default. Regular/On-demand VMs will be launched")
  Regular: "Regular",

  @doc("Spot VMs will be launched.")
  Spot: "Spot",
}

@doc("Different kind of eviction policies")
union EvictionPolicy {
  string,

  @doc("When evicted, the Spot VM will be deleted and the corresponding capacity will be updated to reflect this.")
  Delete: "Delete",

  @doc("When evicted, the Spot VM will be deallocated/stopped")
  Deallocate: "Deallocate",
}

@doc("Allocation strategy types for LaunchBulkInstancesOperation")
union AllocationStrategy {
  string,

  @doc("Default. VM sizes distribution will be determined to optimize for price. Note: Capacity will still be considered here but will be given much less weight.")
  LowestPrice: "LowestPrice",

  @doc("VM sizes distribution will be determined to optimize for capacity.")
  CapacityOptimized: "CapacityOptimized",

  @doc("VM sizes distribution will be determined to optimize for the 'rank' specified for each vm size.")
  Prioritized: "Prioritized",
}

@doc("Distribution strategies for LaunchBulkInstancesOperation zone allocation policy.")
union ZoneDistributionStrategy {
  string,

  @doc("""
        Default. Launch instances in a single zone based on best effort.
        If capacity is not available, LaunchBulkInstancesOperation can allocate capacity in different zones.
    """)
  BestEffortSingleZone: "BestEffortSingleZone",

  @doc("""
        Launch instances based on zone preferences.
        Higher priority zones are filled first before allocating to lower priority zones.
    """)
  Prioritized: "Prioritized",

  @doc("""
        Balance launching instances across zones specified based on best effort.
        If capacity is not available, LaunchBulkInstancesOperation can deviate balancing across all zones.
    """)
  BestEffortBalanced: "BestEffortBalanced",

  @doc("Launch instances across all provided zones, ensuring the difference between any two zones is no more than one instance.")
  StrictBalanced: "StrictBalanced",
}

@doc("Architecture types supported by Azure VMs.")
union ArchitectureType {
  string,

  @doc("ARM64 Architecture")
  ARM64: "ARM64",

  @doc("X64 Architecture")
  X64: "X64",
}

@doc("VMSizes supported by Azure VMs. Included is a union of Excluded and Required.")
union VMAttributeSupport {
  string,

  @doc("All VMSizes having the feature support will be excluded.")
  Excluded: "Excluded",

  @doc(" VMSizes that have the feature support and that do not have the feature support will be used. Included is a union of Excluded and Required.")
  Included: "Included",

  @doc("Only the VMSizes having the feature support will be used.")
  Required: "Required",
}

@doc("Local storage disk types supported by Azure VMs.")
union LocalStorageDiskType {
  string,

  @doc("HDD DiskType.")
  HDD: "HDD",

  @doc("SDD DiskType.")
  SSD: "SSD",
}

@doc("Accelerator manufacturers supported by Azure VMs.")
union AcceleratorManufacturer {
  string,

  @doc("AMD GpuType")
  AMD: "AMD",

  @doc("Nvidia GpuType")
  Nvidia: "Nvidia",

  @doc("Xilinx GpuType")
  Xilinx: "Xilinx",
}

@doc("Accelerator types supported by Azure VMs.")
union AcceleratorType {
  string,

  @doc("GPU Accelerator")
  GPU: "GPU",

  @doc("FPGA Accelerator")
  FPGA: "FPGA",
}

@doc("""
        VMCategories defined for Azure VMs.
        See: https://learn.microsoft.com/en-us/azure/virtual-machines/sizes/overview?tabs=breakdownseries%2Cgeneralsizelist%2Ccomputesizelist%2Cmemorysizelist%2Cstoragesizelist%2Cgpusizelist%2Cfpgasizelist%2Chpcsizelist#general-purpose
  """)
union VMCategory {
  string,

  @doc("""
        General purpose VM sizes provide balanced CPU-to-memory ratio. Ideal for testing and development, small to medium databases, and low to medium traffic web servers.
    """)
  GeneralPurpose: "GeneralPurpose",

  @doc("""
        Compute optimized VM sizes have a high CPU-to-memory ratio. These sizes are good for medium traffic web servers, network appliances, batch processes, and application servers.
    """)
  ComputeOptimized: "ComputeOptimized",

  @doc("""
        Memory optimized VM sizes offer a high memory-to-CPU ratio that is great for relational database servers, medium to large caches, and in-memory analytics.
    """)
  MemoryOptimized: "MemoryOptimized",

  @doc("""
        Storage optimized virtual machine (VM) sizes offer high disk throughput and IO, and are ideal for Big Data, SQL, NoSQL databases, data warehousing, and large transactional databases. 
        Examples include Cassandra, MongoDB, Cloudera, and Redis.
    """)
  StorageOptimized: "StorageOptimized",

  @doc("""
        GPU optimized VM sizes are specialized virtual machines available with single, multiple, or fractional GPUs. 
        These sizes are designed for compute-intensive, graphics-intensive, and visualization workloads.
    """)
  GpuAccelerated: "GpuAccelerated",

  @doc("""
        FPGA optimized VM sizes are specialized virtual machines available with single or multiple FPGA. 
        These sizes are designed for compute-intensive workloads. This article provides information about the number and type of FPGA, vCPUs, data disks, and NICs. 
        Storage throughput and network bandwidth are also included for each size in this grouping.
    """)
  FpgaAccelerated: "FpgaAccelerated",

  @doc("""
        Azure High Performance Compute VMs are optimized for various HPC workloads such as computational fluid dynamics, finite element analysis, frontend and backend EDA, 
        rendering, molecular dynamics, computational geo science, weather simulation, and financial risk analysis.
    """)
  HighPerformanceCompute: "HighPerformanceCompute",
}

@doc("Cpu Manufacturers  supported by Azure VMs.")
union CpuManufacturer {
  string,

  @doc("Intel CPU.")
  Intel: "Intel",

  @doc("AMD CPU.")
  AMD: "AMD",

  @doc("Microsoft CPU.")
  Microsoft: "Microsoft",

  @doc("Ampere CPU.")
  Ampere: "Ampere",
}

@doc("HyperVGenerations supported by Azure VMs.")
union HyperVGeneration {
  string,

  @doc("Gen1 hyperV.")
  Gen1: "Gen1",

  @doc("Gen2 hyperV.")
  Gen2: "Gen2",
}
// ------------------ Resource Types --------------- //
@doc("Managed Service Identity updatable properties that are optional.")
model ManagedServiceIdentityUpdate
  is OptionalProperties<UpdateableProperties<Azure.ResourceManager.CommonTypes.ManagedServiceIdentity>>;

@doc("Resource plan updatable properties that are optional.")
model ResourcePlanUpdate
  is OptionalProperties<UpdateableProperties<Azure.ResourceManager.CommonTypes.Plan>>;

@doc("A LaunchBulkInstancesOperation resource")
model LaunchBulkInstancesOperation {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Zones is a valid property"
  @doc("Zones in which the LaunchBulkInstancesOperation is available")
  zones?: Array<string>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "This field is using the existing compute context for tags where this field is a free-form JSON object."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Tags is a standard ARM resource property"
  @doc("Resource tags.")
  tags?: Record<string>;

  ...ManagedServiceIdentityProperty;
  ...ResourcePlanProperty;
}

@doc("Location based type.")
model LocationBasedLaunchBulkInstancesOperation
  is ProxyResource<LaunchBulkInstancesOperationProperties> {
  @doc("The location name.")
  @path
  @minLength(1)
  @segment("locations")
  @key
  @visibility(Lifecycle.Read)
  location: azureLocation;

  ...LaunchBulkInstancesOperation;
}

// model OperationStatus is OmitProperties<ArmOperationStatus, "name"> {
//   ...ResourceNameParameter<OperationStatus>;
// }

@doc("Status of a long-running operation.")
model OperationStatus {
  /** The operation status */
  @Azure.Core.lroStatus
  status: Azure.ResourceManager.ResourceProvisioningState;

  /** The unique identifier for the operationStatus resource */
  @visibility(Lifecycle.Read)
  id: string;

  /** The name of the  operationStatus resource */
  @visibility(Lifecycle.Read)
  name?: string;

  /** The type of the  operationStatus resource */
  @visibility(Lifecycle.Read)
  type?: string;

  /** Operation start time */
  @visibility(Lifecycle.Read)
  startTime?: utcDateTime;

  /** Operation complete time */
  @visibility(Lifecycle.Read)
  endTime?: utcDateTime;

  /** The progress made toward completing the operation */
  @visibility(Lifecycle.Read)
  percentComplete?: float64;

  /** Errors that occurred if the operation ended with Canceled or Failed status */
  @visibility(Lifecycle.Read)
  error?: Azure.ResourceManager.Foundations.ErrorDetail;
}

// ------------------ Models --------------- //
@doc("List of LaunchBulkInstancesOperation resources.")
model LaunchBulkInstancesOperationListResult {
  @pageItems
  @doc("The list of LaunchBulkInstancesOperation resources.")
  // @OpenAPI.extension("x-ms-identifiers", #[])
  value: LocationBasedLaunchBulkInstancesOperation[];

  @doc("The URL to get the next set of results.")
  @nextLink
  nextLink?: string;
}

@doc("Details of the LaunchBulkInstancesOperation.")
model LaunchBulkInstancesOperationProperties {
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

@doc("Contains properties that are applicable to both Spot and Regular.")
model PriorityProfile {
  @doc("Specifies the type of Virtual Machine.")
  type?: VirtualMachineType;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "maxPricePerVM has VM which does not follow camel casing"
  @doc("Price per hour of each Spot VM will never exceed this.")
  maxPricePerVM?: float32;

  @doc("Eviction Policy to follow when evicting Spot VMs.")
  evictionPolicy?: EvictionPolicy;

  @doc("Allocation strategy to follow when determining the VM sizes distribution.")
  allocationStrategy?: AllocationStrategy;
}

@doc("Specifications about a VM Size. This will also contain the corresponding rank and weight in future.")
model VmSizeProfile {
  @doc("The Sku name (e.g. 'Standard_DS1_v2')")
  name: string;

  @doc("""
    The rank of the VM size. This is used with 'AllocationStrategy.Prioritized'
    The lower the number, the higher the priority. Starting with 0.
    """)
  @minValue(0)
  @maxValue(65535)
  rank?: int32;
}

@doc("Compute Profile to configure the Virtual Machines.")
model ComputeProfile {
  @doc("""
    Base Virtual Machine Profile Properties to be specified according to "specification/compute/resource-manager/Microsoft.Compute/ComputeRP/stable/{computeApiVersion}/virtualMachine.json#/definitions/VirtualMachineProperties"
    """)
  virtualMachineProfile: VirtualMachineProfile;

  @doc("""
    Virtual Machine Extensions Array to be specified according to "specification/compute/resource-manager/Microsoft.Compute/ComputeRP/stable/{computeApiVersion}/virtualMachine.json#/definitions/VirtualMachineExtension"
    """)
  extensions?: Array<VirtualMachineExtension>;

  @doc("""
    Specifies the Microsoft.Compute API version to use when creating underlying Virtual Machines.
    The default value will be the latest supported computeApiVersion by LaunchBulkInstancesOperation.
    """)
  computeApiVersion?: string;
}

@doc("ZoneAllocationPolicy for LaunchBulkInstancesOperation.")
model ZoneAllocationPolicy {
  @doc("Distribution strategy used for zone allocation policy.")
  distributionStrategy: ZoneDistributionStrategy;

  @doc("Zone preferences, required when zone distribution strategy is Prioritized.")
  @identifiers(#[])
  zonePreferences?: Array<ZonePreference>;
}

@doc("Zone preferences for LaunchBulkInstancesOperation zone allocation policy.")
model ZonePreference {
  @doc("Name of the zone.")
  zone: string;

  @doc("""
        The rank of the zone. This is used with 'Prioritized' ZoneDistributionStrategy.
        The lower the number, the higher the priority, starting with 0.
        0 is the highest rank. If not specified, defaults to lowest rank.
    """)
  @minValue(0)
  @maxValue(65535)
  rank?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "VMAttributeMinMaxInteger which does not follow camel casing"
@doc("While retrieving VMSizes from CRS, Min = 0 (uint.MinValue) if not specified, Max = 4294967295 (uint.MaxValue) if not specified. This allows to filter VMAttributes on all available VMSizes.")
model VMAttributeMinMaxInteger {
  @minValue(0)
  @doc("Min VMSize from CRS, Min = 0 (uint.MinValue) if not specified.")
  min?: int32;

  @minValue(0)
  @doc("Max VMSize from CRS, Max = 4294967295 (uint.MaxValue) if not specified.")
  max?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "VMAttributeMinMaxDouble which does not follow camel casing"
@doc("VMAttributes using double values.")
model VMAttributeMinMaxDouble {
  @minValue(0.0)
  @doc("Minimum value. If not specified, no minimum filter is applied.")
  min?: float64;

  @minValue(0.0)
  @doc("Maximum value. Must be greater than zero. Double.MaxValue(1.7976931348623157E+308).")
  max?: float64;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "VMAttributes which does not follow camel casing"
@doc("VMAttributes that will be used to filter VMSizes which will be used to launch instances.")
model VMAttributes {
  @doc("The range of vCpuCount specified from Min to Max. Must be specified if VMAttributes are specified, either Min or Max is required if specified.")
  vCpuCount: VMAttributeMinMaxInteger;

  @doc("The range of memory specified from Min to Max. Must be specified if VMAttributes are specified, either Min or Max is required if specified.")
  memoryInGiB: VMAttributeMinMaxDouble;

  @doc("The VM architecture types specified as a list. Must be specified if VMAttributes are specified. Must be compatible with image used.")
  architectureTypes: Array<ArchitectureType>;

  @doc("The range of memory in GiB per vCPU specified from min to max. Optional parameter. Either Min or Max is required if specified.")
  memoryInGiBPerVCpu?: VMAttributeMinMaxDouble;

  @doc("""
    Specifies whether the VMSize supporting local storage should be used to launch instances or not.
    Included - Default if not specified as most Azure VMs support local storage.
    """)
  localStorageSupport?: VMAttributeSupport;

  @doc("""
    LocalStorageSupport should be set to "Included" or "Required" to use this VMAttribute. 
    If localStorageSupport is "Excluded", this VMAttribute can not be used.
    """)
  localStorageInGiB?: VMAttributeMinMaxDouble;

  @doc("""
    The local storage disk types specified as a list. LocalStorageSupport should be set to "Included" or "Required" to use this VMAttribute. 
    If localStorageSupport is "Excluded", this VMAttribute can not be used.
    """)
  localStorageDiskTypes?: Array<LocalStorageDiskType>;

  @doc("The range of data disk count specified from Min to Max. Optional parameter. Either Min or Max is required if specified.")
  dataDiskCount?: VMAttributeMinMaxInteger;

  @doc("The range of network interface count specified from Min to Max. Optional parameter. Either Min or Max is required if specified.")
  networkInterfaceCount?: VMAttributeMinMaxInteger;

  @doc("The range of network bandwidth in Mbps specified from Min to Max. Optional parameter. Either Min or Max is required if specified.")
  networkBandwidthInMbps?: VMAttributeMinMaxDouble;

  @doc("Specifies whether the VMSize supporting RDMA (Remote Direct Memory Access) should be used to build launch instances or not.")
  rdmaSupport?: VMAttributeSupport;

  @doc("""
    The range of RDMA (Remote Direct Memory Access) network interface count specified from Min to Max. Optional parameter. Either Min or Max is required if specified.
    rdmaSupport should be set to "Included" or "Required" to use this VMAttribute. 
    If rdmaSupport is "Excluded", this VMAttribute can not be used.
    """)
  rdmaNetworkInterfaceCount?: VMAttributeMinMaxInteger;

  @doc("""
    Specifies whether the VMSize supporting accelerator should be used to launch instances or not.
    acceleratorSupport should be set to "Included" or "Required" to use this VMAttribute. 
    If acceleratorSupport is "Excluded", this VMAttribute can not be used.
    """)
  acceleratorSupport?: VMAttributeSupport;

  @doc("""
    The accelerator manufacturers specified as a list. 
    acceleratorSupport should be set to "Included" or "Required" to use this VMAttribute. 
    If acceleratorSupport is "Excluded", this VMAttribute can not be used.
    """)
  acceleratorManufacturers?: Array<AcceleratorManufacturer>;

  @doc("""
    The accelerator types specified as a list. acceleratorSupport should be set to "Included" or "Required" to use this VMAttribute. 
    If acceleratorSupport is "Excluded", this VMAttribute can not be used.
    """)
  acceleratorTypes?: Array<AcceleratorType>;

  @doc("""
    The range of accelerator count specified from min to max. Optional parameter. Either Min or Max is required if specified.
    acceleratorSupport should be set to "Included" or "Required" to use this VMAttribute. 
    If acceleratorSupport is "Excluded", this VMAttribute can not be used.
    """)
  acceleratorCount?: VMAttributeMinMaxInteger;

  @doc("The VM category specified as a list. Optional parameter.")
  vmCategories?: Array<VMCategory>;

  @doc("The VM CPU manufacturers specified as a list. Optional parameter.")
  cpuManufacturers?: Array<CpuManufacturer>;

  @doc("The hyperV generations specified as a list. Optional parameter.")
  hyperVGenerations?: Array<HyperVGeneration>;

  @doc("Specifies whether the VMSize supporting burstable capability should be used to launch instances or not.")
  burstableSupport?: VMAttributeSupport;

  @doc("Specifies which VMSizes should be allowed while filtering on VMAttributes. Cannot be specified together with excludedVMSizes. Maximum of 10 VM sizes allowed. Optional parameter.")
  allowedVMSizes?: Array<string>;

  @doc("Specifies which VMSizes should be excluded while filtering on VMAttributes. Cannot be specified together with allowedVMSizes. Maximum of 10 VM sizes allowed. Optional parameter.")
  excludedVMSizes?: Array<string>;
}
