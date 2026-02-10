import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace Microsoft.Marketplace;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read-only metadata resource."
@doc("Base model containing common product attributes shared between ProductSummary and ProductDetails")
model ProductBase {
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

  @doc("Indicates whether product purchases count toward Azure consumption commitment benefits for enterprise customers.\n- `Eligible` - Product costs apply to Azure consumption commitment benefit calculations and credits\n- `NotEligible` - Product costs do not qualify for Azure consumption commitment benefit programs")
  azureBenefit?: string;

  @doc("Displays certification and qualification badges earned by the product for marketplace visibility.\n- `PreferredSolution` - Microsoft-recognized solution meeting specific quality and partnership criteria\n- `PowerBICertified` - Certified compatibility and integration with Microsoft Power BI platform\n- `AdditionalPurchaseRequirement` - Product requires additional purchases or subscriptions for full functionality")
  badges?: string[];

  @doc("Identifies the publisher relationship to Microsoft for support and partnership classification.\n- `Microsoft` - First-party Microsoft product with direct Microsoft support and development\n- `ThirdParty` - Independent software vendor product with publisher-provided support and maintenance")
  publisherType?: string;

  @doc("Indicates the product availability status and customer access level within Azure Marketplace.\n- `Preview` - Limited availability to selected customers for testing and early access evaluation\n- `Public` - General availability to all Azure Marketplace customers for production deployment")
  publishingStage?: string;

  @key
  @visibility(Lifecycle.Read)
  @doc("Unique product identifier")
  uniqueProductId: string;

  @doc("Specifies the primary deployment model and hosting architecture for the marketplace product stored in the Marketplace Catalog.\n- `None` - Unspecified product type, typically used for products without a defined deployment model\n- `ManagedApplication` - Azure Managed Applications that deploy and manage resources in customer subscriptions\n- `VirtualMachine` - Pre-configured virtual machine images deployable to Azure compute infrastructure\n- `AzureApplication` - Native Azure applications leveraging platform services and APIs\n- `Container` - Containerized applications deployed through Azure Container Instances or similar services\n- `SaaS` - Software as a Service solutions hosted and managed by the publisher\n- `SolutionTemplate` - Azure Resource Manager templates that provision multiple Azure resources\n- `IotEdgeModules` - Modules designed for deployment to Azure IoT Edge runtime environments\n- `ManagedServices` - Fully managed services where the publisher handles infrastructure and operations\n- `ContainerApps` - Applications built for Azure Container Apps serverless container platform\n- `DynamicsOps` - Microsoft Dynamics 365 Finance and Operations applications and extensions\n- `DynamicsCE` - Microsoft Dynamics 365 Customer Engagement applications and customizations\n- `DynamicsBC` - Microsoft Dynamics 365 Business Central applications and add-ons\n- `PowerBI` - Microsoft Power BI reports, dashboards, and data visualization components\n- `ConsultingServices` - Professional services offerings including implementation and advisory services\n- `CosellOnly` - Products available exclusively through Microsoft co-sell partner programs\n- `CoreVirtualMachine` - Core virtual machine offerings with baseline Azure compute capabilities\n- `PowerBIVisuals` - Custom visualizations for Microsoft Power BI reporting platform\n- `Office365` - Microsoft 365 and Office 365 applications, add-ins, and integrations\n- `AADApps` - Azure Active Directory integrated applications supporting organizational identity\n- `AzureServices` - Native Azure platform services and resource providers\n- `AppService` - Web applications hosted on Azure App Service platform\n- `LogAnalytics` - Azure Monitor Log Analytics solutions and workspace configurations\n- `MicrosoftProduct` - First-party Microsoft products available through marketplace channels")
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
  @identifiers(#[])
  attributes?: Attribute[];
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read-only metadata resource."
@doc("Returns a subset of Product attributes")
model ProductSummary {
  ...ProductBase;

  @doc("Full set of plan/SKU attributes")
  @identifiers(#[])
  plans?: PlanSummary[];
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read-only metadata resource."
@doc("Returns the full set of Product attributes")
model ProductDetails {
  ...ProductBase;

  @doc("List of product videos")
  @identifiers(#[])
  videos?: ProductVideo[];

  @doc("List of Images")
  @identifiers(#[])
  images?: ImageGroup[];

  @doc("List of linked add ins provided for the item")
  linkedAddIns?: string[];

  @doc("List of Links provided for the item")
  links?: LinkProperties[];

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

  @doc("Indicates if a product is private")
  isPrivate: boolean;

  @doc("Indicates if a product is no longer available for sale")
  isStopSell: boolean;

  @doc("Legal terms URI")
  legalTermsUri?: string;

  @doc("Identifies the legal agreement framework governing product licensing and usage terms.\n- `None` - Standard marketplace terms apply without additional legal agreement requirements\n- `EA` - Microsoft Enterprise Agreement terms for volume licensing and enterprise customer deployments")
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

  @doc("Indicates if VM was originally a Core Virtual Machine")
  isCoreVm?: boolean;

  @doc("A StopSellInfo object providing stop sell related data")
  stopSellInfo?: StopSellInfo;

  @doc("Includes links to the learning and marketing materials as configured by the publisher")
  marketingMaterial?: MarketingMaterial;

  @doc("List of artifacts")
  @identifiers(#[])
  artifacts?: Artifact[];

  @doc("Full set of plan/SKU attributes")
  plans?: PlanDetails[];

  @doc("Indicates that the SKU has add-ons")
  hasAddOns?: boolean;
}

@doc("Returns a subset of Plan attributes")
model PlanSummary {
  @doc("Plan identifier")
  planId?: string;

  @doc("Unique plan identifier which is prefixed by combining uniqueProductId and PlanId with no separator in between")
  uniquePlanId?: string;

  @doc("Display name of the plan / sku")
  displayName?: string;

  @doc("Specifies the virtual machine processor architecture and generation. Applies exclusively to Virtual Machine product types.\n- `X64Gen1` - x64 processor architecture with Generation 1 virtual machine firmware and BIOS support\n- `X64Gen2` - x64 processor architecture with Generation 2 virtual machine firmware and UEFI support\n- `Arm64` - ARM 64-bit processor architecture optimized for energy efficiency and cloud-native workloads")
  vmArchitectureType?: string;

  @doc("Controls plan availability and partner access within the Microsoft Cloud Solution Provider (CSP) program.\n- `OptIn` - Enables all authorized Cloud Solution Provider partners to resell and deploy the product to customers\n- `OptOut` - Excluded from Cloud Solution Provider program, available only through direct channels\n- `SelectiveOptIn` - Available only to selected Cloud Solution Provider partners for resale and customer deployment")
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

  @doc("The order the plan is displayed in the 'Plans' table")
  displayRank?: string;

  @doc("Indication that the plan is accessible to restricted audience only")
  isPrivate?: boolean;

  @doc("Indication whether the SKU supports reservations")
  hasRi?: boolean;
}

@doc("Returns the full set of Plan attributes")
model PlanDetails {
  ...PlanSummary;

  @doc("The id")
  id?: string;

  @doc("List of availabilities for this plan")
  availabilities?: Availability[];

  @doc("What blade to open when someone wants to create a marketplace item")
  uiDefinitionUri?: string;

  @doc("Files related to the marketplace item")
  @identifiers(#[])
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
  @identifiers(#[])
  billingComponents?: BillingComponent[];

  @doc("List of purchase duration discounts")
  @identifiers(#[])
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
  @identifiers(#[])
  skuAttributes?: Attribute[];

  @doc("The sku properties")
  skuProperties?: SkuProperties;

  @doc("SKU price related properties.")
  @identifiers(#[])
  offeringProperties?: OfferingProperties[];

  @doc("Indicates if this SKU has consumption components")
  hasConsumptionComponents?: boolean;

  @doc("Indicates if this SKU is available for end users")
  isEndUserEligible?: boolean;

  @doc("Indicates if this SKU is available for admins")
  isAdminEligible?: boolean;

  @doc("The entra id version for products that come with entra id support")
  entraIdVersion?: string;

  @doc("Technical Requirements")
  technicalRequirements?: string;

  @doc("The URI to the FAQ page")
  faqUri?: string;

  @doc("Fulfillment instructions for this SKU")
  fulfillmentData?: FulfillmentData;

  @doc("Provides promotion data")
  @identifiers(#[])
  benefits?: Benefit[];

  @doc("Contains constraint product properties to determine eligibility")
  constraintsData?: ConstraintsData;

  @doc("Meter type descriptions")
  @identifiers(#[])
  meterTypeDescriptions?: MeterTypeDescription[];

  @doc("Usage unit")
  usageUnit?: string;

  @doc("Sku name")
  skuName?: string;
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

@doc("Represents a SKU attribute, which consists of a key and value. The attributes may differ across various services.")
model Attribute {
  @doc("The attribute key")
  key?: string;

  @doc("The attribute value")
  value?: string;
}

@doc("Additional metadata")
model PlanMetadata {
  @doc("The VM image generation (applicable to Virtual Machine products only)")
  generation?: string;

  @doc("Pointing to a planId which holds the alternative stack reference")
  altStackReference?: string;
}

@doc("Plan level resources and configuration files")
model Artifact {
  @doc("Artifact name")
  name?: string;

  @doc("Artifact uri")
  uri?: string;

  @doc("Defines the artifact resource type and its role in the marketplace offering deployment process.\n- `Template` - Primary Azure Resource Manager template containing the main deployment configuration\n- `Fragment` - Nested Azure Resource Manager template referenced by the primary template for modular deployments\n- `Custom` - Publisher-defined artifact with specialized deployment or configuration requirements\n- `Metadata` - Supplementary information and configuration data supporting the deployment process")
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

  @doc("Specifies the business or technical justification for discontinuing product sales in the marketplace.\n- `EndOfSupport` - Product lifecycle has reached end-of-support status with no further updates or maintenance\n- `SecurityIssue` - Critical security vulnerability or compliance issue requiring immediate sales suspension\n- `Other` - Alternative business reason not covered by standard discontinuation categories")
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

  @doc("Included quantity")
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
  @identifiers(#[])
  includedQuantityProperties?: IncludedQuantityProperty[];
}

@doc("Term description parameters")
model TermDescriptionParameter {
  @doc("Description parameter")
  parameter?: string;

  @doc("Parameter's value")
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

  @doc("Title of the billing plan")
  title?: string;

  @doc("Description of the billing plan")
  description?: string;

  @doc("Retail price with currency")
  price?: Price;
}

@doc("Represents a billing component model")
model BillingComponent {
  @doc("Billing Tag")
  billingTag?: string;
}

@doc("Applicable term")
model Term {
  @doc("Term description parameters")
  @identifiers(#["parameter", "value"])
  termDescriptionParameters?: TermDescriptionParameter[];

  @doc("Term id")
  termId?: string;

  @doc("Term unit")
  termUnit?: string;

  @doc("Defines the rules for calculating prorated charges or refunds for a subscription.")
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

  @doc("Defines the lifecycle management policy for the term")
  lifecyclePolicy?: LifecyclePolicy;

  @doc("Product code for this term")
  productCode?: string;

  @doc("Term state")
  state?: string;

  @doc("Term Actions")
  actions?: string[];
}

@doc("Availability for a given plan")
model Availability {
  @doc("The document id")
  id?: string;

  @doc("List of allowed actions")
  actions?: string[];

  @doc("Applicable billing meter information")
  meter?: Meter;

  @doc("Specifies the distribution channel and customer segment for product pricing and availability. Possible values:\n- `Direct-Commercial` - Available through direct Azure Marketplace purchases for commercial customers without intermediaries like partners or resellers\n- `Partner-Commercial` - Available through Cloud Solution Provider partner channel for reseller distribution")
  pricingAudience: string;

  @doc("List of applicable terms")
  @identifiers(#[])
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
  @doc("Video Caption")
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
  @doc("Image caption")
  caption?: string;

  @doc("Image uri")
  uri?: string;

  @doc("Purpose of the image")
  imagePurpose?: string;
}

@doc("List of image objects")
model ImageGroup {
  @doc("Context of the image group")
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

@doc("Contains fulfillment configuration and instructions")
model FulfillmentData {
  @doc("Differentiates between fulfillment types")
  fulfillmentType?: string;

  @doc("Fulfillment attributes")
  attributes?: FulfillmentAttributes;

  @doc("Bundled products included defining additional product/SKU combinations")
  @identifiers(#[])
  additionalProducts?: ProductFulfillmentConfig[];
}

@doc("Configuration for additional products bundled with early access pass SKUs")
model ProductFulfillmentConfig {
  @doc("Product and SKU ID for bundled products included with the license")
  productSkuId?: string;

  @doc("Quantity of the bundled product per license ")
  defaultKeyActivationCount?: int32;
}

@doc("Attributes that define fulfillment timing and delay handling")
model FulfillmentAttributes {
  @doc("Timing configuration for product fulfillment")
  fulfillmentTiming?: string;

  @doc("Mitigation explanation for delayed fulfillment")
  fulfillmentDelayMitigation?: string;
}

@doc("Benefit information for a plan")
model Benefit {
  @doc("Benefit type")
  benefitType?: string;

  @doc("Base plan ID")
  basePlanId?: string;

  @doc("Billing plan")
  billingPlan?: string;

  @doc("Term duration. Examples: 'P1M' (1 month), 'P30D' (30 days)")
  termDuration?: string;
}

@doc("Constraints data for a plan")
model ConstraintsData {
  @doc("Seat constraint configurations defining minimum and maximum seat limits")
  @identifiers(#[])
  seatConstraints?: MinMaxSeatsConstraint[];

  @doc("Asset ownership limits")
  @identifiers(#[])
  assetOwnershipLimits?: AssetOwnershipLimit[];

  @doc("Lists eligible prerequisite SKUs")
  prerequisiteSkus?: Prerequisites;
}

@doc("Defines minimum and maximum seat limits for a specific constraint type")
model MinMaxSeatsConstraint {
  @doc("Constraint type")
  type?: string;

  @doc("Minimum seats")
  minSeats?: int32;

  @doc("Maximum seats")
  maxSeats?: int32;
}

@doc("Minimum and maximum percentage seats constraint")
model MinMaxPercentageSeatsConstraint {
  @doc("Constraint type")
  type?: string;

  @doc("Minimum percent seats")
  minPercentSeats?: float64;

  @doc("Maximum percent seats")
  maxPercentSeats?: float64;
}

@doc("Defines ownership restrictions and limits for SKU assets")
model AssetOwnershipLimit {
  @doc("Limit type")
  type?: string;

  @doc("Minimum number of assets")
  minAssets?: int32;

  @doc("Maximum number of assets")
  maxAssets?: int32;
}

@doc("Defines prerequisite SKU requirements and seat constraints")
model Prerequisites {
  @doc("Prerequisite sets where all specified SKUs must be owned")
  @identifiers(#[])
  mustHaveAll?: PrerequisiteSet[];

  @doc("Prerequisite sets where any one of the specified SKUs must be owned")
  @identifiers(#[])
  mustHaveAny?: PrerequisiteSet[];

  @doc("Percentage-based seat constraints for prerequisite SKUs")
  @identifiers(#[])
  seatConstraints?: MinMaxPercentageSeatsConstraint[];
}

@doc("Prerequisite set")
model PrerequisiteSet {
  @doc("Product ID")
  productId?: string;

  @doc("SKU IDs")
  skuIds?: string[];
}

@doc("Meter type description")
model MeterTypeDescription {
  @doc("Meter Type Description key")
  key?: string;

  @doc("Meter type description value")
  value?: MeterTypeDescriptionValue;
}

@doc("Meter type description value")
model MeterTypeDescriptionValue {
  @doc("The type of meter")
  meterType?: string;

  @doc("The unit of measurement for the meter")
  unitOfMeasure?: string;
}

@doc("Defines lifecycle management policy")
model LifecyclePolicy {
  @doc("Grace period duration where customers retain access to their product. Examples: 'P1M' (1 month), 'P30D' (30 days), 'P0D' (0 days)")
  graceDuration?: string;

  @doc("Inactive period duration")
  inactiveDuration?: string;

  @doc("Lockout period duration")
  lockoutDuration?: string;
}
