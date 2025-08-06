import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Http;

namespace Microsoft.Marketplace;

// The following section contains query param models
@doc("Marketplace Catalog API")
model MarketParameter {
  @query
  @doc("Product market value  (the response will include only products that can be sold in the specified market)\nPossible values can be found at https://docs.microsoft.com/en-us/azure/marketplace/marketplace-geo-availability-currencies. Example: 'US'")
  market: string;
}

@doc("Parameters for language selection")
model LanguageParameter {
  @query
  @doc("Language to search, ISO 639-1 two-letter code, possible values - 'en,cs,de,es,fr,hu,it,ja,ko,nl,pl,pt-br,pt-pt,ru,sv,tr,zh-hans,zh-hant'. Default is \"en\"")
  language?: string = "en";
}

@doc("Parameters for location filtering")
model LocationsParameter {
  @query
  @doc("Return products available in selected location. Enumeration of the Azure datacenter regions. See https://azure.microsoft.com/regions/")
  locations?: string[];
}

@doc("Parameters for preview product keys")
model HideKeysParameter {
  @query
  @doc("This key is utilized to retrieve preview products and is generated within the Partner Center during the offer publishing process.")
  hideKeys?: string[];
}

@doc("Indicates whether to include in the response the product's plans/SKUs that are no longer available for purchase. By default, includeStopSoldPlans is set to FALSE.")
model IncludeStopSoldPlansParameter {
  @query
  @doc("Indicates whether to include in the response the product's plans/SKUs that are no longer available for purchase. By default, includeStopSoldPlans is set to FALSE.")
  includeStopSoldPlans?: boolean = false;
}

@doc("By default SKU details are included (excludeSkuDetails = FALSE ), to exclude SKU details in the response, set excludeSkuDetails to TRUE.")
model ExcludeSkuDetailsParameter {
  @query
  @doc("By default SKU details are included (excludeSkuDetails = FALSE ), to exclude SKU details in the response, set excludeSkuDetails to TRUE.")
  excludeSkuDetails?: boolean = false;
}

@doc("Include future availabilities parameter")
model IncludeFutureAvailabilitiesParameter {
  @query
  @doc("Indicates whether to include the product's plans/SKU availabilities with future dates in the response. By default, includeFutureAvailabilities is set to FALSE.")
  includeFutureAvailabilities?: boolean = false;
}

@doc("SKU ID filter parameter")
model SkuIdParameter {
  @query
  @doc("Apply SKU ID filtering to the results and only return products that include SKUs matching the selected SKU ID.")
  skuId?: string;
}

@doc("Pricing audience header parameter")
model PricingAudienceHeaderParameter {
  @header("x-ms-pricing-audience")
  @doc("DirectCommercial or PartnerCommercial, DirectCommercial is the default")
  pricingAudience?: string;
}

@doc("Service parameter")
model ServiceParameter {
  @query
  @doc("The service name of the product, such as 'Virtual Machines'")
  service: string;
}

@doc("Service family parameter")
model ServiceFamilyParameter {
  @query
  @doc("The service family of the product, such as 'Compute'")
  serviceFamily: string;
}

// OData parameters
@doc("OData Filter parameter")
model OdataFilterParameter {
  @query
  @doc("Filters the results, based on a Boolean condition. Example: $filter=productType eq 'VirtualMachine'. Fields that can be filtered by are:\n- `displayName`\n- `productId`\n- `popularity`\n- `categoryIds`\n- `industryIds`\n- `publisherId`\n- `uniqueProductId`\n- `productType`\n- `operatingSystems`\n- `pricingTypes`\n- `publisherDisplayName`\n- `longSummary`\n- `summary`\n- `linkedAddinsTypes`\n- `description`\n- `supportedProducts`\n- `applicableProducts`\n- `lastModifiedDateTime`\n- `plan.planId`\n- `plan.displayName`\n- `plan.cspState`\n- `plan.altStackReference`\n- `plan.stackType`\n- `plan.categoryIds`\n- `plan.hasProtectedArtifacts`\n- `plan.pricingTypes`\n- `plan.summary`\n- `plan.description`\n- `plan.skuId`\n- `plan.displayRank`\n- `plan.isPrivate`")
  $filter?: string;
}

@doc("Search filter parameter")
model SearchParameter {
  @query
  @doc("Optional search by display name, publisher display name, or keywords. Example $search=Microsoft")
  $search?: string;
}

@doc("OData Select parameter")
model OdataSelectParameter {
  @query
  @doc("Selects which properties to include in the results. Example: $select=displayName")
  $select?: string;
}

@doc("OData Expand parameter")
model OdataExpandParameter {
  @query
  @doc("Expands related entities inline")
  $expand?: string;
}

@doc("OData Expand parameter")
model OdataOrderByParameter {
  @query
  @doc("Ordering expression for the results using OData notation. Avoid using orderby unless essential as this may impact the latency of your request.  Example: $orderby=displayName desc.This API only supports ordering by a single field. Fields that can be ordered by are:\n- `lastModifiedDateTime`\n- `uniqueProductId`\n- `productType`\n- `displayName`\n- `publisherId`'")
  $orderBy?: string;
}
