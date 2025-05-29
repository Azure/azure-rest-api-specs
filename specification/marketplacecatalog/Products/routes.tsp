import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using Azure.Core;
using Azure.Core.Traits;

namespace Products;

alias ProductsListingTraits = QueryParametersTrait<StorefrontParameter &
  LanguageParameter &
  LocationsParameter &
  MarketParameter &
  HideKeysParameter &
  SelectQueryParameter &
  FilterParameter &
  ExpandQueryParameter &
  OrderByQueryParameter>;

alias ProductsListingOperation = ResourceOperations<ProductsListingTraits>;

interface ProductOperations {
  @doc("Retrieves a list of products available in the marketplace catalog.")
  list is ProductsListingOperation.ResourceList<ProductSummary>;
}
