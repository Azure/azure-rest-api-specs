import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Advisor;
@doc("Advisor Recommendation.")
model ResourceRecommendationBase
  is ExtensionResource<RecommendationProperties> {
  @doc("The recommendation ID.")
  @path
  @key("recommendationId")
  @segment("recommendations")
  name: string;
}

@armResourceOperations
interface ResourceRecommendationBases {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Obtains details of a cached recommendation.")
  @operationId("Recommendations_Get")
  get is ArmResourceRead<ResourceRecommendationBase>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Obtains cached recommendations for a subscription. The recommendations are generated or computed by invoking generateRecommendations.")
  @operationId("Recommendations_List")
  list is ArmResourceListByParent<
    ResourceRecommendationBase,
    {
      ...BaseParameters<ResourceRecommendationBase>;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("The filter to apply to the recommendations.<br>Filter can be applied to properties ['ResourceId', 'ResourceGroup', 'RecommendationTypeGuid', '[Category](#category)'] with operators ['eq', 'and', 'or'].<br>Example:<br>- $filter=Category eq 'Cost' and ResourceGroup eq 'MyResourceGroup'")
      @query("$filter")
      $filter?: string;

      @doc("The number of recommendations per page if a paged version of this API is being used.")
      @query("$top")
      $top?: int32;

      @doc("The page-continuation token to use with a paged version of this API.")
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
}
