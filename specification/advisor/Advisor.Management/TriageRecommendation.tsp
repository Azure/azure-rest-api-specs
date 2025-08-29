import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ResiliencyReview.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Advisor;
/**
 * Triage recommendation data structure.
 */
@parentResource(ResiliencyReview)
model TriageRecommendation
  is Azure.ResourceManager.ProxyResource<TriageRecommendationProperties> {
  ...ResourceNameParameter<
    Resource = TriageRecommendation,
    KeyName = "recommendationId",
    SegmentName = "triageRecommendations",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface TriageRecommendationOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Existing review id. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000). */
        @path
        @segment("resiliencyReviews")
        reviewId: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = TriageRecommendation,
        KeyName = "recommendationId",
        SegmentName = "providers/Microsoft.Advisor/triageRecommendations",
        NamePattern = ""
      >>
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface TriageRecommendations {
  /**
   * Get an existing recommendation by id for an existing Azure Advisor Resiliency Review Id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("triageRecommendations_Get")
  get is TriageRecommendationOps.Read<TriageRecommendation>;

  /**
   * Get list of recommendations for an existing Azure Advisor Resiliency Review Id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @segment("providers/Microsoft.Advisor/triageRecommendations")
  @operationId("triageRecommendations_List")
  list is TriageRecommendationOps.List<
    TriageRecommendation,
    Parameters = {
      /**
       * The number of items to be included in the result.
       */
      @query("$top")
      $top?: int32;

      /**
       * The number of items to skip before starting to collect the result set.
       */
      @query("$skip")
      $skip?: int32;
    },
    Response = ArmResponse<TriageRecommendationCollection>
  >;

  /**
   * Approve a triage recommendation for a given id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("triageRecommendations_ApproveTriageRecommendation")
  @action("approve")
  approveTriageRecommendation is TriageRecommendationOps.ActionSync<
    TriageRecommendation,
    void,
    OkResponse
  >;

  /**
   * Reject an existing triage recommendation for a given id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("triageRecommendations_RejectTriageRecommendation")
  @action("reject")
  rejectTriageRecommendation is TriageRecommendationOps.ActionSync<
    TriageRecommendation,
    RecommendationRejectBody,
    OkResponse
  >;

  /**
   * Reset an existing triage recommendation for a given id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("triageRecommendations_ResetTriageRecommendation")
  @action("reset")
  resetTriageRecommendation is TriageRecommendationOps.ActionSync<
    TriageRecommendation,
    void,
    OkResponse,
    Parameters = {}
  >;
}

@@doc(TriageRecommendation.name,
  "Existing triage recommendation id. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000)."
);
@@doc(TriageRecommendation.properties, "Advisor resiliency review properties.");
@@doc(TriageRecommendations.rejectTriageRecommendation::parameters.body,
  "JSON object that contains reason for rejecting triage recommendation."
);
