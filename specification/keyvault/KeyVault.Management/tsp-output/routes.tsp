import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.KeyVault;

interface VaultsOperations {
  /**
   * Gets information about the deleted vaults in a subscription.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.KeyVault/deletedVaults")
  @get
  listDeleted is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    DeletedVaultListResult
  >;
}

interface ManagedHsmsOperations {
  /**
   * The List operation gets information about the deleted managed HSMs associated with the subscription.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.KeyVault/deletedManagedHSMs")
  @get
  listDeleted is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    DeletedManagedHsmListResult
  >;
}
