import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

@armProviderNamespace
@service({
  title: "Carbon",
})
@versioned(Versions)
@doc("Carbon Report Resource Provider query API.")
namespace Microsoft.Carbon;

/** Api versions */
enum Versions {
  /** 2024-02-01-preview preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2024-02-01-preview`,
}

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Date range to be used with QueryParameter")
model DateRange {
  @doc("Start date parameter, format is yyyy-MM-dd")
  start: plainDate;

  @doc("End date parameter, format is yyyy-MM-dd")
  end: plainDate;
}

@doc("Supported category types to be used with QueryParameter")
union CategoryTypeEnum {
  string,

  @doc("Subscription level aggregation granularity")
  Subscription: "Subscription",

  @doc("ResourceGroup level aggregation granularity")
  ResourceGroup: "ResourceGroup",

  @doc("Location level aggregation granularity")
  Location: "Location",

  @doc("ServiceType level aggregation granularity")
  ServiceType: "ServiceType",

  @doc("Resource level aggregation granularity")
  Resource: "Resource",

  @doc("ResourceType level aggregation granularity")
  ResourceType: "ResourceType",
}

@doc("Supported emission scopes to be used with QueryParameter")
union EmissionScopeEnum {
  string,

  @doc("Scope1 carbon emission")
  Scope1: "Scope1",

  @doc("Scope2 carbon emission")
  Scope2: "Scope2",

  @doc("Scope3 carbon emission")
  Scope3: "Scope3",
}

@doc("Enum for Access Decision")
union AccessDecisionEnum {
  string,

  @doc("Access allowed")
  Allowed: "Allowed",

  @doc("Access denied")
  Denied: "Denied",
}

@doc("Query filter parameter specified by users")
@discriminator("reportType")
model QueryFilter {
  @doc("Report type")
  reportType: string;

  @doc("The start date and end date for carbon emissions data")
  dateRange: DateRange;

  @doc("SubscriptionId list for carbon emissions data")
  @extension("x-ms-identifiers", [])
  subscriptionList: string[];

  @doc("resourceGroupUrl list for carbon emissions data")
  @extension("x-ms-identifiers", [])
  resourceGroupUrlList?: string[];

  @doc("resource type list for carbon emissions data")
  @extension("x-ms-identifiers", [])
  resourceTypeList?: string[];

  @doc("Location list for carbon emissions data")
  @extension("x-ms-identifiers", [])
  locationList?: string[];

  @doc("Carbon emission scope for carbon emissions data")
  @extension("x-ms-identifiers", [])
  carbonScopeList: EmissionScopeEnum[];
}

@doc("Query Parameters for Overall Carbon Emissions Summary")
model OverallSummaryReportQueryFilter extends QueryFilter {
  @doc("Overall summary report type name")
  reportType: "OverallSummaryReport";
}

@doc("Query Parameters for Monthly Carbon Emissions Summary")
model MonthlySummaryReportQueryFilter extends QueryFilter {
  @doc("Monthly summary report type name")
  reportType: "MonthlySummaryReport";
}

@doc("Query Parameters for Top Items Carbon Emission by Category Type")
model TopItemsSummaryReportQueryFilter extends QueryFilter {
  @doc("Top items summary report type name")
  reportType: "TopItemsSummaryReport";

  @doc("Item Category type")
  categoryType: CategoryTypeEnum;

  @doc("Number of top items to return. The value should be between 5 and 100")
  @maxValue(100)
  @minValue(5)
  topItems: int32;
}

@doc("Query Parameters for Top Items Carbon Emissions by Month")
model TopItemsMonthlySummaryReportQueryFilter extends QueryFilter {
  @doc("Top items monthly summary report type name")
  reportType: "TopItemsMonthlySummaryReport";

  @doc("Item Category type")
  categoryType: CategoryTypeEnum;

  @doc("Number of top items to return. The value should be between 5 and 100")
  @maxValue(100)
  @minValue(5)
  topItems: int32;
}

@doc("Query Parameters for Detailed carbon emissions by pageSize")
model ItemDetailsQueryFilter extends QueryFilter {
  @doc("Item pagination data report type name")
  reportType: "ItemDetailsReport";

  @doc("Item Category type")
  categoryType: CategoryTypeEnum;

  @doc("Order by column name")
  orderBy: string;

  @doc("Direction for sorting")
  sortDirection: string;

  @doc("Group category name")
  groupCategory: string;

  @doc("Number of items to return")
  pageSize: int32;

  @doc("The number of result items to skip")
  skipToken?: string;
}

@doc("Access Decision for each Subscription")
model SubscriptionAccessDecision {
  @doc("Id of Subscription")
  subscriptionId: string;

  @doc("Access decision to subscription")
  decision: AccessDecisionEnum;
}

@discriminator("dataType")
@doc("Response for given query parameters")
model CarbonEmissionData {
  @doc("Query result data type name")
  dataType: string;

  @doc("Total carbon emissions for given query parameters")
  totalCarbonEmission: float64;

  @doc("Total carbon emission for last month for given query parameters")
  totalCarbonEmissionLastMonth: float64;

  @doc("Change ratio between totalCarbonEmission and totalCarbonEmissionLastMonth")
  changeRatioForLastMonth: float64;

  @doc("Total carbon emissions for 12 months ago for given query parameters")
  totalCarbonEmission12MonthsAgo: float64;

  @doc("Change ratio between totalCarbonEmission and totalCarbonEmission12MonthsAgo")
  changeRatioFor12Months: float64;

  @doc("Change Value between totalCarbonEmission and totalCarbonEmissionLastMonth")
  changeValueMonthOverMonth?: float64;
}

@doc("Response for Overall Carbon Emissions Summary")
model CarbonEmissionOverallSummaryData extends CarbonEmissionData {
  @doc("Overall summary data")
  dataType: "OverallSummaryData";
}

@doc("Response for Monthly Carbon Emissions Summary")
model CarbonEmissionMonthlySummaryData extends CarbonEmissionData {
  @doc("Monthly summary data")
  dataType: "MonthlySummaryData";

  @doc("Monthly date string")
  date: string;

  @doc("Carbon Intensity")
  carbonIntensity: float64;
}

@doc("Response for Top Items by Category Type")
model CarbonEmissionTopItemsSummaryData extends CarbonEmissionData {
  @doc("Top items summary data")
  dataType: "TopItemsSummaryData";

  @doc("Item name")
  itemName: string;

  @doc("Item category")
  categoryType: CategoryTypeEnum;
}

@doc("Response for Top Items For Resource")
model ResourceCarbonEmissionTopItemsSummaryData extends CarbonEmissionData {
  @doc("Top items summary data")
  dataType: "ResourceTopItemsSummaryData";

  @doc("Item name")
  itemName: string;

  @doc("Item category")
  categoryType: CategoryTypeEnum;

  @doc("Subscription Id")
  subscriptionId: string;

  @doc("Resource Group")
  resourceGroup: string;
}

@doc("Response for Top Items For ResourceGroup")
model ResourceGroupCarbonEmissionTopItemsSummaryData
  extends CarbonEmissionData {
  @doc("Top items summary data")
  dataType: "ResourceGroupTopItemsSummaryData";

  @doc("Item name")
  itemName: string;

  @doc("Item category")
  categoryType: CategoryTypeEnum;

  @doc("Subscription Id")
  subscriptionId: string;
}

@doc("Response for Top Items Carbon Emissions by Month")
model CarbonEmissionTopItemMonthlySummaryData extends CarbonEmissionData {
  @doc("Top items Monthly summary data")
  dataType: "TopItemsMonthlySummaryData";

  @doc("Item name")
  itemName: string;

  @doc("Item category")
  categoryType: CategoryTypeEnum;

  @doc("Month date")
  date: string;
}

@doc("Response for Top Items Carbon Emissions by Month for ResourceType")
model ResourceCarbonEmissionTopItemMonthlySummaryData
  extends CarbonEmissionData {
  @doc("Top items Monthly summary data")
  dataType: "ResourceTopItemsMonthlySummaryData";

  @doc("Item name")
  itemName: string;

  @doc("Item category")
  categoryType: CategoryTypeEnum;

  @doc("Month date")
  date: string;

  @doc("Subscription Id")
  subscriptionId: string;

  @doc("Resource Group")
  resourceGroup: string;
}

@doc("Response for Top Items Carbon Emissions by Month for ResourceGroupType")
model ResourceGroupCarbonEmissionTopItemMonthlySummaryData
  extends CarbonEmissionData {
  @doc("Top items Monthly summary data")
  dataType: "ResourceGroupTopItemsMonthlySummaryData";

  @doc("Item name")
  itemName: string;

  @doc("Item category")
  categoryType: CategoryTypeEnum;

  @doc("Month date")
  date: string;

  @doc("Subscription Id")
  subscriptionId: string;
}

@doc("Response for detailed carbon emissions")
model CarbonEmissionItemDetailData extends CarbonEmissionData {
  @doc("Item details data")
  dataType: "ItemDetailsData";

  @doc("Item name")
  itemName: string;

  @doc("Item group name")
  groupName: string;

  @doc("Item category")
  categoryType: CategoryTypeEnum;
}

@doc("Response for detailed carbon emissions")
model ResourceTypeCarbonEmissionItemDetailData extends CarbonEmissionData {
  @doc("Resource Type level details data")
  dataType: "ResourceTypeItemDetailsData";

  @doc("Item name, resource type name")
  itemName: string;

  @doc("Item group name")
  resourceTypeFriendlyName: string;

  @doc("Item category, which is ResourceType")
  categoryType: CategoryTypeEnum;
}

@doc("Response for Resource detailed carbon emissions")
model ResourceCarbonEmissionItemDetailData extends CarbonEmissionData {
  @doc("Item details data")
  dataType: "ResourceItemDetailsData";

  @doc("Item name")
  itemName: string;

  @doc("Item group name")
  groupName: string;

  @doc("Item category")
  categoryType: CategoryTypeEnum;

  @doc("Subscription Id")
  subscriptionId: string;

  @doc("Resource Group")
  resourceGroup: string;

  @doc("Resource Id Url")
  resourceId?: string;

  @doc("Resource Location")
  location?: string;

  @doc("Resource Type")
  resourceType?: string;

  @doc("Friendly name of Resource Type")
  resourceTypeFriendlyName?: string;

  @doc("Resource Provider")
  resourceProvider?: string;
}

@doc("Response for Resource Group detailed carbon emissions")
model ResourceGroupCarbonEmissionItemDetailData extends CarbonEmissionData {
  @doc("Item details data")
  dataType: "ResourceGroupItemDetailsData";

  @doc("Item name")
  itemName: string;

  @doc("Item group name")
  groupName: string;

  @doc("Item category")
  categoryType: CategoryTypeEnum;

  @doc("Subscription Id")
  subscriptionId: string;
}

@doc("List of carbon emission results")
@Azure.Core.pagedResult
model CarbonEmissionDataListResult {
  @doc("The CarbonEmissionData items on this page")
  @extension("x-ms-identifiers", [])
  @items
  value: CarbonEmissionData[];

  @doc("The number of result items to skip for next page")
  skipToken?: string;

  @doc("The link to the next page of items")
  @Azure.Core.nextLink
  nextLink?: string;

  @doc("The access decision list for each input subscription ")
  @extension("x-ms-identifiers", [])
  subscriptionAccessDecisionList?: SubscriptionAccessDecision[];
}

@doc("Response for available date range of carbon emission data")
model CarbonEmissionDataAvailableDateRange {
  @doc("Start date parameter, format is yyyy-MM-dd")
  startDate: string;

  @doc("End date parameter, format is yyyy-MM-dd")
  endDate: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Each resource interface must have an @armResourceOperations decorator."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-missing-decorator" "Resource POST operation must be decorated with @armResourceAction or @armResourceCollectionAction."
interface CarbonService {
  @doc("API for Carbon Emissions Reports")
  @post
  @armResourceCollectionAction
  @route("/providers/Microsoft.Carbon/carbonEmissionReports")
  listCarbonEmissionReports(
    ...ApiVersionParameter,

    @body
    @doc("Query parameters")
    queryParameters: QueryFilter,
  ): CarbonEmissionDataListResult | ErrorResponse;

  @doc("API for query carbon emission data available date range")
  @post
  @armResourceAction(CarbonEmissionDataAvailableDateRange)
  @route("/providers/Microsoft.Carbon/queryCarbonEmissionDataAvailableDateRange")
  queryCarbonEmissionDataAvailableDateRange(
    ...ApiVersionParameter,
  ): ArmResponse<CarbonEmissionDataAvailableDateRange> | ErrorResponse;
}
