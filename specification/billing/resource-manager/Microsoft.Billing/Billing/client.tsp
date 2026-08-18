import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.Core;
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

// Restore GA SDK 1.2.2 C# names for models, properties, enums, enum-values, and operations.
// Also covers workarounds for:
//   - identical-valued union dedup (e.g. Enrollment*ViewCharges -> *ViewCharge),
//   - CS0111 resource-method disambiguation (BillingProfiles/InvoiceSections products list -> GetProducts),
//   - double-nested flatten name collisions (ReservationPurchaseRequest*.instanceFlexibility).
@@clientName(AcceptanceMode, "AgreementAcceptanceMode", "csharp");
@@clientName(AcceptTransferRequest, "AcceptTransferContent", "csharp");
@@clientName(AccessDecision, "BillingProfileAccessDecision", "csharp");
@@clientName(AccountStatus, "BillingAccountStatus", "csharp");
@@clientName(AccountSubType, "BillingAccountSubType", "csharp");
@@clientName(AccountType, "BillingAccountType", "csharp");
@@clientName(AddressDetails, "BillingAddressDetails", "csharp");
@@clientName(
  AddressValidationResponse,
  "BillingAddressValidationResult",
  "csharp"
);
@@clientName(
  AddressValidationStatus,
  "BillingAddressValidationStatus",
  "csharp"
);
@@clientName(Agreement, "BillingAgreement", "csharp");
@@clientName(AgreementProperties, "BillingAgreementProperties", "csharp");
@@clientName(AgreementType, "BillingAgreementType", "csharp");
@@clientName(Amount, "BillingAmount", "csharp");
@@clientName(AppliedScopeProperties, "BillingAppliedScopeProperties", "csharp");
@@clientName(AppliedScopeType, "BillingAppliedScopeType", "csharp");
@@clientName(AssociatedTenant, "BillingAssociatedTenant", "csharp");
@@clientName(
  AssociatedTenantProperties,
  "BillingAssociatedTenantProperties",
  "csharp"
);
@@clientName(AutoRenew, "BillingSubscriptionAutoRenewState", "csharp");
@@clientName(AvailableBalance, "BillingAvailableBalanceData", "csharp");
@@clientName(
  AvailableBalanceOperationGroup.getByBillingProfile,
  "GetBillingProfileAvailableBalance",
  "csharp"
);
@@clientName(
  AvailableBalanceProperties,
  "BillingAvailableBalanceProperties",
  "csharp"
);
@@clientName(
  AvailableBalances.getByBillingAccount,
  "GetBillingAccountAvailableBalance",
  "csharp"
);
@@clientName(AzurePlan, "BillingAzurePlan", "csharp");
@@clientName(Beneficiary, "BillingBeneficiary", "csharp");
@@clientName(
  BillingAccounts.checkAccessByBillingAccount,
  "checkAccessBillingPermissions",
  "csharp"
);
@@clientName(
  BillingAccounts.createByBillingAccount,
  "createByBillingAccountBillingRoleAssignment",
  "csharp"
);
@@clientName(
  BillingAccounts.listByBillingAccount,
  "getBillingPermissions",
  "csharp"
);
@@clientName(
  BillingAccounts.resolveByBillingAccount,
  "resolveByBillingAccountBillingRoleAssignment",
  "csharp"
);
@@clientName(
  BillingAccounts.downloadDocumentsByBillingAccount,
  "DownloadDocumentsByBillingAccountInvoice",
  "csharp"
);
@@clientName(
  BillingProfileProperties.invoiceEmailOptIn,
  "IsInvoiceEmailOptIn",
  "csharp"
);
@@clientName(
  BillingProfiles.checkAccessByBillingProfile,
  "checkAccessBillingPermissions",
  "csharp"
);
@@clientName(
  BillingProfiles.createByBillingProfile,
  "createByBillingProfileBillingRoleAssignment",
  "csharp"
);
@@clientName(
  BillingProfiles.listByBillingProfile,
  "getBillingPermissions",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" "Intentionally restores GA 1.2.2 shared GetProducts method name for the billing profile products list operation."
@@clientName(
  BillingProfiles.productsListByBillingProfile,
  "GetProducts",
  "csharp"
);
@@clientName(
  BillingProfiles.resolveByBillingProfile,
  "resolveByBillingProfileBillingRoleAssignment",
  "csharp"
);
@@clientName(BillingRelationshipType.CSPCustomer, "CspCustomer", "csharp");
@@clientName(BillingRelationshipType.CSPPartner, "CspPartner", "csharp");
@@clientName(BillingRequestProperties.type, "RequestType", "csharp");
@@clientName(
  BillingSubscriptionAliasProperties.beneficiaryTenantId,
  "SubscriptionAliasBeneficiaryTenantId",
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
  BillingSubscriptionProperties.beneficiaryTenantId,
  "BeneficiaryTenantId",
  "csharp"
);
@@clientName(BillingSubscriptionProperties.customerId, "CustomerId", "csharp");
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
@@clientName(Customer, "BillingCustomer", "csharp");
@@clientName(
  CustomerOperationGroup.listByCustomerAtBillingAccount,
  "getBillingPermissionsByCustomerAtBillingAccount",
  "csharp"
);
@@clientName(CustomerPolicy, "BillingCustomerPolicy", "csharp");
@@clientName(
  CustomerPolicyProperties,
  "BillingCustomerPolicyProperties",
  "csharp"
);
@@clientName(CustomerProperties, "BillingCustomerProperties", "csharp");
@@clientName(
  Customers.checkAccessByCustomer,
  "checkAccessBillingPermissions",
  "csharp"
);
@@clientName(
  Customers.createByCustomer,
  "createByCustomerBillingRoleAssignment",
  "csharp"
);
@@clientName(
  Customers.createOrUpdateByCustomer,
  "createOrUpdateByCustomerPolicy",
  "csharp"
);
@@clientName(Customers.listByCustomer, "getBillingPermissions", "csharp");
@@clientName(
  Customers.resolveByCustomer,
  "resolveByCustomerBillingRoleAssignment",
  "csharp"
);
@@clientName(CustomerStatus, "BillingCustomerStatus", "csharp");
@@clientName(Department, "BillingDepartment", "csharp");
@@clientName(DepartmentProperties, "BillingDepartmentProperties", "csharp");
@@clientName(
  Departments.checkAccessByDepartment,
  "checkAccessBillingPermissions",
  "csharp"
);
@@clientName(Departments.listByDepartment, "getBillingPermissions", "csharp");
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
@@clientName(EnrollmentAccount, "BillingEnrollmentAccount", "csharp");
@@clientName(
  EnrollmentAccountOperationGroup.checkAccessByEnrollmentAccount,
  "checkAccessBillingPermissions",
  "csharp"
);
@@clientName(
  EnrollmentAccountOperationGroup.listByEnrollmentAccount,
  "getBillingPermissions",
  "csharp"
);
@@clientName(
  EnrollmentAccountOwnerViewCharges,
  "EnrollmentAccountOwnerViewCharge",
  "csharp"
);
@@clientName(
  EnrollmentAccountProperties,
  "BillingEnrollmentAccountProperties",
  "csharp"
);
@@clientName(
  EnrollmentDepartmentAdminViewCharges,
  "EnrollmentDepartmentAdminViewCharge",
  "csharp"
);
@@clientName(EnrollmentDetails, "BillingAccountEnrollmentDetails", "csharp");
@@clientName(FailedPayment, "BillingInvoiceFailedPayment", "csharp");
@@clientName(FailedPayment.date, "On", "csharp");
@@clientName(
  FailedPaymentReason,
  "BillingInvoiceFailedPaymentReason",
  "csharp"
);
@@clientName(Invoice, "BillingInvoice", "csharp");
@@clientName(InvoiceProperties, "BillingInvoiceProperties", "csharp");
@@clientName(
  Invoices.getTransactionSummaryByInvoice,
  "getTransactionSummaryByInvoiceTransaction",
  "csharp"
);
@@clientName(
  Invoices.transactionsDownloadByInvoice,
  "transactionsDownloadByInvoiceTransaction",
  "csharp"
);
@@clientName(InvoiceSection, "BillingInvoiceSection", "csharp");
@@clientName(
  InvoiceSectionProperties,
  "BillingInvoiceSectionProperties",
  "csharp"
);
@@clientName(
  InvoiceSections.checkAccessByInvoiceSection,
  "checkAccessBillingPermissions",
  "csharp"
);
@@clientName(
  InvoiceSections.createByInvoiceSection,
  "createByInvoiceSectionBillingRoleAssignment",
  "csharp"
);
@@clientName(
  InvoiceSections.listByInvoiceSection,
  "getBillingPermissions",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" "Intentionally restores GA 1.2.2 shared GetProducts method name for the invoice section products list operation."
@@clientName(
  InvoiceSections.productsListByInvoiceSection,
  "GetProducts",
  "csharp"
);
@@clientName(
  InvoiceSections.resolveByInvoiceSection,
  "resolveByInvoiceSectionBillingRoleAssignment",
  "csharp"
);
@@clientName(InvoiceStatus, "BillingInvoiceStatus", "csharp");
@@clientName(InvoiceType, "BillingInvoiceType", "csharp");
@@clientName(MarkupStatus, "EnrollmentMarkupStatus", "csharp");
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
@@clientName(
  MoveBillingSubscriptionRequest,
  "BillingSubscriptionMoveContent",
  "csharp"
);
@@clientName(MoveProductRequest, "MoveProductContent", "csharp");
@@clientName(
  NextBillingCycleDetails.billingFrequency,
  "NextBillingCycleBillingFrequency",
  "csharp"
);
@@clientName(Operation, "BillingOperationInfo", "csharp");
@@clientName(OperationDisplay, "BillingOperationDisplay", "csharp");
@@clientName(OperationListResult, "BillingOperationInfoListResult", "csharp");
@@clientName(Participant, "BillingAgreementParticipant", "csharp");
@@clientName(PartnerTransferDetails, "PartnerTransferDetail", "csharp");
@@clientName(PatchProperties.renew, "IsRenewed", "csharp");
@@clientName(Payment, "BillingInvoicePayment", "csharp");
@@clientName(Payment.date, "MadeOn", "csharp");
@@clientName(PaymentDetail, "BillingPlanPaymentDetail", "csharp");
@@clientName(PaymentDetail.paymentDate, "PaymentCompletedOn", "csharp");
@@clientName(PaymentMethod, "BillingPaymentMethod", "csharp");
@@clientName(PaymentMethodLink, "BillingPaymentMethodLink", "csharp");
@@clientName(
  PaymentMethodProperties,
  "PaymentMethodProjectionProperties",
  "csharp"
);
@@clientName(PaymentMethodProperties.id, "PaymentMethodId", "csharp");
@@clientName(PaymentOnAccount, "BillingPaymentOnAccount", "csharp");
@@clientName(PaymentOnAccount.date, "On", "csharp");
@@clientName(PaymentStatus, "BillingPaymentStatus", "csharp");
@@clientName(PaymentTerm, "BillingPaymentTerm", "csharp");
@@clientName(PolicySummary, "BillingPolicySummary", "csharp");
@@clientName(PolicyType, "BillingPolicyType", "csharp");
@@clientName(Price, "BillingPrice", "csharp");
@@clientName(Principal, "BillingPrincipal", "csharp");
@@clientName(PrincipalType, "BillingPrincipalType", "csharp");
@@clientName(Product, "BillingProduct", "csharp");
@@clientName(ProductDetails, "BillingProductDetails", "csharp");
@@clientName(ProductProperties, "BillingProductProperties", "csharp");
@@clientName(ProductStatus, "BillingProductStatus", "csharp");
@@clientName(ProductTransferStatus, "BillingProductTransferStatus", "csharp");
@@clientName(ProductType, "BillingProductType", "csharp");
@@clientName(ProductType.SAAS, "Saas", "csharp");
@@clientName(ProvisioningState, "BillingProvisioningState", "csharp");
@@clientName(
  ProvisioningTenantState,
  "BillingProvisioningTenantState",
  "csharp"
);
@@clientName(PurchaseRequest, "BillingPurchaseProperties", "csharp");
@@clientName(PurchaseRequestProperties.renew, "IsRenewed", "csharp");
@@clientName(RebillDetails.rebillDetails, "RebillDetailsValue", "csharp");
@@clientName(RecipientTransferDetails, "RecipientTransferDetail", "csharp");
@@clientName(RegistrationNumber, "BillingRegistrationNumber", "csharp");
@@clientName(RegistrationNumber.required, "IsRequired", "csharp");
@@clientName(RegistrationNumber.type, "RegistrationNumberType", "csharp");
@@clientName(RenewalTermDetails, "SubscriptionRenewalTermDetails", "csharp");
@@clientName(RenewProperties, "BillingRenewProperties", "csharp");
@@clientName(RenewPropertiesResponse, "ReservationRenewProperties", "csharp");
@@clientName(Reseller, "CreatedSubscriptionReseller", "csharp");
@@clientName(Reservation, "BillingReservation", "csharp");
@@clientName(ReservationOrder, "BillingReservationOrder", "csharp");
@@clientName(ReservationOrderProperty.expiryDate, "ExpireOn", "csharp");
@@clientName(
  ReservationOrderProperty.expiryDateTime,
  "ReservationExpireOn",
  "csharp"
);
@@clientName(ReservationOrderProperty.reviewDateTime, "ReviewedOn", "csharp");
@@clientName(ReservationProperty.archived, "IsArchived", "csharp");
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
@@clientName(ReservationProperty.renew, "IsRenewed", "csharp");
@@clientName(
  ReservationPurchaseRequestProperties.instanceFlexibility,
  "InstanceFlexibilityPropertiesInstanceFlexibility",
  "csharp"
);
@@clientName(ReservationPurchaseRequestProperties.renew, "IsRenewed", "csharp");
@@clientName(
  ReservationPurchaseRequestPropertiesReservedResourceProperties.instanceFlexibility,
  "InstanceFlexibilityPropertiesReservedResourcePropertiesInstanceFlexibility",
  "csharp"
);
@@clientName(SavingsPlanModel, "BillingSavingsPlanModel", "csharp");
@@clientName(SavingsPlanModelProperties.renew, "IsRenewed", "csharp");
@@clientName(SavingsPlanTerm, "BillingSavingsPlanTerm", "csharp");
@@clientName(SavingsPlanUpdateRequestProperties.renew, "IsRenewed", "csharp");
@@clientName(
  SavingsPlanValidateResponse,
  "SavingsPlanValidateResult",
  "csharp"
);
@@clientName(SavingsPlanValidResponseProperty.valid, "IsValid", "csharp");
@@clientName(SpendingLimit, "BillingSpendingLimit", "csharp");
@@clientName(SpendingLimitDetails.type, "LimitType", "csharp");
@@clientName(SpendingLimitType.MSDN, "Msdn", "csharp");
@@clientName(SupportedAccountType, "BillingSupportedAccountType", "csharp");
@@clientName(SupportLevel, "BillingEnrollmentSupportLevel", "csharp");
@@clientName(SystemOverrides, "BillingSystemOverrides", "csharp");
@@clientName(TaxIdentifier, "BillingTaxIdentifier", "csharp");
@@clientName(TaxIdentifier.type, "IdentifierType", "csharp");
@@clientName(TaxIdentifierStatus, "BillingTaxIdentifierStatus", "csharp");
@@clientName(TaxIdentifierType, "BillingTaxIdentifierType", "csharp");
@@clientName(Transaction, "BillingTransactionData", "csharp");
@@clientName(TransactionKind, "BillingTransactionKind", "csharp");
@@clientName(TransactionProperties, "BillingTransactionProperties", "csharp");
@@clientName(TransactionProperties.date, "On", "csharp");
@@clientName(TransactionSummary, "BillingTransactionSummary", "csharp");
@@clientName(TransferDetails, "BillingTransferDetail", "csharp");
@@clientName(TransferError, "BillingTransferError", "csharp");
@@clientName(TransferStatus, "PartnerTransferStatus", "csharp");
@@clientName(TransitionDetails, "BillingTransitionDetails", "csharp");
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
  BillingSubscriptionMergeRequest,
  "BillingSubscriptionMergeContent",
  "csharp"
);
@@clientName(
  BillingSubscriptionSplitRequest,
  "BillingSubscriptionSplitContent",
  "csharp"
);
@@clientName(
  InitiateTransferRequest,
  "BillingTransferDetailCreateOrUpdateContent",
  "csharp"
);
@@clientName(CancelSubscriptionRequest, "CancelSubscriptionContent", "csharp");
@@clientName(
  PartnerInitiateTransferRequest,
  "PartnerTransferDetailCreateOrUpdateContent",
  "csharp"
);
@@clientName(
  SavingsPlanUpdateValidateRequest,
  "SavingsPlanUpdateValidateContent",
  "csharp"
);
@@clientName(
  ValidationResultProperties,
  "BillingTransferValidationResultProperties",
  "csharp"
);
@@clientName(
  InvoicesOperationGroup.downloadDocumentsByBillingSubscription,
  "DownloadDocumentsByBillingSubscriptionInvoice",
  "csharp"
);
@@clientName(
  BillingAccounts.addPaymentTerms::parameters.body,
  "arrayOfPaymentTerm",
  "csharp"
);
@@clientName(
  BillingAccounts.cancelPaymentTerms::parameters.body,
  "dateTime",
  "csharp"
);
@@clientName(
  BillingAccounts.validatePaymentTerms::parameters.body,
  "arrayOfPaymentTerm",
  "csharp"
);
@@clientName(
  BillingAccounts.downloadDocumentsByBillingAccount::parameters.body,
  "arrayOfDocumentDownloadRequest",
  "csharp"
);
@@clientName(
  InvoicesOperationGroup.downloadDocumentsByBillingSubscription::parameters.downloadUrls,
  "arrayOfDocumentDownloadRequest",
  "csharp"
);

// Restore GA C# property types that the new spec models as plain `string`:
//   resource IDs -> Azure.Core.armResourceIdentifier, URLs -> url, tenant IDs -> uuid (Guid?),
//   dates that lost their utcDateTime base -> utcDateTime, termDuration -> duration (TimeSpan?).
@@alternateType(
  BillingSubscriptionProperties.beneficiaryTenantId,
  uuid,
  "csharp"
);
@@alternateType(
  BillingSubscriptionProperties.billingProfileId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  BillingSubscriptionProperties.invoiceSectionId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  BillingSubscriptionProperties.provisioningTenantId,
  uuid,
  "csharp"
);
@@alternateType(BillingSubscriptionProperties.resourceUri, url, "csharp");
@@alternateType(BillingSubscriptionProperties.termDuration, duration, "csharp");
@@alternateType(
  BillingSubscriptionSplitRequest.termDuration,
  duration,
  "csharp"
);
@@alternateType(DocumentDownloadResult.expiryTime, utcDateTime, "csharp");
@@alternateType(
  PaymentMethodLinkProperties.paymentMethodId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
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
  RebillDetails.creditNoteDocumentId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  RebillDetails.invoiceDocumentId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(RecipientTransferProperties.customerTenantId, uuid, "csharp");
@@alternateType(
  RefundDetailsSummary.rebillInvoiceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(RenewalTermDetails.termDuration, duration, "csharp");
@@alternateType(
  ReservationOrderProperty.billingAccountId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ReservationOrderProperty.billingProfileId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ReservationOrderProperty.customerId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ReservationProperty.expiryDate, utcDateTime, "csharp");
@@alternateType(
  SavingsPlanModelProperties.billingAccountId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  SavingsPlanModelProperties.billingProfileId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  SavingsPlanModelProperties.customerId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  SavingsPlanOrderModelProperties.billingAccountId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  SavingsPlanOrderModelProperties.billingProfileId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  SavingsPlanOrderModelProperties.customerId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  TransactionProperties.invoiceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// Pin BillingPermissions/CheckAccess family operations back to the parent Resource for C#.
// back-compatible.tsp routes them to synthetic sub-clients for non-C# emitters; GA SDK 1.2.2
// exposed them directly on the parent Resource (e.g. BillingAccountResource.GetBillingPermissions).
@@clientLocation(
  BillingAccounts.checkAccessByBillingAccount,
  BillingAccounts,
  "csharp"
);
@@clientLocation(
  BillingAccounts.listByBillingAccount,
  BillingAccounts,
  "csharp"
);
@@clientLocation(
  BillingProfiles.checkAccessByBillingProfile,
  BillingProfiles,
  "csharp"
);
@@clientLocation(
  BillingProfiles.listByBillingProfile,
  BillingProfiles,
  "csharp"
);
@@clientLocation(
  CustomerOperationGroup.listByCustomerAtBillingAccount,
  CustomerOperationGroup,
  "csharp"
);
@@clientLocation(Customers.checkAccessByCustomer, Customers, "csharp");
@@clientLocation(Customers.listByCustomer, Customers, "csharp");
@@clientLocation(Departments.checkAccessByDepartment, Departments, "csharp");
@@clientLocation(Departments.listByDepartment, Departments, "csharp");
@@clientLocation(
  EnrollmentAccountOperationGroup.checkAccessByEnrollmentAccount,
  EnrollmentAccountOperationGroup,
  "csharp"
);
@@clientLocation(
  EnrollmentAccountOperationGroup.listByEnrollmentAccount,
  EnrollmentAccountOperationGroup,
  "csharp"
);
@@clientLocation(
  InvoiceSections.checkAccessByInvoiceSection,
  InvoiceSections,
  "csharp"
);
@@clientLocation(
  InvoiceSections.listByInvoiceSection,
  InvoiceSections,
  "csharp"
);

// Workaround for MPG emitter no-matching-items-property error on
// BillingAccounts.savingsPlansListByBillingAccount — the C# emitter cannot resolve inherited
// value/nextLink properties through `extends SavingsPlanModelList is Page<SavingsPlanModel>`.
// Tracking: https://github.com/Azure/azure-sdk-for-net/issues/59567. Remove once fixed.
@@scope(BillingAccounts.savingsPlansListByBillingAccount, "!csharp");

// Restore public setters / parameterless ctors on input models that the new spec marks output-only.
// MPG generator drops setters and ctors when usage is read-only; @@usage(Usage.input, "csharp")
// restores both — required for GA 1.2.2 input + Transfer detail resources whose ctors were public.
@@usage(Agreement, Usage.input, "csharp");
@@usage(AgreementProperties, Usage.input, "csharp");
@@usage(AvailableBalance, Usage.input, "csharp");
@@usage(BillingAccount, Usage.input, "csharp");
@@usage(BillingPlanInformation, Usage.input, "csharp");
@@usage(BillingRequestProperties, Usage.input, "csharp");
@@usage(BillingRoleDefinition, Usage.input, "csharp");
@@usage(BillingRoleDefinitionProperties, Usage.input, "csharp");
@@usage(BillingSubscription, Usage.input, "csharp");
@@usage(BillingSubscriptionAlias, Usage.input, "csharp");
@@usage(BillingSubscriptionPatch, Usage.input, "csharp");
@@usage(Customer, Usage.input, "csharp");
@@usage(CustomerProperties, Usage.input, "csharp");
@@usage(Department, Usage.input, "csharp");
@@usage(DepartmentProperties, Usage.input, "csharp");
@@usage(EnrollmentAccount, Usage.input, "csharp");
@@usage(EnrollmentAccountProperties, Usage.input, "csharp");
@@usage(Invoice, Usage.input, "csharp");
@@usage(PartnerTransferDetails, Usage.input, "csharp");
@@usage(PartnerTransferProperties, Usage.input, "csharp");
@@usage(PaymentDetail, Usage.input, "csharp");
@@usage(PaymentMethod, Usage.input, "csharp");
@@usage(PaymentMethodLink, Usage.input, "csharp");
@@usage(PaymentMethodLogo, Usage.input, "csharp");
@@usage(PaymentMethodProperties, Usage.input, "csharp");
@@usage(Product, Usage.input, "csharp");
@@usage(RecipientTransferDetails, Usage.input, "csharp");
@@usage(RecipientTransferProperties, Usage.input, "csharp");
@@usage(RenewPropertiesResponse, Usage.input, "csharp");
@@usage(Reservation, Usage.input, "csharp");
@@usage(ReservationExtendedStatusInfo, Usage.input, "csharp");
@@usage(ReservationMergeProperties, Usage.input, "csharp");
@@usage(ReservationOrder, Usage.input, "csharp");
@@usage(ReservationOrderBillingPlanInformation, Usage.input, "csharp");
@@usage(ReservationPaymentDetail, Usage.input, "csharp");
@@usage(ReservationPurchaseRequest, Usage.input, "csharp");
@@usage(ReservationSplitProperties, Usage.input, "csharp");
@@usage(ReservationSwapProperties, Usage.input, "csharp");
@@usage(ReservationUtilizationAggregates, Usage.input, "csharp");
@@usage(SavingsPlanModel, Usage.input, "csharp");
@@usage(SavingsPlanOrderModel, Usage.input, "csharp");
@@usage(Sku, Usage.input, "csharp");
@@usage(SubscriptionPolicy, Usage.input, "csharp");
@@usage(SubscriptionPolicyProperties, Usage.input, "csharp");
@@usage(TaxIdentifier, Usage.input, "csharp");
@@usage(Transaction, Usage.input, "csharp");
@@usage(TransactionProperties, Usage.input, "csharp");
@@usage(TransferDetails, Usage.input, "csharp");
@@usage(TransferProperties, Usage.input, "csharp");

// Restore GA-public Sku model (the new spec marks it internal-only).
@@access(Sku, Access.public, "csharp");

// Restore GA inheritance: Reservation extended TrackedResource and the *Patch models extended
// ProxyResource in 1.2.2. The new spec defines them as standalone models; this decorator
// re-introduces the GA base type for source/binary compat.
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Restores the GA 1.2.2 base type for source and binary compatibility."
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  BillingAccountPatch,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Restores the GA 1.2.2 base type for source and binary compatibility."
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  BillingSubscriptionPatch,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Restores the GA 1.2.2 base type for source and binary compatibility."
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  ProductPatch,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Restores the GA 1.2.2 base type for source and binary compatibility."
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  Reservation,
  Azure.ResourceManager.CommonTypes.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Restores the GA 1.2.2 base type for source and binary compatibility."
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  Transaction,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);

// Restore GA Pageable<BillingTransferValidationResult> return type for RecipientTransfers.validate.
// Spec models the response envelope `ValidateTransferListResponse` with `@pageItems value`,
// but `ArmResourceActionSync` doesn't mark the op as paging in TCGC, so the C# generator
// exposes the envelope (breaking GA which returned `Pageable<BillingTransferValidationResult>`).
// Client-only override; no swagger impact.
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Restore previous SDK Pageable<BillingTransferValidationResult> return type"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  RecipientTransfers.validate,
  "csharp"
);
