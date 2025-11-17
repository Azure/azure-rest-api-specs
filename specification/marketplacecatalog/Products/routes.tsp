import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using Azure.Core;
using TypeSpec.Http;

namespace Products;

alias MarketplaceDiscoveryTraits = Traits.NoConditionalRequests &
  Traits.NoRepeatableRequests &
  Traits.NoClientRequestId;

// Product listing traits
alias ProductsListingParams = LanguageParameter &
  LocationsListingParameter &
  ListingMarketParameter &
  HideKeysParameter &
  OdataSelectParameter &
  ProductsOdataFilterParameter &
  OdataExpandParameter &
  ProductsOdataOrderByParameter &
  SearchParameter;

// Product get traits
alias ProductsGetParams = UniqueProductIdParameter &
  SingleMarketParameter &
  LanguageParameter &
  LocationsSingleParameter &
  IncludeStopSoldPlansParameter &
  HideKeysParameter &
  ExcludeSkuDetailsParameter &
  IncludeFutureAvailabilitiesParameter &
  SkuIdParameter;

interface Products {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Products list is a proxy resource that doesn't fit the standard operations path"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "DiscoveryApiPagedProductsResult is the Discovery API standard for returning listing responses"
  @doc("Retrieves a list of products available in the marketplace catalog")
  @get
  @list
  @route("/products")
  list is Azure.Core.Foundations.Operation<
    ProductsListingParams,
    DiscoveryApiPagedProductsResult,
    MarketplaceDiscoveryTraits,
    DiscoveryErrorPayload
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Products get is a proxy resource that doesn't fit the standard operations path"
  @doc("Retrieves a single product by ID from the marketplace catalog")
  @get
  @route("/products/{uniqueProductId}")
  get is Azure.Core.Foundations.Operation<
    ProductsGetParams,
    ProductDetails,
    MarketplaceDiscoveryTraits,
    DiscoveryErrorPayload
  >;
}

// Skus listing traits
alias SkusListingParams = ServiceParameter &
  ServiceFamilyParameter &
  LanguageParameter &
  SkusLocationsListingParameter &
  ListingSkusMarketParameter &
  OdataSelectParameter &
  SkusOdataFilterParameter &
  SkusOdataOrderByParameter;

interface Skus {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Skus list is a proxy resource that doesn't fit the standard operations path"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "DiscoveryApiPagedSkusResult is the Discovery API standard for returning listing responses"
  @doc("Retrieves a list of SKUs available in the marketplace catalog")
  @list
  @get
  @route("/skus")
  list is Azure.Core.Foundations.Operation<
    SkusListingParams,
    DiscoveryApiPagedSkusResult,
    MarketplaceDiscoveryTraits,
    DiscoveryErrorPayload
  >;
}
