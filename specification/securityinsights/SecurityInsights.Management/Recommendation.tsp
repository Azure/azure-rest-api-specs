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

  /**
   * Etag of the azure resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

alias workspaceExternalResource = Extension.ExternalResource<
  "Microsoft.OperationalInsights",
  "workspaces",
  "{workspaceName}"
>;

@armResourceOperations
interface Recommendations {
  /**
   * Gets a recommendation by its id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Get_SingleRecommendation")
  singleRecommendation is ArmResourceRead<Recommendation>;

  /**
   * Patch a recommendation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Update_Recommendation")
  @patch(#{ implicitOptionality: false })
  recommendation is ArmCustomPatchSync<
    Recommendation,
    PatchModel = RecommendationPatch
  >;

  /**
   * Gets a list of all recommendations.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GetRecommendations_List")
  list is ArmResourceListByParent<
    Recommendation,
    Response = ArmResponse<RecommendationList>
  >;

  /**
   * Reevaluate a recommendation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Reevaluate_Recommendation")
  @action("triggerEvaluation")
  reevaluateRecommendation is ArmResourceActionSync<
    Recommendation,
    void,
    ArmResponse<ReevaluateResponse>
  >;
}

#suppress "@azure-tools/typespec-azure-core/no-format"
@@format(Recommendation.name, "uuid");
@@doc(Recommendation.name, "Recommendation Id.");
@@doc(Recommendation.properties, "Recommendation properties object.");
@@doc(Recommendations.recommendation::parameters.properties,
  "Recommendation Fields to Update."
);
