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
@service(#{ title: "Carbon" })
@doc("Carbon Report Resource Provider query API.")
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.Carbon;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2025-04-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2025_04_01: "2025-04-01",
}

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Date range to be used with QueryParameter, it should be within 12 months between start and end date. In certain cases, start and end dates must be the same date.")
model DateRange {
  @doc("Start date parameter in yyyy-MM-01 format. Only the first day of each month is accepted.")
  start: plainDate;

  @doc("End date parameter in yyyy-MM-01 format. Only the first day of each month is accepted.")
  end: plainDate;
}

@doc("Supported category types to be used with QueryParameter. Each type represents a different level of emissions data aggregation.")
union CategoryTypeEnum {
  @doc("Emissions aggregated at the subscription level.")
  Subscription: "Subscription",

  @doc("Emissions aggregated at the resource group level.")
  ResourceGroup: "ResourceGroup",

  @doc("Emissions aggregated at the location level.")
  Location: "Location",

  @doc("Emissions aggregated at the resource level.")
  Resource: "Resource",

  @doc("Emissions aggregated at the resource type level.")
  ResourceType: "ResourceType",

  string,
}

@doc("Supported carbon emission scopes to be used with QueryParameter, as defined by the GHG Protocol. At least one scope must be specified. The output will return a total of all specified scopes.")
union EmissionScopeEnum {
  @doc("Scope1 carbon emission")
  Scope1: "Scope1",

  @doc("Scope2 carbon emission")
  Scope2: "Scope2",

  @doc("Scope3 carbon emission")
  Scope3: "Scope3",

  string,
}

@doc("Enum for Access Decision")
union AccessDecisionEnum {
  @doc("Access allowed")
  Allowed: "Allowed",

  @doc("Access denied")
  Denied: "Denied",

  string,
}

@doc("Enum for Report Type, specifying different report formats for carbon emissions data. Each report type returns different aggregations of carbon emissions across various categories, date range, emissions scope, and other parameters.")
union ReportTypeEnum {
  @doc("Overall summary report provides total carbon emissions for the specified date range and query parameters, as well as comparative values for a high-level overview. This report type can accept different values in the start and end fields within DateRange (e.g., start: 2024-03-01 and end: 2024-06-01).")
  OverallSummaryReport: "OverallSummaryReport",

  @doc("MonthlySummaryReport provides carbon emissions data by month for the specified query parameters. This report type can accept different values in the start and end fields within DateRange (e.g., start: 2024-03-01 and end: 2024-06-01).")
  MonthlySummaryReport: "MonthlySummaryReport",

  @doc("TopItemsSummaryReport provides the N highest-emitting items for the specified query filters. This report returns data for a single month at a time, so it requires the same values for the start and end fields within DateRange. A maximum of N=10 items can be returned at a time.")
  TopItemsSummaryReport: "TopItemsSummaryReport",

  @doc("TopItemsMonthlyReport provides the N highest-emitting items by month for the specified query filter. Returns emissions data for the top N items by month within the given date range. A maximum of N=10 items can be returned at a time.")
  TopItemsMonthlySummaryReport: "TopItemsMonthlySummaryReport",

  @doc("ItemDetailsReport provides a granular list of items based on the specified CategoryType (e.g., Resource, ResourceGroup, ResourceType, Location, or Subscription) for the query filter. This report can be queried for only one month at a time, requiring the same values in the start and end fields within DateRange.")
  ItemDetailsReport: "ItemDetailsReport",

  string,
}

