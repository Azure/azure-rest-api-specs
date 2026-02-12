import "@typespec/rest";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;

namespace Search;

@doc("A subset of Product attributes")
model ProductSummary {
  @doc("Product display name")
  displayName?: string;

  @doc("Publisher id")
  publisherId?: string;

  @doc("Indicates whether product purchases count toward Azure consumption commitment benefits for enterprise customers.\n- `Eligible` - Product costs apply to Azure consumption commitment benefit calculations and credits\n- `NotEligible` - Product costs do not qualify for Azure consumption commitment benefit programs")
  azureBenefit?: AzureBenefit;

  @doc("Displays certification and qualification badges earned by the product for marketplace visibility")
  badges?: string[];

  @doc("Identifies the publisher relationship to Microsoft for support and partnership classification.\n- `Microsoft` - First-party Microsoft product with direct Microsoft support and development\n- `ThirdParty` - Independent software vendor product with publisher-provided support and maintenance")
  publisherType?: string;

  @doc("Indicates the product availability status and customer access level within Azure Marketplace.\n- `Preview` - Limited availability to selected customers for testing and early access evaluation\n- `Public` - General availability to all Azure Marketplace customers for production deployment")
  publishingStage?: string;

  @key
  @visibility(Lifecycle.Read)
  @doc("Unique product identifier")
  uniqueProductId: string;

  @doc("Specifies the primary deployment model and hosting architecture for the marketplace product stored in the Marketplace Catalog. Possible values include, but are not limited to:\n- `None` - Unspecified product type, typically used for products without a defined deployment model\n- `ManagedApplication` - Azure Managed Applications that deploy and manage resources in customer subscriptions\n- `VirtualMachine` - Pre-configured virtual machine images deployable to Azure compute infrastructure\n- `AzureApplication` - Native Azure applications leveraging platform services and APIs\n- `Container` - Containerized applications deployed through Azure Container Instances or similar services\n- `SaaS` - Software as a Service solutions hosted and managed by the publisher\n- `SolutionTemplate` - Azure Resource Manager templates that provision multiple Azure resources\n- `IotEdgeModules` - Modules designed for deployment to Azure IoT Edge runtime environments\n- `ManagedServices` - Fully managed services where the publisher handles infrastructure and operations\n- `ContainerApps` - Applications built for Azure Container Apps serverless container platform\n- `DynamicsOps` - Microsoft Dynamics 365 Finance and Operations applications and extensions\n- `DynamicsCE` - Microsoft Dynamics 365 Customer Engagement applications and customizations\n- `DynamicsBC` - Microsoft Dynamics 365 Business Central applications and add-ons\n- `PowerBI` - Microsoft Power BI reports, dashboards, and data visualization components\n- `ConsultingServices` - Professional services offerings including implementation and advisory services\n- `CosellOnly` - Products available exclusively through Microsoft co-sell partner programs\n- `CoreVirtualMachine` - Core virtual machine offerings with baseline Azure compute capabilities\n- `PowerBIVisuals` - Custom visualizations for Microsoft Power BI reporting platform\n- `Office365` - Microsoft 365 and Office 365 applications, add-ins, and integrations\n- `AADApps` - Azure Active Directory integrated applications supporting organizational identity\n- `AzureServices` - Native Azure platform services and resource providers\n- `AppService` - Web applications hosted on Azure App Service platform\n- `LogAnalytics` - Azure Monitor Log Analytics solutions and workspace configurations\n- `MicrosoftProduct` - First-party Microsoft products available through marketplace channels")
  productType: string;

  @doc("Product sub type")
  productSubType?: string;

  @doc("Product Family")
  productFamily?: string;

  @doc("Operating system info for this product")
  operatingSystems?: string[];

  @doc("Indicates the billing models and cost structures available for the plan.\n- `Free` - No charge for plan usage, typically for community editions or basic service tiers\n- `FreeTrial` - Time-limited free access period before transitioning to paid billing model\n- `Byol` - Bring Your Own License model where customers provide existing software licenses\n- `Payg` - Pay As You Go consumption-based billing calculated on actual resource usage\n- `Ri` - Reserved Instance billing with upfront commitment for discounted long-term pricing")
  pricingTypes?: string[];

  @doc("Publisher display name")
  publisherDisplayName?: string;

  @doc("Product long summary")
  longSummary?: string;

  @doc("Product summary")
  summary?: string;

  @doc("Linked add-in types")
  linkedAddInsTypes?: Record<string>;

  @doc("URI to the small product icon")
  smallIconUri?: string;

  @doc("The product description text")
  description?: string;

  @doc("The legal terms of the product for the CSP")
  cspLegalTermsUri?: string;

  @doc("The privacy policy of the product")
  privacyPolicyUri?: string;

  @doc("Categorizes products by customer rating thresholds for marketplace filtering and discovery.\n- `AboveOne` - Products with customer ratings exceeding 1.0 stars based on marketplace reviews\n- `AboveTwo` - Products with customer ratings exceeding 2.0 stars based on marketplace reviews\n- `AboveThree` - Products with customer ratings exceeding 3.0 stars based on marketplace reviews\n- `AboveFour` - Products with customer ratings exceeding 4.0 stars based on marketplace reviews")
  ratingBuckets?: string[];

  @doc("Average rating for the offer")
  ratingAverage?: float64;

  @doc("Total number of ratings for the offer")
  ratingCount?: int32;

  @doc("Retail price of the product's cheapest plan")
  startingPrice?: MarketStartPrice;

  @doc("Full set of plan/SKU attributes")
  plans?: PlanSummary[];

  @doc("Maps to the list of compatible products")
  supportedProducts?: string[];

  @doc("Product categories the offer belongs to")
  applicableProducts?: string[];

  @doc("Latest update date of the product")
  lastModifiedDateTime?: string;

  @doc("List of locations which are available on the SKUs")
  locations?: string[];

  @doc("The service family of the product, such as 'Compute'")
  serviceFamily?: string;

  @doc("The service name of the product, such as 'Virtual Machines'")
  service?: string;

  @doc("A unique commercial identifier used to reference a specific product in transactional operations such as purchases, invoicing, and metering. This Id  services entitlement validation, and billing across systems")
  productId?: string;

  @doc("Indication whether the product has plans with reservations")
  hasRiPlans?: boolean;

  @doc("Indication of whether product appears in Azure Marketplace")
  hasMarketplaceFootprint?: boolean;

  @doc("Set of products attributes")
  attributes?: Attribute[];

  @doc("Used to map SaaS apps to their Azure AD appIds")
  activeDirectoryAppId?: string;
}

