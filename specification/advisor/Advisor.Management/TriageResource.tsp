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
    NamePattern = ""
  >;
}

@armResourceOperations
interface TriageResources {
  /**
   * Get a triage resource for a given review and recommendation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("triageResources_Get")
  get is ArmResourceRead<TriageResource>;

  /**
   * List all triage resources that belong to a review and recommendation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("triageResources_List")
  list is ArmResourceListByParent<
    TriageResource,
    Response = ArmResponse<TriageResourceCollection>
  >;
}

@@doc(TriageResource.name,
  "Existing recommendation triage resource associated with a triage recommendation. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000)."
);
@@doc(TriageResource.properties, "Triage resource properties.");
