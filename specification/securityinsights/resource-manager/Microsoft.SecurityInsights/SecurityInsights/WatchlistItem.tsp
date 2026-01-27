import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Watchlist.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.SecurityInsights;
/**
 * Represents a Watchlist Item in Azure Security Insights.
 */
@parentResource(Watchlist)
model WatchlistItem
  is Azure.ResourceManager.ProxyResource<WatchlistItemProperties> {
  ...ResourceNameParameter<
    Resource = WatchlistItem,
    KeyName = "watchlistItemId",
    SegmentName = "watchlistItems",
    NamePattern = ""
  >;

  /**
   * Etag of the azure resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

@armResourceOperations
interface WatchlistItems {
  /**
   * Get a watchlist item.
   */
  get is Extension.Read<OperationalInsights, WatchlistItem, Error = CloudError>;

  /**
   * Create or update a watchlist item.
   */
  createOrUpdate is Extension.CreateOrReplaceSync<
    OperationalInsights,
    WatchlistItem,
    Error = CloudError
  >;

  /**
   * Delete a watchlist item.
   */
  delete is Extension.DeleteSync<
    OperationalInsights,
    WatchlistItem,
    Error = CloudError
  >;

  /**
   * Get all watchlist Items.
   */
  list is Extension.ListByTarget<
    OperationalInsights,
    WatchlistItem,
    Parameters = {
      /**
       * Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls. Optional.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = ArmResponse<WatchlistItemList>,
    Error = CloudError
  >;
}

@@doc(WatchlistItem.name, "The watchlist item id (GUID)");
@@doc(WatchlistItem.properties, "Watchlist Item properties");
@@doc(WatchlistItems.createOrUpdate::parameters.resource, "The watchlist item");
