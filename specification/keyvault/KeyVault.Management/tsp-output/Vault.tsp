import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.KeyVault;
@doc("Resource information with extended details.")
model Vault is TrackedResource<VaultProperties> {
  @doc("The name of the vault.")
  @path
  @key("vaultName")
  @segment("vaults")
  name: string;
}

@armResourceOperations
interface Vaults {
  @doc("Gets the specified Azure key vault.")
  get is ArmResourceRead<Vault>;
  @doc("Create or update a key vault in the specified subscription.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Vault>;
  @doc("Update a key vault in the specified subscription.")
  update is ArmResourcePatchSync<Vault, VaultProperties>;
  @doc("Deletes the specified Azure key vault.")
  delete is ArmResourceDeleteSync<Vault>;
  @doc("The List operation gets information about the vaults associated with the subscription and within the specified resource group.")
  listByResourceGroup is ArmResourceListByParent<
    Vault,
    {
      ...BaseParameters<Vault>;

      @doc("Maximum number of results to return.")
      @query("$top")
      $top?: int32;
    }
  >;
  @doc("The List operation gets information about the vaults associated with the subscription.")
  listBySubscription is ArmListBySubscription<Vault>;
}

@armResourceOperations
interface PrivateLinkResources {
  @doc("Gets the private link resources supported for the key vault.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.KeyVault/vaults/{vaultName}/privateLinkResources")
  @get
  ListByVault is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Name of the resource group that contains the key vault.")
      @path
      resourceGroupName: string;

      @doc("The name of the key vault.")
      @pattern("^[a-zA-Z0-9-]{3,24}$")
      @path
      vaultName: string;
    },
    PrivateLinkResourceListResult
  >;
}
