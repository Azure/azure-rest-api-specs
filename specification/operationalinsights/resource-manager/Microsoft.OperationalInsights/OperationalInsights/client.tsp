import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.OperationalInsights;

@@clientName(Microsoft.OperationalInsights,
  "OperationalInsightsManagementClient",
  "javascript"
);
@@clientName(LogAnalyticsQueryPacks.search, "listSearch", "javascript");
