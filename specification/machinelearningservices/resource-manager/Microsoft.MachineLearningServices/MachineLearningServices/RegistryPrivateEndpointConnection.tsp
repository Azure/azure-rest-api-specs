import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;

/**
 * PrivateEndpointConnections ARM operations for Registry.
 */
@armResourceOperations
interface RegistryPrivateEndpointConnections {
  /**
   * Get a private endpoint connection.
   */
  @summary("Get a private endpoint connection")
  get is ArmChildResourceRead<
    RegistryPrivateEndpointConnection,
    ParentResource = Registry
  >;

  /**
   * Create or update a private endpoint connection.
   */
  @summary("Create or update a private endpoint connection")
  createOrUpdate is ArmChildResourceCreateOrReplaceAsync<
    RegistryPrivateEndpointConnection,
    ParentResource = Registry
  >;

  /**
   * Delete a private endpoint connection.
   */
  @summary("Delete a private endpoint connection")
  delete is ArmChildResourceDeleteWithoutOkAsync<
    RegistryPrivateEndpointConnection,
    ParentResource = Registry
  >;

  /**
   * List private endpoint connections for a registry.
   */
  @summary("List private endpoint connections for a registry")
  listByRegistry is ArmChildResourceListByParent<
    RegistryPrivateEndpointConnection,
    ParentResource = Registry
  >;
}
