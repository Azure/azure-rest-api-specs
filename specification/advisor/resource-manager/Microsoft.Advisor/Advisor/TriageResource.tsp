import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
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
@removed(Versions.v2026_03_01_preview)
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Compatibility: preserves the legacy triage resource parameter and provider path shape in API versions 2025-05-01-preview and 2026-02-01-preview; changing it would alter the TriageResourceOps interface."
@removed(Versions.v2026_03_01_preview)
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Compatibility: preserves the legacy triage resource operation route shapes in API versions 2025-05-01-preview and 2026-02-01-preview; changing it would alter the TriageResources interface."
@removed(Versions.v2026_03_01_preview)
interface TriageResources {
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Compatibility: preserves the legacy GET triage resource wire shape in API versions 2025-05-01-preview and 2026-02-01-preview; changing it would alter the triageResources_Get operation."
  #deprecated "This operation is no longer supported. The Azure Advisor triage workflow has been retired and there is no replacement API. Clients should stop calling this operation."
  @doc("Deprecated: This operation is no longer supported. The Azure Advisor triage workflow has been retired and there is no replacement API. Clients should stop calling this operation.")
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

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Compatibility: preserves the legacy list triage resources wire shape in API versions 2025-05-01-preview and 2026-02-01-preview; changing it would alter the triageResources_List operation."
  #deprecated "This operation is no longer supported. The Azure Advisor triage workflow has been retired and there is no replacement API. Clients should stop calling this operation."
  @doc("Deprecated: This operation is no longer supported. The Azure Advisor triage workflow has been retired and there is no replacement API. Clients should stop calling this operation.")
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

@@doc(
  TriageResource.name,
  "Existing recommendation triage resource associated with a triage recommendation. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000)."
);
@@doc(TriageResource.properties, "Triage resource properties.");
