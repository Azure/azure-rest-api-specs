import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityInsights;
/**
 * Represents a Watchlist in Azure Security Insights.
 */
model Watchlist is Azure.ResourceManager.ProxyResource<WatchlistProperties> {
  ...ResourceNameParameter<
    Resource = Watchlist,
    KeyName = "watchlistAlias",
    SegmentName = "watchlists",
    NamePattern = ""
  >;

  /**
   * Etag of the azure resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

alias WatchlistWorkspaceExternalResource = Extension.ExternalResource<
  "Microsoft.OperationalInsights",
  "workspaces",
  "{workspaceName}"
>;

@armResourceOperations
interface Watchlists {
  /**
   * Get a watchlist, without its watchlist items.
   */
  get is ArmResourceRead<Watchlist>;

  /**
   * Create or update a Watchlist and its Watchlist Items (bulk creation, e.g. through text/csv content type). To create a Watchlist and its Items, we should call this endpoint with rawContent and contentType properties.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Watchlist>;

  /**
   * Delete a watchlist.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Watchlist,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Get all watchlists, without watchlist items.
   */
  list is ArmResourceListByParent<
    Watchlist,
    Parameters = {
      /**
       * Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls. Optional.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = ArmResponse<WatchlistList>
  >;
}

@@doc(Watchlist.name, "The watchlist alias");
@@doc(Watchlist.properties, "Watchlist properties");
@@doc(Watchlists.createOrUpdate::parameters.resource, "The watchlist");
