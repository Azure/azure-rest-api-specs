import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ApplicationGateway.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Private Endpoint connection on an application gateway.
 */
@parentResource(ApplicationGateway)
model ApplicationGatewayPrivateEndpointConnection
  is Azure.ResourceManager.ProxyResource<ApplicationGatewayPrivateEndpointConnectionProperties> {
  ...ResourceNameParameter<
    Resource = ApplicationGatewayPrivateEndpointConnection,
    KeyName = "connectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = ""
  >;

  /** A unique read-only string that changes whenever the resource is updated. */
  @visibility(Lifecycle.Read)
  etag?: string;
}

@armResourceOperations
interface ApplicationGatewayPrivateEndpointConnections {
  /**
   * Gets the specified private endpoint connection on application gateway.
   */
  get is ArmResourceRead<
    ApplicationGatewayPrivateEndpointConnection,
    Error = CloudError
  >;

  /**
   * Updates the specified private endpoint connection on application gateway.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  update is ArmResourceCreateOrReplaceAsync<
    ApplicationGatewayPrivateEndpointConnection,
    Response = ArmResourceUpdatedResponse<ApplicationGatewayPrivateEndpointConnection> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader> &
      Azure.Core.Foundations.RetryAfterHeader),
    Error = CloudError
  >;

  /**
   * Deletes the specified private endpoint connection on application gateway.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    ApplicationGatewayPrivateEndpointConnection,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists all private endpoint connections on an application gateway.
   */
  list is ArmResourceListByParent<
    ApplicationGatewayPrivateEndpointConnection,
    Error = CloudError
  >;
}

@@doc(ApplicationGatewayPrivateEndpointConnection.name,
  "Name of the private endpoint connection on an application gateway."
);
@@doc(ApplicationGatewayPrivateEndpointConnection.properties,
  "Properties of the application gateway private endpoint connection."
);
@@doc(ApplicationGatewayPrivateEndpointConnections.update::parameters.resource,
  "Parameters supplied to update application gateway private endpoint connection operation."
);
