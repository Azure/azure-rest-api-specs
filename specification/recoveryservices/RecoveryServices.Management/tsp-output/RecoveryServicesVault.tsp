import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.RecoveryServices;
@doc("Resource information, as returned by the resource provider.")
model RecoveryServicesVault is TrackedResource<VaultProperties> {
  @doc("The name of the recovery services vault.")
  @path
  @key("vaultName")
  @segment("vaults")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface RecoveryServicesVaults {
  @doc("Get the Vault details.")
  get is ArmResourceRead<RecoveryServicesVault>;
  @doc("Creates or updates a Recovery Services vault.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<RecoveryServicesVault>;
  @doc("Updates the vault.")
  update is ArmResourcePatchAsync<RecoveryServicesVault, VaultProperties>;
  @doc("Deletes a vault.")
  delete is ArmResourceDeleteSync<RecoveryServicesVault>;
  @doc("Retrieve a list of Vaults.")
  listByResourceGroup is ArmResourceListByParent<RecoveryServicesVault>;
  @doc("Fetches all the resources of the specified type in the subscription.")
  listBySubscriptionId is ArmListBySubscription<RecoveryServicesVault>;
  @doc("Fetches the replication usages of the vault.")
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

  @doc("Fetches the usages of the vault.")
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
