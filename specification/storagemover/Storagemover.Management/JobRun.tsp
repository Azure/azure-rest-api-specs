import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./JobDefinition.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StorageMover;
/**
 * The Job Run resource.
 */
@parentResource(JobDefinition)
model JobRun is Azure.ResourceManager.ProxyResource<JobRunProperties> {
  ...ResourceNameParameter<
    Resource = JobRun,
    KeyName = "jobRunName",
    SegmentName = "jobRuns",
    NamePattern = ""
  >;
}

@armResourceOperations
interface JobRuns {
  /**
   * Gets a Job Run resource.
   */
  get is ArmResourceRead<JobRun>;

  /**
   * Lists all Job Runs in a Job Definition.
   */
  list is ArmResourceListByParent<JobRun, Response = ArmResponse<JobRunList>>;
}

@@doc(JobRun.name, "The name of the Job Run resource.");
@@doc(JobRun.properties, "Job run properties.");
