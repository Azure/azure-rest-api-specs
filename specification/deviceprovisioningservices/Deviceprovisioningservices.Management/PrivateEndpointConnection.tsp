import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Devices;
/**
 * The private endpoint connection of a provisioning service
 */
model PrivateEndpointConnection
  is Azure.ResourceManager.ProxyResource<
    PrivateEndpointConnectionProperties,
    false
  > {
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
   * Get private endpoint connection properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IotDpsResource_GetPrivateEndpointConnection")
  getPrivateEndpointConnection is ArmResourceRead<PrivateEndpointConnection>;

  /**
   * Create or update the status of a private endpoint connection with the specified name
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IotDpsResource_CreateOrUpdatePrivateEndpointConnection")
  createOrUpdatePrivateEndpointConnection is ArmResourceCreateOrReplaceAsync<
    PrivateEndpointConnection,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete private endpoint connection with the specified name
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("IotDpsResource_DeletePrivateEndpointConnection")
  deletePrivateEndpointConnection is ArmResourceDeleteWithoutOkAsync<
    PrivateEndpointConnection,
    Response = ArmResponse<PrivateEndpointConnection> | (ArmDeleteAcceptedLroResponse & {
      @bodyRoot
      _: PrivateEndpointConnection;
    }) | ArmDeletedNoContentResponse
  >;

  /**
   * List private endpoint connection properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IotDpsResource_ListPrivateEndpointConnections")
  listPrivateEndpointConnections is ArmResourceListByParent<
    PrivateEndpointConnection,
    Response = ArmResponse<PrivateEndpointConnection[]>
  >;
}

@@doc(PrivateEndpointConnection.name,
  "The name of the private endpoint connection"
);
@@doc(PrivateEndpointConnection.properties,
  "The properties of a private endpoint connection"
);
@@doc(PrivateEndpointConnections.createOrUpdatePrivateEndpointConnection::parameters.resource,
  "The private endpoint connection with updated properties"
);
