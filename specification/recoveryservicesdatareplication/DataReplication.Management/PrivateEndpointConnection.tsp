import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VaultModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataReplication;
/**
 * Represents private endpoint connection.
 */
@parentResource(VaultModel)
model PrivateEndpointConnection
  is Azure.ResourceManager.ProxyResource<PrivateEndpointConnectionResponseProperties> {
  ...ResourceNameParameter<
    Resource = PrivateEndpointConnection,
    KeyName = "privateEndpointConnectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = "^[a-zA-Z0-9]*$"
  >;
}

#suppress "@azure-tools/typespec-azure-core/no-openapi"
@@OpenAPI.extension(PrivateEndpointConnections.update::parameters.resource,
  "x-ms-client-name",
  "body"
);
@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Gets the private endpoint connection details.
   */
  get is ArmResourceRead<PrivateEndpointConnection>;

  /**
   * Updated the private endpoint connection status (Approval/Rejected). This gets invoked by resource admin.
   */
  update is ArmResourceCreateOrReplaceSync<PrivateEndpointConnection>;

  /**
   * Deletes the private endpoint connection.
   */
  delete is ArmResourceDeleteWithoutOkAsync<PrivateEndpointConnection>;

  /**
   * Gets the all private endpoint connections configured on the vault.
   */
  list is ArmResourceListByParent<PrivateEndpointConnection>;
}

@@doc(PrivateEndpointConnection.name, "The private endpoint connection name.");
@@doc(PrivateEndpointConnections.update::parameters.resource,
  "Private endpoint connection update input."
);