@doc("Represents a SKU attribute, which consists of a key and value. The attributes may differ across various services")
model Attribute {
  @doc("The attribute key")
  key?: string;

  @doc("The attribute value")
  value?: string;
}

@doc("Retail price of the product's cheapest plan")
model MarketStartPrice {
  @doc("The market for which the starting price is calculated")
  market?: string;

  @doc("The terms pricing model units")
  termUnits?: string;

  @doc("The meters pricing model units")
  meterUnits?: string;

  @doc("Starting (minimal) terms price")
  minTermPrice?: float32;

  @doc("Starting (minimal) meters price")
  minMeterPrice?: float32;

  @doc("Currency for price")
  currency?: string;
}

@doc("A subset of Plan attributes")
model PlanSummary {
  @doc("Plan identifier")
  planId?: string;

  @doc("Unique plan Id which is prefixed by combining uniqueProductId and PlanId with no separator in between")
  uniquePlanId?: string;

  @doc("Display name of the plan / sku")
  displayName?: string;

  @doc("Specifies the virtual machine processor architecture and generation. Applies exclusively to Virtual Machine product types.\n- `X64Gen1` - x64 processor architecture with Generation 1 virtual machine firmware and BIOS support\n- `X64Gen2` - x64 processor architecture with Generation 2 virtual machine firmware and UEFI support\n- `Arm64` - ARM 64-bit processor architecture optimized for energy efficiency and cloud-native workloads")
  vmArchitectureType?: string;

  @doc("Controls plan availability and partner access within the Microsoft Cloud Solution Provider (CSP) program.\n- `OptIn` - Enables all authorized Cloud Solution Provider partners to resell and deploy the product to customers\n- `OptOut` - Excluded from Cloud Solution Provider program, available only through direct channels\n- `SelectiveOptIn` - Available only to selected Cloud Solution Provider partners for resale and customer deployment")
  cspState?: string;

  @doc("Expanded plan/SKU metadata")
  metadata?: PlanMetadata;

  @doc("Alternative stack reference")
  altStackReference?: string;

  @doc("Stack type : Classic, Gen1, Gen2")
  stackType?: string;

  @doc("The alternative architecture reference")
  altArchitectureReference?: string;

  @doc("Plan CategoryIds")
  categoryIds?: string[];

  @doc("Set to true if plan has artifacts that are to be hidden for non authenticated users")
  hasProtectedArtifacts?: boolean;

  @doc("Indicates the billing models and cost structures available for the plan.\n- `Free` - No charge for plan usage, typically for community editions or basic service tiers\n- `FreeTrial` - Time-limited free access period before transitioning to paid billing model\n- `Byol` - Bring Your Own License model where customers provide existing software licenses\n- `Payg` - Pay As You Go consumption-based billing calculated on actual resource usage\n- `Ri` - Reserved Instance billing with upfront commitment for discounted long-term pricing")
  pricingTypes?: string[];

  @doc("Defines the security enhancement level for virtual machine deployments. Applies exclusively to Virtual Machine product types.\n- `None` - Standard virtual machine security without additional protection features\n- `Trusted` - Trusted Launch security with secure boot and virtual Trusted Platform Module capabilities\n- `Confidential` - Confidential computing with memory encryption and attestation for sensitive workloads")
  vmSecuritytypes?: string[];

  @doc("The plan summary text")
  summary?: string;

  @doc("Plan / sku description")
  description?: string;

  @doc("The SKU id")
  skuId?: string;

  @doc("Specifies the primary deployment model and hosting architecture for the marketplace product. Currently supported values are:\n- `None` - Unspecified product type, typically used for products without a defined deployment model\n- `DevService` - Development-focused services and tools for software creation workflows\n- `ManagedApplication` - Azure Managed Applications that deploy and manage resources in customer subscriptions\n- `VirtualMachine` - Pre-configured virtual machine images deployable to Azure compute infrastructure\n- `AzureApplication` - Native Azure applications leveraging platform services and APIs\n- `Container` - Containerized applications deployed through Azure Container Instances or similar services\n- `SaaS` - Software as a Service solutions hosted and managed by the publisher\n- `SolutionTemplate` - Azure Resource Manager templates that provision multiple Azure resources\n- `IotEdgeModules` - Modules designed for deployment to Azure IoT Edge runtime environments\n- `ManagedServices` - Fully managed services where the publisher handles infrastructure and operations\n- `ContainerApps` - Applications built for Azure Container Apps serverless container platform\n- `VisualStudioExtension` - Extensions that integrate with Visual Studio IDE functionality\n- `DynamicsOps` - Microsoft Dynamics 365 Finance and Operations applications and extensions\n- `DynamicsCE` - Microsoft Dynamics 365 Customer Engagement applications and customizations\n- `DynamicsBC` - Microsoft Dynamics 365 Business Central applications and add-ons\n- `PowerBI` - Microsoft Power BI reports, dashboards, and data visualization components\n- `ConsultingServices` - Professional services offerings including implementation and advisory services\n- `CosellOnly` - Products available exclusively through Microsoft co-sell partner programs\n- `CoreVirtualMachine` - Core virtual machine offerings with baseline Azure compute capabilities\n- `PowerBIVisuals` - Custom visualizations for Microsoft Power BI reporting platform\n- `Office365` - Microsoft 365 and Office 365 applications, add-ins, and integrations\n- `AADApps` - Azure Active Directory integrated applications supporting organizational identity\n- `AzureServices` - Native Azure platform services and resource providers\n- `AppService` - Web applications hosted on Azure App Service platform\n- `LogAnalytics` - Azure Monitor Log Analytics solutions and workspace configurations\n- `MicrosoftProduct` - First-party Microsoft products available through marketplace channels")
  planType: string;

  @doc("The order the plan is displayed in the 'Plans' table. Note that lower numbers appear first.")
  displayRank?: string;

  @doc("Indication that the plan is accessible to restricted audience only")
  isPrivate?: boolean;

  @doc("Indication whether the SKU supports reservations")
  hasRi?: boolean;
}

