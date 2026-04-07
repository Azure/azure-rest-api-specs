import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Http;
using Azure.Core.Foundations;

namespace Search;

// ----------------------------------- The following section contains aliases --------------------------- //
alias SearchRequestParameters = LanguageParameter &
  MarketParameter &
  SelectParameter &
  AzureBenefitParameter &
  BadgesParameter &
  FacetsParameter &
  HideKeysParameter &
  IndustryCloudParameter &
  OperatingSystemsParameter &
  OrderByParameter &
  PricingTypesParameter &
  ProductTypesParameter &
  PublisherDisplayNameParameter &
  PublisherIdsParameter &
  PublisherTypesParameter &
  PublishingStageParameter &
  RatingBucketsParameter &
  SearchQueryParameter &
  SupportedProductsParameter &
  TopParameter &
  VmArchitectureTypesParameter &
  VmSecurityTypesParameter;

alias SuggestionsRequestParameters = LanguageParameter &
  SuggestionsSearchQueryParameter &
  SuggestionTypesParameter &
  AzureBenefitParameter &
  BadgesParameter &
  IndustryCloudParameter &
  OperatingSystemsParameter &
  PricingTypesParameter &
  ProductTypesParameter &
  PublisherDisplayNameParameter &
  PublisherIdsParameter &
  PublisherTypesParameter &
  RatingBucketsParameter &
  SuggestionsSelectQueryParameter &
  SupportedProductsParameter &
  TopParameter &
  VmArchitectureTypesParameter &
  VmSecurityTypesParameter;

alias FacetsRequestParameters = FacetsParameter &
  LanguageParameter &
  MarketParameter &
  AzureBenefitParameter &
  BadgesParameter &
  HideKeysParameter &
  IndustryCloudParameter &
  OperatingSystemsParameter &
  PricingTypesParameter &
  ProductTypesParameter &
  PublisherDisplayNameParameter &
  PublisherIdsParameter &
  PublisherTypesParameter &
  PublishingStageParameter &
  RatingBucketsParameter &
  SearchQueryParameter &
  SupportedProductsParameter &
  VmArchitectureTypesParameter &
  VmSecurityTypesParameter;

// ----------------------------------- The following section contains operations --------------------------- //

#suppress "@azure-tools/typespec-azure-core/use-standard-names" ""
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Routes for listing and single are almost the same, requires custom operation"
@doc("Serves a user experience with search and filter results on Marketplace public products.")
@get
@route("/search")
op search(
  ...ApiVersionParameter,
  ...SearchRequestParameters,
): SearchResponse | DiscoveryErrorPayload;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" ""
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Routes for listing and single are almost the same, requires custom operation"
@doc("Make suggestions while user is typing a search query for products.")
@get
@route("/suggestions")
op suggestions(
  ...ApiVersionParameter,
  ...SuggestionsRequestParameters,
): SuggestionsResponse | DiscoveryErrorPayload;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" ""
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Routes for listing and single are almost the same, requires custom operation"
@doc("Get counts of Marketplace public products with requested properties.")
@get
@route("/facets")
op facets(
  ...ApiVersionParameter,
  ...FacetsRequestParameters,
): FacetsResponse | DiscoveryErrorPayload;
