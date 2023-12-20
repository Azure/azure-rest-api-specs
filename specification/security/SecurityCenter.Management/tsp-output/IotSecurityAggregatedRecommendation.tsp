import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./IotSecuritySolutionAnalyticsModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SecurityCenter;
@doc("IoT Security solution recommendation information.")
@parentResource(IotSecuritySolutionAnalyticsModel)
model IotSecurityAggregatedRecommendation
  is ProxyResource<IoTSecurityAggregatedRecommendationProperties> {
  @doc("Name of the recommendation aggregated for this query.")
  @path
  @key("aggregatedRecommendationName")
  @segment("aggregatedRecommendations")
  name: string;
}

@armResourceOperations
interface IotSecurityAggregatedRecommendations {
  @doc("Use this method to get the aggregated security analytics recommendation of yours IoT Security solution. This aggregation is performed by recommendation name.")
  get is ArmResourceRead<IotSecurityAggregatedRecommendation>;
  @doc("Use this method to get the list of aggregated security analytics recommendations of yours IoT Security solution.")
  list is ArmResourceListByParent<
    IotSecurityAggregatedRecommendation,
    {
      ...BaseParameters<IotSecurityAggregatedRecommendation>;

      @doc("Number of results to retrieve.")
      @query("$top")
      $top?: int32;
    }
  >;
}
