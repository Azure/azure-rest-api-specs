import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Advisor.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
@doc("Database, Server or Elastic Pool Recommended Action.")
@parentResource(Advisor)
model RecommendedAction is ProxyResource<RecommendedActionProperties> {
  @doc("The name of Database Recommended Action.")
  @path
  @key("recommendedActionName")
  @segment("recommendedActions")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface RecommendedActions {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a database recommended action.")
  @operationId("DatabaseRecommendedActions_Get")
  get is ArmResourceRead<RecommendedAction>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates a database recommended action.")
  @operationId("DatabaseRecommendedActions_Update")
  update is ArmCustomPatchSync<RecommendedAction, RecommendedAction>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets list of Database Recommended Actions.")
  @operationId("DatabaseRecommendedActions_ListByDatabaseAdvisor")
  listByDatabaseAdvisor is ArmResourceListByParent<RecommendedAction>;
}

@@projectedName(RecommendedActions.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(RecommendedActions.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(RecommendedActions.update::parameters.properties,
  "The requested recommended action resource state."
);
