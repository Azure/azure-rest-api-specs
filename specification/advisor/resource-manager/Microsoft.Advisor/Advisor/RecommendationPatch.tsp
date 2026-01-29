import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.Advisor;
/**
 * Advisor Recommendation.
 */
@added(Versions.v2026_02_01) 
model RecommendationsPatchResponse
    is Azure.ResourceManager.ExtensionResource<RecommendationPatchProperties> {
    ...ResourceNameParameter<
    Resource = RecommendationsPatchResponse,
      KeyName = "recommendationId",
      SegmentName = "recommendations",
      NamePattern = ""
      >;
}

@armResourceOperations
@added(Versions.v2026_02_01)
interface RecommendationsPatch {

  /**
   * Update the state properties of a Recommendation.
   */
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  patch is ArmCustomPatchSync<
    RecommendationsPatchResponse,
    PatchModel = RecommendationStatePropertiesPayload,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Error = ArmDefaultErrorResponse
  >;

  }
