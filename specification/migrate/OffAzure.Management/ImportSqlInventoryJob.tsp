import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SqlSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OffAzure;
/**
 * Import SQL inventory job REST Resource.
 */
@parentResource(SqlSite)
model ImportSqlInventoryJob
  is Azure.ResourceManager.ProxyResource<ImportSqlInventoryJobProperties> {
  ...ResourceNameParameter<
    Resource = ImportSqlInventoryJob,
    KeyName = "jobName",
    SegmentName = "importJobs"
  >;
}

@armResourceOperations(#{ omitTags: true })
interface ImportSqlInventoryJobs {
  /**
   * Gets the SQL inventory import job with the given job name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("SqlImportJobsController")
  @operationId("SqlImportJobsController_GetImportjob")
  getImportjob is ArmResourceRead<ImportSqlInventoryJob>;

  /**
   * Method to get all import SQL inventory job for the given site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("SqlImportJobsController")
  @operationId("SqlImportJobsController_ListImportjobs")
  listImportjobs is ArmResourceListByParent<
    ImportSqlInventoryJob,
    Response = ArmResponse<PagedImportSqlInventoryJob>
  >;
}

@@doc(ImportSqlInventoryJob.name, "Job Arm Name.");
@@doc(ImportSqlInventoryJob.properties,
  "Gets or sets the import job properties."
);
