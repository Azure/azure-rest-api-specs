import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.ResourceManager.CommonTypes;
using Microsoft.Carbon;

@@clientName(CarbonEmissionTopItemMonthlySummaryData,
  "CarbonEmissionTopItemMonthlySummary",
  "csharp"
);
@@clientName(CarbonEmissionTopItemsSummaryData,
  "CarbonEmissionTopItemsSummary",
  "csharp"
);
@@clientName(CarbonEmissionData, "CarbonEmission", "csharp");
@@clientName(CarbonEmissionItemDetailData,
  "CarbonEmissionItemDetail",
  "csharp"
);
@@clientName(CarbonEmissionMonthlySummaryData,
  "CarbonEmissionMonthlySummary",
  "csharp"
);
@@clientName(CarbonEmissionOverallSummaryData,
  "CarbonEmissionOverallSummary",
  "csharp"
);
@@clientName(ResourceGroupCarbonEmissionTopItemsSummaryData,
  "ResourceGroupCarbonEmissionTopItemsSummary",
  "csharp"
);
@@clientName(ResourceCarbonEmissionItemDetailData,
  "ResourceCarbonEmissionItemDetail",
  "csharp"
);
@@clientName(ResourceCarbonEmissionTopItemMonthlySummaryData,
  "ResourceCarbonEmissionTopItemMonthlySummary",
  "csharp"
);
@@clientName(ResourceCarbonEmissionTopItemsSummaryData,
  "ResourceCarbonEmissionTopItemsSummary",
  "csharp"
);
@@clientName(ResourceGroupCarbonEmissionItemDetailData,
  "ResourceGroupCarbonEmissionItemDetail",
  "csharp"
);
@@clientName(ResourceGroupCarbonEmissionTopItemMonthlySummaryData,
  "ResourceGroupCarbonEmissionTopItemMonthlySummary",
  "csharp"
);
@@clientName(Microsoft.Carbon, "CarbonOptimizationMgmt", "python");
@@clientName(Microsoft.Carbon, "CarbonOptimizationManagementClient", "java");
