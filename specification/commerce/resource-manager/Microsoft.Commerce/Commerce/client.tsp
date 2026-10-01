import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Commerce;

@@clientName(Microsoft.Commerce, "UsageManagementClient", "python, javascript");
@@clientName(RateCardOperationGroup.get, "GetRateCard", "csharp");
@@clientName(
  UsageAggregatesOperationGroup.list,
  "GetUsageAggregates",
  "csharp"
);
@@clientName(
  AggregationGranularity,
  "CommerceUsageAggregationGranularity",
  "csharp"
);
@@clientName(MeterInfo, "CommerceMeterInfo", "csharp");
@@clientName(MonetaryCommitment, "CommerceMonetaryCommitment", "csharp");
@@clientName(MonetaryCredit, "CommerceMonetaryCredit", "csharp");
@@clientName(OfferTermInfo, "CommerceOfferTermInfo", "csharp");
@@clientName(ResourceRateCardInfo, "CommerceRateCardInfo", "csharp");
@@clientName(RecurringCharge, "CommerceRecurringCharge", "csharp");
@@clientName(RecurringCharge.RecurringCharge, "Amount", "csharp");
@@clientName(UsageAggregation, "CommerceUsageAggregation", "csharp");
@@clientName(OfferTermInfoName, "KnownOfferTermInfoName", "csharp");

/** Name of the offer term. */
union OfferTermInfoNameForCSharp {
  string,

  /** Recurring Charge. */
  RecurringCharge: "Recurring Charge",

  /** Monetary Commitment. */
  MonetaryCommitment: "Monetary Commitment",

  /** Monetary Credit. */
  MonetaryCredit: "Monetary Credit",
}

@@clientName(OfferTermInfoNameForCSharp, "OfferTermInfoName", "csharp");
@@alternateType(OfferTermInfoName, OfferTermInfoNameForCSharp, "csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  UsageAggregatesOperationGroupListParameters.aggregationGranularity,
  "Daily",
  "javascript,python"
);
