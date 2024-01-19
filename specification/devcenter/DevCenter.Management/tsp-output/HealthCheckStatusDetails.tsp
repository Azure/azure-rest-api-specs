import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkConnection.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevCenter;
@doc("Health Check details.")
@singleton("latest")
@parentResource(NetworkConnection)
model HealthCheckStatusDetails
  is ProxyResource<HealthCheckStatusDetailsProperties> {
  @key("healthCheck")
  @segment("healthChecks")
  name: string;
}

@armResourceOperations
@projectedName("client", "HealthCheckStatusDetails")
interface HealthCheckStatusDetailsOperationGroup {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets health check status details.")
  @operationId("NetworkConnections_GetHealthDetails")
  getHealthDetails is ArmResourceRead<HealthCheckStatusDetails>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists health check status details")
  @operationId("NetworkConnections_ListHealthDetails")
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
