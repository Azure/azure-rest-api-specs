import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Products;

interface ProductOperations {
  // Need to add an example to this
  @route("/products")
  @doc("Public Products API provides an unauthenticated endpoint for consuming commercial 3rd party Marketplace public products and 1st party Azure products. In addition, it enables Odata filtering on selected product properties.  Each API request must include an API key allocated to you (see X-API-Key description). Send an email to MKPL_Platform_API_DL@microsoft.com including the following details to get the API Key:\n- Customer name\n- Service/Product name\n- AD Registered App ID (if available)\n- Focal point email\n- Use case/scenario\n- Expected traffic volume, including peak requests per second (daily)")
  @tag("ListingPublicProducts")
  @returnsDoc("Returns a list of public or preview products")
  @get
  getProducts(
    @doc("Version of the REST API used for the request.")
    @query("api-version")
    apiVersion: string,

    @doc("Return products available in Azure Portal Marketplace, AppSource or Azure Marketplace portal. The possible values are: \n- `azure` - Azure Portal Marketplace\n- `amp` - Azure Marketplace portal\n- `appsource` - AppSource portal\nThe default value is 'azure'")
    @query
    storefront?: string = "azure",

    @doc("Language to search, ISO 639-1 two-letter code, possible values - 'en,cs,de,es,fr,hu,it,ja,ko,nl,pl,pt-br,pt-pt,ru,sv,tr,zh-hans,zh-hant'. Default is \"en\"")
    @query
    language?: string = "en",

    @doc("Return products available in selected location. Enumeration of the Azure datacenter regions. See https://azure.microsoft.com/regions/")
    @query
    locations?: string[],

    @doc("Product market value  (the response will include only products that can be sold in the specified market)\nPossible values can be found at https://docs.microsoft.com/en-us/azure/marketplace/marketplace-geo-availability-currencies. Example: 'US'")
    @query
    market?: string,

    @doc("This key is utilized to retrieve preview products and is generated within the Partner Center during the offer publishing process.")
    @query
    hideKeys?: string[],

    @doc("Selects which properties to include in the results. Example: 'select=displayName'")
    @query
    select?: string[],

    @doc("Filters the results, based on a Boolean condition. Example: 'filter=productType eq \"VirtualMachine\"'. Fields that can be filtered by are:\n- `displayName`\n- `productId`\n- `popularity`\n- `categoryIds`\n- `industryIds`\n- `publisherId`\n- `uniqueProductId`\n- `productType`\n- `operatingSystems`\n- `pricingTypes`\n- `publisherDisplayName`\n- `longSummary`\n- `summary`\n- `linkedAddinsTypes`\n- `description`\n- `supportedProducts`\n- `applicableProducts`\n- `lastModifiedDateTime`\n- `plan.planId`\n- `plan.displayName`\n- `plan.cspState`\n- `plan.altStackReference`\n- `plan.stackType`\n- `plan.categoryIds`\n- `plan.hasProtectedArtifacts`\n- `plan.pricingTypes`\n- `plan.summary`\n- `plan.description`\n- `plan.skuId`\n- `plan.displayRank`\n- `plan.isPrivate`")
    @query
    filter?: string,

    @doc("Expands related entities inline. Example: 'expand=startingPrice'")
    @query
    expand?: string[],

    @doc("Ordering expression for the results using OData notation. Avoid using orderby unless essential as this may impact the latency of your request.  Example: 'orderby=displayName desc'.This API only supports ordering by a single field. Fields that can be ordered by are:\n- `lastModifiedDateTime`\n- `uniqueProductId`\n- `productType`\n- `displayName`\n- `publisherId`")
    @query
    orderby?: string,

    @doc("Use Api key provided by Marketplace Catalog Team as a parameter provided in the header")
    @header("X-API-Key")
    apiKey: string,
  ): CatalogApiResponse | ErrorResponse;
}