@doc("Additional metadata")
model PlanMetadata {
  @doc("The VM image generation (applicable to Virtual Machine products only)")
  generation?: string;

  @doc("Pointing to a planId which holds the alternative stack reference")
  altStackReference?: string;

  @doc("Other plans that may be related to this plan")
  relatedSkus?: PlanSkuRelation[];
}

@doc("Pointing to a related SKU object")
model PlanSkuRelation {
  @doc("The related Sku")
  sku?: RelatedSku;

  @doc("Relation Type")
  relationType?: string;
}

@doc("Sku object related to given plan")
model RelatedSku {
  @doc("The Sku name")
  name?: string;

  @doc("The Sku generation")
  generation?: string;

  @doc("The Sku identity")
  identity?: string;
}

@doc("Includes links to the learning and marketing materials as configured by the publisher")
model MarketingMaterial {
  @doc("Path to the marketing site")
  path?: string;

  @doc("Path to the learn site")
  learnUri?: string;
}

@doc("Search response object")
model SearchResponse {
  @doc("The search facets")
  facets?: Record<FacetsItem>;

  @doc("The search results")
  results: ProductSummary[];

  @doc("The total count of search results")
  totalCount?: int64;

  @doc("The search query used")
  showingResultsFor?: string;

  @doc("The next link for pagination, if available")
  nextLink?: string;
}

