import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.Billing;

const BillingAccountNamePattern = string("^([0-9]+|([Pp][Cc][Nn]\\.[A-Za-z0-9]+)|[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}(:[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}_[0-9]{4}(-[0-9]{2}){2})?)$");
const BillingProfileCustomerInvoiceSectionNamePattern = string("^[a-zA-Z\\d-_]{1,128}$");
const BillingRoleAssignmentPattern = string("^[a-fA-F0-9]{8}[-]?([a-fA-F0-9]{4}[-]?){3}[a-fA-F0-9]{12}(_[a-fA-F0-9]{8}[-]?([a-fA-F0-9]{4}[-]?){3}[a-fA-F0-9]{12})?$");
const InvoicePattern = string("^(H[0-9]-[A-Z0-9]+)$|^(?:([GHT]|HT){1}[A-Z0-9]{9})$|^(?:[D]{1}[A-Z0-9]{9})$|^(?:E{1}[B-Z0-9]{1}[A-Z0-9]{8})$|^(?:EA[A-Z0-9]{8})$");
const AgreementNamePattern = string("^[a-fA-F0-9]{1,12}$");
const GuidPattern = string("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$");
const LowerAlphaNumericPattern = string("^[a-z0-9]*$");
const PaymentMethodPattern = string("^[A-Za-z0-9:_+\\-]{1,128}$");
const PoNumberPattern = string("^[A-Za-z0-9._\\-]{1,64}$");
const PoMappingPattern = string("^[A-Za-z0-9._\\-]{1,128}$");
const AlertPattern = string("^[a-z][a-z0-9]*$");
const LicenseReservationPattern = string("[a-zA-Z\\d-_]+");
const EmailAddressPattern = string("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$");

/**
 * The mode of acceptance for an agreement.
 */
union AcceptanceMode {
  string,

  /**
   * The Other option for the acceptance mode.
   */
  Other: "Other",

  /**
   * The ClickToAccept option for the acceptance mode.
   */
  ClickToAccept: "ClickToAccept",

  /**
   * The ESignEmbedded option for the acceptance mode.
   */
  ESignEmbedded: "ESignEmbedded",

  /**
   * The ESignOffline option for the acceptance mode.
   */
  ESignOffline: "ESignOffline",

  /**
   * The Implicit option for the acceptance mode.
   */
  Implicit: "Implicit",

  /**
   * The Offline option for the acceptance mode.
   */
  Offline: "Offline",

  /**
   * The PhysicalSign option for the acceptance mode.
   */
  PhysicalSign: "PhysicalSign",
}

/**
 * The category of the agreement.
 */
union Category {
  string,

  /**
   * The Other option for the category.
   */
  Other: "Other",

  /**
   * The AffiliatePurchaseTerms option for the category.
   */
  AffiliatePurchaseTerms: "AffiliatePurchaseTerms",

  /**
   * The IndirectForGovernmentAgreement option for the category.
   */
  IndirectForGovernmentAgreement: "IndirectForGovernmentAgreement",

  /**
   * The MicrosoftCustomerAgreement option for the category.
   */
  MicrosoftCustomerAgreement: "MicrosoftCustomerAgreement",

  /**
   * The MicrosoftPartnerAgreement option for the category.
   */
  MicrosoftPartnerAgreement: "MicrosoftPartnerAgreement",

  /**
   * The UKCloudComputeFramework option for the category.
   */
  UKCloudComputeFramework: "UKCloudComputeFramework",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * The User option for the created by type.
   */
  User: "User",

  /**
   * The Application option for the created by type.
   */
  Application: "Application",

  /**
   * The ManagedIdentity option for the created by type.
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * The Key option for the created by type.
   */
  Key: "Key",
}

/**
 * The provisioning state of the resource during a long-running operation.
 */
@Azure.Core.lroStatus
union ProvisioningState {
  string,

  /**
   * The Succeeded option for the provisioning state.
   */
  Succeeded: "Succeeded",

  /**
   * The Canceled option for the provisioning state.
   */
  Canceled: "Canceled",

  /**
   * The Failed option for the provisioning state.
   */
  Failed: "Failed",

  /**
   * The New option for the provisioning state.
   */
  New: "New",

  /**
   * The Pending option for the provisioning state.
   */
  Pending: "Pending",

  /**
   * The Provisioning option for the provisioning state.
   */
  Provisioning: "Provisioning",

  /**
   * The PendingBilling option for the provisioning state.
   */
  PendingBilling: "PendingBilling",

  /**
   * The ConfirmedBilling option for the provisioning state.
   */
  ConfirmedBilling: "ConfirmedBilling",

  /**
   * The Creating option for the provisioning state.
   */
  Creating: "Creating",

  /**
   * The Created option for the provisioning state.
   */
  Created: "Created",

  /**
   * The Expired option for the provisioning state.
   */
  Expired: "Expired",
}

/**
 * The state determines whether users from the associated tenant can be assigned roles for commerce activities like viewing and downloading invoices, managing payments, and making purchases.
 */
union BillingManagementTenantState {
  string,

  /**
   * The Other option for the billing management tenant state.
   */
  Other: "Other",

  /**
   * The NotAllowed option for the billing management tenant state.
   */
  NotAllowed: "NotAllowed",

  /**
   * The Active option for the billing management tenant state.
   */
  Active: "Active",

  /**
   * The Revoked option for the billing management tenant state.
   */
  Revoked: "Revoked",
}

/**
 * The state determines whether subscriptions and licenses can be provisioned in the associated tenant. It can be set to 'Pending' to initiate a billing request.
 */
union ProvisioningTenantState {
  string,

  /**
   * The Other option for the provisioning tenant state.
   */
  Other: "Other",

  /**
   * The NotRequested option for the provisioning tenant state.
   */
  NotRequested: "NotRequested",

  /**
   * The Active option for the provisioning tenant state.
   */
  Active: "Active",

  /**
   * The Pending option for the provisioning tenant state.
   */
  Pending: "Pending",

  /**
   * The BillingRequestExpired option for the provisioning tenant state.
   */
  BillingRequestExpired: "BillingRequestExpired",

  /**
   * The BillingRequestDeclined option for the provisioning tenant state.
   */
  BillingRequestDeclined: "BillingRequestDeclined",

  /**
   * The Revoked option for the provisioning tenant state.
   */
  Revoked: "Revoked",
}

/**
 * Payment on Account type.
 */
union PaymentMethodFamily {
  string,

  /**
   * The Other option for the payment method family.
   */
  Other: "Other",

  /**
   * The None option for the payment method family.
   */
  None: "None",

  /**
   * The CreditCard option for the payment method family.
   */
  CreditCard: "CreditCard",

  /**
   * The Credits option for the payment method family.
   */
  Credits: "Credits",

  /**
   * The CheckWire option for the payment method family.
   */
  CheckWire: "CheckWire",

  /**
   * The EWallet option for the payment method family.
   */
  EWallet: "EWallet",

  /**
   * The TaskOrder option for the payment method family.
   */
  TaskOrder: "TaskOrder",

  /**
   * The DirectDebit option for the payment method family.
   */
  DirectDebit: "DirectDebit",

  /**
   * The RealTimePayments option for the payment method family.
   */
  @added(Versions.v2024_08_01_preview)
  RealTimePayments: "RealTimePayments",

  /**
   * The Virtual option for the payment method family.
   */
  @added(Versions.v2024_08_01_preview)
  Virtual: "Virtual",

  /**
   * The Sandbox option for the payment method family.
   */
  @added(Versions.v2024_08_01_preview)
  Sandbox: "Sandbox",
}

/**
 * The current status of the billing account.
 */
union AccountStatus {
  string,

  /**
   * The Other option for the account status.
   */
  Other: "Other",

  /**
   * The Active option for the account status.
   */
  Active: "Active",

  /**
   * The UnderReview option for the account status.
   */
  UnderReview: "UnderReview",

  /**
   * The Disabled option for the account status.
   */
  Disabled: "Disabled",

  /**
   * The Deleted option for the account status.
   */
  Deleted: "Deleted",

  /**
   * The Extended option for the account status.
   */
  Extended: "Extended",

  /**
   * The Pending option for the account status.
   */
  Pending: "Pending",

  /**
   * The New option for the account status.
   */
  New: "New",

  /**
   * The Expired option for the account status.
   */
  Expired: "Expired",

  /**
   * The Terminated option for the account status.
   */
  Terminated: "Terminated",

  /**
   * The Transferred option for the account status.
   */
  Transferred: "Transferred",
}

/**
 * The type of customer.
 */
union AccountType {
  string,

  /**
   * The Other option for the account type.
   */
  Other: "Other",

  /**
   * The Enterprise option for the account type.
   */
  Enterprise: "Enterprise",

  /**
   * The Individual option for the account type.
   */
  Individual: "Individual",

  /**
   * The Partner option for the account type.
   */
  Partner: "Partner",

  /**
   * The Reseller option for the account type.
   */
  Reseller: "Reseller",

  /**
   * The ClassicPartner option for the account type.
   */
  ClassicPartner: "ClassicPartner",

  /**
   * The Internal option for the account type.
   */
  Internal: "Internal",

  /**
   * The Tenant option for the account type.
   */
  Tenant: "Tenant",

  /**
   * The Business option for the account type.
   */
  Business: "Business",
}

/**
 * The tier of the account.
 */
union AccountSubType {
  string,

  /**
   * The Other option for the account sub type.
   */
  Other: "Other",

  /**
   * The None option for the account sub type.
   */
  None: "None",

  /**
   * The Individual option for the account sub type.
   */
  Individual: "Individual",

  /**
   * The Professional option for the account sub type.
   */
  Professional: "Professional",

  /**
   * The Enterprise option for the account sub type.
   */
  Enterprise: "Enterprise",
}

/**
 * Reason for the specified billing account status.
 */
union BillingAccountStatusReasonCode {
  string,

  /**
   * The Other option for the billing account status reason code.
   */
  Other: "Other",

  /**
   * The UnusualActivity option for the billing account status reason code.
   */
  UnusualActivity: "UnusualActivity",

  /**
   * The ManuallyTerminated option for the billing account status reason code.
   */
  ManuallyTerminated: "ManuallyTerminated",

  /**
   * The Expired option for the billing account status reason code.
   */
  Expired: "Expired",

  /**
   * The Transferred option for the billing account status reason code.
   */
  Transferred: "Transferred",

  /**
   * The TerminateProcessing option for the billing account status reason code.
   */
  TerminateProcessing: "TerminateProcessing",
}

/**
 * The type of agreement.
 */
union AgreementType {
  string,

  /**
   * The Other option for the agreement type.
   */
  Other: "Other",

  /**
   * The MicrosoftCustomerAgreement option for the agreement type.
   */
  MicrosoftCustomerAgreement: "MicrosoftCustomerAgreement",

  /**
   * The EnterpriseAgreement option for the agreement type.
   */
  EnterpriseAgreement: "EnterpriseAgreement",

  /**
   * The MicrosoftOnlineServicesProgram option for the agreement type.
   */
  MicrosoftOnlineServicesProgram: "MicrosoftOnlineServicesProgram",

  /**
   * The MicrosoftPartnerAgreement option for the agreement type.
   */
  MicrosoftPartnerAgreement: "MicrosoftPartnerAgreement",
}

/**
 * The billing account extension opted by the company.
 */
union ExtendedTermOption {
  string,

  /**
   * The Other option for the extended term option.
   */
  Other: "Other",

  /**
   * Indicates that the extended term option is enabled.
   */
  `Opted-In`: "Opted-In",

  /**
   * Indicates that the extended term option is disabled.
   */
  `Opted-Out`: "Opted-Out",
}

/**
 * The support level offer associated with an enrollment.
 */
union SupportLevel {
  string,

  /**
   * The Other option for the support level.
   */
  Other: "Other",

  /**
   * The Standard option for the support level.
   */
  Standard: "Standard",

  /**
   * Indicates the Pro-Direct support offer.
   */
  `Pro-Direct`: "Pro-Direct",

  /**
   * The Developer option for the support level.
   */
  Developer: "Developer",
}

/**
 * Markup status of enrollment, applicable only for indirect enrollments.
 */
union MarkupStatus {
  string,

  /**
   * The Other option for the markup status.
   */
  Other: "Other",

  /**
   * The Disabled option for the markup status.
   */
  Disabled: "Disabled",

  /**
   * The Preview option for the markup status.
   */
  Preview: "Preview",

  /**
   * The Published option for the markup status.
   */
  Published: "Published",

  /**
   * The Locked option for the markup status.
   */
  Locked: "Locked",
}

/**
 * Identifies the billing relationships represented by a billing account or billing profile. The billing relationship may be between Microsoft, the customer, and/or a third-party.
 */
union BillingRelationshipType {
  string,

  /**
   * The Other option for the billing relationship type.
   */
  Other: "Other",

  /**
   * The Direct option for the billing relationship type.
   */
  Direct: "Direct",

  /**
   * The IndirectCustomer option for the billing relationship type.
   */
  IndirectCustomer: "IndirectCustomer",

  /**
   * The IndirectPartner option for the billing relationship type.
   */
  IndirectPartner: "IndirectPartner",

  /**
   * The CSPPartner option for the billing relationship type.
   */
  CSPPartner: "CSPPartner",

  /**
   * The CSPCustomer option for the billing relationship type.
   */
  CSPCustomer: "CSPCustomer",
}

/**
 * The type of the tax identifier.
 */
union TaxIdentifierType {
  string,

  /**
   * The Other option for the tax identifier type.
   */
  Other: "Other",

  /**
   * The BrazilCcmId option for the tax identifier type.
   */
  BrazilCcmId: "BrazilCcmId",

  /**
   * The BrazilCnpjId option for the tax identifier type.
   */
  BrazilCnpjId: "BrazilCnpjId",

  /**
   * The BrazilCpfId option for the tax identifier type.
   */
  BrazilCpfId: "BrazilCpfId",

  /**
   * The CanadianFederalExempt option for the tax identifier type.
   */
  CanadianFederalExempt: "CanadianFederalExempt",

  /**
   * The CanadianProvinceExempt option for the tax identifier type.
   */
  CanadianProvinceExempt: "CanadianProvinceExempt",

  /**
   * The ExternalTaxation option for the tax identifier type.
   */
  ExternalTaxation: "ExternalTaxation",

  /**
   * The IndiaFederalTanId option for the tax identifier type.
   */
  IndiaFederalTanId: "IndiaFederalTanId",

  /**
   * The IndiaFederalServiceTaxId option for the tax identifier type.
   */
  IndiaFederalServiceTaxId: "IndiaFederalServiceTaxId",

  /**
   * The IndiaPanId option for the tax identifier type.
   */
  IndiaPanId: "IndiaPanId",

  /**
   * The IndiaStateCstId option for the tax identifier type.
   */
  IndiaStateCstId: "IndiaStateCstId",

  /**
   * The IndiaStateGstINId option for the tax identifier type.
   */
  IndiaStateGstINId: "IndiaStateGstINId",

  /**
   * The IndiaStateVatId option for the tax identifier type.
   */
  IndiaStateVatId: "IndiaStateVatId",

  /**
   * The IntlExempt option for the tax identifier type.
   */
  IntlExempt: "IntlExempt",

  /**
   * The USExempt option for the tax identifier type.
   */
  USExempt: "USExempt",

  /**
   * The VatId option for the tax identifier type.
   */
  VatId: "VatId",

  /**
   * The LoveCode option for the tax identifier type.
   */
  LoveCode: "LoveCode",

  /**
   * The MobileBarCode option for the tax identifier type.
   */
  MobileBarCode: "MobileBarCode",

  /**
   * The NationalIdentificationNumber option for the tax identifier type.
   */
  NationalIdentificationNumber: "NationalIdentificationNumber",

  /**
   * The PublicSectorId option for the tax identifier type.
   */
  PublicSectorId: "PublicSectorId",
}

/**
 * The status of the tax identifier.
 */
union TaxIdentifierStatus {
  string,

  /**
   * The Other option for the tax identifier status.
   */
  Other: "Other",

  /**
   * The Valid option for the tax identifier status.
   */
  Valid: "Valid",

  /**
   * The Invalid option for the tax identifier status.
   */
  Invalid: "Invalid",
}

/**
 * The status of the billing profile.
 */
union BillingProfileStatus {
  string,

  /**
   * The Other option for the billing profile status.
   */
  Other: "Other",

  /**
   * The Active option for the billing profile status.
   */
  Active: "Active",

  /**
   * The Disabled option for the billing profile status.
   */
  Disabled: "Disabled",

  /**
   * The Warned option for the billing profile status.
   */
  Warned: "Warned",

  /**
   * The Deleted option for the billing profile status.
   */
  Deleted: "Deleted",

