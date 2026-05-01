import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ImportSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OffAzure;
/**
 * A host resource belonging to a site resource.
 */
@parentResource(ImportSite)
model DeleteImportMachinesJob
  is Azure.ResourceManager.ProxyResource<DeleteImportedMachinesJobProperties> {
  ...ResourceNameParameter<
    Resource = DeleteImportMachinesJob,
    KeyName = "jobName",
    SegmentName = "deleteJobs"
  >;
}

@armResourceOperations(#{ omitTags: true })
interface DeleteImportMachinesJobs {
  /**
   * Gets the delete imported machines job with the given job name.
   */
  @tag("ImportJobsController")
  getDeletejob is ArmResourceRead<DeleteImportMachinesJob>;

  /**
   * Method to get all delete import machines job for the given site.
   */
  @tag("ImportJobsController")
  listDeletejobs is ArmResourceListByParent<
    DeleteImportMachinesJob,
    Response = ArmResponse<PagedDeleteImportMachinesJob>
  >;
}

@@doc(DeleteImportMachinesJob.name, "Job Arm Name.");
@@doc(DeleteImportMachinesJob.properties,
  "The resource-specific properties for this resource."
);
