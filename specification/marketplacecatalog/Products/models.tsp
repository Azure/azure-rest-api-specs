import "@typespec/rest";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace Products;

@doc("Summary description of the SKU")
@resource("skus")
model SkuSummary {
  @key
  @visibility(Lifecycle.Read)
  @doc("The unique id of the product")
  productId: string;

  @doc("Product display name")
  productDisplayName?: string;

  @doc("The product description text")
  productDescription?: string;

  @doc("The service family of the product, such as 'Compute'")
  serviceFamily?: string;

  @doc("The service name of the product, such as 'Virtual Machines'")
  service?: string;

  @doc("Publisher id")
  publisherId?: string;

  @doc("A value indicating whether this is a Microsoft or third party product. Possible values include \n- `Microsoft` - Product is published by Microsoft (1st party product)\n- `ThirdParty` - Product is published by Third Party Vendor")
  publisherType?: string;

  @doc("The delivery method or deployment model. Possible values include \n- `None` - Default value\n- `DevService` - Dev Service\n- `ManagedApplication` - Managed Application plan type\n- `VirtualMachine` - Virtual Machine\n- `AzureApplication` - Azure Application\n- `Container` - Container\n- `SaaS` - Software as a Service\n- `SolutionTemplate` - Solution Template\n- `IotEdgeModules` - IoT Edge Module\n- `ManagedServices` - Managed Service\n- `ContainerApps` - Container App\n- `VisualStudioExtension` - Visual Studio Extension\n- `DynamicsOps` - Dynamics Operations\n- `DynamicsCE` - Dynamics CE\n- `DynamicsBC` - Dynamics Business Central\n- `PowerBI` - Power BI\n- `ConsultingServices` - Consulting Services\n- `CosellOnly` - Co-sell Only\n- `CoreVirtualMachine` - Core Virtual Machine\n- `PowerBIVisuals` - Power BI Visuals\n- `Office365` - Office 365\n- `AADApps` - Azure Active Directory Applications\n- `AzureServices` - Azure Services\n- `AppService` - App Service\n- `LogAnalytics` - Log Analytics\n- `MicrosoftProduct` - Microsoft Product")
  productType?: string;

  @doc("Product sub type")
  productSubType?: string;

  @doc("Product summary")
  summary?: string;

  @doc("The product attributes")
  productAttributes?: Attribute[];

  @doc("Sku name")
  skuName?: string;

  @doc("Sku id")
  skuId?: string;

  @doc("Sku type")
  skuType?: string;

  @doc("Language")
  language?: string;

  @doc("Sku description localized")
  skuDescription?: string;

  @doc("Sku title localized")
  skuTitle?: string;

  @doc("Latest update date of the SKU")
  lastModifiedDateTime?: string;

  @doc("Location (region)")
  location?: string;

  @doc("The Arm region name")
  armRegionName?: string;

  @doc("The cloud, such as 'Global'")
  cloud?: string;

  @doc("The location type, such as 'Region'")
  locationType?: string;

  @doc("The region")
  region?: string;

  @doc("The sku group id")
  skuGroupId?: string;

  @doc("The zone, such as 'Zone 1'")
  zone?: string;

  @doc("The feature")
  feature?: string;

  @doc("The service type")
  serviceType?: string;

  @doc("Min quantity")
  minQuantity?: int32;

  @doc("Max quantity")
  maxQuantity?: int32;

  @doc("Value showing whether the plan is available for purchase through CSP channel. Possible values include \n- `OptIn` - Plan configured CSP program opt-in for any partner in the CSP Program\n- `OptOut` - Plan configured CSP program opt-out\n- `SelectiveOptIn` - Plan configured CSP program opt-in for specific partners in the CSP program ISV selects")
  cspState?: string;

  @doc("Indication whether the SKU supports reservations")
  hasRi?: boolean;

  @doc("The SKU attributes")
  skuAttributes?: Attribute[];

  @doc("The sku properties")
  skuProperties?: SkuProperties;

  @doc("SKU price related properties")
  offeringProperties?: OfferingProperties[];
}

@doc("The SKU properties, contains some of the attributes for faster OData filter")
model SkuProperties {
  @doc("The sku category")
  category?: string;

  @doc("The data disk type, such as 'Ssd'")
  dataDiskType?: string;

  @doc("The disk type, such as 'Ssd'")
  diskType?: string;

  @doc("The number of cores")
  numberOfCores?: string;

  @doc("The RAM")
  ram?: string;

  @doc("The number of virtual CPUs")
  vCpu?: string;

  @doc("The ARM SKU name")
  armSkuName?: string;

  @doc("The access tier, such as 'Standard'")
  accessTier?: string;
}

