import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Http;
using Rest;

namespace Microsoft.Marketplace;

const LanguageParameterDescription = "Language to search, ISO 639-1 two-letter code, possible values - 'en,cs,de,es,fr,hu,it,ja,ko,nl,pl,pt-br,pt-pt,ru,sv,tr,id,zh-hans,zh-hant'. Default is 'en'.";
const MarketParameterDescription = "Product market value (the response will include only SKUs that can be sold in the specified market). Possible values can be found at https://docs.microsoft.com/en-us/azure/marketplace/marketplace-geo-availability-currencies. Example: 'US'.";
const ExcludePublicParameterDescription = "Whether to exclude public offers and public plans from the response. Default is false, which means that public offers and public plans are included in the response. If set to true, only private plans will be returned.";
const LocationsParameterDescription = "Return SKUs available in the selected locations. Enumeration of the Azure datacenter regions. See https://azure.microsoft.com/regions/.";
const FilterOdataParameterDescription = "Filters the results, based on a Boolean condition. Example: $filter=serviceFamily eq 'Compute'. Fields that can be filtered by are:\n- `productId`\n- `serviceFamily`\n- `service`\n- `skuId`\n- `skuName`\n- `skuType`\n- `armRegionName`\n- `location`\n- `publisherId`\n- `productType`";
const SelectOdataParameterDescription = "Selects which properties to include in the results. Example: $select=skuName,skuId";
const ExpandOdataParameterDescription = "Expands related entities inline.";
const OrderByOdataParameterDescription = "Ordering expression for the results using OData notation. Avoid using orderby unless essential as this may impact the latency of your request. Example: $orderby=skuName desc. This API only supports ordering by a single field. Fields that can be ordered by are:\n- `lastModifiedDateTime`\n- `skuName`\n- `skuId`\n- `productId`\n- `serviceFamily`\n- `service`";
const MarketSingleParameterDescription = "Sku market value that will be used to fetch the product and affect the returning result.Possible values can be found at https://docs.microsoft.com/en-us/azure/marketplace/marketplace-geo-availability-currencies. Example: 'US'";

/** Sku
/** Sku id path parameter */
model SkuIdParameter {
  /** The ID of the SKU */
  @path
  @segment("providers/Microsoft.Marketplace/skus")
  @minLength(1)
  skuId: string;
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
 * The default billing profile id parameter type.
 */
model BillingProfileIdParameter {
  /** The ID of the target billing profile. */
  @path
  @segment("billingProfiles")
  @minLength(1)
  billingProfileId: string;
}
