import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.Core;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Billing;

/**
 * The mode of acceptance for an agreement.
 */
union AcceptanceMode {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * ClickToAccept
   */
  ClickToAccept: "ClickToAccept",

  /**
   * ESignEmbedded
   */
  ESignEmbedded: "ESignEmbedded",

  /**
   * ESignOffline
   */
  ESignOffline: "ESignOffline",

  /**
   * Implicit
   */
  Implicit: "Implicit",

  /**
   * Offline
   */
  Offline: "Offline",

  /**
   * PhysicalSign
   */
  PhysicalSign: "PhysicalSign",
}

/**
 * The category of the agreement.
 */
union Category {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * AffiliatePurchaseTerms
   */
  AffiliatePurchaseTerms: "AffiliatePurchaseTerms",

  /**
   * IndirectForGovernmentAgreement
   */
  IndirectForGovernmentAgreement: "IndirectForGovernmentAgreement",

  /**
   * MicrosoftCustomerAgreement
   */
  MicrosoftCustomerAgreement: "MicrosoftCustomerAgreement",

  /**
   * MicrosoftPartnerAgreement
   */
  MicrosoftPartnerAgreement: "MicrosoftPartnerAgreement",

  /**
   * UKCloudComputeFramework
   */
  UKCloudComputeFramework: "UKCloudComputeFramework",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Key
   */
  Key: "Key",
}

/**
 * The provisioning state of the resource during a long-running operation.
 */
union ProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * New
   */
  New: "New",

  /**
   * Pending
   */
  Pending: "Pending",

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",

  /**
   * PendingBilling
   */
  PendingBilling: "PendingBilling",

  /**
   * ConfirmedBilling
   */
  ConfirmedBilling: "ConfirmedBilling",

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Created
   */
  Created: "Created",

  /**
   * Expired
   */
  Expired: "Expired",
}

/**
 * The state determines whether users from the associated tenant can be assigned roles for commerce activities like viewing and downloading invoices, managing payments, and making purchases.
 */
union BillingManagementTenantState {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * NotAllowed
   */
  NotAllowed: "NotAllowed",

  /**
   * Active
   */
  Active: "Active",

  /**
   * Revoked
   */
  Revoked: "Revoked",
}

/**
 * The state determines whether subscriptions and licenses can be provisioned in the associated tenant. It can be set to 'Pending' to initiate a billing request.
 */
union ProvisioningTenantState {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * NotRequested
   */
  NotRequested: "NotRequested",

  /**
   * Active
   */
  Active: "Active",

  /**
   * Pending
   */
  Pending: "Pending",

  /**
   * BillingRequestExpired
   */
  BillingRequestExpired: "BillingRequestExpired",

  /**
   * BillingRequestDeclined
   */
  BillingRequestDeclined: "BillingRequestDeclined",

  /**
   * Revoked
   */
  Revoked: "Revoked",
}

/**
 * Payment on Account type.
 */
union PaymentMethodFamily {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * None
   */
  None: "None",

  /**
   * CreditCard
   */
  CreditCard: "CreditCard",

  /**
   * Credits
   */
  Credits: "Credits",

  /**
   * CheckWire
   */
  CheckWire: "CheckWire",

  /**
   * EWallet
   */
  EWallet: "EWallet",

  /**
   * TaskOrder
   */
  TaskOrder: "TaskOrder",

  /**
   * DirectDebit
   */
  DirectDebit: "DirectDebit",
}

/**
 * The current status of the billing account.
 */
union AccountStatus {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * Active
   */
  Active: "Active",

  /**
   * UnderReview
   */
  UnderReview: "UnderReview",

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Deleted
   */
  Deleted: "Deleted",

  /**
   * Extended
   */
  Extended: "Extended",

  /**
   * Pending
   */
  Pending: "Pending",

  /**
   * New
   */
  New: "New",

  /**
   * Expired
   */
  Expired: "Expired",

  /**
   * Terminated
   */
  Terminated: "Terminated",

  /**
   * Transferred
   */
  Transferred: "Transferred",
}

/**
 * The type of customer.
 */
union AccountType {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * Enterprise
   */
  Enterprise: "Enterprise",

  /**
   * Individual
   */
  Individual: "Individual",

  /**
   * Partner
   */
  Partner: "Partner",

  /**
   * Reseller
   */
  Reseller: "Reseller",

  /**
   * ClassicPartner
   */
  ClassicPartner: "ClassicPartner",

  /**
   * Internal
   */
  Internal: "Internal",

  /**
   * Tenant
   */
  Tenant: "Tenant",

  /**
   * Business
   */
  Business: "Business",
}

/**
 * The tier of the account.
 */
union AccountSubType {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * None
   */
  None: "None",

  /**
   * Individual
   */
  Individual: "Individual",

  /**
   * Professional
   */
  Professional: "Professional",

  /**
   * Enterprise
   */
  Enterprise: "Enterprise",
}

/**
 * Reason for the specified billing account status.
 */
union BillingAccountStatusReasonCode {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * UnusualActivity
   */
  UnusualActivity: "UnusualActivity",

  /**
   * ManuallyTerminated
   */
  ManuallyTerminated: "ManuallyTerminated",

  /**
   * Expired
   */
  Expired: "Expired",

  /**
   * Transferred
   */
  Transferred: "Transferred",

  /**
   * TerminateProcessing
   */
  TerminateProcessing: "TerminateProcessing",
}

/**
 * The type of agreement.
 */
union AgreementType {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * MicrosoftCustomerAgreement
   */
  MicrosoftCustomerAgreement: "MicrosoftCustomerAgreement",

  /**
   * EnterpriseAgreement
   */
  EnterpriseAgreement: "EnterpriseAgreement",

  /**
   * MicrosoftOnlineServicesProgram
   */
  MicrosoftOnlineServicesProgram: "MicrosoftOnlineServicesProgram",

  /**
   * MicrosoftPartnerAgreement
   */
  MicrosoftPartnerAgreement: "MicrosoftPartnerAgreement",
}

/**
 * The billing account extension opted by the company.
 */
union ExtendedTermOption {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * Opted-In
   */
  `Opted-In`: "Opted-In",

  /**
   * Opted-Out
   */
  `Opted-Out`: "Opted-Out",
}

/**
 * The support level offer associated with an enrollment.
 */
union SupportLevel {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * Standard
   */
  Standard: "Standard",

  /**
   * Pro-Direct
   */
  `Pro-Direct`: "Pro-Direct",

  /**
   * Developer
   */
  Developer: "Developer",
}

/**
 * Markup status of enrollment, applicable only for indirect enrollments.
 */
union MarkupStatus {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Preview
   */
  Preview: "Preview",

  /**
   * Published
   */
  Published: "Published",

  /**
   * Locked
   */
  Locked: "Locked",
}

/**
 * Identifies the billing relationships represented by a billing account or billing profile. The billing relationship may be between Microsoft, the customer, and/or a third-party.
 */
union BillingRelationshipType {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * Direct
   */
  Direct: "Direct",

  /**
   * IndirectCustomer
   */
  IndirectCustomer: "IndirectCustomer",

  /**
   * IndirectPartner
   */
  IndirectPartner: "IndirectPartner",

  /**
   * CSPPartner
   */
  CSPPartner: "CSPPartner",

  /**
   * CSPCustomer
   */
  CSPCustomer: "CSPCustomer",
}

/**
 * The type of the tax identifier.
 */
union TaxIdentifierType {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * BrazilCcmId
   */
  BrazilCcmId: "BrazilCcmId",

  /**
   * BrazilCnpjId
   */
  BrazilCnpjId: "BrazilCnpjId",

  /**
   * BrazilCpfId
   */
  BrazilCpfId: "BrazilCpfId",

  /**
   * CanadianFederalExempt
   */
  CanadianFederalExempt: "CanadianFederalExempt",

  /**
   * CanadianProvinceExempt
   */
  CanadianProvinceExempt: "CanadianProvinceExempt",

  /**
   * ExternalTaxation
   */
  ExternalTaxation: "ExternalTaxation",

  /**
   * IndiaFederalTanId
   */
  IndiaFederalTanId: "IndiaFederalTanId",

  /**
   * IndiaFederalServiceTaxId
   */
  IndiaFederalServiceTaxId: "IndiaFederalServiceTaxId",

  /**
   * IndiaPanId
   */
  IndiaPanId: "IndiaPanId",

  /**
   * IndiaStateCstId
   */
  IndiaStateCstId: "IndiaStateCstId",

  /**
   * IndiaStateGstINId
   */
  IndiaStateGstINId: "IndiaStateGstINId",

  /**
   * IndiaStateVatId
   */
  IndiaStateVatId: "IndiaStateVatId",

  /**
   * IntlExempt
   */
  IntlExempt: "IntlExempt",

  /**
   * USExempt
   */
  USExempt: "USExempt",

  /**
   * VatId
   */
  VatId: "VatId",

  /**
   * LoveCode
   */
  LoveCode: "LoveCode",

  /**
   * MobileBarCode
   */
  MobileBarCode: "MobileBarCode",

  /**
   * NationalIdentificationNumber
   */
  NationalIdentificationNumber: "NationalIdentificationNumber",

  /**
   * PublicSectorId
   */
  PublicSectorId: "PublicSectorId",
}

/**
 * The status of the tax identifier.
 */
union TaxIdentifierStatus {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * Valid
   */
  Valid: "Valid",

  /**
   * Invalid
   */
  Invalid: "Invalid",
}

/**
 * The status of the billing profile.
 */
union BillingProfileStatus {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * Active
   */
  Active: "Active",

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Warned
   */
  Warned: "Warned",

  /**
   * Deleted
   */
  Deleted: "Deleted",

  /**
   * UnderReview
   */
  UnderReview: "UnderReview",
}

/**
 * Reason for the specified billing profile status.
 */
union BillingProfileStatusReasonCode {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * PastDue
   */
  PastDue: "PastDue",

  /**
   * UnusualActivity
   */
  UnusualActivity: "UnusualActivity",

  /**
   * SpendingLimitReached
   */
  SpendingLimitReached: "SpendingLimitReached",

  /**
   * SpendingLimitExpired
   */
  SpendingLimitExpired: "SpendingLimitExpired",
}

/**
 * The billing profile spending limit.
 */
union SpendingLimit {
  string,

  /**
   * Off
   */
  Off: "Off",

  /**
   * On
   */
  On: "On",
}

/**
 * Indicates the eligibility status of the payment terms.
 */
union PaymentTermsEligibilityStatus {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * Valid
   */
  Valid: "Valid",

  /**
   * Invalid
   */
  Invalid: "Invalid",
}

/**
 * Indicates the reason for the ineligibility of the payment terms.
 */
union PaymentTermsEligibilityCode {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * OverlappingPaymentTerms
   */
  OverlappingPaymentTerms: "OverlappingPaymentTerms",

  /**
   * InvalidDateFormat
   */
  InvalidDateFormat: "InvalidDateFormat",

  /**
   * InvalidDateRange
   */
  InvalidDateRange: "InvalidDateRange",

  /**
   * InactiveBillingAccount
   */
  InactiveBillingAccount: "InactiveBillingAccount",

  /**
   * InvalidBillingAccountType
   */
  InvalidBillingAccountType: "InvalidBillingAccountType",

  /**
   * NullOrEmptyPaymentTerms
   */
  NullOrEmptyPaymentTerms: "NullOrEmptyPaymentTerms",

  /**
   * BillingAccountNotFound
   */
  BillingAccountNotFound: "BillingAccountNotFound",

  /**
   * IneligibleBillingAccountStatus
   */
  IneligibleBillingAccountStatus: "IneligibleBillingAccountStatus",

  /**
   * InvalidTerms
   */
  InvalidTerms: "InvalidTerms",
}

/**
 * Status of the address validation.
 */
union AddressValidationStatus {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * Valid
   */
  Valid: "Valid",

  /**
   * Invalid
   */
  Invalid: "Invalid",
}

/**
 * Access Decision, specifies access is allowed or not.
 */
union AccessDecision {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * Allowed
   */
  Allowed: "Allowed",

  /**
   * NotAllowed
   */
  NotAllowed: "NotAllowed",
}

/**
 * Status describing if billing profile is eligible to be deleted.
 */
union DeleteBillingProfileEligibilityStatus {
  string,

  /**
   * Allowed
   */
  Allowed: "Allowed",

  /**
   * NotAllowed
   */
  NotAllowed: "NotAllowed",
}

/**
 * Code of the delete invoice section eligibility response.
 */
union DeleteBillingProfileEligibilityCode {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * ActiveCredits
   */
  ActiveCredits: "ActiveCredits",

  /**
   * ActiveCreditCard
   */
  ActiveCreditCard: "ActiveCreditCard",

  /**
   * LastBillingProfile
   */
  LastBillingProfile: "LastBillingProfile",

  /**
   * NotSupported
   */
  NotSupported: "NotSupported",

  /**
   * OutstandingCharges
   */
  OutstandingCharges: "OutstandingCharges",

  /**
   * PendingCharges
   */
  PendingCharges: "PendingCharges",

  /**
   * ReservedInstances
   */
  ReservedInstances: "ReservedInstances",

  /**
   * ActiveBillingSubscriptions
   */
  ActiveBillingSubscriptions: "ActiveBillingSubscriptions",
}

/**
 * The type of spending limit.
 */
union SpendingLimitType {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * None
   */
  None: "None",

  /**
   * FreeAccount
   */
  FreeAccount: "FreeAccount",

  /**
   * Sandbox
   */
  Sandbox: "Sandbox",

  /**
   * AzureForStudents
   */
  AzureForStudents: "AzureForStudents",

  /**
   * AcademicSponsorship
   */
  AcademicSponsorship: "AcademicSponsorship",

  /**
   * AzureConsumptionCredit
   */
  AzureConsumptionCredit: "AzureConsumptionCredit",

  /**
   * AzurePassSponsorship
   */
  AzurePassSponsorship: "AzurePassSponsorship",

  /**
   * MpnSponsorship
   */
  MpnSponsorship: "MpnSponsorship",

  /**
   * MSDN
   */
  MSDN: "MSDN",

  /**
   * NonProfitSponsorship
   */
  NonProfitSponsorship: "NonProfitSponsorship",

  /**
   * Sponsorship
   */
  Sponsorship: "Sponsorship",

  /**
   * StartupSponsorship
   */
  StartupSponsorship: "StartupSponsorship",

  /**
   * AzureForStudentsStarter
   */
  AzureForStudentsStarter: "AzureForStudentsStarter",

  /**
   * VisualStudio
   */
  VisualStudio: "VisualStudio",
}

/**
 * The status of current spending limit.
 */
union SpendingLimitStatus {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * None
   */
  None: "None",

  /**
   * Active
   */
  Active: "Active",

  /**
   * Expired
   */
  Expired: "Expired",

  /**
   * LimitReached
   */
  LimitReached: "LimitReached",

  /**
   * LimitRemoved
   */
  LimitRemoved: "LimitRemoved",
}

/**
 * Identifies the status of an customer. This is an upcoming property that will be populated in the future.
 */
union CustomerStatus {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * Active
   */
  Active: "Active",

  /**
   * Pending
   */
  Pending: "Pending",

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Warned
   */
  Warned: "Warned",

  /**
   * Deleted
   */
  Deleted: "Deleted",

  /**
   * UnderReview
   */
  UnderReview: "UnderReview",
}

/**
 * Identifies the status of an invoice section.
 */
union InvoiceSectionState {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * Active
   */
  Active: "Active",

  /**
   * Deleted
   */
  Deleted: "Deleted",

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * UnderReview
   */
  UnderReview: "UnderReview",

  /**
   * Warned
   */
  Warned: "Warned",

  /**
   * Restricted
   */
  Restricted: "Restricted",
}

/**
 * Reason for the specified invoice section status.
 */
union InvoiceSectionStateReasonCode {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * PastDue
   */
  PastDue: "PastDue",

  /**
   * UnusualActivity
   */
  UnusualActivity: "UnusualActivity",

  /**
   * SpendingLimitReached
   */
  SpendingLimitReached: "SpendingLimitReached",

  /**
   * SpendingLimitExpired
   */
  SpendingLimitExpired: "SpendingLimitExpired",
}

/**
 * The subscription status.
 */
union BillingSubscriptionStatus {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * Active
   */
  Active: "Active",

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Deleted
   */
  Deleted: "Deleted",

  /**
   * Warned
   */
  Warned: "Warned",

  /**
   * Expiring
   */
  Expiring: "Expiring",

  /**
   * Expired
   */
  Expired: "Expired",

  /**
   * AutoRenew
   */
  AutoRenew: "AutoRenew",

  /**
   * Cancelled
   */
  Cancelled: "Cancelled",

  /**
   * Suspended
   */
  Suspended: "Suspended",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * The suspension reason for a subscription. This field is not available for Enterprise Agreement billing accounts.
 */
union SubscriptionStatusReason {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Cancelled
   */
  Cancelled: "Cancelled",

  /**
   * PastDue
   */
  PastDue: "PastDue",

  /**
   * SuspiciousActivity
   */
  SuspiciousActivity: "SuspiciousActivity",

  /**
   * Other
   */
  Other: "Other",

  /**
   * Transferred
   */
  Transferred: "Transferred",

  /**
   * PolicyViolation
   */
  PolicyViolation: "PolicyViolation",

  /**
   * SpendingLimitReached
   */
  SpendingLimitReached: "SpendingLimitReached",

  /**
   * Expired
   */
  Expired: "Expired",
}

/**
 * The type of billing subscription.
 */
union SubscriptionBillingType {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Benefit
   */
  Benefit: "Benefit",

  /**
   * Free
   */
  Free: "Free",

  /**
   * Paid
   */
  Paid: "Paid",

  /**
   * PrePaid
   */
  PrePaid: "PrePaid",
}

/**
 * The Azure workload type of the subscription.
 */
union SubscriptionWorkloadType {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Production
   */
  Production: "Production",

  /**
   * DevTest
   */
  DevTest: "DevTest",

  /**
   * Internal
   */
  Internal: "Internal",
}

/**
 * Status of billing request.
 */
union BillingRequestStatus {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * Pending
   */
  Pending: "Pending",

  /**
   * Approved
   */
  Approved: "Approved",

  /**
   * Declined
   */
  Declined: "Declined",

  /**
   * Cancelled
   */
  Cancelled: "Cancelled",

  /**
   * Completed
   */
  Completed: "Completed",

  /**
   * Expired
   */
  Expired: "Expired",
}

/**
 * Type of billing request.
 */
union BillingRequestType {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * InvoiceAccess
   */
  InvoiceAccess: "InvoiceAccess",

  /**
   * ProvisioningAccess
   */
  ProvisioningAccess: "ProvisioningAccess",

  /**
   * RoleAssignment
   */
  RoleAssignment: "RoleAssignment",

  /**
   * UpdateBillingPolicy
   */
  UpdateBillingPolicy: "UpdateBillingPolicy",
}

/**
 * The type of a role Assignment.
 */
union PrincipalType {
  string,

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * None
   */
  None: "None",

  /**
   * User
   */
  User: "User",

  /**
   * Group
   */
  Group: "Group",

  /**
   * DirectoryRole
   */
  DirectoryRole: "DirectoryRole",

  /**
   * ServicePrincipal
   */
  ServicePrincipal: "ServicePrincipal",

  /**
   * Everyone
   */
  Everyone: "Everyone",
}

/**
 * Represents the Savings plan term in ISO 8601 format.
 */
union SavingsPlanTerm {
  string,

  /**
   * P1Y
   */
  P1Y: "P1Y",

  /**
   * P3Y
   */
  P3Y: "P3Y",

  /**
   * P5Y
   */
  P5Y: "P5Y",
}

/**
 * Represents the billing plan in ISO 8601 format. Required only for monthly purchases.
 */
union BillingPlan {
  string,

  /**
   * P1M
   */
  P1M: "P1M",
}

/**
 * Describes whether the payment is completed, failed, pending, cancelled or scheduled in the future.
 */
union PaymentStatus {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Scheduled
   */
  Scheduled: "Scheduled",

  /**
   * Cancelled
   */
  Cancelled: "Cancelled",

  /**
   * Completed
   */
  Completed: "Completed",

  /**
   * Pending
   */
  Pending: "Pending",
}

/**
 * Type of the Applied Scope.
 */
union AppliedScopeType {
  string,

