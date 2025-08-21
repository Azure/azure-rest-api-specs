import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./versions.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using TypeSpec.Versioning;

@versioned(SaaSHubVersions)
namespace Microsoft.SaaSHub;

/**
 * Indicates whether auto renewal is turned on or off for a SaaSHub saas resource. The default value will be 'On' for products that support autorenew.
 */
union AutoRenew {
  string,

  /**
   * Auto renew is turned off
   */
  Off: "Off",

  /**
   * Auto renew is turned on
   */
  On: "On",

  /**
   * Auto renew is turned on for the next term only
   */
  Once: "Once",
}

/**
 * The operation type for the linked resources
 */
union OriginResourceOperationType {
  string,

  /**
   * Renew operation type
   */
  Renew: "Renew",

  /**
   * Merge operation type
   */
  Merge: "Merge",
}

/**
 * The policy override for the resource indicates whether the self-serve cancellation or seat reduction is allowed.
 */
union Cancellation {
  string,

  /**
   * Cancellation is allowed
   */
  Allowed: "Allowed",

  /**
   * Cancellation is not allowed
   */
  NotAllowed: "NotAllowed",
}

/**
 * Gets the status of the SaaSHub saas resource at the time the operation was called.
 */
@Azure.Core.lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  /**
   * Resource provisioning request is accepted
   */
  Accepted: "Accepted",

  /**
   * Resource provisioning request is being processed
   */
  Processing: "Processing",

  /**
   * Resource provisioning request is being updating
   */
  Updating: "Updating",

  /**
   * Resource provisioning request status is unknown
   */
  Unknown: "Unknown",

  string,
}

/**
 * Whether the validation passed/failed.
 */
union EvaluateResult {
  string,

  /**
   * Validation result is unknown
   */
  Unknown: "Unknown",

  /**
   * Validation result is passed
   */
  Passed: "Passed",

  /**
   * Validation result is failed
   */
  Failed: "Failed",
}

/**
 * True if user is eligible for this promotion, false otherwise
 */
union EligibilityResult {
  string,

  /**
   * Ineligible for promotion
   */
  Ineligible: "Ineligible",

  /**
   * Eligible for promotion
   */
  Eligible: "Eligible",
}

/**
 * Whether the target is cloud resource or contract.
 */
union CoTermTargetType {
  string,

  /**
   * Resource co-term type
   */
  Resource: "Resource",

  /**
   * Contract co-term type
   */
  Contract: "Contract",
}

/**
 * Type of the offer for which the saas resource is purchased
 */
union OfferType {
  string,

  /**
   * Paid offer
   */
  Paid: "Paid",

  /**
   * Trial offer
   */
  Trial: "Trial",
}

/**
 * System imposed policies that regulate behavior of the resource.
 */
model SystemOverrides {
  /**
   * The policy override for the resource indicates whether the self-serve cancellation or seat reduction is allowed.
   */
  @visibility(Lifecycle.Read)
  cancellation?: Cancellation;

  /**
   * The end date in UTC time by when the self-serve cancellation ends.
   */
  @visibility(Lifecycle.Read)
  cancellationAllowedEndDate?: utcDateTime;

  /**
   * Represents an dependency-generated ID unique per instance of this resource.
   */
  @visibility(Lifecycle.Read)
  systemId?: string;

  /**
   * Represents a system entity version for the resource, used for concurrency control.
   */
  @visibility(Lifecycle.Read)
  systemVersion?: string;

  /**
   * The number of times the resource has been renewed.
   */
  @visibility(Lifecycle.Read)
  renewalCount?: int32 = 0;

  /**
   * The start date in UTC time on the current product code.
   */
  @visibility(Lifecycle.Read)
  startDateOnCurrentProductCode?: utcDateTime;

  /**
   * Duration of license reassignment period for the current term. Value is an ISO 8601 duration string.
   * Expected to be P0D (0 days) or greater.
   */
  @visibility(Lifecycle.Read)
  licenseReassignmentDuration?: string;

  /**
   * ISO 8601 duration string representing the data retention period for the resource.
   * Read-only property.
   */
  @visibility(Lifecycle.Read)
  dataRetentionDuration?: string;

  /**
   * URL pointing to the product information in the Catalog endpoint.
   * Read-only property.
   */
  @visibility(Lifecycle.Read)
  productUrl?: string;
}

