import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";
import "./models.tsp";
import "./virtualMachineProfile.tsp";
import "./virtualMachineExtension.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Compute;

// ============================================================
// Path parameter helpers (scoped to LaunchBulkInstancesOperation
// to avoid collision with the existing `LocationParameter` alias
// in routes.tsp which uses key `locationparameter`).
// ============================================================

alias LaunchLocationParameter = {
  /** The location name. */
  @path
  @minLength(1)
  @segment("locations")
  @key
  location: azureLocation;
};

alias LaunchOperationParameter = {
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

alias LaunchCommonParams = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ResourceGroupParameter;
};

alias LaunchSubscriptionParams = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
};

alias LaunchCustomParams = {
  ...LaunchCommonParams;
  ...ProviderNamespace<LaunchBulkInstancesOperation>;
  ...LaunchLocationParameter;
  ...ResourceNameParameter<
    LaunchBulkInstancesOperation,
    NamePattern = "^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$"
  >;
};

// ============================================================
// Enums
// ============================================================

@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
@Azure.Core.lroStatus
@doc("The status of the LaunchBulkInstancesOperation.")
union ProvisioningState {
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

  string,
}

@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
@doc("Capacity types for LaunchBulkInstancesOperation.")
union CapacityType {
  @doc("Default. VM is the default capacity type for LaunchBulkInstancesOperation where capacity is provisioned in terms of VMs.")
  VM: "VM",

  @doc("VCpu is the capacity type for LaunchBulkInstancesOperation where capacity is provisioned in terms of VCpus. If VCpu capacity is not exactly divisible by VCpu count in VMSizes, capacity in VCpus will be overprovisioned by default.")
  VCpu: "VCpu",

  string,
}

@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
@doc("Different kind of eviction policies")
union EvictionPolicy {
  @doc("When evicted, the Spot VM will be deleted and the corresponding capacity will be updated to reflect this.")
  Delete: "Delete",

  @doc("When evicted, the Spot VM will be deallocated/stopped")
  Deallocate: "Deallocate",

  string,
}

@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
@doc("Distribution strategies for LaunchBulkInstancesOperation zone allocation policy.")
union ZoneDistributionStrategy {
  @doc("Default. Launch instances in a single zone based on best effort. If capacity is not available, LaunchBulkInstancesOperation can allocate capacity in different zones.")
  BestEffortSingleZone: "BestEffortSingleZone",

  @doc("Launch instances based on zone preferences. Higher priority zones are filled first before allocating to lower priority zones.")
  Prioritized: "Prioritized",

  @doc("Balance launching instances across zones specified based on best effort. If capacity is not available, LaunchBulkInstancesOperation can deviate balancing across all zones.")
  BestEffortBalanced: "BestEffortBalanced",

  @doc("Launch instances across all provided zones, ensuring the difference between any two zones is no more than one instance.")
  StrictBalanced: "StrictBalanced",

  string,
}

@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
@doc("Architecture types supported by Azure VMs.")
union ArchitectureType {
  @doc("ARM64 Architecture")
  ARM64: "ARM64",

  @doc("X64 Architecture")
  X64: "X64",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "VMAttributeSupport which does not follow camel casing"
@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
@doc("VMSizes supported by Azure VMs. Included is a union of Excluded and Required.")
union VMAttributeSupport {
  @doc("All VMSizes having the feature support will be excluded.")
  Excluded: "Excluded",

  @doc("VMSizes that have the feature support and that do not have the feature support will be used. Included is a union of Excluded and Required.")
  Included: "Included",

  @doc("Only the VMSizes having the feature support will be used.")
  Required: "Required",

  string,
}

@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
@doc("Local storage disk types supported by Azure VMs.")
union LocalStorageDiskType {
  @doc("HDD DiskType.")
  HDD: "HDD",

  @doc("SSD DiskType.")
  SSD: "SSD",

  string,
}

@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
@doc("Accelerator manufacturers supported by Azure VMs.")
union AcceleratorManufacturer {
  @doc("AMD GpuType")
  AMD: "AMD",