  /**
   * The UnderReview option for the billing profile status.
   */
  UnderReview: "UnderReview",
}

/**
 * Reason for the specified billing profile status.
 */
union BillingProfileStatusReasonCode {
  string,

  /**
   * The Other option for the billing profile status reason code.
   */
  Other: "Other",

  /**
   * The PastDue option for the billing profile status reason code.
   */
  PastDue: "PastDue",

  /**
   * The UnusualActivity option for the billing profile status reason code.
   */
  UnusualActivity: "UnusualActivity",

  /**
   * The SpendingLimitReached option for the billing profile status reason code.
   */
  SpendingLimitReached: "SpendingLimitReached",

  /**
   * The SpendingLimitExpired option for the billing profile status reason code.
   */
  SpendingLimitExpired: "SpendingLimitExpired",
}

/**
 * The billing profile spending limit.
 */
union SpendingLimit {
  string,

  /**
   * The Off option for the spending limit.
   */
  Off: "Off",

  /**
   * The On option for the spending limit.
   */
  On: "On",
}

/**
 * Indicates the eligibility status of the payment terms.
 */
union PaymentTermsEligibilityStatus {
  string,

  /**
   * The Other option for the payment terms eligibility status.
   */
  Other: "Other",

  /**
   * The Valid option for the payment terms eligibility status.
   */
  Valid: "Valid",

  /**
   * The Invalid option for the payment terms eligibility status.
   */
  Invalid: "Invalid",
}

/**
 * Indicates the reason for the ineligibility of the payment terms.
 */
union PaymentTermsEligibilityCode {
  string,

  /**
   * The Other option for the payment terms eligibility code.
   */
  Other: "Other",

  /**
   * The OverlappingPaymentTerms option for the payment terms eligibility code.
   */
  OverlappingPaymentTerms: "OverlappingPaymentTerms",

  /**
   * The InvalidDateFormat option for the payment terms eligibility code.
   */
  InvalidDateFormat: "InvalidDateFormat",

  /**
   * The InvalidDateRange option for the payment terms eligibility code.
   */
  InvalidDateRange: "InvalidDateRange",

  /**
   * The InactiveBillingAccount option for the payment terms eligibility code.
   */
  InactiveBillingAccount: "InactiveBillingAccount",

  /**
   * The InvalidBillingAccountType option for the payment terms eligibility code.
   */
  InvalidBillingAccountType: "InvalidBillingAccountType",

  /**
   * The NullOrEmptyPaymentTerms option for the payment terms eligibility code.
   */
  NullOrEmptyPaymentTerms: "NullOrEmptyPaymentTerms",

  /**
   * The BillingAccountNotFound option for the payment terms eligibility code.
   */
  BillingAccountNotFound: "BillingAccountNotFound",

  /**
   * The IneligibleBillingAccountStatus option for the payment terms eligibility code.
   */
  IneligibleBillingAccountStatus: "IneligibleBillingAccountStatus",

  /**
   * The InvalidTerms option for the payment terms eligibility code.
   */
  InvalidTerms: "InvalidTerms",
}

/**
 * Status of the address validation.
 */
union AddressValidationStatus {
  string,

  /**
   * The Other option for the address validation status.
   */
  Other: "Other",

  /**
   * The Valid option for the address validation status.
   */
  Valid: "Valid",

  /**
   * The Invalid option for the address validation status.
   */
  Invalid: "Invalid",
}

/**
 * Access Decision, specifies access is allowed or not.
 */
union AccessDecision {
  string,

  /**
   * The Other option for the access decision.
   */
  Other: "Other",

  /**
   * The Allowed option for the access decision.
   */
  Allowed: "Allowed",

  /**
   * The NotAllowed option for the access decision.
   */
  NotAllowed: "NotAllowed",
}

/**
 * Status describing if billing profile is eligible to be deleted.
 */
union DeleteBillingProfileEligibilityStatus {
  string,

  /**
   * The Allowed option for the delete billing profile eligibility status.
   */
  Allowed: "Allowed",

  /**
   * The NotAllowed option for the delete billing profile eligibility status.
   */
  NotAllowed: "NotAllowed",
}

/**
 * Code of the delete invoice section eligibility response.
 */
union DeleteBillingProfileEligibilityCode {
  string,

  /**
   * The None option for the delete billing profile eligibility code.
   */
  None: "None",

  /**
   * The ActiveCredits option for the delete billing profile eligibility code.
   */
  ActiveCredits: "ActiveCredits",

  /**
   * The ActiveCreditCard option for the delete billing profile eligibility code.
   */
  ActiveCreditCard: "ActiveCreditCard",

  /**
   * The LastBillingProfile option for the delete billing profile eligibility code.
   */
  LastBillingProfile: "LastBillingProfile",

  /**
   * The NotSupported option for the delete billing profile eligibility code.
   */
  NotSupported: "NotSupported",

  /**
   * The OutstandingCharges option for the delete billing profile eligibility code.
   */
  OutstandingCharges: "OutstandingCharges",

  /**
   * The PendingCharges option for the delete billing profile eligibility code.
   */
  PendingCharges: "PendingCharges",

  /**
   * The ReservedInstances option for the delete billing profile eligibility code.
   */
  ReservedInstances: "ReservedInstances",

  /**
   * The ActiveBillingSubscriptions option for the delete billing profile eligibility code.
   */
  ActiveBillingSubscriptions: "ActiveBillingSubscriptions",
}

/**
 * The type of spending limit.
 */
union SpendingLimitType {
  string,

  /**
   * The Other option for the spending limit type.
   */
  Other: "Other",

  /**
   * The None option for the spending limit type.
   */
  None: "None",

  /**
   * The FreeAccount option for the spending limit type.
   */
  FreeAccount: "FreeAccount",

  /**
   * The Sandbox option for the spending limit type.
   */
  Sandbox: "Sandbox",

  /**
   * The AzureForStudents option for the spending limit type.
   */
  AzureForStudents: "AzureForStudents",

  /**
   * The AcademicSponsorship option for the spending limit type.
   */
  AcademicSponsorship: "AcademicSponsorship",

  /**
   * The AzureConsumptionCredit option for the spending limit type.
   */
  AzureConsumptionCredit: "AzureConsumptionCredit",

  /**
   * The AzurePassSponsorship option for the spending limit type.
   */
  AzurePassSponsorship: "AzurePassSponsorship",

  /**
   * The MpnSponsorship option for the spending limit type.
   */
  MpnSponsorship: "MpnSponsorship",

  /**
   * The MSDN option for the spending limit type.
   */
  MSDN: "MSDN",

  /**
   * The NonProfitSponsorship option for the spending limit type.
   */
  NonProfitSponsorship: "NonProfitSponsorship",

  /**
   * The Sponsorship option for the spending limit type.
   */
  Sponsorship: "Sponsorship",

  /**
   * The StartupSponsorship option for the spending limit type.
   */
  StartupSponsorship: "StartupSponsorship",

  /**
   * The AzureForStudentsStarter option for the spending limit type.
   */
  AzureForStudentsStarter: "AzureForStudentsStarter",

  /**
   * The VisualStudio option for the spending limit type.
   */
  VisualStudio: "VisualStudio",
}

/**
 * The status of current spending limit.
 */
union SpendingLimitStatus {
  string,

  /**
   * The Other option for the spending limit status.
   */
  Other: "Other",

  /**
   * The None option for the spending limit status.
   */
  None: "None",

  /**
   * The Active option for the spending limit status.
   */
  Active: "Active",

  /**
   * The Expired option for the spending limit status.
   */
  Expired: "Expired",

  /**
   * The LimitReached option for the spending limit status.
   */
  LimitReached: "LimitReached",

  /**
   * The LimitRemoved option for the spending limit status.
   */
  LimitRemoved: "LimitRemoved",
}

/**
 * Identifies the status of an customer. This is an upcoming property that will be populated in the future.
 */
union CustomerStatus {
  string,

  /**
   * The Other option for the customer status.
   */
  Other: "Other",

  /**
   * The Active option for the customer status.
   */
  Active: "Active",

  /**
   * The Pending option for the customer status.
   */
  Pending: "Pending",

  /**
   * The Disabled option for the customer status.
   */
  Disabled: "Disabled",

  /**
   * The Warned option for the customer status.
   */
  Warned: "Warned",

  /**
   * The Deleted option for the customer status.
   */
  Deleted: "Deleted",

  /**
   * The UnderReview option for the customer status.
   */
  UnderReview: "UnderReview",
}

/**
 * Identifies the status of an invoice section.
 */
union InvoiceSectionState {
  string,

  /**
   * The Other option for the invoice section state.
   */
  Other: "Other",

  /**
   * The Active option for the invoice section state.
   */
  Active: "Active",

  /**
   * The Deleted option for the invoice section state.
   */
  Deleted: "Deleted",

  /**
   * The Disabled option for the invoice section state.
   */
  Disabled: "Disabled",

  /**
   * The UnderReview option for the invoice section state.
   */
  UnderReview: "UnderReview",

  /**
   * The Warned option for the invoice section state.
   */
  Warned: "Warned",

  /**
   * The Restricted option for the invoice section state.
   */
  Restricted: "Restricted",
}

/**
 * Reason for the specified invoice section status.
 */
union InvoiceSectionStateReasonCode {
  string,

  /**
   * The Other option for the invoice section state reason code.
   */
  Other: "Other",

  /**
   * The PastDue option for the invoice section state reason code.
   */
  PastDue: "PastDue",

  /**
   * The UnusualActivity option for the invoice section state reason code.
   */
  UnusualActivity: "UnusualActivity",

  /**
   * The SpendingLimitReached option for the invoice section state reason code.
   */
  SpendingLimitReached: "SpendingLimitReached",

  /**
   * The SpendingLimitExpired option for the invoice section state reason code.
   */
  SpendingLimitExpired: "SpendingLimitExpired",
}

/**
 * The subscription status.
 */
union BillingSubscriptionStatus {
  string,

  /**
   * The Other option for the billing subscription status.
   */
  Other: "Other",

  /**
   * The Unknown option for the billing subscription status.
   */
  Unknown: "Unknown",

  /**
   * The Active option for the billing subscription status.
   */
  Active: "Active",

  /**
   * The Disabled option for the billing subscription status.
   */
  Disabled: "Disabled",

  /**
   * The Deleted option for the billing subscription status.
   */
  Deleted: "Deleted",

  /**
   * The Warned option for the billing subscription status.
   */
  Warned: "Warned",

  /**
   * The Expiring option for the billing subscription status.
   */
  Expiring: "Expiring",

  /**
   * The Expired option for the billing subscription status.
   */
  Expired: "Expired",

  /**
   * The AutoRenew option for the billing subscription status.
   */
  AutoRenew: "AutoRenew",

  /**
   * The Cancelled option for the billing subscription status.
   */
  Cancelled: "Cancelled",

  /**
   * The Suspended option for the billing subscription status.
   */
  Suspended: "Suspended",

  /**
   * The Failed option for the billing subscription status.
   */
  Failed: "Failed",
}

/**
 * The suspension reason for a subscription. This field is not available for Enterprise Agreement billing accounts.
 */
union SubscriptionStatusReason {
  string,

  /**
   * The None option for the subscription status reason.
   */
  None: "None",

  /**
   * The Cancelled option for the subscription status reason.
   */
  Cancelled: "Cancelled",

  /**
   * The PastDue option for the subscription status reason.
   */
  PastDue: "PastDue",

  /**
   * The SuspiciousActivity option for the subscription status reason.
   */
  SuspiciousActivity: "SuspiciousActivity",

  /**
   * The Other option for the subscription status reason.
   */
  Other: "Other",

  /**
   * The Transferred option for the subscription status reason.
   */
  Transferred: "Transferred",

  /**
   * The PolicyViolation option for the subscription status reason.
   */
  PolicyViolation: "PolicyViolation",

  /**
   * The SpendingLimitReached option for the subscription status reason.
   */
  SpendingLimitReached: "SpendingLimitReached",

  /**
   * The Expired option for the subscription status reason.
   */
  Expired: "Expired",
}

/**
 * The type of billing subscription.
 */
union SubscriptionBillingType {
  string,

  /**
   * The None option for the subscription billing type.
   */
  None: "None",

  /**
   * The Benefit option for the subscription billing type.
   */
  Benefit: "Benefit",

  /**
   * The Free option for the subscription billing type.
   */
  Free: "Free",

  /**
   * The Paid option for the subscription billing type.
   */
  Paid: "Paid",

  /**
   * The PrePaid option for the subscription billing type.
   */
  PrePaid: "PrePaid",
}

/**
 * The Azure workload type of the subscription.
 */
union SubscriptionWorkloadType {
  string,

  /**
   * The None option for the subscription workload type.
   */
  None: "None",

  /**
   * The Production option for the subscription workload type.
   */
  Production: "Production",

  /**
   * The DevTest option for the subscription workload type.
   */
  DevTest: "DevTest",

  /**
   * The Internal option for the subscription workload type.
   */
  Internal: "Internal",
}

/**
 * Status of billing request.
 */
union BillingRequestStatus {
  string,

  /**
   * The Other option for the billing request status.
   */
  Other: "Other",

  /**
   * The Pending option for the billing request status.
   */
  Pending: "Pending",

  /**
   * The Approved option for the billing request status.
   */
  Approved: "Approved",

  /**
   * The Declined option for the billing request status.
   */
  Declined: "Declined",

  /**
   * The Cancelled option for the billing request status.
   */
  Cancelled: "Cancelled",

  /**
   * The Completed option for the billing request status.
   */
  Completed: "Completed",

  /**
   * The Expired option for the billing request status.
   */
  Expired: "Expired",
}

/**
 * Type of billing request.
 */
union BillingRequestType {
  string,

  /**
   * The Other option for the billing request type.
   */
  Other: "Other",

  /**
   * The InvoiceAccess option for the billing request type.
   */
  InvoiceAccess: "InvoiceAccess",

  /**
   * The ProvisioningAccess option for the billing request type.
   */
  ProvisioningAccess: "ProvisioningAccess",

  /**
   * The RoleAssignment option for the billing request type.
   */
  RoleAssignment: "RoleAssignment",

  /**
   * The UpdateBillingPolicy option for the billing request type.
   */
  UpdateBillingPolicy: "UpdateBillingPolicy",
}

/**
 * The type of a role Assignment.
 */
union PrincipalType {
  string,

  /**
   * The Unknown option for the principal type.
   */
  Unknown: "Unknown",

  /**
   * The None option for the principal type.
   */
  None: "None",

  /**
   * The User option for the principal type.
   */
  User: "User",

  /**
   * The Group option for the principal type.
   */
  Group: "Group",

  /**
   * The DirectoryRole option for the principal type.
   */
  DirectoryRole: "DirectoryRole",

  /**
   * The ServicePrincipal option for the principal type.
   */
  ServicePrincipal: "ServicePrincipal",

  /**
   * The Everyone option for the principal type.
   */
  Everyone: "Everyone",
}

/**
 * Represents the Savings plan term in ISO 8601 format.
 */
union SavingsPlanTerm {
  string,

  /**
   * The P1Y option for the savings plan term.
   */
  P1Y: "P1Y",

  /**
   * The P3Y option for the savings plan term.
   */
  P3Y: "P3Y",

  /**
   * The P5Y option for the savings plan term.
   */
  P5Y: "P5Y",
}

/**
 * Represents the billing plan in ISO 8601 format. Required only for monthly purchases.
 */
union BillingPlan {
  string,

  /**
   * The P1M option for the billing plan.
   */
  P1M: "P1M",
}

/**
 * Describes whether the payment is completed, failed, pending, cancelled or scheduled in the future.
 */
union PaymentStatus {
  string,

  /**
   * The Succeeded option for the payment status.
   */
  Succeeded: "Succeeded",

  /**
   * The Failed option for the payment status.
   */
  Failed: "Failed",

  /**
   * The Scheduled option for the payment status.
   */
  Scheduled: "Scheduled",

  /**
   * The Cancelled option for the payment status.
   */
  Cancelled: "Cancelled",

  /**
   * The Completed option for the payment status.
   */
  Completed: "Completed",

  /**
   * The Pending option for the payment status.
   */
  Pending: "Pending",
}

/**
 * Type of the Applied Scope.
 */
union AppliedScopeType {
  string,

  /**
   * The Single option for the applied scope type.
   */
  Single: "Single",

  /**
   * The Shared option for the applied scope type.
   */
  Shared: "Shared",

  /**
   * The ManagementGroup option for the applied scope type.
   */
  ManagementGroup: "ManagementGroup",
}

/**
 * Commitment grain.
 */
union CommitmentGrain {
  string,

  /**
   * The Hourly option for the commitment grain.
   */
  Hourly: "Hourly",
}

/**
 * Indicates whether auto renewal is turned on or off for a product.
 */
