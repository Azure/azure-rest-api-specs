import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Consumption;
using TypeSpec.Http;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(OperationStatus.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Marketplace.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TagsResult.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Balance.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ReservationSummary.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ReservationDetail.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ReservationRecommendationDetailsModel.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ReservationTransaction.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ModernReservationTransaction.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ManagementGroupAggregatedCostResult.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(EventSummary.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(LotSummary.properties);

@@clientName(LotProperties.OrganizationType, "organizationType");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(LegacyUsageDetail.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ModernUsageDetail.properties);

// #suppress "deprecated" "@flattenProperty decorator is not recommended to use."
// @@flattenProperty(LegacyReservationRecommendation.properties);

// #suppress "deprecated" "@flattenProperty decorator is not recommended to use."
// @@flattenProperty(ModernReservationRecommendation.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(LegacyChargeSummary.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ModernChargeSummary.properties);

@@clientName(Budgets.createOrUpdate::parameters.resource, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Budget.properties);

@@clientLocation(PriceSheetResults.get, PriceSheet);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PriceSheetResult.properties);

@@clientLocation(CreditSummaries.get, "Credits");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CreditSummary.properties);

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
