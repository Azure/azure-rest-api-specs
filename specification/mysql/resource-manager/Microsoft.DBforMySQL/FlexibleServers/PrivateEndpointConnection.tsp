import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DBforMySQL;
/**
 * The private endpoint connection resource.
 */
@parentResource(Server)
model PrivateEndpointConnection
  is Azure.ResourceManager.CommonTypes.PrivateEndpointConnection {
  /** The name of the private endpoint connection. */
  @visibility(Lifecycle.Read)
  @path
  @segment("privateEndpointConnections")
  @key
  @pattern("^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*")
  privateEndpointConnectionName: string;
}

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Gets a private endpoint connection.
   */
  get is ArmResourceRead<PrivateEndpointConnection>;

  /**
   * Approve or reject a private endpoint connection with a given name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<PrivateEndpointConnection>;

  /**
   * Deletes a private endpoint connection with a given name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    PrivateEndpointConnection,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all private endpoint connections on a server.
   */
  #suppress "deprecated" "Fixme: Update justification, follow aka.ms/tsp/conversion-fix for details"
  listByServer is ArmResourceListByParent<PrivateEndpointConnection>;
}

@@doc(PrivateEndpointConnection.properties, "Resource properties.");
@@doc(PrivateEndpointConnections.createOrUpdate::parameters.resource, "");
