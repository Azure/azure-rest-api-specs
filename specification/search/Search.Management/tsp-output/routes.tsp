import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Search;

interface UsagesOperations {
  /**
   * Gets a list of all Search quota usages in the given subscription.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Search/locations/{location}/usages")
  @get
  listBySubscription is Azure.Core.Foundations.Operation<
    {
      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      @header
      clientRequestId?: string;

      /**
       * The unique location name for a Microsoft Azure geographic region.
       */
      @path
      location: string;

      /**
       * The unique identifier for a Microsoft Azure subscription. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      subscriptionId: string;
    },
    QuotaUsagesListResult
  >;
}

/**
 * Gets the quota usage for a search sku in the given subscription.
 */
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Search/locations/{location}/usages/{skuName}")
@get
op usageBySubscriptionSku is Azure.Core.Foundations.Operation<
  {
    /**
     * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
     */
    @header
    clientRequestId?: string;

    /**
     * The unique location name for a Microsoft Azure geographic region.
     */
    @path
    location: string;

    /**
     * The unique identifier for a Microsoft Azure subscription. You can obtain this value from the Azure Resource Manager API or the portal.
     */
    @path
    subscriptionId: string;

    /**
     * The unique search service sku name supported by Azure Cognitive Search.
     */
    @path
    skuName: string;
  },
  QuotaUsageResult
>;
