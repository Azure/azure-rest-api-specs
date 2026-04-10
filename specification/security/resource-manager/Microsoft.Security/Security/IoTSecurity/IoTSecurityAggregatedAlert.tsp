import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./IoTSecuritySolutionAnalyticsModel.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Common;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

@armResourceOperations(#{ omitTags: true })
interface IoTSecurityAggregatedAlerts {
  /**
   * Use this method to get a single the aggregated alert of yours IoT Security solution. This aggregation is performed by alert name.
   */
  @tag("Aggregated Alert")
  get is ArmResourceRead<IoTSecurityAggregatedAlert, Error = CloudError>;

  /**
   * Use this method to get the aggregated alert list of yours IoT Security solution.
   */
  @tag("Aggregated Alert")
  list is ArmResourceListByParent<
    IoTSecurityAggregatedAlert,
    Parameters = {
      /**
       * Number of results to retrieve.
       */
      @query("$top")
      $top?: int32;
    },
    Response = ArmResponse<IoTSecurityAggregatedAlertList>,
    Error = CloudError
  >;

  /**
   * Use this method to dismiss an aggregated IoT Security Solution Alert.
   */
  @tag("Aggregated Alert")
  dismiss is ArmResourceActionSync<
    IoTSecurityAggregatedAlert,
    void,
    OkResponse,
    Error = CloudError
  >;
}

@@doc(IoTSecurityAggregatedAlert.name, "Identifier of the aggregated alert.");
@@doc(IoTSecurityAggregatedAlert.properties,
  "IoT Security solution aggregated alert details."
);


