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
 * A private link resource for Bookshelf.
 */
@added(Versions.v2026_02_01_preview)
@parentResource(Bookshelf)
model BookshelfPrivateLinkResource
  is Azure.ResourceManager.ProxyResource<Azure.ResourceManager.CommonTypes.PrivateLinkResourceProperties> {
  ...PrivateLinkResourceParameter;
}

@added(Versions.v2026_02_01_preview)
@armResourceOperations
interface BookshelfPrivateLinkResources {
  /**
   * Gets the specified private link resource for the bookshelf.
   */
  get is ArmResourceRead<BookshelfPrivateLinkResource>;

  /**
   * Lists all private link resources for the bookshelf.
   */
  listByBookshelf is ArmResourceListByParent<BookshelfPrivateLinkResource>;
}

@@pattern(PrivateLinkResourceParameter.name, "^[a-z][a-zA-Z0-9]*");
@@minLength(PrivateLinkResourceParameter.name, 3);
@@maxLength(PrivateLinkResourceParameter.name, 63);