@doc("SKU price related properties")
model OfferingProperties {
  @doc("The product code (UPN)")
  productCode?: string;

  @doc("The term id")
  termId?: string;

  @doc("The meter type")
  meterType?: string;

  @doc("The billing meter id")
  billingMeterId?: string;

  @doc("The offering id")
  offeringId?: string;

  @doc("Entitlement, Consumption or Reservation")
  type?: string;
}

@doc("Returns a subset of Product attributes")
@resource("products")
model ProductSummary {
  @doc("Product display name")
  displayName?: string;

  @doc("Popularity of the product")
  popularity?: float64;

  @doc("Array of product categories")
  categoryIds?: string[];

  @doc("List of industry IDs the item belongs to")
  industryIds?: string[];

  @doc("Publisher id")
  publisherId?: string;

  @doc("Eligibility for Azure consumption commitment benefit. For more details see: https://docs.microsoft.com/en-us/marketplace/azure-consumption-commitment-benefit. Possible values include \n- `Eligible` - The product is eligible for Azure consumption commitment benefit\n- `NotEligible` - The product is not eligible for Azure consumption commitment benefit")
  azureBenefit?: string;

  @doc("Badge type. Possible values include \n- `PreferredSolution` - Preferred Solution badge\n- `PowerBICertified` - Power BI Certified badge\n- `AdditionalPurchaseRequirement` - Additional Purchase Requirement badge")
  badges?: string[];

  @doc("A value indicating whether this is a Microsoft or third party product. Possible values include \n- `Microsoft` - Product is published by Microsoft (1st party product)\n- `ThirdParty` - Product is published by Third Party Vendor")
  publisherType?: string;

  @doc("Product publishing stage. Possible values include \n- `Preview` - Product is available to restricted audience\n- `Public` - Product is publicly available in the Marketplace")
  publishingStage?: string;

  @key
  @visibility(Lifecycle.Read)
  @doc("Unique product identifier")
  uniqueProductId: string;

  @doc("The delivery method or deployment model. Possible values include \n- `None` - Default value\n- `DevService` - Dev Service\n- `ManagedApplication` - Managed Application plan type\n- `VirtualMachine` - Virtual Machine\n- `AzureApplication` - Azure Application\n- `Container` - Container\n- `SaaS` - Software as a Service\n- `SolutionTemplate` - Solution Template\n- `IotEdgeModules` - IoT Edge Module\n- `ManagedServices` - Managed Service\n- `ContainerApps` - Container App\n- `VisualStudioExtension` - Visual Studio Extension\n- `DynamicsOps` - Dynamics Operations\n- `DynamicsCE` - Dynamics CE\n- `DynamicsBC` - Dynamics Business Central\n- `PowerBI` - Power BI\n- `ConsultingServices` - Consulting Services\n- `CosellOnly` - Co-sell Only\n- `CoreVirtualMachine` - Core Virtual Machine\n- `PowerBIVisuals` - Power BI Visuals\n- `Office365` - Office 365\n- `AADApps` - Azure Active Directory Applications\n- `AzureServices` - Azure Services\n- `AppService` - App Service\n- `LogAnalytics` - Log Analytics\n- `MicrosoftProduct` - Microsoft Product")
  productType: string;

  @doc("Product sub type")
  productSubType?: string;

  @doc("Product Family")
  productFamily?: string;

  @doc("Operating system info for this product")
  operatingSystems?: string[];

  @doc("The pricing types for which this plan is designated. Possible values include \n- `Free` - Product has at least one plan that is free of charge\n- `FreeTrial` - Product has at least one plan that is free trial\n- `Byol` - Product has at least one plan that is bring your own license\n- `Payg` - Product has at least one plan that is Pay as you go\n- `Ri` - Product has at least one plan that is Reserved Instance billing model")
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

  @doc("Rating Bucket. Possible values include \n- `AboveOne` - Above one star rating\n- `AboveTwo` - Above two stars rating\n- `AboveThree` - Above three stars rating\n- `AboveFour` - Above four stars rating")
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

  @doc("The unique id of the product")
  productId?: string;

  @doc("Indication whether the product has plans with reservations")
  hasRiPlans?: boolean;

  @doc("Indication if product has a representation in the marketplace")
  hasMarketplaceFootprint?: boolean;

  @doc("Set of products attributes")
  attributes?: Attribute[];
}

