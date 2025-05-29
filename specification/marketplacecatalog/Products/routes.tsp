import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace Products;

// Product listing traits

alias ProductsListingTraits = SupportsClientRequestId &
  SupportsRepeatableRequests &
  NoConditionalRequests &
  QueryParametersTrait<StorefrontParameter &
    LanguageParameter &
    LocationsParameter &
    MarketParameter &
    HideKeysParameter &
    SelectQueryParameter &
    FilterParameter &
    ExpandQueryParameter &
    OrderByQueryParameter>;

// Product get traits
alias ProductsGetTraits = SupportsClientRequestId &
  SupportsRepeatableRequests &
  NoConditionalRequests &
  QueryParametersTrait<MarketParameter &
    StorefrontParameter &
    LanguageParameter &
    LocationsParameter &
    IncludeStopSoldPlansParameter &
    HideKeysParameter &
    ExcludeSkuDetailsParameter &
    IncludeFutureAvailabilitiesParameter &
    SkuIdParameter &
    PricingAudienceHeaderParameter &
    ApiKeyParameter>;

alias ProductsListingOperation = ResourceOperations<ProductsListingTraits>;
alias ProductsGetOperation = ResourceOperations<ProductsGetTraits>;

interface ProductOperations {
  @doc("Retrieves a list of products available in the marketplace catalog.")
  list is ProductsListingOperation.ResourceList<ProductSummary>;

  @doc("Retrieves a single product by ID from the marketplace catalog.")
  get is ProductsGetOperation.ResourceRead<ProductDetails>;
}
