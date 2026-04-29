import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Compute;

// ===================== VM Attribute Enums =====================

/** Whether a VM capability should be excluded, included, or required. */
@added(Versions.v2026_05_05_preview)
union VmAttributeSupport {
  string,

  /** Exclude VM sizes that have the capability. */
  Excluded: "Excluded",

  /** Allow VM sizes with and without the capability. */
  Included: "Included",

  /** Only allow VM sizes that have the capability. */
  Required: "Required",
}

/** Architecture type of the VM. */
@added(Versions.v2026_05_05_preview)
union ArchitectureType {
  string,

  /** ARM64 architecture. */
  ARM64: "ARM64",

  /** x64 architecture. */
  X64: "X64",
}

/** CPU manufacturer. */
@added(Versions.v2026_05_05_preview)
union CpuManufacturer {
  string,

  /** Intel CPU. */
  Intel: "Intel",

  /** AMD CPU. */
  AMD: "AMD",

  /** Microsoft CPU. */
  Microsoft: "Microsoft",

  /** Ampere CPU. */
  Ampere: "Ampere",
}

/** VM category classification. */
@added(Versions.v2026_05_05_preview)
union VmCategory {
  string,

  /** General purpose VMs. */
  GeneralPurpose: "GeneralPurpose",

  /** Compute optimized VMs. */
  ComputeOptimized: "ComputeOptimized",

  /** Memory optimized VMs. */
  MemoryOptimized: "MemoryOptimized",

  /** Storage optimized VMs. */
  StorageOptimized: "StorageOptimized",

  /** GPU accelerated VMs. */
  GpuAccelerated: "GpuAccelerated",

  /** FPGA accelerated VMs. */
  FpgaAccelerated: "FpgaAccelerated",

  /** High performance compute VMs. */
  HighPerformanceCompute: "HighPerformanceCompute",
}

/** Accelerator manufacturer. */
@added(Versions.v2026_05_05_preview)
union AcceleratorManufacturer {
  string,

  /** AMD accelerator. */
  AMD: "AMD",

  /** Nvidia accelerator. */
  Nvidia: "Nvidia",

  /** Xilinx accelerator. */
  Xilinx: "Xilinx",
}

/** Accelerator type. */
@added(Versions.v2026_05_05_preview)
union AcceleratorType {
  string,

  /** GPU accelerator. */
  GPU: "GPU",

  /** FPGA accelerator. */
  FPGA: "FPGA",
}

/** Local storage disk type. */
@added(Versions.v2026_05_05_preview)
union LocalStorageDiskType {
  string,

  /** HDD local storage. */
  HDD: "HDD",

  /** SSD local storage. */
  SSD: "SSD",
}

/** Hyper-V generation. */
@added(Versions.v2026_05_05_preview)
union HyperVGeneration {
  string,

  /** Generation 1. */
  Gen1: "Gen1",

  /** Generation 2. */
  Gen2: "Gen2",
}

// ===================== VM Attribute Models =====================

/** Integer min/max range for VM attributes. */
@added(Versions.v2026_05_05_preview)
model VmAttributeMinMaxInteger {
  /** Minimum value. */
  min?: int32;

  /** Maximum value. */
  max?: int32;
}

/** Double min/max range for VM attributes. */
@added(Versions.v2026_05_05_preview)
model VmAttributeMinMaxDouble {
  /** Minimum value. */
  min?: float64;

  /** Maximum value. */
  max?: float64;
}

/** VM attribute constraints for attribute-based VM selection. */
@added(Versions.v2026_05_05_preview)
model VmAttributes {
  /** vCPU count range. Required. */
  vCpuCount: VmAttributeMinMaxInteger;

  /** Memory range in GiB. Required. */
  memoryInGiB: VmAttributeMinMaxDouble;

  /** Supported VM architectures. Required. */
  architectureTypes: ArchitectureType[];

  /** Memory-per-vCPU range in GiB. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "memoryInGiBPerVCpu matches the established Azure Compute API naming convention"
  memoryInGiBPerVCpu?: VmAttributeMinMaxDouble;

  /** Data disk count range. */
  dataDiskCount?: VmAttributeMinMaxInteger;

  /** NIC count range. */
  networkInterfaceCount?: VmAttributeMinMaxInteger;

  /** Network bandwidth range in Mbps. */
  networkBandwidthInMbps?: VmAttributeMinMaxDouble;

  /** Whether local storage support should be excluded, included, or required. */
  localStorageSupport?: VmAttributeSupport;

  /** Local storage capacity range in GiB. */
  localStorageInGiB?: VmAttributeMinMaxDouble;

  /** Allowed local storage disk types. */
  localStorageDiskTypes?: LocalStorageDiskType[];

  /** Whether RDMA support should be excluded, included, or required. */
  rdmaSupport?: VmAttributeSupport;

  /** RDMA NIC count range. */
  rdmaNetworkInterfaceCount?: VmAttributeMinMaxInteger;

  /** Whether accelerator support should be excluded, included, or required. */
  acceleratorSupport?: VmAttributeSupport;

  /** Allowed accelerator manufacturers. */
  acceleratorManufacturers?: AcceleratorManufacturer[];

  /** Allowed accelerator types. */
  acceleratorTypes?: AcceleratorType[];

  /** Accelerator count range. */
  acceleratorCount?: VmAttributeMinMaxInteger;

  /** Allowed VM categories. */
  vmCategories?: VmCategory[];

  /** Allowed CPU manufacturers. */
  cpuManufacturers?: CpuManufacturer[];

  /** Whether burstable SKUs should be excluded, included, or required. */
  burstableSupport?: VmAttributeSupport;

  /** Allowed Hyper-V generations. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "hyperVGenerations matches the established Azure Compute API naming convention"
  hyperVGenerations?: HyperVGeneration[];

  /** VM sizes to explicitly exclude. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "excludedVMSizes matches the established Azure Compute API naming convention"
  excludedVMSizes?: string[];

  /** VM sizes to explicitly allow; attribute filtering applied only to this set. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "allowedVMSizes matches the established Azure Compute API naming convention"
  allowedVMSizes?: string[];
}
