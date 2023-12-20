import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SqlServerJobAgent.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("A job.")
@parentResource(SqlServerJobAgent)
model SqlServerJob is ProxyResource<JobProperties> {
  @doc("The name of the job to get.")
  @path
  @key("jobName")
  @segment("jobs")
  name: string;
}

@armResourceOperations
interface SqlServerJobs {
  @doc("Gets a job.")
  get is ArmResourceRead<SqlServerJob>;
  @doc("Creates or updates a job.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SqlServerJob>;
  @doc("Deletes a job.")
  delete is ArmResourceDeleteSync<SqlServerJob>;
  @doc("Gets a list of jobs.")
  listByAgent is ArmResourceListByParent<SqlServerJob>;
  @doc("Starts an elastic job execution.")
  create is ArmResourceActionAsync<SqlServerJob, void, SqlServerJobExecution>;
}
