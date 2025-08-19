import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Http;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;

namespace Products;

// Product listing traits
alias ProductsListingTraits = LanguageParameter &
  LocationsListingParameter &
  ListingMarketParameter &
  HideKeysParameter &
  OdataSelectParameter &
  OdataFilterParameter &
  OdataExpandParameter &
  OdataOrderByParameter &
  SearchParameter &
  PricingAudienceListingParameter;

// Product get traits
alias ProductsGetTraits = SingleMarketParameter &
  LanguageParameter &
  LocationsSingleParameter &
  IncludeStopSoldPlansParameter &
  HideKeysParameter &
  ExcludeSkuDetailsParameter &
  IncludeFutureAvailabilitiesParameter &
  SkuIdParameter &
  PricingAudienceSingleParameter;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Routes for listing and single are almost the same, requires custom operation"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Returning custom paginated object"
@doc("Retrieves a list of products available in the marketplace catalog")
@get
@list
@route("/products")
op listProducts(...ApiVersionParameter, ...ProductsListingTraits): {
  ...DiscoveryApiPagedResult<ProductSummary>;
} | DiscoveryErrorPayload;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Routes for listing and single are almost the same, requires custom operation"
@doc("Retrieves a single product by ID from the marketplace catalog")
@get
@route("/products/{uniqueProductId}")
op getProduct(
  @doc("Unique product identifier")
  @path
  uniqueProductId: string,

  ...ApiVersionParameter,
  ...ProductsGetTraits,
): ProductDetails | DiscoveryErrorPayload;

// Skus listing traits
alias SkusListingTraits = ServiceParameter &
  ServiceFamilyParameter &
  LanguageParameter &
  LocationsListingParameter &
  ListingMarketParameter &
  OdataSelectParameter &
  OdataFilterParameter &
  OdataOrderByParameter &
  PricingAudienceListingParameter;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Retaining custom implementation for operation parity"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Returning custom paginated object"
@doc("Retrieves a list of SKUs available in the marketplace catalog.")
@list
@get
@route("/skus")
op listSkus(...ApiVersionParameter, ...SkusListingTraits): {
  ...DiscoveryApiPagedResult<SkuSummary>;
} | DiscoveryErrorPayload;