@doc("The Facets items for the search result")
model FacetsItem {
  @doc("Facet values dictionary, key is the facet name")
  facetValues?: Record<FacetValue>;
}

@doc("Facet values for a given facet")
model FacetValue {
  @doc("Facet value count")
  count?: int64;
}

@doc("The suggestions item")
model SuggestionsItem {
  @doc("The suggestion display text")
  displayText?: string;

  @doc("The suggestion icon url")
  iconUrl?: string;

  @doc("The suggestion item id")
  id?: string;

  @doc("The suggestion linked add-in types")
  linkedAddInsTypes?: Record<string>;

  @doc("The suggestion supported product types")
  productType?: ProductType;

  @doc("The search results")
  suggestionType: SuggestionType;
}

@doc("Suggestions response object")
model SuggestionsResponse {
  @doc("The search results")
  value: SuggestionsItem[];

  @doc("The total count of search results")
  totalCount?: int64;
}

@doc("Facets response object")
model FacetsResponse {
  @doc("The facet items results")
  value: Record<FacetsItem>;
}

// ----------------------------------- The following section contains enums --------------------------- //

#suppress "@azure-tools/typespec-azure-core/documentation-required" ""
@doc("The search field name")
union SearchFieldName {
  string,
  All: "All",
  LastModifiedDateTime: "LastModifiedDateTime",
  Market: "Market",
  SupportedProducts: "SupportedProducts",
  HideKeys: "HideKeys",
  PublisherId: "PublisherId",
  DisplayName: "DisplayName",
  AzureBenefit: "AzureBenefit",
  Badges: "Badges",
  SmallIconUri: "SmallIconUri",
  IndustryCloud: "IndustryCloud",
  PublisherType: "PublisherType",
  PublishingState: "PublishingState",
  Language: "Language",
  UniqueProductId: "UniqueProductId",
  ProductType: "ProductType",
  Plans: "Plans",
  OperatingSystems: "OperatingSystems",
  PricingTypes: "PricingTypes",
  PublisherDisplayName: "PublisherDisplayName",
  Summary: "Summary",
  LongSummary: "LongSummary",
  VmImageGenerations: "VmImageGenerations",
  VmSecurityTypes: "VmSecurityTypes",
  VmArchitectureTypes: "VmArchitectureTypes",
  Description: "Description",
  RatingBuckets: "RatingBuckets",
  RatingAverage: "RatingAverage",
  RatingCount: "RatingCount",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" ""
@doc("Azure benefit eligibility filter")
union AzureBenefit {
  string,
  Eligible: "Eligible",
  NotEligible: "NotEligible",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" ""
@doc("Product Badges")
union Badges {
  string,
  PreferredSolution: "PreferredSolution",
  PowerBICertified: "PowerBICertified",
  AdditionalPurchaseRequirement: "AdditionalPurchaseRequirement",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" ""
@doc("Industry Cloud")
union IndustryCloud {
  string,
  NotApplicable: "NotApplicable",
  True: "True",
  False: "False",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" ""
@doc("Pricing Type")
union PricingType {
  string,
  Free: "Free",
  FreeTrial: "FreeTrial",
  Byol: "Byol",
  Payg: "Payg",
  Ri: "Ri",
}

@doc("Product Type")
union ProductType {
  string,

