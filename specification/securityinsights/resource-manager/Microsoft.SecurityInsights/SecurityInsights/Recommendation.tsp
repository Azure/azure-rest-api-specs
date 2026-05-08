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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;
}

@armResourceOperations(#{ omitTags: true })
interface Recommendations {
  /**
   * Gets a recommendation by its id.
   */
  @tag("recommendations")
  singleRecommendation is Extension.Read<
    workspaceExternalResource,
    Recommendation,
    Error = CloudError
  >;

  /**
   * Patch a recommendation.
   */
  @tag("recommendations")
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
  @tag("recommendations")
  list is Extension.ListByTarget<
    workspaceExternalResource,
    Recommendation,
    Response = ArmResponse<RecommendationList>,
    Error = CloudError
  >;

  /**
   * Reevaluate a recommendation.
   */
  @action("triggerEvaluation")
  @tag("recommendations")
  reevaluateRecommendation is Extension.ActionSync<
    workspaceExternalResource,
    Recommendation,
    void,
    ArmResponse<ReevaluateResponse>,
    Error = CloudError
  >;
}

#suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@format(Recommendation.name, "uuid");
@@doc(Recommendation.name, "Recommendation Id.");
@@doc(Recommendation.properties, "Recommendation properties object.");
@@doc(Recommendations.recommendation::parameters.properties,
  "Recommendation Fields to Update."
);
