import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Advisor;
/**
 * Advisor Recommendation.
 */
@extensionResource
model ResourceRecommendationBase
  is Azure.ResourceManager.ExtensionResource<RecommendationProperties> {
  ...ResourceNameParameter<
    Resource = ResourceRecommendationBase,
    KeyName = "recommendationId",
    SegmentName = "recommendations",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ResourceRecommendationBases {
  /**
   * Obtains details of a cached recommendation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Recommendations_Get")
  get is ArmResourceRead<
    ResourceRecommendationBase,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters,
  >;

  /**
   * Update the tracked properties of a Recommendation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("Recommendations_Patch")
  patch is ArmCustomPatchSync<
    ResourceRecommendationBase,
    PatchModel = TrackedRecommendationPropertiesPayload,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters,
  >;

  /**
   * Obtains cached recommendations for a subscription. The recommendations are generated or computed by invoking generateRecommendations.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Recommendations_List")
  list is ArmResourceListByParent<
    ResourceRecommendationBase,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Parameters = {
      /**
       * The filter to apply to the recommendations.<br>Filter can be applied to properties ['ResourceId', 'ResourceGroup', 'RecommendationTypeGuid', '[Category](#category)'] with operators ['eq', 'and', 'or'].<br>Example:<br>- $filter=Category eq 'Cost' and ResourceGroup eq 'MyResourceGroup'
       */
      @query("$filter")
      $filter?: string;

      /**
       * The number of recommendations per page if a paged version of this API is being used.
       */
      @query("$top")
      $top?: int32;

      /**
       * The page-continuation token to use with a paged version of this API.
       */
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
}

@@doc(ResourceRecommendationBase.name, "The recommendation ID.");
@@doc(ResourceRecommendationBase.properties,
  "The properties of the recommendation."
);
@@doc(ResourceRecommendationBases.patch::parameters.properties,
  "The properties to update on the recommendation."
);