@doc("Shared query filter parameter to configure carbon emissions data queries for all different report type defined in ReportTypeEnum.")
@discriminator("reportType")
model QueryFilter {
  @doc("The ReportType requested for carbon emissions data. Required. Specifies how data is aggregated and displayed in the output, as explained in the ReportTypeEnum.")
  reportType: ReportTypeEnum;

  @doc("The start and end dates for carbon emissions data. Required. For ItemDetailsReport and TopItemsSummaryReport, only one month of data is supported at a time, so start and end dates should be equal within DateRange (e.g., start: 2024-06-01 and end: 2024-06-01).")
  dateRange: DateRange;

  @doc("List of subscription IDs for which carbon emissions data is requested. Required. Each subscription ID should be in lowercase format. The max length of list is 100.")
  subscriptionList: string[];

  @doc("List of resource group URLs for carbon emissions data. Optional. Each URL must follow the format '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroup}', and should be in all lowercase.")
  resourceGroupUrlList?: string[];

  @doc("List of resource types for carbon emissions data. Optional. Each resource type should be specified in lowercase, following the format 'microsoft.{service}/{resourceType}', e.g., 'microsoft.storage/storageaccounts'.")
  resourceTypeList?: string[];

  @doc("List of locations(Azure Region Display Name) for carbon emissions data, with each location specified in lowercase (e.g., 'east us'). Optional. You can use the command 'az account list-locations -o table' to find Azure Region Display Names.")
  locationList?: string[];

  @doc("List of carbon emission scopes. Required. Accepts one or more values from EmissionScopeEnum (e.g., Scope1, Scope2, Scope3) in list form. The output will include the total emissions for the specified scopes.")
  carbonScopeList: EmissionScopeEnum[];
}

@doc("Query filter parameter to configure OverallSummaryReport queries.")
model OverallSummaryReportQueryFilter extends QueryFilter {
  @doc("Specifies that the report type is a overall summary report for carbon emissions data.")
  reportType: ReportTypeEnum.OverallSummaryReport;
}

@doc("Query filter parameter to configure MonthlySummaryReport queries.")
model MonthlySummaryReportQueryFilter extends QueryFilter {
  @doc("Specifies that the report type is a monthly summary report for carbon emissions data.")
  reportType: ReportTypeEnum.MonthlySummaryReport;
}

@doc("Query filter parameter to configure TopItemsSummaryReport queries.")
model TopItemsSummaryReportQueryFilter extends QueryFilter {
  @doc("Specifies that the report type is a top items summary report for carbon emissions data, aggregated by category type.")
  reportType: ReportTypeEnum.TopItemsSummaryReport;

  @doc("Specifies the category type for which to retrieve top-emitting items. See supported values defined in CategoryTypeEnum.")
  categoryType: CategoryTypeEnum;

  @doc("The number of top items to return, based on emissions. This value must be between 1 and 10.")
  @maxValue(10)
  @minValue(1)
  topItems: int32;
}

@doc("Query filter parameter to configure TopItemsMonthlySummaryReport queries.")
model TopItemsMonthlySummaryReportQueryFilter extends QueryFilter {
  @doc("Specifies that the report type is a top items monthly summary report for carbon emissions data.")
  reportType: ReportTypeEnum.TopItemsMonthlySummaryReport;

  @doc("Specifies the category type to retrieve top-emitting items, aggregated by month. See supported types in CategoryTypeEnum.")
  categoryType: CategoryTypeEnum;

  @doc("The number of top items to return, based on emissions. Must be between 1 and 10.")
  @maxValue(10)
  @minValue(1)
  topItems: int32;
}

@doc("Sorting is supported for columns in ItemDetailsReport. This object define sorting direction.")
union SortDirectionEnum {
  @doc("Descending order for query result.")
  Desc: "Desc",

  @doc("Ascending order for query result.")
  Asc: "Asc",

  string,
}

@doc("Sorting is supported for columns in ItemDetailsReport. This object includes the column names that sorting is allowed for. Select one of these supported values")
union OrderByColumnEnum {
  @doc("The itemName filed in ItemDetailsReport result, see CarbonEmissionItemDetailData for more information.")
  ItemName: "ItemName",

  @doc("The latestMonthEmissions filed in ItemDetailsReport result, see CarbonEmissionItemDetailData for more information.")
  LatestMonthEmissions: "LatestMonthEmissions",

  @doc("The previousMonthEmissions filed in ItemDetailsReport result, see CarbonEmissionItemDetailData for more information.")
  PreviousMonthEmissions: "PreviousMonthEmissions",

