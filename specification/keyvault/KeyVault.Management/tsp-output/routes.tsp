import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Azure.ResourceManager.KeyVault;

interface VaultsOperations {
  @doc("Gets information about the deleted vaults in a subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.KeyVault/deletedVaults")
  @get
  ListDeleted is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    DeletedVaultListResult
  >;
}

interface ManagedHsmsOperations {
  @doc("The List operation gets information about the deleted managed HSMs associated with the subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.KeyVault/deletedManagedHSMs")
  @get
  ListDeleted is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    DeletedManagedHsmListResult
  >;
}
