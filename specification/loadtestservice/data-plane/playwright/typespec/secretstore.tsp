import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./routes.tsp";
import "./identity.tsp";
import "./systemdata.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Playwright;

@doc("A store of Key Vault secret references grouped by domain.")
@added(Versions.v2026_12_01_preview)
@resource("secret-stores")
model SecretStore {
  @doc("The secret store ID in GUID format.")
  @key("secretStoreId")
  @visibility(Lifecycle.Read)
  id: Azure.Core.uuid;

  @minLength(3)
  @maxLength(24)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{1,22}[a-zA-Z0-9]$")
  @doc("The secret store name.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  name: string;

  @doc("A description of the purpose of the secret store.")
  @maxLength(200)
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  description?: string;

  @doc("Secret configurations keyed by domain.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  domainSecrets: Record<SecretConfiguration>;

  @doc("The managed identity used to access the Key Vault secrets referenced by this secret store.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  keyVaultReferenceIdentity: ManagedIdentity;

  @doc("The read-only creation and modification metadata.")
  @visibility(Lifecycle.Read)
  systemData: SystemData;
}

@doc("Key Vault secret references for a domain.")
@added(Versions.v2026_12_01_preview)
model SecretConfiguration {
  @doc("Secret aliases mapped to Key Vault secret URLs, not secret values. If version is not specified, the latest version is used.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  secrets: Record<url>;
}

@doc("Operations for managing secret stores at the service endpoint.")
@added(Versions.v2026_12_01_preview)
interface SecretStores {
  @doc("Creates or updates a secret store with the specified ID. Omitted properties remain unchanged on update.")
  createOrUpdate is Operations.ResourceCreateOrUpdate<SecretStore>;

  @doc("Gets the secret store with the specified ID.")
  get is Operations.ResourceRead<SecretStore>;

  @doc("Lists secret stores, using nextLink to retrieve additional pages.")
  list is Operations.ResourceList<SecretStore>;

  @doc("Deletes the secret store with the specified ID.")
  delete is Operations.ResourceDelete<SecretStore>;
}
