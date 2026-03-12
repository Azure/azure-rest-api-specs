import "@typespec/http";
import "@typespec/versioning";

// Import common definitions
import "../common/common.tsp";

import "./models.tsp";
import "./routes.tsp";

// Import client customizations
using TypeSpec.Http;
using TypeSpec.Versioning;

/**
 * The Azure Key Vault Administration service client performs administrative operations
 * including RBAC, BackupRestore, and settings management
 * against the Azure Key Vault service.
 */
@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
      scopes: ["https://vault.azure.net/.default"],
    }
  ]>
)
@service(#{ title: "KeyVaultClient" })
@versioned(Versions)
@server(
  "{vaultBaseUrl}",
  "The key vault client performs cryptographic key operations and vault operations against the Key Vault service.",
  {
    /**
     * The base URL of the Key Vault instance (e.g. https://myvault.vault.azure.net/)
     */
    vaultBaseUrl: url,
  }
)
namespace KeyVault;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 7.5 API version.
   */
  `v7.5`: "7.5",

  /**
   * The 7.6-preview.2 API version.
   */
  `v7.6_preview.2`: "7.6-preview.2",

  /**
   * The 7.6 API version.
   */
  `v7.6`: "7.6",

  /**
   * The 2025-06-01-preview API version.
   */
  v2025_06_01_preview: "2025-06-01-preview",

  /**
   * The 2025-07-01 API version.
   */
  v2025_07_01: "2025-07-01",
}