@doc("Represents a SKU attribute, which consists of a key and value. The attributes may differ across various services.")
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

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "This inheritance is intentional for extending ProductSummary with additional details"
@doc("Summary description of the product")
@resource("product")
model ProductDetails extends ProductSummary {
  @doc("List of product videos")
  videos?: ProductVideo[];

  @doc("List of Images")
  images?: ImageGroup[];

  @doc("List of linked Add Ins provided for the item")
  linkedAddIns?: string[];

  @doc("List of Links provided for the item")
  links?: LinkProperties[];

  @doc("Dictionary of additional properties provided for the item")
  additionalProductProperties?: Record<string>;

  @doc("The product language")
  language?: string;

  @doc("A value indicating whether standard contract amendments are present")
  hasStandardContractAmendments?: boolean;

  @doc("The offer id")
  offerId?: string;

  @doc("Standard contract amendments for the product")
  standardContractAmendmentsRevisionId?: string;

  @doc("The universal amendment link for an enterprise contract")
  universalAmendmentUrl?: string;

  @doc("A value indicating whether the item is private")
  isPrivate: boolean;

  @doc("A value indicating whether sale of this item is stopped")
  isStopSell: boolean;

  @doc("Legal terms URI")
  legalTermsUri?: string;

  @doc("Supported legal terms type. Possible values include \n- `None` - No specific legal terms\n- `EA` - Microsoft Enterprise Agreement")
  legalTermsType?: string;

  @doc("Support uri of the product")
  supportUri?: string;

  @doc("User interface definition uri")
  uiDefinitionUri?: string;

  @doc("List of screenshot image URIs")
  screenshotUris?: string[];

  @doc("URI to the medium product icon")
  mediumIconUri?: string;

  @doc("URI to the large product icon")
  largeIconUri?: string;

  @doc("URI to the wide product icon")
  wideIconUri?: string;

  @doc("Pricing details uri of the product")
  pricingDetailsUri?: string;

  @doc("A value indicating whether microsoft is acting as a reseller")
  isReseller?: boolean;

  @doc("Product ownership selling motion")
  productOwnershipSellingMotion?: string;

  @doc("Indication to disable sending email on purchase")
  disableSendEmailOnPurchase?: boolean;

  @doc("Indicates if VM was originally CoreVirtualMachine")
  isCoreVm?: boolean;

  @doc("A StopSellInfo object providing stop sell related data")
  stopSellInfo?: StopSellInfo;

  @doc("Includes links to the learning and marketing materials as configured by the publisher")
  marketingMaterial?: MarketingMaterial;

  @doc("List of artifacts")
  artifacts?: Artifact[];

  // Override properties that differ from base class
  @doc("Full set of plan/SKU attributes")
  plans?: PlanDetails[];

  @doc("The unique id of the product")
  productId: string;
}

@doc("The sku")
model RelatedSku {
  @doc("The name")
  name?: string;

  @doc("The generation")
  generation?: string;

  @doc("The identity")
  identity?: string;
}

@doc("Pointing to a related SKU object")
model PlanSkuRelation {
  @doc("The Sku")
  sku?: RelatedSku;

  @doc("Relation Type")
  relationType?: string;
}

