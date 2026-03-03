import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Advisor.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * Database, Server or Elastic Pool Recommended Action.
 */
@parentResource(Advisor)
model RecommendedAction
  is Azure.ResourceManager.ProxyResource<RecommendedActionProperties> {
  ...ResourceNameParameter<
    Resource = RecommendedAction,
    KeyName = "recommendedActionName",
    SegmentName = "recommendedActions",
    NamePattern = ""
  >;

  /**
   * Resource kind.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  kind?: string;

  /**
   * Resource location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface RecommendedActions {
  /**
   * Gets a database recommended action.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DatabaseRecommendedActions_Get")
  get is ArmResourceRead<RecommendedAction>;

  /**
   * Updates a database recommended action.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DatabaseRecommendedActions_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    RecommendedAction,
    PatchModel = RecommendedAction
  >;

  /**
   * Gets list of Database Recommended Actions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DatabaseRecommendedActions_ListByDatabaseAdvisor")
  listByDatabaseAdvisor is ArmResourceListByParent<
    RecommendedAction,
    Response = ArmResponse<RecommendedAction[]>
  >;
}

@@doc(RecommendedAction.name, "The name of Database Recommended Action.");
@@doc(RecommendedAction.properties, "Resource properties.");
@@doc(RecommendedActions.update::parameters.properties,
  "The requested recommended action resource state."
);
