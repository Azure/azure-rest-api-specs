import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.KeyVault;
@doc("Deleted vault information with extended details.")
@locationResource
model DeletedVault is ProxyResource<DeletedVaultProperties> {
  @doc("The name of the vault.")
  @key("vaultName")
  @segment("deletedVaults")
  name: string;
}

@armResourceOperations
interface Vaults {
  @doc("Gets the deleted Azure key vault.")
  getDeleted is ArmResourceRead<DeletedVault>;
  @doc("Permanently deletes the specified vault. aka Purges the deleted Azure key vault.")
  purgeDeleted is ArmResourceActionAsync<DeletedVault, void, void>;
}
