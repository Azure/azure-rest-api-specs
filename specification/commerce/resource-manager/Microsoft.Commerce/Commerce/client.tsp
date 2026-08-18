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
@@clientName(RecurringCharge.RecurringCharge, "Amount", "csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(
  UsageAggregatesOperationGroupListParameters.aggregationGranularity,
  "Daily",
  "javascript,python"
);
