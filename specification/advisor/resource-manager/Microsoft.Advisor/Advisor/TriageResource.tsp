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
using TypeSpec.Versioning;

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
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@added(Versions.v2025_05_01_preview)
@removed(Versions.v2026_02_01)
interface TriageResourceOps
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
      {}
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@added(Versions.v2025_05_01_preview)
@removed(Versions.v2026_02_01)
interface TriageResources {
  /**
   * Get a triage resource for a given review and recommendation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Get existing triage resource.")
  @operationId("triageResources_Get")
  get is TriageResourceOps.Read<
    TriageResource,
    Parameters = {
      /**
       * Existing triage recommendation id. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      @segment("providers/Microsoft.Advisor/triageRecommendations")
      recommendationId: string;

      /**
       *
       * Existing recommendation triage resource associated with a triage recommendation. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      @segment("providers/Microsoft.Advisor/triageResources")
      recommendationResourceId: string;
    }
  >;

  /**
   * List all triage resources that belong to a review and recommendation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2025_05_01_preview)
  @removed(Versions.v2026_02_01)
  @summary("List triage resources based on a review and recommendation.")
  @segment("providers/Microsoft.Advisor/triageResources")
  @operationId("triageResources_List")
  list is TriageResourceOps.List<
    TriageResource,
    Parameters = {
      /**
       * Existing triage recommendation id. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      @segment("providers/Microsoft.Advisor/triageRecommendations")
      recommendationId: string;
    },
    Response = ArmResponse<TriageResourceCollection>
  >;
}

@@doc(TriageResource.name,
  "Existing recommendation triage resource associated with a triage recommendation. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000)."
);
@@doc(TriageResource.properties, "Triage resource properties.");
