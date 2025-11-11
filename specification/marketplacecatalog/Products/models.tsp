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

  @doc("Identifies the publisher relationship to Microsoft for support and partnership classification.\n- `Microsoft` - First-party Microsoft product with direct Microsoft support and development\n- `ThirdParty` - Independent software vendor product with publisher-provided support and maintenance")
  publisherType?: string;

  @doc("Specifies the primary deployment model and hosting architecture for the marketplace product. Currently supported values are:\n- `None` - Unspecified product type, typically used for products without a defined deployment model\n- `DevService` - Development-focused services and tools for software creation workflows\n- `ManagedApplication` - Azure Managed Applications that deploy and manage resources in customer subscriptions\n- `VirtualMachine` - Pre-configured virtual machine images deployable to Azure compute infrastructure\n- `AzureApplication` - Native Azure applications leveraging platform services and APIs\n- `Container` - Containerized applications deployed through Azure Container Instances or similar services\n- `SaaS` - Software as a Service solutions hosted and managed by the publisher\n- `SolutionTemplate` - Azure Resource Manager templates that provision multiple Azure resources\n- `IotEdgeModules` - Modules designed for deployment to Azure IoT Edge runtime environments\n- `ManagedServices` - Fully managed services where the publisher handles infrastructure and operations\n- `ContainerApps` - Applications built for Azure Container Apps serverless container platform\n- `VisualStudioExtension` - Extensions that integrate with Visual Studio IDE functionality\n- `DynamicsOps` - Microsoft Dynamics 365 Finance and Operations applications and extensions\n- `DynamicsCE` - Microsoft Dynamics 365 Customer Engagement applications and customizations\n- `DynamicsBC` - Microsoft Dynamics 365 Business Central applications and add-ons\n- `PowerBI` - Microsoft Power BI reports, dashboards, and data visualization components\n- `ConsultingServices` - Professional services offerings including implementation and advisory services\n- `CosellOnly` - Products available exclusively through Microsoft co-sell partner programs\n- `CoreVirtualMachine` - Core virtual machine offerings with baseline Azure compute capabilities\n- `PowerBIVisuals` - Custom visualizations for Microsoft Power BI reporting platform\n- `Office365` - Microsoft 365 and Office 365 applications, add-ins, and integrations\n- `AADApps` - Azure Active Directory integrated applications supporting organizational identity\n- `AzureServices` - Native Azure platform services and resource providers\n- `AppService` - Web applications hosted on Azure App Service platform\n- `LogAnalytics` - Azure Monitor Log Analytics solutions and workspace configurations\n- `MicrosoftProduct` - First-party Microsoft products available through marketplace channels")
  productType?: string;

  @doc("Denotes product sub group type, for example: 'Azure'")
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

  @doc("Controls plan availability and partner access within the Microsoft Cloud Solution Provider (CSP) program.\n- `OptIn` - Enables all authorized Cloud Solution Provider partners to resell and deploy the product to customers\n- `OptOut` - Excluded from Cloud Solution Provider program, available only through direct channels\n- `SelectiveOptIn` - Available exclusively to publisher-selected Cloud Solution Provider partners")
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