  @doc("The monthOverMonthEmissionsChangeRatio filed in ItemDetailsReport result, see CarbonEmissionItemDetailData for more information.")
  MonthOverMonthEmissionsChangeRatio: "MonthOverMonthEmissionsChangeRatio",

  @doc("The monthlyEmissionsChangeValue filed in ItemDetailsReport result, see CarbonEmissionItemDetailData for more information.")
  MonthlyEmissionsChangeValue: "MonthlyEmissionsChangeValue",

  @doc("The resourceGroup filed in ResourceCarbonEmissionItemDetailData result, see ResourceCarbonEmissionItemDetailData for more information.")
  ResourceGroup: "ResourceGroup",

  string,
}

@doc("Query Parameters for ItemDetailsReport")
model ItemDetailsQueryFilter extends QueryFilter {
  @doc("Specifies that the report type is an item details report for granular carbon emissions data. This is a paginated report.")
  reportType: ReportTypeEnum.ItemDetailsReport;

  @doc("Specifies the category type for detailed emissions data, such as Resource, ResourceGroup, ResourceType, Location, or Subscription. See supported types in CategoryTypeEnum.")
  categoryType: CategoryTypeEnum;

  @doc("The column name to order the results by. See supported values in OrderByColumnEnum.")
  orderBy: OrderByColumnEnum;

  @doc("Direction for sorting results. See supported values in SortDirectionEnum.")
  sortDirection: SortDirectionEnum;

  @doc("Number of items to return in one request, max value is 5000.")
  @maxValue(5000)
  @minValue(1)
  pageSize: int32;

  @doc("Pagination token for fetching the next page of data. This token is nullable and will be returned in the previous response if additional data pages are available.")
  skipToken?: string;
}

@doc("Access Decision for each Subscription")
model SubscriptionAccessDecision {
  @doc("Id of Subscription")
  subscriptionId: string;

  @doc("Access decision to subscription")
  decision: AccessDecisionEnum;

  @doc("The reason why access request got denied")
  denialReason?: string;
}

@doc("The response data type of Carbon emission data")
union ResponseDataTypeEnum {
  @doc("The response data type for OverallSummaryReport")
  OverallSummaryData: "OverallSummaryData",

  @doc("The response data type for MonthlySummaryReport")
  MonthlySummaryData: "MonthlySummaryData",

  @doc("The response data type for TopItemsSummaryReport")
  TopItemsSummaryData: "TopItemsSummaryData",

  @doc("The response data type for Resource's TopItemsSummaryReport")
  ResourceTopItemsSummaryData: "ResourceTopItemsSummaryData",

  @doc("The response data type for ResourceGroup's TopItemsSummaryReport")
  ResourceGroupTopItemsSummaryData: "ResourceGroupTopItemsSummaryData",

  @doc("The response data type for TopItemsMonthlySummaryReport")
  TopItemsMonthlySummaryData: "TopItemsMonthlySummaryData",

  @doc("The response data type for Resource's TopItemsMonthlySummaryReport")
  ResourceTopItemsMonthlySummaryData: "ResourceTopItemsMonthlySummaryData",

  @doc("The response data type for ResourceGroup's TopItemsMonthlySummaryReport")
  ResourceGroupTopItemsMonthlySummaryData: "ResourceGroupTopItemsMonthlySummaryData",

  @doc("The response data type for ItemDetailsReport")
  ItemDetailsData: "ItemDetailsData",

  @doc("The response data type for Resource's ItemDetailsReport")
  ResourceItemDetailsData: "ResourceItemDetailsData",

  @doc("The response data type for ResourceGroup's ItemDetailsReport")
  ResourceGroupItemDetailsData: "ResourceGroupItemDetailsData",

  string,
}

