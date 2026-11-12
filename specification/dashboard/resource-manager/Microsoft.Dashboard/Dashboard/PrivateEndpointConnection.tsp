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
// Keep the custom resource instead of PrivateEndpointConnectionResource to preserve
// writable groupIds, which is not included in the common-types v3 template.
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
  approve is Azure.ResourceManager.Legacy.CreateOrReplaceAsync<
    PrivateEndpointConnection,
    Response = ArmResourceCreatedResponse<
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

@@doc(
  PrivateEndpointConnection.name,
  "The private endpoint connection name of Azure Managed Grafana."
);
@@doc(PrivateEndpointConnection.properties, "Resource properties.");
@@doc(PrivateEndpointConnections.approve::parameters.resource, "");
