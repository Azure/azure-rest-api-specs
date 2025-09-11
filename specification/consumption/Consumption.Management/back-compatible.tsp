import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Consumption;
using TypeSpec.Http;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Legacy.flattenProperty decorator is not recommended to use."
@@Legacy.flattenProperty(OperationStatus.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Legacy.flattenProperty decorator is not recommended to use."
@@Legacy.flattenProperty(Marketplace.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Legacy.flattenProperty decorator is not recommended to use."
@@Legacy.flattenProperty(TagsResult.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Legacy.flattenProperty decorator is not recommended to use."
@@Legacy.flattenProperty(Balance.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Legacy.flattenProperty decorator is not recommended to use."
@@Legacy.flattenProperty(ReservationSummary.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Legacy.flattenProperty decorator is not recommended to use."
@@Legacy.flattenProperty(ReservationDetail.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Legacy.flattenProperty decorator is not recommended to use."
@@Legacy.flattenProperty(ReservationRecommendationDetailsModel.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Legacy.flattenProperty decorator is not recommended to use."
@@Legacy.flattenProperty(ReservationTransaction.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Legacy.flattenProperty decorator is not recommended to use."
@@Legacy.flattenProperty(ModernReservationTransaction.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Legacy.flattenProperty decorator is not recommended to use."
@@Legacy.flattenProperty(ManagementGroupAggregatedCostResult.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Legacy.flattenProperty decorator is not recommended to use."
@@Legacy.flattenProperty(EventSummary.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Legacy.flattenProperty decorator is not recommended to use."
@@Legacy.flattenProperty(LotSummary.properties);

@@clientName(LotProperties.OrganizationType, "organizationType");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Legacy.flattenProperty decorator is not recommended to use."
@@Legacy.flattenProperty(LegacyUsageDetail.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Legacy.flattenProperty decorator is not recommended to use."
@@Legacy.flattenProperty(ModernUsageDetail.properties);

// #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Legacy.flattenProperty decorator is not recommended to use."
// @@Legacy.flattenProperty(LegacyReservationRecommendation.properties);

// #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Legacy.flattenProperty decorator is not recommended to use."
// @@Legacy.flattenProperty(ModernReservationRecommendation.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Legacy.flattenProperty decorator is not recommended to use."
@@Legacy.flattenProperty(LegacyChargeSummary.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Legacy.flattenProperty decorator is not recommended to use."
@@Legacy.flattenProperty(ModernChargeSummary.properties);

@@clientName(Budgets.createOrUpdate::parameters.resource, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Legacy.flattenProperty decorator is not recommended to use."
@@Legacy.flattenProperty(Budget.properties);

@@clientLocation(PriceSheetResults.get, PriceSheet);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Legacy.flattenProperty decorator is not recommended to use."
@@Legacy.flattenProperty(PriceSheetResult.properties);

@@clientLocation(CreditSummaries.get, "Credits");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@Legacy.flattenProperty decorator is not recommended to use."
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
