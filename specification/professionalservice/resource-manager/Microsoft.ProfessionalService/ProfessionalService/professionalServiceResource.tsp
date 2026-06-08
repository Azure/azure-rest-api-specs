using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.ProfessionalService;

/** Professional Service resource properties for GA API version 2026-05-01. */
model ProfessionalServiceResourceProperties {
  /** The status of the last provisioning operation performed on the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProfessionalServiceProvisioningState;

  /** The Professional Service asset id. Server-assigned unique identifier for the marketplace subscription. */
  @visibility(Lifecycle.Read)
  assetId?: string;

  /** Optional description. Used as subscription display name by Teams, Admin Center and other consumers. */
  description?: string;

  /** The Professional Service Subscription Status. Server-assigned. */
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

  /** The term unit (ISO 8601 duration, e.g. P1M, P1Y). Server-resolved from ProductCode. */
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

  /** Whether the Professional Service subscription will auto renew upon term end. */
  autoRenew?: boolean;

  /** Whether the current term is a Free Trial term. Server-determined. */
  @visibility(Lifecycle.Read)
  isFreeTrial?: boolean;

  /** The storefront. */
  storefront?: string;

  /**
   * The purchaser email. Server-derived from authenticated identity. Read-only.
   *
   * Customer data (PII): NOT included in default GET responses. Returned only when
   * the request specifies `$expandCustomerData=true`. Callers requesting customer
   * data must have appropriate authorization and handle the value per GDPR requirements.
   *
   * `@secret` is applied so SDK generators emit `format: password`, ensuring the value
   * is redacted in logs, CLI output, and diagnostic traces.
   */
  @visibility(Lifecycle.Read)
  @secret
  purchaserEmail?: string;

  /** The private offer id. */
  privateOfferId?: string;

  /** The product code. Primary purchase identifier for GA — used to resolve term details server-side. */
  productCode: string;
}

/** Professional Service ARM tracked resource for GA API version 2026-05-01. Inherits standard ARM envelope (id, name, type, location, tags, systemData). */
model ProfessionalServiceResource
  is TrackedResource<ProfessionalServiceResourceProperties> {
  ...ResourceNameParameter<
    Resource = ProfessionalServiceResource,
    KeyName = "resourceName",
    SegmentName = "resources"
  >;
}