/**
 * Renewal term details of the saas resource.
 */
model RenewalTermDetails {
  /**
   * The number of licenses purchased for the saas resource
   */
  quantity?: int64;

  /**
   * Upn value of the product, which can be used to resolve product Id/sku Id/availability Id/term Id
   */
  productCode?: string;

  /**
   * Billing frequency of the product under the saas resource. Example P1Y and P1M
   */
  @visibility(Lifecycle.Read)
  billingFrequency?: string;

  /**
   * The duration for which you can use the saas resource. Example P1Y and P1M
   */
  @visibility(Lifecycle.Read)
  termUnit?: string;

  /**
   * End date of the renewal term in UTC time. It can be patched for co-term scenario, the time part passed in will be ignored
   */
  endDate?: utcDateTime;

  /**
   * Linked resources for the saas resource
   */
  linkedResources?: LinkedResources;

  /**
   * Billing token for renewal term transaction.
   */
  @secret
  billingToken?: string;

  /**
   * Availability token for renewal term transaction.
   */
  @secret
  availabilityToken?: string;
}

/**
 * Linked resources for the saas resource
 */
model LinkedResources {
  /**
   * The resources ids which will be linked to current resource.
   */
  resourceIds?: string[];

  /**
   * The link operation type.
   */
  operationType?: OriginResourceOperationType;
}

/**
 * Term details of the saas resource.
 */
model TermDetails {
  /**
   * Billing frequency of the product under the saas resource. Example P1Y and P1M
   */
  @visibility(Lifecycle.Read)
  billingFrequency?: string;

  /**
   * The duration for which you can use the saas resource. Example P1Y and P1M
   */
  @visibility(Lifecycle.Read)
  termUnit?: string;

  /**
   * Start date of the term in UTC time. When there is a value passed in for PUT scenario, it is to support future start date scenario. The time part passed in will be ignored
   */
  startDate?: utcDateTime;

  /**
   * End date of the term in UTC time. When there is a value passed in for PUT scenario, it is to support co-term scenario. When there is a value passed in for PATCH scenario, it is to support extend trial scenario. The time part passed in will be ignored
   */
  endDate?: utcDateTime;
}

/**
 * Validation result for canCreate operation.
 */
model CanCreateResult {
  /**
   * Whether the validation passed/failed.
   */
  @visibility(Lifecycle.Read)
  evaluateResult?: EvaluateResult;

  /**
   * ReasonCode for why the request payload failed validation. Null when validation passed.
   */
  @visibility(Lifecycle.Read)
  reasonCode?: string;

  /**
   * Detailed reason for why the request payload failed validation. Null when validation passed.
   */
  @visibility(Lifecycle.Read)
  reason?: string;

  /**
   * Additional information for failed validation.
   */
  @visibility(Lifecycle.Read)
  additionalInfo?: CanCreateResultAdditionalInfo;
}

/**
 * Additional information for failed validation.
 */
