import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.AzureStackHCI;

/**
 * Cluster Jobs resource
 */
@added(Versions.v2026_05_01_preview)
@parentResource(EdgeMachine)
model EdgeMachineJob
  is Azure.ResourceManager.ProxyResource<EdgeMachineJobProperties> {
  ...ResourceNameParameter<
    Resource = EdgeMachineJob,
    KeyName = "jobsName",
    SegmentName = "jobs",
    NamePattern = "^[a-zA-Z0-9-_]{3,63}$"
  >;
}

@@doc(EdgeMachineJob.name, "Name of EdgeMachineJob");

@added(Versions.v2026_05_01_preview)
@armResourceOperations
interface EdgeMachineJobs {
  /**
   * Get a EdgeMachineJob
   */
  get is ArmResourceRead<EdgeMachineJob>;

  /**
   * Create a EdgeMachineJob
   */
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EdgeMachineJob>;

  /**
   * Delete a EdgeMachineJob
   */
  delete is ArmResourceDeleteWithoutOkAsync<EdgeMachineJob>;

  /**
   * List EdgeMachineJob resources by EdgeMachines
   */
  list is ArmResourceListByParent<EdgeMachineJob>;
}