  @doc("Nvidia GpuType")
  Nvidia: "Nvidia",

  @doc("Xilinx GpuType")
  Xilinx: "Xilinx",

  string,
}

@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
@doc("Accelerator types supported by Azure VMs.")
union AcceleratorType {
  @doc("GPU Accelerator")
  GPU: "GPU",

  @doc("FPGA Accelerator")
  FPGA: "FPGA",

  string,
}

@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
@doc("VMCategories defined for Azure VMs.")
union VMCategory {
  @doc("General purpose VM sizes provide balanced CPU-to-memory ratio. Ideal for testing and development, small to medium databases, and low to medium traffic web servers.")
  GeneralPurpose: "GeneralPurpose",

  @doc("Compute optimized VM sizes have a high CPU-to-memory ratio. These sizes are good for medium traffic web servers, network appliances, batch processes, and application servers.")
  ComputeOptimized: "ComputeOptimized",

  @doc("Memory optimized VM sizes offer a high memory-to-CPU ratio that is great for relational database servers, medium to large caches, and in-memory analytics.")
  MemoryOptimized: "MemoryOptimized",

  @doc("Storage optimized virtual machine (VM) sizes offer high disk throughput and IO, and are ideal for Big Data, SQL, NoSQL databases, data warehousing, and large transactional databases.")
  StorageOptimized: "StorageOptimized",

  @doc("GPU optimized VM sizes are specialized virtual machines available with single, multiple, or fractional GPUs.")
  GpuAccelerated: "GpuAccelerated",

  @doc("FPGA optimized VM sizes are specialized virtual machines available with single or multiple FPGA.")
  FpgaAccelerated: "FpgaAccelerated",

  @doc("Azure High Performance Compute VMs are optimized for various HPC workloads such as CFD, FEA, EDA, rendering, molecular dynamics, weather simulation, and financial risk analysis.")
  HighPerformanceCompute: "HighPerformanceCompute",

  string,
}

@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
@doc("Cpu Manufacturers supported by Azure VMs.")
union CpuManufacturer {
  @doc("Intel CPU.")
  Intel: "Intel",

  @doc("AMD CPU.")
  AMD: "AMD",

  @doc("Microsoft CPU.")
  Microsoft: "Microsoft",

  @doc("Ampere CPU.")
  Ampere: "Ampere",

  string,
}

@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
@doc("HyperVGenerations supported by Azure VMs.")
union HyperVGeneration {
  @doc("Gen1 hyperV.")
  Gen1: "Gen1",

  @doc("Gen2 hyperV.")
  Gen2: "Gen2",

  string,
}

@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
@doc("Virtual Machine operation status values.")
union VMOperationStatus {
  @doc("Indicates that the virtual machine is either in the process of being created or is scheduled to be created.")
  Creating: "Creating",

  @doc("Indicates that the cancellation request was successful because the virtual machine had not been created yet.")
  Canceled: "Canceled",

  @doc("Indicates that the cancellation request could not be applied because the virtual machine had already been created.")
  CancelFailedStatusUnknown: "CancelFailedStatusUnknown",

  @doc("Indicates that the virtual machine operation failed.")
  Failed: "Failed",

  @doc("Indicates that the virtual machine operation completed successfully.")
  Succeeded: "Succeeded",

  @doc("Indicates that the virtual machine is being deleted.")
  Deleting: "Deleting",

  @doc("Indicates that the virtual machine operation is being cancelled.")
  Cancelling: "Cancelling",

  string,
}

// ============================================================
// Supporting models
// ============================================================

#suppress "@azure-tools/typespec-azure-core/casing-style" "VMAttributeMinMaxInteger which does not follow camel casing"
@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
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
@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
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
@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
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

  @doc("Specifies whether the VMSize supporting local storage should be used to launch instances or not. Included - Default if not specified as most Azure VMs support local storage.")
  localStorageSupport?: VMAttributeSupport;