union AutoRenew {
  string,

  /**
   * The Off option for the auto renew.
   */
  Off: "Off",

  /**
   * The On option for the auto renew.
   */
  On: "On",
}

/**
 * The current enrollment account status of the subscription. This field is available only for the Enterprise Agreement Type.
 */
union SubscriptionEnrollmentAccountStatus {
  string,

  /**
   * The Active option for the subscription enrollment account status.
   */
  Active: "Active",

  /**
   * The Cancelled option for the subscription enrollment account status.
   */
  Cancelled: "Cancelled",

  /**
   * The Expired option for the subscription enrollment account status.
   */
  Expired: "Expired",

  /**
   * The Deleted option for the subscription enrollment account status.
   */
  Deleted: "Deleted",

  /**
   * The TransferredOut option for the subscription enrollment account status.
   */
  TransferredOut: "TransferredOut",

  /**
   * The Transferring option for the subscription enrollment account status.
   */
  Transferring: "Transferring",

  /**
   * The Inactive option for the subscription enrollment account status.
   */
  Inactive: "Inactive",
}

/**
 * The policy override for the subscription indicates whether the self-serve cancellation or seat reduction is allowed.
 */
union Cancellation {
  string,

  /**
   * The NotAllowed option for the cancellation.
   */
  NotAllowed: "NotAllowed",

  /**
   * The Allowed option for the cancellation.
   */
  Allowed: "Allowed",
}

/**
 * The status of an operation on the subscription. When None, there is no ongoing operation. When LockedForUpdate, write operations will be blocked on the Billing Subscription. Other is the default value and you may need to refer to the latest API version for more details.
 */
union BillingSubscriptionOperationStatus {
  string,

  /**
   * The Other option for the billing subscription operation status.
   */
  Other: "Other",

  /**
   * The None option for the billing subscription operation status.
   */
  None: "None",

  /**
   * The LockedForUpdate option for the billing subscription operation status.
   */
  LockedForUpdate: "LockedForUpdate",
}

/**
 * Cancellation reason.
 */
union CancellationReason {
  string,

  /**
   * The Other option for the cancellation reason.
   */
  Other: "Other",

  /**
   * The Compromise option for the cancellation reason.
   */
  Compromise: "Compromise",

  /**
   * The Dispute option for the cancellation reason.
   */
  Dispute: "Dispute",
}

/**
 * Error code of the transfer validation response.
 */
union SubscriptionTransferValidationErrorCode {
  string,

  /**
   * The Other option for the subscription transfer validation error code.
   */
  Other: "Other",

  /**
   * The BillingAccountInactive option for the subscription transfer validation error code.
   */
  BillingAccountInactive: "BillingAccountInactive",

  /**
   * The DestinationBillingProfileInactive option for the subscription transfer validation error code.
   */
  DestinationBillingProfileInactive: "DestinationBillingProfileInactive",

  /**
   * The DestinationBillingProfileNotFound option for the subscription transfer validation error code.
   */
  DestinationBillingProfileNotFound: "DestinationBillingProfileNotFound",

  /**
   * The DestinationBillingProfilePastDue option for the subscription transfer validation error code.
   */
  DestinationBillingProfilePastDue: "DestinationBillingProfilePastDue",

  /**
   * The DestinationInvoiceSectionInactive option for the subscription transfer validation error code.
   */
  DestinationInvoiceSectionInactive: "DestinationInvoiceSectionInactive",

  /**
   * The DestinationInvoiceSectionNotFound option for the subscription transfer validation error code.
   */
  DestinationInvoiceSectionNotFound: "DestinationInvoiceSectionNotFound",

  /**
   * The InsufficientPermissionOnDestination option for the subscription transfer validation error code.
   */
  InsufficientPermissionOnDestination: "InsufficientPermissionOnDestination",

  /**
   * The InsufficientPermissionOnSource option for the subscription transfer validation error code.
   */
  InsufficientPermissionOnSource: "InsufficientPermissionOnSource",

  /**
   * The InvalidDestination option for the subscription transfer validation error code.
   */
  InvalidDestination: "InvalidDestination",

  /**
   * The InvalidSource option for the subscription transfer validation error code.
   */
  InvalidSource: "InvalidSource",

  /**
   * The MarketplaceNotEnabledOnDestination option for the subscription transfer validation error code.
   */
  MarketplaceNotEnabledOnDestination: "MarketplaceNotEnabledOnDestination",

  /**
   * The ProductInactive option for the subscription transfer validation error code.
   */
  ProductInactive: "ProductInactive",

  /**
   * The ProductNotFound option for the subscription transfer validation error code.
   */
  ProductNotFound: "ProductNotFound",

  /**
   * The ProductTypeNotSupported option for the subscription transfer validation error code.
   */
  ProductTypeNotSupported: "ProductTypeNotSupported",

  /**
   * The SourceBillingProfilePastDue option for the subscription transfer validation error code.
   */
  SourceBillingProfilePastDue: "SourceBillingProfilePastDue",

  /**
   * The SourceInvoiceSectionInactive option for the subscription transfer validation error code.
   */
  SourceInvoiceSectionInactive: "SourceInvoiceSectionInactive",

  /**
   * The AccountIsLocked option for the subscription transfer validation error code.
   */
  AccountIsLocked: "AccountIsLocked",

  /**
   * The AssetHasCap option for the subscription transfer validation error code.
   */
  AssetHasCap: "AssetHasCap",

  /**
   * The AssetNotActive option for the subscription transfer validation error code.
   */
  AssetNotActive: "AssetNotActive",

  /**
   * The BillingProfilePastDue option for the subscription transfer validation error code.
   */
  BillingProfilePastDue: "BillingProfilePastDue",

  /**
   * The CrossBillingAccountNotAllowed option for the subscription transfer validation error code.
   */
  CrossBillingAccountNotAllowed: "CrossBillingAccountNotAllowed",

  /**
   * The NoActiveAzurePlan option for the subscription transfer validation error code.
   */
  NoActiveAzurePlan: "NoActiveAzurePlan",

  /**
   * The None option for the subscription transfer validation error code.
   */
  None: "None",

  /**
   * The SubscriptionNotActive option for the subscription transfer validation error code.
   */
  SubscriptionNotActive: "SubscriptionNotActive",

  /**
   * The SubscriptionHasReservations option for the subscription transfer validation error code.
   */
  SubscriptionHasReservations: "SubscriptionHasReservations",

  /**
   * The SubscriptionTypeNotSupported option for the subscription transfer validation error code.
   */
  SubscriptionTypeNotSupported: "SubscriptionTypeNotSupported",

  /**
   * The InvoiceSectionIsRestricted option for the subscription transfer validation error code.
   */
  InvoiceSectionIsRestricted: "InvoiceSectionIsRestricted",
}

/**
 * The type of the document.
 */
union InvoiceDocumentType {
  string,

  /**
   * The Other option for the invoice document type.
   */
  Other: "Other",

  /**
   * The Invoice option for the invoice document type.
   */
  Invoice: "Invoice",

  /**
   * The VoidNote option for the invoice document type.
   */
  VoidNote: "VoidNote",

  /**
   * The TaxReceipt option for the invoice document type.
   */
  TaxReceipt: "TaxReceipt",

  /**
   * The CreditNote option for the invoice document type.
   */
  CreditNote: "CreditNote",

  /**
   * The Summary option for the invoice document type.
   */
  Summary: "Summary",

  /**
   * The Transactions option for the invoice document type.
   */
  Transactions: "Transactions",
}

/**
 * The source of the document. ENF for Brazil and DRS for rest of the world.
 */
union DocumentSource {
  string,

  /**
   * The Other option for the document source.
   */
  Other: "Other",

  /**
   * The DRS option for the document source.
   */
  DRS: "DRS",

  /**
   * The ENF option for the document source.
   */
  ENF: "ENF",
}

/**
 * The reason that the payment failed.
 */
union FailedPaymentReason {
  string,

  /**
   * The Other option for the failed payment reason.
   */
  Other: "Other",

  /**
   * The BankDeclined option for the failed payment reason.
   */
  BankDeclined: "BankDeclined",

  /**
   * The CardExpired option for the failed payment reason.
   */
  CardExpired: "CardExpired",

  /**
   * The IncorrectCardDetails option for the failed payment reason.
   */
  IncorrectCardDetails: "IncorrectCardDetails",
}

/**
 * Invoice type.
 */
union InvoiceType {
  string,

  /**
   * The Other option for the invoice type.
   */
  Other: "Other",

  /**
   * The AzureServices option for the invoice type.
   */
  AzureServices: "AzureServices",

  /**
   * The AzureMarketplace option for the invoice type.
   */
  AzureMarketplace: "AzureMarketplace",

  /**
   * The AzureSupport option for the invoice type.
   */
  AzureSupport: "AzureSupport",
}

/**
 * The current status of the invoice.
 */
union InvoiceStatus {
  string,

  /**
   * The Other option for the invoice status.
   */
  Other: "Other",

  /**
   * The Due option for the invoice status.
   */
  Due: "Due",

  /**
   * The OverDue option for the invoice status.
   */
  OverDue: "OverDue",

  /**
   * The Paid option for the invoice status.
   */
  Paid: "Paid",

  /**
   * The Void option for the invoice status.
   */
  Void: "Void",

  /**
   * The Locked option for the invoice status.
   */
  Locked: "Locked",
}

/**
 * Identifies the type of tax calculation used for the invoice. The field is applicable only to invoices with special tax calculation logic.
 */
union SpecialTaxationType {
  string,

  /**
   * The SubtotalLevel option for the special taxation type.
   */
  SubtotalLevel: "SubtotalLevel",

  /**
   * The InvoiceLevel option for the special taxation type.
   */
  InvoiceLevel: "InvoiceLevel",
}

/**
 * The status of refund request.
 */
union RefundStatus {
  string,

  /**
   * The Other option for the refund status.
   */
  Other: "Other",

  /**
   * The Pending option for the refund status.
   */
  Pending: "Pending",

  /**
   * The Approved option for the refund status.
   */
  Approved: "Approved",

  /**
   * The Declined option for the refund status.
   */
  Declined: "Declined",

  /**
   * The Cancelled option for the refund status.
   */
  Cancelled: "Cancelled",

  /**
   * The Completed option for the refund status.
   */
  Completed: "Completed",

  /**
   * The Expired option for the refund status.
   */
  Expired: "Expired",
}

/**
 * The reason for refund.
 */
union RefundReasonCode {
  string,

  /**
   * The Other option for the refund reason code.
   */
  Other: "Other",

  /**
   * The AccidentalConversion option for the refund reason code.
   */
  AccidentalConversion: "AccidentalConversion",

  /**
   * The UnclearPricing option for the refund reason code.
   */
  UnclearPricing: "UnclearPricing",

  /**
   * The AccidentalPurchase option for the refund reason code.
   */
  AccidentalPurchase: "AccidentalPurchase",

  /**
   * The ForgotToCancel option for the refund reason code.
   */
  ForgotToCancel: "ForgotToCancel",

  /**
   * The UnclearDocumentation option for the refund reason code.
   */
  UnclearDocumentation: "UnclearDocumentation",
}

/**
 * Status describing if invoice section is eligible to be deleted.
 */
union DeleteInvoiceSectionEligibilityStatus {
  string,

  /**
   * The Allowed option for the delete invoice section eligibility status.
   */
  Allowed: "Allowed",

  /**
   * The NotAllowed option for the delete invoice section eligibility status.
   */
  NotAllowed: "NotAllowed",
}

/**
 * Code for the delete invoice section validation.
 */
union DeleteInvoiceSectionEligibilityCode {
  string,

  /**
   * The Other option for the delete invoice section eligibility code.
   */
  Other: "Other",

  /**
   * The LastInvoiceSection option for the delete invoice section eligibility code.
   */
  LastInvoiceSection: "LastInvoiceSection",

  /**
   * The ActiveAzurePlans option for the delete invoice section eligibility code.
   */
  ActiveAzurePlans: "ActiveAzurePlans",

  /**
   * The ReservedInstances option for the delete invoice section eligibility code.
   */
  ReservedInstances: "ReservedInstances",

  /**
   * The ActiveBillingSubscriptions option for the delete invoice section eligibility code.
   */
  ActiveBillingSubscriptions: "ActiveBillingSubscriptions",
}

/**
 * Status of the payment method.
 */
union PaymentMethodStatus {
  string,

  /**
   * The unknown option for the payment method status.
   */
  @added(Versions.v2024_08_01_preview)
  Unknown: "unknown",

  /**
   * The active option for the payment method status.
   */
  active: "active",

  /**
   * The inactive option for the payment method status.
   */
  inactive: "inactive",
}

/**
 * The service defined resource name.
 */
union ServiceDefinedResourceName {
  string,

  /**
   * The default option for the service defined resource name.
   */
  default: "default",
}

/**
 * The policy that controls whether the users in customer's organization can view charges at pay-as-you-go prices.
 */
union ViewChargesPolicy {
  string,

  /**
   * The Other option for the view charges policy.
   */
  Other: "Other",

  /**
   * The Allowed option for the view charges policy.
   */
  Allowed: "Allowed",

  /**
   * The NotAllowed option for the view charges policy.
   */
  NotAllowed: "NotAllowed",
}

/**
 * The type of the policy.
 */
union PolicyType {
  string,

  /**
   * The Other option for the policy type.
   */
  Other: "Other",

  /**
   * The UserControlled option for the policy type.
   */
  UserControlled: "UserControlled",

  /**
   * The SystemControlled option for the policy type.
   */
  SystemControlled: "SystemControlled",
}

/**
 * The state showing the enrollment auth level.
 */
union EnrollmentAuthLevelState {
  string,

  /**
   * The Other option for the enrollment auth level state.
   */
  Other: "Other",

  /**
   * The MicrosoftAccountOnly option for the enrollment auth level state.
   */
  MicrosoftAccountOnly: "MicrosoftAccountOnly",

  /**
   * The MixedAccount option for the enrollment auth level state.
   */
  MixedAccount: "MixedAccount",

  /**
   * The OrganizationalAccountCrossTenant option for the enrollment auth level state.
   */
  OrganizationalAccountCrossTenant: "OrganizationalAccountCrossTenant",

  /**
   * The OrganizationalAccountOnly option for the enrollment auth level state.
   */
  OrganizationalAccountOnly: "OrganizationalAccountOnly",
}

/**
 * The policy that controls whether account owner can view charges.
 */
union EnrollmentAccountOwnerViewCharges {
  string,

  /**
   * The Other option for the enrollment account owner view charges.
   */
  Other: "Other",

  /**
   * The Allowed option for the enrollment account owner view charges.
   */
  Allowed: "Allowed",

  /**
   * The Disabled option for the enrollment account owner view charges.
   */
  Disabled: "Disabled",

  /**
   * The NotAllowed option for the enrollment account owner view charges.
   */
  NotAllowed: "NotAllowed",
}

/**
 * The policy that controls whether department admin can view charges.
 */
union EnrollmentDepartmentAdminViewCharges {
  string,

  /**
   * The Other option for the enrollment department admin view charges.
   */
  Other: "Other",

  /**
   * The Allowed option for the enrollment department admin view charges.
   */
  Allowed: "Allowed",

  /**
   * The Disabled option for the enrollment department admin view charges.
   */
  Disabled: "Disabled",

  /**
   * The NotAllowed option for the enrollment department admin view charges.
   */
  NotAllowed: "NotAllowed",
}

/**
 * The policy that controls invoice section label management at invoice section scope. This is allowed by default.
 */
union InvoiceSectionLabelManagementPolicy {
  string,

  /**
   * The Other option for the invoice section label management policy.
   */
  Other: "Other",

  /**
   * The Allowed option for the invoice section label management policy.
   */
  Allowed: "Allowed",

  /**
   * The NotAllowed option for the invoice section label management policy.
   */
  NotAllowed: "NotAllowed",
}

/**
 * The policy that controls whether Azure marketplace purchases are allowed.
 */
union MarketplacePurchasesPolicy {
  string,

  /**
   * The Other option for the marketplace purchases policy.
   */
  Other: "Other",

  /**
   * The AllAllowed option for the marketplace purchases policy.
   */
  AllAllowed: "AllAllowed",

  /**
   * The Disabled option for the marketplace purchases policy.
   */
  Disabled: "Disabled",

  /**
   * The NotAllowed option for the marketplace purchases policy.
   */
  NotAllowed: "NotAllowed",

  /**
   * The OnlyFreeAllowed option for the marketplace purchases policy.
   */
  OnlyFreeAllowed: "OnlyFreeAllowed",
}

/**
 * The policy that controls whether Azure reservation purchases are allowed.
 */
union ReservationPurchasesPolicy {
  string,

  /**
   * The Other option for the reservation purchases policy.
   */
  Other: "Other",

