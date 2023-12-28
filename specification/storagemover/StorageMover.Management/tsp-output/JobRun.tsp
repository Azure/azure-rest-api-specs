import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./JobDefinition.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.StorageMover;
@doc("The Job Run resource.")
@parentResource(JobDefinition)
model JobRun is ProxyResource<JobRunProperties> {
  @doc("The name of the Job Run resource.")
  @key("jobRunName")
  @segment("jobRuns")
  name: string;
}

@armResourceOperations
interface JobRuns {
  @doc("Gets a Job Run resource.")
  get is ArmResourceRead<JobRun>;
  @doc("Lists all Job Runs in a Job Definition.")
  list is ArmResourceListByParent<JobRun>;
}
