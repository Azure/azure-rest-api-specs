import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./IoTSecuritySolutionModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
/**
 * Security analytics of your IoT Security solution
 */
@singleton("default")
@parentResource(IoTSecuritySolutionModel)
model IoTSecuritySolutionAnalyticsModel
  is Azure.ResourceManager.ProxyResource<IoTSecuritySolutionAnalyticsModelProperties> {
  ...ResourceNameParameter<
    Resource = IoTSecuritySolutionAnalyticsModel,
    KeyName = "analyticsModel",
    SegmentName = "analyticsModels",
    NamePattern = ""
  >;
}

@armResourceOperations
interface IoTSecuritySolutionAnalyticsModels {
  /**
   * Use this method to get IoT Security Analytics metrics.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IotSecuritySolutionAnalytics_Get")
  get is ArmResourceRead<IoTSecuritySolutionAnalyticsModel>;

  /**
   * Use this method to get IoT security Analytics metrics in an array.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IotSecuritySolutionAnalytics_List")
  list is ArmResourceListByParent<
    IoTSecuritySolutionAnalyticsModel,
    Response = ArmResponse<IoTSecuritySolutionAnalyticsModelList>
  >;
}

@@doc(IoTSecuritySolutionAnalyticsModel.name, "");
@@doc(IoTSecuritySolutionAnalyticsModel.properties,
  "Security Solution  Aggregated Alert data"
);
