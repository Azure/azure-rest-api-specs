import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./EdgeMachineGpu.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.AzureStackHCI;

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
  /**
   * Get a specific GPU Job on an Edge Machine GPU.
   */
  get is ArmResourceRead<EdgeMachineGpuJob>;

  /**
   * Create or update a GPU Job on an Edge Machine GPU.
   */
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EdgeMachineGpuJob>;

  /**
   * Delete a specific GPU Job on an Edge Machine GPU.
   */
  delete is ArmResourceDeleteWithoutOkAsync<EdgeMachineGpuJob>;

  /**
   * List EdgeMachineGpuJob resources by EdgeMachineGpu
   */
  list is ArmResourceListByParent<EdgeMachineGpuJob>;
}

@@doc(EdgeMachineGpuJob.name, "Name of EdgeMachineGpuJob");
