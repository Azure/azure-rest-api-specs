import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityInsights;
/**
 * Recommendation object.
 */
model Recommendation
  is Azure.ResourceManager.ProxyResource<RecommendationProperties> {
  ...ResourceNameParameter<
    Resource = Recommendation,
    KeyName = "recommendationId",
    SegmentName = "recommendations",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Recommendations {
  /**
   * Gets a recommendation by its id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Get_SingleRecommendation")
  singleRecommendation is Extension.Read<
    workspaceExternalResource,
    Recommendation,
    Error = CloudError
  >;

  /**
   * Patch a recommendation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Update_Recommendation")
  @patch(#{ implicitOptionality: false })
  recommendation is Extension.CustomPatchSync<
    workspaceExternalResource,
    Recommendation,
    PatchModel = RecommendationPatch,
    Error = CloudError
  >;

  /**
   * Gets a list of all recommendations.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GetRecommendations_List")
  list is Extension.ListByTarget<
    workspaceExternalResource,
    Recommendation,
    Response = ArmResponse<RecommendationList>,
    Error = CloudError
  >;

  /**
   * Reevaluate a recommendation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Reevaluate_Recommendation")
  @action("triggerEvaluation")
  reevaluateRecommendation is Extension.ActionSync<
    workspaceExternalResource,
    Recommendation,
    void,
    ArmResponse<ReevaluateResponse>,
    Error = CloudError
  >;
}

#suppress "@azure-tools/typespec-azure-core/no-format"
@@format(Recommendation.name, "uuid");
@@doc(Recommendation.name, "Recommendation Id.");
@@doc(Recommendation.properties, "Recommendation properties object.");
@@doc(Recommendations.recommendation::parameters.properties,
  "Recommendation Fields to Update."
);
