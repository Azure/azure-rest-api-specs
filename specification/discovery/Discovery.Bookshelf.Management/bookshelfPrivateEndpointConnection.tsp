import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./bookshelf.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Discovery;

/**
 * The Private Endpoint Connection resource for Bookshelf.
 */
@added(Versions.v2026_02_01_preview)
@parentResource(Bookshelf)
model BookshelfPrivateEndpointConnection
  is Azure.ResourceManager.ProxyResource<Azure.ResourceManager.CommonTypes.PrivateEndpointConnectionProperties> {
  ...PrivateEndpointConnectionParameter;
}

@added(Versions.v2026_02_01_preview)
@armResourceOperations
interface BookshelfPrivateEndpointConnections {
  /**
   * Gets the specified private endpoint connection associated with the bookshelf.
   */
  get is ArmResourceRead<BookshelfPrivateEndpointConnection>;

  /**
   * Approves or updates the specified private endpoint connection.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<BookshelfPrivateEndpointConnection>;

  /**
   * Deletes the specified private endpoint connection.
   */
  delete is ArmResourceDeleteWithoutOkAsync<BookshelfPrivateEndpointConnection>;

  /**
   * Lists all private endpoint connections for a bookshelf.
   */
  listByBookshelf is ArmResourceListByParent<BookshelfPrivateEndpointConnection>;
}

@@pattern(PrivateEndpointConnectionParameter.name, "^[a-z][a-zA-Z0-9]*");
@@minLength(PrivateEndpointConnectionParameter.name, 3);
@@maxLength(PrivateEndpointConnectionParameter.name, 63);
