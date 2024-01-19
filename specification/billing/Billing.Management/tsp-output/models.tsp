import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Billing;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Indicates whether auto renewal is turned on or off for a subscription.")
enum AutoRenew {
  Off,
  On,
}

@doc("The current enrollment account status of the subscription. This field is available only for the Enterprise Agreement billing accounts.")
enum SubscriptionEnrollmentAccountStatus {
  Active,
  Cancelled,
  Expired,
  Deleted,
  TransferredOut,
  Transferring,
}

@doc("The status of the subscription. This field is not available for Enterprise Agreement billing accounts.")
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

@doc("Error code of the transfer validation response.")
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

@doc("The family of payment method.")
enum PaymentMethodFamily {
  CreditCard,
  CheckWire,
}

@doc("Status of the payment method.")
enum PaymentMethodStatus {
  active,
  inactive,
}

@doc("Error code of the detach payment method eligibility validation response.")
enum DetachPaymentMethodEligibilityErrorCode {
  AzureSubscriptions,
  RecurringCharges,
  ReservedInstances,
  OutstandingCharges,
  PendingCharges,
}

@doc("The billing properties of a subscription.")
model BillingSubscriptionProperties {
  @doc("Indicates whether auto renewal is turned on or off for a subscription.")
  autoRenew?: AutoRenew;

  @doc("The provisioning tenant of the subscription.")
  beneficiaryTenantId?: string;

  @doc("The billing frequency of the subscription in the ISO8601 format. Example: P1M, P3M, P1Y")
  billingFrequency?: string;

  @doc("The ID of the billing profile to which the subscription is billed. This field is only applicable for Microsoft Customer Agreement billing accounts.")
  billingProfileId?: string;

  @doc("Dictionary of billing policies associated with the subscription.")
  @visibility("read")
  billingPolicies?: Record<string>;

  @doc("The display name of the billing profile to which the subscription is billed. This field is only applicable for Microsoft Customer Agreement billing accounts.")
  @visibility("read")
  billingProfileDisplayName?: string;

  @doc("The name of the billing profile to which the subscription is billed. This field is only applicable for Microsoft Customer Agreement billing accounts.")
  @visibility("read")
  billingProfileName?: string;

  @doc("The cost center applied to the subscription. This field is only available for consumption subscriptions of Microsoft Customer Agreement Type billing accounts.")
  consumptionCostCenter?: string;

  @doc("The ID of the customer for whom the subscription was created. The field is applicable only for Microsoft Partner Agreement billing accounts.")
  customerId?: string;

  @doc("The name of the customer for whom the subscription was created. The field is applicable only for Microsoft Partner Agreement billing accounts.")
  @visibility("read")
  customerDisplayName?: string;

  @doc("The name of the subscription.")
  displayName?: string;

  @doc("The enrollment Account ID associated with the subscription. This field is available only for the Enterprise Agreement billing accounts.")
  @visibility("read")
  enrollmentAccountId?: string;

  @doc("The enrollment Account name associated with the subscription. This field is available only for the Enterprise Agreement billing accounts.")
  @visibility("read")
  enrollmentAccountDisplayName?: string;

  @doc("The billing properties that can be modified. This field is available only for the Enterprise Agreement billing accounts.")
  @visibility("read")
  enrollmentAccountSubscriptionDetails?: EnrollmentAccountSubscriptionDetails;

  @doc("The ID of the invoice section to which the subscription is billed. The field is applicable only for Microsoft Partner Agreement billing accounts.")
  invoiceSectionId?: string;

  @doc("The display name of the invoice section to which the subscription is billed. The field is applicable only for Microsoft Partner Agreement billing accounts.")
  @visibility("read")
  invoiceSectionDisplayName?: string;

  @doc("The name of the invoice section to which the subscription is billed. The field is applicable only for Microsoft Partner Agreement billing accounts.")
  @visibility("read")
  invoiceSectionName?: string;

  @doc("The last month's charges. This field is only available for usage based subscriptions of Microsoft Customer Agreement billing accounts.")
  @visibility("read")
  lastMonthCharges?: Amount;

  @doc("The current month to date charges. This field is only available for usage based subscriptions of Microsoft Customer Agreement billing accounts.")
  @visibility("read")
  monthToDateCharges?: Amount;

  @doc("Next billing cycle details of the subscription.")
  @visibility("read")
  nextBillingCycleDetails?: NextBillingCycleDetails;

  @doc("The offer ID for the subscription. This field is only available for the Microsoft Online Services Program billing accounts.")
  @visibility("read")
  offerId?: string;

  @doc("The category of the product for which the subscription is purchased. Possible values include: AzureSupport, Hardware, ReservationOrder, SaaS, SavingsPlanOrder, Software, UsageBased, Other")
  @visibility("read")
  productCategory?: string;

  @doc("The type of the product for which the subscription is purchased")
  @visibility("read")
  productType?: string;

  @doc("The ID of the product for which the subscription is purchased")
  productTypeId?: string;

  @doc("The purchase date of the subscription in UTC time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  purchaseDate?: utcDateTime;

  @doc("The number of licenses purchased for the subscription")
  quantity?: int32;

  @doc("The reseller for which the subscription is created. The field is available for Microsoft Partner Agreement billing accounts.")
  @visibility("read")
  reseller?: Reseller;

  @doc("The term details of the subscription at the next renewal.")
  @visibility("read")
  renewalTermDetails?: RenewalTermDetails;

  @doc("The SKU description of the product for which the subscription is purchased. This field is only available for Microsoft Customer Agreement billing accounts.")
  @visibility("read")
  skuDescription?: string;

  @doc("The SKU ID of the product for which the subscription is purchased. This field is only available for Microsoft Customer Agreement billing accounts.")
  skuId?: string;

  @doc("The status of the subscription. This field is not available for Enterprise Agreement billing accounts.")
  @visibility("read")
  status?: BillingSubscriptionStatus;

  @doc("The ID of the usage-based subscription. This field is only available for usage-based subscriptions of Microsoft Customer Agreement billing accounts.")
  @visibility("read")
  subscriptionId?: string;

  @doc("The suspension reason for the subscription. This field is not available for Enterprise Agreement billing accounts.")
  @visibility("read")
  suspensionReasons?: string[];

  @doc("The duration for which you can use the subscription. Example P1Y and P1M")
  termDuration?: duration;

  @doc("The start date of the term in UTC time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  termStartDate?: utcDateTime;

  @doc("The end date of the term in UTC time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  termEndDate?: utcDateTime;
}

@doc("The billing properties that can be modified. This field is available only for the Enterprise Agreement billing accounts.")
model EnrollmentAccountSubscriptionDetails {
  @doc("The current enrollment account status of the subscription. This field is available only for the Enterprise Agreement billing accounts.")
  @visibility("read")
  subscriptionEnrollmentAccountStatus?: SubscriptionEnrollmentAccountStatus;

  @doc("The enrollment Account and the subscription association start date. This field is available only for the Enterprise Agreement billing accounts.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  enrollmentAccountStartDate?: utcDateTime;
}

@doc("The amount.")
model Amount {
  @doc("The currency for the amount value.")
  @visibility("read")
  currency?: string;

  @doc("Amount value.")
  @visibility("read")
  value?: float32;
}

@doc("The next billing cycle details of the subscription.")
model NextBillingCycleDetails {
  @doc("The billing frequency of the subscription in the next billing cycle.")
  @visibility("read")
  billingFrequency?: string;
}

@doc("Details of the reseller.")
model Reseller {
  @doc("The MPN ID of the reseller.")
  @visibility("read")
  resellerId?: string;

  @doc("The name of the reseller.")
  @visibility("read")
  description?: string;
}

@doc("The term details of the subscription at renewal.")
model RenewalTermDetails {
  @doc("The billing frequency of the subscription.")
  @visibility("read")
  billingFrequency?: string;

  @doc("The ID of the product.")
  @visibility("read")
  productTypeId?: string;

  @doc("The number of licenses")
  quantity?: int32;

  @doc("The SKU ID of the product")
  @visibility("read")
  skuId?: string;

  @doc("The term duration of the subscription. Example P1M and P1Y")
  @visibility("read")
  termDuration?: duration;
}

@doc("The resource model definition.")
model Resource {
  @doc("Resource Id.")
  @visibility("read")
  id?: string;

  @doc("Resource name.")
  @visibility("read")
  name?: string;

  @doc("Resource type.")
  @visibility("read")
  type?: string;
}

@doc("The details of the error.")
model ErrorDetails {
  @doc("Error code.")
  @visibility("read")
  code?: string;

  @doc("Error message indicating why the operation failed.")
  @visibility("read")
  message?: string;

  @doc("The target of the particular error.")
  @visibility("read")
  target?: string;

  @doc("The sub details of the error.")
  details?: ErrorSubDetailsItem[];
}

model ErrorSubDetailsItem {
  @doc("Error code.")
  @visibility("read")
  code?: string;

  @doc("Error message indicating why the operation failed.")
  @visibility("read")
  message?: string;

  @doc("The target of the particular error.")
  @visibility("read")
  target?: string;
}

@doc("Request parameters to transfer billing subscription.")
model MoveBillingSubscriptionRequest {
  @doc("The destination enrollment account id.")
  destinationEnrollmentAccountId?: string;

  @doc("The destination invoice section id.")
  destinationInvoiceSectionId?: string;
}

@doc("Result of the transfer eligibility validation.")
model ValidateMoveBillingSubscriptionEligibilityResult {
  @doc("Specifies whether the subscription is eligible to move.")
  @visibility("read")
  isMoveEligible?: boolean;

  @doc("Validation error details.")
  errorDetails?: ValidateMoveBillingSubscriptionEligibilityError;
}

@doc("Error details of the transfer eligibility validation")
model ValidateMoveBillingSubscriptionEligibilityError {
  @doc("Error code for the billing subscription move validation.")
  code?: SubscriptionTransferValidationErrorCode;

  @doc("The error message.")
  message?: string;

  @doc("Detailed error message explaining the error.")
  details?: string;
}

@doc("Request to merge two billing subscriptions")
model BillingSubscriptionMergeRequest {
  @doc("The ID of the target billing subscription that will be merged with the source subscription provided in the request.")
  targetBillingSubscriptionName?: string;

  @doc("The quantity of the source billing subscription that will be merged with the target billing subscription.")
  quantity?: int32;
}

@doc("Request to split a billing subscription")
model BillingSubscriptionSplitRequest {
  @doc("The billing frequency of the target subscription in the ISO8601 format. Example: P1M, P3M, P1Y")
  billingFrequency?: string;

  @doc("The quantity of the target product to which the subscription needs to be split into.")
  quantity?: int32;

  @doc("The ID of the target product to which the subscription needs to be split into. This value is not same as the value returned in Get API call and can be retrieved from Catalog API to know the product id to split into.")
  targetProductTypeId?: string;

  @doc("The ID of the target product to which the subscription needs to be split into. This value is not same as the value returned in Get API call and can be retrieved from Catalog API to know the sku id to split into.")
  targetSkuId?: string;

  @doc("The term duration of the target in ISO8601 format product to which the subscription needs to be split into. Example: P1M, P1Y")
  termDuration?: duration;
}

@doc("Billing subscription alias properties.")
model BillingSubscriptionAliasProperties extends BillingSubscriptionProperties {
  @doc("The ID of the billing subscription with the subscription alias.")
  @visibility("read")
  billingSubscriptionId?: string;
}

@doc("The properties of a payment method.")
model PaymentMethodProperties {
  @doc("The family of payment method.")
  family?: PaymentMethodFamily;

  @doc("The type of payment method.")
  @visibility("read")
  type?: string;

  @doc("The account holder name for the payment method. This is only supported for payment methods with family CreditCard.")
  @visibility("read")
  accountHolderName?: string;

  @doc("The expiration month and year of the payment method. This is only supported for payment methods with family CreditCard.")
  @visibility("read")
  expiration?: string;

  @doc("Last four digits of payment method.")
  @visibility("read")
  lastFourDigits?: string;

  @doc("The display name of the payment method.")
  @visibility("read")
  displayName?: string;

  @doc("The list of logos for the payment method.")
  logos?: PaymentMethodLogo[];

  @doc("Status of the payment method.")
  status?: PaymentMethodStatus;
}

@doc("Logo of payment method.")
model PaymentMethodLogo {
  @doc("MIME type of the logo.")
  @visibility("read")
  mimeType?: string;

  @doc("Public URL of image of the logo.")
  @visibility("read")
  url?: string;
}

@doc("The properties of a payment method link.")
model PaymentMethodLinkProperties {
  @doc("Projection of a payment method")
  paymentMethod?: PaymentMethodProjectionProperties;
}

@doc("The properties of a payment method projection.")
model PaymentMethodProjectionProperties {
  @doc("Id of payment method.")
  @visibility("read")
  id?: string;

  @doc("The family of payment method.")
  family?: PaymentMethodFamily;

  @doc("The type of payment method.")
  @visibility("read")
  type?: string;

  @doc("The account holder name for the payment method. This is only supported for payment methods with family CreditCard.")
  @visibility("read")
  accountHolderName?: string;

  @doc("The expiration month and year of the payment method. This is only supported for payment methods with family CreditCard.")
  @visibility("read")
  expiration?: string;

  @doc("Last four digits of payment method.")
  @visibility("read")
  lastFourDigits?: string;

  @doc("The display name of the payment method.")
  @visibility("read")
  displayName?: string;

  @doc("The list of logos for the payment method.")
  logos?: PaymentMethodLogo[];

  @doc("Status of the payment method.")
  status?: PaymentMethodStatus;
}

@doc("Error response indicates that payment method cannot be detached from billing profile.")
@error
model DetachPaymentMethodEligibilityResult {
  @doc("The details of the error.")
  error?: DetachPaymentMethodEligibilityError;
}

@doc("The details of the error.")
model DetachPaymentMethodEligibilityError {
  @doc("Error code.")
  @visibility("read")
  code?: string;

  @doc("Error message.")
  @visibility("read")
  message?: string;

  @doc("The list of detach payment method eligibility errors.")
  @visibility("read")
  details?: DetachPaymentMethodErrorDetails[];
}

@doc("Error details of the detach payment method eligibility validation.")
model DetachPaymentMethodErrorDetails {
  @doc("Error code for the detach payment method eligibility validation.")
  code?: DetachPaymentMethodEligibilityErrorCode;

  @doc("Error message for the detach payment method eligibility validation.")
  message?: string;
}

@doc("The payment method resource model definition.")
model PaymentMethodResource {
  @doc("The ID that uniquely identifies a payment method.")
  paymentMethodId?: string;
}
