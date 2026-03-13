import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Http;
using Rest;

namespace Microsoft.Marketplace;

const LanguageParameterDescription = "Language to search, ISO 639-1 two-letter code, possible values - 'en,cs,de,es,fr,hu,it,ja,ko,nl,pl,pt-br,pt-pt,ru,sv,tr,id,zh-hans,zh-hant'. Default is \"en\"";
const MarketParameterDescription = "Product market value  (the response will include only products that can be sold in the specified market)\nPossible values can be found at https://docs.microsoft.com/en-us/azure/marketplace/marketplace-geo-availability-currencies. Example: 'US'";
const ExcludePublicParameterDescription = "Whether to exclude public offers and public plans from the response. Default is false, which means that public offers and public plans are included in the response. If set to true, only private plans will be returned.";
const PricingAudienceParameterDescription = "Direct-Commercial or Partner-Commercial. This value is used to determine the pricing audience for the product. If not specified, the default value is Direct-Commercial.";
const FilterOdataParameterDescription = "Filters the results, based on a Boolean condition. Example: $filter=productType eq 'VirtualMachine'. Fields that can be filtered by are:\n- `displayName`\n- `productId`\n- `popularity`\n- `categoryIds`\n- `industryIds`\n- `publisherId`\n- `uniqueProductId`\n- `productType`\n- `operatingSystems`\n- `pricingTypes`\n- `publisherDisplayName`\n- `longSummary`\n- `summary`\n- `linkedAddinsTypes`\n- `description`\n- `supportedProducts`\n- `applicableProducts`\n- `lastModifiedDateTime`\n- `plan.planId`\n- `plan.displayName`\n- `plan.cspState`\n- `plan.altStackReference`\n- `plan.stackType`\n- `plan.categoryIds`\n- `plan.hasProtectedArtifacts`\n- `plan.pricingTypes`\n- `plan.summary`\n- `plan.description`\n- `plan.skuId`\n- `plan.displayRank`\n- `plan.isPrivate`";
const SelectOdataParameterDescription = "Selects which properties to include in the results. Example: $select=displayName";
const ExpandOdataParameterDescription = "Expands related entities inline";
const OrderByOdataParameterDescription = "Ordering expression for the results using OData notation. Avoid using orderby unless essential as this may impact the latency of your request.  Example: $orderby=displayName desc.This API only supports ordering by a single field. Fields that can be ordered by are:\n- `lastModifiedDateTime`\n- `uniqueProductId`\n- `productType`\n- `displayName`\n- `publisherId`'";
const SearchParameterDescription = "Optional search by display name, publisher display name, or keywords. Example $search=Microsoft";
const LocationsarameterDescription = "Return products available in selected location. Enumeration of the Azure datacenter regions. See https://azure.microsoft.com/regions/";

const IncludeStopSoldPlansParameterDescription = "Indicates whether to include plans that are no longer available for purchase in the response. By default, includeStopSoldPlans is set to FALSE.";
const LookUpOfferInTenantLevelParameterDescription = "Indicates whether to use the tenant in context to fetch the product. By default, lookUpOfferInTenantLevel is set to FALSE.";
const MarketSingleParameterDescription = "Product market value that will be used to fetch the product and affect the returning result.Possible values can be found at https://docs.microsoft.com/en-us/azure/marketplace/marketplace-geo-availability-currencies. Example: 'US'";
const IncludeHiddenPlansParameterDescription = "Indicates whether to include hidden plans in the response. By default, includeHiddenPlans is set to FALSE.";
const PlanIdParameterDescription = "Optional to pass the plan id to filter to a specific plan within the product. If not specified, the response will include all plans of the product.";
const SkuIdParameterDescription = "Optional to pass the sku id to filter to a specific sku within the product. If not specified, the response will include all skus of the product.";
const IncludeServiceInstructionTemplatesParameterDescription = "Indicates whether to include the product's service instruction templates in the response. By default, includeServiceInstructionTemplates is set to FALSE.";

/** Product
/** Product id path parameter */
model ProductIdParameter {
  /** The ID of the product */
  @path
  @segment("providers/Microsoft.Marketplace/products")
  @minLength(1)
  productId: string;
}

/**
 * The default billing account id parameter type.
 */
model BillingAccountIdParameter {
  /** The ID of the target billing account. */
  @path
  @segment("providers/Microsoft.Billing/billingAccounts")
  @minLength(1)
  billingAccountId: string;
}

/**
 * The default billing account id parameter type.
 */
model BillingProfileIdParameter {
  /** The ID of the target billing account. */
  @path
  @segment("billingProfiles")
  @minLength(1)
  billingProfileId: string;
}
