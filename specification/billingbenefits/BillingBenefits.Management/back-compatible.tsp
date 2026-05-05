import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.BillingBenefits;

// @@clientLocation and @@clientName decorators for operations that originally had @operationId
// All @operationId decorators have been removed and replaced with these client customizations
@@clientLocation(SavingsPlanOperationGroup.listAll, "SavingsPlan");

@@clientLocation(DiscountsOperationGroup.scopeList, Discounts);
@@clientLocation(ReservationOrderAliasResponses.get, "ReservationOrderAlias");
@@clientLocation(ReservationOrderAliasResponses.create,
  "ReservationOrderAlias"
);
@@clientLocation(SavingsPlanModels.get, "SavingsPlan");
@@clientLocation(SavingsPlanModels.update, "SavingsPlan");
@@clientLocation(SavingsPlanModels.list, "SavingsPlan");
@@clientLocation(SavingsPlanModels.validateUpdate, "SavingsPlan");
@@clientLocation(SavingsPlanOrderAliasModels.get, "SavingsPlanOrderAlias");
@@clientLocation(SavingsPlanOrderAliasModels.create, "SavingsPlanOrderAlias");
@@clientLocation(SavingsPlanOrderModels.get, "SavingsPlanOrder");
@@clientLocation(SavingsPlanOrderModels.list, "SavingsPlanOrder");
@@clientLocation(SavingsPlanOrderModels.elevate, "SavingsPlanOrder");
@@clientLocation(Discounts.get, "Discount");
@@clientLocation(Discounts.update, "Discount");
@@clientLocation(BenefitOperationGroup.validate, "Benefit");
@@clientLocation(ContributorsOperationGroup.listFromApplicableMacc,
  Contributors
);
@@clientLocation(SellerResourceOperationGroup.list, "SellerResource");
@@clientLocation(ApplicableMaccsOperationGroup.list, "ApplicableMaccs");
@@clientLocation(CreditsOperationGroup.listApplicable, Credits);
@@clientLocation(ConditionalCreditsOperationGroup.scopeList,
  ConditionalCredits
);
@@clientLocation(ConditionalCreditContributorsOperationGroup.listFromApplicableConditionalCredit,
  ConditionalCreditContributors
);
@@clientLocation(CreditSources.get, "Sources");
@@clientLocation(CreditSources.create, "Sources");
@@clientLocation(CreditSources.update, "Sources");
@@clientLocation(CreditSources.delete, "Sources");
@@clientLocation(CreditSources.listByCredit, "Sources");
@@clientLocation(FreeServicesOperations.get, "FreeServices");
@@clientLocation(FreeServicesOperations.create, "FreeServices");
@@clientLocation(FreeServicesOperations.update, "FreeServices");
@@clientLocation(FreeServicesOperations.delete, "FreeServices");
@@clientLocation(FreeServicesOperations.listByResourceGroup, "FreeServices");
@@clientLocation(FreeServicesOperations.listBySubscription, "FreeServices");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(RoleAssignmentEntity.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PurchaseRequest.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ReservationOrderAliasRequest.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DiscountPatchRequest.properties
);

@@clientName(SavingsPlanOrderAliasModels.create::parameters.resource, "body");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SavingsPlanOrderAliasModel.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SavingsPlanOrderModel.properties
);

@@clientName(SavingsPlanModels.update::parameters.properties, "body");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SavingsPlanModel.properties
);

@@clientName(ReservationOrderAliasResponses.create::parameters.resource,
  "body"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ReservationOrderAliasResponse.properties
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(MaccPatchRequest.properties
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ChargeShortfallRequest.properties
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SellerResourceListRequest.properties
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ApplicableMacc.properties);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CreditPatchRequest.properties
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ConditionalCreditPatchRequest.properties
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CreditSource.properties);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Credit.properties);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ConditionalCreditContributor.properties
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Contributor.properties);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CreditsValidateModel.properties
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Macc.properties);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(MaccValidateModel.properties
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SavingsPlanValidateModel.properties
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(FreeServices.properties);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(FreeServicesPatchRequest.properties
);

@@clientName(Discounts.create::parameters.resource, "body");
@@clientName(Discounts.update::parameters.properties, "body");
@@clientName(ConditionalCredits.createOrUpdate::parameters.resource, "body");
@@clientName(ConditionalCredits.update::parameters.properties, "body");
@@clientName(Credits.create::parameters.resource, "body");
@@clientName(Credits.update::parameters.properties, "body");
@@clientName(CreditSources.create::parameters.resource, "body");
@@clientName(CreditSources.update::parameters.properties, "body");
@@clientName(Maccs.create::parameters.resource, "body");
@@clientName(Maccs.update::parameters.properties, "body");
@@clientName(FreeServicesOperations.create::parameters.resource, "body");
@@clientName(FreeServicesOperations.update::parameters.properties, "body");

@@doc(Azure.ResourceManager.ArmAsyncOperationHeader.azureAsyncOperation,
  "URL for checking the ongoing status of the operation."
);
@@doc(Azure.ResourceManager.ArmCombinedLroHeaders.azureAsyncOperation,
  "URL for checking the ongoing status of the operation."
);
@@doc(Azure.ResourceManager.ArmCombinedLroHeaders.location,
  "Location URI to poll for result."
);
