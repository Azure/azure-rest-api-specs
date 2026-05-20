import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Billing;

@@clientName(Microsoft.Billing, "BillingManagementClient", "javascript,python");
@@clientName(BillingPlan.P1M, "P1_M", "python");
@@clientName(SavingsPlanTerm.P1Y, "P1_Y", "python");
@@clientName(SavingsPlanTerm.P3Y, "P3_Y", "python");
@@clientName(SavingsPlanTerm.P5Y, "P5_Y", "python");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  AssociatedTenantsListByBillingAccountParameters.includeRevoked,
  false,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  BillingAccountsListParameters.includeAll,
  false,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  BillingAccountsListParameters.includeAllWithoutBillingProfiles,
  false,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  BillingAccountsListParameters.includeDeleted,
  false,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  BillingAccountsListParameters.includePendingAgreement,
  false,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  BillingAccountsListParameters.includeResellee,
  false,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  BillingPropertyGetParameters.includeBillingCountry,
  false,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  BillingPropertyGetParameters.includeTransitionStatus,
  false,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  BillingProfilesListByBillingAccountParameters.includeDeleted,
  false,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  BillingSubscriptionAliasesListByBillingAccountParameters.includeDeleted,
  false,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  BillingRoleAssignmentsResolveByBillingAccountParameters.resolveScopeDisplayNames,
  false,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  BillingRoleAssignmentsResolveByBillingProfileParameters.resolveScopeDisplayNames,
  false,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  BillingRoleAssignmentsResolveByInvoiceSectionParameters.resolveScopeDisplayNames,
  false,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  BillingRoleAssignmentsResolveByCustomerParameters.resolveScopeDisplayNames,
  false,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  BillingSubscriptionsListByBillingAccountParameters.includeDeleted,
  false,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  BillingSubscriptionsListByBillingAccountParameters.includeTenantSubscriptions,
  false,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  BillingSubscriptionsListByBillingAccountParameters.includeFailed,
  false,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  BillingSubscriptionsListByBillingProfileParameters.includeDeleted,
  false,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  BillingSubscriptionsListByCustomerParameters.includeDeleted,
  false,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  BillingSubscriptionsListByCustomerAtBillingAccountParameters.includeDeleted,
  false,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  BillingSubscriptionsListByInvoiceSectionParameters.includeDeleted,
  false,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  InvoiceSectionsListByBillingProfileParameters.includeDeleted,
  false,
  "python"
);

