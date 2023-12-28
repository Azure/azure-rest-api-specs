import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkConnection.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DevCenter;
@doc("Health Check details.")
@singleton("latest")
@parentResource(NetworkConnection)
model HealthCheckStatusDetails
  is ProxyResource<HealthCheckStatusDetailsProperties> {
  @key("latest")
  @segment("healthChecks")
  name: string;
}

@armResourceOperations
interface NetworkConnections {
  @doc("Gets health check status details.")
  getHealthDetails is ArmResourceRead<HealthCheckStatusDetails>;
  @doc("Lists health check status details")
  listHealthDetails is ArmResourceListByParent<
    HealthCheckStatusDetails,
    {
      ...BaseParameters<HealthCheckStatusDetails>;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    }
  >;
}
