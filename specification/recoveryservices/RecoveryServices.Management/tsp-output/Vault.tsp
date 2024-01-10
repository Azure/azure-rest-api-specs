import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.RecoveryServices;
@doc("Resource information, as returned by the resource provider.")
model Vault is TrackedResource<VaultProperties> {
  @doc("The name of the recovery services vault.")
  @key("vaultName")
  @segment("vaults")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface Vaults {
  @doc("Get the Vault details.")
  get is ArmResourceRead<Vault>;

  @doc("Creates or updates a Recovery Services vault.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Vault>;

  @doc("Updates the vault.")
  update is ArmCustomPatchAsync<Vault, PatchVault>;

  @doc("Deletes a vault.")
  delete is ArmResourceDeleteSync<Vault>;

  @doc("Retrieve a list of Vaults.")
  listByResourceGroup is ArmResourceListByParent<Vault>;

  @doc("Fetches all the resources of the specified type in the subscription.")
  listBySubscriptionId is ArmListBySubscription<Vault>;
}

@armResourceOperations
@projectedName("client", "ReplicationUsages")
interface Vaults_ReplicationUsages {
  @doc("Fetches the replication usages of the vault.")
  // FIXME: ReplicationUsages_List could not be converted to a resource operation
  @route("/Subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/replicationUsages")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the recovery services vault.")
      @path
      vaultName: string;
    },
    ReplicationUsageList
  >;
}

@armResourceOperations
@projectedName("client", "Usages")
interface Vaults_Usages {
  @doc("Fetches the usages of the vault.")
  // FIXME: Usages_ListByVaults could not be converted to a resource operation
  @route("/Subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/usages")
  @get
  ListByVaults is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the recovery services vault.")
      @path
      vaultName: string;
    },
    VaultUsageList
  >;
}
