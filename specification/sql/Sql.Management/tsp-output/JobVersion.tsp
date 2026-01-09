import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Job.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
// FIXME: JobVersion has no properties property
/**
 * A job version.
 */
@parentResource(Job)
model JobVersion is ProxyResource<{}> {
  /**
   * The version of the job to get.
   */
  @path
  @key("jobVersion")
  @segment("versions")
  name: int32;
}

@armResourceOperations
interface JobVersions {
  /**
   * Gets a job version.
   */
  get is ArmResourceRead<JobVersion>;

  /**
   * Gets all versions of a job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("JobVersions_ListByJob")
  listByJob is ArmResourceListByParent<JobVersion>;
}