  /**
   * The Allowed option for the reservation purchases policy.
   */
  Allowed: "Allowed",

  /**
   * The Disabled option for the reservation purchases policy.
   */
  Disabled: "Disabled",

  /**
   * The NotAllowed option for the reservation purchases policy.
   */
  NotAllowed: "NotAllowed",
}

/**
 * The policy that controls whether users with Azure savings plan purchase are allowed.
 */
union SavingsPlanPurchasesPolicy {
  string,

  /**
   * The Other option for the savings plan purchases policy.
   */
  Other: "Other",

  /**
   * The Allowed option for the savings plan purchases policy.
   */
  Allowed: "Allowed",

  /**
   * The Disabled option for the savings plan purchases policy.
   */
  Disabled: "Disabled",

  /**
   * The NotAllowed option for the savings plan purchases policy.
   */
  NotAllowed: "NotAllowed",
}

/**
 * The status of the product.
 */
union ProductStatus {
  string,

  /**
   * The Other option for the product status.
   */
  Other: "Other",

  /**
   * The Active option for the product status.
   */
  Active: "Active",

  /**
   * The Disabled option for the product status.
   */
  Disabled: "Disabled",

  /**
   * The Deleted option for the product status.
   */
  Deleted: "Deleted",

  /**
   * The PastDue option for the product status.
   */
  PastDue: "PastDue",

  /**
   * The Expiring option for the product status.
   */
  Expiring: "Expiring",

  /**
   * The Expired option for the product status.
   */
  Expired: "Expired",

  /**
   * The AutoRenew option for the product status.
   */
  AutoRenew: "AutoRenew",

  /**
   * The Canceled option for the product status.
   */
  Canceled: "Canceled",

  /**
   * The Suspended option for the product status.
   */
  Suspended: "Suspended",
}

/**
 * Error code for the product transfer validation.
 */
union MoveValidationErrorCode {
  string,

  /**
   * The Other option for the move validation error code.
   */
  Other: "Other",

  /**
   * The BillingAccountInactive option for the move validation error code.
   */
  BillingAccountInactive: "BillingAccountInactive",

  /**
   * The DestinationBillingProfileInactive option for the move validation error code.
   */
  DestinationBillingProfileInactive: "DestinationBillingProfileInactive",

  /**
   * The DestinationBillingProfileNotFound option for the move validation error code.
   */
  DestinationBillingProfileNotFound: "DestinationBillingProfileNotFound",

  /**
   * The DestinationBillingProfilePastDue option for the move validation error code.
   */
  DestinationBillingProfilePastDue: "DestinationBillingProfilePastDue",

  /**
   * The DestinationInvoiceSectionInactive option for the move validation error code.
   */
  DestinationInvoiceSectionInactive: "DestinationInvoiceSectionInactive",

  /**
   * The DestinationInvoiceSectionNotFound option for the move validation error code.
   */
  DestinationInvoiceSectionNotFound: "DestinationInvoiceSectionNotFound",

  /**
   * The InsufficientPermissionOnDestination option for the move validation error code.
   */
  InsufficientPermissionOnDestination: "InsufficientPermissionOnDestination",

  /**
   * The InsufficientPermissionOnSource option for the move validation error code.
   */
  InsufficientPermissionOnSource: "InsufficientPermissionOnSource",

  /**
   * The InvalidDestination option for the move validation error code.
   */
  InvalidDestination: "InvalidDestination",

  /**
   * The InvalidSource option for the move validation error code.
   */
  InvalidSource: "InvalidSource",

  /**
   * The MarketplaceNotEnabledOnDestination option for the move validation error code.
   */
  MarketplaceNotEnabledOnDestination: "MarketplaceNotEnabledOnDestination",

  /**
   * The ProductInactive option for the move validation error code.
   */
  ProductInactive: "ProductInactive",

  /**
   * The ProductNotFound option for the move validation error code.
   */
  ProductNotFound: "ProductNotFound",

  /**
   * The ProductTypeNotSupported option for the move validation error code.
   */
  ProductTypeNotSupported: "ProductTypeNotSupported",

  /**
   * The SourceBillingProfilePastDue option for the move validation error code.
   */
  SourceBillingProfilePastDue: "SourceBillingProfilePastDue",

  /**
   * The SourceInvoiceSectionInactive option for the move validation error code.
   */
  SourceInvoiceSectionInactive: "SourceInvoiceSectionInactive",
}

/**
 * Turning this on will apply the reservation discount to other VMs in the same VM size group. Only specify for VirtualMachines reserved resource type.
 */
union InstanceFlexibility {
  string,

  /**
   * The On option for the instance flexibility.
   */
  On: "On",

  /**
   * The Off option for the instance flexibility.
   */
  Off: "Off",
}

/**
 * The status of the reservation.
 */
union ReservationStatusCode {
  string,

  /**
   * The None option for the reservation status code.
   */
  None: "None",

  /**
   * The Pending option for the reservation status code.
   */
  Pending: "Pending",

  /**
   * The Processing option for the reservation status code.
   */
  Processing: "Processing",

  /**
   * The Active option for the reservation status code.
   */
  Active: "Active",

  /**
   * The PurchaseError option for the reservation status code.
   */
  PurchaseError: "PurchaseError",

  /**
   * The PaymentInstrumentError option for the reservation status code.
   */
  PaymentInstrumentError: "PaymentInstrumentError",

  /**
   * The Split option for the reservation status code.
   */
  Split: "Split",

  /**
   * The Merged option for the reservation status code.
   */
  Merged: "Merged",

  /**
   * The Expired option for the reservation status code.
   */
  Expired: "Expired",

  /**
   * The Succeeded option for the reservation status code.
   */
  Succeeded: "Succeeded",

  /**
   * The CapacityError option for the reservation status code.
   */
  CapacityError: "CapacityError",

  /**
   * The CapacityRestricted option for the reservation status code.
   */
  CapacityRestricted: "CapacityRestricted",

  /**
   * The Exchanged option for the reservation status code.
   */
  Exchanged: "Exchanged",

  /**
   * The UnknownError option for the reservation status code.
   */
  UnknownError: "UnknownError",

  /**
   * The RiskCheckFailed option for the reservation status code.
   */
  RiskCheckFailed: "RiskCheckFailed",

  /**
   * The CreditLineCheckFailed option for the reservation status code.
   */
  CreditLineCheckFailed: "CreditLineCheckFailed",

  /**
   * The Warning option for the reservation status code.
   */
  Warning: "Warning",

  /**
   * The NoBenefitDueToSubscriptionTransfer option for the reservation status code.
   */
  NoBenefitDueToSubscriptionTransfer: "NoBenefitDueToSubscriptionTransfer",

  /**
   * The NoBenefitDueToSubscriptionDeletion option for the reservation status code.
   */
  NoBenefitDueToSubscriptionDeletion: "NoBenefitDueToSubscriptionDeletion",

  /**
   * The NoBenefit option for the reservation status code.
   */
  NoBenefit: "NoBenefit",
}

/**
 * Represent the billing plans.
 */
union ReservationBillingPlan {
  string,

  /**
   * The Upfront option for the reservation billing plan.
   */
  Upfront: "Upfront",

  /**
   * The Monthly option for the reservation billing plan.
   */
  Monthly: "Monthly",
}

/**
 * The type of transaction.
 */
union TransactionType {
  string,

  /**
   * The Other option for the transaction type.
   */
  Other: "Other",

  /**
   * The Billed option for the transaction type.
   */
  Billed: "Billed",

  /**
   * The Unbilled option for the transaction type.
   */
  Unbilled: "Unbilled",
}

/**
 * The credit type of the transaction. Applies only to credited transactions.
 */
union CreditType {
  string,

  /**
   * The Other option for the credit type.
   */
  Other: "Other",

  /**
   * The AzureFreeCredit option for the credit type.
   */
  AzureFreeCredit: "AzureFreeCredit",

  /**
   * The AzureCreditOffer option for the credit type.
   */
  AzureCreditOffer: "AzureCreditOffer",

  /**
   * The ServiceInterruption option for the credit type.
   */
  ServiceInterruption: "ServiceInterruption",

  /**
   * The Refund option for the credit type.
   */
  Refund: "Refund",
}

/**
 * Type of the transaction, billed or unbilled.
 */
union TransactionKind {
  string,

  /**
   * The Other option for the transaction kind.
   */
  Other: "Other",

  /**
   * The All option for the transaction kind.
   */
  All: "All",

  /**
   * The Reservation option for the transaction kind.
   */
  Reservation: "Reservation",
}

/**
 * The status of a transfer.
 */
union TransferStatus {
  string,

  /**
   * The Expired option for the transfer status.
   */
  Expired: "Expired",

  /**
   * The Pending option for the transfer status.
   */
  Pending: "Pending",

  /**
   * The InProgress option for the transfer status.
   */
  InProgress: "InProgress",

  /**
   * The Completed option for the transfer status.
   */
  Completed: "Completed",

  /**
   * The CompletedWithErrors option for the transfer status.
   */
  CompletedWithErrors: "CompletedWithErrors",

  /**
   * The Failed option for the transfer status.
   */
  Failed: "Failed",

  /**
   * The Canceled option for the transfer status.
   */
  Canceled: "Canceled",

  /**
   * The Declined option for the transfer status.
   */
  Declined: "Declined",
}

/**
 * The type of product that is transferred.
 */
union ProductType {
  string,

  /**
   * The AzureSubscription option for the product type.
   */
  AzureSubscription: "AzureSubscription",

  /**
   * The AzureReservation option for the product type.
   */
  AzureReservation: "AzureReservation",

  /**
   * The Department option for the product type.
   */
  Department: "Department",

  /**
   * The SavingsPlan option for the product type.
   */
  SavingsPlan: "SavingsPlan",

  /**
   * The SAAS option for the product type.
   */
  SAAS: "SAAS",
}

/**
 * The status of a transfer.
 */
union ProductTransferStatus {
  string,

  /**
   * The NotStarted option for the product transfer status.
   */
  NotStarted: "NotStarted",

  /**
   * The InProgress option for the product transfer status.
   */
  InProgress: "InProgress",

  /**
   * The Completed option for the product transfer status.
   */
  Completed: "Completed",

  /**
   * The Failed option for the product transfer status.
   */
  Failed: "Failed",
}

/**
 * The type of customer of the transfer initiator.
 */
union InitiatorCustomerType {
  string,

  /**
   * The Partner option for the initiator customer type.
   */
  Partner: "Partner",

  /**
   * The EA option for the initiator customer type.
   */
  EA: "EA",
}

/**
 * Type of the products that can be transferred.
 */
union EligibleProductType {
  string,

  /**
   * The DevTestAzureSubscription option for the eligible product type.
   */
  DevTestAzureSubscription: "DevTestAzureSubscription",

  /**
   * The StandardAzureSubscription option for the eligible product type.
   */
  StandardAzureSubscription: "StandardAzureSubscription",

  /**
   * The AzureReservation option for the eligible product type.
   */
  AzureReservation: "AzureReservation",
}

/**
 * The supported account types.
 */
union SupportedAccountType {
  string,

  /**
   * The None option for the supported account type.
   */
  None: "None",

  /**
   * The Partner option for the supported account type.
   */
  Partner: "Partner",

  /**
   * The Individual option for the supported account type.
   */
  Individual: "Individual",

  /**
   * The Enterprise option for the supported account type.
   */
  Enterprise: "Enterprise",
}

/**
 * The state of an alert.
 */
@added(Versions.v2024_08_01_preview)
union AlertState {
  string,

  /**
   * The unknown alert state.
   */
  Unknown: "Unknown",

  /**
   * A newly fired alert.
   */
  New: "New",

  /**
   * An alert acknowledged by a user.
   */
  Acknowledged: "Acknowledged",

  /**
   * An alert dismissed by the system.
   */
  Closed: "Closed",
}

/**
 * The severity of an alert. Severity ranges from Sev0, which is the highest, to Sev3, which is the lowest.
 */
@added(Versions.v2024_08_01_preview)
union AlertSeverity {
  string,

  /**
   * The highest alert severity.
   */
  Sev0: "Sev0",

  /**
   * The second-highest alert severity.
   */
  Sev1: "Sev1",

  /**
   * The second-lowest alert severity.
   */
  Sev2: "Sev2",

  /**
   * The lowest alert severity.
   */
  Sev3: "Sev3",
}

/**
 * The resource type of the target Azure Resource Manager resource. This represents a billing account, billing profile, billing subscription, invoice, or transaction.
 */
@added(Versions.v2024_08_01_preview)
union AlertTargetResourceType {
  string,

  /**
   * The target resource type is unknown.
   */
  Unknown: "Unknown",

  /**
   * A billing subscription.
   */
  BillingSubscription: "BillingSubscription",

  /**
   * A billing account.
   */
  BillingAccount: "BillingAccount",

  /**
   * A billing profile.
   */
  BillingProfile: "BillingProfile",

  /**
   * An invoice.
   */
  Invoice: "Invoice",

  /**
   * A transaction.
   */
  Transaction: "Transaction",
}

/**
 * The type of alert.
 */
@added(Versions.v2024_08_01_preview)
union AlertType {
  string,

  /**
   * The alert type is unknown.
   */
  Unknown: "Unknown",

  /**
   * A custom alert.
   */
  Custom: "Custom",

  /**
   * A service alert.
   */
  Service: "Service",

  /**
   * A maintenance alert.
   */
  Maintenance: "Maintenance",

  /**
   * An alert for a successful billing authorization threshold.
   */
  ThresholdBillingAuthSuccess: "ThresholdBillingAuthSuccess",

  /**
   * An alert for a declined billing limit threshold.
   */
  ThresholdBillingLimitDeclined: "ThresholdBillingLimitDeclined",

  /**
   * A reminder alert for a declined billing limit threshold.
   */
  ThresholdBillingLimitDeclinedReminder: "ThresholdBillingLimitDeclinedReminder",

  /**
   * An alert for a billing consumption threshold.
   */
  ThresholdBillingConsumption: "ThresholdBillingConsumption",

  /**
   * A successful payment alert.
   */
  PaymentSuccessful: "PaymentSuccessful",

  /**
   * A failed payment alert.
   */
  PaymentFailed: "PaymentFailed",

  /**
   * A purchase-started alert.
   */
  PurchaseStarted: "PurchaseStarted",

  /**
   * A purchase-completed alert.
   */
  PurchaseCompleted: "PurchaseCompleted",

  /**
   * The default alert type.
   */
  Default: "Default",
}

/**
 * A billing alert.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not a subscription provisioned resource."
@added(Versions.v2024_08_01_preview)
model AlertProperties {
  /**
   * Information that is common to all alert types.
   */
  essentials?: AlertEssentials;

  /**
   * Information that will be used to display the alert in the portal.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Free form by design to support different kinds of alerts to display to the customer. Entirely system generated values, the service guarantees no secret material is ever placed in this map."
  egressConfig?: Record<string>;

  /**
   * Information specific to an alert type.
   */
  context?: AlertContext;
}

/**
 * Information that is common to all alert types.
 */
@added(Versions.v2024_08_01_preview)
model AlertEssentials {
  /**
   * The state of an alert.
   */
  alertState?: AlertState;

  /**
   * The description of the alert.
   */
  description?: string;

  /**
   * The severity of an alert. Severity ranges from Sev0, which is the highest, to Sev3, which is the lowest.
   */
  severity?: AlertSeverity;

  /**
   * Alert starts display time.
   */
  startDateTime?: utcDateTime;

  /**
   * The time at which the alert expires.
   */
  expiredDateTime?: utcDateTime;

  /**
   * Resource ID of the target Azure Resource Manager resource on which the alert was created. This represents a billing scope ID, invoice ID, or billing subscription ID.
   */
  targetResource?: string;

  /**
   * The resource type of the target Azure Resource Manager resource. This represents a billing account, billing profile, billing subscription, invoice, or transaction.
   */
  targetResourceType?: AlertTargetResourceType;
}

/**
 * Information specific to an alert type.
 */
@added(Versions.v2024_08_01_preview)
model AlertContext {
  /**
   * The type of alert.
   */
  alertType?: AlertType;

  /**
   * The resource ID that uniquely identifies a billing account resource.
   */
  billingAccountId?: string;

  /**
   * The name of the billing account.
   */
  billingAccountDisplayName?: string;

  /**
   * The resource ID that uniquely identifies a billing profile resource.
   */
  billingProfileId?: string;

  /**
   * The name of the billing profile.
   */
  billingProfileDisplayName?: string;
}

/**
 * An agreement.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not a subscription provisioned resource."
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
  effectiveDate?: utcDateTime;

  /**
   * The date when the agreement expires.
   */
  @visibility(Lifecycle.Read)
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

  /**
   * A list of clauses in an agreement.
   */
  @added(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  clauses?: Clause[];
}