  @doc("LocalStorageSupport should be set to \"Included\" or \"Required\" to use this VMAttribute. If localStorageSupport is \"Excluded\", this VMAttribute can not be used.")
  localStorageInGiB?: VMAttributeMinMaxDouble;

  @doc("The local storage disk types specified as a list. LocalStorageSupport should be set to \"Included\" or \"Required\" to use this VMAttribute. If localStorageSupport is \"Excluded\", this VMAttribute can not be used.")
  localStorageDiskTypes?: Array<LocalStorageDiskType>;

  @doc("The range of data disk count specified from Min to Max. Optional parameter. Either Min or Max is required if specified.")
  dataDiskCount?: VMAttributeMinMaxInteger;

  @doc("The range of network interface count specified from Min to Max. Optional parameter. Either Min or Max is required if specified.")
  networkInterfaceCount?: VMAttributeMinMaxInteger;

  @doc("The range of network bandwidth in Mbps specified from Min to Max. Optional parameter. Either Min or Max is required if specified.")
  networkBandwidthInMbps?: VMAttributeMinMaxDouble;

  @doc("Specifies whether the VMSize supporting RDMA (Remote Direct Memory Access) should be used to build launch instances or not.")
  rdmaSupport?: VMAttributeSupport;

  @doc("The range of RDMA (Remote Direct Memory Access) network interface count specified from Min to Max. Optional parameter. Either Min or Max is required if specified. rdmaSupport should be set to \"Included\" or \"Required\" to use this VMAttribute. If rdmaSupport is \"Excluded\", this VMAttribute can not be used.")
  rdmaNetworkInterfaceCount?: VMAttributeMinMaxInteger;

  @doc("Specifies whether the VMSize supporting accelerator should be used to launch instances or not. acceleratorSupport should be set to \"Included\" or \"Required\" to use this VMAttribute. If acceleratorSupport is \"Excluded\", this VMAttribute can not be used.")
  acceleratorSupport?: VMAttributeSupport;

  @doc("The accelerator manufacturers specified as a list. acceleratorSupport should be set to \"Included\" or \"Required\" to use this VMAttribute. If acceleratorSupport is \"Excluded\", this VMAttribute can not be used.")
  acceleratorManufacturers?: Array<AcceleratorManufacturer>;

  @doc("The accelerator types specified as a list. acceleratorSupport should be set to \"Included\" or \"Required\" to use this VMAttribute. If acceleratorSupport is \"Excluded\", this VMAttribute can not be used.")
  acceleratorTypes?: Array<AcceleratorType>;

  @doc("The range of accelerator count specified from min to max. Optional parameter. Either Min or Max is required if specified. acceleratorSupport should be set to \"Included\" or \"Required\" to use this VMAttribute. If acceleratorSupport is \"Excluded\", this VMAttribute can not be used.")
  acceleratorCount?: VMAttributeMinMaxInteger;

  @doc("The VM category specified as a list. Optional parameter.")
  vmCategories?: Array<VMCategory>;

  @doc("The VM CPU manufacturers specified as a list. Optional parameter.")
  cpuManufacturers?: Array<CpuManufacturer>;

  @doc("The hyperV generations specified as a list. Optional parameter.")
  hyperVGenerations?: Array<HyperVGeneration>;

  @doc("Specifies whether the VMSize supporting burstable capability should be used to launch instances or not.")
  burstableSupport?: VMAttributeSupport;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "allowedVMSizes has VM which does not follow camel casing"
  @doc("Specifies which VMSizes should be allowed while filtering on VMAttributes. Cannot be specified together with excludedVMSizes. Maximum of 10 VM sizes allowed. Optional parameter.")
  @maxItems(10)
  allowedVMSizes?: Array<string>;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "excludedVMSizes has VM which does not follow camel casing"
  @doc("Specifies which VMSizes should be excluded while filtering on VMAttributes. Cannot be specified together with allowedVMSizes. Maximum of 10 VM sizes allowed. Optional parameter.")
  @maxItems(10)
  excludedVMSizes?: Array<string>;
}

