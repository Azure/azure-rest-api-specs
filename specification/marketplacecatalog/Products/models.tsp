import "@typespec/rest";
import "@azure-tools/typespec-azure-core";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Products;

@doc("Eligibility for Azure consumption commitment benefit")
enum AzureBenefit {
  @doc("The product is eligible for Azure consumption commitment benefit")
  Eligible,

  @doc("The product is not eligible for Azure consumption commitment benefit")
  NotEligible,
}

@doc("Badge type")
enum Badge {
  @doc("Preferred Solution badge")
  PreferredSolution,

  @doc("Power BI Certified badge")
  PowerBICertified,

  @doc("Additional Purchase Requirement badge")
  AdditionalPurchaseRequirement,
}

@doc("Publisher type")
enum PublisherType {
  @doc("Product is published by Microsoft (1st party product)")
  Microsoft,

  @doc("Product is published by Third Party Vendor")
  ThirdParty,
}

@doc("Product publishing stage")
enum PublishingStage {
  @doc("Product is available to restricted audience")
  Preview,

  @doc("Product is publicly available in the Marketplace")
  Public,
}

@doc("Rating Bucket")
enum RatingBucket {
  @doc("Above one star rating")
  AboveOne,

  @doc("Above two stars rating")
  AboveTwo,

  @doc("Above three stars rating")
  AboveThree,

  @doc("Above four stars rating")
  AboveFour,
}

@doc("Legal terms type")
enum LegalTermsType {
  @doc("No specific legal terms")
  None,

  @doc("Microsoft Enterprise Agreement")
  EA,
}

@doc("VM Architecture Type")
enum VmArchitectureType {
  @doc("The VM image architecture of the plan is X64 Generation1")
  X64Gen1,

  @doc("The VM image architecture of the plan is X64 Generation2")
  X64Gen2,

  @doc("The VM image architecture of the plan is Arm64")
  Arm64,
}

@doc("Value showing whether the plan is available for purchase through CSP channel")
enum CspState {
  @doc("Plan configured CSP program opt-in for any partner in the CSP Program")
  OptIn,

  @doc("Plan configured CSP program opt-out")
  OptOut,

  @doc("Plan configured CSP program opt-in for specific partners in the CSP program ISV selects")
  SelectiveOptIn,
}

@doc("The pricing types for which this plan is designated")
enum PricingType {
  @doc("Product has at least one plan that is free of charge")
  Free,

  @doc("Product has at least one plan that is free trial")
  FreeTrial,

  @doc("Product has at least one plan that is bring your own license")
  Byol,

  @doc("Product has at least one plan that is Pay as you go")
  Payg,

  @doc("Product has at least one plan that is Reserved Instance billing model")
  Ri,
}

@doc("VM security type")
enum VmSecurityType {
  @doc("Default value")
  None,

  @doc("Trusted Launch security")
  Trusted,

  @doc("Confidential security")
  Confidential,
}

@doc("Delivery method or deployment model")
enum ProductType {
  @doc("Default value")
  None,

  @doc("Dev Service")
  DevService,

  @doc("Managed Application plan type")
  ManagedApplication,

  @doc("Virtual Machine")
  VirtualMachine,

  @doc("Azure Application")
  AzureApplication,

  @doc("Container")
  Container,

  @doc("Software as a Service")
  SaaS,

  @doc("Solution Template")
  SolutionTemplate,

  @doc("IoT Edge Module")
  IotEdgeModules,

  @doc("Managed Service")
  ManagedServices,

  @doc("Container App")
  ContainerApps,

  @doc("Visual Studio Extension")
  VisualStudioExtension,

  @doc("Dynamics Operations")
  DynamicsOps,

  @doc("Dynamics CE")
  DynamicsCE,

  @doc("Dynamics Business Central")
  DynamicsBC,

  @doc("Power BI")
  PowerBI,

  @doc("Consulting Services")
  ConsultingServices,

  @doc("Co-sell Only")
  CosellOnly,

  @doc("Core Virtual Machine")
  CoreVirtualMachine,

  @doc("Power BI Visuals")
  PowerBIVisuals,

  @doc("Office 365")
  Office365,

  @doc("Azure Active Directory Applications")
  AADApps,

  @doc("Azure Services")
  AzureServices,

  @doc("App Service")
  AppService,

  @doc("Log Analytics")
  LogAnalytics,

  @doc("Microsoft Product")
  MicrosoftProduct,
}

@doc("The type of the artifact")
enum ArtifactType {
  @doc("Contains link to the main ARM template")
  Template,

  @doc("Contains link to the nested ARM template")
  Fragment,

  @doc("Custom artifact type")
  Custom,

  @doc("Metadata artifact type")
  Metadata,
}

@doc("Supported pricing audiences")
union PricingAudience {
  @doc("Available to commercial direct channel")
  DirectCommercial: "DirectCommercial",

  @doc("Available to Cloud Solution Providers (CSP)")
  PartnerCommercial: "PartnerCommercial",

  string,
}

@doc("Reason for stopping to sell an item")
union StopSellReason {
  @doc("End of support for the item")
  EndOfSupport: "EndOfSupport",

  @doc("Security issue with the item")
  SecurityIssue: "SecurityIssue",

  @doc("Other reason")
  Other: "Other",

  string,
}

