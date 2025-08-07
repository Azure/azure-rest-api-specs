import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using Azure.Core;
using Azure.Core.Traits;

namespace Products;

// Product listing traits
alias ProductsListingTraits = NoClientRequestId &
  SupportsRepeatableRequests &
  NoConditionalRequests &
  QueryParametersTrait<LanguageParameter &
    LocationsListingParameter &
    ListingMarketParameter &
    HideKeysParameter &
    OdataSelectParameter &
    OdataFilterParameter &
    OdataExpandParameter &
    OdataOrderByParameter &
    SearchParameter &
    PricingAudienceListingParameter>;

// Product get traits
alias ProductsGetTraits = NoClientRequestId &
  SupportsRepeatableRequests &
  NoConditionalRequests &
  QueryParametersTrait<SingleMarketParameter &
    LanguageParameter &
    LocationsSingleParameter &
    IncludeStopSoldPlansParameter &
    HideKeysParameter &
    ExcludeSkuDetailsParameter &
    IncludeFutureAvailabilitiesParameter &
    SkuIdParameter &
    PricingAudienceSingleParameter>;

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
alias SkusListingTraits = NoClientRequestId &
  SupportsRepeatableRequests &
  NoConditionalRequests &
  QueryParametersTrait<ServiceParameter &
    ServiceFamilyParameter &
    LanguageParameter &
    LocationsListingParameter &
    ListingMarketParameter &
    OdataSelectParameter &
    OdataFilterParameter &
    OdataOrderByParameter &
    PricingAudienceListingParameter>;

// Operation definitions for Skus
alias SkusListingOperation = ResourceOperations<SkusListingTraits>;

interface SkusOperations {
  @doc("Retrieves a list of SKUs available in the marketplace catalog.")
  list is SkusListingOperation.ResourceList<SkuSummary>;
}
