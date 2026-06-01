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
@@clientName(ProductType.SAAS, "Saas", "csharp");
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
@@clientName(TransferDetails, "BillingTransferDetail", "csharp");
@@clientName(PartnerTransferDetails, "PartnerTransferDetail", "csharp");
@@clientName(RecipientTransferDetails, "RecipientTransferDetail", "csharp");
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
@@clientName(
  EnrollmentAccountOwnerViewCharges,
  "EnrollmentAccountOwnerViewCharge",
  "csharp"
);
@@clientName(
  EnrollmentDepartmentAdminViewCharges,
  "EnrollmentDepartmentAdminViewCharge",
  "csharp"
);

// Resource-level method disambiguation: multiple @get @action ops on same parent resource share name "GetBy<Parent>" causing CS0111.
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@clientName(
  BillingProfiles.productsListByBillingProfile,
  "GetProducts",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@clientName(
  InvoiceSections.productsListByInvoiceSection,
  "GetProducts",
  "csharp"
);
// Resolve CS0102: ReservationPurchaseRequestProperties has direct .instanceFlexibility AND .reservedResourceProperties.instanceFlexibility (flattened by back-compatible.tsp). Rename the flatten source.
@@clientName(
  ReservationPurchaseRequestPropertiesReservedResourceProperties.instanceFlexibility,
  "ReservedInstanceFlexibility",
  "csharp"
);

@@clientName(SpendingLimitType.MSDN, "Msdn", "csharp");
// SavingsPlanUpdateValidate rename TEMPORARILY commented out — combined with @@clientLocation
// in back-compatible.tsp, the current emitter drops the action method from the Resource entirely.
// Tracking root-cause analysis separately; restore once Phase 6 fix lands.
// @@clientName(SavingsPlanUpdateValidateRequest, "SavingsPlanUpdateValidateContent", "csharp");

// Restore GA C# types for *Id (ResourceIdentifier), *Uri (Uri), tenant IDs (Guid?), and
// termDuration (TimeSpan?). Spec models these as `string`; @@alternateType maps to the GA shapes.
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
@@alternateType(BillingSubscriptionProperties.resourceUri, url, "csharp");
@@alternateType(BillingSubscriptionProperties.termDuration, duration, "csharp");
@@alternateType(
  BillingSubscriptionProperties.provisioningTenantId,
  uuid,
  "csharp"
);

@@alternateType(
  SavingsPlanModelProperties.billingAccountId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  SavingsPlanModelProperties.customerId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  SavingsPlanModelProperties.billingProfileId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

@@alternateType(
  SavingsPlanOrderModelProperties.billingAccountId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  SavingsPlanOrderModelProperties.customerId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  SavingsPlanOrderModelProperties.billingProfileId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

@@alternateType(
  ReservationOrderProperty.billingAccountId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ReservationOrderProperty.customerId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ReservationOrderProperty.billingProfileId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

@@alternateType(
  PaymentMethodLinkProperties.paymentMethodId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

@@alternateType(RenewalTermDetails.termDuration, duration, "csharp");

// Resolve AZC0033: model named "Operation" must use a non-generic suffix.
@@clientName(Operation, "BillingOperationInfo", "csharp");
@@clientName(OperationDisplay, "BillingOperationDisplay", "csharp");
@@clientName(OperationListResult, "BillingOperationInfoListResult", "csharp");

// Workaround for MPG emitter no-matching-items-property error:
// `BillingAccounts.savingsPlansListByBillingAccount` returns `SavingsPlanModelListResult`,
// which `extends SavingsPlanModelList` (which `is Azure.Core.Page<SavingsPlanModel>`).
// The C# emitter cannot resolve the inherited `value`/`nextLink` properties as pagination
// metadata through `extends`, and `@@pageItems` / `Legacy.markAsPageable` workarounds in
// client.tsp do not propagate either. Suppress the operation for C# only.
// Tracking issue: https://github.com/Azure/azure-sdk-for-net/issues/59567
// Removal criteria: once the emitter resolves inherited Page<T> properties through
// `extends`, drop this `@@scope` line and regenerate to restore
// `BillingAccountResource.GetByBillingAccountSavingsPlan(Options)`.
@@scope(BillingAccounts.savingsPlansListByBillingAccount, "!csharp");

// Restore public setters / parameterless ctors on input models that the new spec marks output-only.
// MPG generator drops setters and ctors when usage is read-only; @@usage(Usage.input, "csharp") restores both.
@@usage(BillingAccount, Usage.input, "csharp");
@@usage(Agreement, Usage.input, "csharp");
@@usage(AgreementProperties, Usage.input, "csharp");
@@usage(AvailableBalance, Usage.input, "csharp");
@@usage(AvailableBalanceProperties, Usage.input, "csharp");
@@usage(Customer, Usage.input, "csharp");
@@usage(CustomerProperties, Usage.input, "csharp");
@@usage(Department, Usage.input, "csharp");
@@usage(DepartmentProperties, Usage.input, "csharp");
@@usage(EnrollmentAccount, Usage.input, "csharp");
@@usage(EnrollmentAccountProperties, Usage.input, "csharp");
@@usage(Invoice, Usage.input, "csharp");
@@usage(InvoiceProperties, Usage.input, "csharp");
@@usage(PaymentMethod, Usage.input, "csharp");
@@usage(PaymentMethodLink, Usage.input, "csharp");
@@usage(BillingPlanInformation, Usage.input, "csharp");
@@usage(PaymentDetail, Usage.input, "csharp");
@@usage(Product, Usage.input, "csharp");
@@usage(BillingRequestProperties, Usage.input, "csharp");
@@usage(Reservation, Usage.input, "csharp");
@@usage(ReservationOrder, Usage.input, "csharp");
@@usage(BillingRoleDefinition, Usage.input, "csharp");
@@usage(BillingRoleDefinitionProperties, Usage.input, "csharp");
@@usage(SavingsPlanModel, Usage.input, "csharp");
@@usage(BillingSubscriptionAlias, Usage.input, "csharp");
@@usage(BillingSubscription, Usage.input, "csharp");
@@usage(BillingSubscriptionPatch, Usage.input, "csharp");
@@usage(TaxIdentifier, Usage.input, "csharp");
@@usage(Transaction, Usage.input, "csharp");
@@usage(TransactionProperties, Usage.input, "csharp");
@@usage(PaymentMethodLogo, Usage.input, "csharp");
@@usage(PaymentMethodProperties, Usage.input, "csharp");
@@usage(RefundDetailsSummary, Usage.input, "csharp");
@@usage(RefundTransactionDetails, Usage.input, "csharp");
@@usage(ReservationExtendedStatusInfo, Usage.input, "csharp");
@@usage(ReservationMergeProperties, Usage.input, "csharp");
@@usage(ReservationOrderBillingPlanInformation, Usage.input, "csharp");
@@usage(ReservationPaymentDetail, Usage.input, "csharp");
@@usage(ReservationPurchaseRequest, Usage.input, "csharp");
@@usage(RenewPropertiesResponse, Usage.input, "csharp");
@@usage(ReservationSplitProperties, Usage.input, "csharp");
@@usage(ReservationSwapProperties, Usage.input, "csharp");
@@usage(ReservationUtilizationAggregates, Usage.input, "csharp");
@@usage(SavingsPlanOrderModel, Usage.input, "csharp");
@@usage(SubscriptionPolicy, Usage.input, "csharp");
@@usage(SubscriptionPolicyProperties, Usage.input, "csharp");
@@usage(Sku, Usage.input, "csharp");
@@access(Sku, Access.public, "csharp");

// D7 fix: restore public parameterless ctors on Transfer detail resources by marking the
// underlying TypeSpec models as Usage.input (the new spec makes them read-only).
@@usage(TransferDetails, Usage.input, "csharp");
@@usage(PartnerTransferDetails, Usage.input, "csharp");
@@usage(RecipientTransferDetails, Usage.input, "csharp");
@@usage(TransferProperties, Usage.input, "csharp");
@@usage(PartnerTransferProperties, Usage.input, "csharp");
@@usage(RecipientTransferProperties, Usage.input, "csharp");

// D8 fix: GA emitted Amount-typed properties as { get; } only because the inner Amount
// model has @visibility(Lifecycle.Read) on its fields (currency, value). The MPG emitter,
// when the containing model is marked Usage.input, ignores the inner type's read-only-ness
// and emits a public setter — letting callers assign a meaningless BillingAmount whose own
// Currency/Value cannot be mutated. Restore the GA shape by marking each Amount-typed
// outer property Lifecycle.Read. This applies across all languages, which is the correct
// behaviour (Amount is a read-only response shape per spec).
@@visibility(AvailableBalanceProperties.amount, Lifecycle.Read);
@@visibility(AvailableBalanceProperties.totalPaymentsOnAccount, Lifecycle.Read);
@@visibility(PaymentOnAccount.amount, Lifecycle.Read);
@@visibility(BillingSubscriptionProperties.lastMonthCharges, Lifecycle.Read);
@@visibility(BillingSubscriptionProperties.monthToDateCharges, Lifecycle.Read);
@@visibility(InvoiceProperties.amountDue, Lifecycle.Read);
@@visibility(InvoiceProperties.azurePrepaymentApplied, Lifecycle.Read);
@@visibility(InvoiceProperties.billedAmount, Lifecycle.Read);
@@visibility(InvoiceProperties.creditAmount, Lifecycle.Read);
@@visibility(InvoiceProperties.freeAzureCreditApplied, Lifecycle.Read);
@@visibility(InvoiceProperties.subTotal, Lifecycle.Read);
@@visibility(InvoiceProperties.taxAmount, Lifecycle.Read);
@@visibility(InvoiceProperties.totalAmount, Lifecycle.Read);
@@visibility(Payment.amount, Lifecycle.Read);
@@visibility(RefundDetailsSummary.amountRequested, Lifecycle.Read);
@@visibility(RefundDetailsSummary.amountRefunded, Lifecycle.Read);
@@visibility(ProductProperties.lastCharge, Lifecycle.Read);
@@visibility(TransactionProperties.azureCreditApplied, Lifecycle.Read);
@@visibility(TransactionProperties.consumptionCommitmentDecremented, Lifecycle.Read);
@@visibility(TransactionProperties.effectivePrice, Lifecycle.Read);
@@visibility(TransactionProperties.marketPrice, Lifecycle.Read);
@@visibility(TransactionProperties.subTotal, Lifecycle.Read);
@@visibility(TransactionProperties.tax, Lifecycle.Read);
@@visibility(TransactionProperties.transactionAmount, Lifecycle.Read);
@@visibility(RefundTransactionDetails.amountRequested, Lifecycle.Read);
@@visibility(RefundTransactionDetails.amountRefunded, Lifecycle.Read);

// D3 fix: BillingTransferValidationResult.Results was IReadOnlyList in GA. The new spec
// does not mark ValidateTransferResponseProperties.results as read-only, so the C# emitter
// would emit IList. Force read-only visibility here to preserve the GA shape.
@@visibility(ValidateTransferResponseProperties.results, Lifecycle.Read);

// D2 fix: Reservation should map to TrackedResource in C# to preserve the GA
// `BillingReservationData : TrackedResourceData` base. The new spec declares it as
// ProxyResource with optional location/tags, which yields `: ResourceData` by default.
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  Reservation,
  Azure.ResourceManager.CommonTypes.TrackedResource,
  "csharp"
);

// D2 fix: Patch models (and Transaction) inherit from ProxyResourceWithTags in the new spec,
// but the GA C# surface exposes them as `: ResourceData`. Flatten ProxyResourceWithTags into
// the C# layer so the public surface keeps the GA base type and Tags becomes a direct property.
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  BillingAccountPatch,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  ProductPatch,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  BillingSubscriptionPatch,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  Transaction,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);

// D19 fix: restore GA property names that the new spec renamed/restructured.
@@clientName(FailedPayment.date, "On", "csharp");
@@clientName(PaymentOnAccount.date, "On", "csharp");
@@clientName(TransactionProperties.date, "On", "csharp");
@@clientName(RegistrationNumber.type, "RegistrationNumberType", "csharp");
@@clientName(TaxIdentifier.type, "IdentifierType", "csharp");
@@clientName(SpendingLimitDetails.type, "LimitType", "csharp");
@@clientName(RebillDetails.rebillDetails, "RebillDetailsValue", "csharp");

// D3 fix: GA emitted RecipientTransferDetailData.CustomerTenantId as Guid?, but the new spec
// declares customerTenantId as plain string. Force the C# property type back to Guid via uuid alias.
@@alternateType(RecipientTransferProperties.customerTenantId, uuid, "csharp");

// D19 fix: BillingSubscriptionAliasProperties extends BillingSubscriptionProperties; the
// generator flattens both into BillingSubscriptionData and prefixes alias-only properties
// to disambiguate. GA used the "Subscription" prefix; new gen uses "SubscriptionAlias".
// Override to restore GA names.
@@clientName(
  BillingSubscriptionAliasProperties.beneficiaryTenantId,
  "SubscriptionBeneficiaryTenantId",
  "csharp"
);
@@clientName(
  BillingSubscriptionAliasProperties.customerId,
  "SubscriptionCustomerId",
  "csharp"
);

// D19 fix: BillingRequestProperties.type was GA-named RequestType (the GA generator added
// a disambiguating suffix). The @@clientName decorator below does not apply because
// TypeSpec resolves `BillingRequestProperties.type` against the model's intrinsic `type`
// metadata rather than the property; the RequestType alias is restored via SDK-side
// Custom partial (sdk/billing/.../src/Custom/Models/BillingRequestProperties.cs).
// Decorator kept commented for documentation purposes only.
// @@clientName(BillingRequestProperties.type, "RequestType", "csharp");
