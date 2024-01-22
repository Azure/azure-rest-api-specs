import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.CostManagement;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The number of days used to look back.
 */
enum LookBackPeriod {
  /**
   * 7 days used to look back.
   */
  Last7Days,

  /**
   * 30 days used to look back.
   */
  Last30Days,

  /**
   * 60 days used to look back.
   */
  Last60Days,
}

/**
 * Grain which corresponds to value.
 */
enum Grain {
  /**
   * Hourly grain corresponds to value per hour.
   */
  Hourly,

  /**
   * Hourly grain corresponds to value per day.
   */
  Daily,

  /**
   * Hourly grain corresponds to value per month.
   */
  Monthly,
}

/**
 * Grain which corresponds to value.
 */
enum Term {
  /**
   * Benefit term is 1 year.
   */
  P1Y,

  /**
   * Benefit term is 3 years.
   */
  P3Y,
}

/**
 * Kind of the recommendation scope.
 */
enum Scope {
  /**
   * Single scope recommendation.
   */
  Single,

  /**
   * Shared scope recommendation.
   */
  Shared,
}

/**
 * Kind/type of the benefit.
 */
enum BenefitKind {
  /**
   * Benefit is IncludedQuantity.
   */
  IncludedQuantity,

  /**
   * Benefit is Reservation.
   */
  Reservation,

  /**
   * Benefit is SavingsPlan.
   */
  SavingsPlan,
}

enum GrainParameter {
  /**
   * Hourly grain corresponds to value per hour.
   */
  Hourly,

  /**
   * Hourly grain corresponds to value per day.
   */
  Daily,

  /**
   * Hourly grain corresponds to value per month.
   */
  Monthly,
}

/**
 * Enum representing the status of an async operation.
 */
enum OperationStatusType {
  Running,
  Complete,
  Failed,
  Completed,
}

/**
 * The CSV file from the reportUrl and secondaryReportUrl blob link will consist of the following columns of benefit utilization data. UtilizedPercentage will be 0 for savings plans reports and non data bricks reservations. Utilization percentages will be 0 for data bricks reservations.
 */
enum BenefitUtilizationSummaryReportSchema {
  Kind,
  AvgUtilizationPercentage,
  BenefitOrderId,
  BenefitId,
  BenefitType,
  MaxUtilizationPercentage,
  MinUtilizationPercentage,
  UsageDate,
  UtilizedPercentage,
}

/**
 * The status of the export's schedule. If 'Inactive', the export's schedule is paused.
 */
enum StatusType {
  Active,
  Inactive,
}

/**
 * The schedule recurrence.
 */
enum RecurrenceType {
  Daily,
  Weekly,
  Monthly,
  Annually,
}

/**
 * The format of the export being delivered. Currently only 'Csv' is supported.
 */
enum FormatType {
  Csv,
}

/**
 * The type of the export. Note that 'Usage' is equivalent to 'ActualCost' and is applicable to exports that do not yet provide data for charges or amortization for service reservations.
 */
enum ExportType {
  Usage,
  ActualCost,
  AmortizedCost,
}

/**
 * The time frame for pulling data for the export. If custom, then a specific time period must be provided.
 */
enum TimeframeType {
  MonthToDate,
  BillingMonthToDate,
  TheLastMonth,
  TheLastBillingMonth,
  WeekToDate,
  Custom,
}

/**
 * The granularity of rows in the export. Currently only 'Daily' is supported.
 */
enum GranularityType {
  Daily,
}

/**
 * The type of the export run.
 */
enum ExecutionType {
  OnDemand,
  Scheduled,
}

/**
 * The last known status of the export run.
 */
enum ExecutionStatus {
  Queued,
  InProgress,
  Completed,
  Failed,
  Timeout,
  NewDataNotAvailable,
  DataNotAvailable,
}

/**
 * The type of the report. Usage represents actual usage, forecast represents forecasted data and UsageAndForecast represents both usage and forecasted data. Actual usage and forecasted data can be differentiated based on dates.
 */
enum ReportType {
  Usage,
}

/**
 * The time frame for pulling data for the report. If custom, then a specific time period must be provided.
 */
enum ReportTimeframeType {
  WeekToDate,
  MonthToDate,
  YearToDate,
  Custom,
}

/**
 * The granularity of rows in the report.
 */
enum ReportGranularityType {
  Daily,
  Monthly,
}

/**
 * The name of the aggregation function to use.
 */
enum FunctionType {
  Sum,
}

/**
 * The type of the column in the report.
 */
enum QueryColumnType {
  /**
   * The tag associated with the cost data.
   */
  TagKey,

  /**
   * The dimension of cost data.
   */
  Dimension,
}

/**
 * Direction of sort.
 */
enum ReportConfigSortingType {
  Ascending,
  Descending,
}

/**
 * The operator to use for comparison.
 */
enum OperatorType {
  In,
  Contains,
}

/**
 * Chart type of the main view in Cost Analysis. Required.
 */
enum ChartType {
  Area,
  Line,
  StackedColumn,
  GroupedColumn,
  Table,
}

/**
 * Show costs accumulated over time.
 */
enum AccumulatedType {
  `true`,
  `false`,
}

/**
 * Metric to use when displaying costs.
 */
enum MetricType {
  ActualCost,
  AmortizedCost,
  AHUB,
}

/**
 * KPI type (Forecast, Budget).
 */
enum KpiTypeType {
  Forecast,
  Budget,
}

/**
 * Data type to show in view.
 */
enum PivotTypeType {
  Dimension,
  TagKey,
}

/**
 * type of alert
 */
enum AlertType {
  Budget,
  Invoice,
  Credit,
  Quota,
  General,
  xCloud,
  BudgetForecast,
}

/**
 * Alert category
 */
enum AlertCategory {
  Cost,
  Usage,
  Billing,
  System,
}

/**
 * Criteria that triggered alert
 */
enum AlertCriteria {
  CostThresholdExceeded,
  UsageThresholdExceeded,
  CreditThresholdApproaching,
  CreditThresholdReached,
  QuotaThresholdApproaching,
  QuotaThresholdReached,
  MultiCurrency,
  ForecastCostThresholdExceeded,
  ForecastUsageThresholdExceeded,
  InvoiceDueDateApproaching,
  InvoiceDueDateReached,
  CrossCloudNewDataAvailable,
  CrossCloudCollectionError,
  GeneralThresholdError,
}

/**
 * Source of alert
 */
enum AlertSource {
  Preset,
  User,
}

/**
 * Type of timegrain cadence
 */
enum AlertTimeGrainType {
  None,
  Monthly,
  Quarterly,
  Annually,
  BillingMonth,
  BillingQuarter,
  BillingAnnual,
}

/**
 * operator used to compare currentSpend with amount
 */
enum AlertOperator {
  None,
  EqualTo,
  GreaterThan,
  GreaterThanOrEqualTo,
  LessThan,
  LessThanOrEqualTo,
}

/**
 * alert status
 */
enum AlertStatus {
  None,
  Active,
  Overridden,
  Resolved,
  Dismissed,
}

enum ExternalCloudProviderType {
  externalSubscriptions,
  externalBillingAccounts,
}

/**
 * The type of the forecast.
 */
enum ForecastType {
  Usage,
  ActualCost,
  AmortizedCost,
}

/**
 * The time frame for pulling data for the forecast.
 */
enum ForecastTimeframe {
  Custom,
}

/**
 * The name of the column to aggregate.
 */
enum FunctionName {
  PreTaxCostUSD,
  Cost,
  CostUSD,
  PreTaxCost,
}

/**
 * The operator to use for comparison.
 */
enum ForecastOperatorType {
  In,
}

/**
 * The operator to use for comparison.
 */
enum QueryOperatorType {
  In,
}

/**
 * The CSV file from the reportUrl blob link consists of reservation usage data with the following schema at daily granularity
 */
