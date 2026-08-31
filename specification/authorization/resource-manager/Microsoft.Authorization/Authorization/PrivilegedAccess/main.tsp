import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./PrivilegedResourceFavorite.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using TypeSpec.Versioning;

/**
 * Privileged Access — end-user API surface for Privileged Access Management.
 *
 * Provides two resource types under `Microsoft.Authorization`:
 *   1. `privilegedResources` (GET-only collection) — a unified view of the
 *      Azure resources you have privileged access to.
 *   2. `privilegedResourceFavorites` (PUT/GET/DELETE) — your personal resource
 *      favorites.
 *
 * Both resource types are tenant-scoped: they are addressed at the tenant, not
 * under a subscription or resource group.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "The Microsoft.Authorization/operations listing is owned by the AccessReview subproject of the shared Authorization service; this subproject must not duplicate it."
@armProviderNamespace("Microsoft.Authorization")
@service(#{ title: "AuthorizationManagementClient" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
namespace Microsoft.PrivilegedAccess;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2026-06-01-preview API version.
   */
  v2026_06_01_preview: "2026-06-01-preview",
}
