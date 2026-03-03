import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Job.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
// FIXME: JobVersion has no properties property
/**
 * A job version.
 */
@parentResource(Job)
model JobVersion is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = JobVersion,
    KeyName = "jobVersion",
    SegmentName = "versions",
    NamePattern = "",
    Type = int32
  >;
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
  listByJob is ArmResourceListByParent<JobVersion>;
}

@@doc(JobVersion.name, "The version of the job to get.");
