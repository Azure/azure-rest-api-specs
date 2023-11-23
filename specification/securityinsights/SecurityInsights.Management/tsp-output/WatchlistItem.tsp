import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Watchlist.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.SecurityInsights;
@doc("Represents a Watchlist item in Azure Security Insights.")
@parentResource(Watchlist)
model WatchlistItem is ProxyResource<WatchlistItemProperties> {
  @doc("Watchlist Item Id (GUID)")
  @path
  @key("watchlistItemId")
  @segment("watchlistItems")
  name: string;
}

@armResourceOperations
interface WatchlistItems {
  @doc("Gets a watchlist, without its watchlist items.")
  get is ArmResourceRead<WatchlistItem>;
  @doc("Creates or updates a watchlist item.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<WatchlistItem>;
  @doc("Delete a watchlist item.")
  delete is ArmResourceDeleteSync<WatchlistItem>;
  @doc("Gets all watchlist Items.")
  list is ArmResourceListByParent<
    WatchlistItem,
    {
      ...BaseParameters<WatchlistItem>;

      @doc("Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls. Optional.")
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
}
