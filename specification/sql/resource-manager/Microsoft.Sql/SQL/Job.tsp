import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./JobAgent.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A job.
 */
@parentResource(JobAgent)
model Job is Azure.ResourceManager.ProxyResource<JobProperties> {
  ...ResourceNameParameter<
    Resource = Job,
    KeyName = "jobName",
    SegmentName = "jobs",
    NamePattern = ""
  >;
}

@armResourceOperations(#{ omitTags: true })
interface Jobs {
  /**
   * Gets a job.
   */
  @tag("Jobs")
  get is ArmResourceRead<Job>;

  /**
   * Creates or updates a job.
   */
  @tag("Jobs")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Job>;

  /**
   * Deletes a job.
   */
  @tag("Jobs")
  delete is ArmResourceDeleteSync<Job>;

  /**
   * Gets a list of jobs.
   */
  @tag("Jobs")
  listByAgent is ArmResourceListByParent<Job>;

  /**
   * Starts an elastic job execution.
   */
  @tag("JobExecutions")
  @action("start")
  create is ArmResourceActionAsync<Job, void, Response = JobExecution>;
}

@@doc(Job.name, "The name of the job to get.");
@@doc(Job.properties, "Resource properties.");
@@doc(Jobs.createOrUpdate::parameters.resource, "The requested job state.");
