import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using Azure.Core;
using Azure.Core.Traits;

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
    OrderByQueryParameter> &
  RequestHeadersTrait<ApiKeyParameter>;

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
    SkuIdParameter> &
  RequestHeadersTrait<ApiKeyParameter & PricingAudienceHeaderParameter>;

// Operation definitions
alias ProductsListingOperation = ResourceOperations<ProductsListingTraits>;
alias ProductsGetOperation = ResourceOperations<ProductsGetTraits>;

interface ProductOperations {
  @doc("Retrieves a list of products available in the marketplace catalog.")
  list is ProductsListingOperation.ResourceList<ProductSummary>;

  @doc("Retrieves a single product by ID from the marketplace catalog.")
  get is ProductsGetOperation.ResourceRead<ProductDetails>;
}

// Skus listing traits
alias SkusListingTraits = SupportsClientRequestId &
  SupportsRepeatableRequests &
  NoConditionalRequests &
  QueryParametersTrait<ServiceParameter &
    ServiceFamilyParameter &
    LanguageParameter &
    LocationsParameter &
    MarketParameter &
    SelectQueryParameter &
    FilterParameter &
    OrderByQueryParameter> &
  RequestHeadersTrait<ApiKeyParameter>;

// Operation definitions for Skus
alias SkusListingOperation = ResourceOperations<SkusListingTraits>;

interface SkusOperations {
  @doc("Retrieves a list of SKUs available in the marketplace catalog.")
  list is SkusListingOperation.ResourceList<SkuSummary>;
}
