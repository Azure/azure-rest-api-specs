import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.ProfessionalService;

/** Professional Service resource properties for GA API version 2026-05-01. */
model ProfessionalServiceResourceProperties {
  /** The status of the last provisioning operation performed on the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProfessionalServiceProvisioningState;

  /** The Professional Service asset identifier. Server-assigned unique identifier for the marketplace subscription. */
  @visibility(Lifecycle.Read)
  assetId?: string;

  /** Optional description. Used as subscription display name by Teams, Admin Center, and other consumers. */
  description?: string;

  /** The Professional Service subscription status. Server-assigned. */
  @visibility(Lifecycle.Read)
  status?: ProfessionalServiceResourceStatus;

  /** The reason for the current status. Server-assigned. */
  @visibility(Lifecycle.Read)
  statusReason?: SubscriptionStatusReason;

  /** The seat count. */
  quantity?: int64;

  /** The publisher name. Server-resolved from ProductCode. */
  @visibility(Lifecycle.Read)
  publisherName?: string;

  /** The plan name. Server-resolved from ProductCode. */
  @visibility(Lifecycle.Read)
  planName?: string;

  /** The offer name. Server-resolved from ProductCode. */
  @visibility(Lifecycle.Read)
  offerName?: string;

  /** The term unit (ISO 8601 duration, for example P1M or P1Y). Server-resolved from ProductCode. */
  @visibility(Lifecycle.Read)
  termUnit?: string;

  /** The billing period (ISO 8601 duration). Server-resolved from ProductCode. */
  @visibility(Lifecycle.Read)
  billingPeriod?: string;

  /** The risk property bag header (JSON format). Write-only — not returned in GET responses. */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
  riskPropertyBagHeader?: string;

  /** The start date of the current term. Server-calculated. */
  @visibility(Lifecycle.Read)
  termStartDate?: utcDateTime;

  /** The end date of the current term. Server-calculated. */
  @visibility(Lifecycle.Read)
  termEndDate?: utcDateTime;

  /** The future start date of the subscription commitment, when available. Server-calculated. */
  @visibility(Lifecycle.Read)
  futureStartDate?: utcDateTime;

  /** Whether the Professional Service subscription will auto-renew upon term end. */
  autoRenew?: boolean;

  /** Whether the current term is a free trial term. Server-determined. */
  @visibility(Lifecycle.Read)
  isFreeTrial?: boolean;

  /** The storefront. */
  storefront?: string;

  /**
   * The purchaser email. Server-derived from authenticated identity. Read-only.
   *
   * Customer data (PII): NEVER returned in `List` (`listByResourceGroup`,
   * `listByAzureSubscription`), `PUT`, `PATCH`, or default point `GET` responses, so
   * Azure Resource Graph and control-plane caches never receive or store PII. Returned
   * exclusively on single-resource point `GET` when the caller explicitly passes
   * `$expandCustomerData=true` (per `ARG002`). Present as an optional property on the
   * shared resource model because `RPC-Get-V1-10` requires collection `GET` `value[]`
   * to use the same resource schema as point `GET`. Callers requesting customer data
   * must have appropriate authorization and handle the value per GDPR requirements.
   *
   * `@secret` is applied so SDK generators emit `format: password`, ensuring the value
   * is redacted in logs, CLI output, and diagnostic traces.
   */
  @visibility(Lifecycle.Read)
  @secret
  purchaserEmail?: string;

  /** The quote identifier associated with the purchase. */
  quoteId?: string;

  /** The private offer identifier. */
  privateOfferId?: string;

  /** The product code. Primary purchase identifier for GA — used to resolve term details server-side. */
  productCode: string;

  /**
   * Optional campaign attribution metadata for a new subscription-level purchase.
   * Accepted only on create and purchase validation; never returned in responses or accepted on update.
   */
  @visibility(Lifecycle.Create)
  campaign?: CampaignMetadata;
}

/** Professional Service tracked resource for GA API version 2026-05-01. Inherits standard Azure Resource Manager envelope (id, name, type, location, tags, systemData). */
model ProfessionalServiceResource
  is TrackedResource<ProfessionalServiceResourceProperties> {
  ...ResourceNameParameter<
    Resource = ProfessionalServiceResource,
    KeyName = "resourceName",
    SegmentName = "resources"
  >;
}

/** The type used for update operations of the ProfessionalServiceResource. */
model ProfessionalServiceResourceUpdate is Azure.ResourceManager.Foundations.ResourceUpdateModel<
  ProfessionalServiceResource,
  ProfessionalServiceResourceProperties
>;

/** Professional Service purchase validation properties including the proposed resource name. */
model ProfessionalServicePurchaseValidationProperties {
  ...ProfessionalServiceResourceProperties;

  /** The proposed Professional Service resource name to validate. */
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @minLength(3)
  @maxLength(24)
  name: string;
}

/** Request payload for validating a proposed Professional Service purchase without creating the resource. */
model ProfessionalServicePurchaseValidationRequest {
  /** The geo-location where the resource lives. Must be `global` for Professional Service resources. */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  location: azureLocation;

  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /** The proposed Professional Service purchase properties, including the proposed resource name. */
  properties: ProfessionalServicePurchaseValidationProperties;
}
