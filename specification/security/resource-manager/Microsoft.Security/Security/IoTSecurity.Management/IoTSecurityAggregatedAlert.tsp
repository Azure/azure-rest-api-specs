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
 * Security Solution Aggregated Alert information
 */
@parentResource(IoTSecuritySolutionAnalyticsModel)
model IoTSecurityAggregatedAlert
  is Azure.ResourceManager.ProxyResource<IoTSecurityAggregatedAlertProperties> {
  ...ResourceNameParameter<
    Resource = IoTSecurityAggregatedAlert,
    KeyName = "aggregatedAlertName",
    SegmentName = "aggregatedAlerts",
    NamePattern = ""
  >;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  tags?: Record<string>;
}

@armResourceOperations
interface IoTSecurityAggregatedAlerts {
  /**
   * Use this method to get a single the aggregated alert of yours IoT Security solution. This aggregation is performed by alert name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IotSecuritySolutionsAnalyticsAggregatedAlert_Get")
  get is ArmResourceRead<IoTSecurityAggregatedAlert>;

  /**
   * Use this method to get the aggregated alert list of yours IoT Security solution.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IotSecuritySolutionsAnalyticsAggregatedAlert_List")
  list is ArmResourceListByParent<
    IoTSecurityAggregatedAlert,
    Parameters = {
      /**
       * Number of results to retrieve.
       */
      @query("$top")
      $top?: int32;
    },
    Response = ArmResponse<IoTSecurityAggregatedAlertList>
  >;

  /**
   * Use this method to dismiss an aggregated IoT Security Solution Alert.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IotSecuritySolutionsAnalyticsAggregatedAlert_Dismiss")
  dismiss is ArmResourceActionSync<
    IoTSecurityAggregatedAlert,
    void,
    OkResponse
  >;
}

@@doc(IoTSecurityAggregatedAlert.name, "Identifier of the aggregated alert.");
@@doc(IoTSecurityAggregatedAlert.properties,
  "IoT Security solution aggregated alert details."
);
