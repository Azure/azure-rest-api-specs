import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./IotSecuritySolution.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SecurityCenter;
@doc("Security analytics of your IoT Security solution")
@parentResource(IotSecuritySolution)
@singleton("default")
model IotSecuritySolutionAnalyticsModel
  is ProxyResource<IoTSecuritySolutionAnalyticsModelProperties> {
  @key("default")
  @segment("analyticsModels")
  name: string;
}

@armResourceOperations
interface IotSecuritySolutionAnalyticsModels {
  @doc("Use this method to get IoT Security Analytics metrics.")
  get is ArmResourceRead<IotSecuritySolutionAnalyticsModel>;
  @doc("Use this method to get IoT security Analytics metrics in an array.")
  listByIotSecuritySolution is ArmResourceListByParent<IotSecuritySolutionAnalyticsModel>;
}
