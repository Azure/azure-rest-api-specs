import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.SecurityInsights;
@doc("Represents a Watchlist in Azure Security Insights.")
model Watchlist is ProxyResource<WatchlistProperties> {
  @doc("Watchlist Alias")
  @path
  @key("watchlistAlias")
  @segment("watchlists")
  name: string;
}

@armResourceOperations
interface Watchlists {
  @doc("Gets a watchlist, without its watchlist items.")
  get is ArmResourceRead<Watchlist>;
  @doc("Create or update a Watchlist and its Watchlist Items (bulk creation, e.g. through text/csv content type). To create a Watchlist and its Items, we should call this endpoint with either rawContent or a valid SAR URI and contentType properties. The rawContent is mainly used for small watchlist (content size below 3.8 MB). The SAS URI enables the creation of large watchlist, where the content size can go up to 500 MB. The status of processing such large file can be polled through the URL returned in Azure-AsyncOperation header.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Watchlist>;
  @doc("Delete a watchlist.")
  delete is ArmResourceDeleteSync<Watchlist>;
  @doc("Gets all watchlists, without watchlist items.")
  list is ArmResourceListByParent<
    Watchlist,
    {
      ...BaseParameters<Watchlist>;

      @doc("Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls. Optional.")
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
}
