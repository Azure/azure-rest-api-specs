import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Billing;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Indicates whether auto renewal is turned on or off for a subscription.
 */
enum AutoRenew {
  Off,
  On,
}

/**
 * The current enrollment account status of the subscription. This field is available only for the Enterprise Agreement billing accounts.
 */
enum SubscriptionEnrollmentAccountStatus {
  Active,
  Cancelled,
  Expired,
  Deleted,
  TransferredOut,
  Transferring,
}

/**
 * The status of the subscription. This field is not available for Enterprise Agreement billing accounts.
 */
enum BillingSubscriptionStatus {
  Unknown,
  Active,
  Disabled,
  Deleted,
  Warned,
  Expiring,
  Expired,
  AutoRenew,
  Cancelled,
  Suspended,
}

/**
 * Error code of the transfer validation response.
 */
enum SubscriptionTransferValidationErrorCode {
  AccountIsLocked,
  AssetNotActive,
  AssetHasCap,
  BillingAccountInactive,
  BillingProfilePastDue,
  CrossBillingAccountNotAllowed,
  DestinationBillingProfileNotFound,
  DestinationBillingProfileInactive,
  DestinationBillingProfilePastDue,
  DestinationInvoiceSectionNotFound,
  DestinationInvoiceSectionInactive,
  InvalidDestination,
  InvalidSource,
  InvoiceSectionIsRestricted,
  InsufficientPermissionOnDestination,
  InsufficientPermissionOnSource,
  MarketplaceNotEnabledOnDestination,
  ProductNotFound,
  ProductInactive,
  ProductTypeNotSupported,
  SourceBillingProfilePastDue,
  SourceInvoiceSectionInactive,
  SubscriptionNotActive,
  SubscriptionTypeNotSupported,
}

/**
 * The family of payment method.
 */
enum PaymentMethodFamily {
  CreditCard,
  CheckWire,
}

/**
 * Status of the payment method.
 */
enum PaymentMethodStatus {
  active,
  inactive,
}

/**
 * Error code of the detach payment method eligibility validation response.
 */
enum DetachPaymentMethodEligibilityErrorCode {
  AzureSubscriptions,
  RecurringCharges,
  ReservedInstances,
  OutstandingCharges,
  PendingCharges,
}

/**
 * The billing properties of a subscription.
 */
