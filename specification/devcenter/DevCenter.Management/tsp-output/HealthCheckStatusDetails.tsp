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
/**
 * Health Check details.
 */
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
  /**
   * Gets health check status details.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NetworkConnections_GetHealthDetails")
  getHealthDetails is ArmResourceRead<HealthCheckStatusDetails>;

  /**
   * Lists health check status details
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NetworkConnections_ListHealthDetails")
  listHealthDetails is ArmResourceListByParent<
    HealthCheckStatusDetails,
    {
      ...BaseParameters<HealthCheckStatusDetails>;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;
    }
  >;
}
