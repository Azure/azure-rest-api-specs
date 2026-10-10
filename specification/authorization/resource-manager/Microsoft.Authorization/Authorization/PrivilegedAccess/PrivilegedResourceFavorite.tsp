import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;

namespace Microsoft.PrivilegedAccess;

/**
 * A per-user resource favorite. Each user's favorites are private to them:
 * two different users issuing PUT against the same `{favoriteId}` create two
 * independent favorite records.
 *
 * Operations (defined in routes.tsp):
 *   - LIST   `GET    /providers/Microsoft.Authorization/privilegedResourceFavorites`
 *   - GET    `GET    /providers/Microsoft.Authorization/privilegedResourceFavorites/{favoriteId}`
 *   - PUT    `PUT    /providers/Microsoft.Authorization/privilegedResourceFavorites/{favoriteId}` (idempotent)
 *   - DELETE `DELETE /providers/Microsoft.Authorization/privilegedResourceFavorites/{favoriteId}` (idempotent)
 *
 * `{favoriteId}` is deterministically derived from the favorited Azure resource
 * path: `favoriteId = base64url(lowercased Azure resource ID)`. Because the
 * derivation is deterministic, the client may compute the id locally and
 * issue the PUT/GET/DELETE without an additional round-trip; the service
 * validates the derivation on PUT.
 *
 * Favorites are not scoped to any subscription or resource group — they belong
 * to the calling user.
 */
@tenantResource
model PrivilegedResourceFavorite
  is Azure.ResourceManager.ProxyResource<PrivilegedResourceFavoriteProperties> {
  ...ResourceNameParameter<
    Resource = PrivilegedResourceFavorite,
    KeyName = "favoriteId",
    SegmentName = "privilegedResourceFavorites",
    NamePattern = "^[A-Za-z0-9_-]{1,2048}$"
  >;
}