enum ReservationReportSchema {
  InstanceFlexibilityGroup,
  InstanceFlexibilityRatio,
  InstanceId,
  Kind,
  ReservationId,
  ReservationOrderId,
  ReservedHours,
  SkuName,
  TotalReservedQuantity,
  UsageDate,
  UsedHours,
}

/**
 * Destination of the view data. Currently only CSV format is supported.
 */
enum FileFormat {
  Csv,
}

/**
 * Frequency of the schedule.
 */
enum ScheduleFrequency {
  /**
   * Cost analysis data will be emailed every day.
   */
  Daily,

  /**
   * Cost analysis data will be emailed every week.
   */
  Weekly,

  /**
   * Cost analysis data will be emailed every month.
   */
  Monthly,
}

/**
 * Days of Week.
 */
enum DaysOfWeek {
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
  Sunday,
}

/**
 * Weeks of month.
 */
enum WeeksOfMonth {
  First,
  Second,
  Third,
  Fourth,
  Last,
}

/**
 * Status of the scheduled action.
 */
enum ScheduledActionStatus {
  /**
   * Scheduled action is saved but will not be run.
   */
  Disabled,

  /**
   * Scheduled action is saved and will be run.
   */
  Enabled,

  /**
   * Scheduled action is expired.
   */
  Expired,
}

/**
 * Kind of the scheduled action.
 */
enum ScheduledActionKind {
  /**
   * Cost analysis data will be emailed.
   */
  Email,

  /**
   * Cost anomaly information will be emailed. Available only on subscription scope at daily frequency. If no anomaly is detected on the resource, an email won't be sent.
   */
  InsightAlert,
}

/**
 * The type of the detailed report. By default ActualCost is provided
 */
enum CostDetailsMetricType {
  /**
   * Actual cost data.
   */
  ActualCostCostDetailsMetricType: "ActualCost",

  /**
   * Amortized cost data.
   */
  AmortizedCostCostDetailsMetricType: "AmortizedCost",
}

/**
 * The status of the cost details operation
 */
enum CostDetailsStatusType {
  /**
   * Operation is Completed.
   */
  CompletedCostDetailsStatusType: "Completed",

  /**
   * Operation is Completed and no cost data found.
   */
  NoDataFoundCostDetailsStatusType: "NoDataFound",

  /**
   * Operation Failed.
   */
  FailedCostDetailsStatusType: "Failed",
}

/**
 * The data format of the report
 */
enum CostDetailsDataFormat {
  /**
   * Csv data format.
   */
  CsvCostDetailsDataFormat: "Csv",
}

/**
 * The type of the detailed report. By default ActualCost is provided
 */
enum GenerateDetailedCostReportMetricType {
  ActualCost,
  AmortizedCost,
}

/**
 * The status of the long running operation.
 */
enum ReportOperationStatusType {
  InProgress,
  Completed,
  Failed,
  Queued,
  NoDataFound,
  ReadyToDownload,
  TimedOut,
}

/**
 * Result of listing benefit recommendations.
 */
model BenefitRecommendationsListResult
  is Azure.Core.Page<BenefitRecommendationModel>;

/**
 * benefit plan recommendation details.
 */
model BenefitRecommendationModel extends BenefitResource {
  /**
   * The properties of the benefit recommendations.
   */
  properties?: BenefitRecommendationProperties;
}

/**
 * The properties of the benefit recommendations.
 */
@discriminator("scope")
model BenefitRecommendationProperties {
  /**
   * The first usage date used for looking back for computing the recommendations.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  firstConsumptionDate?: utcDateTime;

  /**
   * The last usage date used for looking back for computing the recommendations.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastConsumptionDate?: utcDateTime;

  /**
   * The number of days of usage evaluated for computing the recommendations.
   */
  lookBackPeriod?: LookBackPeriod;

  /**
   * The total hours for which the cost is covered. Its equal to number of records in a property 'properties/usage/charges'.
   */
  @visibility("read")
  totalHours?: int32;

  /**
   * On-demand charges between firstConsumptionDate and lastConsumptionDate that were used for computing benefit recommendations.
   */
  usage?: RecommendationUsageDetails;

  /**
   * ARM SKU name. 'Compute_Savings_Plan' for SavingsPlan.
   */
  @visibility("read")
  armSkuName?: string;

  /**
   * Term period of the benefit. For example, P1Y or P3Y.
   */
  term?: Term;

  /**
   * Grain of the proposed commitment amount. Supported values: 'Hourly'
   */
  commitmentGranularity?: Grain;

  /**
   * An ISO 4217 currency code identifier for the costs and savings amounts.
   */
  @visibility("read")
  currencyCode?: string;

  /**
   * The current cost without benefit, corresponds to 'totalHours' in the look-back period.
   */
  @visibility("read")
  costWithoutBenefit?: decimal;

  /**
   * The details of the proposed recommendation.
   */
  recommendationDetails?: AllSavingsBenefitDetails;

  /**
   * The list of all benefit recommendations with the recommendation details.
   */
  @visibility("read")
  allRecommendationDetails?: AllSavingsList;
}

/**
 * On-demand charges between firstConsumptionDate and lastConsumptionDate that were used for computing benefit recommendations.
 */
model RecommendationUsageDetails {
  /**
   * The grain of the usage. Supported values: 'Hourly'
   */
  usageGrain?: Grain;

  /**
   * On-demand charges for each hour between firstConsumptionDate and lastConsumptionDate that were used for computing benefit recommendations.
   */
  @visibility("read")
  charges?: decimal[];
}

/**
 * Benefit recommendation details.
 */
model AllSavingsBenefitDetails {
  /**
   * The difference between total cost and benefit cost for the 'totalHours' in the look-back period.
   */
  @visibility("read")
  overageCost?: decimal;

  /**
   * The estimated cost with benefit for the 'totalHours' in the look-back period. It's equal to (commitmentAmount * totalHours)
   */
  @visibility("read")
  benefitCost?: decimal;

  /**
   * Total cost, which is sum of benefit cost and overage cost.
   */
  @visibility("read")
  totalCost?: decimal;

  /**
   * The amount saved for the 'totalHours' in the look-back period, by purchasing the recommended quantity of the benefit.
   */
  @visibility("read")
  savingsAmount?: decimal;

  /**
   * The savings in percentage for the 'totalHours' in the look-back period, by purchasing the recommended quantity of benefit.
   */
  @visibility("read")
  savingsPercentage?: decimal;

  /**
   * Estimated benefit coverage percentage for the 'totalHours' in the look-back period, with this commitment.
   */
  @visibility("read")
  coveragePercentage?: decimal;

  /**
   * The commitment amount at the commitmentGranularity.
   */
  @visibility("read")
  commitmentAmount?: decimal;

  /**
   * Estimated average utilization percentage for the 'totalHours' in the look-back period, with this commitment.
   */
  @visibility("read")
  averageUtilizationPercentage?: decimal;

  /**
   * Estimated unused portion of the 'benefitCost'.
   */
  @visibility("read")
  wastageCost?: decimal;
}

/**
 * The list of all benefit recommendations with the recommendation details.
 */
model AllSavingsList {
  /**
   * The list of benefit recommendations with the recommendation details..
   */
  @visibility("read")
  value?: AllSavingsBenefitDetails[];

  /**
   * The link (URL) to the next page of results.
   */
  @visibility("read")
  nextLink?: url;
}

/**
 * The benefit resource model definition.
 */
model BenefitResource extends Resource {
  /**
   * Reservation or SavingsPlan.
   */
  kind?: BenefitKind;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;
}

/**
* Error response indicates that the service is not able to process the incoming request. The reason is provided in the error message. 

Some Error responses: 

 * 429 TooManyRequests - Request is throttled. Retry after waiting for the time specified in the "x-ms-ratelimit-microsoft.consumption-retry-after" header. 

 * 503 ServiceUnavailable - Service is temporarily unavailable. Retry after waiting for the time specified in the "Retry-After" header.
*/
@error
model OperationErrorResponse {
  /**
   * The details of the error.
   */
  error?: ErrorDetails;
}