@doc("Summary description of the SKU")
model SkuSummary {
  @doc("The unique id of the product")
  productId?: string;

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

  @doc("Publisher type")
  publisherType?: PublisherType;

  @doc("The delivery method or deployment model")
  productType?: ProductType;

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

  @doc("CSP state")
  cspState?: CspState;

  @doc("Indication whether the SKU supports reservations")
  hasRI?: boolean;

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

  @doc("The Ram")
  ram?: string;

  @doc("The number of virtual CPUs")
  vCpu?: string;

  @doc("The Arm sku name")
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

  @doc("Eligibility for Azure consumption commitment benefit")
  azureBenefit?: AzureBenefit;

  @doc("The product badges")
  badges?: Badge[];

  @doc("Publisher type")
  publisherType?: PublisherType;

  @doc("Product publishing stage")
  publishingStage?: PublishingStage;

  @key
  @doc("Unique product identifier")
  uniqueProductId: string;

  @doc("The delivery method or deployment model")
  productType: ProductType;

  @doc("Product sub type")
  productSubType?: string;

  @doc("Product Family")
  productFamily?: string;

  @doc("Operating system info for this product")
  operatingSystems?: string[];

  @doc("The pricing types for this offer")
  pricingTypes?: PricingType[];

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

  @doc("Rating buckets")
  ratingBuckets?: RatingBucket[];

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
  hasRIPlans?: boolean;

  @doc("Indication if product has a representation in the marketplace")
  hasMarketplaceFootprint?: boolean;

  @doc("Set of products attributes")
  attributes?: Attribute[];
}

@doc("Represents a SKU attribute")
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

@doc("Summary description of the product")
model ProductDetails {
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

  @doc("Eligibility for Azure consumption commitment benefit")
  azureBenefit?: AzureBenefit;

  @doc("The product badges")
  badges?: Badge[];

  @doc("Publisher type")
  publisherType?: PublisherType;

  @doc("Product publishing stage")
  publishingStage?: PublishingStage;

  @doc("Unique product identifier")
  uniqueProductId?: string;

  @doc("The delivery method or deployment model")
  productType: ProductType;

  @doc("Product sub type")
  productSubType?: string;

  @doc("Product Family")
  productFamily?: string;

  @doc("Operating system info for this product")
  operatingSystems?: string[];

  @doc("The pricing types for this offer")
  pricingTypes?: PricingType[];

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

  @doc("Rating buckets")
  ratingBuckets?: RatingBucket[];

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
  productId: string;

  @doc("Indication if product has a representation in the marketplace")
  hasMarketplaceFootprint?: boolean;

  @doc("Set of products attributes")
  attributes?: Attribute[];

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

  @doc("CSP legal terms URI")
  cspLegalTermsUri?: string;

  @doc("Legal terms type")
  legalTermsType?: LegalTermsType;

  @doc("Uri to the privacy policy of the product")
  privacyPolicyUri?: string;

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
}

@doc("Related SKU")
model RelatedSku {
  @doc("The name")
  name?: string;

  @doc("The generation")
  generation?: string;

  @doc("The identity")
  identity?: string;
}

@doc("Related SKU relation")
model PlanSkuRelation {
  @doc("The Sku")
  sku?: RelatedSku;

  @doc("Relation Type")
  relationType?: string;
}

@doc("Plan/SKU metadata")
model PlanMetadata {
  @doc("The VM image generation (applicable to Virtual Machine products only)")
  generation?: string;

  @doc("Pointing to a planId which holds the alternative stack reference")
  altStackReference?: string;

  @doc("Pointing to a planId of plans that are related to this plan")
  relatedSkus?: PlanSkuRelation[];
}

@doc("Returns a subset of Plan attributes")
model PlanSummary {
  @doc("Plan id")
  planId?: string;

  @doc("Unique plan Id which is prefixed by combining uniqueProductId and PlanId with no separator in between")
  uniquePlanId?: string;

  @doc("Display name of the plan / sku")
  displayName?: string;

  @doc("VM Architecture Type. Applicable to Virtual Machine products only.")
  vmArchitectureType?: VmArchitectureType;

  @doc("Value showing whether the plan is available for purchase through CSP channel.")
  cspState?: CspState;

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

  @doc("The list of the pricing types for which this plan is designated")
  pricingTypes?: PricingType[];

  @doc("VM security types")
  vmSecuritytypes?: VmSecurityType[];

  @doc("The plan summary text")
  summary?: string;

  @doc("Plan / sku description")
  description?: string;

  @doc("The SKU id")
  skuId?: string;

  @doc("Managed Application or Solution template plan type")
  planType: ProductType;

  @doc("The order the plan is displayed in the 'Plans' table")
  displayRank?: string;

  @doc("Indication that the plan is accessible to restricted audience only")
  isPrivate?: boolean;

  @doc("Indication whether the SKU supports reservations")
  hasRI?: boolean;
}

@doc("Response page composed of a list of Product objects together with a next page link.")
model CatalogApiResponse {
  @doc("The list of returned items")
  items?: ProductSummary[];

  @doc("Link to the next page where request returns more than a single page of results")
  nextPageLink?: string;
}

@doc("Response page composed of a list of SKU Summaries together with a next page link")
model SkuApiResponse {
  @doc("The list of returned items")
  items?: SkuSummary[];

  @doc("Link to the next page where request returns more than a single page of results")
  nextPageLink?: string;
}

@doc("Plan level resources and configuration files")
model Artifact {
  @doc("The type of the artifact")
  artifactType: ArtifactType;
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

  @doc("A value indicating the reason for stopping to sell this item")
  reason?: StopSellReason;

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

  @doc("Supported pricing audiences")
  pricingAudience: PricingAudience;

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
  isPIRequired: boolean;

  @doc("Retail price for the item")
  listPrice: float32;

  @doc("Manufacturer's suggested retail price for the item")
  msrp: float32;
}
