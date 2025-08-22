import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Cache;
/**
 * The Private Endpoint Connection resource.
 */
@parentResource(RedisResource)
model PrivateEndpointConnection is PrivateEndpointConnectionResource {
  /** The name of the private endpoint connection associated with the Azure resource */
  @visibility(Lifecycle.Read)
  @path
  @segment("privateEndpointConnections")
  @key
  privateEndpointConnectionName: string;
}

alias PrivateEndpointOperations = Azure.ResourceManager.PrivateEndpoints<PrivateEndpointConnection>;

@armResourceOperations
interface PrivateEndpointConnections {
  /**
   * Gets the specified private endpoint connection associated with the redis cache.
   */
  get is ArmResourceRead<PrivateEndpointConnection>;

  /**
   * Update the state of specified private endpoint connection associated with the redis cache.
   */
  put is ArmResourceCreateOrReplaceAsync<
    PrivateEndpointConnection,
    LroHeaders = ArmLroLocationHeader<FinalResult = PrivateEndpointConnection> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes the specified private endpoint connection associated with the redis cache.
   */
  delete is ArmResourceDeleteSync<PrivateEndpointConnection>;

  /**
   * List all the private endpoint connections associated with the redis cache.
   */
  list is ArmResourceListByParent<
    PrivateEndpointConnection,
    Response = ResourceListResult<PrivateEndpointConnection>
  >;
}

@@doc(PrivateEndpointConnection.properties, "Resource properties.");
@@doc(PrivateEndpointConnections.put::parameters.resource,
  "The private endpoint connection properties."
);
