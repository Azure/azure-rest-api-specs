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

  /**
   * URL pointing to the cloud licensing information for the resource.
   * Read-only property.
   */
  @added(SaaSHubVersions.v2026_03_31_preview)
  @visibility(Lifecycle.Read)
  cloudLicensingUrl?: string;
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
  @identifiers(#[])
  promotion?: CanCreateResultPromotionInfo[];

  /**
   * Additional evaluation eligibility result for qualifying co-term resources for a future price concession. Null when constraints passed or not applicable.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  futurePrice?: CanCreateResultFuturePriceInfo[];

  /**
   * Additional detail when request payload failed coTerm constraints. Null when constraints passed or not applicable.
   * @deprecated Starting with 2026-03-31-preview, use the 'coTerm' property instead.
   */
  #deprecated "Starting with 2026-03-31-preview, use the 'coTerm' property instead."
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  coTermDates?: CoTermDateEligibilityResult[];

  /**
   * Additional information for coTerm eligibility with top-level eligibility indicator. Null when constraints passed or not applicable.
   */
  @added(SaaSHubVersions.v2026_03_31_preview)
  @visibility(Lifecycle.Read)
  coTerm?: CoTermEligibilityResult;
}

/**
 * Additional detail when request payload failed addOn constraints. Null when constraints passed or not applicable.
 */
model CanCreateResultAddOnInfo {
  /**
   * Whether the add-on eligibility is satisfied.
   */
  @added(SaaSHubVersions.v2026_03_31_preview)
  @visibility(Lifecycle.Read)
  isEligible?: EligibilityResult;

  /**
   * AddOn ineligible reasons.
   */
  @visibility(Lifecycle.Read)
  ineligibilityReasons?: string[];

  /**
   * AddOn eligibility constraints.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
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
   * Identifies which discount UPN each eligibility result corresponds to for CSP Growth Margin.
   */
  @visibility(Lifecycle.Read)
  @added(SaaSHubVersions.v2026_03_31_preview)
  discountProductCode?: string;

  /**
   * Promotion eligibility constraints.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  @typeChangedFrom(SaaSHubVersions.v2026_03_31_preview, EligibilityConstraint[])
  eligibilityConstraints?: PromotionEligibilityConstraint[];
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
  @identifiers(#[])
  qualifyingResources?: CanCreateResultFuturePriceQualifyingResource[];

  /**
   * Types of future price concession. E.g. FuturePriceNotToExceedCap, PercentageDiscount
   */
  @visibility(Lifecycle.Read)
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
  @removed(SaaSHubVersions.v2026_03_31_preview)
  @visibility(Lifecycle.Read)
  resourceName?: string;

  /**
   * ARM resource URI for the qualifying resource.
   */
  @added(SaaSHubVersions.v2026_03_31_preview)
  @visibility(Lifecycle.Read)
  resourceId?: string;

  /**
   * Upn value of the product, which can be used to resolve product Id/sku Id/availability Id/term Id.
   */
  @added(SaaSHubVersions.v2026_03_31_preview)
  @visibility(Lifecycle.Read)
  productCode?: string;

  /**
   * Number of seats for this qualifying resource.
   */
  @added(SaaSHubVersions.v2026_03_31_preview)
  @visibility(Lifecycle.Read)
  quantity?: int64;

  /**
   * Whether the qualifying resource originated from the copurchased products list.
   * True if from copurchasedProducts, false if from existing customer resources.
   */
  @added(SaaSHubVersions.v2026_03_31_preview)
  @visibility(Lifecycle.Read)
  isCopurchased?: boolean;

  /**
   * Item tracking identifier from the copurchased product request.
   * Present when isCopurchased is true, so the client can correlate back to the original request item.
   */
  @added(SaaSHubVersions.v2026_03_31_preview)
  @visibility(Lifecycle.Read)
  itemTrackingId?: string;
}

/**
 * Additional information for coTerm eligibility with top-level eligibility indicator.
 */