@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
@doc("Compute Profile to configure the Virtual Machines.")
model ComputeProfile {
  @doc("Base Virtual Machine Profile Properties to be specified according to specification/compute/resource-manager/Microsoft.Compute/ComputeRP/stable/{computeApiVersion}/virtualMachine.json#/definitions/VirtualMachineProperties")
  virtualMachineProfile: BulkactionVMProperties;

  @identifiers(#["name"])
  @doc("Virtual Machine Extensions Array to be specified according to specification/compute/resource-manager/Microsoft.Compute/ComputeRP/stable/{computeApiVersion}/virtualMachine.json#/definitions/VirtualMachineExtension")
  extensions?: Array<BulkactionVMExtension>;

  @doc("Specifies the Microsoft.Compute API version to use when creating underlying Virtual Machines. The default value will be the latest supported computeApiVersion by LaunchBulkInstancesOperation.")
  computeApiVersion?: string;
}

@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
@doc("API error base.")
model ApiErrorBase {
  @doc("The error code.")
  code?: string;

  @doc("The target of the particular error.")
  target?: string;

  @doc("The error message.")
  message?: string;
}

@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
@doc("Inner error details.")
model InnerError {
  @doc("The exception type.")
  exceptionType?: string;

  @doc("The internal error message or exception dump.")
  errorDetail?: string;
}

@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
@doc("ApiError for Fleet")
model ApiError is ApiErrorBase {
  @identifiers(#["message", "target"])
  @doc("The API error details")
  details?: Array<ApiErrorBase>;

  @doc("The API inner error")
  innererror?: InnerError;
}

@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
@doc("A virtual machine launched by a LaunchBulkInstancesOperation.")
model VirtualMachine {
  @doc("The name of the virtual machine.")
  @key("virtualMachineName")
  @segment("virtualMachines")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The compute RP resource id of the virtual machine. subscriptions/{subId}/resourceGroups/{rgName}/providers/Microsoft.Compute/virtualMachines/{vmName}")
  @visibility(Lifecycle.Read)
  id: armResourceIdentifier;

  @doc("Type of the virtual machine")
  @visibility(Lifecycle.Read)
  type?: string;

  @doc("Represents the operationStatus of the virtual machine in response to the last operation performed on it by the LaunchBulkInstancesOperation.")
  @visibility(Lifecycle.Read)
  operationStatus: VMOperationStatus;

  @doc("Error information when operationStatus is Failed.")
  @visibility(Lifecycle.Read)
  error?: ApiError;
}

@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
@doc("The response of a virtual machine list operation.")
model VirtualMachineListResult {
  @pageItems
  @doc("The Virtual Machine items on this page.")
  value: Array<VirtualMachine>;

  @nextLink
  @doc("The link to the next page of items.")
  nextLink?: url;
}

// ============================================================
// Resource: LaunchBulkInstancesOperation
// ============================================================

@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
@doc("A LaunchBulkInstancesOperation resource. Holds envelope properties shared between the request shape and the location-keyed resource.")
model LaunchBulkInstancesOperation {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Zones is a valid envelope property for this resource."
  @doc("Zones in which the LaunchBulkInstancesOperation is available")
  zones?: Array<string>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Tags free-form object matches the established compute contract."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Tags is a standard ARM resource property."
  @doc("Resource tags.")
  tags?: Record<string>;

  ...ManagedServiceIdentityProperty;
  ...ResourcePlanProperty;
}

@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
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

@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
@doc("Location based LaunchBulkInstancesOperation resource. The location is part of the resource path.")
model LocationBasedLaunchBulkInstancesOperation
  is Azure.ResourceManager.ProxyResource<LaunchBulkInstancesOperationProperties> {
  @doc("The location name.")
  @path
  @minLength(1)
  @segment("locations")
  @key
  @visibility(Lifecycle.Read)
  location: azureLocation;

  ...LaunchBulkInstancesOperation;
}

@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
@doc("List of LaunchBulkInstancesOperation resources.")
model LaunchBulkInstancesOperationListResult {
  @pageItems
  @identifiers(#["id"])
  @doc("The list of LaunchBulkInstancesOperation resources.")
  value: LocationBasedLaunchBulkInstancesOperation[];

  @nextLink
  @doc("The URL to get the next set of results.")
  nextLink?: string;
}

// ============================================================
// Routes: BulkActions interface (8 operations)
// ============================================================

@added(Microsoft.Compute.Versions.`2026-04-06-preview`)
@armResourceOperations(#{ allowStaticRoutes: true })
interface BulkActions {
  @doc("Gets an instance of LaunchBulkInstancesOperations.")
  get is ArmResourceRead<
    Resource = LocationBasedLaunchBulkInstancesOperation,
    Parameters = LaunchBulkInstancesOperationId,
    Response = ArmResponse<LocationBasedLaunchBulkInstancesOperation>
  >;

  @doc("Get the status of a LaunchBulkInstancesOperation.")
  getOperationStatus is ArmResourceRead<
    Resource = LocationBasedLaunchBulkInstancesOperation,
    Parameters = LaunchOperationParameter,
    Response = ArmResponse<Azure.ResourceManager.CommonTypes.OperationStatusResult>,
    BaseParameters = LaunchSubscriptionParams
  >;

  @doc("Creates or updates LaunchBulkInstancesOperations.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    Resource = LocationBasedLaunchBulkInstancesOperation,
    Parameters = LaunchBulkInstancesOperationId
  >;

  @doc("Deletes LaunchBulkInstancesOperations.")
  delete is ArmResourceDeleteWithoutOkAsync<
    Resource = LocationBasedLaunchBulkInstancesOperation,
    Parameters = LaunchBulkInstancesOperationId & DeleteInstancesParameter
  >;

  @doc("Cancels LaunchBulkInstancesOperation instances that have not yet launched.")
  cancel is ArmResourceActionNoResponseContentAsync<
    Resource = LocationBasedLaunchBulkInstancesOperation,
    Request = void,
    Parameters = LaunchBulkInstancesOperationId
  >;

  @doc("List LaunchBulkInstancesOperation resources by resource group.")
  @get
  @autoRoute
  @action("launchBulkInstancesOperations")
  @list
  @listsResource(LaunchBulkInstancesOperation)
  @armResourceList(LocationBasedLaunchBulkInstancesOperation)
  listByResourceGroup(
    ...LaunchCommonParams,
    ...ProviderNamespace<LocationBasedLaunchBulkInstancesOperation>,
    ...LaunchLocationParameter,
  ): ArmResponse<LaunchBulkInstancesOperationListResult> | ErrorResponse;

  @doc("List LaunchBulkInstancesOperation resources by subscriptionId.")
  @get
  @autoRoute
  @action("launchBulkInstancesOperations")
  @list
  @listsResource(LaunchBulkInstancesOperation)
  @armResourceList(LocationBasedLaunchBulkInstancesOperation)
  listBySubscription(
    ...LaunchSubscriptionParams,
    ...ProviderNamespace<LocationBasedLaunchBulkInstancesOperation>,
    ...LaunchLocationParameter,
  ): ArmResponse<LaunchBulkInstancesOperationListResult> | ErrorResponse;

  @doc("List VirtualMachine resources of a LaunchBulkInstancesOperation.")
  @autoRoute
  @listsResource(VirtualMachine)
  @armResourceList(VirtualMachine)
  @list
  @get
  listVirtualMachines(
    ...LaunchCustomParams,

    @doc("Filter expression to filter the virtual machines.")
    @query
    $filter?: string,

    @doc("Skip token for pagination. Uses the token from a previous response to fetch the next page of results.")
    @query
    $skiptoken?: string,
  ): ArmResponse<VirtualMachineListResult> | ErrorResponse;
}
