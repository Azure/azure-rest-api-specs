import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Commerce;

/**
 * Ownership classification of a product. Indicates whether the product is
 * owned by Microsoft (first-party) or by a third-party publisher.
 */
union UpnOwnership {
  string,

  /** First-party (Microsoft-owned) product. */
  "1PP",

  /** Third-party (publisher-owned) product. */
  "3PP",
}

/** The commercial type of a SKU. */
union SkuType {
  string,

  /** Consumption-based SKU (pay-as-you-go). */
  Consumption: "consumption",

  /** Subscription-based SKU. */
  Subscription: "subscription",

  /** One-time purchase SKU. */
  OneTime: "one_time",
}

/**
 * Fragment names that can be requested via the `fragments` query parameter
 * on UPN read operations. Each fragment is an opt-in subtree exposed under
 * `properties.{fragmentName}` in the response.
 */
union UpnFragment {
  string,

  /** Listing and catalog-presentation fragment. */
  Listing: "listing",

  /** List / retail / rate-card pricing fragment (not customer-negotiated pricing). */
  Pricing: "pricing",

  /** Purchase flow configuration fragment. */
  Purchase: "purchase",

  /** Lifecycle metadata fragment. */
  Lifecycle: "lifecycle",

  /** Display metadata fragment. */
  Display: "display",

  /** Tax configuration fragment. */
  Tax: "tax",

  /** Term and billing-plan fragment. */
  Term: "term",

  /** Benefits fragment. */
  Benefits: "benefits",

  /** Bundle composition fragment. */
  Bundle: "bundle",

  /** Eligibility predicates fragment. */
  Eligibility: "eligibility",

  /** Compact channel/market/salesMotion permutations fragment. */
  Permutations: "permutations",

  /** Catalog tags fragment. */
  Tags: "tags",

  /** Search keywords fragment. */
  Search: "search",

  /** Financial classification fragment. */
  Financial: "financial",

  /** External identifiers fragment. */
  ExternalIds: "externalIds",
}

/** Unit metadata associated with a value exchange. */
model ValueExchangeUnit {
  /** A human-readable hint describing the unit (for example, "vCPU Duration - 1 Hour"). */
  hint?: string;
}

/** Dimension metadata associated with a value exchange. */
model ValueExchangeDimensions {
  /** The location dimension (for example, an Azure region). */
  location?: string;

  /** The feature dimension (for example, a product feature name). */
  feature?: string;
}

/**
 * Value-exchange (UPN identity) metadata. The value exchange is the leaf of
 * the OCP Product -> SKU -> Value Exchange hierarchy and is the transactable
 * identity addressed by this resource.
 */
model ValueExchange {
  /** The stable identifier of the value exchange. */
  id: string;

  /** Unit metadata for the value exchange. */
  unit?: ValueExchangeUnit;

  /** Dimension metadata for the value exchange. */
  dimensions?: ValueExchangeDimensions;
}

/**
 * Denormalized product summary embedded in a UPN. Only identifying and
 * discovery-relevant product fields are exposed here; the full product
 * document is not retrievable as a separate resource type.
 */
model ProductSummary {
  /** The stable product identifier. */
  id: string;

  /** The human-readable friendly name of the product. */
  friendlyName?: string;

  /** The offer template identifier for this product (for example, "offer-template/az-generic"). */
  template?: string;

  /** Discovery tags associated with the product. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Product tags are free-form discovery metadata sourced from the upstream BigCat catalog; the key set is unbounded and cannot be modeled as an explicit type."
  tags?: Record<string>;

  /** Ownership classification of the product. */
  ownership?: UpnOwnership;
}

/**
 * Denormalized SKU summary embedded in a UPN. Only identifying and
 * discovery-relevant SKU fields are exposed here.
 */
model SkuSummary {
  /** The stable SKU identifier. */
  id: string;

  /** The human-readable friendly name of the SKU. */
  friendlyName?: string;

  /** The commercial type of the SKU. */
  type?: SkuType;
}

/**
 * Properties of a UPN (Unified Product Node) resource. A UPN is the
 * transactable catalog identity and carries denormalized product and SKU
 * summaries plus the value-exchange identity.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "UPN is a read-only catalog projection synthesized from the upstream BigCat feed; no ARM provisioning lifecycle applies. The resource has no create/update/delete operations and therefore no provisioning state to track."
model UpnProperties {
  /** The value-exchange identity that this UPN represents. */
  valueExchange: ValueExchange;

  /** Denormalized product summary. */
  product: ProductSummary;

  /** Denormalized SKU summary. */
  sku: SkuSummary;

  /** The offer-template identifier for this UPN (for example, "offer-template/az-vm"). */
  template?: string;
}

/**
 * Optional query parameter that allows callers to opt in to fragment
 * subtrees on UPN read operations. The value is a comma-separated list of
 * fragment names (see `UpnFragment`), or `*` to request all fragments.
 * Default (omitted) returns only the identity envelope.
 */
model FragmentsQueryParameter {
  /**
   * A comma-separated list of fragment names to include in the response,
   * or `*` to include all fragments. Example: `pricing,permutations,display`.
   */
  @query("fragments")
  fragments?: string;
}