@discriminator("dataType")
@doc("The basic response for different query report, all query report result will have these information")
model CarbonEmissionData {
  @doc("The data type of the query result, indicating the format of the returned response.")
  dataType: ResponseDataTypeEnum;

  @doc("Total carbon emissions for the specified query parameters, measured in kgCO2E. This value represents total emissions over the specified date range (e.g., March-June).")
  latestMonthEmissions: float64;

  @doc("Total carbon emissions for the previous month’s date range, which is the same period as the specified date range but shifted left by one month (e.g., if the specified range is March - June, the previous month’s range will be Feb - May). The value is measured in kgCO2E.")
  previousMonthEmissions: float64;

  @doc("The percentage change in carbon emissions between the current and previous DateRange. This is calculated as: (latestMonthEmissions - previousMonthEmissions) / previousMonthEmissions.")
  monthOverMonthEmissionsChangeRatio?: float64;

  @doc("The change in carbon emissions between the current and previous period, calculated as: latestMonthEmissions - previousMonthEmissions.")
  monthlyEmissionsChangeValue?: float64;
}

@doc("Response for Overall Carbon Emissions Summary")
model CarbonEmissionOverallSummaryData extends CarbonEmissionData {
  @doc("Overall summary data")
  dataType: ResponseDataTypeEnum.OverallSummaryData;
}

@doc("Response for Monthly Carbon Emissions Summary")
model CarbonEmissionMonthlySummaryData extends CarbonEmissionData {
  @doc("Monthly summary data")
  dataType: ResponseDataTypeEnum.MonthlySummaryData;

  @doc("The date, representing the month, for which the emissions data is reported, formatted as yyyy-MM-dd (e.g., 2024-03-01)")
  date: string;

  @doc("Carbon intensity for the specified month, typically in units of kgCO2E per unit of normalized usage")
  carbonIntensity: float64;
}

@doc("Response for Top Items by Category Type")
model CarbonEmissionTopItemsSummaryData extends CarbonEmissionData {
  @doc("Top items summary data")
  dataType: ResponseDataTypeEnum.TopItemsSummaryData;

  @doc("The identifier of the item being reported on, which could refer to the resource name, resource type name, location, resource group name, or subscription ID, depending on the specified category type.")
  itemName: string;

  @doc("The category type of the item. This defines which dimension the emissions are aggregated by, and the supported values are defined in CategoryTypeEnum (e.g., Subscription, ResourceGroup, Resource, etc.).")
  categoryType: CategoryTypeEnum;
}

@doc("Response for Top Items For Resource Category")
model ResourceCarbonEmissionTopItemsSummaryData extends CarbonEmissionData {
  @doc("Data for the top items carbon emissions summary report specific to resource category")
  dataType: ResponseDataTypeEnum.ResourceTopItemsSummaryData;

  @doc("The resource name of the resource for the Resource Category.")
  itemName: string;

  @doc("The category type of the item. This defines which dimension the emissions are aggregated by, and the supported values are defined in CategoryTypeEnum (e.g., Subscription, ResourceGroup, Resource, etc.).")
  categoryType: CategoryTypeEnum;

  @doc("Subscription Id")
  subscriptionId: string;

  @doc("Resource group name")
  resourceGroup: string;

  @doc("Resource Id, The URI of the resource for the Resource Category. This identifies the resource being reported.")
  resourceId: string;
}

@doc("Response for Top Items For ResourceGroup")
model ResourceGroupCarbonEmissionTopItemsSummaryData
  extends CarbonEmissionData {
  @doc("Resource group top items summary data")
  dataType: ResponseDataTypeEnum.ResourceGroupTopItemsSummaryData;

  @doc("The resourceGroup name of the resource for ResourceGroup Category")
  itemName: string;

  @doc("ResourceGroup Item category")
  categoryType: CategoryTypeEnum;

  @doc("Subscription Id")
  subscriptionId: string;

  @doc("Resource Group url, value format is '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroup}'")
  resourceGroupUrl: string;
}

@doc("Response for Top Items Carbon Emissions by Month")
model CarbonEmissionTopItemMonthlySummaryData extends CarbonEmissionData {
  @doc("Top items Monthly summary data")
  dataType: ResponseDataTypeEnum.TopItemsMonthlySummaryData;

  @doc("Item name, it can be resource name, resource type name, location, resource group name or subscriptionId. It depends on category type.")
  itemName: string;

  @doc("Item category, see supported type value defined in CategoryTypeEnum")
  categoryType: CategoryTypeEnum;

  @doc("The date, representing the month, for which the emissions data is reported, formatted as yyyy-MM-dd (e.g., 2024-03-01)")
  date: string;
}

