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
  armRegionName: string;

  /** The cloud, such as 'Global'. */
  cloud: string;

  /** The location type, such as 'Region'. */
  locationType: string;

  /** The region. */
  region: string;

  /** The SKU group id. */
  skuGroupId: string;

  /** The zone, such as 'Zone 1'. */
  zone: string;

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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Property name matches existing API contract"
  hasRI?: boolean;

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
