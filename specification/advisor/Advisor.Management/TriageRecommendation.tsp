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

@armResourceOperations
interface TriageRecommendations {
  /**
   * Get an existing recommendation by id for an existing Azure Advisor Resiliency Review Id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("triageRecommendations_Get")
  get is ArmResourceRead<TriageRecommendation>;

  /**
   * Get list of recommendations for an existing Azure Advisor Resiliency Review Id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("triageRecommendations_List")
  list is ArmResourceListByParent<
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("approve")
  @operationId("triageRecommendations_ApproveTriageRecommendation")
  approveTriageRecommendation is ArmResourceActionSync<
    TriageRecommendation,
    void,
    OkResponse
  >;

  /**
   * Reject an existing triage recommendation for a given id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("reject")
  @operationId("triageRecommendations_RejectTriageRecommendation")
  rejectTriageRecommendation is ArmResourceActionSync<
    TriageRecommendation,
    RecommendationRejectBody,
    OkResponse
  >;

  /**
   * Reset an existing triage recommendation for a given id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("reset")
  @operationId("triageRecommendations_ResetTriageRecommendation")
  resetTriageRecommendation is ArmResourceActionSync<
    TriageRecommendation,
    void,
    OkResponse
  >;
}

@@doc(TriageRecommendation.name,
  "Existing triage recommendation id. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000)."
);
@@doc(TriageRecommendation.properties, "Advisor resiliency review properties.");
@@doc(TriageRecommendations.rejectTriageRecommendation::parameters.body,
  "JSON object that contains reason for rejecting triage recommendation."
);
