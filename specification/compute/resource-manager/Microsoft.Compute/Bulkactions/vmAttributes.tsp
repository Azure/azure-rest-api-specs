import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Compute;

// ============================================================
// VM attribute primitives shared across resources that need
// to filter or describe Azure VM SKUs. Lives here so any
// future resource in Microsoft.Compute Bulkactions (or beyond)
// can import without duplicating the union and model definitions.
// ============================================================

@doc("Architecture types supported by Azure VMs.")
union ArchitectureType {
  @doc("ARM64 Architecture")
  ARM64: "ARM64",

  @doc("X64 Architecture")
  X64: "X64",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "VMAttributeSupport which does not follow camel casing"
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

@doc("Local storage disk types supported by Azure VMs.")
union LocalStorageDiskType {
  @doc("HDD DiskType.")
  HDD: "HDD",

  @doc("SSD DiskType.")
  SSD: "SSD",

  string,
}

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

@doc("Accelerator types supported by Azure VMs.")
union AcceleratorType {
  @doc("GPU Accelerator")
  GPU: "GPU",

  @doc("FPGA Accelerator")
  FPGA: "FPGA",

  string,
}

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

@doc("HyperVGenerations supported by Azure VMs.")
union HyperVGeneration {
  @doc("Gen1 hyperV.")
  Gen1: "Gen1",

  @doc("Gen2 hyperV.")
  Gen2: "Gen2",

  string,
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
