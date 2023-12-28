import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./JobAgent.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("A job.")
@parentResource(JobAgent)
model Job is ProxyResource<JobProperties> {
  @doc("The name of the job to get.")
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
}

@armResourceOperations
interface JobExecutions {
  @doc("Starts an elastic job execution.")
  create is ArmResourceActionAsync<Job, void, JobExecution>;
}
