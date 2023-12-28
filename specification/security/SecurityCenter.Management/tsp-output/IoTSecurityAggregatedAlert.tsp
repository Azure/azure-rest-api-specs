import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./IoTSecuritySolutionAnalyticsModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SecurityCenter;
@doc("Security Solution Aggregated Alert information")
@parentResource(IoTSecuritySolutionAnalyticsModel)
model IoTSecurityAggregatedAlert
  is ProxyResource<IoTSecurityAggregatedAlertProperties> {
  @doc("Identifier of the aggregated alert.")
  @key("aggregatedAlertName")
  @segment("aggregatedAlerts")
  name: string;
}

@armResourceOperations
interface IotSecuritySolutionsAnalyticsAggregatedAlert {
  @doc("Use this method to get a single the aggregated alert of yours IoT Security solution. This aggregation is performed by alert name.")
  get is ArmResourceRead<IoTSecurityAggregatedAlert>;
  @doc("Use this method to get the aggregated alert list of yours IoT Security solution.")
  list is ArmResourceListByParent<
    IoTSecurityAggregatedAlert,
    {
      ...BaseParameters<IoTSecurityAggregatedAlert>;

      @doc("Number of results to retrieve.")
      @query("$top")
      $top?: int32;
    }
  >;
  @doc("Use this method to dismiss an aggregated IoT Security Solution Alert.")
  dismiss is ArmResourceActionSync<IoTSecurityAggregatedAlert, void, void>;
}
