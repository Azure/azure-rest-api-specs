import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.ResourceManager.CommonTypes;
using Microsoft.Carbon;

@@clientName(Microsoft.Carbon, "CarbonOptimizationMgmt", "python");
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
@@clientName(ResourceGroupCarbonEmissionTopItemMonthlySummaryData.resourceGroupUrl,
  "ResourceGroupId",
  "csharp"
);
@@clientName(ResourceGroupCarbonEmissionItemDetailData.resourceGroupUrl,
  "ResourceGroupId",
  "csharp"
);
@@clientName(ResponseDataTypeEnum, "CarbonEmissionDataType", "csharp");
@@clientName(SortDirectionEnum, "CarbonEmissionQuerySortDirection", "csharp");
@@alternateType(ResourceCarbonEmissionTopItemsSummaryData.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ResourceCarbonEmissionTopItemMonthlySummaryData.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ResourceCarbonEmissionItemDetailData.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ResourceCarbonEmissionItemDetailData.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(QueryFilter.locationList, Azure.Core.azureLocation[], "csharp");
@@alternateType(ResourceCarbonEmissionItemDetailData.resourceType,
  Azure.Core.armResourceType,
  "csharp"
);
@@alternateType(QueryFilter.resourceTypeList,
  Azure.Core.armResourceType[],
  "csharp"
);
@@alternateType(ResourceGroupCarbonEmissionTopItemsSummaryData.resourceGroupUrl,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ResourceGroupCarbonEmissionTopItemMonthlySummaryData.resourceGroupUrl,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ResourceGroupCarbonEmissionItemDetailData.resourceGroupUrl,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(CarbonEmissionDataAvailableDateRange.startDate,
  utcDateTime,
  "csharp"
);
@@alternateType(CarbonEmissionDataAvailableDateRange.endDate,
  utcDateTime,
  "csharp"
);
