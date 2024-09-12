import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DiskAccess.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Compute;
/**
 * The Private Endpoint Connection resource.
 */
@parentResource(DiskAccess)
model PrivateEndpointConnection
  is Azure.ResourceManager.ProxyResource<PrivateEndpointConnectionProperties> {
  ...ResourceNameParameter<
    Resource = PrivateEndpointConnection,
    KeyName = "privateEndpointConnectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = ""
  >;

  /**
   * private endpoint connection Id
   */
  @visibility("read")
  id?: string;

  /**
   * private endpoint connection type
   */
  @visibility("read")
  type?: string;
}

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Gets information about a private endpoint connection under a disk access resource.
   */
  getAPrivateEndpointConnection is ArmResourceRead<PrivateEndpointConnection>;

  /**
   * Approve or reject a private endpoint connection under disk access resource, this can't be used to create a new private endpoint connection.
   */
  updateAPrivateEndpointConnection is ArmResourceCreateOrReplaceAsync<PrivateEndpointConnection>;

  /**
   * Deletes a private endpoint connection under a disk access resource.
   */
  deleteAPrivateEndpointConnection is ArmResourceDeleteAsync<PrivateEndpointConnection>;

  /**
   * List information about private endpoint connections under a disk access resource
   */
  listPrivateEndpointConnections is ArmResourceListByParent<PrivateEndpointConnection>;
}

@@doc(PrivateEndpointConnection.name,
  "The name of the private endpoint connection."
);
@@doc(PrivateEndpointConnection.properties, "Resource properties.");
@@doc(PrivateEndpointConnections.updateAPrivateEndpointConnection::parameters.resource,
  "private endpoint connection object supplied in the body of the Put private endpoint connection operation."
);
