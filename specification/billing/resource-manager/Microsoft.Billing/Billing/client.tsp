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
@@clientName(BillingRequestProperties.type, "RequestType", "csharp");
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

@@clientName(
  ReservationPurchaseRequestPropertiesReservedResourceProperties.instanceFlexibility,
  "InstanceFlexibilityPropertiesReservedResourcePropertiesInstanceFlexibility",
  "csharp"
);
@@clientName(
  ReservationPurchaseRequestProperties.instanceFlexibility,
  "InstanceFlexibilityPropertiesInstanceFlexibility",
  "csharp"
);
@@clientName(
  BillingSubscriptionProperties.customerId,
  "CustomerId",
  "csharp"
);
@@clientName(
  BillingSubscriptionProperties.beneficiaryTenantId,
  "BeneficiaryTenantId",
  "csharp"
);
@@clientName(SpendingLimitType.MSDN, "Msdn", "csharp");

// NOTE: Spec-side rename of action-payload models (*Request -> *Content) via
// @@clientName is unsafe when combined with @@clientLocation: the MPG emitter
// silently drops the action method from the Resource/Collection, leaving only
// the REST operation and the model class. Verified on all 6 candidate types
// (Merge/Split/Cancel/Initiate/PartnerInitiate/SavingsPlanUpdateValidate).
// Tracking the emitter regression upstream; until fixed, the GA *Content classes
// are kept as hand-written Custom/Models/*Content shims (with [WirePath(...)]).

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

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  Reservation,
  Azure.ResourceManager.CommonTypes.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  BillingAccountPatch,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  ProductPatch,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  BillingSubscriptionPatch,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

// =====================================================================================
// D20: C# back-compat for GA SDK 1.2.2 method placement and names.
//
// (1) back-compatible.tsp moves several List/CheckAccess ops onto a synthetic
//     "BillingPermissions" sub-client (multi-language). GA SDK 1.2.2 instead exposed those
//     methods directly on the parent Resource (e.g. BillingAccountResource.GetBillingPermissions).
//     Override @@clientLocation with a C#-scoped directive that pins them back to the natural
//     parent interface so they appear on the parent Resource in the .NET SDK.
//
// (2) MPG derives Action/List method names from the operation identifier (e.g. "ListByBillingAccount"),
//     while GA SDK 1.2.2 used "GetBillingPermissions". Use @@clientName(..., "csharp") to override
//     just the C# method name, preserving wire/spec names.
// =====================================================================================

// (1) Pin BillingPermissions family back to their parent Resource for C# only.
@@clientLocation(
  BillingAccounts.listByBillingAccount,
  BillingAccounts,
  "csharp"
);
@@clientLocation(
  BillingAccounts.checkAccessByBillingAccount,
  BillingAccounts,
  "csharp"
);
@@clientLocation(
  BillingProfiles.listByBillingProfile,
  BillingProfiles,
  "csharp"
);
@@clientLocation(
  BillingProfiles.checkAccessByBillingProfile,
  BillingProfiles,
  "csharp"
);
@@clientLocation(Customers.listByCustomer, Customers, "csharp");
@@clientLocation(Customers.checkAccessByCustomer, Customers, "csharp");
@@clientLocation(
  CustomerOperationGroup.listByCustomerAtBillingAccount,
  CustomerOperationGroup,
  "csharp"
);
@@clientLocation(
  Departments.listByDepartment,
  Departments,
  "csharp"
);
@@clientLocation(
  Departments.checkAccessByDepartment,
  Departments,
  "csharp"
);
@@clientLocation(
  EnrollmentAccountOperationGroup.listByEnrollmentAccount,
  EnrollmentAccountOperationGroup,
  "csharp"
);
@@clientLocation(
  EnrollmentAccountOperationGroup.checkAccessByEnrollmentAccount,
  EnrollmentAccountOperationGroup,
  "csharp"
);
@@clientLocation(
  InvoiceSections.listByInvoiceSection,
  InvoiceSections,
  "csharp"
);
@@clientLocation(
  InvoiceSections.checkAccessByInvoiceSection,
  InvoiceSections,
  "csharp"
);

// (2a) Pattern A: BillingPermissions family - rename methods to GA-style names.
@@clientName(
  BillingAccounts.checkAccessByBillingAccount,
  "checkAccessBillingPermissions",
  "csharp"
);
@@clientName(
  BillingAccounts.listByBillingAccount,
  "getBillingPermissions",
  "csharp"
);
@@clientName(
  BillingProfiles.checkAccessByBillingProfile,
  "checkAccessBillingPermissions",
  "csharp"
);
@@clientName(
  BillingProfiles.listByBillingProfile,
  "getBillingPermissions",
  "csharp"
);
@@clientName(
  Customers.checkAccessByCustomer,
  "checkAccessBillingPermissions",
  "csharp"
);
@@clientName(
  Customers.listByCustomer,
  "getBillingPermissions",
  "csharp"
);
@@clientName(
  CustomerOperationGroup.listByCustomerAtBillingAccount,
  "getBillingPermissionsByCustomerAtBillingAccount",
  "csharp"
);
@@clientName(
  Departments.checkAccessByDepartment,
  "checkAccessBillingPermissions",
  "csharp"
);
@@clientName(
  Departments.listByDepartment,
  "getBillingPermissions",
  "csharp"
);
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
  InvoiceSections.checkAccessByInvoiceSection,
  "checkAccessBillingPermissions",
  "csharp"
);
@@clientName(
  InvoiceSections.listByInvoiceSection,
  "getBillingPermissions",
  "csharp"
);

// (2b) Pattern B: BillingRoleAssignment family - GA suffixes parent scope in method name.
@@clientName(
  BillingAccounts.createByBillingAccount,
  "createByBillingAccountBillingRoleAssignment",
  "csharp"
);
@@clientName(
  BillingAccounts.resolveByBillingAccount,
  "resolveByBillingAccountBillingRoleAssignment",
  "csharp"
);
@@clientName(
  BillingProfiles.createByBillingProfile,
  "createByBillingProfileBillingRoleAssignment",
  "csharp"
);
@@clientName(
  BillingProfiles.resolveByBillingProfile,
  "resolveByBillingProfileBillingRoleAssignment",
  "csharp"
);
@@clientName(
  Customers.createByCustomer,
  "createByCustomerBillingRoleAssignment",
  "csharp"
);
@@clientName(
  Customers.resolveByCustomer,
  "resolveByCustomerBillingRoleAssignment",
  "csharp"
);
@@clientName(
  InvoiceSections.createByInvoiceSection,
  "createByInvoiceSectionBillingRoleAssignment",
  "csharp"
);
@@clientName(
  InvoiceSections.resolveByInvoiceSection,
  "resolveByInvoiceSectionBillingRoleAssignment",
  "csharp"
);

// (2c) Pattern C-1: Individual ops needing GA-named restoration.
@@clientName(
  Invoices.transactionsDownloadByInvoice,
  "transactionsDownloadByInvoiceTransaction",
  "csharp"
);
@@clientName(
  Invoices.getTransactionSummaryByInvoice,
  "getTransactionSummaryByInvoiceTransaction",
  "csharp"
);
@@clientName(
  Customers.createOrUpdateByCustomer,
  "createOrUpdateByCustomerPolicy",
  "csharp"
);