/**
 * The details of the error.
 */
model ErrorDetails {
  /**
   * Error code.
   */
  @visibility("read")
  code?: string;

  /**
   * Error message indicating why the operation failed.
   */
  @visibility("read")
  message?: string;
}

/**
 * List of benefit utilization summaries.
 */
model BenefitUtilizationSummariesListResult
  is Azure.Core.Page<BenefitUtilizationSummary>;

/**
 * Benefit utilization summary resource.
 */
@discriminator("kind")
model BenefitUtilizationSummary extends Resource {}

/**
 * Properties of an async benefit utilization summaries request.
 */
model BenefitUtilizationSummariesRequest {
  /**
   * Billing account the benefit utilization summaries report is for. Required for billing account and billing profile scopes. Not supported for any benefit scopes.
   */
  billingAccountId?: string;

  /**
   * Billing profile id the benefit utilization summaries report is for. Required for billing profile scope. Not supported for billing account or any benefit scopes.
   */
  billingProfileId?: string;

  /**
   * Benefit order id the benefit utilization summaries report is for. Required for benefit order and benefit id scopes. Not supported for any billing scopes.
   */
  benefitOrderId?: string;

  /**
   * Benefit id the benefit utilization summaries report is for. Required for benefit id scope. Not supported for benefit order or any billing scopes.
   */
  benefitId?: string;

  /**
   * The grain the summaries data is served at in the report. Accepted values are 'Daily' or 'Monthly'.
   */
  grain: Grain;

  /**
   * The start date of the summaries data that will be served in the report.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDate: utcDateTime;

  /**
   * The end date of the summaries data that will be served in the report.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDate: utcDateTime;

  /**
   * The type of benefit data requested. Required for billing account and billing profile scopes. Implied and not to be passed at benefit scopes. Supported values are Reservation and SavingsPlan
   */
  kind?: BenefitKind;
}

/**
 * Status of a benefit utilization summaries report. Provides Async Benefit Utilization Summaries Request input, status, and report sas url.
 */
model BenefitUtilizationSummariesOperationStatus {
  /**
   * Input given to create the benefit utilization summaries report.
   */
  input?: BenefitUtilizationSummariesRequest;

  /**
   * The status of the creation of the benefit utilization summaries report.
   */
  status?: OperationStatusType;

  /**
   * Contains sas url to the async benefit utilization summaries report and a date that the url is valid until. These values will be empty if the report is in a Running or Failed state
   */
  properties?: AsyncOperationStatusProperties;
}

/**
 * Object representing the report url and valid until date of the async report generated.
 */
