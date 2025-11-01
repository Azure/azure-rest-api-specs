import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Microsoft.Carbon;

@@clientName(Microsoft.Carbon, "CarbonOptimizationMgmtClient", "python");
@@clientName(Microsoft.Carbon, "CarbonOptimizationManagementClient", "java");

// CSharp
@@clientName(CarbonService.queryCarbonEmissionReports,
  "QueryCarbonEmissionReports",
  "csharp"
);
@@clientName(CarbonService.queryCarbonEmissionDataAvailableDateRange,
  "QueryCarbonEmissionAvailableDateRange",
  "csharp"
);
@@clientName(CarbonEmissionDataListResult,
  "CarbonEmissionListResult",
  "csharp"
);
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
@@clientName(Microsoft.Carbon, "CarbonOptimizationMgmtClient", "python");
@@clientName(Microsoft.Carbon, "CarbonOptimizationManagementClient", "java");
@@clientName(Microsoft.Carbon,
  "CarbonOptimizationManagementClient",
  "javascript"
);
@@clientName(CarbonEmissionDataAvailableDateRange,
  "CarbonEmissionAvailableDateRange",
  "csharp"
);
@@clientName(CategoryTypeEnum, "CarbonEmissionCategoryType", "csharp");
@@clientName(EmissionScopeEnum, "CarbonEmissionScope", "csharp");
@@clientName(AccessDecisionEnum, "CarbonEmissionAccessDecision", "csharp");
@@clientName(ReportTypeEnum, "CarbonEmissionQueryReportType", "csharp");
@@clientName(DateRange, "CarbonEmissionQueryDateRange", "csharp");
@@clientName(DateRange.start, "StartOn", "csharp");
@@clientName(DateRange.end, "EndOn", "csharp");
@@clientName(QueryFilter, "CarbonEmissionQueryFilter", "csharp");
@@clientName(OrderByColumnEnum, "CarbonEmissionQueryOrderByColumn", "csharp");
@@clientName(ResourceGroupCarbonEmissionTopItemsSummaryData.resourceGroupUrl,
  "ResourceGroupId",
  "csharp"
);
@@alternateType(ResourceGroupCarbonEmissionTopItemsSummaryData.resourceGroupUrl,
  armResourceIdentifier,
  "csharp"
);
@@clientName(ResourceGroupCarbonEmissionTopItemMonthlySummaryData.resourceGroupUrl,
  "ResourceGroupId",
  "csharp"
);
@@alternateType(ResourceGroupCarbonEmissionTopItemMonthlySummaryData.resourceGroupUrl,
  armResourceIdentifier,
  "csharp"
);
@@clientName(ResourceGroupCarbonEmissionItemDetailData.resourceGroupUrl,
  "ResourceGroupId",
  "csharp"
);
@@alternateType(ResourceGroupCarbonEmissionItemDetailData.resourceGroupUrl,
  armResourceIdentifier,
  "csharp"
);
@@clientName(ResponseDataTypeEnum, "CarbonEmissionDataType", "csharp");
@@clientName(SortDirectionEnum, "CarbonEmissionQuerySortDirection", "csharp");
@@alternateType(ResourceCarbonEmissionTopItemsSummaryData.resourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(ResourceCarbonEmissionTopItemMonthlySummaryData.resourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(ResourceCarbonEmissionItemDetailData.resourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(ResourceCarbonEmissionItemDetailData.location,
  azureLocation,
  "csharp"
);
@@alternateType(QueryFilter.locationList, azureLocation[], "csharp");
@@alternateType(ResourceCarbonEmissionItemDetailData.resourceType,
  armResourceType,
  "csharp"
);
@@alternateType(QueryFilter.resourceTypeList, armResourceType[], "csharp");
@@alternateType(CarbonEmissionDataAvailableDateRange.startDate,
  utcDateTime,
  "csharp"
);
@@alternateType(CarbonEmissionDataAvailableDateRange.endDate,
  utcDateTime,
  "csharp"
);
