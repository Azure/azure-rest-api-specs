import "@azure-tools/typespec-azure-core";
import "@typespec/versioning";

using TypeSpec.Versioning;

namespace Playwright;

@doc("Azure Key Vault secret references used for authentication.")
@added(Versions.v2026_11_01_preview)
model Credentials {
  @doc("The Azure Key Vault secret URI for the authentication username.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  usernameSecretUri: url;

  @doc("The Azure Key Vault secret URI for the authentication password.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  passwordSecretUri: url;
}
