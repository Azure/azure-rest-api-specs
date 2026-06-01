import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace Microsoft.Marketplace;

// ============================================================================
// Referenced Models
// ============================================================================

/** Key-value attribute pair. */
model Attribute {
  /** The attribute key. */
  key?: string;

  /** The attribute value. */
  value?: string;
}

/** SKU properties, can be different per each service family. */
model SkuProperties {
  /** The SKU category. */
  category?: string;

  /** The data disk type, such as 'Ssd'. */
  dataDiskType?: string;

  /** The disk type, such as 'Ssd'. */
  diskType?: string;

  /** The number of cores. */
  numberOfCores?: string;

  /** The RAM. */
  ram?: string;

  /** The number of virtual CPUs. */
  vCpu?: string;

  /** The ARM SKU name. */
  armSkuName?: string;

  /** The access tier, such as 'Standard'. */
  accessTier?: string;
}

/** Offering properties such as: product code (UPN), term id, meter type, offering id. */
model OfferingProperties {
  /** The meter type. */
  meterType?: string;

  /** The billing meter id. */
  billingMeterId?: string;

  /** The offering id. */
  offeringId?: string;

  /** The product code (UPN). */
  productCode?: string;

  /** The term id. */
  termId?: string;

  /** The pricing property type (e.g., Consumption, Reservation, Entitlement). */
  type?: string;
}

/** Product-level alternate ids (product id without SKU id), used for OData lookup on SKUs of a specific product. */
model ProductAlternateIds {
  /** Applicable promotion product identifiers. */
  applicablePromotion?: string[];

  /** Add-on parent product identifiers. */
  addOnParent?: string[];

  /** Applicable future price concession product identifiers. */
  applicableFuturePriceConcession?: string[];

  /** Benefit SKU product identifiers. */
  benefitSku?: string[];

  /** Included in bundle product identifiers. */
  includedInBundle?: string[];

  /** Associated SKU product identifiers. */
  associatedSku?: string[];
}

/** Alternate ids for the SKU. */
model SkuAlternateIds {
  /** AAD SKU identifiers. */
  aadSkuId?: string[];

  /** Legacy offer GUID identifiers. */
  legacyOfferGuid?: string[];

  /** Applicable promotion identifiers. */
  applicablePromotion?: string[];

  /** Add-on parent identifiers. */
  addOnParent?: string[];

  /** Applicable future price concession identifiers. */
  applicableFuturePriceConcession?: string[];

  /** Benefit SKU identifiers. */
  benefitSku?: string[];

  /** Included in bundle identifiers. */
  includedInBundle?: string[];

  /** Associated SKU identifiers. */
  associatedSku?: string[];

  /** Product-level alternate ids (product id without SKU id), used for OData lookup on SKUs of a specific product. */
  products?: ProductAlternateIds;
}

// ============================================================================
// Main Model
// ============================================================================

