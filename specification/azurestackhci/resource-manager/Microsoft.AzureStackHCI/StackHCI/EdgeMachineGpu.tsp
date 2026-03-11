import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

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

// ==================== GpuJobs Resource ====================

/**
 * Details of a GPU Job on an Edge Machine GPU.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
@added(Versions.v2026_03_15_preview)
@parentResource(EdgeMachineGpu)
model EdgeMachineGpuJob
  is Azure.ResourceManager.ProxyResource<EdgeMachineGpuJobProperties> {
  ...ResourceNameParameter<
    Resource = EdgeMachineGpuJob,
    KeyName = "jobsName",
    SegmentName = "jobs",
    NamePattern = "^[a-zA-Z0-9-_]{3,512}$"
  >;
}

/**
 * CRUD + List operations for Edge Machine GPU Jobs.
 */
@added(Versions.v2026_03_15_preview)
@armResourceOperations
interface EdgeMachineGpuJobs {
  /** Get a specific GPU Job on an Edge Machine GPU. */
  get is ArmResourceRead<EdgeMachineGpuJob>;

  /** Create or update a GPU Job on an Edge Machine GPU. */
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EdgeMachineGpuJob>;

  /** Delete a specific GPU Job on an Edge Machine GPU. */
  delete is ArmResourceDeleteWithoutOkAsync<EdgeMachineGpuJob>;

  /** List EdgeMachineGpuJob resources by EdgeMachineGpu. */
  list is ArmResourceListByParent<EdgeMachineGpuJob>;
}

@@doc(EdgeMachineGpuJob.name, "Name of EdgeMachineGpuJob");
