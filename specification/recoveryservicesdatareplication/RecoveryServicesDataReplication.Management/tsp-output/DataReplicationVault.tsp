import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.RecoveryServicesDataReplication;
@doc("Vault model.")
model DataReplicationVault is TrackedResource<VaultModelProperties> {
  @doc("The vault name.")
  @pattern("^[a-zA-Z0-9]*$")
  @path
  @key("vaultName")
  @segment("replicationVaults")
  name: string;
}

@armResourceOperations
interface DataReplicationVaults {
  @doc("Gets the details of the vault.")
  get is ArmResourceRead<DataReplicationVault>;
  @doc("Creates the vault.")
  create is ArmResourceCreateOrUpdateAsync<DataReplicationVault>;
  @doc("Performs update on the vault.")
  update is ArmResourcePatchAsync<DataReplicationVault, VaultModelProperties>;
  @doc("Removes the vault.")
  delete is ArmResourceDeleteWithoutOkAsync<DataReplicationVault>;
  @doc("Gets the list of vaults in the given subscription and resource group.")
  list is ArmResourceListByParent<
    DataReplicationVault,
    {
      ...BaseParameters<DataReplicationVault>;

      @doc("Continuation token from the previous call.")
      @query("continuationToken")
      continuationToken?: string;
    }
  >;
  @doc("Gets the list of vaults in the given subscription.")
  listBySubscription is ArmListBySubscription<DataReplicationVault>;
}
