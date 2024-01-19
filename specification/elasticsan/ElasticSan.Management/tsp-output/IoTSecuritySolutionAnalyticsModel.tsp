import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./IoTSecuritySolutionModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
@doc("Security analytics of your IoT Security solution")
@singleton("default")
@parentResource(IoTSecuritySolutionModel)
model IoTSecuritySolutionAnalyticsModel
  is ProxyResource<IoTSecuritySolutionAnalyticsModelProperties> {
  @key("analyticsModel")
  @segment("analyticsModels")
  name: string;
}

@armResourceOperations
interface IoTSecuritySolutionAnalyticsModels {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Use this method to get IoT Security Analytics metrics.")
  @operationId("IotSecuritySolutionAnalytics_Get")
  get is ArmResourceRead<IoTSecuritySolutionAnalyticsModel>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Use this method to get IoT security Analytics metrics in an array.")
  @operationId("IotSecuritySolutionAnalytics_List")
  list is ArmResourceListByParent<IoTSecuritySolutionAnalyticsModel>;
}
