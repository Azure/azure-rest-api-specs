import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "./hciCommon.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

@doc("A EdgeDevice")
@armProviderNamespace("Microsoft.AzureStackHCI")
namespace Microsoft.AzureStackHCI;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
@doc("GPU resource")
@parentResource(EdgeDevice)
@discriminator("kind")
model Gpu is Azure.ResourceManager.ExtensionResource<{}> {
  ...ResourceNameParameter<
    Resource = Gpu,
    KeyName = "gpuName",
    SegmentName = "gpus",
    NamePattern = "^[a-zA-Z0-9-]{3,24}$"
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" ""
  @doc("Edge Solution type to support polymorphic resource.")
  @visibility("read", "create")
  kind: EdgeDeviceKind;
}

@armResourceOperations
interface Gpus {
  @doc("Get a Gpu")
  get is ArmResourceRead<Gpu>;

  @doc("Create a Gpu")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Gpu>;

  @doc("Delete a Gpu")
  delete is ArmResourceDeleteWithoutOkAsync<Gpu>;

  @doc("List Gpu resources by EdgeDevice")
  listByEdgeDevice is ArmResourceListByParent<Gpu>;
}

///////////////////models///////////

@doc("GPU Vendor Type supported.")
union GpuVendorType {
  string,

  @doc("Nvidia GPU.")
  Nvidia: "Nvidia",

  @doc("AMD GPU.")
  AMD: "AMD",

  @doc("Intel GPU.")
  Intel: "Intel",
}

@doc("GPU modes supported.")
union GpuMode {
  string,

  @doc("GPU-P mode.")
  GPUP: "GPUP",

  @doc("DDA mode.")
  DDA: "DDA",
}

@doc("GPU properties for edge device with HCI OS installed.")
model HciGpu extends Gpu {
  @doc("GPU properties")
  properties: HciGpuProperties;

  @doc("Edge Solution type to support polymorphic resource.")
  kind: EdgeDeviceKind.HCI;
}

@doc("Represents the properties of a GPU.")
model HciGpuProperties {
  @doc("The name of the node.")
  nodeName?: string;

  @doc("GPU reported properties.")
  @visibility("read")
  reportedProperties?: HciGpuReportedProperties;

  @doc("GPU desired properties.")
  desiredProperties?: HciGpuDesiredProperties;
}

@doc("Represents the desired properties of a GPU.")
model HciGpuDesiredProperties {
  @doc("Desired partition size (default: 0 for DDA) For e.g. 2, 4, etc. across all nodes ")
  partitionSizeGb?: int32;

  @doc("Specified by admin whether this GPU can be used as DDA, GPU-P, GPU-P with LM. Can only be updated when the GPU is not attached to any VM. ")
  gpuMode?: GpuMode;
}
@doc("Represents the reported properties of a log collection job.")
model HciGpuReportedProperties {
  @doc("List of GPU details for this edge device.")
  @visibility("read")
  @extension("x-ms-identifiers", ["gpuId"])
  gpuDetails?: GpuDetails[];
}

@doc("Represents the details of a GPU.")
model GpuDetails {
  @doc("Represents the details of a GPU.")
  @visibility("read")
  gpuId?: string;

  @doc("The name of the GPU.")
  @visibility("read")
  gpuName?: string;

  @doc("The vendor of the GPU.")
  @visibility("read")
  gpuManufacturer?: string;

  @doc("The model of the GPU.")
  @visibility("read")
  gpuModel?: string;

  @doc("The status of the GPU.")
  @visibility("read")
  gpuStatus?: string;

  @doc("Specified by admin whether this GPU can be used as DDA, GPU-P, GPU-P with LM. Can only be updated when the GPU is not attached to any VM. ")
  @visibility("read")
  gpuMode?: GpuMode;

  @doc("Reported partition size (default: 0 for DDA) For e.g. 2, 4, etc. ")
  @visibility("read")
  partitionSizeGb: string;

  @doc("This is the count of total partitions.")
  @visibility("read")
  totalPartitions?: int32;

  @doc("The number of available partitions.")
  @visibility("read")
  availablePartitions?: int32;

  @doc("This is the count of assigned partitions.")
  @visibility("read")
  assignedPartitions?: int32;

  @doc("This is the host driver for the host on which GPU is assigned, only for DDA")
  @visibility("read")
  hostDriverVersion?: string;

  @doc("It is the available processing power to encode video. ")
  @visibility("read")
  availableEncoder?: string;

  @doc("It is the available processing power to decode video. ")
  @visibility("read")
  availableDecoder?: string;

  @doc("It is a high-speed memory which drivers allow the GPU to borrow from system memory.")
  @visibility("read")
  availableVram?: string;

  @doc("VRAM (Video Random-Access Memory) is the total RAM that is plugged into your GPU and acts as temporary storage for data related to graphics rendering.")
  @visibility("read")
  totalVram?: string;

  @doc("It is a resource pool on each server containing the clustered GPU resources.")
  @visibility("read")
  ddaPool?: string;

  @doc("IA set of valid partition counts that's predefined to configure. ")
  @visibility("read")
  validPartitionCount?: string[];

  @doc("This is the assignment status of the GPU.")
  @visibility("read")
  assignmentStatus?: string;

  @visibility("read")
  @extension("x-ms-identifiers", ["workloadName"])
  @doc("workload details to which GPU is assigned.")
  workloads?: WorkloadDetails[];
}

@doc("Represents the details of a workload.")
model WorkloadDetails {
  @doc("workload Id to which GPU is assigned.")
  @visibility("read")
  workloadId?: string;

  @doc("This gives information about workload name (VM/AKS) specifically the VM Name or AKS Name.")
  @visibility("read")
  workloadName?: string;

  @doc("This gives information about workload status, running or down.")
  @visibility("read")
  workloadStatus?: string;

  @doc("This tells if workload is VM, AKS, etc.")
  @visibility("read")
  workloadType?: string;

  @doc("The partition details for a workload using GPU-P.")
  @extension("x-ms-identifiers", ["uniqueId"])
  @visibility("read")
  partitionDetails?: PartitionDetails[];

  @doc("This is the unique instance path for a workload using GPU-P.")
  @visibility("read")
  slotLocation?: string;
}

@doc("Represents the GPU partition details")
model PartitionDetails {
  @doc("Unique identifier for the partition")
  @visibility("read")
  uniqueId?: string;

  @doc("The partition number that is being used by the workload")
  @visibility("read")
  partitionId?: int32;

  @doc("The current vRAM that is used by the partition")
  @visibility("read")
  currentVram?: string;

  @doc("The current encode that is used by the partition")
  @visibility("read")
  currentEncode?: string;

  @doc("The current decode that is used by the partition")
  @visibility("read")
  currentDecode?: string;
}
