import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VmwareSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OffAzure;
/**
 * A host resource belonging to a site resource.
 */
@parentResource(VmwareSite)
model VmwareJob is Azure.ResourceManager.ProxyResource<JobProperties> {
  ...ResourceNameParameter<
    Resource = VmwareJob,
    KeyName = "jobName",
    SegmentName = "jobs"
  >;
}

@armResourceOperations
interface VmwareJobs {
  /**
   * Get a VmwareJob
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HypervJobsController_Get")
  get is ArmResourceRead<VmwareJob>;

  /**
   * List VmwareJob resources by VmwareSite
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HypervJobsController_ListByVmwareSite")
  listByVmwareSite is ArmResourceListByParent<VmwareJob>;
}

@@doc(VmwareJob.name, " Jobs name");
@@doc(VmwareJob.properties,
  "The resource-specific properties for this resource."
);