model BillingSubscriptionProperties {
  /**
   * Indicates whether auto renewal is turned on or off for a subscription.
   */
  autoRenew?: AutoRenew;

  /**
   * The provisioning tenant of the subscription.
   */
  beneficiaryTenantId?: string;

  /**
   * The billing frequency of the subscription in the ISO8601 format. Example: P1M, P3M, P1Y
   */
  billingFrequency?: string;

  /**
   * The ID of the billing profile to which the subscription is billed. This field is only applicable for Microsoft Customer Agreement billing accounts.
   */
  billingProfileId?: string;

  /**
   * Dictionary of billing policies associated with the subscription.
   */
  @visibility("read")
  billingPolicies?: Record<string>;

  /**
   * The display name of the billing profile to which the subscription is billed. This field is only applicable for Microsoft Customer Agreement billing accounts.
   */
  @visibility("read")
  billingProfileDisplayName?: string;

  /**
   * The name of the billing profile to which the subscription is billed. This field is only applicable for Microsoft Customer Agreement billing accounts.
   */
  @visibility("read")
  billingProfileName?: string;

  /**
   * The cost center applied to the subscription. This field is only available for consumption subscriptions of Microsoft Customer Agreement Type billing accounts.
   */
  consumptionCostCenter?: string;

  /**
   * The ID of the customer for whom the subscription was created. The field is applicable only for Microsoft Partner Agreement billing accounts.
   */
  customerId?: string;

  /**
   * The name of the customer for whom the subscription was created. The field is applicable only for Microsoft Partner Agreement billing accounts.
   */
  @visibility("read")
  customerDisplayName?: string;

  /**
   * The name of the subscription.
   */
  displayName?: string;

  /**
   * The enrollment Account ID associated with the subscription. This field is available only for the Enterprise Agreement billing accounts.
   */
  @visibility("read")
  enrollmentAccountId?: string;

  /**
   * The enrollment Account name associated with the subscription. This field is available only for the Enterprise Agreement billing accounts.
   */
  @visibility("read")
  enrollmentAccountDisplayName?: string;

  /**
   * The billing properties that can be modified. This field is available only for the Enterprise Agreement billing accounts.
   */
  @visibility("read")
  @extension("x-ms-client-flatten", true)
  enrollmentAccountSubscriptionDetails?: EnrollmentAccountSubscriptionDetails;

  /**
   * The ID of the invoice section to which the subscription is billed. The field is applicable only for Microsoft Partner Agreement billing accounts.
   */
  invoiceSectionId?: string;

  /**
   * The display name of the invoice section to which the subscription is billed. The field is applicable only for Microsoft Partner Agreement billing accounts.
   */
  @visibility("read")
  invoiceSectionDisplayName?: string;

  /**
   * The name of the invoice section to which the subscription is billed. The field is applicable only for Microsoft Partner Agreement billing accounts.
   */
  @visibility("read")
  invoiceSectionName?: string;

  /**
   * The last month's charges. This field is only available for usage based subscriptions of Microsoft Customer Agreement billing accounts.
   */
  @visibility("read")
  lastMonthCharges?: Amount;

  /**
   * The current month to date charges. This field is only available for usage based subscriptions of Microsoft Customer Agreement billing accounts.
   */
  @visibility("read")
  monthToDateCharges?: Amount;

  /**
   * Next billing cycle details of the subscription.
   */
  @visibility("read")
  nextBillingCycleDetails?: NextBillingCycleDetails;

  /**
   * The offer ID for the subscription. This field is only available for the Microsoft Online Services Program billing accounts.
   */
  @visibility("read")
  offerId?: string;

  /**
   * The category of the product for which the subscription is purchased. Possible values include: AzureSupport, Hardware, ReservationOrder, SaaS, SavingsPlanOrder, Software, UsageBased, Other
   */
  @visibility("read")
  productCategory?: string;

  /**
   * The type of the product for which the subscription is purchased
   */
  @visibility("read")
  productType?: string;

  /**
   * The ID of the product for which the subscription is purchased
   */
  productTypeId?: string;

  /**
   * The purchase date of the subscription in UTC time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  purchaseDate?: utcDateTime;

  /**
   * The number of licenses purchased for the subscription
   */
  quantity?: int64;

  /**
   * The reseller for which the subscription is created. The field is available for Microsoft Partner Agreement billing accounts.
   */
  @visibility("read")
  reseller?: Reseller;

  /**
   * The term details of the subscription at the next renewal.
   */
  @visibility("read")
  renewalTermDetails?: RenewalTermDetails;

  /**
   * The SKU description of the product for which the subscription is purchased. This field is only available for Microsoft Customer Agreement billing accounts.
   */
  @visibility("read")
  skuDescription?: string;

  /**
   * The SKU ID of the product for which the subscription is purchased. This field is only available for Microsoft Customer Agreement billing accounts.
   */
  skuId?: string;

  /**
   * The status of the subscription. This field is not available for Enterprise Agreement billing accounts.
   */
  @visibility("read")
  status?: BillingSubscriptionStatus;

  /**
   * The ID of the usage-based subscription. This field is only available for usage-based subscriptions of Microsoft Customer Agreement billing accounts.
   */
  @visibility("read")
  subscriptionId?: string;

  /**
   * The suspension reason for the subscription. This field is not available for Enterprise Agreement billing accounts.
   */
  @visibility("read")
  suspensionReasons?: string[];

  /**
   * The duration for which you can use the subscription. Example P1Y and P1M
   */
  termDuration?: duration;

  /**
   * The start date of the term in UTC time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  termStartDate?: utcDateTime;

  /**
   * The end date of the term in UTC time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  termEndDate?: utcDateTime;
}

/**
 * The billing properties that can be modified. This field is available only for the Enterprise Agreement billing accounts.
 */
model EnrollmentAccountSubscriptionDetails {
  /**
   * The current enrollment account status of the subscription. This field is available only for the Enterprise Agreement billing accounts.
   */
  @visibility("read")
  subscriptionEnrollmentAccountStatus?: SubscriptionEnrollmentAccountStatus;

  /**
   * The enrollment Account and the subscription association start date. This field is available only for the Enterprise Agreement billing accounts.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  enrollmentAccountStartDate?: utcDateTime;
}

/**
 * The amount.
 */
model Amount {
  /**
   * The currency for the amount value.
   */
  @visibility("read")
  currency?: string;

  /**
   * Amount value.
   */
  @visibility("read")
  value?: float32;
}

/**
 * The next billing cycle details of the subscription.
 */
model NextBillingCycleDetails {
  /**
   * The billing frequency of the subscription in the next billing cycle.
   */
  @visibility("read")
  billingFrequency?: string;
}

/**
 * Details of the reseller.
 */
model Reseller {
  /**
   * The MPN ID of the reseller.
   */
  @visibility("read")
  resellerId?: string;

  /**
   * The name of the reseller.
   */
  @visibility("read")
  description?: string;
}

/**
 * The term details of the subscription at renewal.
 */
model RenewalTermDetails {
  /**
   * The billing frequency of the subscription.
   */
  @visibility("read")
  billingFrequency?: string;

  /**
   * The ID of the product.
   */
  @visibility("read")
  productTypeId?: string;

  /**
   * The number of licenses
   */
  quantity?: int64;

  /**
   * The SKU ID of the product
   */
  @visibility("read")
  skuId?: string;

  /**
   * The term duration of the subscription. Example P1M and P1Y
   */
  @visibility("read")
  termDuration?: duration;
}

/**
 * The resource model definition.
 */
model Resource {
  /**
   * Resource Id.
   */
  @visibility("read")
  id?: string;

  /**
   * Resource name.
   */
  @visibility("read")
  name?: string;

  /**
   * Resource type.
   */
  @visibility("read")
  type?: string;
}

/**
 * The details of the error.
 */
model ErrorDetails {
  /**
   * Error code.
   */
  @visibility("read")
  code?: string;

  /**
   * Error message indicating why the operation failed.
   */
  @visibility("read")
  message?: string;

  /**
   * The target of the particular error.
   */
  @visibility("read")
  target?: string;

  /**
   * The sub details of the error.
   */
  details?: ErrorSubDetailsItem[];
}

model ErrorSubDetailsItem {
  /**
   * Error code.
   */
  @visibility("read")
  code?: string;

  /**
   * Error message indicating why the operation failed.
   */
  @visibility("read")
  message?: string;

  /**
   * The target of the particular error.
   */
  @visibility("read")
  target?: string;
}

/**
 * Request parameters to transfer billing subscription.
 */
model MoveBillingSubscriptionRequest {
  /**
   * The destination enrollment account id.
   */
  destinationEnrollmentAccountId?: string;

  /**
   * The destination invoice section id.
   */
  destinationInvoiceSectionId?: string;
}

/**
 * Result of the transfer eligibility validation.
 */
model ValidateMoveBillingSubscriptionEligibilityResult {
  /**
   * Specifies whether the subscription is eligible to move.
   */
  @visibility("read")
  isMoveEligible?: boolean;

  /**
   * Validation error details.
   */
  errorDetails?: ValidateMoveBillingSubscriptionEligibilityError;
}

/**
 * Error details of the transfer eligibility validation
 */
model ValidateMoveBillingSubscriptionEligibilityError {
  /**
   * Error code for the billing subscription move validation.
   */
  code?: SubscriptionTransferValidationErrorCode;

  /**
   * The error message.
   */
  message?: string;

  /**
   * Detailed error message explaining the error.
   */
  details?: string;
}

/**
 * Request to merge two billing subscriptions
 */
model BillingSubscriptionMergeRequest {
  /**
   * The ID of the target billing subscription that will be merged with the source subscription provided in the request.
   */
  targetBillingSubscriptionName?: string;

  /**
   * The quantity of the source billing subscription that will be merged with the target billing subscription.
   */
  quantity?: int32;
}

/**
 * Request to split a billing subscription
 */
model BillingSubscriptionSplitRequest {
  /**
   * The billing frequency of the target subscription in the ISO8601 format. Example: P1M, P3M, P1Y
   */
  billingFrequency?: string;

  /**
   * The quantity of the target product to which the subscription needs to be split into.
   */
  quantity?: int32;

  /**
   * The ID of the target product to which the subscription needs to be split into. This value is not same as the value returned in Get API call and can be retrieved from Catalog API to know the product id to split into.
   */
  targetProductTypeId?: string;

  /**
   * The ID of the target product to which the subscription needs to be split into. This value is not same as the value returned in Get API call and can be retrieved from Catalog API to know the sku id to split into.
   */
  targetSkuId?: string;

  /**
   * The term duration of the target in ISO8601 format product to which the subscription needs to be split into. Example: P1M, P1Y
   */
  termDuration?: duration;
}

/**
 * Billing subscription alias properties.
 */
model BillingSubscriptionAliasProperties extends BillingSubscriptionProperties {
  /**
   * The ID of the billing subscription with the subscription alias.
   */
  @visibility("read")
  billingSubscriptionId?: string;
}

/**
 * The properties of a payment method.
 */
model PaymentMethodProperties {
  /**
   * The family of payment method.
   */
  family?: PaymentMethodFamily;

  /**
   * The type of payment method.
   */
  @visibility("read")
  type?: string;

  /**
   * The account holder name for the payment method. This is only supported for payment methods with family CreditCard.
   */
  @visibility("read")
  accountHolderName?: string;

  /**
   * The expiration month and year of the payment method. This is only supported for payment methods with family CreditCard.
   */
  @visibility("read")
  expiration?: string;

  /**
   * Last four digits of payment method.
   */
  @visibility("read")
  lastFourDigits?: string;

  /**
   * The display name of the payment method.
   */
  @visibility("read")
  displayName?: string;

  /**
   * The list of logos for the payment method.
   */
  logos?: PaymentMethodLogo[];

  /**
   * Status of the payment method.
   */
  status?: PaymentMethodStatus;
}

/**
 * Logo of payment method.
 */
model PaymentMethodLogo {
  /**
   * MIME type of the logo.
   */
  @visibility("read")
  mimeType?: string;

  /**
   * Public URL of image of the logo.
   */
  @visibility("read")
  url?: string;
}

/**
 * The properties of a payment method link.
 */
model PaymentMethodLinkProperties {
  /**
   * Projection of a payment method
   */
  paymentMethod?: PaymentMethodProjectionProperties;
}

/**
 * The properties of a payment method projection.
 */
model PaymentMethodProjectionProperties {
  /**
   * Id of payment method.
   */
  @visibility("read")
  id?: string;

  /**
   * The family of payment method.
   */
  family?: PaymentMethodFamily;

  /**
   * The type of payment method.
   */
  @visibility("read")
  type?: string;

  /**
   * The account holder name for the payment method. This is only supported for payment methods with family CreditCard.
   */
  @visibility("read")
  accountHolderName?: string;

  /**
   * The expiration month and year of the payment method. This is only supported for payment methods with family CreditCard.
   */
  @visibility("read")
  expiration?: string;

  /**
   * Last four digits of payment method.
   */
  @visibility("read")
  lastFourDigits?: string;

  /**
   * The display name of the payment method.
   */
  @visibility("read")
  displayName?: string;

  /**
   * The list of logos for the payment method.
   */
  logos?: PaymentMethodLogo[];

  /**
   * Status of the payment method.
   */
  status?: PaymentMethodStatus;
}

/**
 * Error response indicates that payment method cannot be detached from billing profile.
 */
@error
model DetachPaymentMethodEligibilityResult {
  /**
   * The details of the error.
   */
  error?: DetachPaymentMethodEligibilityError;
}

/**
 * The details of the error.
 */
model DetachPaymentMethodEligibilityError {
  /**
   * Error code.
   */
  @visibility("read")
  code?: string;

  /**
   * Error message.
   */
  @visibility("read")
  message?: string;

  /**
   * The list of detach payment method eligibility errors.
   */
  @visibility("read")
  details?: DetachPaymentMethodErrorDetails[];
}

/**
 * Error details of the detach payment method eligibility validation.
 */
model DetachPaymentMethodErrorDetails {
  /**
   * Error code for the detach payment method eligibility validation.
   */
  code?: DetachPaymentMethodEligibilityErrorCode;

  /**
   * Error message for the detach payment method eligibility validation.
   */
  message?: string;
}

/**
 * The payment method resource model definition.
 */
model PaymentMethodResource {
  /**
   * The ID that uniquely identifies a payment method.
   */
  paymentMethodId?: string;
}
