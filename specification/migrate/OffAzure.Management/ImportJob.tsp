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
model ImportJob is Azure.ResourceManager.ProxyResource<JobProperties> {
  ...ResourceNameParameter<
    Resource = ImportJob,
    KeyName = "jobName",
    SegmentName = "jobs"
  >;
}

@armResourceOperations
interface ImportJobs {
  /**
   * Get a ImportJob
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ImportJobsController_Get")
  get is ArmResourceRead<ImportJob>;

  /**
   * List ImportJob resources by ImportSite
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ImportJobsController_ListByImportSite")
  listByImportSite is ArmResourceListByParent<ImportJob>;
}

@@doc(ImportJob.name, " Jobs name");
@@doc(ImportJob.properties,
  "The resource-specific properties for this resource."
);