  @doc("product type returned for Azure Services, Container Extensions and VM extensions")
  None: "None",

  @doc("Dev Service") DevService: "DevService",

  @doc("Managed Application plan type (applicable to Azure Applications only)")
  ManagedApplication: "ManagedApplication",

  @doc("the product is Image service instances with usage-based pricing")
  VirtualMachine: "VirtualMachine",

  @doc("products published as Solution Templates (ST) or Azure Managed Apps (AMA) plans that deploy Azure resources to the customer tenant")
  AzureApplication: "AzureApplication",

  @doc("the product is delivered as Container") Container: "Container",

  @doc("the product is a Software solution purchased on pay-as-you-go basis from a cloud service provider")
  SaaS: "SaaS",

  @doc("Solution Template plan type (applicable to Azure Applications only)")
  SolutionTemplate: "SolutionTemplate",

  @doc("resource is delivered as IoT Edge Module")
  IotEdgeModules: "IotEdgeModules",

  @doc("the product is delivered as Managed Service")
  ManagedServices: "ManagedServices",

  @doc("resource is delivered as Container App") ContainerApps: "ContainerApps",

  @doc("Visual Studio Extensions")
  VisualStudioExtension: "VisualStudioExtension",

  @doc("Dynamics 365 Operations Apps") DynamicsOps: "DynamicsOps",

  @doc("All Dynamics products except for DynamicsBC and DynamicsOps")
  DynamicsCE: "DynamicsCE",

  @doc("Dynamics 365 Business Central") DynamicsBC: "DynamicsBC",
  @doc("Power BI products") PowerBI: "PowerBI",

  @doc("Consulting Services (available only in Azure Marketplace as listing offers)")
  ConsultingServices: "ConsultingServices",

  @doc("Products available in scope of Co-Sell program only")
  CosellOnly: "CosellOnly",

  @doc("Virtual Machine with Windows or endorsed Linux OS image")
  CoreVirtualMachine: "CoreVirtualMachine",

  @doc("Power BI Visuals products") PowerBIVisuals: "PowerBIVisuals",
  @doc("Office 365 products") Office365: "Office365",
  @doc("Azure Active Directory Applications") AADApps: "AADApps",

  @doc("Native Azure Services such as Azure Open AI service, Azure Storage Account, etc")
  AzureServices: "AzureServices",

  @doc("HTTP-based service for hosting web applications, REST APIs, and mobile back ends")
  AppService: "AppService",

  @doc("Log Analytics services that log data from Azure Monitor and other Azure services")
  LogAnalytics: "LogAnalytics",
}

@doc("Publisher Type")
union PublisherType {
  string,

  @doc("Product is published by Microsoft (1st party product)")
  Microsoft: "Microsoft",

  @doc("Product is published by Third Party Vendor") ThirdParty: "ThirdParty",
}

@doc("Publishing Stage")
union PublishingStage {
  string,
  @doc("Product is available to restricted audience") Preview: "Preview",
  @doc("Product is publicly available in the Marketplace") Public: "Public",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" ""
@doc("Rating Bucket")
union RatingBucket {
  string,
  AboveOne: "AboveOne",
  AboveTwo: "AboveTwo",
  AboveThree: "AboveThree",
  AboveFour: "AboveFour",
}

@doc("Vm Architecture Types")
union VmArchitectureType {
  string,

  @doc("The VM image architecture of the plan is X64 Generation1")
  X64Gen1: "X64Gen1",

  @doc("The VM image architecture of the plan is X64 Generation2")
  X64Gen2: "X64Gen2",

