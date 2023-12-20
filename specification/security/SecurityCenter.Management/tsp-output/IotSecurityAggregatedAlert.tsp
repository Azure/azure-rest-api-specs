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
@doc("Security Solution Aggregated Alert information")
@parentResource(IotSecuritySolutionAnalyticsModel)
model IotSecurityAggregatedAlert
  is ProxyResource<IoTSecurityAggregatedAlertProperties> {
  @doc("Identifier of the aggregated alert.")
  @path
  @key("aggregatedAlertName")
  @segment("aggregatedAlerts")
  name: string;
}

@armResourceOperations
interface IotSecurityAggregatedAlerts {
  @doc("Use this method to get a single the aggregated alert of yours IoT Security solution. This aggregation is performed by alert name.")
  get is ArmResourceRead<IotSecurityAggregatedAlert>;
  @doc("Use this method to get the aggregated alert list of yours IoT Security solution.")
  list is ArmResourceListByParent<
    IotSecurityAggregatedAlert,
    {
      ...BaseParameters<IotSecurityAggregatedAlert>;

      @doc("Number of results to retrieve.")
      @query("$top")
      $top?: int32;
    }
  >;
  @doc("Use this method to dismiss an aggregated IoT Security Solution Alert.")
  dismiss is ArmResourceActionSync<IotSecurityAggregatedAlert, void, void>;
}