// C# SDK customizations: model/property/enum/operation renames and type alternates derived from the legacy autorest.md (rename-mapping, prepend-rp-prefix, override-operation-name).
@@clientName(AcceptanceMode, "AgreementAcceptanceMode", "csharp");
@@clientName(AcceptTransferRequest, "AcceptTransferContent", "csharp");
@@clientName(AccessDecision, "BillingProfileAccessDecision", "csharp");
@@clientName(
  AddressValidationResponse,
  "BillingAddressValidationResult",
  "csharp"
);
@@clientName(AutoRenew, "BillingSubscriptionAutoRenewState", "csharp");
@@clientName(Amount, "BillingAmount", "csharp");
@@clientName(AvailableBalance, "BillingAvailableBalanceData", "csharp");
@@clientName(AzurePlan, "BillingAzurePlan", "csharp");
@@clientName(
  BillingProfileProperties.invoiceEmailOptIn,
  "IsInvoiceEmailOptIn",
  "csharp"
);
@@clientName(BillingRelationshipType.CSPPartner, "CspPartner", "csharp");
@@clientName(BillingRelationshipType.CSPCustomer, "CspCustomer", "csharp");
@@clientName(
  BillingSubscriptionProperties.customerId,
  "SubscriptionCustomerId",
  "csharp"
);
@@clientName(
  BillingSubscriptionProperties.beneficiaryTenantId,
  "SubscriptionBeneficiaryTenantId",
  "csharp"
);
@@clientName(
  BillingSubscriptionAliasProperties.billingSubscriptionId,
  "SubscriptionAliasSubscriptionId",
  "csharp"
);
@@clientName(
  BillingSubscriptionAliasProperties.customerId,
  "SubscriptionAliasCustomerId",
  "csharp"
);
@@clientName(
  BillingSubscriptionAliasProperties.beneficiaryTenantId,
  "SubscriptionAliasBeneficiaryTenantId",
  "csharp"
);
@@clientName(Cancellation, "PolicyOverrideCancellation", "csharp");
@@clientName(
  CancellationReason,
  "CustomerSubscriptionCancellationReason",
  "csharp"
);
@@clientName(Category, "BillingAgreementCategory", "csharp");
@@clientName(CheckAccessRequest, "BillingCheckAccessContent", "csharp");
@@clientName(CheckAccessResponse, "BillingCheckAccessResult", "csharp");
@@clientName(Commitment, "BillingBenefitCommitment", "csharp");
@@clientName(CommitmentGrain, "BillingBenefitCommitmentGrain", "csharp");
@@clientName(CreditType, "BillingTransactionCreditType", "csharp");
@@clientName(CustomerStatus, "BillingCustomerStatus", "csharp");
@@clientName(
  DocumentDownloadRequest,
  "BillingDocumentDownloadRequestContent",
  "csharp"
);
@@clientName(DocumentDownloadResult, "BillingDocumentDownloadResult", "csharp");
@@clientName(DocumentDownloadResult.expiryTime, "ExpireOn", "csharp");
@@clientName(DocumentSource, "BillingDocumentSource", "csharp");
@@clientName(DocumentSource.DRS, "Drs", "csharp");
@@clientName(DocumentSource.ENF, "Enf", "csharp");
@@clientName(EnrollmentDetails, "BillingAccountEnrollmentDetails", "csharp");
@@clientName(FailedPayment, "BillingInvoiceFailedPayment", "csharp");
@@clientName(
  FailedPaymentReason,
  "BillingInvoiceFailedPaymentReason",
  "csharp"
);
@@clientName(MarkupStatus, "EnrollmentMarkupStatus", "csharp");
@@clientName(
  MoveBillingSubscriptionRequest,
  "BillingSubscriptionMoveContent",
  "csharp"
);
@@clientName(
  MoveBillingSubscriptionEligibilityResult,
  "BillingSubscriptionValidateMoveEligibilityResult",
  "csharp"
);
@@clientName(
  MoveBillingSubscriptionErrorDetails,
  "BillingSubscriptionValidateMoveEligibilityError",
  "csharp"
);
@@clientName(MoveProductRequest, "MoveProductContent", "csharp");
@@clientName(
  NextBillingCycleDetails.billingFrequency,
  "NextBillingCycleBillingFrequency",
  "csharp"
);
@@clientName(Participant, "BillingAgreementParticipant", "csharp");
@@clientName(RenewalTermDetails, "SubscriptionRenewalTermDetails", "csharp");
@@clientName(Reseller, "CreatedSubscriptionReseller", "csharp");
@@clientName(ReservationProperty.expiryDate, "ExpireOn", "csharp");
@@clientName(
  ReservationProperty.expiryDateTime,
  "ReservationExpireOn",
  "csharp"
);
@@clientName(ReservationProperty.purchaseDate, "PurchaseOn", "csharp");
@@clientName(
  ReservationProperty.purchaseDateTime,
  "ReservationPurchaseOn",
  "csharp"
);
@@clientName(ReservationProperty.archived, "IsArchived", "csharp");
@@clientName(ReservationProperty.renew, "IsRenewed", "csharp");
@@clientName(ReservationOrderProperty.expiryDate, "ExpireOn", "csharp");
@@clientName(
  ReservationOrderProperty.expiryDateTime,
  "ReservationExpireOn",
  "csharp"
);
@@clientName(ReservationOrderProperty.reviewDateTime, "ReviewedOn", "csharp");
@@clientName(ReservationPurchaseRequestProperties.renew, "IsRenewed", "csharp");
@@clientName(Payment, "BillingInvoicePayment", "csharp");
@@clientName(Payment.date, "MadeOn", "csharp");
@@clientName(PaymentDetail, "BillingPlanPaymentDetail", "csharp");
@@clientName(PaymentDetail.paymentDate, "PaymentCompletedOn", "csharp");
@@clientName(PaymentMethodProperties.id, "PaymentMethodId", "csharp");
@@clientName(
  PaymentMethodProperties,
  "PaymentMethodProjectionProperties",
  "csharp"
);
@@clientName(PatchProperties.renew, "IsRenewed", "csharp");
@@clientName(PurchaseRequest, "BillingPurchaseProperties", "csharp");
@@clientName(PurchaseRequestProperties.renew, "IsRenewed", "csharp");
@@clientName(RegistrationNumber.required, "IsRequired", "csharp");
@@clientName(RenewPropertiesResponse, "ReservationRenewProperties", "csharp");
@@clientName(SavingsPlanModel, "BillingSavingsPlanModel", "csharp");
@@clientName(SavingsPlanModelProperties.renew, "IsRenewed", "csharp");
@@clientName(SavingsPlanUpdateRequestProperties.renew, "IsRenewed", "csharp");
@@clientName(
  SavingsPlanValidateResponse,
  "SavingsPlanValidateResult",
  "csharp"
);
@@clientName(SavingsPlanValidResponseProperty.valid, "IsValid", "csharp");
@@clientName(SupportLevel, "BillingEnrollmentSupportLevel", "csharp");
@@clientName(Transaction, "BillingTransactionData", "csharp");
@@clientName(TransferStatus, "PartnerTransferStatus", "csharp");
@@clientName(Utilization, "SavingsPlanUtilization", "csharp");
@@clientName(
  UtilizationAggregates,
  "SavingsPlanUtilizationAggregates",
  "csharp"
);
@@clientName(
  ValidateTransferResponse,
  "BillingTransferValidationResult",
  "csharp"
);
@@clientName(
  ValidationResultProperties,
  "BillingTransferValidationResultProperties",
  "csharp"
);
@@clientName(AccountStatus, "BillingAccountStatus", "csharp");
@@clientName(AccountSubType, "BillingAccountSubType", "csharp");
@@clientName(AccountType, "BillingAccountType", "csharp");
@@clientName(AddressDetails, "BillingAddressDetails", "csharp");
@@clientName(
  AddressValidationStatus,
  "BillingAddressValidationStatus",
  "csharp"
);
@@clientName(AgreementType, "BillingAgreementType", "csharp");
@@clientName(Agreement, "BillingAgreement", "csharp");
@@clientName(AgreementProperties, "BillingAgreementProperties", "csharp");
@@clientName(AppliedScopeProperties, "BillingAppliedScopeProperties", "csharp");
@@clientName(AppliedScopeType, "BillingAppliedScopeType", "csharp");
@@clientName(AssociatedTenant, "BillingAssociatedTenant", "csharp");
@@clientName(
  AssociatedTenantProperties,
  "BillingAssociatedTenantProperties",
  "csharp"
);
@@clientName(
  AvailableBalanceProperties,
  "BillingAvailableBalanceProperties",
  "csharp"
);
@@clientName(Beneficiary, "BillingBeneficiary", "csharp");
@@clientName(Customer, "BillingCustomer", "csharp");
@@clientName(CustomerProperties, "BillingCustomerProperties", "csharp");
@@clientName(CustomerPolicy, "BillingCustomerPolicy", "csharp");
@@clientName(
  CustomerPolicyProperties,
  "BillingCustomerPolicyProperties",
  "csharp"
);
@@clientName(Department, "BillingDepartment", "csharp");
@@clientName(DepartmentProperties, "BillingDepartmentProperties", "csharp");
@@clientName(EnrollmentAccount, "BillingEnrollmentAccount", "csharp");
@@clientName(
  EnrollmentAccountProperties,
  "BillingEnrollmentAccountProperties",
  "csharp"
);
@@clientName(Invoice, "BillingInvoice", "csharp");
@@clientName(InvoiceProperties, "BillingInvoiceProperties", "csharp");
@@clientName(InvoiceSection, "BillingInvoiceSection", "csharp");
@@clientName(
  InvoiceSectionProperties,
  "BillingInvoiceSectionProperties",
  "csharp"
);
@@clientName(InvoiceStatus, "BillingInvoiceStatus", "csharp");
@@clientName(InvoiceType, "BillingInvoiceType", "csharp");
@@clientName(PaymentMethod, "BillingPaymentMethod", "csharp");
@@clientName(PaymentMethodLink, "BillingPaymentMethodLink", "csharp");
@@clientName(PaymentOnAccount, "BillingPaymentOnAccount", "csharp");
@@clientName(PaymentStatus, "BillingPaymentStatus", "csharp");
@@clientName(PaymentTerm, "BillingPaymentTerm", "csharp");
@@clientName(PolicySummary, "BillingPolicySummary", "csharp");
@@clientName(PolicyType, "BillingPolicyType", "csharp");
@@clientName(Price, "BillingPrice", "csharp");
@@clientName(Principal, "BillingPrincipal", "csharp");
@@clientName(PrincipalType, "BillingPrincipalType", "csharp");
@@clientName(ProvisioningState, "BillingProvisioningState", "csharp");
@@clientName(Product, "BillingProduct", "csharp");
@@clientName(ProductProperties, "BillingProductProperties", "csharp");
@@clientName(ProductDetails, "BillingProductDetails", "csharp");
@@clientName(ProductStatus, "BillingProductStatus", "csharp");
@@clientName(ProductTransferStatus, "BillingProductTransferStatus", "csharp");
@@clientName(ProductType, "BillingProductType", "csharp");
@@clientName(
  ProvisioningTenantState,
  "BillingProvisioningTenantState",
  "csharp"
);
@@clientName(RenewProperties, "BillingRenewProperties", "csharp");
@@clientName(Reservation, "BillingReservation", "csharp");
@@clientName(ReservationOrder, "BillingReservationOrder", "csharp");
@@clientName(RegistrationNumber, "BillingRegistrationNumber", "csharp");
@@clientName(SavingsPlanTerm, "BillingSavingsPlanTerm", "csharp");
@@clientName(SpendingLimit, "BillingSpendingLimit", "csharp");
@@clientName(SupportedAccountType, "BillingSupportedAccountType", "csharp");
@@clientName(SystemOverrides, "BillingSystemOverrides", "csharp");
@@clientName(TaxIdentifier, "BillingTaxIdentifier", "csharp");
@@clientName(TaxIdentifierType, "BillingTaxIdentifierType", "csharp");
@@clientName(TaxIdentifierStatus, "BillingTaxIdentifierStatus", "csharp");
@@clientName(TransactionKind, "BillingTransactionKind", "csharp");
@@clientName(TransactionProperties, "BillingTransactionProperties", "csharp");
@@clientName(TransactionSummary, "BillingTransactionSummary", "csharp");
@@clientName(TransferDetails, "BillingTransferDetails", "csharp");
@@clientName(TransferError, "BillingTransferError", "csharp");
@@clientName(TransitionDetails, "BillingTransitionDetails", "csharp");
@@clientName(
  AvailableBalances.getByBillingAccount,
  "GetBillingAccountAvailableBalance",
  "csharp"
);
@@clientName(
  AvailableBalanceOperationGroup.getByBillingProfile,
  "GetBillingProfileAvailableBalance",
  "csharp"
);
@@alternateType(DocumentDownloadResult.expiryTime, utcDateTime, "csharp");
@@alternateType(ReservationProperty.expiryDate, utcDateTime, "csharp");
@@alternateType(
  PaymentMethodProperties.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  PaymentOnAccount.invoiceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  RebillDetails.invoiceDocumentId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  RebillDetails.creditNoteDocumentId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  RefundDetailsSummary.rebillInvoiceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  TransactionProperties.invoiceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// Disambiguate identical-valued unions (workaround for MPG generator dedup bug)
@@clientName(EnrollmentAccountOwnerViewCharges, "EnrollmentAccountOwnerViewCharge", "csharp");
@@clientName(EnrollmentDepartmentAdminViewCharges, "EnrollmentDepartmentAdminViewCharge", "csharp");

// Resource-level method disambiguation: multiple @get @action ops on same parent resource share name "GetBy<Parent>" causing CS0111.
@@clientName(BillingProfiles.productsListByBillingProfile, "GetProducts", "csharp");
@@clientName(InvoiceSections.productsListByInvoiceSection, "GetProducts", "csharp");
// Resolve CS0102: ReservationPurchaseRequestProperties has direct .instanceFlexibility AND .reservedResourceProperties.instanceFlexibility (flattened by back-compatible.tsp). Rename the flatten source.
@@clientName(ReservationPurchaseRequestPropertiesReservedResourceProperties.instanceFlexibility, "ReservedInstanceFlexibility", "csharp");

// Resolve CS1503/CS7036: TermDuration generates as TimeSpan? but spec is string. Force string in C# so WriteStringValue/GetString work.
@@alternateType(RenewalTermDetails.termDuration, string, "csharp");

// Resolve AZC0033: model named "Operation" must use a non-generic suffix.
@@clientName(Operation, "BillingOperationInfo", "csharp");
@@clientName(OperationDisplay, "BillingOperationDisplay", "csharp");
@@clientName(OperationListResult, "BillingOperationInfoListResult", "csharp");