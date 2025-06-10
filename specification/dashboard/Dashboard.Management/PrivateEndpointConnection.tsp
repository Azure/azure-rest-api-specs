import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedGrafana.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Dashboard;
/**
 * The Private Endpoint Connection resource.
 */
@parentResource(ManagedGrafana)
model PrivateEndpointConnection
  is Azure.ResourceManager.ProxyResource<PrivateEndpointConnectionProperties> {
  ...ResourceNameParameter<
    Resource = PrivateEndpointConnection,
    KeyName = "privateEndpointConnectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Existing usage of legacy type"
@armResourceOperations
interface PrivateEndpointConnectionsOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /**
         * The workspace name of Azure Managed Grafana.
         */
        @path
        @segment("grafana")
        @pattern("^[a-zA-Z][a-z0-9A-Z-]{0,28}[a-z0-9A-Z]$")
        workspaceName: string,
      },
      {
        /**
         * The private endpoint connection name of Azure Managed Grafana.
         */
        @path
        @segment("privateEndpointConnections")
        privateEndpointConnectionName: string,
      },
      ErrorResponse
    > {}

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Get private endpoint connections.
   */
  get is ArmResourceRead<PrivateEndpointConnection>;

  /**
   * Manual approve private endpoint connection
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  approve is PrivateEndpointConnectionsOps.CreateOrUpdateAsync<
    PrivateEndpointConnection,
    Response = ArmResourceCreatedResponse<PrivateEndpointConnection> | ArmResourceCreatedResponse<
      Resource = PrivateEndpointConnection,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = PrivateEndpointConnection> &
        Azure.Core.Foundations.RetryAfterHeader
    >,
    OptionalRequestBody = true
  >;

  /**
   * Delete private endpoint connection
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    PrivateEndpointConnection,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Get private endpoint connection
   */
  list is ArmResourceListByParent<PrivateEndpointConnection>;
}

@@doc(PrivateEndpointConnection.name,
  "The private endpoint connection name of Azure Managed Grafana."
);
@@doc(PrivateEndpointConnection.properties, "Resource properties.");
@@doc(PrivateEndpointConnections.approve::parameters.resource, "");
