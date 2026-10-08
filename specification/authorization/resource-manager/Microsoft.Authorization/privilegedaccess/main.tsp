import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./PrivilegedResourceFavorite.tsp";
import "./routes.tsp";
import "./client.tsp";

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
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Migration prototype only: the published PrivilegedAccess contract does not define Microsoft.Authorization/operations at 2026-06-01-preview. The shared Authorization service currently emits that RP-level endpoint at 2021-12-01-preview. Production cutover is blocked until the RP owner confirms actual 2026-06-01-preview endpoint support; this prototype must not invent that wire contract."
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
  @Azure.Core.previewVersion
  v2026_06_01_preview: "2026-06-01-preview",
}
