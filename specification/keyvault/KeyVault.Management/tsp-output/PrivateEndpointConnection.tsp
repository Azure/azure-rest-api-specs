import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Vault.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.KeyVault;
/**
 * Private endpoint connection resource.
 */
@parentResource(Vault)
model PrivateEndpointConnection
  is ProxyResource<PrivateEndpointConnectionProperties> {
  /**
   * Name of the private endpoint connection associated with the key vault.
   */
  @path
  @key("privateEndpointConnectionName")
  @segment("privateEndpointConnections")
  name: string;

  /**
   * Modified whenever there is a change in the state of private endpoint connection.
   */
  etag?: string;
}

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Gets the specified private endpoint connection associated with the key vault.
   */
  get (
    ...ResourceInstanceParameters<PrivateEndpointConnection>
  ): ArmNoContentResponse<"Request successful. Resource does not exist."> //204 response
  | ArmResponse<PrivateEndpointConnection>
  | ErrorResponse;

    /**
   * Updates the specified private endpoint connection associated with the key vault.
   */
    @armResourceCreateOrUpdate(PrivateEndpointConnection)
    @put
    put(
      ...ResourceInstanceParameters<PrivateEndpointConnection,BaseParameters<PrivateEndpointConnectionParameter>>,
      @doc("The intended state of private endpoint connection.")
      @body
      resource: PrivateEndpointConnection
    ): ArmOkResponse<PrivateEndpointConnection>
    | ErrorResponse; 

  /**
   * Deletes the specified private endpoint connection associated with the key vault.
   */
  delete is ArmResourceDeleteAsync<PrivateEndpointConnection>;

  /**
   * The List operation gets information about the private endpoint connections associated with the vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateEndpointConnections_ListByResource")
  listByResource is ArmResourceListByParent<PrivateEndpointConnection>;
}

@@projectedName(PrivateEndpointConnections.put::parameters.resource,
  "json",
  "properties"
);
@@extension(PrivateEndpointConnections.put::parameters.resource,
  "x-ms-client-name",
  "properties"
);
@@doc(PrivateEndpointConnections.put::parameters.resource,
  "The intended state of private endpoint connection."
);