@doc("Sku object properties")
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

  @doc("Identifiers of categories associated with the product. Used for classification, filtering, and product discovery")
  categoryIds?: string[];

  @doc("Identifiers of industries associated with the product. Used for classification, filtering, and product discovery")
  industryIds?: string[];

  @doc("Publisher id")
  publisherId?: string;

  @doc("Indicates whether product purchases count toward Azure consumption commitment benefits for enterprise customers.\n- `Eligible` - Product costs apply to Azure consumption commitment benefit calculations and credits\n- `NotEligible` - Product costs do not qualify for Azure consumption commitment benefit programs")
  azureBenefit?: string;

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

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "This inheritance is intentional for extending ProductSummary with additional details"
@doc("Summary description of the product")
@resource("product")
model ProductDetails extends ProductSummary {
  @doc("List of product videos")
  videos?: ProductVideo[];

  @doc("List of Images")
  images?: ImageGroup[];

  @doc("List of linked add ins provided for the item")
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
  artifacts?: Artifact[];

  // Override properties that differ from base class
  @doc("Full set of plan/SKU attributes")
  plans?: PlanDetails[];
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

@doc("Pointing to a related SKU object")
model PlanSkuRelation {
  @doc("The related Sku")
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

  @doc("Other plans that may be related to this plan")
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

  @doc("Indicates if a product is hidden")
  isHidden: boolean;

  @doc("Indicates if a plan is no longer available for sale")
  isStopSell: boolean;

  @doc("A StopSellInfo object providing stop sell related data")
  stopSellInfo?: StopSellInfo;

  @doc("A value indicating whether the plan is quantifiable")
  isQuantifiable: boolean;

  @doc("Pan billing components")
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

  @doc("Sku type")
  skuType?: string;

  @doc("Sku title localized")
  skuTitle?: string;

  @doc("Sku location")
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

  @doc("SKU price related properties")
  offeringProperties?: OfferingProperties[];
}

@doc("Returns a subset of Plan attributes")
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

@doc("The parameters of the term description")
model TermDescriptionParameter {
  @doc("Parameter")
  parameter?: string;

  @doc("Value")
  value?: string;
}

@doc("Defines the rules for calculating prorated charges or refunds for a subscription")
model ProrationPolicy {
  @doc("Specifies the smallest time unit (ISO 8601 duration) used in proration, e.g., P1D for one day")
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
  @doc("The parameters of the term description")
  termDescriptionParameters?: TermDescriptionParameter[];

  @doc("Term id")
  termId?: string;

  @doc("Term unit")
  termUnit?: string;

  @doc("Defines the rules for calculating prorated charges or refunds for a subscription")
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

  @doc("Specifies the distribution channel and customer segment for product pricing and availability")
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

  @doc("Video preview image")
  previewImage?: PreviewImage;
}

@doc("Video preview image")
model PreviewImage {
  @doc("Preview image caption")
  caption?: string;

  @doc("Preview image uri")
  uri?: string;

  @doc("Preview image purpose")
  imagePurpose?: string;
}

@doc("List of image objects")
model ImageGroup {
  @doc("Image group context")
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
  @doc("Product market value. The response will include plans/availabilities that can be sold in the specified market. Based on ISO-3166 format. Possible values can be found at https://docs.microsoft.com/en-us/azure/marketplace/marketplace-geo-availability-currencies. Example: 'US'")
  market: string;
}

@doc("Marketplace Catalog API")
model ListingMarketParameter {
  @query
  @doc("Product market value. The response will include only products that can be sold in the specified market. Based on ISO-3166 format. Possible values can be found at https://docs.microsoft.com/en-us/azure/marketplace/marketplace-geo-availability-currencies. Example: 'US'")
  market?: string;
}

@doc("Marketplace Catalog API")
model ListingSkusMarketParameter {
  @query
  @doc("Market value. The response will include only skus that can be sold in the specified market. Based on ISO-3166 format. Possible values can be found at https://docs.microsoft.com/en-us/azure/marketplace/marketplace-geo-availability-currencies. Example: 'US'")
  market?: string;
}

@doc("Parameters for language selection")
model LanguageParameter {
  @query
  @doc("Language to search, ISO 639-1 two-letter code, possible values - 'en,cs,de,es,fr,hu,it,ja,ko,nl,pl,pt-br,pt-pt,ru,sv,tr,id,zh-hans,zh-hant'. Default is \"en\"")
  language?: string = "en";
}

@doc("Parameters for location filtering")
model LocationsSingleParameter {
  @query
  @doc("Return plans/availabilities for selected location. For more information on Azure datacenter regions see: https://azure.microsoft.com/regions/")
  locations?: string[];
}

@doc("Parameters for location filtering")
model LocationsListingParameter {
  @query
  @doc("Return products available in selected location. For more information on Azure datacenter regions see: https://azure.microsoft.com/regions/")
  locations?: string[];
}

@doc("Parameters for location filtering")
model SkusLocationsListingParameter {
  @query
  @doc("Return skus available in selected location. For more information on Azure datacenter regions see: https://azure.microsoft.com/regions/")
  locations?: string[];
}

@doc("Parameters for preview product keys")
model HideKeysParameter {
  @query
  @doc("This key is utilized to retrieve preview products and is generated within the Partner Center during the offer publishing process")
  hideKeys?: string[];
}

@doc("Indicates whether to include in the response the product's plans/SKUs that are no longer available for purchase. By default, includeStopSoldPlans is set to FALSE")
model IncludeStopSoldPlansParameter {
  @query
  @doc("Indicates whether to include in the response the product's plans/SKUs that are no longer available for purchase. By default, includeStopSoldPlans is set to FALSE")
  includeStopSoldPlans?: boolean = false;
}

@doc("Indicates whether to exclude SKU details in the response. By default, excludeSkuDetails is set to FALSE")
model ExcludeSkuDetailsParameter {
  @query
  @doc("Indicates whether to exclude SKU details in the response. By default, excludeSkuDetails is set to FALSE")
  excludeSkuDetails?: boolean = false;
}

@doc("Include future availabilities parameter")
model IncludeFutureAvailabilitiesParameter {
  @query
  @doc("Indicates whether to include the product's plans/SKU availabilities with future dates in the response. By default, includeFutureAvailabilities is set to FALSE")
  includeFutureAvailabilities?: boolean = false;
}

@doc("SKU ID filter parameter")
model SkuIdParameter {
  @query
  @doc("Apply SKU Id filter to the result")
  skuId?: string;
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
@doc("Products OData Filter parameter")
model ProductsOdataFilterParameter {
  @query
  @doc("Filters the results, based on a Boolean condition. Example: $filter=productType eq 'VirtualMachine'. Note that not all fields support filtering. Fields that can be filtered by are:\n- `displayName`\n- `productId`\n- `popularity`\n- `categoryIds`\n- `industryIds`\n- `publisherId`\n- `uniqueProductId`\n- `productType`\n- `operatingSystems`\n- `pricingTypes`\n- `publisherDisplayName`\n- `longSummary`\n- `summary`\n- `linkedAddinsTypes`\n- `description`\n- `supportedProducts`\n- `applicableProducts`\n- `lastModifiedDateTime`\n- `plan.planId`\n- `plan.displayName`\n- `plan.cspState`\n- `plan.altStackReference`\n- `plan.stackType`\n- `plan.categoryIds`\n- `plan.hasProtectedArtifacts`\n- `plan.pricingTypes`\n- `plan.summary`\n- `plan.description`\n- `plan.skuId`\n- `plan.displayRank`\n- `plan.isPrivate`")
  $filter?: string;
}

@doc("Skus OData Filter parameter")
model SkusOdataFilterParameter {
  @query
  @doc("Filters the results, based on a Boolean condition. Example: $filter=productType eq 'VirtualMachine'. Note that not all fields support filtering")
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

@doc("Products OData Expand parameter")
model ProductsOdataOrderByParameter {
  @query
  @doc("Ordering expression for the results using OData notation. Avoid using orderby unless essential as this may impact the latency of your request.  Example: $orderby=displayName desc.This API only supports ordering by a single field. Fields that can be ordered by are:\n- `lastModifiedDateTime`\n- `uniqueProductId`\n- `productType`\n- `displayName`\n- `publisherId`")
  $orderBy?: string;
}

@doc("Skus OData Expand parameter")
model SkusOdataOrderByParameter {
  @query
  @doc("Ordering expression for the results using OData notation. Avoid using orderby unless essential as this may impact the latency of your request.  Example: $orderby=productDisplayName desc.This API only supports ordering by a single field. Note that not all fields currently support orderBy")
  $orderBy?: string;
}

// PageResult
@doc("Paged productSummary response result from discovery API")
model DiscoveryApiPagedProductsResult {
  @pageItems
  @doc("List of items in the current page")
  value: ProductSummary[];

  @nextLink
  @doc("Link to the next page of results, if available")
  nextLink?: string;
}

@doc("Paged skuSummary response result from discovery API")
model DiscoveryApiPagedSkusResult {
  @pageItems
  @doc("List of items in the current page")
  value: SkuSummary[];

  @nextLink
  @doc("Link to the next page of results, if available")
  nextLink?: string;
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
