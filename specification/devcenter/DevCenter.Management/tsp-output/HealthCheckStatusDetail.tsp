import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DevCenterNetworkConnection.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DevCenter;
@doc("Health Check details.")
@parentResource(DevCenterNetworkConnection)
@singleton("latest")
model HealthCheckStatusDetail
  is ProxyResource<HealthCheckStatusDetailsProperties> {
  @key("latest")
  @segment("healthChecks")
  name: string;
}

@armResourceOperations
interface HealthCheckStatusDetails {
  @doc("Gets health check status details.")
  getHealthDetails is ArmResourceRead<HealthCheckStatusDetail>;
  @doc("Lists health check status details")
  listByDevCenterNetworkConnection is ArmResourceListByParent<
    HealthCheckStatusDetail,
    {
      ...BaseParameters<HealthCheckStatusDetail>;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    }
  >;
}
