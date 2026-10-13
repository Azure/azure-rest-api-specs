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
 * Class representing the web model of SQL Database.
 */
@parentResource(SqlSite)
model SqlJob is Azure.ResourceManager.ProxyResource<JobProperties> {
  ...ResourceNameParameter<
    Resource = SqlJob,
    KeyName = "jobName",
    SegmentName = "jobs"
  >;
}

@armResourceOperations(#{ omitTags: true })
interface SqlJobs {
  /**
   * Get a SqlJob
   */
  @summary("Gets the sql Job.")
  @tag("SqlJobsController")
  get is ArmResourceRead<SqlJob>;

  /**
   * List SqlJob resources by SqlSite
   */
  @summary("Gets the sql Jobs.")
  @tag("SqlJobsController")
  listBySqlSite is ArmResourceListByParent<SqlJob>;
}

@@doc(SqlJob.name, "SQL Job name.");
@@doc(SqlJob.properties, "The resource-specific properties for this resource.");
