import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Quota;

/**
 * Status of a quota transfer.
 */
@added(Versions.v2026_09_01_preview)
union TransferStatus {
  string,

  /**
   * The transfer has been created on the donor side and is awaiting recipient action.
   */
  Pending: "Pending",

  /**
   * The recipient has approved the transfer; quota commit is in progress.
   */
  Accepted: "Accepted",

  /**
   * The transfer has been applied and quota is committed at the recipient.
   */
  Completed: "Completed",

  /**
   * The donor cancelled the transfer before it was approved.
   */
  Cancelled: "Cancelled",

  /**
   * The recipient rejected the transfer.
   */
  Rejected: "Rejected",

  /**
   * The transfer terminated with a failure.
   */
  Failed: "Failed",
}

/**
 * Record of an approval action on a transfer.
 */
@added(Versions.v2026_09_01_preview)
model ApprovalRecord {
  /**
   * Optional free-text comment supplied by the approver.
   */
  @maxLength(500)
  comment?: string;

  /**
   * Principal that performed the approval (typically a UPN or service principal id).
   */
  actor: string;

  /**
   * Timestamp at which the approval was recorded.
   */
  occurredAt: utcDateTime;
}

/**
 * Record of a cancellation action on a transfer.
 */
@added(Versions.v2026_09_01_preview)
model CancellationRecord {
  /**
   * Optional free-text reason supplied by the donor when cancelling.
   */
  @maxLength(500)
  reason?: string;

  /**
   * Principal that performed the cancellation.
   */
  actor: string;

  /**
   * Timestamp at which the cancellation was recorded.
   */
  occurredAt: utcDateTime;
}

/**
 * Record of a rejection action on a transfer.
 */
@added(Versions.v2026_09_01_preview)
model RejectionRecord {
  /**
   * Optional free-text reason supplied by the recipient when rejecting.
   */
  @maxLength(500)
  reason?: string;

  /**
   * Principal that performed the rejection.
   */
  actor: string;

  /**
   * Timestamp at which the rejection was recorded.
   */
  occurredAt: utcDateTime;
}

/**
 * Donor-side properties of a quota transfer.
 */
@added(Versions.v2026_09_01_preview)
model QuotaTransferProperties {
  /**
   * The status of the underlying ARM resource operation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  /**
   * The business status of the transfer.
   */
  @visibility(Lifecycle.Read)
  transferStatus?: TransferStatus;

  /**
   * Server-generated identifier the recipient uses to address the transfer on the
   * incomingQuotaTransfers URI.
   */
  @visibility(Lifecycle.Read)
  transferId?: uuid;

  /**
   * Human-friendly label surfaced on customer GET responses and recipient inbox listings.
   */
  @maxLength(80)
  displayName: string;

  /**
   * Donor-supplied free-text rationale captured at submit time.
   */
  @maxLength(500)
  comment?: string;

  /**
   * Recipient subscription id. Must differ from the donor subscription.
   */
  destinationSubscription: uuid;

  /**
   * Recipient tenant id, resolved by the service from the recipient subscription.
   */
  @visibility(Lifecycle.Read)
  destinationTenantId?: uuid;

  /**
   * Billing account id both donor and recipient subscriptions must roll up to.
   */
  billingAccountId: string;

  /**
   * The quota dimension being moved, scoped by the URI's target provider
   * (for example, `standardDv5Family` under Microsoft.Compute).
   */
  resourceName: string;

  /**
   * Amount to transfer in the resource's native unit (e.g. vCPU count).
   */
  @minValue(1)
  amount: int64;

  /**
   * Same-tenant one-shot opt-in. When true, the donor PUT admission-checks recipient-side
   * RBAC and cap at submit time and drives the transfer to terminal Completed within the
   * same LRO, with no recipient approve required. The outcome is reflected by
   * `transferStatus`: `Completed` means the auto path committed; `Pending` means it did
   * not (e.g. cross-tenant, missing RBAC, cap exceeded) and the recipient must approve.
   */
  autoApprove?: boolean = false;

  /**
   * Time the transfer was created.
   */
  @visibility(Lifecycle.Read)
  createdAt?: utcDateTime;

  /**
   * Time at which a Pending transfer expires if the recipient has not approved or rejected it.
   */
  @visibility(Lifecycle.Read)
  expiresAt?: utcDateTime;

  /**
   * Principal that created the transfer.
   */
  @visibility(Lifecycle.Read)
  createdBy?: string;

  /**
   * Approval record. Populated when `transferStatus` is `Accepted` or `Completed`.
   * Mutually exclusive with `cancellation`.
   */
  @visibility(Lifecycle.Read)
  approval?: ApprovalRecord;

  /**
   * Cancellation record. Populated when `transferStatus` is `Cancelled`.
   * Mutually exclusive with `approval`.
   */
  @visibility(Lifecycle.Read)
  cancellation?: CancellationRecord;
}