  /**
   * Single
   */
  Single: "Single",

  /**
   * Shared
   */
  Shared: "Shared",

  /**
   * ManagementGroup
   */
  ManagementGroup: "ManagementGroup",
}

/**
 * Commitment grain.
 */
union CommitmentGrain {
  string,

  /**
   * Hourly
   */
  Hourly: "Hourly",
}

/**
 * Indicates whether auto renewal is turned on or off for a product.
 */
union AutoRenew {
  string,

  /**
   * Off
   */
  Off: "Off",

  /**
   * On
   */
  On: "On",
}

/**
 * The current enrollment account status of the subscription. This field is available only for the Enterprise Agreement Type.
 */
union SubscriptionEnrollmentAccountStatus {
  string,

  /**
   * Active
   */
  Active: "Active",

  /**
   * Cancelled
   */
  Cancelled: "Cancelled",

  /**
   * Expired
   */
  Expired: "Expired",

  /**
   * Deleted
   */
  Deleted: "Deleted",

  /**
   * TransferredOut
   */
  TransferredOut: "TransferredOut",

  /**
   * Transferring
   */
  Transferring: "Transferring",

  /**
   * Inactive
   */
  Inactive: "Inactive",
}

/**
 * The policy override for the subscription indicates whether the self-serve cancellation or seat reduction is allowed.
 */
union Cancellation {
  string,

  /**
   * NotAllowed
   */
  NotAllowed: "NotAllowed",

  /**
   * Allowed
   */
  Allowed: "Allowed",
}

/**
 * The status of an operation on the subscription. When None, there is no ongoing operation. When LockedForUpdate, write operations will be blocked on the Billing Subscription. Other is the default value and you may need to refer to the latest API version for more details.
 */
union BillingSubscriptionOperationStatus {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * None
   */
  None: "None",

  /**
   * LockedForUpdate
   */
  LockedForUpdate: "LockedForUpdate",
}

/**
 * Cancellation reason.
 */
union CancellationReason {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * Compromise
   */
  Compromise: "Compromise",

  /**
   * Dispute
   */
  Dispute: "Dispute",
}

/**
 * Error code of the transfer validation response.
 */
union SubscriptionTransferValidationErrorCode {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * BillingAccountInactive
   */
  BillingAccountInactive: "BillingAccountInactive",

  /**
   * DestinationBillingProfileInactive
   */
  DestinationBillingProfileInactive: "DestinationBillingProfileInactive",

  /**
   * DestinationBillingProfileNotFound
   */
  DestinationBillingProfileNotFound: "DestinationBillingProfileNotFound",

  /**
   * DestinationBillingProfilePastDue
   */
  DestinationBillingProfilePastDue: "DestinationBillingProfilePastDue",

  /**
   * DestinationInvoiceSectionInactive
   */
  DestinationInvoiceSectionInactive: "DestinationInvoiceSectionInactive",

  /**
   * DestinationInvoiceSectionNotFound
   */
  DestinationInvoiceSectionNotFound: "DestinationInvoiceSectionNotFound",

  /**
   * InsufficientPermissionOnDestination
   */
  InsufficientPermissionOnDestination: "InsufficientPermissionOnDestination",

  /**
   * InsufficientPermissionOnSource
   */
  InsufficientPermissionOnSource: "InsufficientPermissionOnSource",

  /**
   * InvalidDestination
   */
  InvalidDestination: "InvalidDestination",

  /**
   * InvalidSource
   */
  InvalidSource: "InvalidSource",

  /**
   * MarketplaceNotEnabledOnDestination
   */
  MarketplaceNotEnabledOnDestination: "MarketplaceNotEnabledOnDestination",

  /**
   * ProductInactive
   */
  ProductInactive: "ProductInactive",

  /**
   * ProductNotFound
   */
  ProductNotFound: "ProductNotFound",

  /**
   * ProductTypeNotSupported
   */
  ProductTypeNotSupported: "ProductTypeNotSupported",

  /**
   * SourceBillingProfilePastDue
   */
  SourceBillingProfilePastDue: "SourceBillingProfilePastDue",

  /**
   * SourceInvoiceSectionInactive
   */
  SourceInvoiceSectionInactive: "SourceInvoiceSectionInactive",

  /**
   * AccountIsLocked
   */
  AccountIsLocked: "AccountIsLocked",

  /**
   * AssetHasCap
   */
  AssetHasCap: "AssetHasCap",

  /**
   * AssetNotActive
   */
  AssetNotActive: "AssetNotActive",

  /**
   * BillingProfilePastDue
   */
  BillingProfilePastDue: "BillingProfilePastDue",

  /**
   * CrossBillingAccountNotAllowed
   */
  CrossBillingAccountNotAllowed: "CrossBillingAccountNotAllowed",

  /**
   * NoActiveAzurePlan
   */
  NoActiveAzurePlan: "NoActiveAzurePlan",

  /**
   * None
   */
  None: "None",

  /**
   * SubscriptionNotActive
   */
  SubscriptionNotActive: "SubscriptionNotActive",

  /**
   * SubscriptionHasReservations
   */
  SubscriptionHasReservations: "SubscriptionHasReservations",

  /**
   * SubscriptionTypeNotSupported
   */
  SubscriptionTypeNotSupported: "SubscriptionTypeNotSupported",

  /**
   * InvoiceSectionIsRestricted
   */
  InvoiceSectionIsRestricted: "InvoiceSectionIsRestricted",
}

/**
 * The type of the document.
 */
union InvoiceDocumentType {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * Invoice
   */
  Invoice: "Invoice",

  /**
   * VoidNote
   */
  VoidNote: "VoidNote",

  /**
   * TaxReceipt
   */
  TaxReceipt: "TaxReceipt",

  /**
   * CreditNote
   */
  CreditNote: "CreditNote",

  /**
   * Summary
   */
  Summary: "Summary",

  /**
   * Transactions
   */
  Transactions: "Transactions",
}

/**
 * The source of the document. ENF for Brazil and DRS for rest of the world.
 */
union DocumentSource {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * DRS
   */
  DRS: "DRS",

  /**
   * ENF
   */
  ENF: "ENF",
}

/**
 * The reason that the payment failed.
 */
union FailedPaymentReason {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * BankDeclined
   */
  BankDeclined: "BankDeclined",

  /**
   * CardExpired
   */
  CardExpired: "CardExpired",

  /**
   * IncorrectCardDetails
   */
  IncorrectCardDetails: "IncorrectCardDetails",
}

/**
 * Invoice type.
 */
union InvoiceType {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * AzureServices
   */
  AzureServices: "AzureServices",

  /**
   * AzureMarketplace
   */
  AzureMarketplace: "AzureMarketplace",

  /**
   * AzureSupport
   */
  AzureSupport: "AzureSupport",
}

/**
 * The current status of the invoice.
 */
union InvoiceStatus {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * Due
   */
  Due: "Due",

  /**
   * OverDue
   */
  OverDue: "OverDue",

  /**
   * Paid
   */
  Paid: "Paid",

  /**
   * Void
   */
  Void: "Void",

  /**
   * Locked
   */
  Locked: "Locked",
}

/**
 * Identifies the type of tax calculation used for the invoice. The field is applicable only to invoices with special tax calculation logic.
 */
union SpecialTaxationType {
  string,

  /**
   * SubtotalLevel
   */
  SubtotalLevel: "SubtotalLevel",

  /**
   * InvoiceLevel
   */
  InvoiceLevel: "InvoiceLevel",
}

/**
 * The status of refund request.
 */
union RefundStatus {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * Pending
   */
  Pending: "Pending",

  /**
   * Approved
   */
  Approved: "Approved",

  /**
   * Declined
   */
  Declined: "Declined",

  /**
   * Cancelled
   */
  Cancelled: "Cancelled",

  /**
   * Completed
   */
  Completed: "Completed",

  /**
   * Expired
   */
  Expired: "Expired",
}

/**
 * The reason for refund.
 */
union RefundReasonCode {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * AccidentalConversion
   */
  AccidentalConversion: "AccidentalConversion",

  /**
   * UnclearPricing
   */
  UnclearPricing: "UnclearPricing",

  /**
   * AccidentalPurchase
   */
  AccidentalPurchase: "AccidentalPurchase",

  /**
   * ForgotToCancel
   */
  ForgotToCancel: "ForgotToCancel",

  /**
   * UnclearDocumentation
   */
  UnclearDocumentation: "UnclearDocumentation",
}

/**
 * Status describing if invoice section is eligible to be deleted.
 */
union DeleteInvoiceSectionEligibilityStatus {
  string,

  /**
   * Allowed
   */
  Allowed: "Allowed",

  /**
   * NotAllowed
   */
  NotAllowed: "NotAllowed",
}

/**
 * Code for the delete invoice section validation.
 */
union DeleteInvoiceSectionEligibilityCode {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * LastInvoiceSection
   */
  LastInvoiceSection: "LastInvoiceSection",

  /**
   * ActiveAzurePlans
   */
  ActiveAzurePlans: "ActiveAzurePlans",

  /**
   * ReservedInstances
   */
  ReservedInstances: "ReservedInstances",

  /**
   * ActiveBillingSubscriptions
   */
  ActiveBillingSubscriptions: "ActiveBillingSubscriptions",
}

/**
 * Status of the payment method.
 */
union PaymentMethodStatus {
  string,

  /**
   * active
   */
  active: "active",

  /**
   * inactive
   */
  inactive: "inactive",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ServiceDefinedResourceName {
  string,

  /**
   * default
   */
  default: "default",
}

/**
 * The policy that controls whether the users in customer's organization can view charges at pay-as-you-go prices.
 */
union ViewChargesPolicy {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * Allowed
   */
  Allowed: "Allowed",

  /**
   * NotAllowed
   */
  NotAllowed: "NotAllowed",
}

/**
 * The type of the policy.
 */
union PolicyType {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * UserControlled
   */
  UserControlled: "UserControlled",

  /**
   * SystemControlled
   */
  SystemControlled: "SystemControlled",
}

/**
 * The state showing the enrollment auth level.
 */
union EnrollmentAuthLevelState {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * MicrosoftAccountOnly
   */
  MicrosoftAccountOnly: "MicrosoftAccountOnly",

  /**
   * MixedAccount
   */
  MixedAccount: "MixedAccount",

  /**
   * OrganizationalAccountCrossTenant
   */
  OrganizationalAccountCrossTenant: "OrganizationalAccountCrossTenant",

  /**
   * OrganizationalAccountOnly
   */
  OrganizationalAccountOnly: "OrganizationalAccountOnly",
}

/**
 * The policy that controls whether account owner can view charges.
 */
union EnrollmentAccountOwnerViewCharges {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * Allowed
   */
  Allowed: "Allowed",

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * NotAllowed
   */
  NotAllowed: "NotAllowed",
}

/**
 * The policy that controls whether department admin can view charges.
 */
union EnrollmentDepartmentAdminViewCharges {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * Allowed
   */
  Allowed: "Allowed",

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * NotAllowed
   */
  NotAllowed: "NotAllowed",
}

/**
 * The policy that controls invoice section label management at invoice section scope. This is allowed by default.
 */
union InvoiceSectionLabelManagementPolicy {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * Allowed
   */
  Allowed: "Allowed",

  /**
   * NotAllowed
   */
  NotAllowed: "NotAllowed",
}

/**
 * The policy that controls whether Azure marketplace purchases are allowed.
 */
union MarketplacePurchasesPolicy {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * AllAllowed
   */
  AllAllowed: "AllAllowed",

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * NotAllowed
   */
  NotAllowed: "NotAllowed",

  /**
   * OnlyFreeAllowed
   */
  OnlyFreeAllowed: "OnlyFreeAllowed",
}

/**
 * The policy that controls whether Azure reservation purchases are allowed.
 */
union ReservationPurchasesPolicy {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * Allowed
   */
  Allowed: "Allowed",

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * NotAllowed
   */
  NotAllowed: "NotAllowed",
}

/**
 * The policy that controls whether users with Azure savings plan purchase are allowed.
 */
union SavingsPlanPurchasesPolicy {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * Allowed
   */
  Allowed: "Allowed",

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * NotAllowed
   */
  NotAllowed: "NotAllowed",
}

/**
 * The status of the product.
 */
union ProductStatus {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * Active
   */
  Active: "Active",

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Deleted
   */
  Deleted: "Deleted",

  /**
   * PastDue
   */
  PastDue: "PastDue",

  /**
   * Expiring
   */
  Expiring: "Expiring",

  /**
   * Expired
   */
  Expired: "Expired",

  /**
   * AutoRenew
   */
  AutoRenew: "AutoRenew",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Suspended
   */
  Suspended: "Suspended",
}

/**
 * Error code for the product transfer validation.
 */
union MoveValidationErrorCode {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * BillingAccountInactive
   */
  BillingAccountInactive: "BillingAccountInactive",

  /**
   * DestinationBillingProfileInactive
   */
  DestinationBillingProfileInactive: "DestinationBillingProfileInactive",

  /**
   * DestinationBillingProfileNotFound
   */
  DestinationBillingProfileNotFound: "DestinationBillingProfileNotFound",

  /**
   * DestinationBillingProfilePastDue
   */
  DestinationBillingProfilePastDue: "DestinationBillingProfilePastDue",

  /**
   * DestinationInvoiceSectionInactive
   */
  DestinationInvoiceSectionInactive: "DestinationInvoiceSectionInactive",

  /**
   * DestinationInvoiceSectionNotFound
   */
  DestinationInvoiceSectionNotFound: "DestinationInvoiceSectionNotFound",

  /**
   * InsufficientPermissionOnDestination
   */
  InsufficientPermissionOnDestination: "InsufficientPermissionOnDestination",

  /**
   * InsufficientPermissionOnSource
   */
  InsufficientPermissionOnSource: "InsufficientPermissionOnSource",

  /**
   * InvalidDestination
   */
  InvalidDestination: "InvalidDestination",

  /**
   * InvalidSource
   */
  InvalidSource: "InvalidSource",

  /**
   * MarketplaceNotEnabledOnDestination
   */
  MarketplaceNotEnabledOnDestination: "MarketplaceNotEnabledOnDestination",

  /**
   * ProductInactive
   */
  ProductInactive: "ProductInactive",

  /**
   * ProductNotFound
   */
  ProductNotFound: "ProductNotFound",

  /**
   * ProductTypeNotSupported
   */
  ProductTypeNotSupported: "ProductTypeNotSupported",

  /**
   * SourceBillingProfilePastDue
   */
  SourceBillingProfilePastDue: "SourceBillingProfilePastDue",

  /**
   * SourceInvoiceSectionInactive
   */
  SourceInvoiceSectionInactive: "SourceInvoiceSectionInactive",
}

/**
 * Turning this on will apply the reservation discount to other VMs in the same VM size group. Only specify for VirtualMachines reserved resource type.
 */
union InstanceFlexibility {
  string,

  /**
   * On
   */
  On: "On",

  /**
   * Off
   */
  Off: "Off",
}

/**
 * The status of the reservation.
 */
union ReservationStatusCode {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Pending
   */
  Pending: "Pending",

  /**
   * Processing
   */
  Processing: "Processing",

  /**
   * Active
   */
  Active: "Active",

  /**
   * PurchaseError
   */
  PurchaseError: "PurchaseError",

  /**
   * PaymentInstrumentError
   */
  PaymentInstrumentError: "PaymentInstrumentError",

  /**
   * Split
   */
  Split: "Split",

  /**
   * Merged
   */
  Merged: "Merged",

  /**
   * Expired
   */
  Expired: "Expired",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * CapacityError
   */
  CapacityError: "CapacityError",

  /**
   * CapacityRestricted
   */
  CapacityRestricted: "CapacityRestricted",

  /**
   * Exchanged
   */
  Exchanged: "Exchanged",

  /**
   * UnknownError
   */
  UnknownError: "UnknownError",

  /**
   * RiskCheckFailed
   */
  RiskCheckFailed: "RiskCheckFailed",

  /**
   * CreditLineCheckFailed
   */
  CreditLineCheckFailed: "CreditLineCheckFailed",

  /**
   * Warning
   */
  Warning: "Warning",

  /**
   * NoBenefitDueToSubscriptionTransfer
   */
  NoBenefitDueToSubscriptionTransfer: "NoBenefitDueToSubscriptionTransfer",

  /**
   * NoBenefitDueToSubscriptionDeletion
   */
  NoBenefitDueToSubscriptionDeletion: "NoBenefitDueToSubscriptionDeletion",

  /**
   * NoBenefit
   */
  NoBenefit: "NoBenefit",
}

/**
 * Represent the billing plans.
 */
union ReservationBillingPlan {
  string,

  /**
   * Upfront
   */
  Upfront: "Upfront",

  /**
   * Monthly
   */
  Monthly: "Monthly",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union TransactionType {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * Billed
   */
  Billed: "Billed",

  /**
   * Unbilled
   */
  Unbilled: "Unbilled",
}

/**
 * The credit type of the transaction. Applies only to credited transactions.
 */
union CreditType {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * AzureFreeCredit
   */
  AzureFreeCredit: "AzureFreeCredit",

  /**
   * AzureCreditOffer
   */
  AzureCreditOffer: "AzureCreditOffer",

  /**
   * ServiceInterruption
   */
  ServiceInterruption: "ServiceInterruption",

  /**
   * Refund
   */
  Refund: "Refund",
}

/**
 * Type of the transaction, billed or unbilled.
 */
union TransactionKind {
  string,

  /**
   * Other
   */
  Other: "Other",

  /**
   * All
   */
  All: "All",

  /**
   * Reservation
   */
  Reservation: "Reservation",
}

/**
 * The status of a transfer.
 */
union TransferStatus {
  string,

  /**
   * Expired
   */
  Expired: "Expired",

  /**
   * Pending
   */
  Pending: "Pending",

  /**
   * InProgress
   */
  InProgress: "InProgress",

  /**
   * Completed
   */
  Completed: "Completed",

  /**
   * CompletedWithErrors
   */
  CompletedWithErrors: "CompletedWithErrors",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Declined
   */
  Declined: "Declined",
}

/**
 * The type of product that is transferred.
 */
union ProductType {
  string,

  /**
   * AzureSubscription
   */
  AzureSubscription: "AzureSubscription",

  /**
   * AzureReservation
   */
  AzureReservation: "AzureReservation",

  /**
   * Department
   */
  Department: "Department",

  /**
   * SavingsPlan
   */
  SavingsPlan: "SavingsPlan",

  /**
   * SAAS
   */
  SAAS: "SAAS",
}

/**
 * The status of a transfer.
 */
union ProductTransferStatus {
  string,

  /**
   * NotStarted
   */
  NotStarted: "NotStarted",

  /**
   * InProgress
   */
  InProgress: "InProgress",

  /**
   * Completed
   */
  Completed: "Completed",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * The type of customer of the transfer initiator.
 */
union InitiatorCustomerType {
  string,

  /**
   * Partner
   */
  Partner: "Partner",

  /**
   * EA
   */
  EA: "EA",
}

/**
 * Type of the products that can be transferred.
 */
union EligibleProductType {
  string,

  /**
   * DevTestAzureSubscription
   */
  DevTestAzureSubscription: "DevTestAzureSubscription",

  /**
   * StandardAzureSubscription
   */
  StandardAzureSubscription: "StandardAzureSubscription",

  /**
   * AzureReservation
   */
  AzureReservation: "AzureReservation",
}

/**
 * The supported account types.
 */
union SupportedAccountType {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Partner
   */
  Partner: "Partner",

  /**
   * Individual
   */
  Individual: "Individual",

  /**
   * Enterprise
   */
  Enterprise: "Enterprise",
}

/**
 * An agreement.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AgreementProperties {
  /**
   * The mode of acceptance for an agreement.
   */
  @visibility(Lifecycle.Read)
  acceptanceMode?: AcceptanceMode;

  /**
   * The URL to download the agreement.
   */
  @visibility(Lifecycle.Read)
  agreementLink?: string;

  /**
   * The list of billing profiles associated with agreement and present only for specific agreements.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  billingProfileInfo?: BillingProfileInfo[];

  /**
   * The category of the agreement.
   */
  @visibility(Lifecycle.Read)
  category?: Category;

