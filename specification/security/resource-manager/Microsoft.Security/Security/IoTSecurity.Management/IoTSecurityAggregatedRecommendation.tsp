import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./IoTSecuritySolutionAnalyticsModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
/**
 * IoT Security solution recommendation information.
 */
@parentResource(IoTSecuritySolutionAnalyticsModel)
model IoTSecurityAggregatedRecommendation
  is Azure.ResourceManager.ProxyResource<IoTSecurityAggregatedRecommendationProperties> {
  ...ResourceNameParameter<
    Resource = IoTSecurityAggregatedRecommendation,
    KeyName = "aggregatedRecommendationName",
    SegmentName = "aggregatedRecommendations",
    NamePattern = ""
  >;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  tags?: Record<string>;
}

@armResourceOperations
interface IoTSecurityAggregatedRecommendations {
  /**
   * Use this method to get the aggregated security analytics recommendation of yours IoT Security solution. This aggregation is performed by recommendation name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IotSecuritySolutionsAnalyticsRecommendation_Get")
  get is ArmResourceRead<IoTSecurityAggregatedRecommendation>;

  /**
   * Use this method to get the list of aggregated security analytics recommendations of yours IoT Security solution.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IotSecuritySolutionsAnalyticsRecommendation_List")
  list is ArmResourceListByParent<
    IoTSecurityAggregatedRecommendation,
    Parameters = {
      /**
       * Number of results to retrieve.
       */
      @query("$top")
      $top?: int32;
    },
    Response = ArmResponse<IoTSecurityAggregatedRecommendationList>
  >;
}

@@doc(IoTSecurityAggregatedRecommendation.name,
  "Name of the recommendation aggregated for this query."
);
@@doc(IoTSecurityAggregatedRecommendation.properties, "Security Solution data");