model CanCreateResultAdditionalInfo {
  /**
   * Additional detail when request payload failed addOn constraints. Null when constraints passed or not applicable.
   */
  @visibility(Lifecycle.Read)
  addOn?: CanCreateResultAddOnInfo;

  /**
   * Additional detail when request payload failed promotion constraints. Null when constraints passed or not applicable.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  promotion?: CanCreateResultPromotionInfo[];

  /**
   * Additional evaluation eligibility result for qualifying co-term resources for a future price concession. Null when constraints passed or not applicable.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  futurePrice?: CanCreateResultFuturePriceInfo[];

  /**
   * Additional detail when request payload failed coTerm constraints. Null when constraints passed or not applicable.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  coTermDates?: CoTermDateEligibilityResult[];
}

/**
 * Additional detail when request payload failed addOn constraints. Null when constraints passed or not applicable.
 */
model CanCreateResultAddOnInfo {
  /**
   * AddOn ineligible reasons.
   */
  @visibility(Lifecycle.Read)
  ineligibilityReasons?: string[];

  /**
   * AddOn eligibility constraints.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  eligibilityConstraints?: EligibilityConstraint[];
}

/**
 * Shared eligibility constraint model.
 */
model EligibilityConstraint {
  /**
   * The failed eligibility constraint type.
   */
  @visibility(Lifecycle.Read)
  constraintType?: string;

  /**
   * true if eligibility is satisfied, false otherwise
   */
  @visibility(Lifecycle.Read)
  isEligible?: EligibilityResult;
}

/**
 * Model to present promotion eligibility info.
 */
model CanCreateResultPromotionInfo {
  /**
   * Promotion id.
   */
  @visibility(Lifecycle.Read)
  promotionId?: string;

  /**
   * True if user is eligible for this promotion, false otherwise
   */
  @visibility(Lifecycle.Read)
  isEligible?: EligibilityResult;

  /**
   * Promotion ineligible reasons.
   */
  @visibility(Lifecycle.Read)
  ineligibilityReasons?: string[];

  /**
   * Promotion eligibility constraints.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  eligibilityConstraints?: EligibilityConstraint[];
}

/**
 * Model to present additional info about future price eligibility
 */
model CanCreateResultFuturePriceInfo {
  /**
   * The term end date in UTC time, for resources in this group.
   */
  @visibility(Lifecycle.Read)
  termEndDate?: utcDateTime;

  /**
   * Total cumulative quantity of licenses for resources in this group.
   */
  @visibility(Lifecycle.Read)
  totalQuantity?: int64;

  /**
   * Whether the future price concession eligibility is satisfied by subscriptions in this group
   */
  @visibility(Lifecycle.Read)
  isEligible?: EligibilityResult;

  /**
   * List of qualifying resources for the future price concession
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  qualifyingResources?: CanCreateResultFuturePriceQualifyingResource[];

  /**
   * Types of future price concession. E.g. FuturePriceNotToExceedCap, PercentageDiscount
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  futurePriceConcessionTypes?: string[];

  /**
   * Minimum number of seats required to be eligible for the future price concession
   */
  @visibility(Lifecycle.Read)
  minimumQuantityRequired?: int64;
}

/**
 * Model to represent the future price qualified resource
 */
model CanCreateResultFuturePriceQualifyingResource {
  /**
   * Qualifying resource names
   */
  @visibility(Lifecycle.Read)
  resourceName?: string;
}

/**
 * Additional information for failed validation.
 */
model CoTermDateEligibilityResult {
  /**
   * Target cloud resource or contract name to coTerm to.
   */
  @visibility(Lifecycle.Read)
  coTermTarget?: string;

  /**
   * Whether the target is cloud resource or contract.
   */
  @visibility(Lifecycle.Read)
  coTermTargetType?: CoTermTargetType;

  /**
   * CoTerm end date in UTC time.
   */
  @visibility(Lifecycle.Read)
  termEndDate?: utcDateTime;

  /**
   * CoTerm error details
   */
  @visibility(Lifecycle.Read)
  errorCode?: string;
}

/**
 * Validation result for canCancel operation.
 */
model CanCancelResult {
  /**
   * Whether the validation passed/failed.
   */
  @visibility(Lifecycle.Read)
  evaluateResult?: EvaluateResult;

  /**
   * ReasonCode for why the request payload failed validation. Null when validation passed.
   */
  @visibility(Lifecycle.Read)
  reasonCode?: string;

  /**
   * Detailed reason for why the request payload failed validation. Null when validation passed.
   */
  @visibility(Lifecycle.Read)
  reason?: string;

  /**
   * Additional information for failed validation.
   */
  @visibility(Lifecycle.Read)
  additionalInfo?: CanCancelResultAdditionalInfo;
}

/**
 * Additional information for failed validation.
 */
model CanCancelResultAdditionalInfo {
  /**
   * The end date in UTC time by when the self-serve cancellation ends.
   */
  @visibility(Lifecycle.Read)
  cancellationWindowEndTimestamp?: utcDateTime;
}

/**
 * Validation result for canUpdate operation.
 */
model CanUpdateResult {
  /**
   * Whether the validation passed/failed.
   */
  @visibility(Lifecycle.Read)
  evaluateResult?: EvaluateResult;

  /**
   * ReasonCode for why the request payload failed validation. Null when validation passed.
   */
  @visibility(Lifecycle.Read)
  reasonCode?: string;

  /**
   * Detailed reason for why the request payload failed validation. Null when validation passed.
   */
  @visibility(Lifecycle.Read)
  reason?: string;

  /**
   * Update scenario that was identified based on the canUpdate request body values.
   */
  @visibility(Lifecycle.Read)
  updateScenario?: string;

  /**
   * Additional information for failed validation.
   */
  @visibility(Lifecycle.Read)
  additionalInfo?: CanUpdateResultAdditionalInfo;
}

/**
 * Additional information for failed validation.
 */
model CanUpdateResultAdditionalInfo {
  /**
   * Additional detail when request payload failed refundableQuantity constraints. Null when constraints passed or not applicable. Relevant scenarios: remove quantity.
   */
  @visibility(Lifecycle.Read)
  refundableQuantity?: RefundableQuantityResult;

  /**
   * Additional detail when request payload failed coTerm constraints. Null when constraints passed or not applicable. Relevant scenarios: coterm, scheduled conversion with coterm.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  coTermDates?: CoTermDateEligibilityResult[];
}

/**
 * Shared refundable quantity constraint model.
 */
model RefundableQuantityResult {
  /**
   * Total refundable quantity at the time of the evaluation.
   */
  @visibility(Lifecycle.Read)
  totalRefundableQuantity?: int64;

  /**
   * Batches of refundable quantity with their respective refund window end date.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  refundableQuantities?: RefundableQuantityResultRefundableQuantitiesInfo[];
}

/**
 * Model to present the refundable license information
 */
model RefundableQuantityResultRefundableQuantitiesInfo {
  /**
   * Refundable quantity within this window.
   */
  @visibility(Lifecycle.Read)
  quantity?: int64;

  /**
   * The end date in UTC time by when the refund window ends.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  returnWindowEndDateTime?: utcDateTime;
}

/**
 * Response model for GetRefundableQuantity operation.
 */
model GetRefundableQuantityResponse {
  /**
   * List of refundable quantity information with event details.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  refundableQuantities?: GetRefundableQuantityInfo[];

  /**
   * Total refundable quantity across all events.
   */
  @visibility(Lifecycle.Read)
  totalRefundableQuantity?: int64;
}

/**
 * Model to present detailed refundable quantity information with event details.
 */
model GetRefundableQuantityInfo {
  /**
   * The date and time when the event occurred that created this refundable quantity.
   */
  @visibility(Lifecycle.Read)
  eventDateTime?: utcDateTime;

  /**
   * The change in quantity from this event.
   */
  @visibility(Lifecycle.Read)
  deltaQuantity?: int64;

  /**
   * The end date and time in UTC when the refund window ends for this quantity.
   * Optional - may be null if there is no specific window limit.
   */
  @visibility(Lifecycle.Read)
  returnWindowEndDateTime?: utcDateTime;
}

/**
 * The status of a seat-based resource.
 */
union SeatBasedResourceStatus {
  string,

  /**
   * Resource status is unknown
   */
  Unknown: "Unknown",

  /**
   * Resource status is active
   */
  Active: "Active",

  /**
   * Resource status is disabled
   */
  Disabled: "Disabled",

  /**
   * Resource status is deleted
   */
  Deleted: "Deleted",

  /**
   * Resource status is past due
   */
  PastDue: "PastDue",

  /**
   * Resource status is expiring
   */
  Expiring: "Expiring",

  /**
   * Resource status is expired
   */
  Expired: "Expired",

  /**
   * Resource status is auto renew
   */
  AutoRenew: "AutoRenew",

  /**
   * Resource status is cancelled
   */
  Cancelled: "Cancelled",

  /**
   * Resource status is suspended
   */
  Suspended: "Suspended",
}

/**
 * Base properties for seat-based resources.
 */
model SeatBasedResourceProperties {
  /**
   * Indicates whether auto renewal is turned on or off for a seat-based resource. The default value will be 'On' for products that support autorenew.
   */
  autoRenew?: AutoRenew;

  /**
   * The end customer billing account in CSP scenario, will full format like /providers/Microsoft.Billing/billingAccounts/1111:2222
   */
  endCustomerBillingAccount?: string;

  /**
   * The name of the seat-based resource.
   */
  displayName?: string;

  /**
   * Type of the product for which the resource is purchased
   */
  @visibility(Lifecycle.Read)
  productType?: string;

  /**
   * Linked resources for the resource
   */
  linkedResources?: LinkedResources;

  /**
   * Type of the offer for which the resource is purchased
   */
  @visibility(Lifecycle.Read)
  offerType?: OfferType;

  /**
   * Product Universal Product Number of the product
   */
  productCode?: string;

  /**
   * License data of the product
   */
  @visibility(Lifecycle.Read)
  licenseData?: string;

  /**
   * Gets the status of the seat-based resource at the time the operation was called.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The number of licenses purchased for the resource
   */
  quantity?: int64;

  /**
   * The SKU description of the product for which the resource is purchased.
   */
  @visibility(Lifecycle.Read)
  skuDescription?: string;

  /**
   * The status of the seat-based resource.
   */
  @visibility(Lifecycle.Read)
  status?: SeatBasedResourceStatus;

  /**
   * The suspension reason for a resource.
   */
  @visibility(Lifecycle.Read)
  suspensionReasons?: string[];

  /**
   * Term details of the resource.
   */
  term?: TermDetails;

  /**
   * The Id of the tenant where licenses will be provisioned for this resource. It will only be populated if licenses are provisioned in a different tenant.
   */
  provisioningTenantId?: string;

  /**
   * An external Id which could be used to reference other commerce system entity, such as OMS sub id or proposal id. ExternalId value will have "{externalSystem}:{externalId}", e.g. "oms:1111-2222-444-666"
   */
  externalId?: string;

  /**
   * System imposed policies that regulate behavior of the resource.
   */
  systemOverrides?: SystemOverrides;

  /**
   * Resource tokens for various authorization and context purposes.
   */
  @OpenAPI.extension("x-ms-identifiers", #["type"])
  resourceTokens?: ResourceToken[];

  /**
   * Schedule actions for future terms and changes
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  scheduleActions?: ScheduleAction[];
}

/**
 * Base model for seat-based resources to be used in merge operations as source.
 */
model MergeSourceSeatBasedResource {
  /**
   * The quantity of license to be merged
   */
  quantity?: int64;

  /**
   * The validation error it ran into. Null when validation passed.
   */
  @visibility(Lifecycle.Read)
  validationError?: string;

  /**
   * Resource tokens for various authorization and context purposes (for merge source).
   */
  @OpenAPI.extension("x-ms-identifiers", #["type"])
  resourceTokens?: ResourceToken[];
}

/**
 * Resource token containing type and value for various authorization and context purposes.
 */
model ResourceToken {
  /**
   * The type of the resource token. Examples: "availabilityToken", "billingToken"
   */
  type?: string;

  /**
   * The value of the resource token.
   */
  @doc("Encoded resource token.")
  value?: string;
}

/**
 * Linked resource for scheduled actions
 */
model ScheduleActionLinkedResource {
  /**
   * The URI of the target resource for the scheduled action
   */
  resourceUri?: string;

  /**
   * The billing scope for the linked resource. Only applicable for SaaS resources.
   * Format: /providers/Microsoft.Billing/billingAccounts/{baId}/billingProfiles/{bfId}/invoiceSections/{isId}
   */
  billingScope?: string;
}

/**
 * Schedule action for resource operations
 */
model ScheduleAction {
  /**
   * The type of schedule action
   */
  type?: string;

  /**
   * The effective date for the schedule action
   */
  effectiveDate?: utcDateTime;

  /**
   * Product code for the schedule action
   */
  productCode?: string;

  /**
   * The quantity for the schedule action
   */
  quantity?: int64;

  /**
   * The end date for the schedule action
   */
  endDate?: utcDateTime;

  /**
   * Linked resource for the scheduled action.
   * Optional property.
   */
  linkedResource?: ScheduleActionLinkedResource;

  /**
   * Resource tokens for various authorization and context purposes.
   */
  @OpenAPI.extension("x-ms-identifiers", #["type"])
  resourceTokens?: ResourceToken[];
}

/**
 * End date information for coterm calculation.
 */
model CotermEndDateItem {
  /**
   * Unique identifier for the end date entry.
   */
  id: string;

  /**
   * End date in UTC time.
   */
  endDate: utcDateTime;

  /**
   * Term duration for this specific end date.
   */
  termDuration: string;
}

/**
 * Request model for GetCotermEndDates operation.
 */
model CotermEndDatesRequest {
  /**
   * List of end dates to calculate coterm targets for.
   */
  endDates: CotermEndDateItem[];

  /**
   * Start date for the coterm calculation in UTC time.
   */
  startDate: utcDateTime;

  /**
   * Term duration for the coterm calculation.
   * An ISO 8601 duration using exactly one of the year, month or day designators. E.g. P1Y, P1M.
   */
  termDuration: string;
}

/**
 * Response model for GetCotermEndDates operation.
 */
model CotermResponseItem {
  /**
   * Target cloud resource or contract name to coterm to.
   */
  @visibility(Lifecycle.Read)
  coTermTarget: string;

  /**
   * Whether the target is cloud resource or contract.
   */
  @visibility(Lifecycle.Read)
  coTermTargetType: string;

  /**
   * Term end date in UTC time.
   */
  @visibility(Lifecycle.Read)
  termEndDate?: utcDateTime;

  /**
   * Error code if coterm calculation failed.
   */
  @visibility(Lifecycle.Read)
  errorCode: string;
}

/**
 * Request model for Proposal operation.
 */
model ProposalRequest {
  /**
   * The unique identifier for the proposal.
   */
  proposalId: string;
}

/**
 * Error information for proposal line items.
 */
model ProposalLineItemError {
  /**
   * Error code for the line item.
   */
  errorCode?: string;

  /**
   * Error message for the line item.
   */
  message?: string;
}

/**
 * Additional information for proposal line items.
 */
model ProposalLineItemAdditionalInfo {
  /**
   * ETag for concurrency control.
   */
  etag?: string;

  /**
   * System identifier.
   */
  systemId?: string;

  /**
   * Tracking identifier.
   */
  trackingId?: string;
}

/**
 * Line item information in a proposal response.
 */
model ProposalLineItem {
  /**
   * Unique identifier for the line item.
   */
  lineItemId?: string;

  /**
   * Product identifier.
   */
  productId?: string;

  /**
   * SKU identifier.
   */
  skuId?: string;

  /**
   * Availability identifier.
   */
  availabilityId?: string;

  /**
   * BigId identifier.
   */
  bigId?: string;

  /**
   * Product code for the line item.
   */
  productCode?: string;

  /**
   * Error information if any issues occurred with this line item.
   */
  error?: ProposalLineItemError;

  /**
   * Additional information for the line item.
   */
  additionalInfo?: ProposalLineItemAdditionalInfo;
}

/**
 * Response model for Proposal operation.
 */
model ProposalResponse {
  /**
   * Unique identifier for the proposal response.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Status of the proposal.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * List of line items in the proposal.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  lineItems?: ProposalLineItem[];
}
