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
@doc("Security Solution Aggregated Alert information")
@parentResource(IoTSecuritySolutionAnalyticsModel)
model IoTSecurityAggregatedAlert
  is ProxyResource<IoTSecurityAggregatedAlertProperties> {
  @doc("Identifier of the aggregated alert.")
  @path
  @key("aggregatedAlertName")
  @segment("aggregatedAlerts")
  name: string;
}

@armResourceOperations
interface IoTSecurityAggregatedAlerts {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Use this method to get a single the aggregated alert of yours IoT Security solution. This aggregation is performed by alert name.")
  @operationId("IotSecuritySolutionsAnalyticsAggregatedAlert_Get")
  get is ArmResourceRead<IoTSecurityAggregatedAlert>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Use this method to get the aggregated alert list of yours IoT Security solution.")
  @operationId("IotSecuritySolutionsAnalyticsAggregatedAlert_List")
  list is ArmResourceListByParent<
    IoTSecurityAggregatedAlert,
    {
      ...BaseParameters<IoTSecurityAggregatedAlert>;

      @doc("Number of results to retrieve.")
      @query("$top")
      $top?: int32;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Use this method to dismiss an aggregated IoT Security Solution Alert.")
  @operationId("IotSecuritySolutionsAnalyticsAggregatedAlert_Dismiss")
  dismiss is ArmResourceActionSync<IoTSecurityAggregatedAlert, void, void>;
}
