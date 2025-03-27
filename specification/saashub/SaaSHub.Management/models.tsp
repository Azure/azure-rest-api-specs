import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

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
 * The status of the saas resource.
 */
union SaasResourceStatus {
  string,

  /**
   * Saas resource status is unknown
   */
  Unknown: "Unknown",

  /**
   * Saas resource status is active
   */
  Active: "Active",

  /**
   * Saas resource status is disabled
   */
  Disabled: "Disabled",

  /**
   * Saas resource status is deleted
   */
  Deleted: "Deleted",

  /**
   * Saas resource status is past due
   */
  PastDue: "PastDue",

  /**
   * Saas resource status is expiring
   */
  Expiring: "Expiring",

  /**
   * Saas resource status is expired
   */
  Expired: "Expired",

  /**
   * Saas resource status is auto renew
   */
  AutoRenew: "AutoRenew",

  /**
   * Saas resource status is cancelled
   */
  Cancelled: "Cancelled",

  /**
   * Saas resource status is suspended
   */
  Suspended: "Suspended",
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
 * The properties of a SaaSHub saas resource.
 */
model SaasResourceProperties {
  /**
   * Indicates whether auto renewal is turned on or off for a SaaSHub saas resource. The default value will be 'On' for products that support autorenew.
   */
  autoRenew?: AutoRenew;

  /**
   * The billing scope to use for purchasing the resource. Needs full billing scope to invoice section level like: providers/Microsoft.Billing/billingAccounts/{baId}/billingProfiles/{bfId}/invoiceSections/{isId}
   */
  billingScope?: string;

  /**
   * The billing subscription id linked to this resource, with full format like /providers/Microsoft.Billing/billingAccounts/1111:2222/billingSubscriptions/Id
   */
  @visibility(Lifecycle.Read)
  billingSubscriptionId?: string;

  /**
   * The end customer billing account in CSP scenario, will full format like /providers/Microsoft.Billing/billingAccounts/1111:2222
   */
  endCustomerBillingAccount?: string;

  /**
   * System imposed policies that regulate behavior of the resource.
   */
  systemOverrides?: SaasResourcePropertiesSystemOverrides;

  /**
   * The name of the saas resource.
   */
  displayName?: string;

  /**
   * Type of the product for which the saas resource is purchased
   */
  @visibility(Lifecycle.Read)
  productType?: string;

  /**
   * Type of the offer for which the saas resource is purchased
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
   * Gets the status of the SaaSHub saas resource at the time the operation was called.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The number of licenses purchased for the saas resource
   */
  quantity?: int64;

  /**
   * Renewal term details of the saas resource.
   */
  renewalTerm?: RenewalTermDetails;

  /**
   * The SKU description of the product for which the saas resource is purchased.
   */
  @visibility(Lifecycle.Read)
  skuDescription?: string;

  /**
   * The status of the saas resource.
   */
  @visibility(Lifecycle.Read)
  status?: SaasResourceStatus;

  /**
   * The suspension reason for a saas resource.
   */
  @visibility(Lifecycle.Read)
  suspensionReasons?: string[];

  /**
   * Term details of the saas resource.
   */
  term?: TermDetails;

  /**
   * The original resource uri, if the new resource will be created by splitting part of the licenses from an existing resource
   */
  originalResourceUri?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.SaaSHub/saasResources";
    }
  ]>;

  /**
   * The Id of the tenant where licenses will be provisioned for this resource. It will only be populated if licenses are provisioned in a different tenant.
   */
  provisioningTenantId?: string;

  /**
   * An external Id which could be used to reference other commerce system entity, such as OMS sub id or proposal id. ExternalId value will have "{externalSystem}:{externalId}", e.g. "oms:1111-2222-444-666"
   */
  externalId?: string;

  /**
   * Linked resources for the saas resource
   */
  linkedResources?: LinkedResources;

  /**
   * Billing token for current term transaction.
   */
  billingToken?: string;

  /**
   * Availability token for current term transaction.
   */
  availabilityToken?: string;
}

/**
 * System imposed policies that regulate behavior of the resource.
 */
model SaasResourcePropertiesSystemOverrides {
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
  billingToken?: string;

  /**
   * Availability token for renewal term transaction.
   */
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
   * Start date of the term in UTC time.
   */
  startDate?: utcDateTime;

  /**
   * End date of the term in UTC time. When there is a value passed in for PUT scenario, it is to support co-term scenario. When there is a value passed in for PATCH scenario, it is to support extend trial scenario. The time part passed in will be ignored
   */
  endDate?: utcDateTime;
}

/**
 * Request to check if the resource can be created
 */
model CanCreateRequest {
  /**
   * Resource name of the saas hub resource to be created.
   */
  name: string;

  /**
   * Resource type to be created, currently only supports SaaS resource type.
   */
  type: string;

  /**
   * The properties of the saas hub resource to be created.
   */
  properties: SaasResourceProperties;
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
  @extension("x-ms-identifiers", #[])
  promotion?: CanCreateResultPromotionInfo[];

  /**
   * Additional evaluation eligibility result for qualifying co-term resources for a future price concession. Null when constraints passed or not applicable.
   */
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  futurePrice?: CanCreateResultFuturePriceInfo[];

  /**
   * Additional detail when request payload failed coTerm constraints. Null when constraints passed or not applicable.
   */
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
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
  @extension("x-ms-identifiers", #[])
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
  @extension("x-ms-identifiers", #[])
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
  @extension("x-ms-identifiers", #[])
  qualifyingResources?: CanCreateResultFuturePriceQualifyingResource[];

  /**
   * Types of future price concession. E.g. FuturePriceNotToExceedCap, PercentageDiscount
   */
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
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
 * Request to merge multiple saas resource resources into one target saas resource resource
 */
model MergeSaasResourceRequest {
  /**
   * List of source resources to be merged into target resource.
   */
  sourceResources?: MergeSourceSaasResource[];
}

/**
 * Saas resource to be used in merge operation as source.
 */
model MergeSourceSaasResource {
  /**
   * Id of the saas resource
   */
  id?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.SaaSHub/saasResources";
    }
  ]>;

  /**
   * The quantity of license to be merged
   */
  quantity?: int64;

  /**
   * The validation error it ran into. Null when validation passed.
   */
  @visibility(Lifecycle.Read)
  validationError?: string;
}

/**
 * Validation result for canMerge operation.
 */
model CanMergeResult {
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
  additionalInfo?: MergeSourceSaasResource[];
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
  @extension("x-ms-identifiers", #[])
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
  @extension("x-ms-identifiers", #[])
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