@doc("Additional metadata")
model PlanMetadata {
  @doc("The VM image generation (applicable to Virtual Machine products only)")
  generation?: string;

  @doc("Pointing to a planId which holds the alternative stack reference")
  altStackReference?: string;

  @doc("Pointing to a planId of plans that are related to this plan")
  relatedSkus?: PlanSkuRelation[];
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "This inheritance is intentional for extending PlanSummary with additional details"
@doc("Returns a subset of Plan attributes")
model PlanDetails extends PlanSummary {
  @doc("The id")
  id?: string;

  @doc("List of availabilities for this plan")
  availabilities?: Availability[];

  @doc("What blade to open when someone wants to create a marketplace item")
  uiDefinitionUri?: string;

  @doc("Files related to the marketplace item")
  artifacts?: Artifact[];

  @doc("Version of the marketplace item")
  version?: string;

  @doc("A value indicating whether the plan is hidden")
  isHidden: boolean;

  @doc("A value indicating whether plan has been stopped from selling")
  isStopSell: boolean;

  @doc("A StopSellInfo object providing stop sell related data")
  stopSellInfo?: StopSellInfo;

  @doc("Min quantity")
  minQuantity?: int32;

  @doc("Max quantity")
  maxQuantity?: int32;

  @doc("A value indicating whether the plan is quantifiable")
  isQuantifiable: boolean;

  @doc("Billing components")
  billingComponents?: BillingComponent[];

  @doc("List of purchase duration discounts")
  purchaseDurationDiscounts?: PurchaseDurationDiscount[];

  @doc("A value indicating whether the plan is used as hidden private offer requiring a quote")
  isHiddenPrivateOffer?: boolean;

  @doc("List of certifications")
  certifications?: LinkProperties[];

  @doc("Plan's customer instruction for purchasing")
  customerInstruction?: string;

  @doc("Plan labels")
  planLabels?: string[];

  @doc("SKU type")
  skuType?: string;

  @doc("Sku title localized")
  skuTitle?: string;

  @doc("SKU location")
  location?: string;

  @doc("The Arm region name")
  armRegionName?: string;

  @doc("Applicable cloud, such as 'Global'")
  cloud?: string;

  @doc("The location type, such as 'Region'")
  locationType?: string;

  @doc("The region")
  region?: string;

  @doc("The sku group id")
  skuGroupId?: string;

  @doc("The zone, such as 'Zone 1'")
  zone?: string;

  @doc("The feature, such as 'Spot'")
  feature?: string;

  @doc("The service type")
  serviceType?: string;

  @doc("Set of SKU attributes (varies per sku type), where each attribute is represented by a pair of key (attribute name) and value(attribute value)")
  skuAttributes?: Attribute[];

  @doc("The sku properties")
  skuProperties?: SkuProperties;

  @doc("SKU price related properties.")
  offeringProperties?: OfferingProperties[];
}

@doc("Returns a subset of Plan attributes")
model PlanSummary {
  @doc("Plan id")
  planId?: string;

  @doc("Unique plan Id which is prefixed by combining uniqueProductId and PlanId with no separator in between")
  uniquePlanId?: string;

  @doc("Display name of the plan / sku")
  displayName?: string;

  @doc("VM Architecture Type. Applicable to Virtual Machine products only. Possible values include \n- `X64Gen1` - The VM image architecture of the plan is X64 Generation1\n- `X64Gen2` - The VM image architecture of the plan is X64 Generation2\n- `Arm64` - The VM image architecture of the plan is Arm64")
  vmArchitectureType?: string;

  @doc("Value showing whether the plan is available for purchase through CSP channel. Possible values include \n- `OptIn` - Plan configured CSP program opt-in for any partner in the CSP Program\n- `OptOut` - Plan configured CSP program opt-out\n- `SelectiveOptIn` - Plan configured CSP program opt-in for specific partners in the CSP program ISV selects")
  cspState?: string;

  @doc("Expanded plan/SKU metadata.")
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

  @doc("The pricing types for which this plan is designated. Possible values include \n- `Free` - Product has at least one plan that is free of charge\n- `FreeTrial` - Product has at least one plan that is free trial\n- `Byol` - Product has at least one plan that is bring your own license\n- `Payg` - Product has at least one plan that is Pay as you go\n- `Ri` - Product has at least one plan that is Reserved Instance billing model")
  pricingTypes?: string[];

  @doc("VM security type. Applicable to Virtual Machine products only. Possible values include \n- `None` - Default value\n- `Trusted` - Trusted Launch security\n- `Confidential` - Confidential security")
  vmSecuritytypes?: string[];

  @doc("The plan summary text")
  summary?: string;

  @doc("Plan / sku description")
  description?: string;

  @doc("The SKU id")
  skuId?: string;

  @doc("The delivery method or deployment model. Possible values include \n- `None` - Default value\n- `DevService` - Dev Service\n- `ManagedApplication` - Managed Application plan type\n- `VirtualMachine` - Virtual Machine\n- `AzureApplication` - Azure Application\n- `Container` - Container\n- `SaaS` - Software as a Service\n- `SolutionTemplate` - Solution Template\n- `IotEdgeModules` - IoT Edge Module\n- `ManagedServices` - Managed Service\n- `ContainerApps` - Container App\n- `VisualStudioExtension` - Visual Studio Extension\n- `DynamicsOps` - Dynamics Operations\n- `DynamicsCE` - Dynamics CE\n- `DynamicsBC` - Dynamics Business Central\n- `PowerBI` - Power BI\n- `ConsultingServices` - Consulting Services\n- `CosellOnly` - Co-sell Only\n- `CoreVirtualMachine` - Core Virtual Machine\n- `PowerBIVisuals` - Power BI Visuals\n- `Office365` - Office 365\n- `AADApps` - Azure Active Directory Applications\n- `AzureServices` - Azure Services\n- `AppService` - App Service\n- `LogAnalytics` - Log Analytics\n- `MicrosoftProduct` - Microsoft Product")
  planType: string;

  @doc("The order the plan is displayed in the 'Plans' table")
  displayRank?: string;

  @doc("Indication that the plan is accessible to restricted audience only")
  isPrivate?: boolean;

  @doc("Indication whether the SKU supports reservations")
  hasRi?: boolean;
}

@doc("Plan level resources and configuration files")
model Artifact {
  @doc("Artifact name")
  name?: string;

  @doc("Artifact uri")
  uri?: string;

  @doc("The type of the artifact. Possible values include \n- `Template` - Contains link to the main ARM template\n- `Fragment` - Contains link to the nested ARM template\n- `Custom` - Custom artifact type\n- `Metadata` - Metadata artifact type")
  artifactType: string;
}

@doc("The percentage discount for 3rd party virtual machines software reservations")
model PurchaseDurationDiscount {
  @doc("The duration")
  duration?: string;

  @doc("The discount percentage")
  discountPercentage: float32;
}

@doc("Represents a model for stop sell related information")
model StopSellInfo {
  @doc("A value indicating when the sale of this item is going to be stopped")
  startDate?: utcDateTime;

  @doc("Reason for stopping to sell an item. Possible values include \n- `EndOfSupport` - End of support for the item\n- `SecurityIssue` - Security issue with the item\n- `Other` - Other reason")
  reason?: string;

  @doc("A value indicating an ID of an alternative offer provided by the same publisher")
  alternativeOfferId?: string;

  @doc("A value indicating an ID of an alternative plan of the same offer")
  alternativePlanId?: string;
}

@doc("Includes links to the learning and marketing materials as configured by the publisher")
model MarketingMaterial {
  @doc("Path to the marketing site")
  path?: string;

  @doc("Path to the learn site")
  learnUri?: string;
}

@doc("Represents a link item read from the gallery item package")
model LinkProperties {
  @doc("Id of the link")
  id?: string;

  @doc("Display name of the link")
  displayName?: string;

  @doc("Uri of the link")
  uri?: string;
}

@doc("Included quantity properties")
model IncludedQuantityProperty {
  @doc("Term id")
  termId?: string;

  @doc("Quantity")
  quantity?: string;
}

@doc("Applicable billing meter information")
model Meter {
  @doc("Meter id")
  meterId?: string;

  @doc("Compute part number")
  partNumber?: string;

  @doc("Consumption resource id")
  consumptionResourceId?: string;

  @doc("Retail price with currency")
  price?: Price;

  @doc("Type of this meter")
  type?: string;

  @doc("Included quantity properties")
  includedQuantityProperties?: IncludedQuantityProperty[];
}

@doc("Term description parameters")
model TermDescriptionParameter {
  @doc("Parameter")
  parameter?: string;

  @doc("Value")
  value?: string;
}

@doc("Proration policy")
model ProrationPolicy {
  @doc("Minimum prorated units")
  minimumProratedUnits?: string;
}

@doc("Renew Billing Plan")
model BillingPlan {
  @doc("Billing period")
  billingPeriod?: string;

  @doc("Title")
  title?: string;

  @doc("Description")
  description?: string;

  @doc("Retail price with currency")
  price?: Price;
}

@doc("Represents a billing component model")
model BillingComponent {
  @doc("Billing Tag")
  billingTag?: string;

  @doc("Custom Meter Ids")
  customMeterIds?: Record<int32[]>;
}

@doc("Applicable term")
model Term {
  @doc("Term description parameters")
  termDescriptionParameters?: TermDescriptionParameter[];

  @doc("Term id")
  termId?: string;

  @doc("Term unit")
  termUnit?: string;

  @doc("Proration policy")
  prorationPolicy?: ProrationPolicy;

  @doc("Term description")
  termDescription?: string;

  @doc("Retail price with currency")
  price?: Price;

  @doc("Renew term id")
  renewTermId?: string;

  @doc("Renew term units")
  renewTermUnits?: string;

  @doc("Billing Plan")
  billingPlan?: BillingPlan;

  @doc("Renew Billing Plan")
  renewToTermBillingPlan?: string;

  @doc("Indicates if autorenew is enabled")
  isAutorenewable?: boolean;
}

@doc("Availability for a given plan")
model Availability {
  @doc("The document id")
  id?: string;

  @doc("List of allowed actions")
  actions?: string[];

  @doc("Applicable billing meter information")
  meter?: Meter;

  @doc("Supported pricing audiences. Possible values include \n- `DirectCommercial` - Available to commercial direct channel\n- `PartnerCommercial` - Available to Cloud Solution Providers (CSP)")
  pricingAudience: string;

  @doc("List of applicable terms")
  terms?: Term[];

  @doc("A value indicating whether it has free trials")
  hasFreeTrials: boolean;

  @doc("Consumption unit type")
  consumptionUnitType?: string;

  @doc("Display rank")
  displayRank: int32;
}

@doc("Retail price with currency")
model Price {
  @doc("Currency code i.e. 'USD'")
  currencyCode?: string;

  @doc("A value indicating whether a payment instrument is required")
  isPiRequired: boolean;

  @doc("Retail price for the item")
  listPrice: float32;

  @doc("Manufacturer's suggested retail price for the item")
  msrp: float32;
}

@doc("Product Video")
model ProductVideo {
  @doc("Caption")
  caption?: string;

  @doc("Video uri")
  uri?: string;

  @doc("Video purpose")
  videoPurpose?: string;

  @doc("Preview image")
  previewImage?: PreviewImage;
}

@doc("Video preview image")
model PreviewImage {
  @doc("caption")
  caption?: string;

  @doc("uri")
  uri?: string;

  @doc("imagePurpose")
  imagePurpose?: string;
}

@doc("List of image objects")
model ImageGroup {
  @doc("context")
  context?: string;

  @doc("List of images")
  items?: Image[];
}

@doc("Includes link to the product image")
model Image {
  @doc("Image id")
  id?: string;

  @doc("Image uri")
  uri?: string;

  @doc("Image type")
  type?: string;
}

// ----------------------------------- The following section contains query param models --------------------------- //

// Market is required in some operations and not in others, so there are 2 models used
@doc("Marketplace Catalog API")
model SingleMarketParameter {
  @query
  @doc("Product market value. The response will include plans/availabilities that can be sold in the specified market\nPossible values can be found at https://docs.microsoft.com/en-us/azure/marketplace/marketplace-geo-availability-currencies. Example: 'US'")
  market: string;
}

@doc("Marketplace Catalog API")
model ListingMarketParameter {
  @query
  @doc("Product market value  (the response will include only products that can be sold in the specified market)\nPossible values can be found at https://docs.microsoft.com/en-us/azure/marketplace/marketplace-geo-availability-currencies. Example: 'US'")
  market?: string;
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

@doc("Indicates whether to exclude SKU details in the response. By default, excludeSkuDetails is set to FALSE.")
model ExcludeSkuDetailsParameter {
  @query
  @doc("Indicates whether to exclude SKU details in the response. By default, excludeSkuDetails is set to FALSE.")
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

@doc("Pricing audience query parameter")
model PricingAudienceParameter {
  @query
  @doc("Can be 'DirectCommercial' or 'PartnerCommercial', 'DirectCommercial' is the default")
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
  @doc("Expands related entities inline. Example: $expand=startingPrice")
  $expand?: string;
}

@doc("OData Expand parameter")
model OdataOrderByParameter {
  @query
  @doc("Ordering expression for the results using OData notation. Avoid using orderby unless essential as this may impact the latency of your request.  Example: $orderby=displayName desc.This API only supports ordering by a single field. Fields that can be ordered by are:\n- `lastModifiedDateTime`\n- `uniqueProductId`\n- `productType`\n- `displayName`\n- `publisherId`")
  $orderBy?: string;
}

// API key def
@doc("Use key provided by Marketplace Catalog Team as a parameter provided in the header. Details on obtaining the key can be found at https://learn.microsoft.com/en-us/rest/api/marketplacecatalog/resourcemanager/create-api-key?view=rest-marketplacecatalog-resourcemanager-2023-01-01-preview")
model DiscoveryApiKey is ApiKeyAuth<ApiKeyLocation.header, "X-API-Key">;
