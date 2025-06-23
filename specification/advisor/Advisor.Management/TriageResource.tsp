import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./TriageRecommendation.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Advisor;
/**
 * Triage resource data structure.
 */
@parentResource(TriageRecommendation)
model TriageResource
  is Azure.ResourceManager.ProxyResource<TriageResourceProperties> {
  ...ResourceNameParameter<
    Resource = TriageResource,
    KeyName = "recommendationResourceId",
    SegmentName = "triageResources",
    NamePattern = "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface TriageResourceOps
  extends Azure.ResourceManager.Legacy.CustomLegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,

        /** Existing review id. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000). */
        @path
        @segment("resiliencyReviews")
        reviewId: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = TriageRecommendation,
        KeyName = "recommendationId",
        SegmentName = "triageRecommendations",
        NamePattern = "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      >>
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface TriageResources {
  /**
   * Get a triage resource for a given review and recommendation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/resiliencyReviews/{reviewId}/providers/Microsoft.Advisor/triageRecommendations/{recommendationId}/providers/Microsoft.Advisor/triageResources/{recommendationResourceId}")
  @operationId("triageResources_Get")
  get is TriageResourceOps.Read<
    TriageResource,
    Parameters = {
      /**
       * The triage resource id.
       */
      @path
      @segment("triageResources")
      recommendationResourceId: string;
    }
  >;

  /**
   * List all triage resources that belong to a review and recommendation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/resiliencyReviews/{reviewId}/providers/Microsoft.Advisor/triageRecommendations/{recommendationId}/providers/Microsoft.Advisor/triageResources")
  @operationId("triageResources_List")
  list is TriageResourceOps.List<
    TriageResource,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @path
      recommendationId: string;
    },
    Response = ArmResponse<TriageResourceCollection>
  >;
}

@@doc(TriageResource.name,
  "Existing recommendation triage resource associated with a triage recommendation. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000)."
);
@@doc(TriageResource.properties, "Triage resource properties.");
