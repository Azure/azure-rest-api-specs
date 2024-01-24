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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("latest")
@parentResource(NetworkConnection)
@Azure.ResourceManager.Private.armResourceInternal(
  HealthCheckStatusDetailsProperties
)
@includeInapplicableMetadataInPayload(false)
model HealthCheckStatusDetails extends ProxyResourceBase {
  @key("healthCheck")
  @segment("healthChecks")
  name: string;

  /**
   * Health check status details properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: HealthCheckStatusDetailsProperties;
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
