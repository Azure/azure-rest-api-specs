import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using Azure.Core;
using TypeSpec.Http;
using Azure.Core.Traits;

namespace Products;

@doc("Marketplace Catalog API")
model MarketParameter {
  @query
  @doc("Product market value  (the response will include only products that can be sold in the specified market)\nPossible values can be found at https://docs.microsoft.com/en-us/azure/marketplace/marketplace-geo-availability-currencies. Example: 'US'")
  market: string;
}

alias ProductsListingTraits = QueryParametersTrait<SelectQueryParameter &
  FilterQueryParameter &
  ExpandQueryParameter &
  MarketParameter>;

alias ListingOperation = ResourceOperations<ProductsListingTraits>;

interface ProductOperations {
  @doc("Retrieves a list of products available in the marketplace catalog.")
  list is ListingOperation.ResourceList<ProductSummary>;
}
