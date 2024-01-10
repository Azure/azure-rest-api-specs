import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DataReplication;
@doc("Vault model.")
model VaultModel is TrackedResource<VaultModelProperties> {
  @doc("The vault name.")
  @pattern("^[a-zA-Z0-9]*$")
  @key("vaultName")
  @segment("replicationVaults")
  name: string;
}

@armResourceOperations
@projectedName("client", "Vault")
interface VaultModels_Vault {
  @doc("Gets the details of the vault.")
  get is ArmResourceRead<VaultModel>;

  @doc("Creates the vault.")
  create is ArmResourceCreateOrUpdateAsync<VaultModel>;

  @doc("Performs update on the vault.")
  update is ArmCustomPatchAsync<VaultModel, VaultModelUpdate>;

  @doc("Removes the vault.")
  delete is ArmResourceDeleteWithoutOkAsync<VaultModel>;

  @doc("Gets the list of vaults in the given subscription and resource group.")
  list is ArmResourceListByParent<
    VaultModel,
    {
      ...BaseParameters<VaultModel>;

      @doc("Continuation token from the previous call.")
      @query("continuationToken")
      continuationToken?: string;
    }
  >;

  @doc("Gets the list of vaults in the given subscription.")
  listBySubscription is ArmListBySubscription<VaultModel>;
}