  /**
   * The name of the agreement signed by a customer.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * The date from which the agreement is effective.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  effectiveDate?: utcDateTime;

  /**
   * The date when the agreement expires.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDate?: utcDateTime;

  /**
   * The list of participants that participates in acceptance of an agreement.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  participants?: Participant[];

  /**
   * The current status of the agreement.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * The ID of the lead billing account if this agreement is part of the Customer Affiliate Purchase Terms.
   */
  @visibility(Lifecycle.Read)
  leadBillingAccountName?: string;
}

/**
 * Details about billing profile associated with agreement and available only for specific agreements.
 */
model BillingProfileInfo {
  /**
   * The fully qualified ID that uniquely identifies a billing account.
   */
  billingAccountId?: string;

  /**
   * The name of the billing profile.
   */
  billingProfileDisplayName?: string;

  /**
   * The friendly ID that uniquely identifies a billing profile.
   */
  billingProfileId?: string;

  /**
   * The fully qualified ID that uniquely identifies a billing profile.
   */
  billingProfileSystemId?: string;

  /**
   * Billing account name. Available for a specific type of agreement.
   */
  indirectRelationshipOrganizationName?: string;
}

/**
 * Billing account name. Available for a specific type of agreement.
 */
model Participant {
  /**
   * The email address of the participant.
   */
  @visibility(Lifecycle.Read)
  email?: string;

  /**
   * The acceptance status of the participant.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * The date when the status got changed.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  statusDate?: utcDateTime;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ProxyResourceWithTags
  extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * An associated tenant.
 */
model AssociatedTenantProperties {
  /**
   * The provisioning state of the resource during a long-running operation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The name of the associated tenant.
   */
  displayName?: string;

  /**
   * The ID that uniquely identifies a tenant.
   */
  tenantId?: string;

  /**
   * The state determines whether users from the associated tenant can be assigned roles for commerce activities like viewing and downloading invoices, managing payments, and making purchases.
   */
  billingManagementState?: BillingManagementTenantState;

  /**
   * The state determines whether subscriptions and licenses can be provisioned in the associated tenant. It can be set to 'Pending' to initiate a billing request.
   */
  provisioningManagementState?: ProvisioningTenantState;

  /**
   * The unique identifier for the billing request that is created when enabling provisioning for an associated tenant.
   */
  @visibility(Lifecycle.Read)
  provisioningBillingRequestId?: string;
}

/**
 * The Available Credit or Payment on Account Balance. The credit balance can be used to settle due or past due invoices.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AvailableBalanceProperties {
  /**
   * Credit amount for immediate payment.
   */
  amount?: AvailableBalancePropertiesAmount;

  /**
   * The list of payments on accounts.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  paymentsOnAccount?: PaymentOnAccount[];

  /**
   * Total amount of payments on accounts.
   */
  totalPaymentsOnAccount?: AvailableBalancePropertiesTotalPaymentsOnAccount;
}

/**
 * Credit amount for immediate payment.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AvailableBalancePropertiesAmount extends Amount {}

/**
 * The amount.
 */
model Amount {
  /**
   * The currency for the amount value.
   */
  @visibility(Lifecycle.Read)
  currency?: string;

  /**
   * The amount value. For example, if the currency is USD, then a value of 600 would be $600.00.
   */
  @visibility(Lifecycle.Read)
  value?: float32;
}

/**
 * A Payment on Account.
 */
model PaymentOnAccount {
  /**
   * Payment on Account amount.
   */
  amount?: PaymentOnAccountAmount;

  /**
   * The ID of the billing profile for the payments on account.
   */
  @visibility(Lifecycle.Read)
  billingProfileId?: string;

  /**
   * The name of the billing profile for the payments on account.
   */
  @visibility(Lifecycle.Read)
  billingProfileDisplayName?: string;

  /**
   * The ID of the invoice for which the payments on account was generated.
   */
  @visibility(Lifecycle.Read)
  invoiceId?: string;

  /**
   * The name of the invoice for the payments on account.
   */
  @visibility(Lifecycle.Read)
  invoiceName?: string;

  /**
   * The date of the payments on account.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  date?: utcDateTime;

  /**
   * Payment on Account type.
   */
  @visibility(Lifecycle.Read)
  paymentMethodType?: PaymentMethodFamily;
}

/**
 * Payment on Account amount.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PaymentOnAccountAmount extends Amount {}

/**
 * Total amount of payments on accounts.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AvailableBalancePropertiesTotalPaymentsOnAccount extends Amount {}

/**
 * The properties of payment term.
 */
model PaymentTerm {
  /**
   * Represents duration in netXX format. Always in days.
   */
  term?: string;

  /**
   * The date on when the defined 'Payment Term' will be effective from and is always in UTC.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDate?: utcDateTime;

  /**
   * The date on when the defined 'Payment Term' will end and is always in UTC.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDate?: utcDateTime;

  /**
   * Indicates payment term is the standard payment term.
   */
  @visibility(Lifecycle.Read)
  isDefault?: boolean;
}

/**
 * A billing account.
 */
model BillingAccountProperties {
  /**
   * The provisioning state of the resource during a long-running operation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The current status of the billing account.
   */
  @visibility(Lifecycle.Read)
  accountStatus?: AccountStatus;

  /**
   * The type of customer.
   */
  @visibility(Lifecycle.Read)
  accountType?: AccountType;

  /**
   * The tier of the account.
   */
  @visibility(Lifecycle.Read)
  accountSubType?: AccountSubType;

  /**
   * Reason for the specified billing account status.
   */
  @visibility(Lifecycle.Read)
  accountStatusReasonCode?: BillingAccountStatusReasonCode;

  /**
   * The type of agreement.
   */
  @visibility(Lifecycle.Read)
  agreementType?: AgreementType;

  /**
   * The billing account name.
   */
  displayName?: string;

  /**
   * The properties of an enrollment.
   */
  enrollmentDetails?: BillingAccountPropertiesEnrollmentDetails;

  /**
   * Indicates whether user has read access to the billing account.
   */
  hasReadAccess?: boolean;

  /**
   * Indicates whether or not the billing account has any billing profiles.
   */
  hasNoBillingProfiles?: boolean;

  /**
   * Notification email address for legacy account. Available for agreement type Microsoft Online Services Program.
   */
  notificationEmailAddress?: string;

  /**
   * The tenant that was used to set up the billing account. By default, only users from this tenant can get role assignments on the billing account and all purchases are provisioned in this tenant.
   */
  primaryBillingTenantId?: string;

  /**
   * The address of the individual or organization that is responsible for the billing account.
   */
  soldTo?: BillingAccountPropertiesSoldTo;

  /**
   * Describes the registration number of the organization linked with the billing account.
   */
  registrationNumber?: BillingAccountPropertiesRegistrationNumber;

  /**
   * Identifies the billing relationships represented by a billing account. The billing relationship may be between Microsoft, the customer, and/or a third-party.
   */
  @visibility(Lifecycle.Read)
  billingRelationshipTypes?: BillingRelationshipType[];

  /**
   * Qualifications for pricing on a billing account. Values may be Commercial, Education, Charity or Government.
   */
  @visibility(Lifecycle.Read)
  qualifications?: string[];

  /**
   * A list of tax identifiers for the billing account.
   */
  @identifiers(#[])
  taxIds?: TaxIdentifier[];
}

/**
 * The properties of an enrollment.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BillingAccountPropertiesEnrollmentDetails extends EnrollmentDetails {}

/**
 * The properties of an enrollment.
 */
model EnrollmentDetails {
  /**
   * The start date of the enrollment.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDate?: utcDateTime;

  /**
   * The end date of the enrollment.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDate?: utcDateTime;

  /**
   * The billing currency for the enrollment.
   */
  @visibility(Lifecycle.Read)
  currency?: string;

  /**
   * The channel type of the enrollment.
   */
  @visibility(Lifecycle.Read)
  channel?: string;

  /**
   * The language for the enrollment.
   */
  @visibility(Lifecycle.Read)
  language?: string;

  /**
   * The country code of the enrollment.
   */
  @visibility(Lifecycle.Read)
  countryCode?: string;

  /**
   * The billing cycle for the enrollment.
   */
  @visibility(Lifecycle.Read)
  billingCycle?: string;

  /**
   * The billing account extension opted by the company.
   */
  @visibility(Lifecycle.Read)
  extendedTermOption?: ExtendedTermOption;

  /**
   * The support level offer associated with an enrollment.
   */
  @visibility(Lifecycle.Read)
  supportLevel?: SupportLevel;

  /**
   * The support coverage period for the enrollment.
   */
  @visibility(Lifecycle.Read)
  supportCoverage?: string;

  /**
   * The cloud of the enrollment.
   */
  @visibility(Lifecycle.Read)
  cloud?: string;

  /**
   * The purchase order number of the enrollment.
   */
  poNumber?: string;

  /**
   * Markup status of enrollment, applicable only for indirect enrollments.
   */
  @visibility(Lifecycle.Read)
  markupStatus?: MarkupStatus;

  /**
   * The properties of an enrollment which are applicable only for indirect enrollments.
   */
  indirectRelationshipInfo?: EnrollmentDetailsIndirectRelationshipInfo;

  /**
   * The contact who receives invoices of the enrollment.
   */
  @visibility(Lifecycle.Read)
  invoiceRecipient?: string;
}

/**
 * The properties of an enrollment which are applicable only for indirect enrollments.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model EnrollmentDetailsIndirectRelationshipInfo
  extends IndirectRelationshipInfo {}

/**
 * Identifies the billing profile that is linked to another billing profile in indirect purchase motion.
 */
model IndirectRelationshipInfo {
  /**
   * The billing account name of the partner or the customer for an indirect motion.
   */
  billingAccountName?: string;

  /**
   * The billing profile name of the partner or the customer for an indirect motion.
   */
  billingProfileName?: string;

  /**
   * The display name of the partner or customer for an indirect motion.
   */
  displayName?: string;
}

/**
 * The address of the individual or organization that is responsible for the billing account.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BillingAccountPropertiesSoldTo extends AddressDetails {}

/**
 * Address details.
 */
model AddressDetails {
  /**
   * Address line 1.
   */
  @minLength(1)
  addressLine1: string;

  /**
   * Address line 2.
   */
  addressLine2?: string;

  /**
   * Address line 3.
   */
  addressLine3?: string;

  /**
   * Address city.
   */
  city?: string;

  /**
   * Company name. Optional for MCA Individual (Pay-as-you-go).
   */
  companyName?: string;

  /**
   * Country code uses ISO 3166-1 Alpha-2 format.
   */
  @minLength(1)
  country: string;

  /**
   * Address district.
   */
  district?: string;

  /**
   * Email address.
   */
  email?: string;

  /**
   * First name. Optional for MCA Enterprise.
   */
  firstName?: string;

  /**
   * Last name. Optional for MCA Enterprise.
   */
  lastName?: string;

  /**
   * Middle name.
   */
  middleName?: string;

  /**
   * Phone number.
   */
  phoneNumber?: string;

  /**
   * Postal code.
   */
  postalCode?: string;

  /**
   * Address region.
   */
  region?: string;

  /**
   * Indicates if the address is incomplete.
   */
  isValidAddress?: boolean;
}

/**
 * Describes the registration number of the organization linked with the billing account.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BillingAccountPropertiesRegistrationNumber extends RegistrationNumber {}

/**
 * Describes the registration number of the organization linked with the billing account.
 */
model RegistrationNumber {
  /**
   * The unique identification number of the organization linked with the billing account.
   */
  id?: string;

  /**
   * Identifies if the registration number is required for the billing account.
   */
  @visibility(Lifecycle.Read)
  required?: boolean;

  /**
   * The types of registration number allowed based on the country of the billing account.
   */
  @visibility(Lifecycle.Read)
  type?: string[];
}

/**
 * A tax identifier for the billing account.
 */
model TaxIdentifier {
  /**
   * The id of the tax identifier.
   */
  id?: string;

  /**
   * The type of the tax identifier.
   */
  type?: TaxIdentifierType;

  /**
   * The scope of the tax identifier.
   */
  scope?: string;

  /**
   * The country of the tax identifier.
   */
  country?: string;

  /**
   * The status of the tax identifier.
   */
  status?: TaxIdentifierStatus;
}

/**
 * The details for a billing account transitioned from agreement type Microsoft Online Services Program to agreement type Microsoft Customer Agreement.
 */
model TransitionDetails {
  /**
   * The transition completion date.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  transitionDate?: utcDateTime;

  /**
   * The anniversary day of the pre-transitioned account of type Microsoft Online Services Program.
   */
  @visibility(Lifecycle.Read)
  anniversaryDay?: int32;
}

/**
 * A container for a list of resources
 */
model InvoiceSectionWithCreateSubPermissionListResult
  is Azure.Core.Page<InvoiceSectionWithCreateSubPermission>;

/**
 * Invoice section properties with create subscription permission.
 */
model InvoiceSectionWithCreateSubPermission {
  /**
   * The name of the billing profile.
   */
  @visibility(Lifecycle.Read)
  billingProfileDisplayName?: string;

  /**
   * The fully qualified ID that uniquely identifies a billing profile.
   */
  @visibility(Lifecycle.Read)
  billingProfileId?: string;

  /**
   * The system generated unique identifier for a billing profile.
   */
  @visibility(Lifecycle.Read)
  billingProfileSystemId?: string;

  /**
   * The status of the billing profile.
   */
  @visibility(Lifecycle.Read)
  billingProfileStatus?: BillingProfileStatus;

  /**
   * Reason for the specified billing profile status.
   */
  @visibility(Lifecycle.Read)
  billingProfileStatusReasonCode?: BillingProfileStatusReasonCode;

  /**
   * The billing profile spending limit.
   */
  @visibility(Lifecycle.Read)
  billingProfileSpendingLimit?: SpendingLimit;

  /**
   * Enabled azure plans for the associated billing profile.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  enabledAzurePlans?: AzurePlan[];

  /**
   * The name of the invoice section.
   */
  @visibility(Lifecycle.Read)
  invoiceSectionDisplayName?: string;

  /**
   * The fully qualified ID that uniquely identifies an invoice section.
   */
  @visibility(Lifecycle.Read)
  invoiceSectionId?: string;

  /**
   * The system generated unique identifier for an invoice section.
   */
  @visibility(Lifecycle.Read)
  invoiceSectionSystemId?: string;
}

/**
 * Details of the Azure plan.
 */
model AzurePlan {
  /**
   * The ID that uniquely identifies a product.
   */
  productId?: string;

  /**
   * The ID that uniquely identifies a sku.
   */
  skuId?: string;

  /**
   * The sku description.
   */
  skuDescription?: string;
}

/**
 * Result of the payment terms eligibility.
 */
model PaymentTermsEligibilityResult {
  /**
   * Indicates the eligibility status of the payment terms.
   */
  eligibilityStatus?: PaymentTermsEligibilityStatus;

  /**
   * Details of the payment terms eligibility.
   */
  @identifiers(#[])
  eligibilityDetails?: PaymentTermsEligibilityDetail[];
}

/**
 * Details of the payment terms eligibility.
 */
model PaymentTermsEligibilityDetail {
  /**
   * Indicates the reason for the ineligibility of the payment terms.
   */
  code?: PaymentTermsEligibilityCode;

  /**
   * Indicates the message for the ineligibility of the payment terms.
   */
  message?: string;
}

/**
 * A billing account.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BillingAccountPatch extends ProxyResourceWithTags {
  /**
   * A billing account.
   */
  properties?: BillingAccountProperties;
}

/**
 * Result of the address validation.
 */
model AddressValidationResponse {
  /**
   * Status of the address validation.
   */
  @visibility(Lifecycle.Read)
  status?: AddressValidationStatus;

  /**
   * The list of suggested addresses.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  suggestedAddresses?: AddressDetails[];

  /**
   * Validation error message.
   */
  @visibility(Lifecycle.Read)
  validationMessage?: string;
}

/**
 * A container for a list of resources
 */
model BillingPermissionListResult is Azure.Core.Page<BillingPermission>;

/**
 * The set of allowed action and not allowed actions a caller has on a resource.
 */
model BillingPermission {
  /**
   * The set of actions that the caller is allowed to perform.
   */
  @visibility(Lifecycle.Read)
  actions?: string[];

  /**
   * The set of actions that the caller is not allowed to perform.
   */
  @visibility(Lifecycle.Read)
  notActions?: string[];
}

/**
 * Request to check access.
 */
model CheckAccessRequest {
  /**
   * List of actions passed in the request body against which the permissions will be checked.
   */
  actions?: string[];
}

/**
 * The properties of a check access response.
 */
model CheckAccessResponse {
  /**
   * Access Decision, specifies access is allowed or not.
   */
  @visibility(Lifecycle.Read)
  accessDecision?: AccessDecision;

  /**
   * Gets or sets an action.
   */
  @visibility(Lifecycle.Read)
  action?: string;
}

/**
 * Eligibility to delete a billing profile result.
 */
model DeleteBillingProfileEligibilityResult {
  /**
   * Status describing if billing profile is eligible to be deleted.
   */
  eligibilityStatus?: DeleteBillingProfileEligibilityStatus;

  /**
   * Validation details of delete billing profile eligibility.
   */
  @identifiers(#[])
  eligibilityDetails?: DeleteBillingProfileEligibilityDetail[];
}

/**
 * Validation details of delete billing profile eligibility.
 */
model DeleteBillingProfileEligibilityDetail {
  /**
   * Code of the delete invoice section eligibility response.
   */
  code?: DeleteBillingProfileEligibilityCode;

  /**
   * Validation message.
   */
  message?: string;
}

/**
 * A billing profile.
 */
model BillingProfileProperties {
  /**
   * The provisioning state of the resource during a long-running operation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Identifies the billing relationship represented by the billing profile. The billing relationship may be between Microsoft, the customer, and/or a third-party.
   */
  @visibility(Lifecycle.Read)
  billingRelationshipType?: BillingRelationshipType;

  /**
   * Billing address.
   */
  billTo?: BillingProfilePropertiesBillTo;

  /**
   * The currency in which the charges for the billing profile are billed.
   */
  @visibility(Lifecycle.Read)
  currency?: string;

  /**
   * The name of the billing profile.
   */
  displayName?: string;

  /**
   * Information about the enabled azure plans.
   */
  @identifiers(#[])
  enabledAzurePlans?: AzurePlan[];

  /**
   * Indicates whether user has read access to the billing profile.
   */
  @visibility(Lifecycle.Read)
  hasReadAccess?: boolean;

  /**
   * Identifies the billing profile that is linked to another billing profile in indirect purchase motion.
   */
  indirectRelationshipInfo?: BillingProfilePropertiesIndirectRelationshipInfo;

  /**
   * The day of the month when the invoice for the billing profile is generated.
   */
  @visibility(Lifecycle.Read)
  invoiceDay?: int32;

  /**
   * Flag controlling whether the invoices for the billing profile are sent through email.
   */
  invoiceEmailOptIn?: boolean;

  /**
   * The list of email addresses to receive invoices by email for the billing profile.
   */
  invoiceRecipients?: string[];

  /**
   * The default purchase order number that will appear on the invoices generated for the billing profile.
   */
  poNumber?: string;

  /**
   * The default address where the products are shipped, or the services are being used. If a ship to is not specified for a product or a subscription, then this address will be used.
   */
  shipTo?: BillingProfilePropertiesShipTo;

  /**
   * The address of the individual or organization that is responsible for the billing account.
   */
  soldTo?: BillingProfilePropertiesSoldTo;

  /**
   * The billing profile spending limit.
   */
  @visibility(Lifecycle.Read)
  spendingLimit?: SpendingLimit;

  /**
   * The details of billing profile spending limit.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  spendingLimitDetails?: SpendingLimitDetails[];

  /**
   * The status of the billing profile.
   */
  @visibility(Lifecycle.Read)
  status?: BillingProfileStatus;

  /**
   * Reason for the specified billing profile status.
   */
  @visibility(Lifecycle.Read)
  statusReasonCode?: BillingProfileStatusReasonCode;

  /**
   * The system generated unique identifier for a billing profile.
   */
  @visibility(Lifecycle.Read)
  systemId?: string;

  /**
   * Dictionary of metadata associated with the resource. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Identifies the cloud environments that are associated with a billing profile. This is a system managed optional field and gets updated as the billing profile gets associated with accounts in various clouds.
   */
  @visibility(Lifecycle.Read)
  targetClouds?: string[];

  /**
   * The current payment term of the billing profile.
   */
  currentPaymentTerm?: BillingProfilePropertiesCurrentPaymentTerm;

  /**
   * The other payment terms of the billing profile.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  otherPaymentTerms?: PaymentTerm[];
}

/**
 * Billing address.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BillingProfilePropertiesBillTo extends AddressDetails {}

/**
 * Identifies the billing profile that is linked to another billing profile in indirect purchase motion.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BillingProfilePropertiesIndirectRelationshipInfo
  extends IndirectRelationshipInfo {}

/**
 * The default address where the products are shipped, or the services are being used. If a ship to is not specified for a product or a subscription, then this address will be used.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BillingProfilePropertiesShipTo extends AddressDetails {}

/**
 * The address of the individual or organization that is responsible for the billing account.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BillingProfilePropertiesSoldTo extends AddressDetails {}

/**
 * The billing profile spending limit.
 */
model SpendingLimitDetails {
  /**
   * The initial amount for the billing profile.
   */
  amount?: float32;

  /**
   * The currency in which the charges for the billing profile are billed.
   */
  currency?: string;

  /**
   * The date when this spending limit goes into effect.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDate?: utcDateTime;

  /**
   * The date when this spending limit is no longer in effect.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDate?: utcDateTime;

  /**
   * The type of spending limit.
   */
  type?: SpendingLimitType;

  /**
   * The status of current spending limit.
   */
  status?: SpendingLimitStatus;
}

/**
 * The current payment term of the billing profile.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BillingProfilePropertiesCurrentPaymentTerm extends PaymentTerm {}

/**
 * A billing property.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BillingPropertyProperties {
  /**
   * The type of agreement.
   */
  @visibility(Lifecycle.Read)
  billingAccountAgreementType?: AgreementType;

  /**
   * The name of the billing account.
   */
  @visibility(Lifecycle.Read)
  billingAccountDisplayName?: string;

  /**
   * The fully qualified ID that uniquely identifies a billing account.
   */
  @visibility(Lifecycle.Read)
  billingAccountId?: string;

  /**
   * Notification email address for legacy account. Available for agreement type Microsoft Online Services Program.
   */
  @visibility(Lifecycle.Read)
  accountAdminNotificationEmailAddress?: string;

  /**
   * The country of the individual or organization that is responsible for the billing account.
   */
  @visibility(Lifecycle.Read)
  billingAccountSoldToCountry?: string;

  /**
   * The current status of the billing account.
   */
  @visibility(Lifecycle.Read)
  billingAccountStatus?: AccountStatus;

  /**
   * Reason for the specified billing account status.
   */
  @visibility(Lifecycle.Read)
  billingAccountStatusReasonCode?: BillingAccountStatusReasonCode;

  /**
   * The type of customer.
   */
  @visibility(Lifecycle.Read)
  billingAccountType?: AccountType;

  /**
   * The tier of the account.
   */
  @visibility(Lifecycle.Read)
  billingAccountSubType?: AccountSubType;

  /**
   * The billing currency for the subscription. Available for billing accounts with agreement type Enterprise Agreement
   */
  @visibility(Lifecycle.Read)
  billingCurrency?: string;

  /**
   * The name of the billing profile.
   */
  @visibility(Lifecycle.Read)
  billingProfileDisplayName?: string;

  /**
   * The fully qualified ID that uniquely identifies a billing profile.
   */
  @visibility(Lifecycle.Read)
  billingProfileId?: string;

  /**
   * The billing profile spending limit.
   */
  @visibility(Lifecycle.Read)
  billingProfileSpendingLimit?: SpendingLimit;

  /**
   * The details of billing profile spending limit.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  billingProfileSpendingLimitDetails?: SpendingLimitDetails[];

  /**
   * The status of the billing profile.
   */
  @visibility(Lifecycle.Read)
  billingProfileStatus?: BillingProfileStatus;

  /**
   * Reason for the specified billing profile status.
   */
  @visibility(Lifecycle.Read)
  billingProfileStatusReasonCode?: BillingProfileStatusReasonCode;

  /**
   * The payment method family of the primary payment method for the billing profile.
   */
  @visibility(Lifecycle.Read)
  billingProfilePaymentMethodFamily?: PaymentMethodFamily;

  /**
   * The payment method type of the primary payment method for the billing profile.
   */
  @visibility(Lifecycle.Read)
  billingProfilePaymentMethodType?: string;

  /**
   * The Azure AD tenant ID of the billing account for the subscription.
   */
  @visibility(Lifecycle.Read)
  billingTenantId?: string;

  /**
   * The cost center applied to the subscription. Available for agreement type Microsoft Customer Agreement and Microsoft Partner Agreement. This property can be updated via patch.
   */
  costCenter?: string;

  /**
   * The name of the customer.
   */
  @visibility(Lifecycle.Read)
  customerDisplayName?: string;

  /**
   * The fully qualified ID that uniquely identifies a customer.
   */
  @visibility(Lifecycle.Read)
  customerId?: string;

  /**
   * Identifies the status of an customer. This is an upcoming property that will be populated in the future.
   */
  @visibility(Lifecycle.Read)
  customerStatus?: CustomerStatus;

  /**
   * The name of the invoice section.
   */
  @visibility(Lifecycle.Read)
  invoiceSectionDisplayName?: string;

  /**
   * The fully qualified ID that uniquely identifies an invoice section.
   */
  @visibility(Lifecycle.Read)
  invoiceSectionId?: string;

  /**
   * Identifies the status of an invoice section.
   */
  @visibility(Lifecycle.Read)
  invoiceSectionStatus?: InvoiceSectionState;

  /**
   * Reason for the specified invoice section status.
   */
  @visibility(Lifecycle.Read)
  invoiceSectionStatusReasonCode?: InvoiceSectionStateReasonCode;

  /**
   * Specifies if the billing account for the subscription is transitioned from a Microsoft Online Service Program to a Microsoft Customer Agreement (MCA) account. Will be present and value will be true if its a transitioned billing account.
   */
  @visibility(Lifecycle.Read)
  isTransitionedBillingAccount?: boolean;

  /**
   * The sku description.
   */
  @visibility(Lifecycle.Read)
  skuDescription?: string;

  /**
   * The ID that uniquely identifies a sku.
   */
  @visibility(Lifecycle.Read)
  skuId?: string;

  /**
   * The subscription status.
   */
  @visibility(Lifecycle.Read)
  subscriptionBillingStatus?: BillingSubscriptionStatus;

  /**
   * The reason codes for the subscription status.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  subscriptionBillingStatusDetails?: BillingSubscriptionStatusDetails[];

  /**
   * The type of billing subscription.
   */
  @visibility(Lifecycle.Read)
  subscriptionBillingType?: SubscriptionBillingType;

  /**
   * The address of the individual or organization where service subscription is being used. Available for agreement type Microsoft Online Services Program. This property can be updated via patch.
   */
  subscriptionServiceUsageAddress?: BillingPropertyPropertiesSubscriptionServiceUsageAddress;

  /**
   * The Azure workload type of the subscription.
   */
  @visibility(Lifecycle.Read)
  subscriptionWorkloadType?: SubscriptionWorkloadType;

  /**
   * The enrollment details for the subscription. Available for billing accounts with agreement type Enterprise Agreement.
   */
  enrollmentDetails?: BillingPropertyPropertiesEnrollmentDetails;

  /**
   * Indicates whether user is the account admin.
   */
  @visibility(Lifecycle.Read)
  isAccountAdmin?: boolean;

  /**
   * The ID that uniquely identifies a product.
   */
  @visibility(Lifecycle.Read)
  productId?: string;

  /**
   * The ID that uniquely identifies a product.
   */
  @visibility(Lifecycle.Read)
  productName?: string;
}

/**
 * The suspension details for a subscription. This field is not available for Enterprise Agreement billing accounts.
 */
model BillingSubscriptionStatusDetails {
  /**
   * The suspension effective date for a subscription. This field is not available for Enterprise Agreement billing accounts.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  effectiveDate?: utcDateTime;

  /**
   * The suspension reason for a subscription. This field is not available for Enterprise Agreement billing accounts.
   */
  @visibility(Lifecycle.Read)
  reason?: SubscriptionStatusReason;
}

/**
 * The address of the individual or organization where service subscription is being used. Available for agreement type Microsoft Online Services Program. This property can be updated via patch.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BillingPropertyPropertiesSubscriptionServiceUsageAddress
  extends AddressDetails {}

/**
 * The enrollment details for the subscription. Available for billing accounts with agreement type Enterprise Agreement.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BillingPropertyPropertiesEnrollmentDetails
  extends SubscriptionEnrollmentDetails {}

/**
 * The enrollment details for the subscription. Available for billing accounts with agreement type Enterprise Agreement.
 */
model SubscriptionEnrollmentDetails {
  /**
   * The name of the department
   */
  departmentDisplayName?: string;

  /**
   * The ID that uniquely identifies the department.
   */
  departmentId?: string;

  /**
   * The status of the enrollment account.
   */
  enrollmentAccountStatus?: string;

  /**
   * The name of the enrollment account.
   */
  enrollmentAccountDisplayName?: string;

  /**
   * The ID that uniquely identifies an enrollment account.
   */
  enrollmentAccountId?: string;
}

/**
 * A request submitted by a user to manage billing. Users with an owner role on the scope can approve or decline these requests.
 */
model BillingRequestProperties {
  /**
   * The provisioning state of the resource during a long-running operation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Additional information for the billing request.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalInformation?: Record<string>;

  /**
   * The principal of the request reviewer. Will only be set if request is approved.
   */
  reviewedBy?: BillingRequestPropertiesReviewedBy;

  /**
   * The date and time when the request was reviewed.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reviewalDate?: utcDateTime;

  /**
   * The fully qualified ID that uniquely identifies a billing account.
   */
  @visibility(Lifecycle.Read)
  billingAccountId?: string;

  /**
   * The ID that uniquely identifies a billing account.
   */
  @visibility(Lifecycle.Read)
  billingAccountName?: string;

  /**
   * The name of the billing account.
   */
  @visibility(Lifecycle.Read)
  billingAccountDisplayName?: string;

  /**
   * The primary tenant ID of the billing account for which the billing request was submitted.
   */
  @visibility(Lifecycle.Read)
  billingAccountPrimaryBillingTenantId?: string;

  /**
   * The fully qualified ID that uniquely identifies a billing profile.
   */
  @visibility(Lifecycle.Read)
  billingProfileId?: string;

  /**
   * The ID that uniquely identifies a billing profile.
   */
  @visibility(Lifecycle.Read)
  billingProfileName?: string;

  /**
   * The name of the billing profile.
   */
  @visibility(Lifecycle.Read)
  billingProfileDisplayName?: string;

  /**
   * The principal of the entity who created the request.
   */
  createdBy?: BillingRequestPropertiesCreatedBy;

  /**
   * The date and time when the request was created.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  /**
   * The date and time when the request expires.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDate?: utcDateTime;

  /**
   * The reason to approve or decline the request.
   */
  decisionReason?: string;

  /**
   * The fully qualified ID that uniquely identifies an invoice section.
   */
  @visibility(Lifecycle.Read)
  invoiceSectionId?: string;

  /**
   * The ID that uniquely identifies an invoice section.
   */
  @visibility(Lifecycle.Read)
  invoiceSectionName?: string;

  /**
   * The name of the invoice section.
   */
  @visibility(Lifecycle.Read)
  invoiceSectionDisplayName?: string;

  /**
   * The fully qualified ID that uniquely identifies a customer.
   */
  @visibility(Lifecycle.Read)
  customerId?: string;

  /**
   * The ID that uniquely identifies a customer.
   */
  @visibility(Lifecycle.Read)
  customerName?: string;

  /**
   * The name of the customer.
   */
  @visibility(Lifecycle.Read)
  customerDisplayName?: string;

  /**
   * The fully qualified ID that uniquely identifies a billing subscription.
   */
  @visibility(Lifecycle.Read)
  subscriptionId?: string;

  /**
   * The ID that uniquely identifies a billing subscription.
   */
  @visibility(Lifecycle.Read)
  subscriptionName?: string;

  /**
   * The name of the billing subscription.
   */
  @visibility(Lifecycle.Read)
  subscriptionDisplayName?: string;

  /**
   * Justification for submitting request.
   */
  justification?: string;

  /**
   * The recipients of the billing request.
   */
  @identifiers(#[])
  recipients?: Principal[];

  /**
   * The billing scope for which the request was submitted (ex. '/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingProfiles/{billingProfileName}').
   */
  requestScope?: string;

  /**
   * The billing scope for which the request will be applied. This is a read only property derived by the service.
   */
  @visibility(Lifecycle.Read)
  billingScope?: string;

  /**
   * Status of billing request.
   */
  status?: BillingRequestStatus;

  /**
   * Type of billing request.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type?: BillingRequestType;

  /**
   * The principal of the entity who last updated the request.
   */
  lastUpdatedBy?: BillingRequestPropertiesLastUpdatedBy;

  /**
   * Date and time of last update.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedDate?: utcDateTime;
}

/**
 * The principal of the request reviewer. Will only be set if request is approved.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BillingRequestPropertiesReviewedBy extends Principal {}

/**
 * A principal who has interacted with a billing entity.
 */
model Principal {
  /**
   * The tenant id of the principal who has interacted with a billing entity.
   */
  tenantId?: string;

  /**
   * The object id of the principal who has interacted with a billing entity.
   */
  objectId?: string;

  /**
   * The user principal name of the principal who has interacted with a billing entity.
   */
  upn?: string;
}

/**
 * The principal of the entity who created the request.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BillingRequestPropertiesCreatedBy extends Principal {}

/**
 * The principal of the entity who last updated the request.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BillingRequestPropertiesLastUpdatedBy extends Principal {}

/**
 * The properties of the billing role assignment.
 */
model BillingRoleAssignmentProperties {
  /**
   * The provisioning state of the resource during a long-running operation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The date the role assignment was created.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;

  /**
   * The tenant Id of the user who created the role assignment.
   */
  @visibility(Lifecycle.Read)
  createdByPrincipalTenantId?: string;

  /**
   * The object ID of the user who created the role assignment.
   */
  @visibility(Lifecycle.Read)
  createdByPrincipalId?: string;

  /**
   * The principal PUID of the user who created the role assignment.
   */
  @visibility(Lifecycle.Read)
  createdByPrincipalPuid?: string;

  /**
   * The email address of the user who created the role assignment. This is supported only for billing accounts with agreement type Enterprise Agreement.
   */
  @visibility(Lifecycle.Read)
  createdByUserEmailAddress?: string;

  /**
   * The date the role assignment was modified.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  modifiedOn?: utcDateTime;

  /**
   * The principal PUID of the user who modified the role assignment.
   */
  @visibility(Lifecycle.Read)
  modifiedByPrincipalPuid?: string;

  /**
   * The email address of the user who modified the role assignment. This is supported only for billing accounts with agreement type Enterprise Agreement.
   */
  @visibility(Lifecycle.Read)
  modifiedByUserEmailAddress?: string;

  /**
   * The principal PUID of the user who modified the role assignment.
   */
  @visibility(Lifecycle.Read)
  modifiedByPrincipalId?: string;

  /**
   * The tenant Id of the user who modified the role assignment.
   */
  @visibility(Lifecycle.Read)
  modifiedByPrincipalTenantId?: string;

  /**
   * The principal PUID of the user to whom the role was assigned.
   */
  principalPuid?: string;

  /**
   * The object id of the user to whom the role was assigned.
   */
  principalId?: string;

  /**
   * The principal tenant id of the user to whom the role was assigned.
   */
  principalTenantId?: string;

  /**
   * The ID of the role definition.
   */
  @minLength(1)
  roleDefinitionId: string;

  /**
   * The scope at which the role was assigned.
   */
  scope?: string;

  /**
   * The authentication type of the user, whether Organization or MSA, of the user to whom the role was assigned. This is supported only for billing accounts with agreement type Enterprise Agreement.
   */
  userAuthenticationType?: string;

  /**
   * The email address of the user to whom the role was assigned. This is supported only for billing accounts with agreement type Enterprise Agreement.
   */
  userEmailAddress?: string;

  /**
   * The friendly name of the tenant of the user to whom the role was assigned. This will be 'Primary Tenant' for the primary tenant of the billing account.
   */
  @visibility(Lifecycle.Read)
  principalTenantName?: string;

  /**
   * The display name of the principal to whom the role was assigned.
   */
  @visibility(Lifecycle.Read)
  principalDisplayName?: string;

  /**
   * The type of a role Assignment.
   */
  @visibility(Lifecycle.Read)
  principalType?: PrincipalType;

  /**
   * The ID of the billing request that was created for the role assignment. This is only applicable to cross tenant role assignments or role assignments created through the billing request.
   */
  @visibility(Lifecycle.Read)
  billingRequestId?: string;

  /**
   * The fully qualified ID that uniquely identifies a billing account.
   */
  @visibility(Lifecycle.Read)
  billingAccountId?: string;

  /**
   * The name of the billing account.
   */
  @visibility(Lifecycle.Read)
  billingAccountDisplayName?: string;

  /**
   * The fully qualified ID that uniquely identifies a billing profile.
   */
  @visibility(Lifecycle.Read)
  billingProfileId?: string;

  /**
   * The name of the billing profile.
   */
  @visibility(Lifecycle.Read)
  billingProfileDisplayName?: string;

  /**
   * The fully qualified ID that uniquely identifies an invoice section.
   */
  @visibility(Lifecycle.Read)
  invoiceSectionId?: string;

  /**
   * The name of the invoice section.
   */
  @visibility(Lifecycle.Read)
  invoiceSectionDisplayName?: string;

  /**
   * The fully qualified ID that uniquely identifies a customer.
   */
  @visibility(Lifecycle.Read)
  customerId?: string;

  /**
   * The name of the customer.
   */
  @visibility(Lifecycle.Read)
  customerDisplayName?: string;
}

/**
 * The properties of a role definition.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BillingRoleDefinitionProperties {
  /**
   * The role description.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * The billingPermissions the role has.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  permissions?: BillingPermission[];

  /**
   * The name of the role.
   */
  @minLength(1)
  roleName: string;
}

/**
 * The SKU to be applied for this resource
 */
model Sku {
  /**
   * Name of the SKU to be applied
   */
  name?: string;
}

/**
 * Savings plan order properties
 */
model SavingsPlanOrderModelProperties {
  /**
   * Display name
   */
  displayName?: string;

  /**
   * The provisioning state of the savings plan, e.g. Succeeded
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Subscription that will be charged for purchasing SavingsPlan
   */
  billingScopeId?: string;

  /**
   * Fully-qualified identifier of the billing profile where the savings plan is applied. Present only for Field-led or Customer-led customers.
   */
  @visibility(Lifecycle.Read)
  billingProfileId?: string;

  /**
   * Fully-qualified identifier of the customer where the savings plan is applied. Present only for Partner-led customers.
   */
  @visibility(Lifecycle.Read)
  customerId?: string;

  /**
   * Fully-qualified identifier of the billing account where the savings plan is applied.
   */
  @visibility(Lifecycle.Read)
  billingAccountId?: string;

  /**
   * Represents the Savings plan term in ISO 8601 format.
   */
  term?: SavingsPlanTerm;

  /**
   * Represents the billing plan in ISO 8601 format. Required only for monthly purchases.
   */
  billingPlan?: BillingPlan;

  /**
   * DateTime when the savings plan benefit started.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  benefitStartTime?: utcDateTime;

  /**
   * DateTime when the savings plan will expire.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryDateTime?: utcDateTime;

  /**
   * Information describing the type of billing plan for this savings plan.
   */
  planInformation?: BillingPlanInformation;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  savingsPlans?: string[];

  /**
   * Extended status information
   */
  @visibility(Lifecycle.Read)
  extendedStatusInfo?: ExtendedStatusInfo;

  /**
   * Represents UPN
   */
  productCode?: string;
}

/**
 * Information describing the type of billing plan for this savings plan.
 */
model BillingPlanInformation {
  /**
   * Amount of money to be paid for the Order. Tax is not included.
   */
  pricingCurrencyTotal?: Price;

  /**
   * Date when the billing plan has started.
   */
  startDate?: plainDate;

  /**
   * For recurring billing plans, indicates the date when next payment will be processed. Null when total is paid off.
   */
  nextPaymentDueDate?: plainDate;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  transactions?: PaymentDetail[];
}

/**
 * The price.
 */
model Price {
  /**
   * The ISO 4217 3-letter currency code for the currency used by this purchase record.
   */
  currencyCode?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  amount?: float64;
}

/**
 * Information about payment related to a savings plan order.
 */
model PaymentDetail {
  /**
   * Date when the payment needs to be done.
   */
  dueDate?: plainDate;

  /**
   * Date when the transaction is completed. Null when it is scheduled.
   */
  paymentDate?: plainDate;

  /**
   * Amount in pricing currency. Tax not included.
   */
  pricingCurrencyTotal?: Price;

  /**
   * Amount charged in Billing currency. Tax not included. Is null for future payments
   */
  billingCurrencyTotal?: Price;

  /**
   * Describes whether the payment is completed, failed, pending, cancelled or scheduled in the future.
   */
  status?: PaymentStatus;

  /**
   * Extended status information
   */
  @visibility(Lifecycle.Read)
  extendedStatusInfo?: ExtendedStatusInfo;
}

/**
 * Extended status information
 */
model ExtendedStatusInfo {
  /**
   * Status code providing additional information.
   */
  statusCode?: string;

  /**
   * The message giving detailed information about the status code.
   */
  message?: string;

  /**
   * Properties specific to credit line check failure
   */
  properties?: ExtendedStatusInfoProperties;
}

/**
 * Properties specific to credit line check failure
 */
model ExtendedStatusInfoProperties {
  /**
   * The subscription that has failed credit line check.
   */
  subscriptionId?: string;
}

/**
 * List of savings plan orders
 */
model SavingsPlanOrderModelList is Azure.Core.Page<SavingsPlanOrderModel>;

/**
 * List of savings plans
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SavingsPlanModelListResult extends SavingsPlanModelList {
  /**
   * The roll out count summary of the savings plans
   */
  summary: SavingsPlanSummaryCount;
}

/**
 * List of savings plans
 */
model SavingsPlanModelList is Azure.Core.Page<SavingsPlanModel>;

/**
 * Savings plan properties
 */
model SavingsPlanModelProperties {
  /**
   * Display name
   */
  displayName?: string;

  /**
   * The provisioning state of the resource during a long-running operation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The provisioning state of the savings plan for display, e.g. Succeeded
   */
  @visibility(Lifecycle.Read)
  displayProvisioningState?: string;

  /**
   * The applied scope type of the savings plan for display, e.g. Shared
   */
  @visibility(Lifecycle.Read)
  userFriendlyAppliedScopeType?: string;

  /**
   * Subscription that will be charged for purchasing SavingsPlan
   */
  billingScopeId?: string;

  /**
   * Fully-qualified identifier of the billing profile where the savings plan is applied. Present only for Field-led or Customer-led customers.
   */
  @visibility(Lifecycle.Read)
  billingProfileId?: string;

  /**
   * Fully-qualified identifier of the customer where the savings plan is applied. Present only for Partner-led customers.
   */
  @visibility(Lifecycle.Read)
  customerId?: string;

  /**
   * Fully-qualified identifier of the billing account where the savings plan is applied.
   */
  @visibility(Lifecycle.Read)
  billingAccountId?: string;

  /**
   * Represents the Savings plan term in ISO 8601 format.
   */
  term?: SavingsPlanTerm;

  /**
   * Setting this to true will automatically purchase a new benefit on the expiration date time.
   */
  renew?: boolean;

  /**
   * SavingsPlan Id of the SavingsPlan from which this SavingsPlan is renewed.
   */
  renewSource?: string;

  /**
   * SavingsPlan Id of the SavingsPlan which is purchased because of renew.
   */
  renewDestination?: string;

  /**
   * Properties specific to renew.
   */
  renewProperties?: RenewProperties;

  /**
   * Represents the billing plan in ISO 8601 format. Required only for monthly purchases.
   */
  billingPlan?: BillingPlan;

  /**
   * Type of the Applied Scope.
   */
  appliedScopeType?: AppliedScopeType;

  /**
   * Properties specific to applied scope type. Not required if not applicable.
   */
  appliedScopeProperties?: AppliedScopeProperties;

  /**
   * Commitment towards the benefit.
   */
  commitment?: Commitment;

  /**
   * DateTime of the savings plan starting when this version is effective from.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  effectiveDateTime?: utcDateTime;

  /**
   * This is the DateTime when the savings plan benefit starts.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  benefitStartTime?: utcDateTime;

  /**
   * This is the date-time when the savings plan will expire.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryDateTime?: utcDateTime;

  /**
   * Date time when the savings plan was purchased.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  purchaseDateTime?: utcDateTime;

  /**
   * Savings plan utilization
   */
  @visibility(Lifecycle.Read)
  utilization?: Utilization;

  /**
   * Extended status information
   */
  @visibility(Lifecycle.Read)
  extendedStatusInfo?: ExtendedStatusInfo;

  /**
   * Represents UPN
   */
  productCode?: string;
}

/**
 * Properties specific to renew.
 */
model RenewProperties {
  /**
   * Purchase request.
   */
  purchaseProperties?: PurchaseRequest;
}

/**
 * Purchase request.
 */
model PurchaseRequest {
  /**
   * The SKU to be applied for this resource
   */
  sku?: Sku;

  /**
   * Purchase request properties.
   */
  properties?: PurchaseRequestProperties;
}

/**
 * Purchase request properties.
 */
model PurchaseRequestProperties {
  /**
   * Friendly name of the savings plan
   */
  displayName?: string;

  /**
   * Subscription that will be charged for purchasing SavingsPlan
   */
  billingScopeId?: string;

  /**
   * Represents the Savings plan term in ISO 8601 format.
   */
  term?: SavingsPlanTerm;

  /**
   * Represents the billing plan in ISO 8601 format. Required only for monthly purchases.
   */
  billingPlan?: BillingPlan;

  /**
   * Type of the Applied Scope.
   */
  appliedScopeType?: AppliedScopeType;

  /**
   * Commitment towards the benefit.
   */
  commitment?: Commitment;

  /**
   * Setting this to true will automatically purchase a new benefit on the expiration date time.
   */
  renew?: boolean;

  /**
   * Properties specific to applied scope type. Not required if not applicable.
   */
  appliedScopeProperties?: AppliedScopeProperties;
}

/**
 * Commitment towards the benefit.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model Commitment extends Price {
  /**
   * Commitment grain.
   */
  grain?: CommitmentGrain;
}

/**
 * Properties specific to applied scope type. Not required if not applicable.
 */
model AppliedScopeProperties {
  /**
   * Tenant ID where the savings plan where the benefit is applied.
   */
  tenantId?: string;

  /**
   * Fully-qualified identifier of the management group where the benefit is applied.
   */
  managementGroupId?: string;

  /**
   * Fully-qualified identifier of the subscription where the benefit is applied.
   */
  subscriptionId?: string;

  /**
   * Fully-qualified identifier of the resource group where the benefit is applied.
   */
  resourceGroupId?: string;

  /**
   * Display name
   */
  displayName?: string;
}

/**
 * Savings plan utilization
 */
model Utilization {
  /**
   * The trend for a savings plan's utilization
   */
  @visibility(Lifecycle.Read)
  trend?: string;

  /**
   * The array of aggregates of a savings plan's utilization
   */
  @identifiers(#[])
  aggregates?: UtilizationAggregates[];
}

/**
 * The aggregate values of savings plan utilization
 */
model UtilizationAggregates {
  /**
   * The grain of the aggregate
   */
  @visibility(Lifecycle.Read)
  grain?: float32;

  /**
   * The grain unit of the aggregate
   */
  @visibility(Lifecycle.Read)
  grainUnit?: string;

  /**
   * The aggregate value
   */
  @visibility(Lifecycle.Read)
  value?: float32;

  /**
   * The aggregate value unit
   */
  @visibility(Lifecycle.Read)
  valueUnit?: string;
}

/**
 * Savings plan patch request
 */
model SavingsPlanUpdateRequest {
  /**
   * Savings plan patch request
   */
  properties?: SavingsPlanUpdateRequestProperties;

  /**
   * The SKU to be applied for this resource
   */
  sku?: Sku;

  /**
   * Tags for this reservation
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Savings plan patch request
 */
model SavingsPlanUpdateRequestProperties {
  /**
   * Display name
   */
  displayName?: string;

  /**
   * Type of the Applied Scope.
   */
  appliedScopeType?: AppliedScopeType;

  /**
   * Properties specific to applied scope type. Not required if not applicable.
   */
  appliedScopeProperties?: AppliedScopeProperties;

  /**
   * Setting this to true will automatically purchase a new benefit on the expiration date time.
   */
  renew?: boolean;

  /**
   * Properties specific to renew.
   */
  renewProperties?: RenewProperties;
}

/**
 * Savings plan update validate request.
 */
model SavingsPlanUpdateValidateRequest {
  /**
   * The benefits of a savings plan.
   */
  @identifiers(#[])
  benefits?: SavingsPlanUpdateRequestProperties[];
}

/**
 * Savings plan update validate response.
 */
model SavingsPlanValidateResponse {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  benefits?: SavingsPlanValidResponseProperty[];

  /**
   * Url to get the next page.
   */
  nextLink?: string;
}

/**
 * Benefit scope response property
 */
model SavingsPlanValidResponseProperty {
  /**
   * Indicates if the provided input is valid
   */
  valid?: boolean;

  /**
   * Failure reason code if the provided input is invalid
   */
  reasonCode?: string;

  /**
   * Failure reason if the provided input is invalid
   */
  reason?: string;
}

/**
 * The billing properties of a subscription.
 */
model BillingSubscriptionProperties {
  /**
   * Indicates whether auto renewal is turned on or off for a product.
   */
  autoRenew?: AutoRenew;

  /**
   * The provisioning tenant of the subscription.
   */
  beneficiaryTenantId?: string;

  /**
   * The beneficiary of the billing subscription.
   */
  beneficiary?: Beneficiary;

  /**
   * The billing frequency in ISO8601 format of product in the subscription. Example: P1M, P3M, P1Y
   */
  billingFrequency?: string;

  /**
   * The fully qualified ID that uniquely identifies a billing profile.
   */
  billingProfileId?: string;

  /**
   * Dictionary of billing policies associated with the subscription.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  billingPolicies?: Record<string>;

  /**
   * The name of the billing profile.
   */
  @visibility(Lifecycle.Read)
  billingProfileDisplayName?: string;

  /**
   * The ID that uniquely identifies a billing profile.
   */
  @visibility(Lifecycle.Read)
  billingProfileName?: string;

  /**
   * The cost center applied to the subscription. This field is only available for consumption subscriptions of Microsoft Customer Agreement or Enterprise Agreement Type billing accounts.
   */
  consumptionCostCenter?: string;

  /**
   * The fully qualified ID that uniquely identifies a customer.
   */
  customerId?: string;

  /**
   * The name of the customer.
   */
  @visibility(Lifecycle.Read)
  customerDisplayName?: string;

  /**
   * The ID that uniquely identifies a customer.
   */
  @visibility(Lifecycle.Read)
  customerName?: string;

  /**
   * The name of the billing subscription.
   */
  displayName?: string;

  /**
   * The enrollment Account ID associated with the subscription. This field is available only for the Enterprise Agreement Type billing accounts.
   */
  @visibility(Lifecycle.Read)
  enrollmentAccountId?: string;

  /**
   * The enrollment Account name associated with the subscription. This field is available only for the Enterprise Agreement Type billing accounts.
   */
  @visibility(Lifecycle.Read)
  enrollmentAccountDisplayName?: string;

  /**
   * Enrollment Account Subscription details. This field is available only for the Enterprise Agreement Type billing accounts.
   */
  @visibility(Lifecycle.Read)
  enrollmentAccountSubscriptionDetails?: EnrollmentAccountSubscriptionDetails;

  /**
   * The fully qualified ID that uniquely identifies an invoice section.
   */
  invoiceSectionId?: string;

  /**
   * The name of the invoice section.
   */
  @visibility(Lifecycle.Read)
  invoiceSectionDisplayName?: string;

  /**
   * The ID that uniquely identifies an invoice section.
   */
  @visibility(Lifecycle.Read)
  invoiceSectionName?: string;

  /**
   * The last month's charges. This field is only available for usage based subscriptions of Microsoft Customer Agreement billing accounts.
   */
  @visibility(Lifecycle.Read)
  lastMonthCharges?: Amount;

  /**
   * The current month to date charges. This field is only available for usage based subscriptions of Microsoft Customer Agreement billing accounts.
   */
  @visibility(Lifecycle.Read)
  monthToDateCharges?: Amount;

  /**
   * Next billing cycle details of the subscription.
   */
  @visibility(Lifecycle.Read)
  nextBillingCycleDetails?: NextBillingCycleDetails;

  /**
   * The offer ID for the subscription. This field is only available for the Microsoft Online Services Program billing accounts or billing accounts with agreement type Enterprise Agreement.
   */
  @visibility(Lifecycle.Read)
  offerId?: string;

  /**
   * The category of the product for which the subscription is purchased. Possible values include: AzureSupport, Hardware, ReservationOrder, SaaS, SavingsPlanOrder, Software, UsageBased, Other.
   */
  @visibility(Lifecycle.Read)
  productCategory?: string;

  /**
   * Type of the product for which the subscription is purchased.
   */
  @visibility(Lifecycle.Read)
  productType?: string;

  /**
   * Id of the product for which the subscription is purchased.
   */
  productTypeId?: string;

  /**
   * Purchase date of the product in UTC time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  purchaseDate?: utcDateTime;

  /**
   * The quantity of licenses or fulfillment units for the subscription.
   */
  quantity?: int64;

  /**
   * Reseller for this subscription. The fields is not available for Microsoft Partner Agreement billing accounts.
   */
  @visibility(Lifecycle.Read)
  reseller?: Reseller;

  /**
   * Details for the next renewal term of a subscription.
   */
  @visibility(Lifecycle.Read)
  renewalTermDetails?: RenewalTermDetails;

  /**
   * The SKU ID of the product for which the subscription is purchased. This field is is only available  for Microsoft Customer Agreement billing accounts.
   */
  skuId?: string;

  /**
   * The SKU description of the product for which the subscription is purchased. This field is is only available for billing accounts with agreement type Microsoft Customer Agreement and Microsoft Partner Agreement.
   */
  @visibility(Lifecycle.Read)
  skuDescription?: string;

  /**
   * System imposed policies that regulate behavior of the subscription.
   */
  systemOverrides?: SystemOverrides;

  /**
   * Unique identifier of the linked resource.
   */
  @visibility(Lifecycle.Read)
  resourceUri?: string;

  /**
   * The duration in ISO8601 format for which you can use the subscription. Example: P1M, P3M, P1Y
   */
  termDuration?: string;

  /**
   * Start date of the term in UTC time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  termStartDate?: utcDateTime;

  /**
   * End date of the term in UTC time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  termEndDate?: utcDateTime;

  /**
   * The tenant in which the subscription is provisioned.
   */
  provisioningTenantId?: string;

  /**
   * The status of the subscription. This field is not available for Enterprise Agreement billing accounts
   */
  @visibility(Lifecycle.Read)
  status?: BillingSubscriptionStatus;

  /**
   * The status of an operation on the subscription. When None, there is no ongoing operation. When LockedForUpdate, write operations will be blocked on the Billing Subscription. Other is the default value and you may need to refer to the latest API version for more details.
   */
  @visibility(Lifecycle.Read)
  operationStatus?: BillingSubscriptionOperationStatus;

  /**
   * The provisioning state of the resource during a long-running operation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The ID of the subscription.
   */
  @visibility(Lifecycle.Read)
  subscriptionId?: string;

  /**
   * The suspension reason for a subscription. This field is not available for Enterprise Agreement billing accounts.
   */
  @visibility(Lifecycle.Read)
  suspensionReasons?: string[];

  /**
   * The suspension details for a subscription. This field is not available for Enterprise Agreement billing accounts.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  suspensionReasonDetails?: BillingSubscriptionStatusDetails[];
}

/**
 * Details of the beneficiary.
 */
model Beneficiary {
  /**
   * The ID that uniquely identifies a tenant.
   */
  tenantId?: string;

  /**
   * The ID that uniquely identifies a user in a tenant.
   */
  objectId?: string;
}

/**
 * The billing properties that can be modified. Available only for the Enterprise Agreement Type.
 */
model EnrollmentAccountSubscriptionDetails {
  /**
   * The enrollment Account and the subscription association start date. This field is available only for the Enterprise Agreement Type.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  enrollmentAccountStartDate?: utcDateTime;

  /**
   * The current enrollment account status of the subscription. This field is available only for the Enterprise Agreement Type.
   */
  @visibility(Lifecycle.Read)
  subscriptionEnrollmentAccountStatus?: SubscriptionEnrollmentAccountStatus;
}

/**
 * Billing cycle details of the product.
 */
model NextBillingCycleDetails {
  /**
   * Billing frequency of the product under the subscription.
   */
  @visibility(Lifecycle.Read)
  billingFrequency?: string;
}

/**
 * Details of the reseller.
 */
model Reseller {
  /**
   * The MPN ID of the reseller.
   */
  @visibility(Lifecycle.Read)
  resellerId?: string;

  /**
   * The name of the reseller.
   */
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * Details for the next renewal term of a subscription.
 */
model RenewalTermDetails {
  /**
   * The billing frequency in ISO8601 format of product in the subscription. Example: P1M, P3M, P1Y
   */
  @visibility(Lifecycle.Read)
  billingFrequency?: string;

  /**
   * Id of the product for which the subscription is purchased.
   */
  @visibility(Lifecycle.Read)
  productId?: string;

  /**
   * Type Id of the product for which the subscription is purchased.
   */
  @visibility(Lifecycle.Read)
  productTypeId?: string;

  /**
   * The SKU ID of the product for which the subscription is purchased. This field is is only available  for Microsoft Customer Agreement billing accounts.
   */
  @visibility(Lifecycle.Read)
  skuId?: string;

  /**
   * The duration in ISO8601 format for which you can use the subscription. Example: P1M, P3M, P1Y
   */
  @visibility(Lifecycle.Read)
  termDuration?: string;

  /**
   * The quantity of licenses or fulfillment units for the subscription.
   */
  quantity?: int64;

  /**
   * End date of the term in UTC time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  termEndDate?: utcDateTime;
}

/**
 * System imposed policies that regulate behavior of the subscription.
 */
model SystemOverrides {
  /**
   * The policy override for the subscription indicates whether the self-serve cancellation or seat reduction is allowed.
   */
  @visibility(Lifecycle.Read)
  cancellation?: Cancellation;

  /**
   * The end date in UTC time by when the self-serve cancellation ends.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  cancellationAllowedEndDate?: utcDateTime;
}

/**
 * A billing subscription alias.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BillingSubscriptionAliasProperties extends BillingSubscriptionProperties {
  /**
   * The ID of the billing subscription with the subscription alias.
   */
  @visibility(Lifecycle.Read)
  billingSubscriptionId?: string;
}

/**
 * Request parameters for cancel customer subscription.
 */
model CancelSubscriptionRequest {
  /**
   * Cancellation reason.
   */
  cancellationReason: CancellationReason;

  /**
   * The fully qualified ID that uniquely identifies a customer.
   */
  customerId?: string;
}

/**
 * Request parameters that are provided to merge the two billing subscriptions.
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
 * Request parameters to transfer billing subscription.
 */
model MoveBillingSubscriptionRequest {
  /**
   * The destination invoice section id.
   */
  destinationInvoiceSectionId?: string;

  /**
   * The destination enrollment account id.
   */
  destinationEnrollmentAccountId?: string;
}

/**
 * Request parameters that are provided to split the billing subscription.
 */
model BillingSubscriptionSplitRequest {
  /**
   * The ID of the target product to which the subscription needs to be split into. This value is not same as the value returned in Get API call and can be retrieved from Catalog API to know the product id to split into.
   */
  targetProductTypeId?: string;

  /**
   * The ID of the target product to which the subscription needs to be split into. This value is not same as the value returned in Get API call and can be retrieved from Catalog API to know the sku id to split into.
   */
  targetSkuId?: string;

  /**
   * The quantity of the target product to which the subscription needs to be split into.
   */
  quantity?: int32;

  /**
   * The term duration of the target in ISO8601 format product to which the subscription needs to be split into. Example: P1M, P1Y
   */
  termDuration?: string;

  /**
   * The billing frequency of the target subscription in the ISO8601 format. Example: P1M, P3M, P1Y"
   */
  billingFrequency?: string;
}

/**
 * Result of the transfer eligibility validation.
 */
model MoveBillingSubscriptionEligibilityResult {
  /**
   * Specifies whether the subscription is eligible to be transferred.
   */
  @visibility(Lifecycle.Read)
  isMoveEligible?: boolean;

  /**
   * Error details of the transfer eligibility validation.
   */
  errorDetails?: MoveBillingSubscriptionErrorDetails;
}

/**
 * Error details of the transfer eligibility validation.
 */
model MoveBillingSubscriptionErrorDetails {
  /**
   * Error code of the transfer validation response.
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
 * The billing properties of a subscription.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BillingSubscriptionPatch extends ProxyResourceWithTags {
  /**
   * The properties of a(n) BillingSubscription
   */
  properties?: BillingSubscriptionProperties;
}

/**
 * A partner's customer.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CustomerProperties {
  /**
   * The name of the billing profile.
   */
  @visibility(Lifecycle.Read)
  billingProfileDisplayName?: string;

  /**
   * The fully qualified ID that uniquely identifies a billing profile.
   */
  @visibility(Lifecycle.Read)
  billingProfileId?: string;

  /**
   * The name of the customer.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * The system generated unique identifier for a customer.
   */
  @visibility(Lifecycle.Read)
  systemId?: string;

  /**
   * Identifies the status of an customer. This is an upcoming property that will be populated in the future.
   */
  @visibility(Lifecycle.Read)
  status?: CustomerStatus;

  /**
   * Azure plans enabled for the customer.
   */
  @identifiers(#[])
  enabledAzurePlans?: AzurePlan[];

  /**
   * The list of resellers for which an Azure plan is enabled for the customer.
   */
  @identifiers(#[])
  resellers?: Reseller[];

  /**
   * Dictionary of metadata associated with the resource. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Optional grouping of enrollment accounts to segment costs into logical groupings and set budgets.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DepartmentProperties {
  /**
   * The cost center associated with the department.
   */
  costCenter?: string;

  /**
   * The name of the department.
   */
  displayName?: string;

  /**
   * The ID that uniquely identifies the department.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The status of the department.
   */
  @visibility(Lifecycle.Read)
  status?: string;
}

/**
 * It is an organizational hierarchy within a billing account to administer and manage azure costs.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model EnrollmentAccountProperties {
  /**
   * The cost center associated with the enrollment account.
   */
  costCenter?: string;

  /**
   * The name of the enrollment account.
   */
  displayName?: string;

  /**
   * The name of the department under which the enrollment account exists.
   */
  @visibility(Lifecycle.Read)
  departmentDisplayName?: string;

  /**
   * The ID that uniquely identifies the department.
   */
  @visibility(Lifecycle.Read)
  departmentId?: string;

  /**
   * Boolean flag which enables subscribers to run development and testing workloads on Azure at special Dev/Test rates.
   */
  isDevTestEnabled?: boolean;

  /**
   * The owner of the enrollment account.
   */
  @visibility(Lifecycle.Read)
  accountOwner?: string;

  /**
   * The authorization type of the enrollment account.
   */
  @visibility(Lifecycle.Read)
  authType?: string;

  /**
   * The status of the enrollment account.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * The date from which the enrollment account became valid and functional.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDate?: utcDateTime;

  /**
   * The date of expiration of the enrollment account.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDate?: utcDateTime;
}

/**
 * An invoice.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model InvoiceProperties {
  /**
   * The amount due as of now.
   */
  amountDue?: InvoicePropertiesAmountDue;

  /**
   * The amount of Azure prepayment applied to the charges. This field is applicable to billing accounts with agreement type Microsoft Customer Agreement.
   */
  azurePrepaymentApplied?: InvoicePropertiesAzurePrepaymentApplied;

  /**
   * The total charges for the invoice billing period.
   */
  billedAmount?: InvoicePropertiesBilledAmount;

  /**
   * The Id of the active invoice which is originally billed after this invoice was voided. This field is applicable to the void invoices only.
   */
  @visibility(Lifecycle.Read)
  billedDocumentId?: string;

  /**
   * The name of the billing profile for which the invoice is generated.
   */
  @visibility(Lifecycle.Read)
  billingProfileDisplayName?: string;

  /**
   * The ID of the billing profile for which the invoice is generated.
   */
  @visibility(Lifecycle.Read)
  billingProfileId?: string;

  /**
   * The total refund for returns and cancellations during the invoice billing period. This field is applicable to billing accounts with agreement type Microsoft Customer Agreement.
   */
  creditAmount?: InvoicePropertiesCreditAmount;

  /**
   * The Id of the invoice which got voided and this credit note was issued as a result. This field is applicable to the credit notes only.
   */
  @visibility(Lifecycle.Read)
  creditForDocumentId?: string;

  /**
   * List of documents available to download and view such as invoice, credit note, or tax receipt.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  documents?: InvoiceDocument[];

  /**
   * The type of the document.
   */
  @visibility(Lifecycle.Read)
  documentType?: InvoiceDocumentType;

  /**
   * The due date for the invoice.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  dueDate?: utcDateTime;

  /**
   * List of failed payments.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  failedPayments?: FailedPayment[];

  /**
   * The amount of free Azure credits applied to the charges. This field is applicable to billing accounts with agreement type Microsoft Customer Agreement.
   */
  freeAzureCreditApplied?: InvoicePropertiesFreeAzureCreditApplied;

  /**
   * The date when the invoice was generated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  invoiceDate?: utcDateTime;

  /**
   * The end date of the billing period for which the invoice is generated. The date is in MM-DD-YYYY format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  invoicePeriodEndDate?: utcDateTime;

  /**
   * The start date of the billing period for which the invoice is generated. The date is in MM-DD-YYYY format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  invoicePeriodStartDate?: utcDateTime;

  /**
   * Invoice type.
   */
  @visibility(Lifecycle.Read)
  invoiceType?: InvoiceType;

  /**
   * Specifies if the invoice is generated as part of monthly invoicing cycle or not. This field is applicable to billing accounts with agreement type Microsoft Customer Agreement.
   */
  @visibility(Lifecycle.Read)
  isMonthlyInvoice?: boolean;

  /**
   * List of payments.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  payments?: Payment[];

  /**
   * An optional purchase order number for the invoice.
   */
  @visibility(Lifecycle.Read)
  purchaseOrderNumber?: string;

  /**
   * Rebill details for an invoice.
   */
  rebillDetails?: InvoicePropertiesRebillDetails;

  /**
   * The current status of the invoice.
   */
  @visibility(Lifecycle.Read)
  status?: InvoiceStatus;

  /**
   * The name of the billing subscription for which the invoice is generated.
   */
  @visibility(Lifecycle.Read)
  subscriptionDisplayName?: string;

  /**
   * The ID of the subscription for which the invoice is generated.
   */
  @visibility(Lifecycle.Read)
  subscriptionId?: string;

  /**
   * Identifies the type of tax calculation used for the invoice. The field is applicable only to invoices with special tax calculation logic.
   */
  @visibility(Lifecycle.Read)
  specialTaxationType?: SpecialTaxationType;

  /**
   * The pre-tax amount due. This field is applicable to billing accounts with agreement type Microsoft Customer Agreement.
   */
  subTotal?: InvoicePropertiesSubTotal;

  /**
   * The amount of tax charged for the billing period. This field is applicable to billing accounts with agreement type Microsoft Customer Agreement.
   */
  taxAmount?: InvoicePropertiesTaxAmount;

  /**
   * The amount due when the invoice was generated. This field is applicable to billing accounts with agreement type Microsoft Customer Agreement.
   */
  totalAmount?: InvoicePropertiesTotalAmount;

  /**
   * The details of a refund request.
   */
  refundDetails?: InvoicePropertiesRefundDetails;
}

/**
 * The amount due as of now.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model InvoicePropertiesAmountDue extends Amount {}

/**
 * The amount of Azure prepayment applied to the charges. This field is applicable to billing accounts with agreement type Microsoft Customer Agreement.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model InvoicePropertiesAzurePrepaymentApplied extends Amount {}

/**
 * The total charges for the invoice billing period.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model InvoicePropertiesBilledAmount extends Amount {}

/**
 * The total refund for returns and cancellations during the invoice billing period. This field is applicable to billing accounts with agreement type Microsoft Customer Agreement.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model InvoicePropertiesCreditAmount extends Amount {}

/**
 * The properties of a document.
 */
model InvoiceDocument {
  /**
   * The document numbers for the invoice document.
   */
  @visibility(Lifecycle.Read)
  documentNumbers?: string[];

  /**
   * The URL to download the invoice document if the source is external to Microsoft.Billing.
   */
  @visibility(Lifecycle.Read)
  externalUrl?: string;

  /**
   * The type of the document.
   */
  @visibility(Lifecycle.Read)
  kind?: InvoiceDocumentType;

  /**
   * The ID that uniquely identifies an invoice document. This ID may be an identifier for an invoice PDF, a credit note, or a tax receipt.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The URL to download the invoice document if the source is internal to Microsoft.Billing.
   */
  @visibility(Lifecycle.Read)
  url?: string;

  /**
   * The source of the document. ENF for Brazil and DRS for rest of the world.
   */
  @visibility(Lifecycle.Read)
  source?: DocumentSource;
}

/**
 * A failed payment.
 */
model FailedPayment {
  /**
   * The date when the payment was attempted.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  date?: utcDateTime;

  /**
   * The reason that the payment failed.
   */
  @visibility(Lifecycle.Read)
  failedPaymentReason?: FailedPaymentReason;
}

/**
 * The amount of free Azure credits applied to the charges. This field is applicable to billing accounts with agreement type Microsoft Customer Agreement.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model InvoicePropertiesFreeAzureCreditApplied extends Amount {}

/**
 * An invoice payment.
 */
model Payment {
  /**
   * The paid amount.
   */
  amount?: PaymentAmount;

  /**
   * The date when the payment was made.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  date?: utcDateTime;

  /**
   * The ID that uniquely identifies the payment method used for the invoice.
   */
  @visibility(Lifecycle.Read)
  paymentMethodId?: string;

  /**
   * The family of payment method.
   */
  @visibility(Lifecycle.Read)
  paymentMethodFamily?: PaymentMethodFamily;

  /**
   * The type of payment method.
   */
  @visibility(Lifecycle.Read)
  paymentMethodType?: string;

  /**
   * The type of payment.
   */
  @visibility(Lifecycle.Read)
  paymentType?: string;
}

/**
 * The paid amount.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PaymentAmount extends Amount {}

/**
 * Rebill details for an invoice.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model InvoicePropertiesRebillDetails extends RebillDetails {}

/**
 * The rebill details of an invoice.
 */
model RebillDetails {
  /**
   * The ID of invoice.
   */
  @visibility(Lifecycle.Read)
  invoiceDocumentId?: string;

  /**
   * The ID of credit note.
   */
  @visibility(Lifecycle.Read)
  creditNoteDocumentId?: string;

  /**
   * The rebill details of an invoice.
   */
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  rebillDetails?: RebillDetails;
}

/**
 * The pre-tax amount due. This field is applicable to billing accounts with agreement type Microsoft Customer Agreement.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model InvoicePropertiesSubTotal extends Amount {}

/**
 * The amount of tax charged for the billing period. This field is applicable to billing accounts with agreement type Microsoft Customer Agreement.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model InvoicePropertiesTaxAmount extends Amount {}

/**
 * The amount due when the invoice was generated. This field is applicable to billing accounts with agreement type Microsoft Customer Agreement.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model InvoicePropertiesTotalAmount extends Amount {}

/**
 * The details of a refund request.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model InvoicePropertiesRefundDetails extends RefundDetailsSummary {}

/**
 * The details of refund request.
 */
model RefundDetailsSummary {
  /**
   * Date when the refund was requested.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  requestedOn?: utcDateTime;

  /**
   * Date when the refund was approved.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  approvedOn?: utcDateTime;

  /**
   * Date when the refund was completed.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  completedOn?: utcDateTime;

  /**
   * The amount of refund requested.
   */
  amountRequested?: RefundDetailsSummaryAmountRequested;

  /**
   * The amount refunded.
   */
  amountRefunded?: RefundDetailsSummaryAmountRefunded;

  /**
   * The invoice ID of the rebill invoice for a refund.
   */
  @visibility(Lifecycle.Read)
  rebillInvoiceId?: string;

  /**
   * The number of transactions refunded.
   */
  @visibility(Lifecycle.Read)
  transactionCount?: int32;

  /**
   * The status of refund request.
   */
  @visibility(Lifecycle.Read)
  refundStatus?: RefundStatus;

  /**
   * The ID of refund operation.
   */
  @visibility(Lifecycle.Read)
  refundOperationId?: string;

  /**
   * The reason for refund.
   */
  @visibility(Lifecycle.Read)
  refundReason?: RefundReasonCode;
}

/**
 * The amount of refund requested.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RefundDetailsSummaryAmountRequested extends Amount {}

/**
 * The amount refunded.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RefundDetailsSummaryAmountRefunded extends Amount {}

/**
 * A list of download details for individual documents.
 */
model DocumentDownloadRequest {
  /**
   * The ID that uniquely identifies an invoice document. This ID may be an identifier for an invoice PDF, a credit note, or a tax receipt. If omitted, the most recent invoice PDF for the invoice will be returned.
   */
  documentName?: string;

  /**
   * The ID that uniquely identifies an invoice.
   */
  invoiceName?: string;
}

/**
 * A secure URL that can be used to download a an entity until the URL expires.
 */
model DocumentDownloadResult {
  /**
   * The time in UTC when the download URL will expire.
   */
  @visibility(Lifecycle.Read)
  expiryTime?: string;

  /**
   * The URL to the PDF or .zip file.
   */
  @visibility(Lifecycle.Read)
  url?: string;
}

/**
 * Eligibility to delete an invoice section result.
 */
model DeleteInvoiceSectionEligibilityResult {
  /**
   * Status describing if invoice section is eligible to be deleted.
   */
  eligibilityStatus?: DeleteInvoiceSectionEligibilityStatus;

  /**
   * A list of delete invoice section eligibility result details.
   */
  @identifiers(#[])
  eligibilityDetails?: DeleteInvoiceSectionEligibilityDetail[];
}

/**
 * The details of delete invoice section eligibility result.
 */
model DeleteInvoiceSectionEligibilityDetail {
  /**
   * Code for the delete invoice section validation.
   */
  code?: DeleteInvoiceSectionEligibilityCode;

  /**
   * Validation message.
   */
  message?: string;
}

/**
 * An invoice section.
 */
model InvoiceSectionProperties {
  /**
   * The provisioning state of the resource during a long-running operation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The name of the invoice section.
   */
  displayName?: string;

  /**
   * Identifies the status of an invoice section.
   */
  state?: InvoiceSectionState;

  /**
   * Reason for the specified invoice section status.
   */
  reasonCode?: InvoiceSectionStateReasonCode;

  /**
   * The system generated unique identifier for an invoice section.
   */
  @visibility(Lifecycle.Read)
  systemId?: string;

  /**
   * Identifies the cloud environments that are associated with an invoice section. This is a system managed optional field and gets updated as the invoice section gets associated with accounts in various clouds.
   */
  targetCloud?: string;

  /**
   * Dictionary of metadata associated with the resource. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Details of a REST API operation, returned from the Resource Provider Operations API.
 */
model Operation {
  /**
   * The name of the operation, as per Resource-Based Access Control (RBAC). Examples: "Microsoft.Compute/virtualMachines/write", "Microsoft.Compute/virtualMachines/capture/action".
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Whether the operation applies to data-plane. This is "true" for data-plane operations and "false" for ARM/control-plane operations.
   */
  @visibility(Lifecycle.Read)
  isDataAction?: boolean;

  /**
   * Localized display information for this particular operation.
   */
  display?: OperationDisplay;
}

/**
 * Localized display information for this particular operation.
 */
model OperationDisplay {
  /**
   * The short, localized friendly description of the operation; suitable for tool tips and detailed views.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * The concise, localized friendly name for the operation; suitable for dropdowns. E.g. "Create or Update Virtual Machine", "Restart Virtual Machine".
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * The localized friendly form of the resource provider name, e.g. "Microsoft Monitoring Insights" or "Microsoft Compute".
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /**
   * The localized friendly name of the resource type related to this operation. E.g. "Virtual Machines" or "Job Schedule Collections".
   */
  @visibility(Lifecycle.Read)
  resource?: string;
}

/**
 * The properties of a payment method link.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PaymentMethodLinkProperties {
  /**
   * The account holder name for the payment method. This is only supported for payment methods with family CreditCard.
   */
  @visibility(Lifecycle.Read)
  accountHolderName?: string;

  /**
   * The display name of the payment method.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * The expiration month and year of the payment method. This is only supported for payment methods with family CreditCard.
   */
  @visibility(Lifecycle.Read)
  expiration?: string;

  /**
   * The family of payment method.
   */
  @visibility(Lifecycle.Read)
  family?: PaymentMethodFamily;

  /**
   * Last four digits of payment method.
   */
  @visibility(Lifecycle.Read)
  lastFourDigits?: string;

  /**
   * The list of logos for the payment method.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  logos?: PaymentMethodLogo[];

  /**
   * Projection of a payment method. Will not be returned in this or future versions.
   */
  paymentMethod?: PaymentMethodProperties;

  /**
   * Id of payment method. Example: /providers/Microsoft.Billing/paymentMethods/ABCDABCDABC0
   */
  paymentMethodId?: string;

  /**
   * The type of payment method.
   */
  @visibility(Lifecycle.Read)
  paymentMethodType?: string;

  /**
   * Status of the payment method.
   */
  @visibility(Lifecycle.Read)
  status?: PaymentMethodStatus;
}

/**
 * Logo of payment method.
 */
model PaymentMethodLogo {
  /**
   * MIME type of the logo.
   */
  @visibility(Lifecycle.Read)
  mimeType?: string;

  /**
   * Public URL of image of the logo.
   */
  @visibility(Lifecycle.Read)
  url?: string;
}

/**
 * The properties of a payment method.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PaymentMethodProperties {
  /**
   * Id of payment method.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The account holder name for the payment method. This is only supported for payment methods with family CreditCard.
   */
  @visibility(Lifecycle.Read)
  accountHolderName?: string;

  /**
   * The display name of the payment method.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * The expiration month and year of the payment method. This is only supported for payment methods with family CreditCard.
   */
  @visibility(Lifecycle.Read)
  expiration?: string;

  /**
   * The family of payment method.
   */
  family?: PaymentMethodFamily;

  /**
   * Last four digits of payment method.
   */
  @visibility(Lifecycle.Read)
  lastFourDigits?: string;

  /**
   * The list of logos for the payment method.
   */
  @identifiers(#[])
  logos?: PaymentMethodLogo[];

  /**
   * The type of payment method.
   */
  @visibility(Lifecycle.Read)
  paymentMethodType?: string;

  /**
   * Status of the payment method.
   */
  status?: PaymentMethodStatus;
}

/**
 * A policy at customer scope.
 */
model CustomerPolicyProperties {
  /**
   * The provisioning state of the resource during a long-running operation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The policy that controls whether the users in customer's organization can view charges at pay-as-you-go prices.
   */
  viewCharges: ViewChargesPolicy;

  /**
   * List of all policies defined at the billing scope.
   */
  @identifiers(#["name"])
  policies?: PolicySummary[];
}

/**
 * The summary of the policy.
 */
model PolicySummary {
  /**
   * The name of the policy.
   */
  name?: string;

  /**
   * The value of the policy.
   */
  value?: string;

  /**
   * The type of the policy.
   */
  policyType?: PolicyType;

  /**
   * The scope at which the policy is defined.
   */
  scope?: string;
}

/**
 * A policy at billing profile scope.
 */
model BillingProfilePolicyProperties {
  /**
   * The provisioning state of the resource during a long-running operation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The policies for Enterprise Agreement enrollments.
   */
  enterpriseAgreementPolicies?: BillingProfilePolicyPropertiesEnterpriseAgreementPolicies;

  /**
   * The policy that controls invoice section label management at invoice section scope. This is allowed by default.
   */
  invoiceSectionLabelManagement?: InvoiceSectionLabelManagementPolicy;

  /**
   * The policy that controls whether Azure marketplace purchases are allowed.
   */
  marketplacePurchases?: MarketplacePurchasesPolicy;

  /**
   * The policy that controls whether Azure reservation purchases are allowed.
   */
  reservationPurchases?: ReservationPurchasesPolicy;

  /**
   * The policy that controls whether users with Azure savings plan purchase are allowed.
   */
  savingsPlanPurchases?: SavingsPlanPurchasesPolicy;

  /**
   * The policy that controls whether the users in customer's organization can view charges at pay-as-you-go prices.
   */
  viewCharges?: ViewChargesPolicy;

  /**
   * List of all policies defined at the billing scope.
   */
  @identifiers(#["name"])
  policies?: PolicySummary[];
}

/**
 * The policies for Enterprise Agreement enrollments.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BillingProfilePolicyPropertiesEnterpriseAgreementPolicies
  extends EnterpriseAgreementPolicies {}

/**
 * The policies for Enterprise Agreement enrollments.
 */
model EnterpriseAgreementPolicies {
  /**
   * The state showing the enrollment auth level.
   */
  authenticationType?: EnrollmentAuthLevelState;

  /**
   * The policy that controls whether account owner can view charges.
   */
  accountOwnerViewCharges?: EnrollmentAccountOwnerViewCharges;

  /**
   * The policy that controls whether department admin can view charges.
   */
  departmentAdminViewCharges?: EnrollmentDepartmentAdminViewCharges;
}

/**
 * A policy at billing account scope.
 */
model BillingAccountPolicyProperties {
  /**
   * The provisioning state of the resource during a long-running operation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The policies for Enterprise Agreement enrollments.
   */
  enterpriseAgreementPolicies?: BillingAccountPolicyPropertiesEnterpriseAgreementPolicies;

  /**
   * The policy that controls whether Azure marketplace purchases are allowed.
   */
  marketplacePurchases?: MarketplacePurchasesPolicy;

  /**
   * The policy that controls whether Azure reservation purchases are allowed.
   */
  reservationPurchases?: ReservationPurchasesPolicy;

  /**
   * The policy that controls whether users with Azure savings plan purchase are allowed.
   */
  savingsPlanPurchases?: SavingsPlanPurchasesPolicy;

  /**
   * List of all policies defined at the billing scope.
   */
  @identifiers(#["name"])
  policies?: PolicySummary[];
}

/**
 * The policies for Enterprise Agreement enrollments.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BillingAccountPolicyPropertiesEnterpriseAgreementPolicies
  extends EnterpriseAgreementPolicies {}

/**
 * A policy at subscription scope.
 */
model SubscriptionPolicyProperties {
  /**
   * The provisioning state of the resource during a long-running operation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * List of all policies defined at the billing scope.
   */
  @identifiers(#["name"])
  policies?: PolicySummary[];
}

/**
 * A product.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ProductProperties {
  /**
   * Indicates whether auto renewal is turned on or off for a product.
   */
  autoRenew?: AutoRenew;

  /**
   * The availability of the product.
   */
  @visibility(Lifecycle.Read)
  availabilityId?: string;

  /**
   * The frequency at which the product will be billed.
   */
  @visibility(Lifecycle.Read)
  billingFrequency?: string;

  /**
   * The ID of the billing profile to which the product is billed.
   */
  @visibility(Lifecycle.Read)
  billingProfileId?: string;

  /**
   * The name of the billing profile to which the product is billed.
   */
  @visibility(Lifecycle.Read)
  billingProfileDisplayName?: string;

  /**
   * The ID of the customer for whom the product was purchased. The field is applicable only for Microsoft Partner Agreement billing account.
   */
  @visibility(Lifecycle.Read)
  customerId?: string;

  /**
   * The name of the customer for whom the product was purchased. The field is applicable only for Microsoft Partner Agreement billing account.
   */
  @visibility(Lifecycle.Read)
  customerDisplayName?: string;

  /**
   * The display name of the product.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * The date when the product will be renewed or canceled.
   */
  @visibility(Lifecycle.Read)
  endDate?: string;

  /**
   * The ID of the invoice section to which the product is billed.
   */
  @visibility(Lifecycle.Read)
  invoiceSectionId?: string;

  /**
   * The name of the invoice section to which the product is billed.
   */
  @visibility(Lifecycle.Read)
  invoiceSectionDisplayName?: string;

  /**
   * The last month charges.
   */
  lastCharge?: ProductPropertiesLastCharge;

  /**
   * The date of the last charge.
   */
  @visibility(Lifecycle.Read)
  lastChargeDate?: string;

  /**
   * The description of the type of product.
   */
  @visibility(Lifecycle.Read)
  productType?: string;

  /**
   * The ID of the type of product.
   */
  @visibility(Lifecycle.Read)
  productTypeId?: string;

  /**
   * The sku ID of the product.
   */
  @visibility(Lifecycle.Read)
  skuId?: string;

  /**
   * The sku description of the product.
   */
  @visibility(Lifecycle.Read)
  skuDescription?: string;

  /**
   * The date when the product was purchased.
   */
  @visibility(Lifecycle.Read)
  purchaseDate?: string;

  /**
   * The quantity purchased for the product.
   */
  @visibility(Lifecycle.Read)
  quantity?: int64;

  /**
   * The status of the product.
   */
  @visibility(Lifecycle.Read)
  status?: ProductStatus;

  /**
   * The id of the tenant in which the product is used.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * Reseller for this product. The fields is not available for Microsoft Partner Agreement products.
   */
  reseller?: ProductPropertiesReseller;
}

/**
 * The last month charges.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ProductPropertiesLastCharge extends Amount {}

/**
 * Reseller for this product. The fields is not available for Microsoft Partner Agreement products.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ProductPropertiesReseller extends Reseller {}

/**
 * The properties of the product to initiate a transfer.
 */
model MoveProductRequest {
  /**
   * The destination invoice section id.
   */
  @minLength(1)
  destinationInvoiceSectionId: string;
}

/**
 * Result of the transfer eligibility validation.
 */
model MoveProductEligibilityResult {
  /**
   * Specifies whether the subscription is eligible to be transferred.
   */
  isMoveEligible?: boolean;

  /**
   * Error details of the transfer eligibility validation.
   */
  errorDetails?: MoveProductEligibilityResultErrorDetails;
}

/**
 * Error details of the transfer eligibility validation.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MoveProductEligibilityResultErrorDetails
  extends MoveProductErrorDetails {}

/**
 * Error details of the transfer eligibility validation.
 */
model MoveProductErrorDetails {
  /**
   * Error code for the product transfer validation.
   */
  @visibility(Lifecycle.Read)
  code?: MoveValidationErrorCode;

  /**
   * The error message.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Error details of the transfer eligibility validation.
   */
  @visibility(Lifecycle.Read)
  details?: string;
}

/**
 * A product.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ProductPatch extends ProxyResourceWithTags {
  /**
   * A product.
   */
  properties?: ProductProperties;
}

/**
 * The roll up count summary of reservations in each state
 */
model ReservationSummary {
  /**
   * The number of reservation in Cancelled state
   */
  @visibility(Lifecycle.Read)
  cancelledCount?: float32;

  /**
   * The number of reservation in Expired state
   */
  @visibility(Lifecycle.Read)
  expiredCount?: float32;

  /**
   * The number of reservation in Expiring state
   */
  @visibility(Lifecycle.Read)
  expiringCount?: float32;

  /**
   * The number of reservation in Failed state
   */
  @visibility(Lifecycle.Read)
  failedCount?: float32;

  /**
   * The number of reservation in Pending state
   */
  @visibility(Lifecycle.Read)
  pendingCount?: float32;

  /**
   * The number of reservation in Succeeded state
   */
  @visibility(Lifecycle.Read)
  succeededCount?: float32;

  /**
   * The number of reservation in 'No Benefit' state
   */
  @visibility(Lifecycle.Read)
  noBenefitCount?: float32;

  /**
   * The number of reservation in Warning state
   */
  @visibility(Lifecycle.Read)
  warningCount?: float32;

  /**
   * The number of reservation in Processing state
   */
  @visibility(Lifecycle.Read)
  processingCount?: float32;
}

/**
 * The property of reservation object.
 */
model ReservationProperty {
  /**
   * The reserved source type of the reservation, e.g. virtual machine.
   */
  @visibility(Lifecycle.Read)
  reservedResourceType?: string;

  /**
   * Allows reservation discount to be applied across skus within the same auto fit group. Not all skus support instance size flexibility.
   */
  instanceFlexibility?: InstanceFlexibility;

  /**
   * The display name of the reservation
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * The array of applied scopes of a reservation. Will be null if the reservation is in Shared scope
   */
  appliedScopes?: string[];

  /**
   * The applied scope type of the reservation.
   */
  @visibility(Lifecycle.Read)
  appliedScopeType?: string;

  /**
   * Indicates if the reservation is archived
   */
  archived?: boolean;

  /**
   * Capabilities of the reservation
   */
  capabilities?: string;

  /**
   * The number of the reservation.
   */
  @visibility(Lifecycle.Read)
  quantity?: float32;

  /**
   * The provisioning state of the reservation, e.g. Succeeded
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The effective date time of the reservation
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  effectiveDateTime?: utcDateTime;

  /**
   * This is the DateTime when the reservation benefit started.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  benefitStartTime?: utcDateTime;

  /**
   * DateTime of the last time the reservation was updated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedDateTime?: utcDateTime;

  /**
   * The expiry date of the reservation
   */
  @visibility(Lifecycle.Read)
  expiryDate?: string;

  /**
   * This is the date-time when the reservation will expire.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryDateTime?: utcDateTime;

  /**
   * This is the date-time when the Azure Hybrid Benefit needs to be reviewed.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reviewDateTime?: utcDateTime;

  /**
   * The sku description of the reservation
   */
  @visibility(Lifecycle.Read)
  skuDescription?: string;

  /**
   * The message giving detailed information about the status code.
   */
  extendedStatusInfo?: ReservationExtendedStatusInfo;

  /**
   * The billing plan options available for this sku.
   */
  billingPlan?: ReservationBillingPlan;

  /**
   * The provisioning state of the reservation for display, e.g. Succeeded
   */
  @visibility(Lifecycle.Read)
  displayProvisioningState?: string;

  /**
   * The provisioning state of the reservation, e.g. Succeeded
   */
  @visibility(Lifecycle.Read)
  provisioningSubState?: string;

  /**
   * This is the date when the reservation was purchased.
   */
  purchaseDate?: plainDate;

  /**
   * This is the date-time when the reservation was purchased.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  purchaseDateTime?: utcDateTime;

  /**
   * Properties of reservation split
   */
  splitProperties?: ReservationSplitProperties;

  /**
   * Properties of reservation merge
   */
  mergeProperties?: ReservationMergeProperties;

  /**
   * Properties of reservation swap
   */
  swapProperties?: ReservationSwapProperties;

  /**
   * Properties specific to applied scope type. Not required if not applicable. Required and need to provide tenantId and managementGroupId if AppliedScopeType is ManagementGroup
   */
  appliedScopeProperties?: ReservationAppliedScopeProperties;

  /**
   * Subscription that will be charged for purchasing reservation or savings plan
   */
  @visibility(Lifecycle.Read)
  billingScopeId?: string;

  /**
   * The renew state of the reservation
   */
  @visibility(Lifecycle.Read)
  renew?: boolean;

  /**
   * The renew source of the reservation
   */
  @visibility(Lifecycle.Read)
  renewSource?: string;

  /**
   * Reservation Id of the reservation which is purchased because of renew. Format of the resource Id is /providers/Microsoft.Capacity/reservationOrders/{reservationOrderId}/reservations/{reservationId}.
   */
  renewDestination?: string;

  /**
   * The renew properties for a reservation.
   */
  renewProperties?: RenewPropertiesResponse;

  /**
   * The term of the reservation, e.g. P1Y
   */
  @visibility(Lifecycle.Read)
  term?: string;

  /**
   * The applied scope type of the reservation for display, e.g. Shared
   */
  @visibility(Lifecycle.Read)
  userFriendlyAppliedScopeType?: string;

  /**
   * The renew state of the reservation for display, e.g. On
   */
  @visibility(Lifecycle.Read)
  userFriendlyRenewState?: string;

  /**
   * Reservation utilization
   */
  @visibility(Lifecycle.Read)
  utilization?: ReservationPropertyUtilization;

  /**
   * Represents UPN
   */
  productCode?: string;
}

/**
 * Extended status information for the reservation.
 */
model ReservationExtendedStatusInfo {
  /**
   * The status of the reservation.
   */
  statusCode?: ReservationStatusCode;

  /**
   * The message giving detailed information about the status code.
   */
  message?: string;

  /**
   * Properties for extended status information
   */
  properties?: ExtendedStatusDefinitionProperties;
}

/**
 * Extended status definition properties
 */
model ExtendedStatusDefinitionProperties {
  /**
   * Subscription Id
   */
  subscriptionId?: string;
}

/**
 * Properties of reservation split
 */
model ReservationSplitProperties {
  /**
   * List of destination resource id that are created due to split. Format of the resource id is /providers/Microsoft.Capacity/reservationOrders/{reservationOrderId}/reservations/{reservationId}
   */
  splitDestinations?: string[];

  /**
   * Resource id of the reservation from which this is split. Format of the resource id is /providers/Microsoft.Capacity/reservationOrders/{reservationOrderId}/reservations/{reservationId}
   */
  splitSource?: string;
}

/**
 * Properties of reservation merge
 */
model ReservationMergeProperties {
  /**
   * Reservation resource id Created due to the merge. Format of the resource id is /providers/Microsoft.Capacity/reservationOrders/{reservationOrderId}/reservations/{reservationId}
   */
  mergeDestination?: string;

  /**
   * Resource ids of the source reservation's merged to form this reservation. Format of the resource id is /providers/Microsoft.Capacity/reservationOrders/{reservationOrderId}/reservations/{reservationId}
   */
  mergeSources?: string[];
}

/**
 * Properties of reservation swap
 */
model ReservationSwapProperties {
  /**
   * Resource id of the source reservation that gets swapped. Format of the resource id is /providers/microsoft.capacity/reservationOrders/{reservationOrderId}/reservations/{reservationId}
   */
  swapSource?: string;

  /**
   * Reservation resource id that the original resource gets swapped to. Format of the resource id is /providers/microsoft.capacity/reservationOrders/{reservationOrderId}/reservations/{reservationId}
   */
  swapDestination?: string;
}

/**
 * Properties specific to applied scope type. Not required if not applicable. Required and need to provide tenantId and managementGroupId if AppliedScopeType is ManagementGroup
 */
model ReservationAppliedScopeProperties {
  /**
   * Tenant ID where the reservation should apply benefit.
   */
  tenantId?: string;

  /**
   * Fully-qualified identifier of the management group where the benefit must be applied.
   */
  managementGroupId?: string;

  /**
   * Fully-qualified identifier of the subscription.
   */
  subscriptionId?: string;

  /**
   * Fully-qualified identifier of the resource group.
   */
  resourceGroupId?: string;

  /**
   * Display name
   */
  displayName?: string;
}

/**
 * The renew properties for a reservation.
 */
model RenewPropertiesResponse {
  /**
   * The request for reservation purchase
   */
  purchaseProperties?: ReservationPurchaseRequest;

  /**
   * Amount that Microsoft uses for record. Used during refund for calculating refund limit. Tax is not included. This is locked price 30 days before expiry.
   */
  pricingCurrencyTotal?: Price;

  /**
   * Currency and amount that customer will be charged in customer's local currency for renewal purchase. Tax is not included.
   */
  billingCurrencyTotal?: Price;
}

/**
 * The request for reservation purchase
 */
model ReservationPurchaseRequest {
  /**
   * The name of sku
   */
  sku?: SkuName;

  /**
   * The Azure region where the reserved resource lives.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * Properties of reservation purchase request
   */
  properties?: ReservationPurchaseRequestProperties;
}

/**
 * The name of sku
 */
model SkuName {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  name?: string;
}

/**
 * Properties of reservation purchase request
 */
model ReservationPurchaseRequestProperties {
  /**
   * The reserved source type of the reservation, e.g. virtual machine.
   */
  @visibility(Lifecycle.Read)
  reservedResourceType?: string;

  /**
   * Subscription that will be charged for purchasing reservation or savings plan
   */
  @visibility(Lifecycle.Read)
  billingScopeId?: string;

  /**
   * The term of the reservation, e.g. P1Y
   */
  @visibility(Lifecycle.Read)
  term?: string;

  /**
   * Represent the billing plans.
   */
  billingPlan?: ReservationBillingPlan;

  /**
   * Quantity of the skus that are part of the reservation. Must be greater than zero.
   */
  quantity?: int32;

  /**
   * Friendly name of the reservation
   */
  displayName?: string;

  /**
   * Type of the Applied Scope.
   */
  appliedScopeType?: AppliedScopeType;

  /**
   * List of the subscriptions that the benefit will be applied. Do not specify if AppliedScopeType is Shared.
   */
  appliedScopes?: string[];

  /**
   * Properties specific to applied scope type. Not required if not applicable. Required and need to provide tenantId and managementGroupId if AppliedScopeType is ManagementGroup
   */
  appliedScopeProperties?: ReservationAppliedScopeProperties;

  /**
   * Setting this to true will automatically purchase a new benefit on the expiration date time.
   */
  renew?: boolean;

  /**
   * Properties specific to each reserved resource type. Not required if not applicable.
   */
  reservedResourceProperties?: ReservationPurchaseRequestPropertiesReservedResourceProperties;

  /**
   * Allows reservation discount to be applied across skus within the same auto fit group. Not all skus support instance size flexibility.
   */
  instanceFlexibility?: InstanceFlexibility;

  /**
   * This is the date-time when the Azure hybrid benefit needs to be reviewed.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reviewDateTime?: utcDateTime;
}

/**
 * Properties specific to each reserved resource type. Not required if not applicable.
 */
model ReservationPurchaseRequestPropertiesReservedResourceProperties {
  /**
   * Turning this on will apply the reservation discount to other VMs in the same VM size group. Only specify for VirtualMachines reserved resource type.
   */
  instanceFlexibility?: InstanceFlexibility;
}

/**
 * Reservation utilization
 */
model ReservationPropertyUtilization {
  /**
   * last 7 day utilization trend for a reservation
   */
  @visibility(Lifecycle.Read)
  trend?: string;

  /**
   * The array of aggregates of a reservation's utilization
   */
  @identifiers(#[])
  aggregates?: ReservationUtilizationAggregates[];
}

/**
 * The aggregate values of reservation utilization
 */
model ReservationUtilizationAggregates {
  /**
   * The grain of the aggregate
   */
  @visibility(Lifecycle.Read)
  grain?: float32;

  /**
   * The grain unit of the aggregate
   */
  @visibility(Lifecycle.Read)
  grainUnit?: string;

  /**
   * The aggregate value
   */
  @visibility(Lifecycle.Read)
  value?: float32;

  /**
   * The aggregate value unit
   */
  @visibility(Lifecycle.Read)
  valueUnit?: string;
}

/**
 * The property of reservation sku object.
 */
model ReservationSkuProperty {
  /**
   * The name of the reservation sku.
   */
  @visibility(Lifecycle.Read)
  name?: string;
}

/**
 * The request for reservation patch
 */
model Patch {
  /**
   * Properties for reservation patch
   */
  properties?: PatchProperties;

  /**
   * The sku information associated to this reservation
   */
  sku?: ReservationSkuProperty;

  /**
   * Tags for this reservation
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Properties for reservation patch
 */
model PatchProperties {
  /**
   * Type of the Applied Scope.
   */
  appliedScopeType?: AppliedScopeType;

  /**
   * Properties specific to applied scope type. Not required if not applicable. Required and need to provide tenantId and managementGroupId if AppliedScopeType is ManagementGroup
   */
  appliedScopeProperties?: ReservationAppliedScopeProperties;

  /**
   * Turning this on will apply the reservation discount to other VMs in the same VM size group. Only specify for VirtualMachines reserved resource type.
   */
  instanceFlexibility?: InstanceFlexibility;

  /**
   * Display name of the reservation
   */
  displayName?: string;

  /**
   * Setting this to true will automatically purchase a new benefit on the expiration date time.
   */
  renew?: boolean;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  renewProperties?: PatchPropertiesRenewProperties;

  /**
   * This is the date-time when the Azure hybrid benefit needs to be reviewed.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reviewDateTime?: utcDateTime;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PatchPropertiesRenewProperties {
  /**
   * The request for reservation purchase
   */
  purchaseProperties?: ReservationPurchaseRequest;
}

/**
 * List of `Reservations`
 */
model ReservationList is Azure.Core.Page<Reservation>;

/**
 * Properties of a reservation order.
 */
model ReservationOrderProperty {
  /**
   * Friendly name for user to easily identified the reservation order.
   */
  displayName?: string;

  /**
   * Enrollment id of the reservation order.
   */
  enrollmentId?: string;

  /**
   * Fully-qualified identifier of the customerId where the benefit is applied. Present only for Enterprise Agreement PartnerLed customers.
   */
  customerId?: string;

  /**
   * Billing profile Id associated to this reservation order.
   */
  billingProfileId?: string;

  /**
   * Billing account Id associated to this reservation order.
   */
  billingAccountId?: string;

  /**
   * This is the DateTime when the reservation order was initially requested for purchase.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  requestDateTime?: utcDateTime;

  /**
   * This is the DateTime when the reservation order was created.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDateTime?: utcDateTime;

  /**
   * This is the date when the reservation order will expire.
   */
  expiryDate?: plainDate;

  /**
   * This is the date-time when the reservation order will expire.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryDateTime?: utcDateTime;

  /**
   * This is the DateTime when the reservation benefit started.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  benefitStartTime?: utcDateTime;

  /**
   * Total original quantity of the skus purchased in the reservation order.
   */
  originalQuantity?: int32;

  /**
   * The term of the reservation, e.g. P1Y
   */
  @visibility(Lifecycle.Read)
  term?: string;

  /**
   * The provisioning state of the reservation, e.g. Succeeded
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Represent the billing plans.
   */
  billingPlan?: ReservationBillingPlan;

  /**
   * Information describing the type of billing plan for this reservation order.
   */
  planInformation?: ReservationOrderBillingPlanInformation;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  reservations?: Reservation[];

  /**
   * This is the date-time when the Azure Hybrid Benefit needs to be reviewed.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reviewDateTime?: utcDateTime;

  /**
   * Extended status information for the reservation.
   */
  extendedStatusInfo?: ReservationExtendedStatusInfo;

  /**
   * Represents UPN
   */
  productCode?: string;
}

/**
 * Information describing the type of billing plan for this reservation order.
 */
model ReservationOrderBillingPlanInformation {
  /**
   * Amount of money to be paid for the Order. Tax is not included.
   */
  pricingCurrencyTotal?: Price;

  /**
   * Date when the billing plan has started.
   */
  startDate?: plainDate;

  /**
   * For recurring billing plans, indicates the date when next payment will be processed. Null when total is paid off.
   */
  nextPaymentDueDate?: plainDate;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  transactions?: ReservationPaymentDetail[];
}

/**
 * Information about payment related to a reservation order.
 */
model ReservationPaymentDetail {
  /**
   * Date when the payment needs to be done.
   */
  dueDate?: plainDate;

  /**
   * Date when the transaction is completed. Is null when it is scheduled.
   */
  paymentDate?: plainDate;

  /**
   * Amount in pricing currency. Tax not included.
   */
  pricingCurrencyTotal?: Price;

  /**
   * Amount charged in Billing currency. Tax not included. Is null for future payments
   */
  billingCurrencyTotal?: Price;

  /**
   * Shows the Account that is charged for this payment.
   */
  billingAccount?: string;

  /**
   * Describes whether the payment is completed, failed, pending, cancelled or scheduled in the future.
   */
  status?: PaymentStatus;

  /**
   * Extended status information for the reservation.
   */
  extendedStatusInfo?: ReservationExtendedStatusInfo;
}

/**
 * A transaction.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model Transaction extends ProxyResourceWithTags {
  /**
   * A transaction.
   */
  properties?: TransactionProperties;
}

/**
 * A transaction.
 */
model TransactionProperties {
  /**
   * The amount of any Azure credits automatically applied to this transaction.
   */
  azureCreditApplied?: TransactionPropertiesAzureCreditApplied;

  /**
   * Details of the Azure plan.
   */
  azurePlan?: string;

  /**
   * The ISO 4217 code for the currency in which this transaction is billed.
   */
  billingCurrency?: string;

  /**
   * The name of the billing profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  billingProfileDisplayName?: unknown;

  /**
   * The fully qualified ID that uniquely identifies a billing profile.
   */
  billingProfileId?: string;

  /**
   * The amount of Microsoft Azure Consumption Commitment(MACC) decrement through the transaction.
   */
  consumptionCommitmentDecremented?: TransactionPropertiesConsumptionCommitmentDecremented;

  /**
   * The name of the customer.
   */
  customerDisplayName?: string;

  /**
   * The fully qualified ID that uniquely identifies a customer.
   */
  customerId?: string;

  /**
   * The credit type of the transaction. Applies only to credited transactions.
   */
  creditType?: CreditType;

  /**
   * The date of transaction.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  date?: utcDateTime;

  /**
   * The percentage discount, if any, applied to this transaction.
   */
  discount?: float32;

  /**
   * The price of the product after applying any discounts.
   */
  effectivePrice?: TransactionPropertiesEffectivePrice;

  /**
   * The exchange rate used to convert charged amount to billing currency, if applicable.
   */
  exchangeRate?: float32;

  /**
   * Invoice name on which the transaction was billed or 'Pending' if the transaction is not billed.
   */
  invoice?: string;

  /**
   * The fully qualified ID of the invoice on which the transaction was billed. This field is only applicable for transactions which are billed.
   */
  invoiceId?: string;

  /**
   * The name of the invoice section.
   */
  invoiceSectionDisplayName?: string;

  /**
   * The fully qualified ID that uniquely identifies an invoice section.
   */
  invoiceSectionId?: string;

  /**
   * Whether or not the transaction is third party.
   */
  isThirdParty?: boolean;

  /**
   * Type of the transaction, billed or unbilled.
   */
  kind?: TransactionKind;

  /**
   * The retail price of the product.
   */
  marketPrice?: TransactionPropertiesMarketPrice;

  /**
   * The part number of the product for which the transaction took place. The field is only applicable for Enterprise Agreement invoices.
   */
  partNumber?: string;

  /**
   * The ISO 4217 code for the currency in which the product is priced.
   */
  pricingCurrency?: string;

  /**
   * The description of the product for which the transaction took place.
   */
  productDescription?: string;

  /**
   * The family of the product for which the transaction took place.
   */
  productFamily?: string;

  /**
   * The ID of the product type for which the transaction took place.
   */
  productTypeId?: string;

  /**
   * The type of the product for which the transaction took place.
   */
  productType?: string;

  /**
   * The quantity purchased in the transaction.
   */
  quantity?: int32;

  /**
   * There reason code for the transaction.
   */
  reasonCode?: string;

  /**
   * The date of the purchase of the product, or the start date of the month in which usage started.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  servicePeriodStartDate?: utcDateTime;

  /**
   * The end date of the product term, or the end date of the month in which usage ended.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  servicePeriodEndDate?: utcDateTime;

  /**
   * The pre-tax charged amount for the transaction.
   */
  subTotal?: TransactionPropertiesSubTotal;

  /**
   * The tax amount applied to the transaction.
   */
  tax?: TransactionPropertiesTax;

  /**
   * The charge associated with the transaction.
   */
  transactionAmount?: TransactionPropertiesTransactionAmount;

  /**
   * The type of transaction.
   */
  transactionType?: string;

  /**
   * The number of units used for a given product.
   */
  units?: float32;

  /**
   * The unit of measure used to bill for the product. For example, compute services are billed per hour.
   */
  unitOfMeasure?: string;

  /**
   * The description for the unit of measure for a given product.
   */
  unitType?: string;

  /**
   * Identifies the type of tax calculation used for the invoice. The field is applicable only to invoices with special tax calculation logic.
   */
  specialTaxationType?: SpecialTaxationType;

  /**
   * The refund details of a transaction.
   */
  refundTransactionDetails?: TransactionPropertiesRefundTransactionDetails;
}

/**
 * The amount of any Azure credits automatically applied to this transaction.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TransactionPropertiesAzureCreditApplied extends Amount {}

/**
 * The amount of Microsoft Azure Consumption Commitment(MACC) decrement through the transaction.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TransactionPropertiesConsumptionCommitmentDecremented extends Amount {}

/**
 * The price of the product after applying any discounts.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TransactionPropertiesEffectivePrice extends Amount {}

/**
 * The retail price of the product.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TransactionPropertiesMarketPrice extends Amount {}

/**
 * The pre-tax charged amount for the transaction.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TransactionPropertiesSubTotal extends Amount {}

/**
 * The tax amount applied to the transaction.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TransactionPropertiesTax extends Amount {}

/**
 * The charge associated with the transaction.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TransactionPropertiesTransactionAmount extends Amount {}

/**
 * The refund details of a transaction.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TransactionPropertiesRefundTransactionDetails
  extends RefundTransactionDetails {}

/**
 * The refund details of a transaction.
 */
model RefundTransactionDetails {
  /**
   * The amount of refund requested.
   */
  amountRequested?: RefundTransactionDetailsAmountRequested;

  /**
   * The amount refunded.
   */
  amountRefunded?: RefundTransactionDetailsAmountRefunded;

  /**
   * The ID of refund operation.
   */
  refundOperationId?: string;
}

/**
 * The amount of refund requested.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RefundTransactionDetailsAmountRequested extends Amount {}

/**
 * The amount refunded.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RefundTransactionDetailsAmountRefunded extends Amount {}

/**
 * A transaction summary.
 */
model TransactionSummary {
  /**
   * The total amount of any Azure credits applied.
   */
  @visibility(Lifecycle.Read)
  azureCreditApplied?: float32;

  /**
   * The ISO 4217 code for the currency in which the transactions are billed.
   */
  @visibility(Lifecycle.Read)
  billingCurrency?: string;

  /**
   * The total Microsoft Azure Consumption Commitment (MACC) decrement through the invoice.
   */
  @visibility(Lifecycle.Read)
  consumptionCommitmentDecremented?: float32;

  /**
   * The total pre-tax charged amount.
   */
  @visibility(Lifecycle.Read)
  subTotal?: float32;

  /**
   * The total tax amount applied.
   */
  @visibility(Lifecycle.Read)
  tax?: float32;

  /**
   * The total charges.
   */
  @visibility(Lifecycle.Read)
  total?: float32;
}

/**
 * Transfer details
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TransferProperties {
  /**
   * The time at which the transfer request expires.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTime?: utcDateTime;

  /**
   * Overall transfer status.
   */
  @visibility(Lifecycle.Read)
  transferStatus?: TransferStatus;

  /**
   * The email ID of the user to whom the transfer request was sent.
   */
  @visibility(Lifecycle.Read)
  recipientEmailId?: string;

  /**
   * The email ID of the user who sent the transfer request.
   */
  @visibility(Lifecycle.Read)
  initiatorEmailId?: string;

  /**
   * The email ID of the user who canceled the transfer request.
   */
  @visibility(Lifecycle.Read)
  canceledBy?: string;

  /**
   * Detailed transfer status.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  detailedTransferStatus?: DetailedTransferStatus[];
}

/**
 * Detailed transfer status.
 */
model DetailedTransferStatus {
  /**
   * Type of product that is transferred.
   */
  @visibility(Lifecycle.Read)
  productType?: ProductType;

  /**
   * The ID of the product that is transferred.
   */
  @visibility(Lifecycle.Read)
  productId?: string;

  /**
   * The name of the product that is transferred.
   */
  @visibility(Lifecycle.Read)
  productName?: string;

  /**
   * The SKU of the product that is transferred.
   */
  @visibility(Lifecycle.Read)
  skuDescription?: string;

  /**
   * Transfer status.
   */
  @visibility(Lifecycle.Read)
  transferStatus?: ProductTransferStatus;

  /**
   * Error details for transfer execution.
   */
  errorDetails?: TransferError;
}

/**
 * Error details for transfer execution.
 */
model TransferError {
  /**
   * Error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Error message.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * Request parameters to initiate transfer.
 */
model InitiateTransferRequest {
  /**
   * Request parameters to initiate transfer.
   */
  properties?: InitiateTransferProperties;
}

/**
 * Request parameters to initiate transfer.
 */
model InitiateTransferProperties {
  /**
   * The email ID of the recipient to whom the transfer request is sent.
   */
  recipientEmailId?: string;
}

/**
 * Transfer Details.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PartnerTransferProperties {
  /**
   * The time at which the transfer request expires.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTime?: utcDateTime;

  /**
   * Overall transfer status.
   */
  @visibility(Lifecycle.Read)
  transferStatus?: TransferStatus;

  /**
   * The email ID of the user to whom the transfer request was sent.
   */
  @visibility(Lifecycle.Read)
  recipientEmailId?: string;

  /**
   * The type of customer who sent the transfer request.
   */
  @visibility(Lifecycle.Read)
  initiatorCustomerType?: InitiatorCustomerType;

  /**
   * The email ID of the user who sent the transfer request.
   */
  @visibility(Lifecycle.Read)
  initiatorEmailId?: string;

  /**
   * Optional MPN ID of the reseller for transfer requests that are sent from a Microsoft Partner Agreement billing account.
   */
  @visibility(Lifecycle.Read)
  resellerId?: string;

  /**
   * Optional name of the reseller for transfer requests that are sent from Microsoft Partner Agreement billing account.
   */
  @visibility(Lifecycle.Read)
  resellerName?: string;

  /**
   * The email ID of the user who canceled the transfer request.
   */
  @visibility(Lifecycle.Read)
  canceledBy?: string;

  /**
   * Detailed transfer status.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  detailedTransferStatus?: DetailedTransferStatus[];
}

/**
 * Request parameters to initiate partner transfer.
 */
model PartnerInitiateTransferRequest {
  /**
   * Request parameters to initiate partner transfer.
   */
  properties?: PartnerInitiateTransferProperties;
}

/**
 * Request parameters to initiate transfer.
 */
model PartnerInitiateTransferProperties {
  /**
   * The email ID of the recipient to whom the transfer request is sent.
   */
  recipientEmailId?: string;

  /**
   * Optional MPN ID of the reseller for transfer requests that are sent from a Microsoft Partner Agreement billing account.
   */
  resellerId?: string;
}

/**
 * Request parameters to accept transfer.
 */
model AcceptTransferRequest {
  /**
   * Request parameters to accept transfer.
   */
  properties?: AcceptTransferProperties;
}

/**
 * Request parameters to accept transfer.
 */
model AcceptTransferProperties {
  /**
   * Request parameters to accept transfer.
   */
  @identifiers(#[])
  productDetails?: ProductDetails[];
}

/**
 * Details of the product that is transferred.
 */
model ProductDetails {
  /**
   * Type of the product that is transferred.
   */
  productType?: ProductType;

  /**
   * The ID of the product that is transferred.
   */
  productId?: string;
}

/**
 * Transfer Details.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RecipientTransferProperties {
  /**
   * The time at which the transfer request expires.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTime?: utcDateTime;

  /**
   * Type of subscriptions that can be transferred.
   */
  @visibility(Lifecycle.Read)
  allowedProductType?: EligibleProductType[];

  /**
   * Overall transfer status.
   */
  @visibility(Lifecycle.Read)
  transferStatus?: TransferStatus;

  /**
   * The email ID of the user to whom the transfer request was sent.
   */
  @visibility(Lifecycle.Read)
  recipientEmailId?: string;

  /**
   * The email ID of the user who sent the transfer request.
   */
  @visibility(Lifecycle.Read)
  initiatorEmailId?: string;

  /**
   * Optional MPN ID of the reseller for transfer requests that are sent from a Microsoft Partner Agreement billing account.
   */
  @visibility(Lifecycle.Read)
  resellerId?: string;

  /**
   * Optional name of the reseller for transfer requests that are sent from Microsoft Partner Agreement billing account.
   */
  @visibility(Lifecycle.Read)
  resellerName?: string;

  /**
   * The type of customer who sent the transfer request.
   */
  @visibility(Lifecycle.Read)
  initiatorCustomerType?: InitiatorCustomerType;

  /**
   * The email ID of the user who canceled the transfer request.
   */
  @visibility(Lifecycle.Read)
  canceledBy?: string;

  /**
   * Detailed transfer status.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  detailedTransferStatus?: DetailedTransferStatus[];

  /**
   * The customer tenant id.
   */
  @visibility(Lifecycle.Read)
  customerTenantId?: string;

  /**
   * List of supported account types.
   */
  @visibility(Lifecycle.Read)
  supportedAccounts?: SupportedAccountType[];
}

/**
 * Result of transfer validation.
 */
model ValidateTransferListResponse {
  /**
   * The list of transfer validation results.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  @identifiers(#[])
  value?: ValidateTransferResponse[];
}

/**
 * Transfer validation response.
 */
model ValidateTransferResponse {
  /**
   * The properties of transfer validation response.
   */
  properties?: ValidateTransferResponseProperties;
}

/**
 * The properties of transfer validation response.
 */
model ValidateTransferResponseProperties {
  /**
   * The status of validation
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * The product id for which this result applies.
   */
  @visibility(Lifecycle.Read)
  productId?: string;

  /**
   * The array of validation results.
   */
  @identifiers(#[])
  results?: ValidationResultProperties[];
}

/**
 * The properties of the validation result.
 */
model ValidationResultProperties {
  /**
   * Result Level.
   */
  @visibility(Lifecycle.Read)
  level?: string;

  /**
   * Result Code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * The validation message.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * The roll up count summary of savings plans in each state
 */
model SavingsPlanSummaryCount {
  /**
   * The number of savings plans in Succeeded state
   */
  @visibility(Lifecycle.Read)
  succeededCount?: float32;

  /**
   * The number of savings plans in Failed state
   */
  @visibility(Lifecycle.Read)
  failedCount?: float32;

  /**
   * The number of savings plans in Expiring state
   */
  @visibility(Lifecycle.Read)
  expiringCount?: float32;

  /**
   * The number of savings plans in Expired state
   */
  @visibility(Lifecycle.Read)
  expiredCount?: float32;

  /**
   * The number of savings plans in Pending state
   */
  @visibility(Lifecycle.Read)
  pendingCount?: float32;

  /**
   * The number of savings plans in Cancelled state
   */
  @visibility(Lifecycle.Read)
  cancelledCount?: float32;

  /**
   * The number of savings plans in Processing state
   */
  @visibility(Lifecycle.Read)
  processingCount?: float32;

  /**
   * The number of savings plans in No Benefit state
   */
  @visibility(Lifecycle.Read)
  noBenefitCount?: float32;

  /**
   * The number of savings plans in Warning state
   */
  @visibility(Lifecycle.Read)
  warningCount?: float32;
}

/**
 * An external reference.
 */
model ExternalReference {
  /**
   * The ID that uniquely identifies an external reference.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The URL of the external reference.
   */
  @visibility(Lifecycle.Read)
  url?: string;
}

/**
 * List of ReservationOrders
 */
model ReservationOrderList is Azure.Core.Page<ReservationOrder>;

/**
 * Query parameter to enumerate transfer requests.
 */
model TransferItemQueryParameter {
  /**
   * State of the transfer request query filter.
   */
  state?: string;
}

/**
 * The response of a PaymentMethodLink list operation.
 */
model PaymentMethodLinksListResult is Azure.Core.Page<PaymentMethodLink>;

/**
 * The response of a PaymentMethod list operation.
 */
model PaymentMethodsListResult is Azure.Core.Page<PaymentMethod>;

/**
 * The list of reservations and summary of roll out count of reservations in each state.
 */
model ReservationsListResult is Azure.Core.Page<Reservation> {
  /**
   * The roll out count summary of the reservations
   */
  summary?: ReservationSummary;
}

/**
 * The response of a BillingSubscription list operation.
 */
model BillingSubscriptionListResult is Azure.Core.Page<BillingSubscription> {
  /**
   * Total number of records.
   */
  @visibility(Lifecycle.Read)
  totalCount?: float32;
}
