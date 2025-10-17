import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ClientGenerator.Core;
using Microsoft.Consumption;
using TypeSpec.Http;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(OperationStatus.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Marketplace.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(TagsResult.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Balance.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ReservationSummary.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ReservationDetail.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ReservationRecommendationDetailsModel.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ReservationTransaction.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ModernReservationTransaction.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ManagementGroupAggregatedCostResult.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(EventSummary.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(LotSummary.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(LegacyUsageDetail.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ModernUsageDetail.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(LegacyReservationTransaction.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(LegacyChargeSummary.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ModernChargeSummary.properties);

@@clientName(Budgets.createOrUpdate::parameters.resource, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Budget.properties);

@@clientLocation(PriceSheetResults.get, PriceSheet);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PriceSheetResult.properties);

@@clientLocation(CreditSummaries.get, "Credits");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CreditSummary.properties);

@@clientLocation(PriceSheetOperationGroup.downloadByBillingAccountPeriod,
  PriceSheet
);

@@clientLocation(UsageDetailsOperationGroup.list, "UsageDetails");

@@clientLocation(MarketplacesOperationGroup.list, "Marketplaces");

@@clientLocation(TagsOperationGroup.get, "Tags");

@@clientLocation(ChargesOperationGroup.list, "Charges");

@@clientLocation(BalancesOperationGroup.getByBillingAccount, "Balances");
@@clientLocation(BalancesOperationGroup.getForBillingPeriodByBillingAccount,
  "Balances"
);

@@clientLocation(ReservationsSummariesOperationGroup.listByReservationOrder,
  "ReservationsSummaries"
);
@@clientLocation(ReservationsSummariesOperationGroup.listByReservationOrderAndReservation,
  "ReservationsSummaries"
);
@@clientLocation(ReservationsSummariesOperationGroup.list,
  "ReservationsSummaries"
);

@@clientLocation(ReservationsDetailsOperationGroup.listByReservationOrder,
  "ReservationsDetails"
);
@@clientLocation(ReservationsDetailsOperationGroup.listByReservationOrderAndReservation,
  "ReservationsDetails"
);
@@clientLocation(ReservationsDetailsOperationGroup.list, "ReservationsDetails");

@@clientLocation(ReservationRecommendationsOperationGroup.list,
  "ReservationRecommendations"
);

@@clientLocation(ReservationRecommendationDetailsOperationGroup.get,
  "ReservationRecommendationDetails"
);

@@clientLocation(ReservationTransactionsOperationGroup.list,
  "ReservationTransactions"
);
@@clientLocation(ReservationTransactionsOperationGroup.listByBillingProfile,
  "ReservationTransactions"
);

@@clientLocation(AggregatedCostOperationGroup.getByManagementGroup,
  "AggregatedCost"
);
@@clientLocation(AggregatedCostOperationGroup.getForBillingPeriodByManagementGroup,
  "AggregatedCost"
);

@@clientLocation(EventsOperationGroup.listByBillingProfile, "Events");
@@clientLocation(EventsOperationGroup.listByBillingAccount, "Events");

@@clientLocation(LotsOperationGroup.listByBillingProfile, "Lots");
@@clientLocation(LotsOperationGroup.listByBillingAccount, "Lots");
@@clientLocation(LotsOperationGroup.listByCustomer, "Lots");

@@path(ResourceScopeActionScope.scope,
  #{ allowReserved: true, name: "resourceScope" }
);
@@clientName(ResourceScopeActionScope.scope, "resourceScope");

@@clientName(Amount, "amount");

@@clientName(Azure.ResourceManager.CommonTypes.Resource,
  "ArmResource",
  "python"
);
@@clientName(Azure.ResourceManager.CommonTypes.ProxyResource,
  "ArmProxyResource",
  "python"
);
@@clientName(Azure.ResourceManager.CommonTypes.ErrorResponse,
  "ArmErrorResponse",
  "python"
);

@@clientName(BudgetOperatorType.In, "IN_ENUM", "python");
@@clientName(Term.P1M, "P1_M", "python");
@@clientName(Term.P1Y, "P1_Y", "python");
@@clientName(Term.P3Y, "P3_Y", "python");
