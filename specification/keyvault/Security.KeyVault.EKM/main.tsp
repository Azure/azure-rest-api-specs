import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;

/**
 * The key Vault client performs cryptographic key operations and vault operations against the Key Vault service.
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
    vaultBaseUrl: url,
  }
)
namespace KeyVault;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2026-01-01-preview API version.
   */
  v2026_01_01_preview: "2026-01-01-preview",
}
