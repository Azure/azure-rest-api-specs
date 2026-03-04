import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Billing;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ExtendedStatusInfo.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PurchaseRequest.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(BillingSubscriptionProperties.enrollmentAccountSubscriptionDetails
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(BillingSubscriptionPatch.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ReservationProperty.utilization);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ReservationPurchaseRequest.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ReservationPurchaseRequestProperties.reservedResourceProperties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Patch.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PatchProperties.renewProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(InitiateTransferRequest.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PartnerInitiateTransferRequest.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AcceptTransferRequest.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ValidateTransferResponse.properties);

@@clientName(AssociatedTenants.createOrUpdate::parameters.resource,
  "parameters"
);

@@clientLocation(AvailableBalanceOperationGroup.getByBillingProfile,
  AvailableBalances
);

@@clientName(BillingAccounts.update::parameters.properties, "parameters");
@@clientName(BillingAccounts.addPaymentTerms::parameters.body, "parameters");
@@clientName(BillingAccounts.cancelPaymentTerms::parameters.body, "parameters");
@@clientName(BillingAccounts.validatePaymentTerms::parameters.body,
  "parameters"
);
@@clientLocation(BillingAccounts.listByBillingAccount, "BillingPermissions");
@@clientLocation(BillingAccounts.checkAccessByBillingAccount,
  "BillingPermissions"
);
@@clientName(BillingAccounts.checkAccessByBillingAccount::parameters.body,
  "parameters"
);
@@clientLocation(BillingAccounts.billingRequestsListByBillingAccount,
  BillingRequests
);
@@clientName(BillingAccounts.billingRequestsListByBillingAccount,
  "ListByBillingAccount"
);
@@clientLocation(BillingAccounts.createByBillingAccount,
  BillingRoleAssignments
);
@@clientName(BillingAccounts.createByBillingAccount::parameters.body,
  "parameters"
);
@@clientLocation(BillingAccounts.resolveByBillingAccount,
  BillingRoleAssignments
);
@@clientLocation(BillingAccounts.savingsPlansListByBillingAccount,
  "SavingsPlans"
);
@@clientName(BillingAccounts.savingsPlansListByBillingAccount,
  "ListByBillingAccount"
);
@@clientLocation(BillingAccounts.downloadDocumentsByBillingAccount, Invoices);
@@clientName(BillingAccounts.downloadDocumentsByBillingAccount::parameters.body,
  "parameters"
);
@@clientLocation(BillingAccounts.reservationsListByBillingAccount,
  Reservations
);
@@clientName(BillingAccounts.reservationsListByBillingAccount,
  "ListByBillingAccount"
);

@@clientName(BillingProfiles.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(BillingProfiles.listByBillingProfile, "BillingPermissions");
@@clientLocation(BillingProfiles.checkAccessByBillingProfile,
  "BillingPermissions"
);
@@clientName(BillingProfiles.checkAccessByBillingProfile::parameters.body,
  "parameters"
);
@@clientLocation(BillingProfiles.billingRequestsListByBillingProfile,
  BillingRequests
);
@@clientName(BillingProfiles.billingRequestsListByBillingProfile,
  "ListByBillingProfile"
);
@@clientLocation(BillingProfiles.createByBillingProfile,
  BillingRoleAssignments
);
@@clientName(BillingProfiles.createByBillingProfile::parameters.body,
  "parameters"
);
@@clientLocation(BillingProfiles.resolveByBillingProfile,
  BillingRoleAssignments
);
@@clientLocation(BillingProfiles.invoicesListByBillingProfile, Invoices);
@@clientName(BillingProfiles.invoicesListByBillingProfile,
  "ListByBillingProfile"
);
@@clientLocation(BillingProfiles.productsListByBillingProfile, Products);
@@clientName(BillingProfiles.productsListByBillingProfile,
  "ListByBillingProfile"
);
@@clientLocation(BillingProfiles.reservationsListByBillingProfile,
  Reservations
);
@@clientName(BillingProfiles.reservationsListByBillingProfile,
  "ListByBillingProfile"
);
@@clientLocation(BillingProfiles.transactionsListByBillingProfile,
  "Transactions"
);
@@clientName(BillingProfiles.transactionsListByBillingProfile,
  "ListByBillingProfile"
);

@@clientLocation(BillingProperties.get, "BillingProperty");
@@clientLocation(BillingProperties.update, "BillingProperty");
@@clientName(BillingProperties.update::parameters.properties, "parameters");

@@clientName(BillingRequests.createOrUpdate::parameters.resource, "parameters");

@@clientLocation(BillingRoleAssignmentByCustomer.getByCustomer,
  BillingRoleAssignments
);
@@clientLocation(BillingRoleAssignmentByCustomer.deleteByCustomer,
  BillingRoleAssignments
);
@@clientLocation(BillingRoleAssignmentByCustomer.listByCustomer,
  BillingRoleAssignments
);
@@clientLocation(BillingRoleAssignmentByInvoiceSection.getByInvoiceSection,
  BillingRoleAssignments
);
@@clientLocation(BillingRoleAssignmentByInvoiceSection.deleteByInvoiceSection,
  BillingRoleAssignments
);
@@clientLocation(BillingRoleAssignmentByInvoiceSection.listByInvoiceSection,
  BillingRoleAssignments
);
@@clientLocation(BillingRoleAssignmentByBillingAccount.getByBillingAccount,
  BillingRoleAssignments
);
@@clientLocation(BillingRoleAssignmentByBillingAccount.createOrUpdateByBillingAccount,
  BillingRoleAssignments
);
@@clientName(BillingRoleAssignmentByBillingAccount.createOrUpdateByBillingAccount::parameters.resource,
  "parameters"
);
@@clientLocation(BillingRoleAssignmentByBillingAccount.deleteByBillingAccount,
  BillingRoleAssignments
);
@@clientLocation(BillingRoleAssignmentByBillingAccount.listByBillingAccount,
  BillingRoleAssignments
);
@@clientLocation(BillingRoleAssignmentByDepartment.getByDepartment,
  BillingRoleAssignments
);
@@clientLocation(BillingRoleAssignmentByDepartment.createOrUpdateByDepartment,
  BillingRoleAssignments
);
@@clientName(BillingRoleAssignmentByDepartment.createOrUpdateByDepartment::parameters.resource,
  "parameters"
);
@@clientLocation(BillingRoleAssignmentByDepartment.deleteByDepartment,
  BillingRoleAssignments
);
@@clientLocation(BillingRoleAssignmentByDepartment.listByDepartment,
  BillingRoleAssignments
);
@@clientLocation(BillingRoleAssignmentByEnrollmentAccount.getByEnrollmentAccount,
  BillingRoleAssignments
);
@@clientLocation(BillingRoleAssignmentByEnrollmentAccount.createOrUpdateByEnrollmentAccount,
  BillingRoleAssignments
);
@@clientName(BillingRoleAssignmentByEnrollmentAccount.createOrUpdateByEnrollmentAccount::parameters.resource,
  "parameters"
);
@@clientLocation(BillingRoleAssignmentByEnrollmentAccount.deleteByEnrollmentAccount,
  BillingRoleAssignments
);
@@clientLocation(BillingRoleAssignmentByEnrollmentAccount.listByEnrollmentAccount,
  BillingRoleAssignments
);

@@clientLocation(BillingRoleDefinitions.getByBillingProfile,
  "BillingRoleDefinition"
);
@@clientLocation(BillingRoleDefinitions.listByBillingProfile,
  "BillingRoleDefinition"
);
@@clientLocation(BillingRoleDefinitionByCustomer.getByCustomer,
  "BillingRoleDefinition"
);
@@clientLocation(BillingRoleDefinitionByCustomer.listByCustomer,
  "BillingRoleDefinition"
);
@@clientLocation(BillingRoleDefinitionByInvoiceSection.getByInvoiceSection,
  "BillingRoleDefinition"
);
@@clientLocation(BillingRoleDefinitionByInvoiceSection.listByInvoiceSection,
  "BillingRoleDefinition"
);
@@clientLocation(BillingRoleDefinitionByBillingAccount.getByBillingAccount,
  "BillingRoleDefinition"
);
@@clientLocation(BillingRoleDefinitionByBillingAccount.listByBillingAccount,
  "BillingRoleDefinition"
);
@@clientLocation(BillingRoleDefinitionByDepartment.getByDepartment,
  "BillingRoleDefinition"
);
@@clientLocation(BillingRoleDefinitionByDepartment.listByDepartment,
  "BillingRoleDefinition"
);
@@clientLocation(BillingRoleDefinitionByEnrollmentAccount.getByEnrollmentAccount,
  "BillingRoleDefinition"
);
@@clientLocation(BillingRoleDefinitionByEnrollmentAccount.listByEnrollmentAccount,
  "BillingRoleDefinition"
);

@@clientLocation(SavingsPlanOrderModels.getByBillingAccount,
  "SavingsPlanOrders"
);
@@clientLocation(SavingsPlanOrderModels.listByBillingAccount,
  "SavingsPlanOrders"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SavingsPlanOrderModel.properties);

@@clientLocation(SavingsPlanModels.getByBillingAccount, "SavingsPlans");
@@clientLocation(SavingsPlanModels.updateByBillingAccount, "SavingsPlans");
@@clientName(SavingsPlanModels.updateByBillingAccount::parameters.properties,
  "body"
);
@@clientLocation(SavingsPlanModels.listBySavingsPlanOrder, "SavingsPlans");
@@clientLocation(SavingsPlanModels.validateUpdateByBillingAccount,
  "SavingsPlans"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SavingsPlanModel.properties);

@@clientLocation(BillingSubscriptionOperationGroup.get, BillingSubscriptions);
@@clientLocation(BillingSubscriptionOperationGroup.update,
  BillingSubscriptions
);
@@clientName(BillingSubscriptionOperationGroup.update::parameters.properties,
  "parameters"
);
@@clientLocation(BillingSubscriptionOperationGroup.delete,
  BillingSubscriptions
);
@@clientLocation(BillingSubscriptionOperationGroup.listByBillingAccount,
  BillingSubscriptions
);
@@clientLocation(BillingSubscriptionOperationGroup.cancel,
  BillingSubscriptions
);
@@clientName(BillingSubscriptionOperationGroup.cancel::parameters.body,
  "parameters"
);
@@clientLocation(BillingSubscriptionOperationGroup.merge, BillingSubscriptions);
@@clientName(BillingSubscriptionOperationGroup.merge::parameters.body,
  "parameters"
);
@@clientLocation(BillingSubscriptionOperationGroup.move, BillingSubscriptions);
@@clientName(BillingSubscriptionOperationGroup.move::parameters.body,
  "parameters"
);
@@clientLocation(BillingSubscriptionOperationGroup.split, BillingSubscriptions);
@@clientName(BillingSubscriptionOperationGroup.split::parameters.body,
  "parameters"
);
@@clientLocation(BillingSubscriptionOperationGroup.validateMoveEligibility,
  BillingSubscriptions
);
@@clientName(BillingSubscriptionOperationGroup.validateMoveEligibility::parameters.body,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(BillingSubscription.properties);

@@clientLocation(BillingSubscriptionAliases.get, "BillingSubscriptionsAliases");
@@clientLocation(BillingSubscriptionAliases.createOrUpdate,
  "BillingSubscriptionsAliases"
);
@@clientName(BillingSubscriptionAliases.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(BillingSubscriptionAliases.listByBillingAccount,
  "BillingSubscriptionsAliases"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(BillingSubscriptionAlias.properties);

@@clientLocation(Customers.listByCustomer, "BillingPermissions");
@@clientLocation(Customers.checkAccessByCustomer, "BillingPermissions");
@@clientName(Customers.checkAccessByCustomer::parameters.body, "parameters");
@@clientLocation(Customers.billingRequestsListByCustomer, BillingRequests);
@@clientName(Customers.billingRequestsListByCustomer, "ListByCustomer");
@@clientLocation(Customers.createByCustomer, BillingRoleAssignments);
@@clientName(Customers.createByCustomer::parameters.body, "parameters");
@@clientLocation(Customers.resolveByCustomer, BillingRoleAssignments);
@@clientLocation(Customers.billingSubscriptionsListByCustomer,
  BillingSubscriptions
);
@@clientName(Customers.billingSubscriptionsListByCustomer, "ListByCustomer");
@@clientLocation(Customers.createOrUpdateByCustomer, Policies);
@@clientName(Customers.createOrUpdateByCustomer::parameters.body, "parameters");
@@clientLocation(Customers.transactionsListByCustomer, "Transactions");
@@clientName(Customers.transactionsListByCustomer, "ListByCustomer");
@@clientLocation(CustomerOperationGroup.getByBillingAccount, Customers);
@@clientLocation(CustomerOperationGroup.listByBillingAccount, Customers);
@@clientLocation(CustomerOperationGroup.listByCustomerAtBillingAccount,
  "BillingPermissions"
);
@@clientLocation(CustomerOperationGroup.billingSubscriptionsListByCustomerAtBillingAccount,
  BillingSubscriptions
);
@@clientName(CustomerOperationGroup.billingSubscriptionsListByCustomerAtBillingAccount,
  "ListByCustomerAtBillingAccount"
);
@@clientLocation(CustomerOperationGroup.listByCustomer, Products);

@@clientLocation(Departments.listByDepartment, "BillingPermissions");
@@clientLocation(Departments.checkAccessByDepartment, "BillingPermissions");
@@clientName(Departments.checkAccessByDepartment::parameters.body,
  "parameters"
);

@@clientLocation(EnrollmentAccountOperationGroup.get, EnrollmentAccounts);
@@clientLocation(EnrollmentAccountOperationGroup.listByBillingAccount,
  EnrollmentAccounts
);
@@clientLocation(EnrollmentAccountOperationGroup.listByEnrollmentAccount,
  "BillingPermissions"
);
@@clientLocation(EnrollmentAccountOperationGroup.checkAccessByEnrollmentAccount,
  "BillingPermissions"
);
@@clientName(EnrollmentAccountOperationGroup.checkAccessByEnrollmentAccount::parameters.body,
  "parameters"
);
@@clientLocation(EnrollmentAccountOperationGroup.billingSubscriptionsListByEnrollmentAccount,
  BillingSubscriptions
);
@@clientName(EnrollmentAccountOperationGroup.billingSubscriptionsListByEnrollmentAccount,
  "ListByEnrollmentAccount"
);

@@clientLocation(Invoices.listByInvoice, "Transactions");
@@clientLocation(Invoices.transactionsDownloadByInvoice, "Transactions");
@@clientLocation(Invoices.getTransactionSummaryByInvoice, "Transactions");
@@clientLocation(InvoiceByBillingSubscription.getByBillingSubscription,
  Invoices
);
@@clientLocation(InvoiceByBillingSubscription.listByBillingSubscription,
  Invoices
);
@@clientLocation(InvoiceByBillingSubscription.downloadByBillingSubscription,
  Invoices
);
@@clientLocation(InvoiceById.get, Invoices);

@@clientName(InvoiceSections.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(InvoiceSections.listByInvoiceSection, "BillingPermissions");
@@clientLocation(InvoiceSections.checkAccessByInvoiceSection,
  "BillingPermissions"
);
@@clientName(InvoiceSections.checkAccessByInvoiceSection::parameters.body,
  "parameters"
);
@@clientLocation(InvoiceSections.billingRequestsListByInvoiceSection,
  BillingRequests
);
@@clientName(InvoiceSections.billingRequestsListByInvoiceSection,
  "ListByInvoiceSection"
);
@@clientLocation(InvoiceSections.createByInvoiceSection,
  BillingRoleAssignments
);
@@clientName(InvoiceSections.createByInvoiceSection::parameters.body,
  "parameters"
);
@@clientLocation(InvoiceSections.resolveByInvoiceSection,
  BillingRoleAssignments
);
@@clientLocation(InvoiceSections.billingSubscriptionsListByInvoiceSection,
  BillingSubscriptions
);
@@clientName(InvoiceSections.billingSubscriptionsListByInvoiceSection,
  "ListByInvoiceSection"
);
@@clientLocation(InvoiceSections.productsListByInvoiceSection, Products);
@@clientName(InvoiceSections.productsListByInvoiceSection,
  "ListByInvoiceSection"
);
@@clientLocation(InvoiceSections.transactionsListByInvoiceSection,
  "Transactions"
);
@@clientName(InvoiceSections.transactionsListByInvoiceSection,
  "ListByInvoiceSection"
);

@@clientLocation(PaymentMethodLinks.getByBillingProfile, PaymentMethods);
@@clientLocation(PaymentMethodLinks.listByBillingProfile, PaymentMethods);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PaymentMethodLink.properties);

@@clientLocation(PaymentMethodOperationGroup.getByUser, PaymentMethods);
@@clientLocation(PaymentMethodOperationGroup.deleteByUser, PaymentMethods);
@@clientLocation(PaymentMethodOperationGroup.listByUser, PaymentMethods);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PaymentMethod.properties);

@@clientLocation(CustomerPolicies.getByCustomer, Policies);
@@clientName(Policies.createOrUpdateByCustomerAtBillingAccount::parameters.resource,
  "parameters"
);

@@clientLocation(BillingProfilePolicies.getByBillingProfile, Policies);
@@clientLocation(BillingProfilePolicies.createOrUpdateByBillingProfile,
  Policies
);
@@clientName(BillingProfilePolicies.createOrUpdateByBillingProfile::parameters.resource,
  "parameters"
);

@@clientLocation(BillingAccountPolicies.getByBillingAccount, Policies);
@@clientLocation(BillingAccountPolicies.createOrUpdateByBillingAccount,
  Policies
);
@@clientName(BillingAccountPolicies.createOrUpdateByBillingAccount::parameters.resource,
  "parameters"
);

@@clientLocation(SubscriptionPolicies.getBySubscription, Policies);

@@clientName(Products.update::parameters.properties, "parameters");
@@clientName(Products.move::parameters.body, "parameters");
@@clientName(Products.validateMoveEligibility::parameters.body, "parameters");

@@clientName(Reservations.updateByBillingAccount::parameters.properties,
  "body"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Reservation.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ReservationOrder.properties);

@@clientName(Transfers.initiate::parameters.resource, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(TransferDetails.properties);

@@clientName(PartnerTransfers.initiate::parameters.resource, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PartnerTransferDetails.properties);

@@clientName(RecipientTransfers.accept::parameters.body, "parameters");
@@clientName(RecipientTransfers.validate::parameters.body, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RecipientTransferDetails.properties);

@@clientLocation(AddressOperationGroup.validate, "Address");

@@clientLocation(InvoicesOperationGroup.downloadDocumentsByBillingSubscription,
  Invoices
);
@@clientName(InvoicesOperationGroup.downloadDocumentsByBillingSubscription::parameters.downloadUrls,
  "parameters"
);

@@clientName(AddressOperationGroup.validate::parameters.body, "parameters");

@@Azure.ResourceManager.identifiers(InvoiceSectionWithCreateSubPermissionListResult.value,
  #["invoiceSectionId"]
);

@@Azure.ResourceManager.identifiers(AgreementListResult.value, #["id"]);
@@Azure.ResourceManager.identifiers(AssociatedTenantListResult.value, #["id"]);
@@Azure.ResourceManager.identifiers(BillingAccountListResult.value, #["id"]);
@@Azure.ResourceManager.identifiers(BillingProfileListResult.value, #["id"]);
@@Azure.ResourceManager.identifiers(BillingRequestListResult.value, #["id"]);
@@Azure.ResourceManager.identifiers(BillingRoleAssignmentListResult.value,
  #["id"]
);
@@Azure.ResourceManager.identifiers(BillingRoleDefinitionListResult.value,
  #["id"]
);
@@Azure.ResourceManager.identifiers(BillingSubscriptionAliasListResult.value,
  #["id"]
);
@@Azure.ResourceManager.identifiers(CustomerListResult.value, #["id"]);
@@Azure.ResourceManager.identifiers(DepartmentListResult.value, #["id"]);
@@Azure.ResourceManager.identifiers(EnrollmentAccountListResult.value, #["id"]);
@@Azure.ResourceManager.identifiers(InvoiceListResult.value, #["id"]);
@@Azure.ResourceManager.identifiers(InvoiceSectionListResult.value, #["id"]);
@@Azure.ResourceManager.identifiers(PaymentMethodLinksListResult.value,
  #["id"]
);
@@Azure.ResourceManager.identifiers(PaymentMethodsListResult.value, #["id"]);
@@Azure.ResourceManager.identifiers(ProductListResult.value, #["id"]);
@@Azure.ResourceManager.identifiers(TransactionListResult.value, #["id"]);

@@visibility(AgreementListResult.value, Lifecycle.Read);
@@visibility(AssociatedTenantListResult.value, Lifecycle.Read);
@@visibility(BillingProfileListResult.value, Lifecycle.Read);
@@visibility(BillingRequestListResult.value, Lifecycle.Read);
@@visibility(BillingRoleAssignmentListResult.value, Lifecycle.Read);
@@visibility(BillingRoleDefinitionListResult.value, Lifecycle.Read);
@@visibility(BillingSubscriptionAliasListResult.value, Lifecycle.Read);
@@visibility(CustomerListResult.value, Lifecycle.Read);
@@visibility(DepartmentListResult.value, Lifecycle.Read);
@@visibility(EnrollmentAccountListResult.value, Lifecycle.Read);
@@visibility(InvoiceListResult.value, Lifecycle.Read);
@@visibility(InvoiceSectionListResult.value, Lifecycle.Read);
@@visibility(PaymentMethodLinksListResult.value, Lifecycle.Read);
@@visibility(PaymentMethodsListResult.value, Lifecycle.Read);
@@visibility(ProductListResult.value, Lifecycle.Read);
@@visibility(TransactionListResult.value, Lifecycle.Read);
@@visibility(BillingAccountListResult.value, Lifecycle.Read);
@@visibility(BillingPermissionListResult.value, Lifecycle.Read);
@@visibility(InvoiceSectionWithCreateSubPermissionListResult.value,
  Lifecycle.Read
);
@@visibility(PartnerTransferDetailsListResult.value, Lifecycle.Read);
@@visibility(RecipientTransferDetailsListResult.value, Lifecycle.Read);
@@visibility(TransferDetailsListResult.value, Lifecycle.Read);