model AsyncOperationStatusProperties {
  /**
   * Sas url to the async benefit utilization summaries report. Will be empty if the report is in Running or Failed state.
   */
  reportUrl?: BenefitUtilizationSummaryReportSchema;

  /**
   * Sas url to async benefit utilization summaries report in secondary storage in case of primary outage. Will be empty if the report is in Running or Failed state.
   */
  secondaryReportUrl?: BenefitUtilizationSummaryReportSchema;

  /**
   * The date that the sas url provided in reportUrl expires.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  validUntil?: utcDateTime;
}

/**
 * The properties of the export.
 */
model ExportProperties extends CommonExportProperties {
  /**
   * Has schedule information for the export.
   */
  schedule?: ExportSchedule;
}

/**
 * The schedule associated with the export.
 */
model ExportSchedule {
  /**
   * The status of the export's schedule. If 'Inactive', the export's schedule is paused.
   */
  status?: StatusType;

  /**
   * The schedule recurrence.
   */
  recurrence?: RecurrenceType;

  /**
   * Has start and end date of the recurrence. The start date must be in future. If present, the end date must be greater than start date.
   */
  recurrencePeriod?: ExportRecurrencePeriod;
}

/**
 * The start and end date for recurrence schedule.
 */
model ExportRecurrencePeriod {
  /**
   * The start date of recurrence.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  from: utcDateTime;

  /**
   * The end date of recurrence.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  to?: utcDateTime;
}

/**
 * The common properties of the export.
 */
model CommonExportProperties {
  /**
   * The format of the export being delivered. Currently only 'Csv' is supported.
   */
  format?: FormatType;

  /**
   * Has delivery information for the export.
   */
  deliveryInfo: ExportDeliveryInfo;

  /**
   * Has the definition for the export.
   */
  definition: ExportDefinition;

  /**
   * If requested, has the most recent run history for the export.
   */
  runHistory?: ExportExecutionListResult;

  /**
   * If set to true, exported data will be partitioned by size and placed in a blob directory together with a manifest file. Note: this option is currently available only for Microsoft Customer Agreement commerce scopes.
   */
  partitionData?: boolean;

  /**
   * If the export has an active schedule, provides an estimate of the next run time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextRunTimeEstimate?: utcDateTime;
}

/**
 * The delivery information associated with a export.
 */
model ExportDeliveryInfo {
  /**
   * Has destination for the export being delivered.
   */
  destination: ExportDeliveryDestination;
}

/**
 * This represents the blob storage account location where exports of costs will be delivered. There are two ways to configure the destination. The approach recommended for most customers is to specify the resourceId of the storage account. This requires a one-time registration of the account's subscription with the Microsoft.CostManagementExports resource provider in order to give Cost Management services access to the storage. When creating an export in the Azure portal this registration is performed automatically but API users may need to register the subscription explicitly (for more information see https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-manager-supported-services ). Another way to configure the destination is available ONLY to Partners with a Microsoft Partner Agreement plan who are global admins of their billing account. These Partners, instead of specifying the resourceId of a storage account, can specify the storage account name along with a SAS token for the account. This allows exports of costs to a storage account in any tenant. The SAS token should be created for the blob service with Service/Container/Object resource types and with Read/Write/Delete/List/Add/Create permissions (for more information see https://docs.microsoft.com/en-us/azure/cost-management-billing/costs/export-cost-data-storage-account-sas-key ).
 */
model ExportDeliveryDestination {
  /**
   * The resource id of the storage account where exports will be delivered. This is not required if a sasToken and storageAccount are specified.
   */
  resourceId?: string;

  /**
   * The name of the container where exports will be uploaded. If the container does not exist it will be created.
   */
  container: string;

  /**
   * The name of the directory where exports will be uploaded.
   */
  rootFolderPath?: string;

  /**
   * A SAS token for the storage account. For a restricted set of Azure customers this together with storageAccount can be specified instead of resourceId. Note: the value returned by the API for this property will always be obfuscated. Returning this same obfuscated value will not result in the SAS token being updated. To update this value a new SAS token must be specified.
   */
  sasToken?: string;

  /**
   * The storage account where exports will be uploaded. For a restricted set of Azure customers this together with sasToken can be specified instead of resourceId.
   */
  storageAccount?: string;
}

/**
 * The definition of an export.
 */
model ExportDefinition {
  /**
   * The type of the export. Note that 'Usage' is equivalent to 'ActualCost' and is applicable to exports that do not yet provide data for charges or amortization for service reservations.
   */
  type: ExportType;

  /**
   * The time frame for pulling data for the export. If custom, then a specific time period must be provided.
   */
  timeframe: TimeframeType;

  /**
   * Has time period for pulling data for the export.
   */
  timePeriod?: ExportTimePeriod;

  /**
   * The definition for data in the export.
   */
  dataSet?: ExportDataset;
}

/**
 * The date range for data in the export. This should only be specified with timeFrame set to 'Custom'. The maximum date range is 3 months.
 */
model ExportTimePeriod {
  /**
   * The start date for export data.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  from: utcDateTime;

  /**
   * The end date for export data.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  to: utcDateTime;
}

/**
 * The definition for data in the export.
 */
model ExportDataset {
  /**
   * The granularity of rows in the export. Currently only 'Daily' is supported.
   */
  granularity?: GranularityType;

  /**
   * The export dataset configuration.
   */
  configuration?: ExportDatasetConfiguration;
}

/**
 * The export dataset configuration. Allows columns to be selected for the export. If not provided then the export will include all available columns.
 */
model ExportDatasetConfiguration {
  /**
   * Array of column names to be included in the export. If not provided then the export will include all available columns. The available columns can vary by customer channel (see examples).
   */
  columns?: string[];
}

/**
 * Result of listing the run history of an export.
 */
model ExportExecutionListResult {
  /**
   * A list of export runs.
   */
  @visibility("read")
  value?: ExportRun[];
}

/**
 * An export run.
 */
model ExportRun extends CostManagementProxyResource {
  /**
   * The properties of the export run.
   */
  properties?: ExportRunProperties;
}

/**
 * The properties of the export run.
 */
model ExportRunProperties {
  /**
   * The type of the export run.
   */
  executionType?: ExecutionType;

  /**
   * The last known status of the export run.
   */
  status?: ExecutionStatus;

  /**
   * The identifier for the entity that triggered the export. For on-demand runs it is the user email. For scheduled runs it is 'System'.
   */
  submittedBy?: string;

  /**
   * The time when export was queued to be run.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  submittedTime?: utcDateTime;

  /**
   * The time when export was picked up to be run.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  processingStartTime?: utcDateTime;

  /**
   * The time when the export run finished.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  processingEndTime?: utcDateTime;

  /**
   * The name of the exported file.
   */
  fileName?: string;

  /**
   * The export settings that were in effect for this run.
   */
  runSettings?: CommonExportProperties;

  /**
   * The details of any error.
   */
  error?: ErrorDetails;
}

/**
 * The Resource model definition.
 */
model CostManagementProxyResource {
  /**
   * Resource Id.
   */
  @visibility("read")
  id?: string;

  /**
   * Resource name.
   */
  @visibility("read")
  name?: string;

  /**
   * Resource type.
   */
  @visibility("read")
  type?: string;

  /**
   * eTag of the resource. To handle concurrent update scenario, this field will be used to determine whether the user is updating the latest version or not.
   */
  eTag?: string;
}

/**
 * Result of listing views. It contains a list of available views.
 */
model ViewListResult is Azure.Core.Page<View>;

/**
 * The properties of the view.
 */
model ViewProperties {
  /**
   * User input name of the view. Required.
   */
  displayName?: string;

  /**
   * Cost Management scope to save the view on. This includes 'subscriptions/{subscriptionId}' for subscription scope, 'subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}' for resourceGroup scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}' for Billing Account scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/departments/{departmentId}' for Department scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/enrollmentAccounts/{enrollmentAccountId}' for EnrollmentAccount scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}' for BillingProfile scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/invoiceSections/{invoiceSectionId}' for InvoiceSection scope, 'providers/Microsoft.Management/managementGroups/{managementGroupId}' for Management Group scope, '/providers/Microsoft.CostManagement/externalBillingAccounts/{externalBillingAccountName}' for ExternalBillingAccount scope, and '/providers/Microsoft.CostManagement/externalSubscriptions/{externalSubscriptionName}' for ExternalSubscription scope.
   */
  scope?: string;

  /**
   * Date the user created this view.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;

  /**
   * Date when the user last modified this view.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  modifiedOn?: utcDateTime;

  /**
   * Date range of the current view.
   */
  @visibility("read")
  dateRange?: string;

  /**
   * Currency of the current view.
   */
  @visibility("read")
  currency?: string;

  /**
   * Query body configuration. Required.
   */
  query?: ReportConfigDefinition;

  /**
   * Chart type of the main view in Cost Analysis. Required.
   */
  chart?: ChartType;

  /**
   * Show costs accumulated over time.
   */
  accumulated?: AccumulatedType;

  /**
   * Metric to use when displaying costs.
   */
  metric?: MetricType;

  /**
   * List of KPIs to show in Cost Analysis UI.
   */
  kpis?: KpiProperties[];

  /**
   * Configuration of 3 sub-views in the Cost Analysis UI.
   */
  pivots?: PivotProperties[];
}

/**
 * The definition of a report config.
 */
model ReportConfigDefinition {
  /**
   * The type of the report. Usage represents actual usage, forecast represents forecasted data and UsageAndForecast represents both usage and forecasted data. Actual usage and forecasted data can be differentiated based on dates.
   */
  type: ReportType;

  /**
   * The time frame for pulling data for the report. If custom, then a specific time period must be provided.
   */
  timeframe: ReportTimeframeType;

  /**
   * Has time period for pulling data for the report.
   */
  timePeriod?: ReportConfigTimePeriod;

  /**
   * Has definition for data in this report config.
   */
  dataSet?: ReportConfigDataset;

  /**
   * If true, report includes monetary commitment.
   */
  includeMonetaryCommitment?: boolean;
}

/**
 * The start and end date for pulling data for the report.
 */
model ReportConfigTimePeriod {
  /**
   * The start date to pull data from.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  from: utcDateTime;

  /**
   * The end date to pull data to.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  to: utcDateTime;
}

/**
 * The definition of data present in the report.
 */
model ReportConfigDataset {
  /**
   * The granularity of rows in the report.
   */
  granularity?: ReportGranularityType;

  /**
   * Has configuration information for the data in the report. The configuration will be ignored if aggregation and grouping are provided.
   */
  configuration?: ReportConfigDatasetConfiguration;

  /**
   * Dictionary of aggregation expression to use in the report. The key of each item in the dictionary is the alias for the aggregated column. Report can have up to 2 aggregation clauses.
   */
  aggregation?: Record<ReportConfigAggregation>;

  /**
   * Array of group by expression to use in the report. Report can have up to 2 group by clauses.
   */
  grouping?: ReportConfigGrouping[];

  /**
   * Array of order by expression to use in the report.
   */
  sorting?: ReportConfigSorting[];

  /**
   * Has filter expression to use in the report.
   */
  filter?: ReportConfigFilter;
}

/**
 * The configuration of dataset in the report.
 */
model ReportConfigDatasetConfiguration {
  /**
   * Array of column names to be included in the report. Any valid report column name is allowed. If not provided, then report includes all columns.
   */
  columns?: string[];
}

/**
 * The aggregation expression to be used in the report.
 */
model ReportConfigAggregation {
  /**
   * The name of the column to aggregate.
   */
  name: string;

  /**
   * The name of the aggregation function to use.
   */
  function: FunctionType;
}

/**
 * The group by expression to be used in the report.
 */
model ReportConfigGrouping {
  /**
   * Has type of the column to group.
   */
  type: QueryColumnType;

  /**
   * The name of the column to group. This version supports subscription lowest possible grain.
   */
  name: string;
}

/**
 * The order by expression to be used in the report.
 */
model ReportConfigSorting {
  /**
   * Direction of sort.
   */
  direction?: ReportConfigSortingType;

  /**
   * The name of the column to sort.
   */
  name: string;
}

/**
 * The filter expression to be used in the report.
 */
model ReportConfigFilter {
  /**
   * The logical "AND" expression. Must have at least 2 items.
   */
  and?: ReportConfigFilter[];

  /**
   * The logical "OR" expression. Must have at least 2 items.
   */
  or?: ReportConfigFilter[];

  /**
   * Has comparison expression for a dimension
   */
  dimensions?: ReportConfigComparisonExpression;

  /**
   * Has comparison expression for a tag
   */
  tags?: ReportConfigComparisonExpression;
}

/**
 * The comparison expression to be used in the report.
 */
model ReportConfigComparisonExpression {
  /**
   * The name of the column to use in comparison.
   */
  name: string;

  /**
   * The operator to use for comparison.
   */
  operator: OperatorType;

  /**
   * Array of values to use for comparison
   */
  values: string[];
}

/**
 * Each KPI must contain a 'type' and 'enabled' key.
 */
model KpiProperties {
  /**
   * KPI type (Forecast, Budget).
   */
  type?: KpiTypeType;

  /**
   * ID of resource related to metric (budget).
   */
  id?: string;

  /**
   * show the KPI in the UI?
   */
  enabled?: boolean;
}

/**
 * Each pivot must contain a 'type' and 'name'.
 */
model PivotProperties {
  /**
   * Data type to show in view.
   */
  type?: PivotTypeType;

  /**
   * Data field to show in view.
   */
  name?: string;
}

/**
 * Alert properties.
 */
model AlertProperties {
  /**
   * defines the type of alert
   */
  definition?: AlertPropertiesDefinition;

  /**
   * Alert description
   */
  description?: string;

  /**
   * Source of alert
   */
  source?: AlertSource;

  /**
   * Alert details
   */
  details?: AlertPropertiesDetails;

  /**
   * related budget
   */
  costEntityId?: string;

  /**
   * alert status
   */
  status?: AlertStatus;

  /**
   * dateTime in which alert was created
   */
  creationTime?: string;

  /**
   * dateTime in which alert was closed
   */
  closeTime?: string;

  /**
   * dateTime in which alert was last modified
   */
  modificationTime?: string;

  /**
   * User who last modified the alert
   */
  statusModificationUserName?: string;

  /**
   * dateTime in which the alert status was last modified
   */
  statusModificationTime?: string;
}

/**
 * defines the type of alert
 */
model AlertPropertiesDefinition {
  /**
   * type of alert
   */
  type?: AlertType;

  /**
   * Alert category
   */
  category?: AlertCategory;

  /**
   * Criteria that triggered alert
   */
  criteria?: AlertCriteria;
}

/**
 * Alert details
 */
model AlertPropertiesDetails {
  /**
   * Type of timegrain cadence
   */
  timeGrainType?: AlertTimeGrainType;

  /**
   * datetime of periodStartDate
   */
  periodStartDate?: string;

  /**
   * notificationId that triggered this alert
   */
  triggeredBy?: string;

  /**
   * array of resourceGroups to filter by
   */
  resourceGroupFilter?: unknown[];

  /**
   * array of resources to filter by
   */
  resourceFilter?: unknown[];

  /**
   * array of meters to filter by
   */
  meterFilter?: unknown[];

  /**
   * tags to filter by
   */
  tagFilter?: Record<unknown>;

  /**
   * notification threshold percentage as a decimal which activated this alert
   */
  threshold?: decimal;

  /**
   * operator used to compare currentSpend with amount
   */
  operator?: AlertOperator;

  /**
   * budget threshold amount
   */
  amount?: decimal;

  /**
   * unit of currency being used
   */
  unit?: string;

  /**
   * current spend
   */
  currentSpend?: decimal;

  /**
   * list of emails to contact
   */
  contactEmails?: string[];

  /**
   * list of action groups to broadcast to
   */
  contactGroups?: string[];

  /**
   * list of contact roles
   */
  contactRoles?: string[];

  /**
   * overriding alert
   */
  overridingAlert?: string;

  /**
   * department name
   */
  departmentName?: string;

  /**
   * company name
   */
  companyName?: string;

  /**
   * enrollment number
   */
  enrollmentNumber?: string;

  /**
   * datetime of enrollmentStartDate
   */
  enrollmentStartDate?: string;

  /**
   * datetime of enrollmentEndDate
   */
  enrollmentEndDate?: string;

  /**
   * invoicing threshold
   */
  invoicingThreshold?: decimal;
}

/**
 * The request payload to update an alert
 */
model DismissAlertPayload {
  /**
   * Alert properties.
   */
  properties?: AlertProperties;
}

/**
 * The definition of a forecast.
 */
model ForecastDefinition {
  /**
   * The type of the forecast.
   */
  type: ForecastType;

  /**
   * The time frame for pulling data for the forecast. If custom, then a specific time period must be provided.
   */
  timeframe: ForecastTimeframe;

  /**
   * Has time period for pulling data for the forecast.
   */
  timePeriod?: ForecastTimePeriod;

  /**
   * Has definition for data in this forecast.
   */
  dataset: ForecastDataset;

  /**
   * A boolean determining if actualCost will be included.
   */
  includeActualCost?: boolean;

  /**
   * A boolean determining if FreshPartialCost will be included.
   */
  includeFreshPartialCost?: boolean;
}

/**
 * Has time period for pulling data for the forecast.
 */
model ForecastTimePeriod {
  /**
   * The start date to pull data from.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  from: utcDateTime;

  /**
   * The end date to pull data to.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  to: utcDateTime;
}

/**
 * The definition of data present in the forecast.
 */
model ForecastDataset {
  /**
   * The granularity of rows in the forecast.
   */
  granularity?: GranularityType;

  /**
   * Has configuration information for the data in the export. The configuration will be ignored if aggregation and grouping are provided.
   */
  configuration?: ForecastDatasetConfiguration;

  /**
   * Dictionary of aggregation expression to use in the forecast. The key of each item in the dictionary is the alias for the aggregated column. forecast can have up to 2 aggregation clauses.
   */
  aggregation: Record<ForecastAggregation>;

  /**
   * Has filter expression to use in the forecast.
   */
  filter?: ForecastFilter;
}

/**
 * The configuration of dataset in the forecast.
 */
model ForecastDatasetConfiguration {
  /**
   * Array of column names to be included in the forecast. Any valid forecast column name is allowed. If not provided, then forecast includes all columns.
   */
  columns?: string[];
}

/**
 * The aggregation expression to be used in the forecast.
 */
model ForecastAggregation {
  /**
   * The name of the column to aggregate.
   */
  name: FunctionName;

  /**
   * The name of the aggregation function to use.
   */
  function: FunctionType;
}

/**
 * The filter expression to be used in the export.
 */
model ForecastFilter {
  /**
   * The logical "AND" expression. Must have at least 2 items.
   */
  and?: ForecastFilter[];

  /**
   * The logical "OR" expression. Must have at least 2 items.
   */
  or?: ForecastFilter[];

  /**
   * Has comparison expression for a dimension
   */
  dimensions?: ForecastComparisonExpression;

  /**
   * Has comparison expression for a tag
   */
  tags?: ForecastComparisonExpression;
}

/**
 * The comparison expression to be used in the forecast.
 */
model ForecastComparisonExpression {
  /**
   * The name of the column to use in comparison.
   */
  name: string;

  /**
   * The operator to use for comparison.
   */
  operator: ForecastOperatorType;

  /**
   * Array of values to use for comparison
   */
  values: string[];
}

/**
 * Result of forecast. It contains all columns listed under groupings and aggregation.
 */
model ForecastResult extends CostManagementResource {
  /**
   * Forecast properties
   */
  properties?: ForecastProperties;
}

/**
 * Forecast properties
 */
model ForecastProperties {
  /**
   * The link (url) to the next page of results.
   */
  nextLink?: string;

  /**
   * Array of columns
   */
  columns?: ForecastColumn[];

  /**
   * Array of rows
   */
  rows?: unknown[][];
}

/**
 * Forecast column properties
 */
model ForecastColumn {
  /**
   * The name of column.
   */
  name?: string;

  /**
   * The type of column.
   */
  type?: string;
}

/**
 * The Resource model definition.
 */
model CostManagementResource {
  /**
   * Resource Id.
   */
  @visibility("read")
  id?: string;

  /**
   * Resource name.
   */
  @visibility("read")
  name?: string;

  /**
   * Resource type.
   */
  @visibility("read")
  type?: string;

  /**
   * Location of the resource.
   */
  @visibility("read")
  location?: string;

  /**
   * SKU of the resource.
   */
  @visibility("read")
  sku?: string;

  /**
   * ETag of the resource.
   */
  @visibility("read")
  eTag?: string;

  /**
   * Resource tags.
   */
  @visibility("read")
  tags?: Record<string>;
}

/**
 * Result of listing dimensions. It contains a list of available dimensions.
 */
@pagedResult
model DimensionsListResult {
  /**
   * The list of dimensions.
   */
  @visibility("read")
  @items
  value?: Dimension[];
}

/**
 * List of Dimension.
 */
model Dimension extends CostManagementResource {
  /**
   * Dimension properties.
   */
  properties?: DimensionProperties;
}

/**
 * Dimension properties.
 */
model DimensionProperties {
  /**
   * Dimension description.
   */
  @visibility("read")
  description?: string;

  /**
   * Filter enabled.
   */
  @visibility("read")
  filterEnabled?: boolean;

  /**
   * Grouping enabled.
   */
  @visibility("read")
  groupingEnabled?: boolean;

  /**
   * Dimension data.
   */
  data?: string[];

  /**
   * Total number of data for the dimension.
   */
  @visibility("read")
  total?: int32;

  /**
   * Dimension category.
   */
  @visibility("read")
  category?: string;

  /**
   * Usage start.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  usageStart?: utcDateTime;

  /**
   * Usage end.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  usageEnd?: utcDateTime;

  /**
   * The link (url) to the next page of results.
   */
  @visibility("read")
  nextLink?: string;
}

/**
 * The definition of a query.
 */
model QueryDefinition {
  /**
   * The type of the query.
   */
  type: ExportType;

  /**
   * The time frame for pulling data for the query. If custom, then a specific time period must be provided.
   */
  timeframe: TimeframeType;

  /**
   * Has time period for pulling data for the query.
   */
  timePeriod?: QueryTimePeriod;

  /**
   * Has definition for data in this query.
   */
  dataset: QueryDataset;
}

/**
 * The start and end date for pulling data for the query.
 */
model QueryTimePeriod {
  /**
   * The start date to pull data from.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  from: utcDateTime;

  /**
   * The end date to pull data to.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  to: utcDateTime;
}

/**
 * The definition of data present in the query.
 */
model QueryDataset {
  /**
   * The granularity of rows in the query.
   */
  granularity?: GranularityType;

  /**
   * Has configuration information for the data in the export. The configuration will be ignored if aggregation and grouping are provided.
   */
  configuration?: QueryDatasetConfiguration;

  /**
   * Dictionary of aggregation expression to use in the query. The key of each item in the dictionary is the alias for the aggregated column. Query can have up to 2 aggregation clauses.
   */
  aggregation?: Record<QueryAggregation>;

  /**
   * Array of group by expression to use in the query. Query can have up to 2 group by clauses.
   */
  grouping?: QueryGrouping[];

  /**
   * The filter expression to use in the query. Please reference our Query API REST documentation for how to properly format the filter.
   */
  filter?: QueryFilter;
}

/**
 * The configuration of dataset in the query.
 */
model QueryDatasetConfiguration {
  /**
   * Array of column names to be included in the query. Any valid query column name is allowed. If not provided, then query includes all columns.
   */
  columns?: string[];
}

/**
 * The aggregation expression to be used in the query.
 */
model QueryAggregation {
  /**
   * The name of the column to aggregate.
   */
  name: string;

  /**
   * The name of the aggregation function to use.
   */
  function: FunctionType;
}

/**
 * The group by expression to be used in the query.
 */
model QueryGrouping {
  /**
   * Has type of the column to group.
   */
  type: QueryColumnType;

  /**
   * The name of the column to group.
   */
  name: string;
}

/**
 * The filter expression to be used in the export.
 */
model QueryFilter {
  /**
   * The logical "AND" expression. Must have at least 2 items.
   */
  and?: QueryFilter[];

  /**
   * The logical "OR" expression. Must have at least 2 items.
   */
  or?: QueryFilter[];

  /**
   * Has comparison expression for a dimension
   */
  dimensions?: QueryComparisonExpression;

  /**
   * Has comparison expression for a tag
   */
  tags?: QueryComparisonExpression;
}

/**
 * The comparison expression to be used in the query.
 */
model QueryComparisonExpression {
  /**
   * The name of the column to use in comparison.
   */
  name: string;

  /**
   * The operator to use for comparison.
   */
  operator: QueryOperatorType;

  /**
   * Array of values to use for comparison
   */
  values: string[];
}

/**
 * Result of query. It contains all columns listed under groupings and aggregation.
 */
model QueryResult extends CostManagementResource {
  /**
   * Query properties
   */
  properties?: QueryProperties;
}

/**
 * Query properties
 */
model QueryProperties {
  /**
   * The link (url) to the next page of results.
   */
  nextLink?: string;

  /**
   * Array of columns
   */
  columns?: QueryColumn[];

  /**
   * Array of rows
   */
  rows?: unknown[][];
}

/**
 * QueryColumn properties
 */
model QueryColumn {
  /**
   * The name of column.
   */
  name?: string;

  /**
   * The type of column.
   */
  type?: string;
}

/**
 * The status of the long running operation.
 */
model OperationStatus {
  /**
   * The status of the long running operation.
   */
  status?: OperationStatusType;

  /**
   * The properties of the resource generated.
   */
  properties?: ReportURL;
}

/**
 * The URL to download the generated report.
 */
model ReportURL {
  /**
   * The CSV file from the reportUrl blob link consists of reservation usage data with the following schema at daily granularity
   */
  reportUrl?: ReservationReportSchema;

  /**
   * The time at which report URL becomes invalid.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  validUntil?: utcDateTime;
}

/**
 * The URL to download the generated report.
 */
model DownloadURL {
  /**
   * The time at which report URL becomes invalid/expires in UTC e.g. 2020-12-08T05:55:59.4394737Z.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryTime?: utcDateTime;

  /**
   * The time at which report URL becomes invalid/expires in UTC e.g. 2020-12-08T05:55:59.4394737Z.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  validTill?: utcDateTime;

  /**
   * The URL to download the generated report.
   */
  downloadUrl?: string;
}

/**
 * Scheduled actions list result. It contains a list of scheduled actions.
 */
model ScheduledActionListResult is Azure.Core.Page<ScheduledAction>;

/**
 * The properties of the scheduled action.
 */
model ScheduledActionProperties {
  /**
   * Scheduled action name.
   */
  displayName: string;

  /**
   * Destination format of the view data. This is optional.
   */
  fileDestination?: FileDestination;

  /**
   * Notification properties based on scheduled action kind.
   */
  notification: NotificationProperties;

  /**
   * Email address of the point of contact that should get the unsubscribe requests and notification emails.
   */
  notificationEmail?: string;

  /**
   * Schedule of the scheduled action.
   */
  schedule: ScheduleProperties;

  /**
   * Cost Management scope like 'subscriptions/{subscriptionId}' for subscription scope, 'subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}' for resourceGroup scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}' for Billing Account scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/departments/{departmentId}' for Department scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/enrollmentAccounts/{enrollmentAccountId}' for EnrollmentAccount scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}' for BillingProfile scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/invoiceSections/{invoiceSectionId}' for InvoiceSection scope, '/providers/Microsoft.CostManagement/externalBillingAccounts/{externalBillingAccountName}' for ExternalBillingAccount scope, and '/providers/Microsoft.CostManagement/externalSubscriptions/{externalSubscriptionName}' for ExternalSubscription scope.
   */
  scope?: string;

  /**
   * Status of the scheduled action.
   */
  status: ScheduledActionStatus;

  /**
   * Cost analysis viewId used for scheduled action. For example, '/providers/Microsoft.CostManagement/views/swaggerExample'
   */
  viewId: string;
}

/**
 * Destination of the view data. This is optional. Currently only CSV format is supported.
 */
model FileDestination {
  /**
   * Destination of the view data. Currently only CSV format is supported.
   */
  fileFormats?: FileFormat[];
}

/**
 * The properties of the scheduled action notification.
 */
model NotificationProperties {
  /**
   * Array of email addresses.
   */
  to: string[];

  /**
   * Locale of the email.
   */
  language?: string;

  /**
   * Optional message to be added in the email. Length is limited to 250 characters.
   */
  message?: string;

  /**
   * Regional format used for formatting date/time and currency values in the email.
   */
  regionalFormat?: string;

  /**
   * Subject of the email. Length is limited to 70 characters.
   */
  subject: string;
}

/**
 * The properties of the schedule.
 */
model ScheduleProperties {
  /**
   * Frequency of the schedule.
   */
  frequency: ScheduleFrequency;

  /**
   * UTC time at which cost analysis data will be emailed.
   */
  hourOfDay?: int32;

  /**
   * Day names in english on which cost analysis data will be emailed. This property is applicable when frequency is Weekly or Monthly.
   */
  daysOfWeek?: DaysOfWeek[];

  /**
   * Weeks in which cost analysis data will be emailed. This property is applicable when frequency is Monthly and used in combination with daysOfWeek.
   */
  weeksOfMonth?: WeeksOfMonth[];

  /**
   * UTC day on which cost analysis data will be emailed. Must be between 1 and 31. This property is applicable when frequency is Monthly and overrides weeksOfMonth or daysOfWeek.
   */
  dayOfMonth?: int32;

  /**
   * The start date and time of the scheduled action (UTC).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDate: utcDateTime;

  /**
   * The end date and time of the scheduled action (UTC).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDate: utcDateTime;
}

/**
 * The Resource model definition.
 */
model ScheduledActionProxyResource extends ProxyResource {
  /**
   * Resource Etag. For update calls, eTag is optional and can be specified to achieve optimistic concurrency. Fetch the resource's eTag by doing a 'GET' call first and then including the latest eTag as part of the request body or 'If-Match' header while performing the update. For create calls, eTag is not required.
   */
  @visibility("read")
  eTag?: string;

  /**
   * Kind of the scheduled action.
   */
  kind?: ScheduledActionKind;

  /**
   * Kind of the scheduled action.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
* Error response indicates that the service is not able to process the incoming request. The reason is provided in the error message. 

Some Error responses: 

 * 429 TooManyRequests - Request is throttled. Retry after waiting for the time specified in the "x-ms-ratelimit-microsoft.consumption-retry-after" header. 

 * 503 ServiceUnavailable - Service is temporarily unavailable. Retry after waiting for the time specified in the "Retry-After" header.
*/
@error
model ErrorResponseWithNestedDetails {
  /**
   * The details of the error.
   */
  error?: ErrorDetailsWithNestedDetails;
}

/**
 * The details of the error.
 */
model ErrorDetailsWithNestedDetails extends ErrorDetails {
  /**
   * The additional details of the error.
   */
  @visibility("read")
  details?: ErrorDetailsWithNestedDetails[];
}

/**
 * The check availability request body.
 */
model CheckNameAvailabilityRequest {
  /**
   * The name of the resource for which availability needs to be checked.
   */
  name?: string;

  /**
   * The resource type.
   */
  type?: string;
}

/**
 * The check availability result.
 */
model CheckNameAvailabilityResponse {
  /**
   * Indicates if the resource name is available.
   */
  nameAvailable?: boolean;

  /**
   * The reason why the given name is not available.
   */
  reason?: CheckNameAvailabilityReason;

  /**
   * Detailed reason why the given name is available.
   */
  message?: string;
}

/**
 * A Cost management REST API operation.
 */
model CostManagementOperation extends Operation {
  /**
   * Operation id: {provider}/{resource}/{operation}.
   */
  @visibility("read")
  id?: string;
}

/**
 * The properties of the benefit recommendations when scope is 'Single'.
 */
model SingleScopeBenefitRecommendationProperties
  extends BenefitRecommendationProperties {
  /**
   * The subscription ID that this single scope recommendation is for. Applicable only if recommendation is for 'Single' scope.
   */
  @visibility("read")
  subscriptionId?: string;

  /**
   * The resource group that this single scope recommendation is for. Applicable only if recommendation is for 'Single' scope and 'ResourceGroup' request scope.
   */
  @visibility("read")
  resourceGroup?: string;

  /**
   * Benefit scope. For example, Single or Shared.
   */
  scope: "Single";
}

/**
 * The properties of the benefit recommendation when scope is 'Shared'.
 */
model SharedScopeBenefitRecommendationProperties
  extends BenefitRecommendationProperties {
  /**
   * Benefit scope. For example, Single or Shared.
   */
  scope: "Shared";
}

/**
 * The properties of a benefit utilization summary.
 */
model BenefitUtilizationSummaryProperties {
  /**
   * ARM SKU name. For example, 'Compute_Savings_Plan' for savings plan.
   */
  @visibility("read")
  armSkuName?: string;

  /**
   * The benefit ID is the identifier of the benefit.
   */
  @visibility("read")
  benefitId?: string;

  /**
   * The benefit order ID is the identifier for a benefit purchase.
   */
  @visibility("read")
  benefitOrderId?: string;

  /**
   * The benefit type. Supported values: 'SavingsPlan'.
   */
  benefitType?: BenefitKind;

  /**
   * Date corresponding to the utilization summary record. If the grain of data is monthly, value for this field will be first day of the month.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  usageDate?: utcDateTime;
}

/**
 * Included Quantity utilization summary resource.
 */
model IncludedQuantityUtilizationSummary extends BenefitUtilizationSummary {
  /**
   * Included Quantity utilization summary properties.
   */
  properties?: IncludedQuantityUtilizationSummaryProperties;

  /**
   * Supported values: 'SavingsPlan'.
   */
  kind: "IncludedQuantity";
}

/**
 * Included Quantity utilization summary properties.
 */
model IncludedQuantityUtilizationSummaryProperties
  extends BenefitUtilizationSummaryProperties {
  /**
   * This is the utilized percentage for the benefit ID.
   */
  @visibility("read")
  utilizationPercentage?: decimal;
}

/**
 * Savings plan utilization summary resource.
 */
model SavingsPlanUtilizationSummary extends BenefitUtilizationSummary {
  /**
   * Savings plan utilization summary properties.
   */
  properties?: SavingsPlanUtilizationSummaryProperties;

  /**
   * Supported values: 'SavingsPlan'.
   */
  kind: "SavingsPlan";
}

/**
 * Savings plan utilization summary properties.
 */
model SavingsPlanUtilizationSummaryProperties
  extends BenefitUtilizationSummaryProperties {
  /**
   * This is the average hourly utilization for each date range that corresponds to given grain (Daily, Monthly). Suppose the API call is for usageDate > 2023-03-01 and usageDate < 2022-10-31 at a daily granularity. There will be one record per benefit id for each day. For a single day, the avgUtilizationPercentage value will be equal to the average of the set of values where the set contains 24 utilization percentage entries one for each hour in a specific day.
   */
  @visibility("read")
  avgUtilizationPercentage?: decimal;

  /**
   * This is the minimum hourly utilization for each date range that corresponds to given grain (Daily, Monthly). Suppose the API call is for usageDate > 2023-03-01 and usageDate < 2022-10-31 at a daily granularity. There will be one record per benefit id for each day. For a single day, the minUtilizationPercentage value will be equal to the smallest in the set of values where the set contains 24 utilization percentage entries one for each hour in a specific day. If on the day 2022-10-18, the lowest utilization percentage was 10% at hour 4, then the value for the minUtilizationPercentage in the response will be 10%.
   */
  @visibility("read")
  minUtilizationPercentage?: decimal;

  /**
   * This is the maximum hourly utilization for each date range that corresponds to given grain (Daily, Monthly). Suppose the API call is for usageDate > 2023-03-01 and usageDate < 2022-10-31 at a daily granularity. There will be one record per benefit id for each day. For a single day, the maxUtilizationPercentage value will be equal to the largest in the set of values where the set contains 24 utilization percentage entries one for each hour in a specific day. If on the day 2022-10-18, the largest utilization percentage was 90% at hour 5, then the value for the maxUtilizationPercentage in the response will be 90%.
   */
  @visibility("read")
  maxUtilizationPercentage?: decimal;
}

/**
* Error response indicates that the service is not able to process the incoming request. The reason is provided in the error message. 

Some Error responses: 

 * 400 Bad Request - Invalid Request Payload. Request payload provided is not in a json format or had an invalid member not accepted in the request payload. 

 * 400 Bad Request - Invalid request payload:  can only have either timePeriod or invoiceId or billingPeriod. API only allows data to be pulled for either timePeriod or invoiceId or billingPeriod. Customer should provide only one of these parameters. 

 * 400 Bad Request - Start date must be after . API only allows data to be pulled no older than 13 months from now. 

 * 400 Bad Request - The maximum allowed date range is 1 months. API only allows data to be pulled for 1 month or less. 

 * 429 TooManyRequests - Request is throttled. Retry after waiting for the time specified in the "retry-after" header. 

 * 503 ServiceUnavailable - Service is temporarily unavailable. Retry after waiting for the time specified in the "Retry-After" header.
*/
model GenerateCostDetailsReportErrorResponse {
  /**
   * The details of the error.
   */
  error?: ErrorDetails;
}

/**
 * The definition of a cost detailed report.
 */
model GenerateCostDetailsReportRequestDefinition {
  /**
   * The type of the detailed report. By default ActualCost is provided
   */
  metric?: CostDetailsMetricType;

  /**
   * The specific date range of cost details requested for the report. This parameter cannot be used alongside either the invoiceId or billingPeriod parameters. If a timePeriod, invoiceId or billingPeriod parameter is not provided in the request body the API will return the current month's cost. API only allows data to be pulled for 1 month or less and no older than 13 months. If no timePeriod or billingPeriod or invoiceId is provided the API defaults to the open month time period
   */
  timePeriod?: CostDetailsTimePeriod;

  /**
   * This parameter can be used only by Enterprise Agreement customers. Use the YearMonth(e.g. 202008) format. This parameter cannot be used alongside either the invoiceId or timePeriod parameters. If a timePeriod, invoiceId or billingPeriod parameter is not provided in the request body the API will return the current month's cost.
   */
  billingPeriod?: string;

  /**
   * This parameter can only be used by Microsoft Customer Agreement customers. Additionally, it can only be used at the Billing Profile or Customer scope. This parameter cannot be used alongside either the billingPeriod or timePeriod parameters. If a timePeriod, invoiceId or billingPeriod parameter is not provided in the request body the API will return the current month's cost.
   */
  invoiceId?: string;
}

/**
 * The start and end date for pulling data for the cost detailed report. API only allows data to be pulled for 1 month or less and no older than 13 months.
 */
model CostDetailsTimePeriod {
  /**
   * The start date to pull data from. example format 2020-03-15
   */
  start: string;

  /**
   * The end date to pull data to. example format 2020-03-15
   */
  end: string;
}

/**
 * The result of the long running operation for cost details Api.
 */
model CostDetailsOperationResults {
  /**
   * The id of the long running operation.
   */
  id?: string;

  /**
   * The name of the long running operation.
   */
  name?: string;

  /**
   * The type of the long running operation.
   */
  type?: string;

  /**
   * The status of the cost details operation
   */
  status?: CostDetailsStatusType;

  /**
   * The manifest of the report generated by the operation.
   */
  manifest?: ReportManifest;

  /**
   * The time at which report URL becomes invalid/expires in UTC e.g. 2020-12-08T05:55:59.4394737Z.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  validTill?: utcDateTime;

  /**
   * The details of the error.
   */
  error?: ErrorDetails;
}

/**
 * The manifest of the report generated by the operation.
 */
model ReportManifest {
  /**
   * The Manifest version.
   */
  manifestVersion?: string;

  /**
   * The data format of the report
   */
  dataFormat?: CostDetailsDataFormat;

  /**
   * The total number of bytes in all blobs.
   */
  byteCount?: int64;

  /**
   * The total number of blobs.
   */
  blobCount?: int32;

  /**
   * Is the data in compressed format.
   */
  compressData?: boolean;

  /**
   * The context of the Cost Details request.
   */
  requestContext?: RequestContext;

  /**
   * List of blob information generated by this operation.
   */
  blobs?: BlobInfo[];
}

/**
 * The context of the Cost Details request.
 */
model RequestContext {
  /**
   * The request scope of the request.
   */
  requestScope?: string;

  /**
   * The request payload body provided in Cost Details call
   */
  requestBody?: GenerateCostDetailsReportRequestDefinition;
}

/**
 * The blob information generated by this operation.
 */
model BlobInfo {
  /**
   * Link to the blob to download file.
   */
  blobLink?: string;

  /**
   * Bytes in the blob.
   */
  byteCount?: int64;
}

/**
* Error response indicates that the service is not able to process the incoming request. The reason is provided in the error message. 

Some Error responses: 

 * 413 Request Entity Too Large - Request is throttled. The amount of data required to fulfill the request exceeds the maximum size permitted of 2Gb. Please utilize our Exports feature instead. 

 * 429 TooManyRequests - Request is throttled. Retry after waiting for the time specified in the "x-ms-ratelimit-microsoft.consumption-retry-after" header. 

 * 503 ServiceUnavailable - Service is temporarily unavailable. Retry after waiting for the time specified in the "Retry-After" header.
*/
model GenerateDetailedCostReportErrorResponse {
  /**
   * The details of the error.
   */
  error?: ErrorDetails;
}

/**
 * The definition of a cost detailed report.
 */
model GenerateDetailedCostReportDefinition {
  /**
   * The type of the detailed report. By default ActualCost is provided
   */
  metric?: GenerateDetailedCostReportMetricType;

  /**
   * Has time period for pulling data for the cost detailed report. Can only have one of either timePeriod or invoiceId or billingPeriod parameters. If none provided current month cost is provided.
   */
  timePeriod?: GenerateDetailedCostReportTimePeriod;

  /**
   * Billing period in YearMonth(e.g. 202008) format. Only for legacy enterprise customers can use this. Can only have one of either timePeriod or invoiceId or billingPeriod parameters. If none provided current month cost is provided.
   */
  billingPeriod?: string;

  /**
   * Invoice ID for Pay-as-you-go and Microsoft Customer Agreement scopes. Can only have one of either timePeriod or invoiceId or billingPeriod parameters. If none provided current month cost is provided.
   */
  invoiceId?: string;

  /**
   * Customer ID for Microsoft Customer Agreement scopes (Invoice Id is also required for this).
   */
  customerId?: string;
}

/**
 * The start and end date for pulling data for the cost detailed report.
 */
model GenerateDetailedCostReportTimePeriod {
  /**
   * The start date to pull data from. example format 2020-03-15
   */
  start: string;

  /**
   * The end date to pull data to. example format 2020-03-15
   */
  end: string;
}

/**
 * The status of the long running operation for cost detailed report.
 */
model GenerateDetailedCostReportOperationStatuses {
  /**
   * The ID of the long running operation.
   */
  id?: string;

  /**
   * The name of the long running operation.
   */
  name?: string;

  /**
   * The status of the long running operation.
   */
  status?: Status;

  /**
   * The startTime of the operation.
   */
  startTime?: string;

  /**
   * The endTime of the operation.
   */
  endTime?: string;

  /**
   * The type of the long running operation.
   */
  type?: string;

  /**
   * The details of the error.
   */
  error?: ErrorDetails;

  /**
   * The properties of the usage file generated.
   */
  properties?: DownloadURL;
}

/**
 * The status of the long running operation.
 */
model Status {
  /**
   * The status of the long running operation.
   */
  status?: ReportOperationStatusType;
}

/**
 * The result of the long running operation for cost detailed report.
 */
model GenerateDetailedCostReportOperationResult {
  /**
   * The ARM resource id of the long running operation.
   */
  id?: string;

  /**
   * The name of the long running operation.
   */
  name?: string;

  /**
   * The type of the long running operation.
   */
  type?: string;

  /**
   * The properties of the resource generated.
   */
  properties?: DownloadURL;
}
