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
@doc("A group of job targets.")
@parentResource(SqlServerJobAgent)
model SqlServerJobTargetGroup is ProxyResource<JobTargetGroupProperties> {
  @doc("The name of the target group.")
  @path
  @key("targetGroupName")
  @segment("targetGroups")
  name: string;
}

@armResourceOperations
interface SqlServerJobTargetGroups {
  @doc("Gets a target group.")
  get is ArmResourceRead<SqlServerJobTargetGroup>;
  @doc("Creates or updates a target group.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SqlServerJobTargetGroup>;
  @doc("Deletes a target group.")
  delete is ArmResourceDeleteSync<SqlServerJobTargetGroup>;
  @doc("Gets all target groups in an agent.")
  listByAgent is ArmResourceListByParent<SqlServerJobTargetGroup>;
}
