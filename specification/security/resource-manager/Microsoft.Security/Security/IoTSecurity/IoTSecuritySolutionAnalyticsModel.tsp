import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./IoTSecuritySolutionModel.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Common;

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

@armResourceOperations(#{ omitTags: true })
interface IoTSecuritySolutionAnalyticsModels {
  /**
   * Use this method to get IoT Security Analytics metrics.
   */
  @tag("IoT Security Solution Analytics")
  get is ArmResourceRead<IoTSecuritySolutionAnalyticsModel, Error = CloudError>;

  /**
   * Use this method to get IoT security Analytics metrics in an array.
   */
  @tag("IoT Security Solution Analytics")
  list is Azure.ResourceManager.Legacy.ArmListSinglePageByParent<
    IoTSecuritySolutionAnalyticsModel,
    Response = ArmResponse<IoTSecuritySolutionAnalyticsModelList>,
    Error = CloudError
  >;
}

@@doc(IoTSecuritySolutionAnalyticsModel.name, "");
@@doc(IoTSecuritySolutionAnalyticsModel.properties,
  "Security Solution  Aggregated Alert data"
);


