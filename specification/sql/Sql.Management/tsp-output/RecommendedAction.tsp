import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Advisor.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("Database, Server or Elastic Pool Recommended Action.")
@parentResource(Advisor)
model RecommendedAction is ProxyResource<RecommendedActionProperties> {
  @doc("The name of Database Recommended Action.")
  @key("recommendedActionName")
  @segment("recommendedActions")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface DatabaseRecommendedActions {
  @doc("Gets a database recommended action.")
  get is ArmResourceRead<RecommendedAction>;
  @doc("Updates a database recommended action.")
  update is ArmCustomPatchSync<RecommendedAction, RecommendedAction>;
  @doc("Gets list of Database Recommended Actions.")
  listByDatabaseAdvisor is ArmResourceListByParent<RecommendedAction>;
}
