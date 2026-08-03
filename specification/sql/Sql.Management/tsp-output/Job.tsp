import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./JobAgent.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A job.
 */
@parentResource(JobAgent)
model Job is ProxyResource<JobProperties> {
  /**
   * The name of the job to get.
   */
  @path
  @key("jobName")
  @segment("jobs")
  name: string;
}

@armResourceOperations
interface Jobs {
  /**
   * Gets a job.
   */
  get is ArmResourceRead<Job>;

  /**
   * Creates or updates a job.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Job>;

  /**
   * Deletes a job.
   */
  delete is ArmResourceDeleteSync<Job>;

  /**
   * Gets a list of jobs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Jobs_ListByAgent")
  listByAgent is ArmResourceListByParent<Job>;

  /**
   * Starts an elastic job execution.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("JobExecutions_Create")
  create is ArmResourceActionAsync<Job, void, JobExecution>;
}

@@projectedName(Jobs.createOrUpdate::parameters.resource, "json", "parameters");
@@extension(Jobs.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Jobs.createOrUpdate::parameters.resource, "The requested job state.");
