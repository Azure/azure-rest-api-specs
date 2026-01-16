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

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(RoleAssignmentEntity.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PurchaseRequest.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ReservationOrderAliasRequest.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DiscountPatchRequest.properties
);

@@clientName(SavingsPlanOrderAliasModels.create::parameters.resource, "body");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SavingsPlanOrderAliasModel.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SavingsPlanOrderModel.properties
);

@@clientName(SavingsPlanModels.update::parameters.properties, "body");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SavingsPlanModel.properties
);

@@clientName(ReservationOrderAliasResponses.create::parameters.resource,
  "body"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ReservationOrderAliasResponse.properties
);

@@clientName(Discounts.create::parameters.resource, "body");
@@clientName(Discounts.update::parameters.properties, "body");
