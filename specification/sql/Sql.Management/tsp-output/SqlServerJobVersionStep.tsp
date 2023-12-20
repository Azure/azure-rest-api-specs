import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SqlServerJobVersion.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("A job step.")
@parentResource(SqlServerJobVersion)
model SqlServerJobVersionStep is ProxyResource<JobStepProperties> {
  @doc("The name of the job step.")
  @path
  @key("stepName")
  @segment("steps")
  name: string;
}

@armResourceOperations
interface SqlServerJobVersionSteps {
  @doc("Gets the specified version of a job step.")
  getByVersion is ArmResourceRead<SqlServerJobVersionStep>;
  @doc("Gets all job steps in the specified job version.")
  listByVersion is ArmResourceListByParent<SqlServerJobVersionStep>;
}