  @doc("The VM image architecture of the plan is Arm64") Arm64: "Arm64",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" ""
@doc("Vm Security Type")
union VmSecurityType {
  string,
  None: "None",
  Trusted: "Trusted",
  Confidential: "Confidential",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" ""
@doc("Suggestion Types")
union SuggestionType {
  string,
  WordSearch: "WordSearch",
  Entity: "Entity",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" ""
@doc("Suggestions Field Name")
union SuggestionsFieldName {
  string,
  DisplayText: "DisplayText",
  Id: "Id",
  IconUrl: "IconUrl",
  ProductType: "ProductType",
  LinkedAddInsTypes: "LinkedAddInsTypes",
}

// ----------------------------------- The following section contains query param models --------------------------- //

@doc("Parameters for language selection")
model LanguageParameter {
  @query
  @doc("Language to search, ISO 639-1 two-letter code, possible values - 'en,cs,de,es,fr,hu,it,ja,ko,nl,pl,pt-br,pt-pt,ru,sv,tr,zh-hans,zh-hant'")
  language: string;
}

@doc("Parameter for market selection")
model MarketParameter {
  @query
  @doc("Product sold market, Possible values - https://docs.microsoft.com/en-us/azure/marketplace/marketplace-geo-availability-currencies or 'All' for all markets. Such as 'US'")
  market: string;
}

@doc("Parameter for selecting which fields to return in the response")
model SelectParameter {
  @query
  @doc("Array of fields to return. Such as select=pricingTypes. \n- `All`: All fields.\n- `SupportedProducts`: Supported Products.\n- `PublisherId`: Publisher Id.\n- `DisplayName`: Display Name.\n- `AzureBenefit`: Azure Benefit.\n- `Badges`: Badges.\n- `SmallIconUri`: Small Icon Uri.\n- `PublisherType`: Publisher Type.\n- `PublishingState`: Publishing State.\n- `UniqueProductId`: Unique Product Id.\n- `ProductType`: Product Type.\n- `Plans`: Plans.\n- `OperatingSystems`: Operating Systems.\n- `PricingTypes`: Pricing Types.\n- `PublisherDisplayName`: Publisher Display Name.\n- `Summary`: Summary.\n- `Description`: Description.\n- `RatingBuckets`: Rating Buckets.\n- `RatingAverage`: Rating Average.\n- `LastModifiedDateTime`: Last Modified time.\n- `RatingCount`: Rating Count.\n- `LongSummary`: Long Summary.")
  select?: SearchFieldName[];
}

@doc("Parameter for azure benefit eligibility filter")
model AzureBenefitParameter {
  @query
  @doc("Define the search for only azure benefit eligible offers, if no value provided, this filter is ignored. Default: null. \n- `Eligible`: Eligible.\n- `NotEligible`: Not Eligible.")
  azureBenefit?: AzureBenefit;
}

@doc("Parameter for badges filter")
model BadgesParameter {
  @query
  @doc("Products that contains any of the given badges. If no value provided, this filter is ignored. The following product badges are available: \n- `PreferredSolution`: Preferred Solution.\n- `PowerBICertified`: power BI Certified.\n- `AdditionalPurchaseRequirement`: Additional Purchase Requirement.")
  badges?: Badges[];
}

@doc("Parameter for which facets should be presented")
model FacetsParameter {
  @query
  @doc("Array of facets to facet by, if none provided then no facets will return. Such as facets=PricingTypes,operatingSystems. \n- `SupportedProducts`: Supported Products. \n- `PublisherType`: Publisher Type.\n- `AzureBenefit`: Azure Benefit.\n- `ProductType`: Product Type.\n- `OperatingSystems`: Operating Systems.\n- `PricingTypes`: Pricing Types.\n- `VmImageGenerations`: Vm Image Generations.\n- `VmSecurityTypes`: Vm Security Types.\n- `VmArchitectureTypes`: Vm Architecture Types.\n- `RatingBuckets`: Rating Buckets.")
  facets?: SearchFieldName[];
}

@doc("Parameters for preview product keys")
model HideKeysParameter {
  @query
  @doc("Products that contains any of the given hideKeys for preview. Such as '22c6b3ae-1111-1111-1111-e7cbdc8569dd'. If no value provided, this filter is ignored. This filter is applied only when PublishingStage filter is set to Preview.")
  hideKeys?: string[];
}

@doc("Parameter for industry cloud eligibility filter")
model IndustryCloudParameter {
  @query
  @doc("Define the search for IndustryCloud offers. If no value provided, this filter is ignored. Default: NotApplicable. \n- `NotApplicable`: Not Applicable.\n- `True`: True.\n- `False`: False.")
  industryCloud?: IndustryCloud;
}

@doc("Parameters for Operating Systems filter")
model OperatingSystemsParameter {
  @query
  @doc("Products that contains any of the given operating systems, Such as operatingSystems=windows,linux. If no value provided, this filter is ignored. This filter is relevant for Virtual Machine product type only.\n- `windows.windowsserver2019`: Windows Server 2019.\n- `windows.windowsserver2019`: Windows Server 2019.\n- `windows.windowsserver2016`: Windows Server 2016.\n- `windows.windowsserver2012r2`: Windows Server 2012 R2.\n- `windows.windowsserver2012`: Windows Server 2012.\n- `windows.windowsserver2008r2`: Windows Server 2008 R2.\n- `windows.others`: Others (windows).\n- `windows.windowsserver2022`: Windows Server 2022.\n- `linux.centos`: Cent OS.\n- `linux.debian`: Debian.\n- `linux.redhat`: Red Hat.\n- `linux.suse`: SUSE.\n- `linux.ubuntu`: Ubuntu.\n- `linux.others`: Others (Linux).")
  operatingSystems?: string[];
}

@doc("Parameters for Operating Systems filter")
model OrderByParameter {
  @query
  @doc("Array of sort by fields to order by and ordering type (asc\\desc), If no value provided, ordered by search score. Default ordering type: asc. For example, orderby=RatingCount desc. \n- `RatingCount`: ratingCount (asc/desc).\n- `LastModifiedDateTime`: lastModifiedDateTime (asc/desc).\n- `RatingAverage`: RatingAverage (asc/desc).")
  orderby?: string[];
}

@doc("Parameters for Pricing Types filter")
model PricingTypesParameter {
  @query
  @doc("Products that contains any of the given pricing types. If no value provided, this filter is ignored. \n- `Byol`: The product has at least one plan that is bring your own license.\n- `Free`: The product has at least one plan that is free of charge.\n- `FreeTrial`: The product has at least one plan that is free trial.\n- `Payg`: The product has at least one plan that is Pay as you go, usage based billing model.\n- `RI`: The product has at least one plan that is Reserved Instance billing model.")
  pricingTypes?: PricingType[];
}

@doc("Parameters for Product Types filter")
model ProductTypesParameter {
  @query
  @doc("Products that contains any of the given product types, Such as 'VirtualMachine'. If no value provided, this filter is ignored. Possible values include, but are not limited to:\n- `AADApps`: Azure Active Directory Apps.\n- `AzureApplication`: Azure Application.\n- `AzureServices`: Azure Services.\n- `ConsultingServices`: Consulting Services.\n- `Container`: Container.\n- `ContainerApps`: Container Apps.\n- `CoreVirtualMachine`: Core Virtual Machine.\n- `CosellOnly`: Cosell Only.\n- `DevService`: Dev Service.\n- `DynamicsBC`: Dynamics BC.\n- `DynamicsCE`: Dynamics CE.\n- `DynamicsOps`: Dynamics Ops.\n- `IotEdgeModules`: Iot Edge Modules.\n- `ManagedApplication`: Managed Application.\n- `ManagedServices`: Managed Services.\n- `Office365`: Office365.\n- `PowerBI`: PowerBI.\n- `PowerBIVisuals`: PowerBI Visuals.\n- `SaaS`: SaaS.\n- `SolutionTemplate`: Solution Template.\n- `VirtualMachine`: Virtual Machine.\n- `VisualStudioExtension`: Visual Studio Extension.\n- `AppService`: App Service.\n- `LogAnalytics`: Log Analytics.")
  productTypes?: ProductType[];
}

@doc("Parameters for Publisher Display Name filter")
model PublisherDisplayNameParameter {
  @query
  @doc("The search publisher name. Such as publisherDisplayName=red hat. If no value provided, this filter is ignored.")
  publisherDisplayName?: string;
}

@doc("Parameters for Publisher Ids filter")
model PublisherIdsParameter {
  @query
  @doc("Products that contains any of the given publisher ids. Such as 'Microsoft'. If no value provided, this filter is ignored.")
  publisherIds?: string[];
}

@doc("Parameters for Publisher Types filter")
model PublisherTypesParameter {
  @query
  @doc("Products that contains any of the given publisher types, If no value provided, this filter is ignored. Possible values: Microsoft, ThirdParty. Default: Microsoft. \n- `Microsoft`: Microsoft.\n- `ThirdParty`: Third Party.")
  publisherTypes?: PublisherType[];
}

@doc("Parameters for Publishing Stage filter")
model PublishingStageParameter {
  @query
  @doc("Audience. Default: Public.\n- `Preview`: Preview.\n- `Public`: Public")
  publishingStage?: PublishingStage;
}

@doc("Parameters for Rating Buckets filter")
model RatingBucketsParameter {
  @query
  @doc("Products that contains any of the given rating buckets. Such as 'Above1'. If no value provided, this filter is ignored. \n- `AboveOne`: Above One.\n- `AboveTwo`: Above Two.\n- `AboveThree`: Above Three.\n- `AboveFour`: Above Four")
  ratingBuckets?: RatingBucket[];
}

@doc("Parameters for Search Query filter")
model SearchQueryParameter {
  @query
  @doc("The search text, if no value provided, this filter is ignored. Such as searchQuery=red hat")
  searchQuery?: string;
}

@doc("Parameters for Skip results value")
model SkipParameter {
  @query
  @doc("Number of items to skip. Minimum: 0, Maximum: 100000, Default : 0.")
  skip?: int32;
}

@doc("Parameters for Supported Products filter")
model SupportedProductsParameter {
  @query
  @doc("Products that contains any of the given supported products. Such as 'CRM'. If no value provided, this filter is ignored.")
  supportedProducts?: string[];
}

@doc("Parameters for top results value")
model TopParameter {
  @query
  @doc("Number of items to return. Minimum: 0, Maximum: 1000, Default: 20.")
  top?: int32;
}

@doc("Parameters for VM Architecture Types filter")
model VmArchitectureTypesParameter {
  @query
  @doc("Array of Virtual Machine image architecture types to search by, If no value provided, this filter is ignored. see https://docs.microsoft.com/en-us/azure/virtual-machines/generation-2: \n - `X64Gen1`: X64 Generation 1.\n - `X64Gen2`: X64 Generation 2.\n - `Arm64`: Arm64 image architecture.")
  vmArchitectureTypes?: VmArchitectureType[];
}

@doc("Parameters for Operating Systems filter")
model VmSecurityTypesParameter {
  @query
  @doc("Products that contains any of the given vm security types. Such as 'Trusted'. If no value provided, this filter is ignored. \n- `None`: None.\n- `Trusted`: Trusted.\n- `Confidential`: Confidential")
  vmSecurityTypes?: VmSecurityType[];
}

@doc("Parameters for Operating Systems filter")
model SuggestionTypesParameter {
  @query
  @doc("Suggestion types. \n- `WordSearch`: WordSearch.\n- `Entity`: Entity.")
  suggestionTypes: SuggestionType[];
}

@doc("Parameters for Search Query filter")
model SuggestionsSearchQueryParameter {
  @query
  @doc("The search text. If no value is provided, this filter is ignored (e.g., searchQuery=red hat). The query must be at least 2 characters long; shorter values will not return results.")
  searchQuery: string;
}

@doc("Parameters for Search Query filter")
model SuggestionsSelectQueryParameter {
  @query
  @doc("Array of fields to return. Such as 'displayText'. If no value provided, return fields as follows. if suggestionsType=Entity, return: suggestionType, displayText, id. if suggestionType=WordSearch, return suggestionType and displayText. \n- `DisplayText`: Display text.\n- `Id`: Id.\n- `IconUrl`: Icon Url.\n- `ProductType`: Product type.\n- `LinkedAddInsTypes`: Linked AddIns types.")
  select?: SuggestionsFieldName[];
}

// API key def
@doc("Use key provided by Marketplace Catalog Team as a parameter provided in the header. Details on obtaining the key can be found at https://aka.ms/DiscoveryAPI/keys")
model DiscoveryApiKey is ApiKeyAuth<ApiKeyLocation.header, "X-API-Key">;

// Error payload definitions
@doc("Error payload returned by Marketplace Discovery APIs")
@error
model DiscoveryErrorPayload {
  @doc("The error details object")
  error: DiscoveryErrorDetails;
}

@doc("Error details returned in DiscoveryErrorPayload")
model DiscoveryErrorDetails {
  @doc("The HTTP error code")
  code: string;

  @doc("The error message")
  message: string;
}
