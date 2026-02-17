import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;

/**
 * Details of a particular GPU in an EdgeMachine.
 */
@added(Versions.v2026_03_15_preview)
@parentResource(EdgeMachine)
model EdgeMachineGpu
  is Azure.ResourceManager.ProxyResource<EdgeMachineGpuProperties> {
  ...ResourceNameParameter<
    Resource = EdgeMachineGpu,
    KeyName = "gpuName",
    SegmentName = "gpus",
    NamePattern = "^[a-zA-Z0-9-_]{3,85}$"
  >;
}

/**
 * CRUD + List operations for Edge Machine GPUs.
 */
@added(Versions.v2026_03_15_preview)
@armResourceOperations
interface EdgeMachineGpus {
  /**
   * Get a specific GPU on an Edge Machine.
   */
  get is ArmResourceRead<EdgeMachineGpu>;

  /**
   * List all GPUs on an Edge Machine.
   */
  list is ArmResourceListByParent<
    EdgeMachineGpu,
    Response = ArmResponse<GpuList>
  >;

  /**
   * Create or update a GPU on an Edge Machine.
   */
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EdgeMachineGpu>;

  @doc("Delete a EdgeMachineGpu")
  delete is ArmResourceDeleteWithoutOkAsync<EdgeMachineGpu>;
}

// Models

/**
 * List of GPUs in Edge Machine.
 */
@added(Versions.v2026_03_15_preview)
#suppress "@azure-tools/typespec-azure-core/casing-style" "model nomenclature"
model GpuList is Azure.Core.Page<EdgeMachineGpu>;

/**
 * GPU resource properties
 */
@added(Versions.v2026_03_15_preview)
model EdgeMachineGpuProperties {
  /**
   * The provisioning state of the GPU.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Represents the instance Id of the GPU.
   */
  @visibility(Lifecycle.Read)
  gpuId?: string;

  /**
   * The vendor of the GPU.
   */
  @visibility(Lifecycle.Read)
  manufacturer?: string;

  /**
   * The model of the GPU.
   */
  @visibility(Lifecycle.Read)
  `model`?: string;

  /**
   * The status of the GPU.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * The PCI location of the GPU.
   */
  @visibility(Lifecycle.Read)
  pciLocation?: string;

  /**
   * Indicates whether the GPU is assignable.
   */
  @visibility(Lifecycle.Read)
  assignable?: boolean;

  /**
   * Indicates whether the GPU is partitionable.
   */
  @visibility(Lifecycle.Read)
  partitionable?: boolean;

  /**
   * This is the host driver for the host on which GPU is assigned, only for DDA
   */
  @visibility(Lifecycle.Read)
  hostDriverVersion?: string;

  /**
   * This is the assignment status of the GPU.
   */
  @visibility(Lifecycle.Read)
  assignmentStatus?: string;

  /**
   * Specified by admin whether this GPU can be used as DDA, GPU-P with LM. Can only be updated when the GPU is not attached to any VM.
   */
  @visibility(Lifecycle.Read)
  gpuMode?: GpuMode;

  /**
   * Details of the workload using DDA mode.
   */
  @visibility(Lifecycle.Read)
  ddaDetails?: DdaDetails;

  /**
   * Details of the GPU specifically in GPU-P mode.
   */
  @visibility(Lifecycle.Read)
  partitionDetails?: GpuPartitionDetails;
}

/**
 * GPU Vendor Type supported.
 */
@added(Versions.v2026_03_15_preview)
union GpuVendorType {
  string,

  /** Nvidia GPU. */
  Nvidia: "Nvidia",

  /** AMD GPU. */
  AMD: "AMD",

  /** Intel GPU. */
  Intel: "Intel",
}

/**
 * Represents the details of a workload.
 */
@added(Versions.v2026_03_15_preview)
model WorkloadDetails {
  /**
   * workload Id to which GPU is assigned.
   */
  @visibility(Lifecycle.Read)
  workloadId?: string;

  /**
   * This gives information about workload name (VM/AKS) specifically the VM Name or AKS Name.
   */
  @visibility(Lifecycle.Read)
  workloadName?: string;

  /**
   * This gives information about workload status, running or down.
   */
  @visibility(Lifecycle.Read)
  workloadStatus?: string;

  /**
   * This tells if workload is VM, AKS, etc.
   */
  @visibility(Lifecycle.Read)
  workloadType?: string;

  /**
   * This is the unique instance path for a workload using GPU-P.
   */
  @visibility(Lifecycle.Read)
  slotLocation?: string;
}

/**
 * Represents the details of the GPU specifically in DDA mode.
 */
@added(Versions.v2026_03_15_preview)
model DdaDetails {
  /**
   * It is a resource pool on each server containing the clustered GPU resources.
   */
  @visibility(Lifecycle.Read)
  ddaPool?: string;

  /**
   * The workload to which this GPU is assigned.
   */
  @visibility(Lifecycle.Read)
  workloadDetail?: WorkloadDetails;
}

/**
 * Represents the details of the GPU specifically in GPU-P mode.
 */
@added(Versions.v2026_03_15_preview)
model GpuPartitionDetails {
  /**
   * The name used by Hyper-V commandlets for GPU partitioning
   */
  partitionableGpuName?: string;

  /**
   * Reported partition size (default: 0 for DDA) For e.g. 2, 4, etc.
   */
  @visibility(Lifecycle.Read)
  partitionSizeGb?: string;

  /**
   * This is the count of total partitions.
   */
  @visibility(Lifecycle.Read)
  totalPartitions?: int32;

  /**
   * The number of available partitions.
   */
  @visibility(Lifecycle.Read)
  availablePartitions?: int32;

  /**
   * This is the count of assigned partitions.
   */
  @visibility(Lifecycle.Read)
  assignedPartitions?: int32;

  /**
   * It is the available processing power to encode video.
   */
  @visibility(Lifecycle.Read)
  availableEncode?: string;

  /**
   * It is the available processing power to decode video.
   */
  @visibility(Lifecycle.Read)
  availableDecode?: string;

  /**
   * It is a high-speed memory which drivers allow the GPU to borrow from system memory.
   */
  @visibility(Lifecycle.Read)
  availableVram?: string;

  /**
   * VRAM (Video Random-Access Memory) is the total RAM that is plugged into your GPU and acts as temporary storage for data related to graphics rendering.
   */
  @visibility(Lifecycle.Read)
  totalVram?: string;

  /**
   * IA set of valid partition counts that's predefined to configure.
   */
  @visibility(Lifecycle.Read)
  validPartitionCount?: string[];

  /**
   * partition details to which GPU is assigned.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["uniqueId"])
  partitions?: PartitionDetails[];
}

/**
 * Represents the GPU partition details
 */
@added(Versions.v2026_03_15_preview)
model PartitionDetails {
  /**
   * Unique identifier for the partition
   */
  @visibility(Lifecycle.Read)
  uniqueId?: string;

  /**
   * The partition number that is being used by the workload
   */
  @visibility(Lifecycle.Read)
  partitionId?: int32;

  /**
   * The current vRAM that is used by the partition
   */
  @visibility(Lifecycle.Read)
  currentVram?: string;

  /**
   * The current encode that is used by the partition
   */
  @visibility(Lifecycle.Read)
  currentEncode?: string;

  /**
   * The current decode that is used by the partition
   */
  @visibility(Lifecycle.Read)
  currentDecode?: string;

  /**
   * The workload to which this partition is assigned.
   */
  @visibility(Lifecycle.Read)
  workloadDetail?: WorkloadDetails;
}
