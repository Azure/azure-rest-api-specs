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
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface ApplicationGatewayPrivateEndpointConnections {
  /**
   * Gets the specified private endpoint connection on application gateway.
   */
  get is ArmResourceRead<ApplicationGatewayPrivateEndpointConnection, Error = CloudError>;

  /**
   * Updates the specified private endpoint connection on application gateway.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  update is ArmResourceCreateOrReplaceAsync<ApplicationGatewayPrivateEndpointConnection,
    Response = ArmResourceUpdatedResponse<ApplicationGatewayPrivateEndpointConnection> | ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader>,
    Error = CloudError
  >;

  /**
   * Deletes the specified private endpoint connection on application gateway.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<ApplicationGatewayPrivateEndpointConnection,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,  Error = CloudError>;

  /**
   * Lists all private endpoint connections on an application gateway.
   */
  list is ArmResourceListByParent<ApplicationGatewayPrivateEndpointConnection, Error = CloudError>;
}

@@doc(ApplicationGatewayPrivateEndpointConnection.name,
  "The name of the application gateway private endpoint connection."
);
@@doc(ApplicationGatewayPrivateEndpointConnection.properties,
  "Properties of the application gateway private endpoint connection."
);
@@doc(ApplicationGatewayPrivateEndpointConnections.update::parameters.resource,
  "Parameters supplied to update application gateway private endpoint connection operation."
);
