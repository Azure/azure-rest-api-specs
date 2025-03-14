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
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model"
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
  @visibility(Lifecycle.Read, Lifecycle.Create)
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
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#["gpuId"])
  gpuDetails?: GpuDetails[];
}

@doc("Represents the details of a GPU.")
model GpuDetails {
  @doc("Represents the details of a GPU.")
  @visibility(Lifecycle.Read)
  gpuId?: string;

  @doc("The name of the GPU.")
  @visibility(Lifecycle.Read)
  gpuName?: string;

  @doc("The vendor of the GPU.")
  @visibility(Lifecycle.Read)
  gpuManufacturer?: string;

  @doc("The model of the GPU.")
  @visibility(Lifecycle.Read)
  gpuModel?: string;

  @doc("The status of the GPU.")
  @visibility(Lifecycle.Read)
  gpuStatus?: string;

  @doc("Specified by admin whether this GPU can be used as DDA, GPU-P, GPU-P with LM. Can only be updated when the GPU is not attached to any VM. ")
  @visibility(Lifecycle.Read)
  gpuMode?: GpuMode;

  @doc("Reported partition size (default: 0 for DDA) For e.g. 2, 4, etc. ")
  @visibility(Lifecycle.Read)
  partitionSizeGb: string;

  @doc("This is the count of total partitions.")
  @visibility(Lifecycle.Read)
  totalPartitions?: int32;

  @doc("The number of available partitions.")
  @visibility(Lifecycle.Read)
  availablePartitions?: int32;

  @doc("This is the count of assigned partitions.")
  @visibility(Lifecycle.Read)
  assignedPartitions?: int32;

  @doc("This is the host driver for the host on which GPU is assigned, only for DDA")
  @visibility(Lifecycle.Read)
  hostDriverVersion?: string;

  @doc("It is the available processing power to encode video. ")
  @visibility(Lifecycle.Read)
  availableEncoder?: string;

  @doc("It is the available processing power to decode video. ")
  @visibility(Lifecycle.Read)
  availableDecoder?: string;

  @doc("It is a high-speed memory which drivers allow the GPU to borrow from system memory.")
  @visibility(Lifecycle.Read)
  availableVram?: string;

  @doc("VRAM (Video Random-Access Memory) is the total RAM that is plugged into your GPU and acts as temporary storage for data related to graphics rendering.")
  @visibility(Lifecycle.Read)
  totalVram?: string;

  @doc("It is a resource pool on each server containing the clustered GPU resources.")
  @visibility(Lifecycle.Read)
  ddaPool?: string;

  @doc("IA set of valid partition counts that's predefined to configure. ")
  @visibility(Lifecycle.Read)
  validPartitionCount?: string[];

  @doc("This is the assignment status of the GPU.")
  @visibility(Lifecycle.Read)
  assignmentStatus?: string;

  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#["workloadName"])
  @doc("workload details to which GPU is assigned.")
  workloads?: WorkloadDetails[];
}

@doc("Represents the details of a workload.")
model WorkloadDetails {
  @doc("workload Id to which GPU is assigned.")
  @visibility(Lifecycle.Read)
  workloadId?: string;

  @doc("This gives information about workload name (VM/AKS) specifically the VM Name or AKS Name.")
  @visibility(Lifecycle.Read)
  workloadName?: string;

  @doc("This gives information about workload status, running or down.")
  @visibility(Lifecycle.Read)
  workloadStatus?: string;

  @doc("This tells if workload is VM, AKS, etc.")
  @visibility(Lifecycle.Read)
  workloadType?: string;

  @doc("The partition details for a workload using GPU-P.")
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#["uniqueId"])
  partitionDetails?: PartitionDetails[];

  @doc("This is the unique instance path for a workload using GPU-P.")
  @visibility(Lifecycle.Read)
  slotLocation?: string;
}

@doc("Represents the GPU partition details")
model PartitionDetails {
  @doc("Unique identifier for the partition")
  @visibility(Lifecycle.Read)
  uniqueId?: string;

  @doc("The partition number that is being used by the workload")
  @visibility(Lifecycle.Read)
  partitionId?: int32;

  @doc("The current vRAM that is used by the partition")
  @visibility(Lifecycle.Read)
  currentVram?: string;

  @doc("The current encode that is used by the partition")
  @visibility(Lifecycle.Read)
  currentEncode?: string;

  @doc("The current decode that is used by the partition")
  @visibility(Lifecycle.Read)
  currentDecode?: string;
}
