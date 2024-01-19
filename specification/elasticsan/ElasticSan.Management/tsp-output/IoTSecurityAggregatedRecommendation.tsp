import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./IoTSecuritySolutionAnalyticsModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
@doc("IoT Security solution recommendation information.")
@parentResource(IoTSecuritySolutionAnalyticsModel)
model IoTSecurityAggregatedRecommendation
  is ProxyResource<IoTSecurityAggregatedRecommendationProperties> {
  @doc("Name of the recommendation aggregated for this query.")
  @path
  @key("aggregatedRecommendationName")
  @segment("aggregatedRecommendations")
  name: string;
}

@armResourceOperations
interface IoTSecurityAggregatedRecommendations {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Use this method to get the aggregated security analytics recommendation of yours IoT Security solution. This aggregation is performed by recommendation name.")
  @operationId("IotSecuritySolutionsAnalyticsRecommendation_Get")
  get is ArmResourceRead<IoTSecurityAggregatedRecommendation>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Use this method to get the list of aggregated security analytics recommendations of yours IoT Security solution.")
  @operationId("IotSecuritySolutionsAnalyticsRecommendation_List")
  list is ArmResourceListByParent<
    IoTSecurityAggregatedRecommendation,
    {
      ...BaseParameters<IoTSecurityAggregatedRecommendation>;

      @doc("Number of results to retrieve.")
      @query("$top")
      $top?: int32;
    }
  >;
}