/** Summary description of the SKU. */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read-only metadata resource."
model SkuSummary {
  // --- Product properties ---

  /** The unique id of the product. */
  productId: string;

  /** Product display name. */
  productDisplayName?: string;

  /** The product description text. */
  productDescription?: string;

  /** The service family of the product, such as 'Compute'. */
  serviceFamily?: string;

  /** The service name of the product, such as 'Virtual Machines'. */
  service?: string;

  /** Publisher id. */
  publisherId?: string;

  /** Identifies the publisher relationship to Microsoft for support and partnership classification.\n- `Microsoft` - First-party Microsoft product with direct Microsoft support and development\n- `ThirdParty` - Independent software vendor product with publisher-provided support and maintenance */
  publisherType?: string;

  /** Offer type. */
  productType?: string;

  /** Product sub type. */
  productSubType?: string;

  /** Product summary. */
  summary?: string;

  /** The product attributes. */
  @identifiers(#[])
  productAttributes?: Attribute[];

  // --- SKU properties ---

  /** SKU name. */
  skuName: string;

  /** SKU id. */
  @key
  @visibility(Lifecycle.Read)
  skuId: string;

  /** SKU type. */
  skuType: string;

  /** Language code for the SKU content. */
  language: string;

  /** SKU description localized. */
  skuDescription: string;

  /** SKU title localized. */
  skuTitle: string;

  /** Latest update date of the SKU. */
  lastModifiedDateTime?: string;

  /** Location (region). */
  location: string;

  /** The ARM region name. */
  armRegionName?: string;

  /** The cloud, such as 'Global'. */
  cloud: string;

  /** The location type, such as 'Region'. */
  locationType: string;

  /** The region. */
  region?: string;

  /** The SKU group id. */
  skuGroupId?: string;

  /** The zone, such as 'Zone 1'. */
  zone?: string;

  /** The feature. */
  feature?: string;

  /** The service type. */
  serviceType?: string;

  /** Minimum order quantity. */
  minQuantity?: int32;

  /** Maximum order quantity. */
  maxQuantity?: int32;

  /** Controls plan availability and partner access within the Microsoft Cloud Solution Provider (CSP) program.\n- `OptIn` - Enables all authorized Cloud Solution Provider partners to resell and deploy the product to customers\n- `OptOut` - Excluded from Cloud Solution Provider program, available only through direct channels\n- `SelectiveOptIn` - Available only to selected Cloud Solution Provider partners for resale and customer deployment */
  cspState?: string;

  /** A value indicating whether the SKU supports reservations. */
  hasRi?: boolean;

  /** The SKU attributes. */
  @identifiers(#[])
  skuAttributes?: Attribute[];

  /** The SKU properties. */
  skuProperties?: SkuProperties;

  /** Offering properties such as: product code (UPN), term id, meter type, offering id. */
  @identifiers(#[])
  offeringProperties?: OfferingProperties[];

  /** Alternate ids for the SKU. */
  alternateIds?: SkuAlternateIds;

  /** Offering type of product family Offers. */
  offeringType?: string;

  /** Category IDs for this SKU. */
  categoryIds?: string[];
}

// ============================================================================
// Availability Models
// ============================================================================

/** Retail price with currency */
model Price {
  /** Currency code i.e. 'USD' */
  currencyCode?: string;

  /** A value indicating whether a payment instrument is required */
  isPiRequired: boolean;

  /** Retail price for the item */
  listPrice: float32;

  /** Manufacturer's suggested retail price for the item */
  msrp: float32;
}

/** Included quantity properties for a meter */
model IncludedQuantityProperty {
  /** Term id */
  termId?: string;

  /** Included quantity */
  quantity?: string;
}

/** Applicable billing meter information */
model Meter {
  /** Meter id */
  meterId?: string;

  /** Compute part number */
  partNumber?: string;

  /** Consumption resource id */
  consumptionResourceId?: string;

  /** Retail price with currency */
  price?: Price;

  /** Type of this meter */
  type?: string;

  /** Included quantity properties */
  @identifiers(#[])
  includedQuantityProperties?: IncludedQuantityProperty[];
}

/** Term description parameters */
model TermDescriptionParameter {
  /** Description parameter */
  parameter?: string;

  /** Parameter's value */
  value?: string;
}

/** Proration policy */
model ProrationPolicy {
  /** Minimum prorated units */
  minimumProratedUnits?: string;
}

/** Renew Billing Plan */
model BillingPlan {
  /** Billing period */
  billingPeriod?: string;

  /** Title of the billing plan */
  title?: string;

  /** Description of the billing plan */
  description?: string;

  /** Retail price with currency */
  price?: Price;
}

/** Defines the lifecycle management policy for the term */
model LifecyclePolicy {
  /** Grace period duration where customers retain access to their product. Examples: 'P1M' (1 month), 'P30D' (30 days), 'P0D' (0 days) */
  graceDuration?: string;

  /** Inactive period duration */
  inactiveDuration?: string;

  /** Lockout period duration */
  lockoutDuration?: string;
}

/** Applicable term */
model Term {
  /** Term description parameters */
  @identifiers(#["parameter", "value"])
  termDescriptionParameters?: TermDescriptionParameter[];

  /** Term id */
  termId?: string;

  /** Term unit */
  termUnit?: string;

  /** Defines the rules for calculating prorated charges or refunds for a subscription. */
  prorationPolicy?: ProrationPolicy;

  /** Term description */
  termDescription?: string;

  /** Retail price with currency */
  price?: Price;

  /** Renew term id */
  renewTermId?: string;

  /** Renew term units */
  renewTermUnits?: string;

  /** Billing Plan */
  billingPlan?: BillingPlan;

  /** Renew Billing Plan */
  renewToTermBillingPlan?: string;

  /** Indicates if autorenew is enabled */
  isAutorenewable?: boolean;

  /** Defines the lifecycle management policy for the term */
  lifecyclePolicy?: LifecyclePolicy;

  /** Product code for this term */
  productCode?: string;

  /** Term state */
  state?: string;

  /** Term Actions */
  actions?: string[];
}

/** Availability for a given plan */
model Availability {
  /** The document id */
  id?: string;

  /** List of allowed actions */
  actions?: string[];

  /** Applicable billing meter information */
  meter?: Meter;

  /** Specifies the distribution channel and customer segment for product pricing and availability. Possible values:\n- `Direct-Commercial` - Available through direct Azure Marketplace purchases for commercial customers without intermediaries like partners or resellers\n- `Partner-Commercial` - Available through Cloud Solution Provider partner channel for reseller distribution */
  pricingAudience: string;

  /** List of applicable terms */
  @identifiers(#[])
  terms?: Term[];

  /** A value indicating whether it has free trials */
  hasFreeTrials: boolean;

  /** Consumption unit type */
  consumptionUnitType?: string;

  /** Display rank */
  displayRank: int32;
}

/**
 * Detailed description of the SKU. Inherits all properties of `SkuSummary`
 * and adds the hydrated `availabilities` collection (filtered by the billing
 * account's eligibility).
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "SkuDetails intentionally extends SkuSummary to produce allOf in the OpenAPI output."
model SkuDetails extends SkuSummary {
  /** Availabilities for this SKU. */
  @identifiers(#[])
  availabilities?: Availability[];
}
