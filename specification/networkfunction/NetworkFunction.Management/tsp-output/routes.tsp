import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.NetworkFunction;

interface AzureTrafficCollectorsBySubscriptionOperations {
  /**
   * Return list of Azure Traffic Collectors in a subscription
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.NetworkFunction/azureTrafficCollectors")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * Azure Subscription ID.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<AzureTrafficCollector>
  >;
}
