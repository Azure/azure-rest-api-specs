import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateAccess.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Chaos;
/**
 * The private endpoint connection resource.
 */
@parentResource(PrivateAccess)
model PrivateEndpointConnection
  is Azure.ResourceManager.ProxyResource<PrivateEndpointConnectionProperties> {
  ...ResourceNameParameter<
    Resource = PrivateEndpointConnection,
    KeyName = "privateEndpointConnectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = "^[^<>%&:?#/\\\\]+$"
  >;
}

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Gets information about a private endpoint connection under a private access resource.
   */
  getAPrivateEndpointConnection is ArmResourceRead<PrivateEndpointConnection>;

  /**
   * Deletes a private endpoint connection under a private access resource.
   */
  deleteAPrivateEndpointConnection is ArmResourceDeleteWithoutOkAsync<PrivateEndpointConnection>;

  /**
   * List information about private endpoint connections under a private access resource
   */
  listPrivateEndpointConnections is ArmResourceListByParent<
    PrivateEndpointConnection,
    Response = PrivateEndpointConnectionListResult
  >;
}

@@doc(PrivateEndpointConnection.name,
  "The name of the private endpoint connection."
);
@@doc(PrivateEndpointConnection.properties, "Resource properties.");
