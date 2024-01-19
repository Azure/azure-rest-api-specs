import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./JobVersion.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
@doc("A job step.")
@parentResource(JobVersion)
model JobStep is ProxyResource<JobStepProperties> {
  @doc("The name of the job step.")
  @path
  @key("stepName")
  @segment("steps")
  name: string;
}

@armResourceOperations
interface JobSteps {
  @doc("Gets the specified version of a job step.")
  getByVersion is ArmResourceRead<JobStep>;

  @doc("Gets all job steps in the specified job version.")
  listByVersion is ArmResourceListByParent<JobStep>;
}