/**
 * Recipient-side projection properties of a quota transfer.
 */
@added(Versions.v2026_09_01_preview)
model IncomingQuotaTransferProperties {
  /**
   * The status of the underlying ARM resource operation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  /**
   * The business status of the transfer.
   */
  @visibility(Lifecycle.Read)
  transferStatus?: TransferStatus;

  /**
   * Server-generated identifier of the transfer (matches the URI key).
   */
  @visibility(Lifecycle.Read)
  transferId?: uuid;

  /**
   * Fully qualified ARM resource id of the donor-side quotaTransfers resource.
   */
  @visibility(Lifecycle.Read)
  transferRef?: armResourceIdentifier;

  /**
   * Donor subscription id. The recipient subscription is the one in the request URI.
   */
  @visibility(Lifecycle.Read)
  sourceSubscriptionId?: uuid;

  /**
   * Donor tenant id, resolved by the service from the donor subscription.
   */
  @visibility(Lifecycle.Read)
  sourceTenantId?: uuid;

  /**
   * Billing account id both donor and recipient subscriptions roll up to.
   */
  @visibility(Lifecycle.Read)
  billingAccountId?: string;

  /**
   * The quota dimension being moved.
   */
  @visibility(Lifecycle.Read)
  resourceName?: string;

  /**
   * Amount being transferred in the resource's native unit.
   */
  @visibility(Lifecycle.Read)
  amount?: int64;

  /**
   * ETag of the donor-side source document at the time the inbox entry was projected. Used
   * as the If-Match value on approve and reject requests.
   */
  @visibility(Lifecycle.Read)
  sourceEtag?: string;

  /**
   * Approval record. Populated when `transferStatus` is `Accepted` or `Completed`.
   * Mutually exclusive with `rejection`.
   */
  @visibility(Lifecycle.Read)
  approval?: ApprovalRecord;

  /**
   * Rejection record. Populated when `transferStatus` is `Rejected`.
   * Mutually exclusive with `approval`.
   */
  @visibility(Lifecycle.Read)
  rejection?: RejectionRecord;
}

/**
 * Request body for the donor cancel action.
 */
@added(Versions.v2026_09_01_preview)
model QuotaTransferCancelRequest {
  /**
   * Optional free-text reason recorded on the transfer.
   */
  @maxLength(500)
  reason?: string;
}

/**
 * Request body for the recipient approve action.
 */
@added(Versions.v2026_09_01_preview)
model IncomingQuotaTransferApproveRequest {
  /**
   * Optional free-text comment recorded on the transfer.
   */
  @maxLength(500)
  comment?: string;
}

/**
 * Request body for the recipient reject action.
 */
@added(Versions.v2026_09_01_preview)
model IncomingQuotaTransferRejectRequest {
  /**
   * Optional free-text reason recorded on the transfer.
   */
  @maxLength(500)
  reason?: string;
}
