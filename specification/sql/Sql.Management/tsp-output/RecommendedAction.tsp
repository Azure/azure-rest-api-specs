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
/**
 * Database, Server or Elastic Pool Recommended Action.
 */
@parentResource(Advisor)
model RecommendedAction is ProxyResource<RecommendedActionProperties> {
  /**
   * The name of Database Recommended Action.
   */
  @path
  @key("recommendedActionName")
  @segment("recommendedActions")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface RecommendedActions {
  /**
   * Gets a database recommended action.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DatabaseRecommendedActions_Get")
  get is ArmResourceRead<RecommendedAction>;

  /**
   * Updates a database recommended action.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("DatabaseRecommendedActions_Update")
  update is ArmCustomPatchSync<RecommendedAction, RecommendedAction>;

  /**
   * Gets list of Database Recommended Actions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
