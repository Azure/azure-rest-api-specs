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
@doc("A job.")
@parentResource(JobAgent)
model Job is ProxyResource<JobProperties> {
  @doc("The name of the job to get.")
  @path
  @key("jobName")
  @segment("jobs")
  name: string;
}

@armResourceOperations
interface Jobs {
  @doc("Gets a job.")
  get is ArmResourceRead<Job>;

  @doc("Creates or updates a job.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Job>;

  @doc("Deletes a job.")
  delete is ArmResourceDeleteSync<Job>;

  @doc("Gets a list of jobs.")
  listByAgent is ArmResourceListByParent<Job>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Starts an elastic job execution.")
  @operationId("JobExecutions_Create")
  create is ArmResourceActionAsync<Job, void, JobExecution>;
}

@@projectedName(Jobs.createOrUpdate::parameters.resource, "json", "parameters");
@@extension(Jobs.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Jobs.createOrUpdate::parameters.resource, "The requested job state.");
