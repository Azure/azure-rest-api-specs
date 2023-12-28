import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./IoTSecuritySolutionModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SecurityCenter;
@doc("Security analytics of your IoT Security solution")
@singleton("default")
@parentResource(IoTSecuritySolutionModel)
model IoTSecuritySolutionAnalyticsModel
  is ProxyResource<IoTSecuritySolutionAnalyticsModelProperties> {
  @key("default")
  @segment("analyticsModels")
  name: string;
}

@armResourceOperations
interface IotSecuritySolutionAnalytics {
  @doc("Use this method to get IoT Security Analytics metrics.")
  get is ArmResourceRead<IoTSecuritySolutionAnalyticsModel>;
  @doc("Use this method to get IoT security Analytics metrics in an array.")
  list is ArmResourceListByParent<IoTSecuritySolutionAnalyticsModel>;
}
