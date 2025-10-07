import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.BillingBenefits;

// @@clientLocation and @@clientName decorators for operations that originally had @operationId
// All @operationId decorators have been removed and replaced with these client customizations
@@clientLocation(SavingsPlanOperationGroup.listAll, "SavingsPlan");

@@clientName(validatePurchase, "ValidatePurchase");
@@clientLocation(BenefitOperationGroup.validate, "Benefit");
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
@@clientLocation(ConditionalCreditsOperationGroup.scopeList,
  ConditionalCredits
);
@@clientLocation(CreditsOperationGroup.listApplicable, Credits);
@@clientLocation(MaccsOperationGroup.list, "ApplicableMaccs");
@@clientLocation(ContributorsOperationGroup.listFromApplicableMacc,
  Contributors
);
@@clientLocation(SellerResourceOperationGroup.list, "SellerResource");

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

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(MaccPatchRequest.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SellerResourceListRequest.properties
);

@@clientName(SellerResourceListRequestProperties.$filter, "filter");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CreditPatchRequest.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(MaccValidateModel.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CreditsValidateModel.properties
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

@@clientName(Discounts.create::parameters.resource, "body");
@@clientName(Discounts.update::parameters.properties, "body");

@@clientName(Maccs.create::parameters.resource, "body");
@@clientName(Maccs.update::parameters.properties, "body");

@@clientName(Credits.create::parameters.resource, "body");
@@clientName(Credits.update::parameters.properties, "body");

@@clientName(CreditSources.create::parameters.resource, "body");
@@clientName(CreditSources.update::parameters.properties, "body");

@@clientName(ConditionalCredits.createOrUpdate::parameters.resource, "body");
@@clientName(ConditionalCredits.update::parameters.properties, "body");
