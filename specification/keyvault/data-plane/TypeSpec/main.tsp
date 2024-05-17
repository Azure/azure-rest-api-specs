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
 * The key vault client performs cryptographic key operations and vault operations
 * against the Key Vault service.
 */
@service({
  title: "KeyVaultClient",
})
@versioned(Versions)
@server(
  "{vaultBaseUrl}",
  "The key vault client performs cryptographic key operations and vault operations against the Key Vault service.",
  {
    vaultBaseUrl: url,
  }
)
namespace KeyVaultClient;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 7.6-preview.1 API version.
   */
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  `v7.6_preview.1`: "7.6-preview.1",
}