@added(SaaSHubVersions.v2026_03_31_preview)
model CoTermEligibilityResult {
  /**
   * Whether the coTerm eligibility is satisfied.
   */
  @visibility(Lifecycle.Read)
  isEligible?: EligibilityResult;

  /**
   * Additional detail when request payload failed coTerm constraints. Null when constraints passed or not applicable.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  coTermDates?: CoTermDateEligibilityResult[];
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
   * @deprecated Starting with 2026-03-31-preview, use the 'coTerm' property instead.
   */
  #deprecated "Starting with 2026-03-31-preview, use the 'coTerm' property instead."
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  coTermDates?: CoTermDateEligibilityResult[];

  /**
   * Additional information for coTerm eligibility with top-level eligibility indicator. Null when constraints passed or not applicable. Relevant scenarios: coterm, scheduled conversion with coterm.
   */
  @added(SaaSHubVersions.v2026_03_31_preview)
  @visibility(Lifecycle.Read)
  coTerm?: CoTermEligibilityResult;

  /**
   * Additional detail when request payload failed addOn constraints. Null when constraints passed or not applicable.
   */
  @added(SaaSHubVersions.v2026_03_31_preview)
  @visibility(Lifecycle.Read)
  addOn?: CanCreateResultAddOnInfo;

  /**
   * Additional detail when request payload failed promotion constraints. Null when constraints passed or not applicable.
   */
  @added(SaaSHubVersions.v2026_03_31_preview)
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  promotion?: CanCreateResultPromotionInfo[];

  /**
   * Additional evaluation eligibility result for qualifying co-term resources for a future price concession. Null when constraints passed or not applicable.
   */
  @added(SaaSHubVersions.v2026_03_31_preview)
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  futurePrice?: CanCreateResultFuturePriceInfo[];
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
  @identifiers(#[])
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
  @identifiers(#[])
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
  @typeChangedFrom(SaaSHubVersions.v2025_07_01_preview, OfferType)
  offerType?: string;

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
  @identifiers(#["type"])
  resourceTokens?: ResourceToken[];

  /**
   * Schedule actions for future terms and changes
   */
  @identifiers(#[])
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
  @identifiers(#["type"])
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
 * Dependency value containing type and value for dependency tracking purposes.
 */
model DependsOnValue {
  /**
   * The type of the dependency value.
   */
  type?: string;

  /**
   * The value of the dependency.
   */
  value?: string;
}

/**
 * Additional information key-value pair
 */
model AdditionalInfoItem {
  /**
   * The type of the additional information item.
   */
  type?: string;

  /**
   * The key of the additional information item.
   */
  key?: string;

  /**
   * The value of the additional information item.
   */
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

  /**
   * The link operation type.
   */
  operationType?: string;

  /**
   * The resource type for the linked resource.
   */
  resourceType?: string;

  /**
   * Indicates whether auto renewal is turned on, off, or on for one term only.
   */
  @added(SaaSHubVersions.v2026_03_31_preview)
  autoRenew?: AutoRenew;

  /**
   * The term end date for coterm scenarios.
   */
  @added(SaaSHubVersions.v2026_03_31_preview)
  termEndDate?: utcDateTime;

  /**
   * The product code for the linked resource.
   */
  @added(SaaSHubVersions.v2026_03_31_preview)
  productCode?: string;

  /**
   * The resource tokens for the linked resource.
   */
  @added(SaaSHubVersions.v2026_03_31_preview)
  @identifiers(#["type"])
  resourceTokens?: ResourceToken[];

  /**
   * The renewal term details for the linked resource.
   */
  @added(SaaSHubVersions.v2026_03_31_preview)
  renewalTerm?: ScheduleActionLinkedResourceRenewalTerm;
}

/**
 * Renewal term details for a scheduled action linked resource
 */
@added(SaaSHubVersions.v2026_03_31_preview)
model ScheduleActionLinkedResourceRenewalTerm {
  /**
   * The product code for the renewal term.
   */
  productCode?: string;

  /**
   * The quantity for the renewal term.
   */
  quantity?: int64;

  /**
   * The resource tokens for the renewal term.
   */
  @identifiers(#["type"])
  resourceTokens?: ResourceToken[];

  /**
   * The end date of the renewal term.
   */
  endDate?: utcDateTime;
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
   * Type of the offer for which the schedule action is applied
   */
  @visibility(Lifecycle.Read)
  offerType?: string;

  /**
   * Resource tokens for various authorization and context purposes.
   */
  @identifiers(#["type"])
  resourceTokens?: ResourceToken[];

  /**
   * The item tracking identifier for the schedule action.
   */
  @added(SaaSHubVersions.v2026_03_31_preview)
  itemTrackingId?: string;
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
 * Response model for GetCotermEndDates operation. Error code is optional.
 */
model CotermResponseItemErrorOptional {
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
  errorCode?: string;
}

/**
 * Bulk response model for TenantLevelGetCotermEndDates and GetCotermEndDates operations with pagination support.
 */
model CotermResponseItemBulkResponse
  is Azure.Core.Page<CotermResponseItemErrorOptional>;

/**
 * Request model for CanTransact operation.
 */
model CanTransactSaasResourcesRequest {
  /**
   * The unique identifier for tracking the canTransact request item.
   */
  @added(SaaSHubVersions.v2026_03_31_preview)
  itemTrackingId?: string;

  /**
   * The URI of the resource for the transaction evaluation.
   */
  resourceUri: string;

  /**
   * Optional token for the evaluation request.
   */
  approvalCode?: string;

  /**
   * The type of operation to evaluate for the transaction.
   */
  operationType: CanTransactOperationType;

  /**
   * Resource properties for the transaction evaluation.
   * Supports SaasResources only.
   */
  properties?: SaasResourceProperties;

  /**
   * Full merge request payload used for canMerge operations.
   */
  mergeRequest?: MergeSaasResourcesRequest;

  /**
   * Additional information as key-value pairs
   */
  @identifiers(#[])
  additionalInfo?: AdditionalInfoItem[];
}

/**
 * Bulk request model for TenantLevelCanTransact operation.
 */
model TenantLevelCanTransactBulkRequest {
  /**
   * Array of transaction requests to evaluate.
   */
  @identifiers(#[])
  items: CanTransactSaasResourcesRequest[];
}

/**
 * Request model for CanTransact operation with CloudServices.
 */
model CanTransactCloudServicesRequest {
  /**
   * The unique identifier for tracking the canTransact request item.
   */
  @added(SaaSHubVersions.v2026_03_31_preview)
  itemTrackingId?: string;

  /**
   * The URI of the resource for the transaction evaluation.
   */
  resourceUri: string;

  /**
   * Optional token for the evaluation request.
   */
  approvalCode?: string;

  /**
   * The type of operation to evaluate for the transaction.
   */
  operationType: CanTransactOperationType;

  /**
   * Resource properties for the transaction evaluation.
   * Supports CloudServices only.
   */
  properties?: CloudServiceProperties;

  /**
   * Full merge request payload used for canMerge operations.
   */
  mergeRequest?: MergeCloudServiceRequest;

  /**
   * Additional information as key-value pairs
   */
  @identifiers(#[])
  additionalInfo?: AdditionalInfoItem[];
}

/**
 * Bulk request model for ResourceGroupLevelCanTransact operation.
 */
model ResourceGroupLevelCanTransactBulkRequest {
  /**
   * Array of transaction requests to evaluate.
   */
  @identifiers(#[])
  items: CanTransactCloudServicesRequest[];
}

/**
 * Bulk response model for ResourceGroupLevelCanTransact operation with pagination support.
 */
model ResourceGroupLevelCanTransactBulkResponse
  is Azure.Core.Page<CanTransactResponse>;

/**
 * The type of operation being evaluated in a CanTransact request.
 */
union CanTransactOperationType {
  string,

  /**
   * Create operation type
   */
  canCreate: "canCreate",

  /**
   * Cancel operation type
   */
  canCancel: "canCancel",

  /**
   * Update operation type
   */
  canUpdate: "canUpdate",

  /**
   * Merge operation type
   */
  canMerge: "canMerge",
}

/**
 * Base response model for CanTransact operation result.
 * The operationType discriminator determines which specific result structure is used.
 */
@discriminator("operationType")
model CanTransactResponse {
  /**
   * The unique identifier for tracking the canTransact response item.
   */
  @added(SaaSHubVersions.v2026_03_31_preview)
  @visibility(Lifecycle.Read)
  itemTrackingId?: string;

  /**
   * The URI of the resource that was evaluated.
   */
  @visibility(Lifecycle.Read)
  resourceUri: string;

  /**
   * Proof of successful evaluation.
   */
  @visibility(Lifecycle.Read)
  approvalCode?: string;

  /**
   * The type of operation that was evaluated.
   */
  @visibility(Lifecycle.Read)
  operationType: CanTransactOperationType;

  /**
   * Dependencies for the transaction evaluation.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  dependsOn?: DependsOnValue[];
}

/**
 * Response for canCreate operation evaluation.
 */
model CanTransactCanCreateResponse extends CanTransactResponse {
  // Discriminator value: must be a literal string (not a union reference) matching a CanTransactOperationType value for proper polymorphic deserialization
  operationType: "canCreate";

  /**
   * The result of the canCreate operation evaluation.
   */
  @visibility(Lifecycle.Read)
  result?: CanCreateResult;
}

/**
 * Response for canCancel operation evaluation.
 */
model CanTransactCanCancelResponse extends CanTransactResponse {
  // Discriminator value: must be a literal string (not a union reference) matching a CanTransactOperationType value for proper polymorphic deserialization
  operationType: "canCancel";

  /**
   * The result of the canCancel operation evaluation.
   */
  @visibility(Lifecycle.Read)
  result?: CanCancelResult;
}

/**
 * Response for canUpdate operation evaluation.
 */
model CanTransactCanUpdateResponse extends CanTransactResponse {
  // Discriminator value: must be a literal string (not a union reference) matching a CanTransactOperationType value for proper polymorphic deserialization
  operationType: "canUpdate";

  /**
   * The result of the canUpdate operation evaluation.
   */
  @visibility(Lifecycle.Read)
  result?: CanUpdateResult;
}

/**
 * Response for canMerge operation evaluation.
 */
model CanTransactCanMergeResponse extends CanTransactResponse {
  // Discriminator value: must be a literal string (not a union reference) matching a CanTransactOperationType value for proper polymorphic deserialization
  operationType: "canMerge";

  /**
   * The result of the canMerge operation evaluation.
   */
  @visibility(Lifecycle.Read)
  result?: CanMergeResult;
}

/**
 * Bulk response model for TenantLevelCanTransact operation with pagination support.
 */
model TenantLevelCanTransactBulkResponse
  is Azure.Core.Page<CanTransactResponse>;

// =====================================================
// ValidatePromotions Models (added in v2026_03_31_preview)
// =====================================================

/**
 * Request model for ValidatePromotions operation.
 */
@added(SaaSHubVersions.v2026_03_31_preview)
model ValidatePromotionsRequest {
  /**
   * List of products to evaluate for promotion eligibility.
   */
  @identifiers(#[])
  products: ValidatePromotionsProductRequest[];

  /**
   * Customer billing scope. Replaces customerAccountId/customerOrganizationId.
   * Required unless productContext properties are populated.
   * Supports multiple formats:
   * - Partial: /providers/Microsoft.Billing/billingAccounts/{baId}
   * - Full customer-led: /providers/Microsoft.Billing/billingAccounts/{baId}/billingProfiles/{profileId}/invoiceSections/{sectionId}
   * - Full partner-led: /providers/Microsoft.Billing/billingAccounts/{baId}/billingProfiles/{profileId}/customers/{customerId}
   */
  customerBillingScope?: string;

  /**
   * Partner billing scope (same format as customerBillingScope).
   */
  partnerBillingScope?: string;
}

/**
 * Product request for ValidatePromotions operation.
 */
@added(SaaSHubVersions.v2026_03_31_preview)
model ValidatePromotionsProductRequest {
  /**
   * GUID representing productId, skuId, termDuration, billingPlan combination.
   */
  productCode: string;

  /**
   * Number of seats to purchase.
   */
  quantity?: int64;

  /**
   * Purchase term end date in UTC time.
   */
  termEndDate?: utcDateTime;

  /**
   * Evaluation type for the promotion eligibility check.
   * Valid values: "Immediate", "ScheduledChange"
   */
  evaluationType?: string;

  /**
   * Resource URI for ScheduledChange evaluation type.
   * Format: /providers/Microsoft.SaaSHub/saasResources/{resourceName}
   */
  resourceUri?: string;

  /**
   * Custom item identifier for tracking.
   */
  itemTrackingId?: string;

  /**
   * Product hydration tokens for authorization and context purposes.
   */
  @identifiers(#["type"])
  resourceTokens?: ResourceToken[];

  /**
   * Product context containing market information and tenant context.
   * Required if billing scope properties are not provided.
   */
  productContext?: ValidatePromotionsProductContext;

  /**
   * The discounts for conditional discounts (e.g., CSP Growth Margin).
   */
  @identifiers(#[])
  discounts?: Discount[];
}

/**
 * Product context for ValidatePromotions request containing market and tenant information.
 */
@added(SaaSHubVersions.v2026_03_31_preview)
model ValidatePromotionsProductContext {
  /**
   * ISO 3166 country code for the market.
   */
  market: string;

  /**
   * Cloud environment (e.g., "Public", "USGov", "China").
   */
  nationalCloud: string;

  /**
   * Pricing audience (e.g., "Direct-Commercial").
   */
  pricingAudience: string;

  /**
   * AAD tenant ID for the customer.
   */
  customerTenantId: string;

  /**
   * AAD tenant ID for the partner.
   */
  partnerTenantId?: string;
}

/**
 * Response model for ValidatePromotions operation with pagination support.
 */
@added(SaaSHubVersions.v2026_03_31_preview)
model ValidatePromotionsResponse
  is Azure.Core.Page<ValidatePromotionsProductResult>;

/**
 * Product result for ValidatePromotions operation.
 */
@added(SaaSHubVersions.v2026_03_31_preview)
model ValidatePromotionsProductResult {
  /**
   * Request metadata echoed back for correlation purposes.
   */
  @visibility(Lifecycle.Read)
  requestMetadata: ValidatePromotionsRequestMetadata;

  /**
   * Promotion eligibility results for this product.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  eligibilityResults: CanCreateResultPromotionInfo[];
}

/**
 * Request metadata for ValidatePromotions response, echoed back for correlation.
 */
@added(SaaSHubVersions.v2026_03_31_preview)
model ValidatePromotionsRequestMetadata {
  /**
   * GUID representing productId, skuId, termDuration, billingPlan combination.
   */
  @visibility(Lifecycle.Read)
  productCode: string;

  /**
   * Number of seats to purchase.
   */
  @visibility(Lifecycle.Read)
  quantity?: int64;

  /**
   * Resource URI from the request.
   */
  @visibility(Lifecycle.Read)
  resourceUri?: string;

  /**
   * Customer billing scope from the request.
   */
  @visibility(Lifecycle.Read)
  customerBillingScope?: string;

  /**
   * Partner billing scope from the request.
   */
  @visibility(Lifecycle.Read)
  partnerBillingScope?: string;

  /**
   * Custom item identifier for tracking, returned as-is from request.
   */
  @visibility(Lifecycle.Read)
  itemTrackingId?: string;

  /**
   * ISO 3166 country code for the market.
   */
  @visibility(Lifecycle.Read)
  market?: string;

  /**
   * Cloud environment (e.g., "Public", "USGov", "China").
   */
  @visibility(Lifecycle.Read)
  nationalCloud?: string;

  /**
   * Pricing audience (e.g., "Direct-Commercial").
   */
  @visibility(Lifecycle.Read)
  pricingAudience?: string;

  /**
   * AAD tenant ID for the customer.
   */
  @visibility(Lifecycle.Read)
  customerTenantId?: string;

  /**
   * AAD tenant ID for the partner.
   */
  @visibility(Lifecycle.Read)
  partnerTenantId?: string;

  /**
   * Purchase term end date in UTC time.
   */
  @visibility(Lifecycle.Read)
  termEndDate?: utcDateTime;

  /**
   * Evaluation type for the promotion eligibility check.
   * Valid values: "Immediate", "ScheduledChange"
   */
  @visibility(Lifecycle.Read)
  evaluationType?: string;

  /**
   * The discounts for conditional discounts (e.g., CSP Growth Margin).
   * Only one discount is expected and supported per transaction for CSP Growth Margin.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  discounts?: Discount[];
}

/**
 * Discount containing type and value for conditional discounts (e.g., CSP Growth Margin).
 */
@added(SaaSHubVersions.v2026_03_31_preview)
model Discount {
  /**
   * The type of the discount.
   */
  type?: string;

  /**
   * The value of the discount.
   */
  value?: string;
}

/**
 * Promotion eligibility constraint with detailed evaluation results.
 * Extends EligibilityConstraint with additional type-specific properties.
 *
 * Properties are grouped by constraintType:
 * - **firstPurchase**: Uses base properties only (constraintType, isEligible, failureDetails)
 * - **newCustomer**: Uses base properties only (constraintType, isEligible, failureDetails)
 * - **seatQuantity**: minSeatQuantityConstraint, maxSeatQuantityConstraint, currentSeatQuantityPurchased, minSeatQuantityRequiredToBePurchased, maxSeatQuantityWhichCanBePurchased
 * - **termDuration**: eligibleTermDurations, eligibleChargeDurations
 * - **qualifyingSubscriptionCoterminosity**: qualifyingSubscriptionTermEndDate, purchaseTermEndDate
 * - **productOwnership**: productsWhichMustAlreadyBeOwned
 * - **redemptionLimit**: maxPromotionRedemptionCount, remainingPromotionRedemptionCount, previousPromotionRedemptionCount
 * - **renewalPurchaseQuantity**: minEligibleSeatQuantity, maxEligibleSeatQuantity, renewalSeatQuantity, eligiblePurchaseLineItems
 * - **productLifetimeOwnershipExclusion**: failureDetails (with resourceUris and condition)
 * - **prerequisiteConstraints**: mustHaveAtLeastOne, mustHaveAny, mustHaveNone, failureDetails
 * - **newToOfferGrowthMarginDiscount**: minNewToOfferConstraint, maxNewToOfferConstraint, currentNewToOfferPurchased, minNewToOfferRequiredToBePurchased, maxNewToOfferWhichCanBePurchased
 * - **seatExpansionGrowthMarginDiscount**: minSeatExpansionConstraint, maxSeatExpansionConstraint, currentSeatExpansionPurchased, minSeatExpansionRequiredToBePurchased, maxSeatExpansionWhichCanBePurchased
 * - **upsellGrowthMarginDiscount**: minRequiredRatioThreshold, maxRequiredRatioThreshold, currentRatio, currentUpsellQuantity, requiredUpsellQuantity, minUpsellQuantityRequired
 */
@added(SaaSHubVersions.v2026_03_31_preview)
model PromotionEligibilityConstraint {
  ...EligibilityConstraint;

  // ─────────────────────────────────────────────────────────────────
  // seatQuantity constraint properties
  // ─────────────────────────────────────────────────────────────────

  /**
   * Minimum seat quantity constraint.
   * Applicable when constraintType = "seatQuantity"
   */
  @visibility(Lifecycle.Read)
  minSeatQuantityConstraint?: int64;

  /**
   * Maximum seat quantity constraint.
   * Applicable when constraintType = "seatQuantity"
   */
  @visibility(Lifecycle.Read)
  maxSeatQuantityConstraint?: int64;

  /**
   * Current seat quantity purchased.
   * Applicable when constraintType = "seatQuantity"
   */
  @visibility(Lifecycle.Read)
  currentSeatQuantityPurchased?: int64;

  /**
   * Minimum seat quantity required to be purchased.
   * Applicable when constraintType = "seatQuantity"
   */
  @visibility(Lifecycle.Read)
  minSeatQuantityRequiredToBePurchased?: int64;

  /**
   * Maximum seat quantity which can be purchased.
   * Applicable when constraintType = "seatQuantity"
   */
  @visibility(Lifecycle.Read)
  maxSeatQuantityWhichCanBePurchased?: int64;

  // ─────────────────────────────────────────────────────────────────
  // termDuration constraint properties
  // ─────────────────────────────────────────────────────────────────

  /**
   * Eligible term durations. Example: ["P1Y", "P3Y"]
   * Applicable when constraintType = "termDuration"
   */
  @visibility(Lifecycle.Read)
  eligibleTermDurations?: string[];

  /**
   * Eligible charge durations. Example: ["P1Y"]
   * Applicable when constraintType = "termDuration"
   */
  @visibility(Lifecycle.Read)
  eligibleChargeDurations?: string[];

  // ─────────────────────────────────────────────────────────────────
  // qualifyingSubscriptionCoterminosity constraint properties
  // ─────────────────────────────────────────────────────────────────

  /**
   * Qualifying subscription term end date.
   * Applicable when constraintType = "qualifyingSubscriptionCoterminosity"
   */
  @visibility(Lifecycle.Read)
  qualifyingSubscriptionTermEndDate?: utcDateTime;

  /**
   * Purchase term end date.
   * Applicable when constraintType = "qualifyingSubscriptionCoterminosity"
   */
  @visibility(Lifecycle.Read)
  purchaseTermEndDate?: utcDateTime;

  // ─────────────────────────────────────────────────────────────────
  // productOwnership constraint properties
  // ─────────────────────────────────────────────────────────────────

  /**
   * Products which must already be owned. Each inner array represents products grouped by productId.
   * Applicable when constraintType = "productOwnership"
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  productsWhichMustAlreadyBeOwned?: string[][];

  // ─────────────────────────────────────────────────────────────────
  // redemptionLimit constraint properties
  // ─────────────────────────────────────────────────────────────────

  /**
   * Maximum promotion redemption count allowed.
   * Applicable when constraintType = "redemptionLimit"
   */
  @visibility(Lifecycle.Read)
  maxPromotionRedemptionCount?: int64;

  /**
   * Remaining promotion redemption count.
   * Applicable when constraintType = "redemptionLimit"
   */
  @visibility(Lifecycle.Read)
  remainingPromotionRedemptionCount?: int64;

  /**
   * Previous promotion redemption count.
   * Applicable when constraintType = "redemptionLimit"
   */
  @visibility(Lifecycle.Read)
  previousPromotionRedemptionCount?: int64;

  // ─────────────────────────────────────────────────────────────────
  // renewalPurchaseQuantity constraint properties
  // ─────────────────────────────────────────────────────────────────

  /**
   * Minimum eligible seat quantity for renewal.
   * Applicable when constraintType = "renewalPurchaseQuantity"
   */
  @visibility(Lifecycle.Read)
  minEligibleSeatQuantity?: int64;

  /**
   * Maximum eligible seat quantity for renewal.
   * Applicable when constraintType = "renewalPurchaseQuantity"
   */
  @visibility(Lifecycle.Read)
  maxEligibleSeatQuantity?: int64;

  /**
   * Renewal seat quantity.
   * Applicable when constraintType = "renewalPurchaseQuantity"
   */
  @visibility(Lifecycle.Read)
  renewalSeatQuantity?: int64;

  /**
   * Eligible purchase line items for renewal.
   * Applicable when constraintType = "renewalPurchaseQuantity"
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  eligiblePurchaseLineItems?: EligiblePurchaseLineItem[];

  // ─────────────────────────────────────────────────────────────────
  // prerequisiteConstraints constraint properties
  // ─────────────────────────────────────────────────────────────────

  /**
   * MustHaveAtLeastOne constraint group - all products in this group must be owned.
   * Applicable when constraintType = "prerequisiteConstraints"
   */
  @visibility(Lifecycle.Read)
  mustHaveAtLeastOne?: PrerequisiteConstraintGroup;

  /**
   * MustHaveAny constraint group - at least one product in this group must be owned.
   * Applicable when constraintType = "prerequisiteConstraints"
   */
  @visibility(Lifecycle.Read)
  mustHaveAny?: PrerequisiteConstraintGroup;

  /**
   * MustHaveNone constraint group - none of the products in this group should be owned.
   * Applicable when constraintType = "prerequisiteConstraints"
   */
  @visibility(Lifecycle.Read)
  mustHaveNone?: PrerequisiteConstraintGroup;

  // ─────────────────────────────────────────────────────────────────
  // newToOfferGrowthMarginDiscount constraint properties
  // ─────────────────────────────────────────────────────────────────

  /**
   * Minimum new-to-offer quantity constraint.
   * Applicable when constraintType = "newToOfferGrowthMarginDiscount"
   */
  @visibility(Lifecycle.Read)
  minNewToOfferConstraint?: int64;

  /**
   * Maximum new-to-offer quantity constraint.
   * Applicable when constraintType = "newToOfferGrowthMarginDiscount"
   */
  @visibility(Lifecycle.Read)
  maxNewToOfferConstraint?: int64;

  /**
   * Current new-to-offer quantity purchased.
   * Applicable when constraintType = "newToOfferGrowthMarginDiscount"
   */
  @visibility(Lifecycle.Read)
  currentNewToOfferPurchased?: int64;

  /**
   * Minimum new-to-offer quantity required to be purchased.
   * Applicable when constraintType = "newToOfferGrowthMarginDiscount"
   */
  @visibility(Lifecycle.Read)
  minNewToOfferRequiredToBePurchased?: int64;

  /**
   * Maximum new-to-offer quantity which can be purchased.
   * Applicable when constraintType = "newToOfferGrowthMarginDiscount"
   */
  @visibility(Lifecycle.Read)
  maxNewToOfferWhichCanBePurchased?: int64;

  // ─────────────────────────────────────────────────────────────────
  // seatExpansionGrowthMarginDiscount constraint properties
  // ─────────────────────────────────────────────────────────────────

  /**
   * Minimum seat expansion quantity constraint.
   * Applicable when constraintType = "seatExpansionGrowthMarginDiscount"
   */
  @visibility(Lifecycle.Read)
  minSeatExpansionConstraint?: int64;

  /**
   * Maximum seat expansion quantity constraint.
   * Applicable when constraintType = "seatExpansionGrowthMarginDiscount"
   */
  @visibility(Lifecycle.Read)
  maxSeatExpansionConstraint?: int64;

  /**
   * Current seat expansion quantity purchased.
   * Applicable when constraintType = "seatExpansionGrowthMarginDiscount"
   */
  @visibility(Lifecycle.Read)
  currentSeatExpansionPurchased?: int64;

  /**
   * Minimum seat expansion quantity required to be purchased.
   * Applicable when constraintType = "seatExpansionGrowthMarginDiscount"
   */
  @visibility(Lifecycle.Read)
  minSeatExpansionRequiredToBePurchased?: int64;

  /**
   * Maximum seat expansion quantity which can be purchased.
   * Applicable when constraintType = "seatExpansionGrowthMarginDiscount"
   */
  @visibility(Lifecycle.Read)
  maxSeatExpansionWhichCanBePurchased?: int64;

  // ─────────────────────────────────────────────────────────────────
  // upsellGrowthMarginDiscount constraint properties
  // ─────────────────────────────────────────────────────────────────

  /**
   * Minimum required upsell-to-base ratio threshold.
   * Applicable when constraintType = "upsellGrowthMarginDiscount"
   */
  @visibility(Lifecycle.Read)
  minRequiredRatioThreshold?: float64;

  /**
   * Maximum required upsell-to-base ratio threshold.
   * Applicable when constraintType = "upsellGrowthMarginDiscount"
   */
  @visibility(Lifecycle.Read)
  maxRequiredRatioThreshold?: float64;

  /**
   * Customer's current upsell-to-base ratio.
   * Applicable when constraintType = "upsellGrowthMarginDiscount"
   */
  @visibility(Lifecycle.Read)
  currentRatio?: float64;

  /**
   * Current upsell seat quantity owned by the customer.
   * Applicable when constraintType = "upsellGrowthMarginDiscount"
   */
  @visibility(Lifecycle.Read)
  currentUpsellQuantity?: int64;

  /**
   * Required upsell seat quantity to meet the constraint.
   * Applicable when constraintType = "upsellGrowthMarginDiscount"
   */
  @visibility(Lifecycle.Read)
  requiredUpsellQuantity?: int64;

  /**
   * Minimum upsell seats that must be purchased.
   * Applicable when constraintType = "upsellGrowthMarginDiscount"
   */
  @visibility(Lifecycle.Read)
  minUpsellQuantityRequired?: int64;

  // ─────────────────────────────────────────────────────────────────
  // Shared properties (applicable to multiple constraint types)
  // ─────────────────────────────────────────────────────────────────

  /**
   * Failure details for the constraint evaluation.
   * Applicable to all constraint types when constraint fails.
   * For "productLifetimeOwnershipExclusion", contains resourceUris and condition details.
   * For "prerequisiteConstraints", contains failedConstraintGroup and productCodes.
   */
  @visibility(Lifecycle.Read)
  failureDetails?: ConstraintFailureDetails;
}

/**
 * Eligible purchase line item for renewal purchase quantity constraint.
 */
@added(SaaSHubVersions.v2026_03_31_preview)
model EligiblePurchaseLineItem {
  /**
   * Product code for the line item.
   */
  @visibility(Lifecycle.Read)
  productCode?: string;

  /**
   * Pricing audience for the line item.
   */
  @visibility(Lifecycle.Read)
  pricingAudience?: string;

  /**
   * Quantity of seats for the line item.
   */
  @visibility(Lifecycle.Read)
  quantity?: int64;

  /**
   * Start date for the line item.
   */
  @visibility(Lifecycle.Read)
  startDate?: utcDateTime;

  /**
   * Resource URI for the line item.
   */
  @visibility(Lifecycle.Read)
  resourceUri?: string;

  /**
   * Whether the line item has a discount.
   */
  @visibility(Lifecycle.Read)
  hasDiscount?: boolean;

  /**
   * Seat cap for the line item.
   */
  @visibility(Lifecycle.Read)
  seatCap?: int64;
}

/**
 * Prerequisite constraint group for promotion eligibility.
 */
@added(SaaSHubVersions.v2026_03_31_preview)
model PrerequisiteConstraintGroup {
  /**
   * Whether the constraints in this group are met.
   */
  @visibility(Lifecycle.Read)
  constraintsMet?: boolean;

  /**
   * Lookback window for the constraint evaluation.
   */
  @visibility(Lifecycle.Read)
  lookbackWindow?: LookbackWindow;

  /**
   * Products in this constraint group.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  products?: PrerequisiteProduct[];

  /**
   * Cumulative seat constraint for this group.
   */
  @visibility(Lifecycle.Read)
  cumulativeSeatConstraint?: CumulativeSeatConstraint;
}

/**
 * Lookback window for prerequisite constraint evaluation.
 */
@added(SaaSHubVersions.v2026_03_31_preview)
model LookbackWindow {
  /**
   * Type of lookback window. Valid values: "Lifetime", "Period"
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Period duration for the lookback window (e.g., "P6M"). Only applicable when type is "Period".
   */
  @visibility(Lifecycle.Read)
  period?: string;
}

/**
 * Prerequisite product for constraint evaluation.
 */
@added(SaaSHubVersions.v2026_03_31_preview)
model PrerequisiteProduct {
  /**
   * Product codes grouped by productId/skuId.
   */
  @visibility(Lifecycle.Read)
  productCodes?: string[];

  /**
   * Required minimum seats for this product.
   */
  @visibility(Lifecycle.Read)
  requiredMinSeats?: int64;

  /**
   * Required maximum seats for this product.
   */
  @visibility(Lifecycle.Read)
  requiredMaxSeats?: int64;

  /**
   * Actual seats owned by the customer.
   */
  @visibility(Lifecycle.Read)
  actualSeats?: int64;
}

/**
 * Cumulative seat constraint for prerequisite groups.
 */
@added(SaaSHubVersions.v2026_03_31_preview)
model CumulativeSeatConstraint {
  /**
   * Required minimum cumulative seats.
   */
  @visibility(Lifecycle.Read)
  requiredMinSeats?: int64;

  /**
   * Required maximum cumulative seats.
   */
  @visibility(Lifecycle.Read)
  requiredMaxSeats?: int64;

  /**
   * Actual cumulative seats owned by the customer.
   */
  @visibility(Lifecycle.Read)
  actualCumulativeSeats?: int64;
}

/**
 * Failure details for constraint evaluation.
 */
@added(SaaSHubVersions.v2026_03_31_preview)
model ConstraintFailureDetails {
  /**
   * Failure message describing why the constraint failed.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * List of failing items with details.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  failingItems?: ConstraintFailingItem[];
}

/**
 * Failing item for constraint failure details.
 */
@added(SaaSHubVersions.v2026_03_31_preview)
model ConstraintFailingItem {
  /**
   * Resource URIs associated with the failing item.
   */
  @visibility(Lifecycle.Read)
  resourceUris?: string[];

  /**
   * Condition that caused the failure.
   */
  @visibility(Lifecycle.Read)
  condition?: FailingItemCondition;

  /**
   * Failed constraint group name (for prerequisiteConstraints).
   */
  @visibility(Lifecycle.Read)
  failedConstraintGroup?: string;

  /**
   * Product codes associated with the failing item.
   */
  @visibility(Lifecycle.Read)
  productCodes?: string[];
}

/**
 * Condition for failing item.
 */
@added(SaaSHubVersions.v2026_03_31_preview)
model FailingItemCondition {
  /**
   * Product code that caused the failure.
   */
  @visibility(Lifecycle.Read)
  productCode?: string;
}

/**
 * Participant in a transfer operation.
 */
@added(SaaSHubVersions.v2026_03_31_preview)
model TransferParticipant {
  /**
   * The account identifier of the participant.
   * Must be one of msa:{puid}, org:{tid}, org:{tid}:{oid}, or mpn:{mpnid}
   */
  accountId: string;

  /**
   * The profile of the participant account.
   * Must be set to UNUSED when using accountId format mpn:{mpnid}
   */
  profileId?: string;

  /**
   * The role that a participant account is playing on the transfer.
   * Possible values include IndirectReseller, AdvisoryPartner, ManagingPartner, TransactingPartner, Customer.
   */
  roleType?: string;
}

/**
 * Request to transfer a SaaS resource to another partner tenant.
 */
@added(SaaSHubVersions.v2026_03_31_preview)
model TransferToPartnerRequest {
  /**
   * The identifier of the recipient partner (beneficiary) to transfer the resource to.
   * Format: tid:{tenantId} for org account, or tid:{tenantId}:{objectId} for individual account.
   */
  beneficiaryId: string;

  /**
   * The full billing scope of the recipient partner.
   * Format: /providers/Microsoft.Billing/billingAccounts/{baId}/billingProfiles/{bfId}/invoiceSections/{isId}
   */
  billingScope: string;

  /**
   * Optional list of participants in the transfer operation.
   */
  @identifiers(#[])
  participants?: TransferParticipant[];
}

// =====================================================
// ValidateFuturePriceEligibility Models (added in v2026_03_31_preview)
// =====================================================

/**
 * Request model for ValidateFuturePriceEligibility operation.
 * Evaluates whether customers qualify for future price concessions when purchasing Microsoft 365 products.
 */
@added(SaaSHubVersions.v2026_03_31_preview)
model ValidateFuturePriceEligibilityRequest {
  /**
   * Products to evaluate for future price eligibility.
   */
  @identifiers(#[])
  targetProducts: ValidateFuturePriceEligibilityTargetProduct[];

  /**
   * Products that may establish ownership baseline for future price eligibility.
   * These are products being purchased in the current transaction.
   */
  @identifiers(#[])
  copurchasedProducts?: ValidateFuturePriceEligibilityCopurchasedProduct[];

  /**
   * ARM billing scope for the customer.
   * Format: /providers/Microsoft.Billing/billingAccounts/{baId}
   * Mutually exclusive with productContext on products; provide either customerBillingScope or productContext on each product.
   */
  customerBillingScope?: string;
}

/**
 * Target product for ValidateFuturePriceEligibility operation.
 */
@added(SaaSHubVersions.v2026_03_31_preview)
model ValidateFuturePriceEligibilityTargetProduct {
  /**
   * Upn value of the product, which can be used to resolve product Id/sku Id/availability Id/term Id.
   */
  productCode: string;

  /**
   * Product context containing market and cloud information.
   * Optional; required if billingScope properties are not provided.
   */
  productContext?: ValidateFuturePriceEligibilityProductContext;

  /**
   * Item identifier for tracking.
   */
  itemTrackingId: string;

  /**
   * Optional array of resource tokens for product hydration.
   */
  @identifiers(#["type"])
  resourceTokens?: ResourceToken[];
}

/**
 * Copurchased product for ValidateFuturePriceEligibility operation.
 * Products being purchased in the current transaction that establish ownership baseline.
 */
@added(SaaSHubVersions.v2026_03_31_preview)
model ValidateFuturePriceEligibilityCopurchasedProduct {
  /**
   * Upn value of the product, which can be used to resolve product Id/sku Id/availability Id/term Id.
   */
  productCode: string;

  /**
   * Product context containing market and cloud information.
   * Optional; required if billingScope properties are not provided.
   */
  productContext?: ValidateFuturePriceEligibilityProductContext;

  /**
   * Number of seats being purchased.
   */
  quantity: int64;

  /**
   * Term start date in ISO 8601 format.
   */
  startDate?: utcDateTime;

  /**
   * ARM resource URI for existing asset.
   * Format: /providers/Microsoft.SaaSHub/saasResources/{resourceName}
   */
  resourceId?: string;

  /**
   * Whether item has discount applied.
   */
  hasDiscount?: boolean;

  /**
   * Seat cap for the product.
   */
  seatCap?: int64;

  /**
   * Item identifier for tracking.
   */
  itemTrackingId?: string;

  /**
   * Optional array of resource tokens for product hydration.
   */
  @identifiers(#["type"])
  resourceTokens?: ResourceToken[];
}

/**
 * Product context for ValidateFuturePriceEligibility request containing market and cloud information.
 */
@added(SaaSHubVersions.v2026_03_31_preview)
model ValidateFuturePriceEligibilityProductContext {
  /**
   * ISO 3166 country code for the market.
   */
  market: string;

  /**
   * Cloud environment.
   */
  nationalCloud: string;

  /**
   * Pricing audience.
   */
  pricingAudience: string;
}

/**
 * Response model for ValidateFuturePriceEligibility operation with pagination support.
 */
@added(SaaSHubVersions.v2026_03_31_preview)
model ValidateFuturePriceEligibilityResponse
  is Azure.Core.Page<ValidateFuturePriceEligibilityProductResult>;

/**
 * Product result for ValidateFuturePriceEligibility operation.
 */
@added(SaaSHubVersions.v2026_03_31_preview)
model ValidateFuturePriceEligibilityProductResult {
  /**
   * Request metadata echoed back for correlation.
   */
  @visibility(Lifecycle.Read)
  requestMetadata: ValidateFuturePriceEligibilityRequestMetadata;

  /**
   * Groups of qualifying coterminous resources for future price concessions.
   * Reuses the existing CanCreateResultFuturePriceInfo model structure.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  qualifyingCoterminousResources?: CanCreateResultFuturePriceInfo[];
}

/**
 * Request metadata for ValidateFuturePriceEligibility response, echoed back for correlation.
 */
@added(SaaSHubVersions.v2026_03_31_preview)
model ValidateFuturePriceEligibilityRequestMetadata {
  /**
   * Upn value of the product, which can be used to resolve product Id/sku Id/availability Id/term Id.
   */
  @visibility(Lifecycle.Read)
  productCode: string;

  /**
   * Pricing audience for the product.
   */
  @visibility(Lifecycle.Read)
  pricingAudience?: string;

  /**
   * Item identifier for tracking.
   */
  @visibility(Lifecycle.Read)
  itemTrackingId?: string;

  /**
   * ARM billing scope for the customer, echoed from request.
   */
  @visibility(Lifecycle.Read)
  customerBillingScope?: string;
}