@doc("Response for top items carbon emissions by month for resource")
model ResourceCarbonEmissionTopItemMonthlySummaryData
  extends CarbonEmissionData {
  @doc("Resource top items Monthly summary data")
  dataType: ResponseDataTypeEnum.ResourceTopItemsMonthlySummaryData;

  @doc("The resource name of resource for Resource Category")
  itemName: string;

  @doc("Resource Item category")
  categoryType: CategoryTypeEnum;

  @doc("Monthly date string, format is yyyy-MM-dd")
  date: string;

  @doc("Subscription Id")
  subscriptionId: string;

  @doc("Resource Group")
  resourceGroup: string;

  @doc("The fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  resourceId: string;
}

@doc("Response for top items carbon emissions by month for resource group")
model ResourceGroupCarbonEmissionTopItemMonthlySummaryData
  extends CarbonEmissionData {
  @doc("Resource group top items Monthly summary data")
  dataType: ResponseDataTypeEnum.ResourceGroupTopItemsMonthlySummaryData;

  @doc("It's resource group name for ResourceGroup category")
  itemName: string;

  @doc("ResourceGroup Item category")
  categoryType: CategoryTypeEnum;

  @doc("Monthly date string, format is yyyy-MM-dd")
  date: string;

  @doc("Subscription Id")
  subscriptionId: string;

  @doc("Resource Group url, the format is '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroup}'")
  resourceGroupUrl: string;
}

@doc("Response for detailed carbon emissions")
model CarbonEmissionItemDetailData extends CarbonEmissionData {
  @doc("Item details data")
  dataType: ResponseDataTypeEnum.ItemDetailsData;

  @doc("Item name, it can be resource name, resource type name, location, resource group name or subscriptionId. It depends on category type.")
  itemName: string;

  @doc("Item category, see supported type value defined in CategoryTypeEnum")
  categoryType: CategoryTypeEnum;
}

@doc("Response for Resource detailed carbon emissions")
model ResourceCarbonEmissionItemDetailData extends CarbonEmissionData {
  @doc("ResourceGroup's item details data")
  dataType: ResponseDataTypeEnum.ResourceItemDetailsData;

  @doc("It's resource name.")
  itemName: string;

  @doc("Resource Item category, see supported value defined in CategoryTypeEnum")
  categoryType: CategoryTypeEnum;

  @doc("Subscription Id")
  subscriptionId: string;

  @doc("Resource Group")
  resourceGroup: string;

  @doc("The fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  resourceId: string;

  @doc("Resource Location (e.g., 'east us').")
  location?: string;

  @doc("The type of resource, for example: microsoft.storage/storageaccounts")
  resourceType?: string;
}

@doc("Response for Resource Group detailed carbon emissions")
model ResourceGroupCarbonEmissionItemDetailData extends CarbonEmissionData {
  @doc("ResourceGroup item details data")
  dataType: ResponseDataTypeEnum.ResourceGroupItemDetailsData;

  @doc("It's resource group name")
  itemName: string;

  @doc("ResourceGroup Item category")
  categoryType: CategoryTypeEnum;

  @doc("Subscription Id")
  subscriptionId: string;

  @doc("Resource Group url, value format is '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroup}'")
  resourceGroupUrl: string;
}

@doc("List of carbon emission results")
@Azure.Core.pagedResult
model CarbonEmissionDataListResult {
  @doc("The CarbonEmissionData items on this page")
  @Azure.ResourceManager.identifiers(#[])
  @items
  value: CarbonEmissionData[];

  @doc("The pagination token to fetch next page data, it's null or empty if it doesn't have next page data")
  skipToken?: string;

  @doc("The access decision list for each input subscription ")
  @Azure.ResourceManager.identifiers(#[])
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
  queryCarbonEmissionReports(
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