/**
 * A clause in an agreement.
 */
@added(Versions.v2024_08_01_preview)
model Clause {
  /**
   * The ID that uniquely identifies an agreement clause.
   */
  @visibility(Lifecycle.Read)
  id: string;

  /**
   * The name of the agreement clause.
   */
  @visibility(Lifecycle.Read)
  name: string;

  /**
   * The date from which the agreement clause is effective.
   */
  @visibility(Lifecycle.Read)
  effectiveDate: utcDateTime;

  /**
   * The date when the agreement clause expires.
   */
  @visibility(Lifecycle.Read)
  expirationDate?: utcDateTime;
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
   * The first name of the participant.
   */
  @added(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  firstName?: string;

  /**
   * The last name of the participant.
   */
  @added(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  lastName?: string;

  /**
   * The acceptance status of the participant.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * The role of the participant.
   */
  @added(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  role?: ParticipantRole;

  /**
   * The date when the status got changed.
   */
  @visibility(Lifecycle.Read)
  statusDate?: utcDateTime;
}

/**
 * The role of the participant.
 */
@added(Versions.v2024_08_01_preview)
union ParticipantRole {
  string,

  /**
   * The participant role is not specified.
   */
  Other: "Other",

  /**
   * The participant can accept or sign the agreement.
   */
  Signer: "Signer",

  /**
   * The participant can review the agreement.
   */
  Reviewer: "Reviewer",

  /**
   * The participant allows the system to automatically sign the agreement.
   */
  AutoSigner: "AutoSigner",

  /**
   * The participant accepts or signs the agreement on behalf of another individual or organization.
   */
  OnBehalfOf: "OnBehalfOf",

  /**
   * The participant is the lead or parent of the entity signing the agreement.
   */
  Lead: "Lead",
}

/**
 * An associated tenant.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not a subscription provisioned resource."
model AssociatedTenantProperties {
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not a subscription provisioned resource."
model AvailableBalanceProperties {
  /**
   * Credit amount for immediate payment.
   */
  amount?: Amount;

  /**
   * The list of payments on accounts.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  paymentsOnAccount?: PaymentOnAccount[];

  /**
   * Total amount of payments on accounts.
   */
  totalPaymentsOnAccount?: Amount;
}

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
  amount?: Amount;

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
  date?: utcDateTime;

  /**
   * Payment on Account type.
   */
  @visibility(Lifecycle.Read)
  paymentMethodType?: PaymentMethodFamily;
}

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
  startDate?: utcDateTime;

  /**
   * The date on when the defined 'Payment Term' will end and is always in UTC.
   */
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not a subscription provisioned resource."
model BillingAccountProperties {
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
   * The trade name of the legal entity for the billing account.
   */
  @added(Versions.v2024_08_01_preview)
  tradeName?: string;

  /**
   * The properties of an enrollment.
   */
  enrollmentDetails?: EnrollmentDetails;

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
  soldTo?: AddressDetails;

  /**
   * Describes the registration number of the organization linked with the billing account.
   */
  registrationNumber?: RegistrationNumber;

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

  /**
   * Provides information such as name and country about the organization affiliated with the billing account.
   */
  @added(Versions.v2024_08_01_preview)
  affiliatedOrganization?: AffiliatedOrganizationInfo;

  /**
   * The sandbox information for the billing account.
   */
  @added(Versions.v2024_08_01_preview)
  sandboxInformation?: SandboxInfo;
}

/**
 * The organization that the billing account is affiliated with.
 */
@added(Versions.v2024_08_01_preview)
model AffiliatedOrganizationInfo {
  /**
   * The name of the affiliated organization.
   */
  affiliatedOrganizationName?: string;

  /**
   * The country of the affiliated organization.
   */
  affiliatedOrganizationCountry?: string;
}

/**
 * The sandbox information for the billing account.
 */
@added(Versions.v2024_08_01_preview)
model SandboxInfo {
  /**
   * The name of the sandbox.
   */
  name?: string;

  /**
   * The type of the sandbox.
   */
  type?: string;
}

/**
 * The properties of an enrollment.
 */
model EnrollmentDetails {
  /**
   * The start date of the enrollment.
   */
  startDate?: utcDateTime;

  /**
   * The end date of the enrollment.
   */
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
  indirectRelationshipInfo?: IndirectRelationshipInfo;

  /**
   * The contact who receives invoices of the enrollment.
   */
  @visibility(Lifecycle.Read)
  invoiceRecipient?: string;

  /**
   * Agreement status of an enrollment, applicable only for users with non-Azure roles.
   */
  @added(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  agreementStatus?: EaAgreementStatus;
}

/**
 * The agreement status of an enrollment.
 */
@added(Versions.v2024_08_01_preview)
union EaAgreementStatus {
  string,

  /**
   * The Other agreement status.
   */
  Other: "Other",

  /**
   * The Active agreement status.
   */
  Active: "Active",

  /**
   * The Amended agreement status.
   */
  Amended: "Amended",

  /**
   * The AmendmentHold agreement status.
   */
  AmendmentHold: "AmendmentHold",

  /**
   * The AmendmentInProgress agreement status.
   */
  AmendmentInProgress: "AmendmentInProgress",

  /**
   * The Ended agreement status.
   */
  Ended: "Ended",

  /**
   * The Expired agreement status.
   */
  Expired: "Expired",

  /**
   * The New agreement status.
   */
  New: "New",

  /**
   * The Hold agreement status.
   */
  Hold: "Hold",

  /**
   * The Pending agreement status.
   */
  Pending: "Pending",

  /**
   * The Rejected agreement status.
   */
  Rejected: "Rejected",

  /**
   * The Review agreement status.
   */
  Review: "Review",

  /**
   * The Terminated agreement status.
   */
  Terminated: "Terminated",
}

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
 * The type of the address usage.
 */
@added(Versions.v2024_08_01_preview)
union AddressUsageType {
  string,

  /**
   * Another address usage type.
   */
  Other: "Other",

  /**
   * A billing address.
   */
  BillTo: "BillTo",

  /**
   * A shipping address.
   */
  ShipTo: "ShipTo",

  /**
   * A sold-to address.
   */
  SoldTo: "SoldTo",

  /**
   * An operating address.
   */
  Operating: "Operating",
}

/**
 * Address details.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not a subscription provisioned resource."
@added(Versions.v2024_08_01_preview)
model AddressEntityProperties {
  /**
   * The system identifier of the address.
   */
  systemId?: string;

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
   * Company name.
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
   * First name.
   */
  firstName?: string;

  /**
   * Last name.
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
   * Indicates whether the address is valid.
   */
  @visibility(Lifecycle.Read)
  isValidAddress?: boolean;

  /**
   * The address snapshot identifier.
   */
  snapshotId?: string;

  /**
   * The type of the address usage.
   */
  addressUsage?: AddressUsageType[];
}

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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not a subscription provisioned resource."
model BillingProfileProperties {
  /**
   * Identifies the billing relationship represented by the billing profile. The billing relationship may be between Microsoft, the customer, and/or a third-party.
   */
  @visibility(Lifecycle.Read)
  billingRelationshipType?: BillingRelationshipType;

  /**
   * Billing address.
   */
  billTo?: AddressDetails;

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
  @removed(Versions.v2024_08_01_preview)
  indirectRelationshipInfo?: IndirectRelationshipInfo;

  /**
   * The details of the relationship between a partner's billing profile and a customer's billing profile. The partner could be either a direct-bill Cloud Solution Provider partner or an indirect reseller.
   */
  @added(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  partnerRelationshipInfo?: IndirectRelationshipInfo;

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
   * The list of contacts who will receive invoices by email for the selected billing profile and will be contacted if there are issues related to payments of these invoices.
   */
  @added(Versions.v2024_08_01_preview)
  @identifiers(#[])
  invoiceRecipientContacts?: InvoiceRecipientContact[];

  /**
   * The default purchase order number that will appear on the invoices generated for the billing profile.
   */
  poNumber?: string;

  /**
   * The default address where the products are shipped, or the services are being used. If a ship to is not specified for a product or a subscription, then this address will be used.
   */
  shipTo?: AddressDetails;

  /**
   * The address of the individual or organization that is responsible for the billing account.
   */
  soldTo?: AddressDetails;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "Existing documentation where tags are in the model properties instead of the envelope. Back compat. Same type as TrackedResource.tags."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing documentation where tags are in the model properties instead of the envelope. Back compat. Same type as TrackedResource.tags."
  tags?: Record<string>;

  /**
   * Identifies the cloud environments that are associated with a billing profile. This is a system managed optional field and gets updated as the billing profile gets associated with accounts in various clouds.
   */
  @visibility(Lifecycle.Read)
  targetClouds?: string[];

  /**
   * The current payment term of the billing profile.
   */
  currentPaymentTerm?: PaymentTerm;

  /**
   * The other payment terms of the billing profile.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  otherPaymentTerms?: PaymentTerm[];
}

/**
 * Invoice recipient contact.
 */
@added(Versions.v2024_08_01_preview)
model InvoiceRecipientContact {
  /**
   * First name.
   */
  firstName: string;

  /**
   * Middle name. Optional.
   */
  middleName?: string;

  /**
   * Last name.
   */
  lastName: string;

  /**
   * Phone number.
   */
  phoneNumber?: string;

  /**
   * Email address.
   */
  email?: string;

  /**
   * Email address.
   */
  emailAddress?: string;
}

/**
 * Request parameters that are provided to update invoice recipient contacts.
 */
@added(Versions.v2024_08_01_preview)
model UpdateInvoiceRecipientContactsRequest {
  /**
   * The list of contacts who will receive invoices by email for the selected billing profile and will be contacted if there are issues related to payments of these invoices.
   */
  @identifiers(#[])
  invoiceRecipientContacts: InvoiceRecipientContact[];
}

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
  startDate?: utcDateTime;

  /**
   * The date when this spending limit is no longer in effect.
   */
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
 * A billing property.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not a subscription provisioned resource."
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
   * The address of the individual or organization that is responsible for the billing account.
   */
  @added(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  billingAccountSoldToAddress?: AddressDetails;

  /**
   * The address of the individual or organization that is responsible for the customer.
   */
  @added(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  customerSoldToAddress?: AddressDetails;

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
   * The market country of the end organization.
   */
  @added(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  market?: string;

  /**
   * A payment method.
   */
  @added(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  paymentMethod?: BillingPropertyPaymentMethod;

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
  subscriptionServiceUsageAddress?: AddressDetails;

  /**
   * The Azure workload type of the subscription.
   */
  @visibility(Lifecycle.Read)
  subscriptionWorkloadType?: SubscriptionWorkloadType;

  /**
   * The enrollment details for the subscription. Available for billing accounts with agreement type Enterprise Agreement.
   */
  enrollmentDetails?: SubscriptionEnrollmentDetails;

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

  /**
   * The current daily invoicing override term, if any.
   */
  @added(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  currentDailyInvoicingOverrideTerm?: DailyInvoicingOverrideTerm;

  /**
   * Other daily invoicing override terms that are not currently active.
   */
  @added(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  otherDailyInvoicingOverrideTerms?: DailyInvoicingOverrideTerm[];
}

/**
 * A payment method.
 */
@added(Versions.v2024_08_01_preview)
model BillingPropertyPaymentMethod {
  /**
   * The family of payment method.
   */
  @visibility(Lifecycle.Read)
  family?: PaymentMethodFamily;

  /**
   * The type of payment method.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * A daily invoicing override term.
 */
@added(Versions.v2024_08_01_preview)
model DailyInvoicingOverrideTerm {
  /**
   * Unique identifier of the daily invoicing override term.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Start date of daily invoicing override term in UTC.
   */
  startDate?: utcDateTime;

  /**
   * End date of daily invoicing override term in UTC.
   */
  endDate?: utcDateTime;

  /**
   * When true, product invoice policy is disabled. When false, product invoice policy is enabled.
   */
  isProductInvoicePolicyDisabled?: boolean;
}

/**
 * The suspension details for a subscription. This field is not available for Enterprise Agreement billing accounts.
 */
model BillingSubscriptionStatusDetails {
  /**
   * The suspension effective date for a subscription. This field is not available for Enterprise Agreement billing accounts.
   */
  @visibility(Lifecycle.Read)
  effectiveDate?: utcDateTime;

  /**
   * The suspension reason for a subscription. This field is not available for Enterprise Agreement billing accounts.
   */
  @visibility(Lifecycle.Read)
  reason?: SubscriptionStatusReason;
}

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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not a subscription provisioned resource."
model BillingRequestProperties {
  /**
   * Additional information for the billing request.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing documentation where additionalInformation is a bag by design."
  additionalInformation?: Record<string>;

  /**
   * The principal of the request reviewer. Will only be set if request is approved.
   */
  reviewedBy?: Principal;

  /**
   * The date and time when the request was reviewed.
   */
  @visibility(Lifecycle.Read)
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
  createdBy?: Principal;

  /**
   * The date and time when the request was created.
   */
  @visibility(Lifecycle.Read)
  creationDate?: utcDateTime;

  /**
   * The date and time when the request expires.
   */
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "Existing model naming. For back compat."
  type?: BillingRequestType;

  /**
   * The principal of the entity who last updated the request.
   */
  lastUpdatedBy?: Principal;

  /**
   * Date and time of last update.
   */
  @visibility(Lifecycle.Read)
  lastUpdatedDate?: utcDateTime;
}

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
 * The properties of the billing role assignment.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not a subscription provisioned resource."
model BillingRoleAssignmentProperties {
  /**
   * The date the role assignment was created.
   */
  @visibility(Lifecycle.Read)
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

  /**
   * The flag that indicates whether the role assignment is inherited from the parent scope. This is supported only for billing accounts with agreement type Enterprise Agreement.
   */
  @added(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  isInherited?: boolean;
}

/**
 * The properties of a role definition.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not a subscription provisioned resource."
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
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

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
  benefitStartTime?: utcDateTime;

  /**
   * DateTime when the savings plan will expire.
   */
  @visibility(Lifecycle.Read)
  expiryDateTime?: utcDateTime;

  /**
   * Information describing the type of billing plan for this savings plan.
   */
  planInformation?: BillingPlanInformation;

  /**
   * Identifiers of the savings plans associated with this order.
   */
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

  /**
   * List of transactions associated with this billing plan.
   */
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

  /**
   * The amount of money to be paid for the Order.
   */
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
model SavingsPlanModelListResult {
  ...SavingsPlanModelList;

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
  renew?: boolean = false;

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
  effectiveDateTime?: utcDateTime;

  /**
   * This is the DateTime when the savings plan benefit starts.
   */
  @visibility(Lifecycle.Read)
  benefitStartTime?: utcDateTime;

  /**
   * This is the date-time when the savings plan will expire.
   */
  @visibility(Lifecycle.Read)
  expiryDateTime?: utcDateTime;

  /**
   * Date time when the savings plan was purchased.
   */
  @visibility(Lifecycle.Read)
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
  renew?: boolean = false;

  /**
   * Properties specific to applied scope type. Not required if not applicable.
   */
  appliedScopeProperties?: AppliedScopeProperties;
}

/**
 * Commitment towards the benefit.
 */
model Commitment {
  ...Price;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing documentation where tags are in the model properties instead of the envelope. Back compat. Same type as TrackedResource.tags."
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
  renew?: boolean = false;

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
  /**
   * The benefits of a savings plan.
   */
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not a subscription provisioned resource."
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
   * The day of the month on which the subscription is billed.
   */
  @added(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  billingDay?: int32;

  /**
   * The first billing month of the subscription.
   */
  @added(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  firstBillingMonth?: int32;

  /**
   * The fully qualified ID that uniquely identifies a billing profile.
   */
  billingProfileId?: string;

  /**
   * Dictionary of billing policies associated with the subscription.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing documentation where billingPolicies is a bag by design."
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
   * The date when the subscription will be next invoiced.
   */
  @added(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  nextInvoiceDate?: utcDateTime;

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
   * The unique code that identifies the product.
   */
  @added(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  productCode?: string;

  /**
   * The duration in ISO8601 format for which you can use the subscription. Example: P1M, P3M, P1Y
   */
  termDuration?: string;

  /**
   * Start date of the term in UTC time.
   */
  @visibility(Lifecycle.Read)
  termStartDate?: utcDateTime;

  /**
   * End date of the term in UTC time.
   */
  @visibility(Lifecycle.Read)
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

  /**
   * The details of the product that was acquired for this subscription. This is promotion product used during purchase.
   */
  @added(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  acquiredProduct?: AcquiredProduct;

  /**
   * Scheduled actions for the billing subscription.
   */
  @added(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  scheduledActions?: ScheduledAction[];
}

/**
 * The details of the product that was acquired for a billing subscription.
 */
@added(Versions.v2024_08_01_preview)
model AcquiredProduct {
  /**
   * The unique code that identifies the product.
   */
  productCode?: string;
}

/**
 * A scheduled action on a billing subscription.
 */
@added(Versions.v2024_08_01_preview)
model ScheduledAction {
  /**
   * The type of scheduled action, for example NextTerm or AbsoluteDate.
   */
  type?: string;

  /**
   * The effective date of the scheduled action in UTC.
   */
  effectiveDate?: utcDateTime;

  /**
   * The product information for the scheduled action.
   */
  product?: ScheduledActionProduct;

  /**
   * The product code for the scheduled action.
   */
  productCode?: string;

  /**
   * The quantity associated with the scheduled action.
   */
  quantity?: int64;

  /**
   * The end date of the scheduled action in UTC.
   */
  endDate?: utcDateTime;

  /**
   * The operation type for the scheduled action, for example deactivate or update.
   */
  operation?: string;

  /**
   * The reason code for the scheduled action, for example customer_cancellation.
   */
  reasonCode?: string;
}

/**
 * Product information for a scheduled action.
 */
@added(Versions.v2024_08_01_preview)
model ScheduledActionProduct {
  /**
   * The product type ID in the scheduled action product.
   */
  productTypeId?: string;

  /**
   * The SKU ID in the scheduled action product.
   */
  skuId?: string;

  /**
   * The billing frequency in ISO8601 format, for example P1M or P12M.
   */
  billingFrequency?: string;

  /**
   * The term duration in ISO8601 format.
   */
  term?: string;

  /**
   * The acquired product details in the scheduled action product.
   */
  acquiredProduct?: AcquiredProduct;
}

/**
 * List of events related to a billing subscription.
 */
@added(Versions.v2024_08_01_preview)
model BillingSubscriptionEventList {
  /**
   * The events related to the billing subscription.
   */
  @identifiers(#[])
  value?: BillingSubscriptionEvent[];

  /**
   * The URL to use for getting the next set of results.
   */
  nextLink?: string;

  /**
   * The total number of events.
   */
  totalCount?: int32;
}

/**
 * History of events related to a billing subscription.
 */
@added(Versions.v2024_08_01_preview)
model BillingSubscriptionEvent {
  /**
   * Type of billing subscription event, for example conversion, quantityChange, renewal, or termExtension.
   */
  type?: string;

  /**
   * Date and time when the subscription event occurred.
   */
  date?: utcDateTime;

  /**
   * Subscription term details before the event for conversions and changes.
   */
  fromTermDetails?: BillingSubscriptionEventTermDetails;

  /**
   * Subscription term details after the event for conversions and changes.
   */
  toTermDetails?: BillingSubscriptionEventTermDetails;

  /**
   * Subscription product details before the event for conversions and changes.
   */
  fromProductDetails?: BillingSubscriptionEventProductDetails;

  /**
   * Subscription product details after the event for conversions and changes.
   */
  toProductDetails?: BillingSubscriptionEventProductDetails;

  /**
   * The quantity of licenses or fulfillment units for the subscription.
   */
  quantity?: int64;
}

/**
 * Subscription term details for a billing subscription event.
 */
@added(Versions.v2024_08_01_preview)
model BillingSubscriptionEventTermDetails {
  /**
   * Start date of the term in UTC time.
   */
  startDate?: utcDateTime;

  /**
   * End date of the term in UTC time.
   */
  endDate?: utcDateTime;

  /**
   * Product term duration, for example P1Y for one year or P1M for one month.
   */
  termDuration?: string;
}

/**
 * Product details for a billing subscription event.
 */
@added(Versions.v2024_08_01_preview)
model BillingSubscriptionEventProductDetails {
  /**
   * Type of the product.
   */
  productTypeId?: string;

  /**
   * The SKU ID of the product for which the subscription is purchased. This field is is only available  for Microsoft Customer Agreement billing accounts.
   */
  skuId?: string;

  /**
   * The unique code that identifies the product and represents UPN.
   */
  productCode?: string;
}

/**
 * The status of invoice payment eligibility.
 */
@added(Versions.v2024_08_01_preview)
union InvoicePayEligibilityStatus {
  string,

  /**
   * The Pending invoice payment eligibility status.
   */
  Pending: "Pending",

  /**
   * The Approved invoice payment eligibility status.
   */
  Approved: "Approved",

  /**
   * The Rejected invoice payment eligibility status.
   */
  Rejected: "Rejected",
}

/**
 * The reason for the invoice payment eligibility status.
 */
@added(Versions.v2024_08_01_preview)
union InvoicePayEligibilityReason {
  string,

  /**
   * No eligibility reason is specified.
   */
  None: "None",

  /**
   * The invoice payment eligibility is under review.
   */
  InReview: "InReview",

  /**
   * The account type is not eligible.
   */
  AccountTypeInvalid: "AccountTypeInvalid",

  /**
   * The payment history is insufficient.
   */
  InsufficientPaymentHistory: "InsufficientPaymentHistory",

  /**
   * The spending history is insufficient.
   */
  InsufficientSpendingHistory: "InsufficientSpendingHistory",

  /**
   * The country is not supported.
   */
  CountryNotSupported: "CountryNotSupported",

  /**
   * There is an outstanding balance.
   */
  OutstandingBalance: "OutstandingBalance",

  /**
   * The eligibility decision is based on the credit response.
   */
  CreditResponse: "CreditResponse",
}

/**
 * The result of the invoice payment eligibility validation.
 */
@added(Versions.v2024_08_01_preview)
model InvoicePayEligibilityResult {
  /**
   * The status of the invoice payment eligibility.
   */
  @visibility(Lifecycle.Read)
  status?: InvoicePayEligibilityStatus;

  /**
   * The reason for the invoice payment eligibility status.
   */
  @visibility(Lifecycle.Read)
  reason?: InvoicePayEligibilityReason;
}

/**
 * The request details for a pay now operation.
 */
@added(Versions.v2024_08_01_preview)
model InvoicePaynowRequest {
  /**
   * The amount to be paid for the invoice.
   */
  amount?: float32;

  /**
   * The payment method to be used for the payment.
   */
  paymentMethodName?: string;
}

/**
 * The payment method eligibility for the Pay Now feature.
 */
@added(Versions.v2024_08_01_preview)
model PaymentMethodEligibility {
  /**
   * The family of the payment method for the Pay Now feature eligibility.
   */
  family?: PaymentMethodFamily;

  /**
   * The type of the payment method for the Pay Now feature eligibility.
   */
  type?: string;

  /**
   * The status of the payment method for the Pay Now feature eligibility.
   */
  isEligible?: boolean;

  /**
   * Indicates the reason for the ineligibility of the payment method for the Pay Now feature.
   */
  reasonCode?: PaynowEligibilityReasonCode;
}

/**
 * The reason code for Pay Now feature eligibility.
 */
@added(Versions.v2024_08_01_preview)
union PaynowEligibilityReasonCode {
  string,

  /**
   * The Pay Now eligibility reason is unspecified.
   */
  Other: "Other",

  /**
   * The invoice is not eligible for Pay Now.
   */
  NotEligible: "NotEligible",

  /**
   * The Pay Now limit has been exceeded.
   */
  PayNowLimitExceeded: "PayNowLimitExceeded",

  /**
   * The caller has insufficient permissions.
   */
  InsufficientPermissions: "InsufficientPermissions",

  /**
   * The invoice has a duplicate payment.
   */
  DuplicatePayment: "DuplicatePayment",

  /**
   * The invoice was not found.
   */
  InvoiceNotFound: "InvoiceNotFound",

  /**
   * The payment amount is invalid.
   */
  InvalidAmount: "InvalidAmount",

  /**
   * The billing account is invalid.
   */
  InvalidAccount: "InvalidAccount",
}

/**
 * Result of the Pay Now feature eligibility.
 */
@added(Versions.v2024_08_01_preview)
model PaynowEligibilityResult {
  /**
   * Indicates the reason for the ineligibility of the Pay Now feature.
   */
  reasonCode?: PaynowEligibilityReasonCode;

  /**
   * The payment methods for the Pay Now feature eligibility.
   */
  @identifiers(#[])
  paymentMethods?: PaymentMethodEligibility[];
}

/**
 * The properties of a license reservation.
 */
@added(Versions.v2024_08_01_preview)
model LicenseReservationProperties {
  /**
   * The provisioning state of the resource during a long-running operation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The line items (or licenses) that are reserved.
   */
  @identifiers(#[])
  lineItems: LicenseReservationLineItem[];

  /**
   * The date from which the license would be used.
   */
  termStartDate: utcDateTime;

  /**
   * The status of the license reservation.
   */
  @visibility(Lifecycle.Read)
  status?: ReservationStatus;

  /**
   * Name of the entity that created the license reservation.
   */
  @visibility(Lifecycle.Read)
  reservedBy?: string;

  /**
   * System imposed policies that regulate behavior of the license reservation.
   */
  systemOverrides?: ReservationSystemOverrides;
}

/**
 * A container for a list of license reservations.
 */
@added(Versions.v2024_08_01_preview)
model LicenseReservationListResult is Azure.Core.Page<LicenseReservation>;

/**
 * Request parameters for canceling a license reservation.
 */
@added(Versions.v2024_08_01_preview)
model CancelLicenseReservationRequest {
  /**
   * Cancellation reason.
   */
  cancellationReason?: string;
}

/**
 * A license reservation line item (or license).
 */
@added(Versions.v2024_08_01_preview)
model LicenseReservationLineItem {
  /**
   * The SKU ID of the license to reserve.
   */
  @minLength(1)
  skuId: string;

  /**
   * The description of the SKU.
   */
  skuDescription?: string;

  /**
   * The number of licenses reserved.
   */
  quantity: int32;

  /**
   * The country where the licenses are used.
   */
  @minLength(1)
  usageCountry: string;
}

/**
 * The status of the license reservation.
 */
@added(Versions.v2024_08_01_preview)
union ReservationStatus {
  string,

  /**
   * The reservation is active.
   */
  Active: "Active",

  /**
   * The reservation is pending.
   */
  Pending: "Pending",

  /**
   * Cancellation of the reservation is pending.
   */
  CancelPending: "CancelPending",

  /**
   * The reservation is cancelled.
   */
  Cancelled: "Cancelled",

  /**
   * The reservation request has been received.
   */
  RequestReceived: "RequestReceived",

  /**
   * The reservation is held.
   */
  Held: "Held",

  /**
   * The reservation is reconciled.
   */
  Reconciled: "Reconciled",

  /**
   * The reservation failed.
   */
  Failed: "Failed",
}

/**
 * System imposed policies that regulate behavior of the license reservation.
 */
@added(Versions.v2024_08_01_preview)
model ReservationSystemOverrides {
  /**
   * The last date by which the license reservation can be canceled.
   */
  @visibility(Lifecycle.Read)
  cancellationAllowedEndDate?: utcDateTime;
}

/**
 * The properties of the cancellation of partner change request.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not a subscription provisioned resource."
@added(Versions.v2024_08_01_preview)
model PartnerChangeRequestCancellationProperties {
  /**
   * The description of the reason for cancellation.
   */
  @visibility(Lifecycle.Read)
  cancellationReason?: string;

  /**
   * The email ID of the user who canceled the partner change request.
   */
  @pattern(EmailAddressPattern)
  @visibility(Lifecycle.Read)
  canceledBy?: string;

  /**
   * The partner change request status.
   */
  @visibility(Lifecycle.Read)
  requestStatus?: RequestStatus;
}

/**
 * The request parameters for cancellation of partner change request.
 */
@added(Versions.v2024_08_01_preview)
model PartnerChangeCancelRequest {
  /**
   * Request parameters to partner change cancel request.
   */
  properties?: PartnerChangeCancelRequestProperties;
}

/**
 * The properties for cancelling a partner change request.
 */
@added(Versions.v2024_08_01_preview)
model PartnerChangeCancelRequestProperties {
  /**
   * The description of the reason for cancellation.
   */
  @minLength(1)
  cancellationReason: string;
}

/**
 * The details of the partner change request for initiate operations.
 */
@added(Versions.v2024_08_01_preview)
model PartnerChangeRequestInitiateResponse
  is Azure.ResourceManager.ProxyResource<PartnerChangeRequestInitiateResponseProperties> {
  ...ResourceNameParameter<Resource = PartnerChangeRequestInitiateResponseProperties>;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  tags?: Record<string>;
}

/**
 * The list of the partner change requests initiated by the initiator.
 */
@added(Versions.v2024_08_01_preview)
model PartnerChangeRequestListResult
  is Azure.Core.Page<PartnerChangeRequestGetDetails>;

@@doc(
  PartnerChangeRequestListResult.value,
  "The details of the partner change requests initiated by the initiator."
);
@@doc(
  PartnerChangeRequestListResult.nextLink,
  "The link (url) to the next page of results."
);

/**
 * The properties of the partner change request for GET operations.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not a subscription provisioned resource."
@added(Versions.v2024_08_01_preview)
model PartnerChangeRequestGetDetailsProperties {
  ...PartnerChangeRequestBaseProperties;

  /**
   * The email ID of the user who canceled the partner change request.
   */
  @pattern(EmailAddressPattern)
  @visibility(Lifecycle.Read)
  canceledBy?: string;

  /**
   * The partner change request package ID.
   */
  @visibility(Lifecycle.Read)
  partnerChangePackageId?: string;
}

/**
 * A secure URL that can be used to download an entity until the URL expires.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not a subscription provisioned resource."
@added(Versions.v2024_08_01_preview)
model PartnerChangeDocumentDownloadResultProperties {
  /**
   * The URL to the PDF or .zip file.
   */
  @secret
  @visibility(Lifecycle.Read)
  url?: string;

  /**
   * The time in UTC when the download URL will expire.
   */
  @visibility(Lifecycle.Read)
  expiryTime?: utcDateTime;
}

/**
 * The partner change request status.
 */
@added(Versions.v2024_08_01_preview)
union RequestStatus {
  string,

  /**
   * The partner change request is currently in progress.
   */
  InProgress: "InProgress",

  /**
   * The partner change request is pending Microsoft review.
   */
  PendingMSReview: "PendingMSReview",

  /**
   * The partner change request is in grace period. Grace period : When a customer switches to a new channel partner, there is a grace period during which the new partner cannot access the customer's agreement, and the old partner remains the official partner on record. Once the grace period ends, the new partner gains access to the customer's agreement, and the old partner loses access.
   */
  InGracePeriod: "InGracePeriod",

  /**
   * The partner change request has been completed successfully.
   */
  Complete: "Complete",

  /**
   * The partner change request was declined by the partner.
   */
  DeclinedByPartner: "DeclinedByPartner",

  /**
   * The partner change request was rejected by Microsoft.
   */
  RejectedByMS: "RejectedByMS",

  /**
   * The partner change request has been canceled.
   */
  Canceled: "Canceled",

  /**
   * The partner change request has failed.
   */
  Failed: "Failed",

  /**
   * The partner change request has expired.
   */
  Expired: "Expired",

  /**
   * The partner change request cancellation is in progress.
   */
  CancellationInProgress: "CancellationInProgress",
}

/**
 * The type of partner.
 */
@added(Versions.v2024_08_01_preview)
union PartnerType {
  string,

  /**
   * The partner acts as a reseller
   */
  Reseller: "Reseller",

  /**
   * The partner acts as a software advisor
   */
  SoftwareAdvisor: "SoftwareAdvisor",
}

/**
 * The reason code for the partner change request.
 */
@added(Versions.v2024_08_01_preview)
union PartnerChangeReasonCode {
  string,

  /**
   * The current partner's service quality did not meet expectations.
   */
  UnsatisfactoryService: "UnsatisfactoryService",

  /**
   * The current partner has been off-boarded by Microsoft.
   */
  PartnerOffBoarded: "PartnerOffBoarded",

  /**
   * Other business reasons for changing the partner.
   */
  Other: "Other",
}

/**
 * Partner change request error response properties.
 */
@added(Versions.v2024_08_01_preview)
model PartnerChangeRequestErrorProperties {
  /**
   * Any validation results that occurred during the operation.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  validationResults?: ValidationResultProperties[];
}

/**
 * The request parameters for initiating a partner change request.
 */
@added(Versions.v2024_08_01_preview)
model PartnerChangeInitiateRequest {
  /**
   * Request parameters to initiate partner change request.
   */
  properties?: PartnerChangeInitiateRequestProperties;
}

/**
 * The properties of the partner change request for initiate operation.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not a subscription provisioned resource."
@added(Versions.v2024_08_01_preview)
model PartnerChangeRequestInitiateResponseProperties {
  ...PartnerChangeRequestBaseProperties;

  /**
   * Validation results from the partner change request initiation.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  validationResults?: ValidationResultProperties[];
}

/**
 * The base properties of the partner change request.
 */
@added(Versions.v2024_08_01_preview)
model PartnerChangeRequestBaseProperties {
  /**
   * The type of partner.
   */
  @visibility(Lifecycle.Read)
  partnerType?: PartnerType;

  /**
   * The time at which the partner change request expires in UTC.
   */
  @encodedName("application/json", "expirationTimeUTC")
  @visibility(Lifecycle.Read)
  expirationTimeUtc?: utcDateTime;

  /**
   * The status of the partner change request.
   */
  @visibility(Lifecycle.Read)
  requestStatus?: RequestStatus;

  /**
   * The email ID of the user to whom the partner change request was sent.
   */
  @pattern(EmailAddressPattern)
  @visibility(Lifecycle.Read)
  recipientEmailId?: string;

  /**
   * The email ID of the user who initiated the partner change request.
   */
  @pattern(EmailAddressPattern)
  @visibility(Lifecycle.Read)
  initiatorEmailId?: string;

  /**
   * The first name of the initiator.
   */
  @visibility(Lifecycle.Read)
  initiatorFirstName?: string;

  /**
   * The last name of the initiator.
   */
  @visibility(Lifecycle.Read)
  initiatorLastName?: string;

  /**
   * The date and time when the partner change request was initiated, in UTC.
   */
  @encodedName("application/json", "initiatedOnUTC")
  @visibility(Lifecycle.Read)
  initiatedOnUtc?: utcDateTime;

  /**
   * The effective date when the partner change will take effect, in UTC.
   */
  @encodedName("application/json", "effectiveDateUTC")
  @visibility(Lifecycle.Read)
  effectiveDateUtc?: utcDateTime;

  /**
   * The primary contact email ID of the partner.
   */
  @pattern(EmailAddressPattern)
  @visibility(Lifecycle.Read)
  partnerPrimaryContactEmailId?: string;

  /**
   * The public customer number of the source partner organization.
   */
  @visibility(Lifecycle.Read)
  sourcePartnerOrganizationPcn?: string;

  /**
   * The name of the source partner organization.
   */
  @visibility(Lifecycle.Read)
  sourcePartnerOrganizationName?: string;

  /**
   * The public customer number of the target partner organization.
   */
  @visibility(Lifecycle.Read)
  targetPartnerOrganizationPcn?: string;

  /**
   * The name of the target partner organization.
   */
  @visibility(Lifecycle.Read)
  targetPartnerOrganizationName?: string;

  /**
   * The public customer number of the customer organization.
   */
  @visibility(Lifecycle.Read)
  customerOrganizationPcn?: string;

  /**
   * The name of the customer organization.
   */
  @visibility(Lifecycle.Read)
  customerOrganizationName?: string;

  /**
   * The reason code for the partner change request.
   */
  @visibility(Lifecycle.Read)
  partnerChangeReasonCode?: PartnerChangeReasonCode;

  /**
   * The reason for the partner change request.
   */
  @visibility(Lifecycle.Read)
  partnerChangeReason?: string;
}

/**
 * The properties for initiating a partner change request.
 */
@added(Versions.v2024_08_01_preview)
model PartnerChangeInitiateRequestProperties {
  /**
   * The email ID of the user to whom the partner change request will be sent.
   */
  @pattern(EmailAddressPattern)
  recipientEmailId?: string;

  /**
   * The effective date of the partner change request in UTC.
   */
  @encodedName("application/json", "effectiveDateUTC")
  effectiveDateUtc?: utcDateTime;

  /**
   * The public customer number of the target partner organization.
   */
  targetPartnerOrganizationPcn?: string;

  /**
   * The reason code for the partner change request.
   */
  partnerChangeReasonCode?: PartnerChangeReasonCode;

  /**
   * The reason for the partner change request.
   */
  partnerChangeReason?: string;

  /**
   * The first name of the initiator.
   */
  initiatorFirstName?: string;

  /**
   * The last name of the initiator.
   */
  initiatorLastName?: string;
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
  termEndDate?: utcDateTime;

  /**
   * The unique code that identifies the product and represents UPN.
   */
  @added(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  productCode?: string;
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
  cancellationAllowedEndDate?: utcDateTime;
}

/**
 * A billing subscription alias.
 */
model BillingSubscriptionAliasProperties {
  ...BillingSubscriptionProperties;

  /**
   * The ID of the billing subscription with the subscription alias.
   */
  @visibility(Lifecycle.Read)
  billingSubscriptionId?: string;

  /**
   * The provisioning state of the resource during a long-running operation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
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
 * A partner's customer.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not a subscription provisioned resource."
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "Existing documentation where tags are in the model properties instead of the envelope. Back compat. Same type as TrackedResource.tags."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing documentation where tags are in the model properties instead of the envelope. Back compat. Same type as TrackedResource.tags."
  tags?: Record<string>;
}

/**
 * Optional grouping of enrollment accounts to segment costs into logical groupings and set budgets.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not a subscription provisioned resource."
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
   * The name of the department.
   */
  @added(Versions.v2024_08_01_preview)
  departmentName?: string;

  /**
   * The spending budget of the department.
   */
  @added(Versions.v2024_08_01_preview)
  spendingQuota?: string;

  /**
   * The ID that uniquely identifies the department.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "Existing documentation where id is also in properties. For back compat."
  @visibility(Lifecycle.Read)
  @removed(Versions.v2024_08_01_preview)
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not a subscription provisioned resource."
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
  startDate?: utcDateTime;

  /**
   * The date of expiration of the enrollment account.
   */
  @visibility(Lifecycle.Read)
  endDate?: utcDateTime;

  /**
   * The offer types associated with the enrollment account.
   */
  @added(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  offerTypes?: string[];

  /**
   * Details of the owner of the enrollment account.
   */
  @added(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  ownerDetails?: EnrollmentAccountOwnerDetails;
}

/**
 * Details of an enrollment account owner.
 */
@added(Versions.v2024_08_01_preview)
model EnrollmentAccountOwnerDetails {
  /**
   * The email address of the enrollment account owner.
   */
  email?: string;

  /**
   * The tenant ID of the enrollment account owner.
   */
  tenantId?: string;

  /**
   * The object ID of the enrollment account owner.
   */
  objectId?: string;
}

/**
 * An invoice.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not a subscription provisioned resource."
model InvoiceProperties {
  /**
   * The amount due as of now.
   */
  amountDue?: Amount;

  /**
   * The amount of Azure prepayment applied to the charges. This field is applicable to billing accounts with agreement type Microsoft Customer Agreement.
   */
  azurePrepaymentApplied?: Amount;

  /**
   * The total charges for the invoice billing period.
   */
  billedAmount?: Amount;

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
  creditAmount?: Amount;

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
  freeAzureCreditApplied?: Amount;

  /**
   * The date when the invoice was generated.
   */
  @visibility(Lifecycle.Read)
  invoiceDate?: utcDateTime;

  /**
   * The end date of the billing period for which the invoice is generated. The date is in MM-DD-YYYY format.
   */
  @visibility(Lifecycle.Read)
  invoicePeriodEndDate?: utcDateTime;

  /**
   * The start date of the billing period for which the invoice is generated. The date is in MM-DD-YYYY format.
   */
  @visibility(Lifecycle.Read)
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
  rebillDetails?: RebillDetails;

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
  subTotal?: Amount;

  /**
   * The amount of tax charged for the billing period. This field is applicable to billing accounts with agreement type Microsoft Customer Agreement.
   */
  taxAmount?: Amount;

  /**
   * The amount due when the invoice was generated. This field is applicable to billing accounts with agreement type Microsoft Customer Agreement.
   */
  totalAmount?: Amount;

  /**
   * The details of a refund request.
   */
  refundDetails?: RefundDetailsSummary;
}

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
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Name kept for backward compatibility"
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
  date?: utcDateTime;

  /**
   * The reason that the payment failed.
   */
  @visibility(Lifecycle.Read)
  failedPaymentReason?: FailedPaymentReason;
}

/**
 * An invoice payment.
 */
model Payment {
  /**
   * The paid amount.
   */
  amount?: Amount;

  /**
   * The date when the payment was made.
   */
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "Existing documentation where rebillDetails is in a type called RebillDetails. Back compat."
  @visibility(Lifecycle.Read)
  rebillDetails?: RebillDetails;
}

/**
 * The details of refund request.
 */
model RefundDetailsSummary {
  /**
   * Date when the refund was requested.
   */
  @visibility(Lifecycle.Read)
  requestedOn?: utcDateTime;

  /**
   * Date when the refund was approved.
   */
  @visibility(Lifecycle.Read)
  approvedOn?: utcDateTime;

  /**
   * Date when the refund was completed.
   */
  @visibility(Lifecycle.Read)
  completedOn?: utcDateTime;

  /**
   * The amount of refund requested.
   */
  amountRequested?: Amount;

  /**
   * The amount refunded.
   */
  amountRefunded?: Amount;

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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not a subscription provisioned resource."
model InvoiceSectionProperties {
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "Existing documentation where tags are in the model properties instead of the envelope. Back compat. Same type as TrackedResource.tags."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing documentation where tags are in the model properties instead of the envelope. Back compat. Same type as TrackedResource.tags."
  tags?: Record<string>;
}

/**
 * The properties of a payment method link.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not a subscription provisioned resource."
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

  /**
   * The address of the payment instrument.
   */
  @added(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  address?: AddressDetails;

  /**
   * The name of bank where the account is held. This is only supported for payment methods with family DirectDebit.
   */
  @added(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  bankName?: string;

  /**
   * The friendly ID of the billing profile.
   */
  @added(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  billingProfileId?: string;

  /**
   * The display name of the billing profile.
   */
  @added(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  billingProfileDisplayName?: string;
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not a subscription provisioned resource."
model PaymentMethodProperties {
  /**
   * Id of payment method.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "Existing documentation where id is also in properties. For back compat."
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

  /**
   * The address of the payment instrument.
   */
  @added(Versions.v2024_08_01_preview)
  address?: AddressDetails;

  /**
   * The name of bank where the account is held. This is only supported for payment methods with family DirectDebit.
   */
  @added(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  bankName?: string;
}

/**
 * A policy at customer scope.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not a subscription provisioned resource."
model CustomerPolicyProperties {
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not a subscription provisioned resource."
model BillingProfilePolicyProperties {
  /**
   * The policies for Enterprise Agreement enrollments.
   */
  enterpriseAgreementPolicies?: EnterpriseAgreementPolicies;

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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not a subscription provisioned resource."
model BillingAccountPolicyProperties {
  /**
   * The policies for Enterprise Agreement enrollments.
   */
  enterpriseAgreementPolicies?: EnterpriseAgreementPolicies;

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
 * A policy at subscription scope.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not a subscription provisioned resource."
model SubscriptionPolicyProperties {
  /**
   * List of all policies defined at the billing scope.
   */
  @identifiers(#["name"])
  policies?: PolicySummary[];
}

/**
 * A product.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not a subscription provisioned resource."
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
  lastCharge?: Amount;

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
  reseller?: Reseller;
}

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
  errorDetails?: MoveProductErrorDetails;
}

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
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The effective date time of the reservation
   */
  @visibility(Lifecycle.Read)
  effectiveDateTime?: utcDateTime;

  /**
   * This is the DateTime when the reservation benefit started.
   */
  benefitStartTime?: utcDateTime;

  /**
   * DateTime of the last time the reservation was updated.
   */
  @visibility(Lifecycle.Read)
  lastUpdatedDateTime?: utcDateTime;

  /**
   * The expiry date of the reservation
   */
  @visibility(Lifecycle.Read)
  expiryDate?: string;

  /**
   * This is the date-time when the reservation will expire.
   */
  expiryDateTime?: utcDateTime;

  /**
   * This is the date-time when the Azure Hybrid Benefit needs to be reviewed.
   */
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
  /**
   * The name of the sku
   */
  name?: string;
}

/**
 * Properties of reservation purchase request
 */
model ReservationPurchaseRequestProperties {
  /**
   * The reserved resource type of the reservation, e.g. virtual machine.
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
  renew?: boolean = false;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "Existing documentation where tags are in the model properties instead of the envelope. Back compat. Same type as TrackedResource.tags."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing documentation where tags are in the model properties instead of the envelope. Back compat. Same type as TrackedResource.tags."
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
  renew?: boolean = false;

  /**
   * Properties for reservation renew
   */
  renewProperties?: PatchPropertiesRenewProperties;

  /**
   * This is the date-time when the Azure hybrid benefit needs to be reviewed.
   */
  reviewDateTime?: utcDateTime;
}

/**
 * Properties for reservation renew
 */
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
  requestDateTime?: utcDateTime;

  /**
   * This is the DateTime when the reservation order was created.
   */
  createdDateTime?: utcDateTime;

  /**
   * This is the date when the reservation order will expire.
   */
  expiryDate?: plainDate;

  /**
   * This is the date-time when the reservation order will expire.
   */
  expiryDateTime?: utcDateTime;

  /**
   * This is the DateTime when the reservation benefit started.
   */
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
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Represent the billing plans.
   */
  billingPlan?: ReservationBillingPlan;

  /**
   * Information describing the type of billing plan for this reservation order.
   */
  planInformation?: ReservationOrderBillingPlanInformation;

  /**
   * List of transactions associated with the reservation order.
   */
  reservations?: Reservation[];

  /**
   * This is the date-time when the Azure Hybrid Benefit needs to be reviewed.
   */
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

  /**
   * List of transactions associated with the billing plan.
   */
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
model Transaction
  is Azure.ResourceManager.ProxyResource<TransactionProperties> {
  ...ResourceNameParameter<
    Resource = Transaction,
    KeyName = "transactionName",
    SegmentName = "transactions"
  >;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  tags?: Record<string>;
}

/**
 * A transaction.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not a subscription provisioned resource."
model TransactionProperties {
  /**
   * The amount of any Azure credits automatically applied to this transaction.
   */
  azureCreditApplied?: Amount;

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
  billingProfileDisplayName?: string;

  /**
   * The fully qualified ID that uniquely identifies a billing profile.
   */
  billingProfileId?: string;

  /**
   * The amount of Microsoft Azure Consumption Commitment(MACC) decrement through the transaction.
   */
  consumptionCommitmentDecremented?: Amount;

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
  date?: utcDateTime;

  /**
   * The percentage discount, if any, applied to this transaction.
   */
  discount?: float32;

  /**
   * The price of the product after applying any discounts.
   */
  effectivePrice?: Amount;

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
  marketPrice?: Amount;

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
  servicePeriodStartDate?: utcDateTime;

  /**
   * The end date of the product term, or the end date of the month in which usage ended.
   */
  servicePeriodEndDate?: utcDateTime;

  /**
   * The pre-tax charged amount for the transaction.
   */
  subTotal?: Amount;

  /**
   * The tax amount applied to the transaction.
   */
  tax?: Amount;

  /**
   * The charge associated with the transaction.
   */
  transactionAmount?: Amount;

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
  refundTransactionDetails?: RefundTransactionDetails;
}

/**
 * The refund details of a transaction.
 */
model RefundTransactionDetails {
  /**
   * The amount of refund requested.
   */
  amountRequested?: Amount;

  /**
   * The amount refunded.
   */
  amountRefunded?: Amount;

  /**
   * The ID of refund operation.
   */
  refundOperationId?: string;
}

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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not a subscription provisioned resource."
model TransferProperties {
  /**
   * The time at which the transfer request expires.
   */
  @visibility(Lifecycle.Read)
  expirationTime?: utcDateTime;

  /**
   * Overall transfer status.
   */
  @visibility(Lifecycle.Read)
  transferStatus?: TransferStatus;

  /**
   * The email ID of the user to whom the transfer request was sent.
   */
  @removed(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  recipientEmailId?: string;

  /**
   * The email ID of the user who sent the transfer request.
   */
  @removed(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  initiatorEmailId?: string;

  /**
   * The tenant ID of the user to whom the transfer request was sent.
   */
  @added(Versions.v2024_08_01_preview)
  recipientTenantId?: string;

  /**
   * The email or object ID of the user to whom the transfer request was sent.
   */
  @added(Versions.v2024_08_01_preview)
  recipientUserId?: string;

  /**
   * The tenant ID of the user who sent the transfer request.
   */
  @added(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  initiatorTenantId?: string;

  /**
   * The email or object ID of the user who sent the transfer request.
   */
  @added(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  initiatorUserId?: string;

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
  @removed(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  productName?: string;

  /**
   * The SKU of the product that is transferred.
   */
  @removed(Versions.v2024_08_01_preview)
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
  @renamedFrom(Versions.v2024_08_01_preview, "code")
  @visibility(Lifecycle.Read)
  errorCode?: string;

  /**
   * Error message.
   */
  @renamedFrom(Versions.v2024_08_01_preview, "message")
  @visibility(Lifecycle.Read)
  errorMessage?: string;
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not a subscription provisioned resource."
model PartnerTransferProperties {
  /**
   * The time at which the transfer request expires.
   */
  @visibility(Lifecycle.Read)
  expirationTime?: utcDateTime;

  /**
   * Overall transfer status.
   */
  @visibility(Lifecycle.Read)
  transferStatus?: TransferStatus;

  /**
   * The email ID of the user to whom the transfer request was sent.
   */
  @removed(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  recipientEmailId?: string;

  /**
   * The type of customer who sent the transfer request.
   */
  @removed(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  initiatorCustomerType?: InitiatorCustomerType;

  /**
   * The email ID of the user who sent the transfer request.
   */
  @removed(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  initiatorEmailId?: string;

  /**
   * The tenant ID of the user to whom the transfer request was sent.
   */
  @added(Versions.v2024_08_01_preview)
  recipientTenantId?: string;

  /**
   * The email or object ID of the user to whom the transfer request was sent.
   */
  @added(Versions.v2024_08_01_preview)
  recipientUserId?: string;

  /**
   * The tenant ID of the user who sent the transfer request.
   */
  @added(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  initiatorTenantId?: string;

  /**
   * The email or object ID of the user who sent the transfer request.
   */
  @added(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  initiatorUserId?: string;

  // This property is still in 2024-04-01 and 2024-08-01-preview and beyond, and is called resellerId in all cases, but we made it writeable in 2024-08-01-preview.
  /**
   * Optional MPN ID of the reseller for transfer requests that are sent from a Microsoft Partner Agreement billing account.
   */
  @removed(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  @renamedFrom(Versions.v2024_08_01_preview, "resellerId")
  oldResellerId?: string;

  /**
   * Optional MPN ID of the reseller for transfer requests that are sent from a Microsoft Partner Agreement billing account.
   */
  @added(Versions.v2024_08_01_preview)
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
  @removed(Versions.v2024_08_01_preview)
  recipientEmailId?: string;

  /**
   * The tenant ID of the recipient to whom the transfer request is sent.
   */
  @added(Versions.v2024_08_01_preview)
  recipientTenantId?: string;

  /**
   * The email or object ID of the user to whom the transfer request is sent.
   */
  @added(Versions.v2024_08_01_preview)
  recipientUserId?: string;

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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not a subscription provisioned resource."
model RecipientTransferProperties {
  /**
   * The time at which the transfer request expires.
   */
  @visibility(Lifecycle.Read)
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
  @removed(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  recipientEmailId?: string;

  /**
   * The email ID of the user who sent the transfer request.
   */
  @removed(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  initiatorEmailId?: string;

  /**
   * The tenant ID of the user to whom the transfer request was sent.
   */
  @added(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  recipientTenantId?: string;

  /**
   * The email or object ID of the user to whom the transfer request was sent.
   */
  @added(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  recipientUserId?: string;

  /**
   * The tenant ID of the user who sent the transfer request.
   */
  @added(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  initiatorTenantId?: string;

  /**
   * The email or object ID of the user who sent the transfer request.
   */
  @added(Versions.v2024_08_01_preview)
  @visibility(Lifecycle.Read)
  initiatorUserId?: string;

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
@added(Versions.v2024_08_01_preview)
model TransferItemQueryParameter {
  /**
   * State of the transfer request query filter.
   */
  state?: string;
}

/**
 * The list transfer supported accounts operation response.
 */
@added(Versions.v2024_08_01_preview)
model SupportedAccountsDetails {
  /**
   * The resource ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The resource name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The list of transfer supported accounts for the customer.
   */
  value: SupportedAccountType[];
}

/**
 * The list transfer supported accounts operation response.
 */
@added(Versions.v2024_08_01_preview)
model SupportedAccountsDetailsListResult
  is Azure.Core.Page<SupportedAccountsDetails>;

/**
 * The purchase order.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Purchase orders do not expose a provisioning state."
@added(Versions.v2024_08_01_preview)
model PurchaseOrderProperties {
  /**
   * Identifies the status of purchase order.
   */
  status: PurchaseOrderStatus;

  /**
   * The description of the purchase order.
   */
  description?: string;

  /**
   * The date when the purchase order was created.
   */
  @visibility(Lifecycle.Read)
  creationDate?: utcDateTime;

  /**
   * The date when the purchase order becomes effective.
   */
  effectiveDate: utcDateTime;

  /**
   * The date when the purchase order expires.
   */
  expirationDate: utcDateTime;

  /**
   * The allocated budget amount for the purchase order.
   */
  allocatedBudget?: float32;

  /**
   * Indicates whether the purchase order (PO) number has been assigned to a charge.
   */
  @visibility(Lifecycle.Read)
  isPoUtilized?: boolean;
}

/**
 * Identifies the status of a purchase order.
 */
@added(Versions.v2024_08_01_preview)
union PurchaseOrderStatus {
  string,

  /**
   * The purchase order is active.
   */
  Active: "active",

  /**
   * The purchase order is inactive.
   */
  Inactive: "inactive",
}

/**
 * A purchase order mapping that associates specific products to a purchase order.
 */
@added(Versions.v2024_08_01_preview)
model PurchaseOrderMappingBase {
  /**
   * The fully qualified ID that uniquely identifies a purchase order.
   */
  @minLength(1)
  purchaseOrderId: string;

  /**
   * A description of the purchase order mapping.
   */
  description?: string;

  /**
   * The title or name of the product associated with this mapping.
   */
  @visibility(Lifecycle.Read)
  productTitle?: string;

  /**
   * The offer identifier of the product associated with this mapping.
   */
  @minLength(1)
  offerId: string;

  /**
   * The publisher identifier of the product associated with this mapping.
   */
  @minLength(1)
  publisherId: string;

  /**
   * The product identifier associated with this mapping.
   */
  productId?: string;

  /**
   * The unique code of the product associated with this mapping.
   */
  productCode?: string;

  /**
   * The date when the purchase order mapping becomes effective.
   */
  effectiveDate: utcDateTime;

  /**
   * The date when the purchase order mapping expires.
   */
  expirationDate: utcDateTime;

  /**
   * The status of the purchase order mapping.
   */
  status: POMappingStatus;
}

/**
 * A purchase order mapping that associates specific products to a purchase order.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Purchase order mappings do not expose a provisioning state."
@added(Versions.v2024_08_01_preview)
model PurchaseOrderMappingProperties {
  ...PurchaseOrderMappingBase;

  /**
   * The date when the purchase order mapping was created.
   */
  @visibility(Lifecycle.Read)
  creationDate?: utcDateTime;

  /**
   * The date when the purchase order mapping was last updated.
   */
  @visibility(Lifecycle.Read)
  updatedDate?: utcDateTime;

  /**
   * Indicates whether this purchase order mapping has been assigned to a charge.
   */
  @visibility(Lifecycle.Read)
  isMapUtilized?: boolean;
}

/**
 * The status of a purchase order mapping.
 */
@added(Versions.v2024_08_01_preview)
union POMappingStatus {
  string,

  /**
   * The purchase order mapping is active.
   */
  Active: "active",

  /**
   * The purchase order mapping is inactive.
   */
  Inactive: "inactive",
}

/**
 * Request body for validating purchase order mappings.
 */
@added(Versions.v2024_08_01_preview)
model PurchaseOrderMappingValidationRequest {
  ...PurchaseOrderMappingBase;
}

/**
 * Response of purchase order mapping validation.
 */
@added(Versions.v2024_08_01_preview)
model PurchaseOrderMappingValidationResponse {
  ...PurchaseOrderMappingBase;

  /**
   * A collection of validation errors that occurred during validation. If empty, validation succeeded.
   */
  @identifiers(#[])
  errors?: ValidationError[];
}

/**
 * A purchase order mapping validation error.
 */
@added(Versions.v2024_08_01_preview)
model ValidationError {
  /**
   * The name of the invalid field.
   */
  fieldName?: string;

  /**
   * The validation error message.
   */
  errorMessage?: string;

  /**
   * The validation error code.
   */
  errorCode?: string;
}

/**
 * A container for a list of purchase order mappings.
 */
@added(Versions.v2024_08_01_preview)
model PurchaseOrderMappingListResult {
  /**
   * The link to the next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;

  /**
   * The list of purchase order mappings.
   */
  @pageItems
  @identifiers(#["id"])
  @visibility(Lifecycle.Read)
  value?: PurchaseOrderMapping[];
}

/**
 * A summary of a purchase order invoice.
 */
@added(Versions.v2024_08_01_preview)
model PurchaseOrderInvoiceSummary {
  /**
   * An invoice id.
   */
  @visibility(Lifecycle.Read)
  invoiceId?: string;

  /**
   * The start date of the billing period for which the invoice is generated. The date is in MM-DD-YYYY format.
   */
  @visibility(Lifecycle.Read)
  invoicePeriodStartDate?: utcDateTime;

  /**
   * The end date of the billing period for which the invoice is generated. The date is in MM-DD-YYYY format.
   */
  @visibility(Lifecycle.Read)
  invoicePeriodEndDate?: utcDateTime;

  /**
   * The date when the invoice was generated.
   */
  @visibility(Lifecycle.Read)
  invoiceDate?: utcDateTime;

  /**
   * The total pre-tax charged amount for a purchase order number.
   */
  @visibility(Lifecycle.Read)
  subTotal?: float32;

  /**
   * The total tax amount applied for a purchase order number.
   */
  @visibility(Lifecycle.Read)
  taxAmount?: float32;

  /**
   * The total charges for a purchase order number.
   */
  @visibility(Lifecycle.Read)
  totalAmount?: float32;

  /**
   * The total tax amount applied for an invoice.
   */
  @visibility(Lifecycle.Read)
  invoiceTaxAmount?: float32;

  /**
   * The total pre-tax charged amount for an invoice.
   */
  @visibility(Lifecycle.Read)
  invoiceSubTotal?: float32;

  /**
   * The amount due when the invoice was generated.
   */
  @visibility(Lifecycle.Read)
  invoiceTotalAmount?: float32;

  /**
   * The ISO 4217 code for the currency in which the charges are billed.
   */
  @visibility(Lifecycle.Read)
  billingCurrency?: string;
}

/**
 * The unbilled charge summary for a purchase order number.
 */
@added(Versions.v2024_08_01_preview)
model PurchaseOrderTransactionSummary {
  /**
   * The total pre-tax charged amount for a purchase order number.
   */
  @visibility(Lifecycle.Read)
  subTotal?: float32;

  /**
   * The total tax amount applied for a purchase order number.
   */
  @visibility(Lifecycle.Read)
  taxAmount?: float32;

  /**
   * The total charges for a purchase order number.
   */
  @visibility(Lifecycle.Read)
  totalAmount?: float32;

  /**
   * The purchase order (PO) number.
   */
  @visibility(Lifecycle.Read)
  poNumber?: string;

  /**
   * The ISO 4217 code for the currency in which the charges are billed.
   */
  @visibility(Lifecycle.Read)
  billingCurrency?: string;
}

/**
 * A container for a list of purchase orders.
 */
@added(Versions.v2024_08_01_preview)
model PurchaseOrderListResult {
  /**
   * The link to the next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;

  /**
   * The list of purchase orders.
   */
  @pageItems
  @identifiers(#["id"])
  @visibility(Lifecycle.Read)
  value?: PurchaseOrder[];
}

/**
 * Migration details.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Not a subscription provisioned resource."
@added(Versions.v2024_08_01_preview)
model MigrationDetailsProperties {
  /**
   * Destination billing scope to be mapped.
   */
  destinationBillingScope?: string;

  /**
   * Migration status.
   */
  status?: MigrationStatus;

  /**
   * Transfer ID.
   */
  @visibility(Lifecycle.Read)
  transferId?: string;
}

/**
 * Migration status.
 */
@added(Versions.v2024_08_01_preview)
union MigrationStatus {
  string,

  /**
   * The Draft migration status.
   */
  Draft: "Draft",

  /**
   * The InProgress migration status.
   */
  InProgress: "InProgress",

  /**
   * The Completed migration status.
   */
  Completed: "Completed",

  /**
   * The Failed migration status.
   */
  Failed: "Failed",

  /**
   * The CompletedWithErrors migration status.
   */
  CompletedWithErrors: "CompletedWithErrors",
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
model ReservationsListResult {
  /** The link (url) to the next page of results. */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: url;

  /** The roll out count summary of the reservations */
  summary?: ReservationSummary;

  /** The list of reservations. */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: Reservation[];
}

/**
 * A container for a list of resources
 */
model BillingSubscriptionListResult {
  /** The link (url) to the next page of results. */
  @visibility(Lifecycle.Read)
  @nextLink
  nextLink?: url;

  /**
   * Total number of records.
   */
  @visibility(Lifecycle.Read)
  totalCount?: int32;

  /** The list of resources. */
  @visibility(Lifecycle.Read)
  @pageItems
  @identifiers(#["id"])
  value?: BillingSubscription[];
}

alias DefaultODataParameters = {
  /**
   * The filter query option allows clients to filter a collection of resources that are addressed by a request URL.
   */
  @query("filter")
  filter?: string;

  /**
   * The orderby query option allows clients to request resources in a particular order.
   */
  @query("orderBy")
  orderBy?: string;

  /**
   * The top query option requests the number of items in the queried collection to be included in the result. The maximum supported value for top is 50.
   */
  @query("top")
  top?: int64;

  /**
   * The skip query option requests the number of items in the queried collection that are to be skipped and not included in the result.
   */
  @query("skip")
  skip?: int64;

  /**
   * The count query option allows clients to request a count of the matching resources included with the resources in the response.
   */
  @query("count")
  count?: boolean;

  /**
   * The search query option allows clients to request items within a collection matching a free-text search expression. search is only supported for string fields.
   */
  @query("search")
  search?: string;
};

model AgreementListResult is Azure.Core.Page<Agreement>;

model AssociatedTenantListResult is Azure.Core.Page<AssociatedTenant>;

model BillingProfileListResult is Azure.Core.Page<BillingProfile>;

model BillingRequestListResult is Azure.Core.Page<BillingRequest>;

model BillingRoleAssignmentListResult is Azure.Core.Page<BillingRoleAssignment>;

model BillingRoleDefinitionListResult is Azure.Core.Page<BillingRoleDefinition>;

model BillingSubscriptionAliasListResult
  is Azure.Core.Page<BillingSubscriptionAlias>;

model CustomerListResult is Azure.Core.Page<Customer>;

model DepartmentListResult is Azure.Core.Page<Department>;

model EnrollmentAccountListResult is Azure.Core.Page<EnrollmentAccount>;

model InvoiceListResult is Azure.Core.Page<Invoice>;

model InvoiceSectionListResult is Azure.Core.Page<InvoiceSection>;

model ProductListResult is Azure.Core.Page<Product>;

model TransactionListResult is Azure.Core.Page<Transaction>;

model BillingAccountListResult is Azure.Core.Page<BillingAccount>;

model PartnerTransferDetailsListResult
  is Azure.Core.Page<PartnerTransferDetails>;

model RecipientTransferDetailsListResult
  is Azure.Core.Page<RecipientTransferDetails>;

model TransferDetailsListResult is Azure.Core.Page<TransferDetails>;

/**
 * A container for a list of alerts.
 */
@added(Versions.v2024_08_01_preview)
model AlertListResult is Azure.Core.Page<Alert>;

/**
 * Invoicing preferences.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Invoicing preferences do not expose a provisioning state."
@added(Versions.v2024_08_01_preview)
model InvoicingPreferencesProperties {
  /**
   * Specifies whether invoice supplements should be created based on the line-item-level purchase order (PO) number for a billing profile.
   */
  supplementalDocumentsEnabled: boolean;

  /**
   * The frequency at which invoices will be generated.
   */
  @visibility(Lifecycle.Read)
  invoiceFrequency?: FlushFrequency;

  /**
   * The date when the next invoice will be generated.
   */
  @visibility(Lifecycle.Read)
  nextInvoiceDate?: utcDateTime;
}

/**
 * The frequency at which invoices will be generated.
 */
@added(Versions.v2024_08_01_preview)
union FlushFrequency {
  string,

  /**
   * Invoices are generated manually.
   */
  Manual: "manual",

  /**
   * Invoices are generated immediately.
   */
  Immediate: "immediate",

  /**
   * Invoices are generated daily.
   */
  Daily: "daily",

  /**
   * Invoices are generated monthly.
   */
  Monthly: "monthly",

  /**
   * Invoices are generated quarterly.
   */
  Quarterly: "quarterly",

  /**
   * Invoices are generated yearly.
   */
  Yearly: "yearly",
}
