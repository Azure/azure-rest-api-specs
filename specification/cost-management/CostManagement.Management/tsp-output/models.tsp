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

@doc("The number of days used to look back.")
enum LookBackPeriod {
  @doc("7 days used to look back.") Last7Days,
  @doc("30 days used to look back.") Last30Days,
  @doc("60 days used to look back.") Last60Days,
}

@doc("Grain which corresponds to value.")
enum Grain {
  @doc("Hourly grain corresponds to value per hour.") Hourly,
  @doc("Hourly grain corresponds to value per day.") Daily,
  @doc("Hourly grain corresponds to value per month.") Monthly,
}

@doc("Grain which corresponds to value.")
enum Term {
  @doc("Benefit term is 1 year.") P1Y,
  @doc("Benefit term is 3 years.") P3Y,
}

@doc("Kind of the recommendation scope.")
enum Scope {
  @doc("Single scope recommendation.") Single,
  @doc("Shared scope recommendation.") Shared,
}

@doc("Kind/type of the benefit.")
enum BenefitKind {
  @doc("Benefit is IncludedQuantity.") IncludedQuantity,
  @doc("Benefit is Reservation.") Reservation,
  @doc("Benefit is SavingsPlan.") SavingsPlan,
}

enum GrainParameter {
  @doc("Hourly grain corresponds to value per hour.") Hourly,
  @doc("Hourly grain corresponds to value per day.") Daily,
  @doc("Hourly grain corresponds to value per month.") Monthly,
}

@doc("Enum representing the status of an async operation.")
enum OperationStatusType {
  Running,
  Complete,
  Failed,
  Completed,
}

@doc("The CSV file from the reportUrl and secondaryReportUrl blob link will consist of the following columns of benefit utilization data. UtilizedPercentage will be 0 for savings plans reports and non data bricks reservations. Utilization percentages will be 0 for data bricks reservations.")
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

@doc("The status of the export's schedule. If 'Inactive', the export's schedule is paused.")
enum StatusType {
  Active,
  Inactive,
}

@doc("The schedule recurrence.")
enum RecurrenceType {
  Daily,
  Weekly,
  Monthly,
  Annually,
}

@doc("The format of the export being delivered. Currently only 'Csv' is supported.")
enum FormatType {
  Csv,
}

@doc("The type of the export. Note that 'Usage' is equivalent to 'ActualCost' and is applicable to exports that do not yet provide data for charges or amortization for service reservations.")
enum ExportType {
  Usage,
  ActualCost,
  AmortizedCost,
}

@doc("The time frame for pulling data for the export. If custom, then a specific time period must be provided.")
enum TimeframeType {
  MonthToDate,
  BillingMonthToDate,
  TheLastMonth,
  TheLastBillingMonth,
  WeekToDate,
  Custom,
}

@doc("The granularity of rows in the export. Currently only 'Daily' is supported.")
enum GranularityType {
  Daily,
}

@doc("The type of the export run.")
enum ExecutionType {
  OnDemand,
  Scheduled,
}

@doc("The last known status of the export run.")
enum ExecutionStatus {
  Queued,
  InProgress,
  Completed,
  Failed,
  Timeout,
  NewDataNotAvailable,
  DataNotAvailable,
}

@doc("The type of the report. Usage represents actual usage, forecast represents forecasted data and UsageAndForecast represents both usage and forecasted data. Actual usage and forecasted data can be differentiated based on dates.")
enum ReportType {
  Usage,
}

@doc("The time frame for pulling data for the report. If custom, then a specific time period must be provided.")
enum ReportTimeframeType {
  WeekToDate,
  MonthToDate,
  YearToDate,
  Custom,
}

@doc("The granularity of rows in the report.")
enum ReportGranularityType {
  Daily,
  Monthly,
}

@doc("The name of the aggregation function to use.")
enum FunctionType {
  Sum,
}

@doc("The type of the column in the report.")
enum QueryColumnType {
  @doc("The tag associated with the cost data.") TagKey,
  @doc("The dimension of cost data.") Dimension,
}

@doc("Direction of sort.")
enum ReportConfigSortingType {
  Ascending,
  Descending,
}

@doc("The operator to use for comparison.")
enum OperatorType {
  In,
  Contains,
}

@doc("Chart type of the main view in Cost Analysis. Required.")
enum ChartType {
  Area,
  Line,
  StackedColumn,
  GroupedColumn,
  Table,
}

@doc("Show costs accumulated over time.")
enum AccumulatedType {
  `true`,
  `false`,
}

@doc("Metric to use when displaying costs.")
enum MetricType {
  ActualCost,
  AmortizedCost,
  AHUB,
}

@doc("KPI type (Forecast, Budget).")
enum KpiTypeType {
  Forecast,
  Budget,
}

@doc("Data type to show in view.")
enum PivotTypeType {
  Dimension,
  TagKey,
}

@doc("type of alert")
enum AlertType {
  Budget,
  Invoice,
  Credit,
  Quota,
  General,
  xCloud,
  BudgetForecast,
}

@doc("Alert category")
enum AlertCategory {
  Cost,
  Usage,
  Billing,
  System,
}

@doc("Criteria that triggered alert")
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

@doc("Source of alert")
enum AlertSource {
  Preset,
  User,
}

@doc("Type of timegrain cadence")
enum AlertTimeGrainType {
  None,
  Monthly,
  Quarterly,
  Annually,
  BillingMonth,
  BillingQuarter,
  BillingAnnual,
}

@doc("operator used to compare currentSpend with amount")
enum AlertOperator {
  None,
  EqualTo,
  GreaterThan,
  GreaterThanOrEqualTo,
  LessThan,
  LessThanOrEqualTo,
}

@doc("alert status")
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

@doc("The type of the forecast.")
enum ForecastType {
  Usage,
  ActualCost,
  AmortizedCost,
}

@doc("The time frame for pulling data for the forecast.")
enum ForecastTimeframe {
  Custom,
}

@doc("The name of the column to aggregate.")
enum FunctionName {
  PreTaxCostUSD,
  Cost,
  CostUSD,
  PreTaxCost,
}

@doc("The operator to use for comparison.")
enum ForecastOperatorType {
  In,
}

@doc("The operator to use for comparison.")
enum QueryOperatorType {
  In,
}

@doc("The CSV file from the reportUrl blob link consists of reservation usage data with the following schema at daily granularity")
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

@doc("Destination of the view data. Currently only CSV format is supported.")
enum FileFormat {
  Csv,
}

@doc("Frequency of the schedule.")
enum ScheduleFrequency {
  @doc("Cost analysis data will be emailed every day.") Daily,
  @doc("Cost analysis data will be emailed every week.") Weekly,
  @doc("Cost analysis data will be emailed every month.") Monthly,
}

@doc("Days of Week.")
enum DaysOfWeek {
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
  Sunday,
}

@doc("Weeks of month.")
enum WeeksOfMonth {
  First,
  Second,
  Third,
  Fourth,
  Last,
}

@doc("Status of the scheduled action.")
enum ScheduledActionStatus {
  @doc("Scheduled action is saved but will not be run.") Disabled,
  @doc("Scheduled action is saved and will be run.") Enabled,
  @doc("Scheduled action is expired.") Expired,
}

@doc("Kind of the scheduled action.")
enum ScheduledActionKind {
  @doc("Cost analysis data will be emailed.") Email,
  @doc("Cost anomaly information will be emailed. Available only on subscription scope at daily frequency. If no anomaly is detected on the resource, an email won't be sent.")
  InsightAlert,
}

@doc("The type of the detailed report. By default ActualCost is provided")
enum CostDetailsMetricType {
  @doc("Actual cost data.") ActualCostCostDetailsMetricType: "ActualCost",
  @doc("Amortized cost data.")
  AmortizedCostCostDetailsMetricType: "AmortizedCost",
}

@doc("The status of the cost details operation")
enum CostDetailsStatusType {
  @doc("Operation is Completed.") CompletedCostDetailsStatusType: "Completed",
  @doc("Operation is Completed and no cost data found.")
  NoDataFoundCostDetailsStatusType: "NoDataFound",
  @doc("Operation Failed.") FailedCostDetailsStatusType: "Failed",
}

@doc("The data format of the report")
enum CostDetailsDataFormat {
  @doc("Csv data format.") CsvCostDetailsDataFormat: "Csv",
}

@doc("The type of the detailed report. By default ActualCost is provided")
enum GenerateDetailedCostReportMetricType {
  ActualCost,
  AmortizedCost,
}

@doc("The status of the long running operation.")
enum ReportOperationStatusType {
  InProgress,
  Completed,
  Failed,
  Queued,
  NoDataFound,
  ReadyToDownload,
  TimedOut,
}

@doc("Result of listing benefit recommendations.")
model BenefitRecommendationsListResult
  is Azure.Core.Page<BenefitRecommendationModel>;

@doc("benefit plan recommendation details.")
model BenefitRecommendationModel extends BenefitResource {
  @doc("The properties of the benefit recommendations.")
  properties?: BenefitRecommendationProperties;
}

@doc("The properties of the benefit recommendations.")
@discriminator("scope")
model BenefitRecommendationProperties {
  @doc("The first usage date used for looking back for computing the recommendations.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  firstConsumptionDate?: utcDateTime;

  @doc("The last usage date used for looking back for computing the recommendations.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastConsumptionDate?: utcDateTime;

  @doc("The number of days of usage evaluated for computing the recommendations.")
  lookBackPeriod?: LookBackPeriod;

  @doc("The total hours for which the cost is covered. Its equal to number of records in a property 'properties/usage/charges'.")
  @visibility("read")
  totalHours?: int32;

  @doc("On-demand charges between firstConsumptionDate and lastConsumptionDate that were used for computing benefit recommendations.")
  usage?: RecommendationUsageDetails;

  @doc("ARM SKU name. 'Compute_Savings_Plan' for SavingsPlan.")
  @visibility("read")
  armSkuName?: string;

  @doc("Term period of the benefit. For example, P1Y or P3Y.")
  term?: Term;

  @doc("Grain of the proposed commitment amount. Supported values: 'Hourly'")
  commitmentGranularity?: Grain;

  @doc("An ISO 4217 currency code identifier for the costs and savings amounts.")
  @visibility("read")
  currencyCode?: string;

  @doc("The current cost without benefit, corresponds to 'totalHours' in the look-back period.")
  @visibility("read")
  costWithoutBenefit?: float32;

  @doc("The details of the proposed recommendation.")
  recommendationDetails?: AllSavingsBenefitDetails;

  @doc("The list of all benefit recommendations with the recommendation details.")
  @visibility("read")
  allRecommendationDetails?: AllSavingsList;
}

@doc("On-demand charges between firstConsumptionDate and lastConsumptionDate that were used for computing benefit recommendations.")
model RecommendationUsageDetails {
  @doc("The grain of the usage. Supported values: 'Hourly'")
  usageGrain?: Grain;

  @doc("On-demand charges for each hour between firstConsumptionDate and lastConsumptionDate that were used for computing benefit recommendations.")
  @visibility("read")
  charges?: float32[];
}

@doc("Benefit recommendation details.")
model AllSavingsBenefitDetails {
  @doc("The difference between total cost and benefit cost for the 'totalHours' in the look-back period.")
  @visibility("read")
  overageCost?: float32;

  @doc("The estimated cost with benefit for the 'totalHours' in the look-back period. It's equal to (commitmentAmount * totalHours)")
  @visibility("read")
  benefitCost?: float32;

  @doc("Total cost, which is sum of benefit cost and overage cost.")
  @visibility("read")
  totalCost?: float32;

  @doc("The amount saved for the 'totalHours' in the look-back period, by purchasing the recommended quantity of the benefit.")
  @visibility("read")
  savingsAmount?: float32;

  @doc("The savings in percentage for the 'totalHours' in the look-back period, by purchasing the recommended quantity of benefit.")
  @visibility("read")
  savingsPercentage?: float32;

  @doc("Estimated benefit coverage percentage for the 'totalHours' in the look-back period, with this commitment.")
  @visibility("read")
  coveragePercentage?: float32;

  @doc("The commitment amount at the commitmentGranularity.")
  @visibility("read")
  commitmentAmount?: float32;

  @doc("Estimated average utilization percentage for the 'totalHours' in the look-back period, with this commitment.")
  @visibility("read")
  averageUtilizationPercentage?: float32;

  @doc("Estimated unused portion of the 'benefitCost'.")
  @visibility("read")
  wastageCost?: float32;
}

@doc("The list of all benefit recommendations with the recommendation details.")
model AllSavingsList {
  @doc("The list of benefit recommendations with the recommendation details..")
  @visibility("read")
  value?: AllSavingsBenefitDetails[];

  @doc("The link (URL) to the next page of results.")
  @visibility("read")
  nextLink?: string;
}

@doc("The benefit resource model definition.")
model BenefitResource extends Resource {
  @doc("Reservation or SavingsPlan.")
  kind?: BenefitKind;
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;
}

@doc("""
Error response indicates that the service is not able to process the incoming request. The reason is provided in the error message. 

Some Error responses: 

 * 429 TooManyRequests - Request is throttled. Retry after waiting for the time specified in the \"x-ms-ratelimit-microsoft.consumption-retry-after\" header. 

 * 503 ServiceUnavailable - Service is temporarily unavailable. Retry after waiting for the time specified in the \"Retry-After\" header.
""")
@error
model OperationErrorResponse {
  @doc("The details of the error.")
  error?: ErrorDetails;
}

@doc("The details of the error.")
model ErrorDetails {
  @doc("Error code.")
  @visibility("read")
  code?: string;

  @doc("Error message indicating why the operation failed.")
  @visibility("read")
  message?: string;
}

@doc("List of benefit utilization summaries.")
model BenefitUtilizationSummariesListResult
  is Azure.Core.Page<BenefitUtilizationSummary>;

@doc("Benefit utilization summary resource.")
@discriminator("kind")
model BenefitUtilizationSummary extends Resource {}

@doc("Properties of an async benefit utilization summaries request.")
model BenefitUtilizationSummariesRequest {
  @doc("Billing account the benefit utilization summaries report is for. Required for billing account and billing profile scopes. Not supported for any benefit scopes.")
  billingAccountId?: string;

  @doc("Billing profile id the benefit utilization summaries report is for. Required for billing profile scope. Not supported for billing account or any benefit scopes.")
  billingProfileId?: string;

  @doc("Benefit order id the benefit utilization summaries report is for. Required for benefit order and benefit id scopes. Not supported for any billing scopes.")
  benefitOrderId?: string;

  @doc("Benefit id the benefit utilization summaries report is for. Required for benefit id scope. Not supported for benefit order or any billing scopes.")
  benefitId?: string;

  @doc("The grain the summaries data is served at in the report. Accepted values are 'Daily' or 'Monthly'.")
  grain: Grain;

  @doc("The start date of the summaries data that will be served in the report.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDate: utcDateTime;

  @doc("The end date of the summaries data that will be served in the report.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDate: utcDateTime;

  @doc("The type of benefit data requested. Required for billing account and billing profile scopes. Implied and not to be passed at benefit scopes. Supported values are Reservation and SavingsPlan")
  kind?: BenefitKind;
}

@doc("Status of a benefit utilization summaries report. Provides Async Benefit Utilization Summaries Request input, status, and report sas url.")
model BenefitUtilizationSummariesOperationStatus {
  @doc("Input given to create the benefit utilization summaries report.")
  input?: BenefitUtilizationSummariesRequest;

  @doc("The status of the creation of the benefit utilization summaries report.")
  status?: OperationStatusType;

  @doc("Contains sas url to the async benefit utilization summaries report and a date that the url is valid until. These values will be empty if the report is in a Running or Failed state")
  properties?: AsyncOperationStatusProperties;
}

@doc("Object representing the report url and valid until date of the async report generated.")
model AsyncOperationStatusProperties {
  @doc("Sas url to the async benefit utilization summaries report. Will be empty if the report is in Running or Failed state.")
  reportUrl?: BenefitUtilizationSummaryReportSchema;

  @doc("Sas url to async benefit utilization summaries report in secondary storage in case of primary outage. Will be empty if the report is in Running or Failed state.")
  secondaryReportUrl?: BenefitUtilizationSummaryReportSchema;

  @doc("The date that the sas url provided in reportUrl expires.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  validUntil?: utcDateTime;
}

@doc("The properties of the export.")
model ExportProperties extends CommonExportProperties {
  @doc("Has schedule information for the export.")
  schedule?: ExportSchedule;
}

@doc("The schedule associated with the export.")
model ExportSchedule {
  @doc("The status of the export's schedule. If 'Inactive', the export's schedule is paused.")
  status?: StatusType;

  @doc("The schedule recurrence.")
  recurrence?: RecurrenceType;

  @doc("Has start and end date of the recurrence. The start date must be in future. If present, the end date must be greater than start date.")
  recurrencePeriod?: ExportRecurrencePeriod;
}

@doc("The start and end date for recurrence schedule.")
model ExportRecurrencePeriod {
  @doc("The start date of recurrence.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  from: utcDateTime;

  @doc("The end date of recurrence.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  to?: utcDateTime;
}

@doc("The common properties of the export.")
model CommonExportProperties {
  @doc("The format of the export being delivered. Currently only 'Csv' is supported.")
  format?: FormatType;

  @doc("Has delivery information for the export.")
  deliveryInfo: ExportDeliveryInfo;

  @doc("Has the definition for the export.")
  definition: ExportDefinition;

  @doc("If requested, has the most recent run history for the export.")
  runHistory?: ExportExecutionListResult;

  @doc("If set to true, exported data will be partitioned by size and placed in a blob directory together with a manifest file. Note: this option is currently available only for Microsoft Customer Agreement commerce scopes.")
  partitionData?: boolean;

  @doc("If the export has an active schedule, provides an estimate of the next run time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextRunTimeEstimate?: utcDateTime;
}

@doc("The delivery information associated with a export.")
model ExportDeliveryInfo {
  @doc("Has destination for the export being delivered.")
  destination: ExportDeliveryDestination;
}

@doc("This represents the blob storage account location where exports of costs will be delivered. There are two ways to configure the destination. The approach recommended for most customers is to specify the resourceId of the storage account. This requires a one-time registration of the account's subscription with the Microsoft.CostManagementExports resource provider in order to give Cost Management services access to the storage. When creating an export in the Azure portal this registration is performed automatically but API users may need to register the subscription explicitly (for more information see https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-manager-supported-services ). Another way to configure the destination is available ONLY to Partners with a Microsoft Partner Agreement plan who are global admins of their billing account. These Partners, instead of specifying the resourceId of a storage account, can specify the storage account name along with a SAS token for the account. This allows exports of costs to a storage account in any tenant. The SAS token should be created for the blob service with Service/Container/Object resource types and with Read/Write/Delete/List/Add/Create permissions (for more information see https://docs.microsoft.com/en-us/azure/cost-management-billing/costs/export-cost-data-storage-account-sas-key ).")
model ExportDeliveryDestination {
  @doc("The resource id of the storage account where exports will be delivered. This is not required if a sasToken and storageAccount are specified.")
  resourceId?: string;

  @doc("The name of the container where exports will be uploaded. If the container does not exist it will be created.")
  container: string;

  @doc("The name of the directory where exports will be uploaded.")
  rootFolderPath?: string;

  @doc("A SAS token for the storage account. For a restricted set of Azure customers this together with storageAccount can be specified instead of resourceId. Note: the value returned by the API for this property will always be obfuscated. Returning this same obfuscated value will not result in the SAS token being updated. To update this value a new SAS token must be specified.")
  sasToken?: string;

  @doc("The storage account where exports will be uploaded. For a restricted set of Azure customers this together with sasToken can be specified instead of resourceId.")
  storageAccount?: string;
}

@doc("The definition of an export.")
model ExportDefinition {
  @doc("The type of the export. Note that 'Usage' is equivalent to 'ActualCost' and is applicable to exports that do not yet provide data for charges or amortization for service reservations.")
  type: ExportType;

  @doc("The time frame for pulling data for the export. If custom, then a specific time period must be provided.")
  timeframe: TimeframeType;

  @doc("Has time period for pulling data for the export.")
  timePeriod?: ExportTimePeriod;

  @doc("The definition for data in the export.")
  dataSet?: ExportDataset;
}

@doc("The date range for data in the export. This should only be specified with timeFrame set to 'Custom'. The maximum date range is 3 months.")
model ExportTimePeriod {
  @doc("The start date for export data.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  from: utcDateTime;

  @doc("The end date for export data.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  to: utcDateTime;
}

@doc("The definition for data in the export.")
model ExportDataset {
  @doc("The granularity of rows in the export. Currently only 'Daily' is supported.")
  granularity?: GranularityType;

  @doc("The export dataset configuration.")
  configuration?: ExportDatasetConfiguration;
}

@doc("The export dataset configuration. Allows columns to be selected for the export. If not provided then the export will include all available columns.")
model ExportDatasetConfiguration {
  @doc("Array of column names to be included in the export. If not provided then the export will include all available columns. The available columns can vary by customer channel (see examples).")
  columns?: string[];
}

@doc("Result of listing the run history of an export.")
model ExportExecutionListResult {
  @doc("A list of export runs.")
  @visibility("read")
  value?: ExportRun[];
}

@doc("An export run.")
model ExportRun extends CostManagementProxyResource {
  @doc("The properties of the export run.")
  properties?: ExportRunProperties;
}

@doc("The properties of the export run.")
model ExportRunProperties {
  @doc("The type of the export run.")
  executionType?: ExecutionType;

  @doc("The last known status of the export run.")
  status?: ExecutionStatus;

  @doc("The identifier for the entity that triggered the export. For on-demand runs it is the user email. For scheduled runs it is 'System'.")
  submittedBy?: string;

  @doc("The time when export was queued to be run.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  submittedTime?: utcDateTime;

  @doc("The time when export was picked up to be run.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  processingStartTime?: utcDateTime;

  @doc("The time when the export run finished.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  processingEndTime?: utcDateTime;

  @doc("The name of the exported file.")
  fileName?: string;

  @doc("The export settings that were in effect for this run.")
  runSettings?: CommonExportProperties;

  @doc("The details of any error.")
  error?: ErrorDetails;
}

@doc("The Resource model definition.")
model CostManagementProxyResource {
  @doc("Resource Id.")
  @visibility("read")
  id?: string;

  @doc("Resource name.")
  @visibility("read")
  name?: string;

  @doc("Resource type.")
  @visibility("read")
  type?: string;

  @doc("eTag of the resource. To handle concurrent update scenario, this field will be used to determine whether the user is updating the latest version or not.")
  eTag?: string;
}

@doc("Result of listing views. It contains a list of available views.")
model ViewListResult is Azure.Core.Page<View>;

@doc("The properties of the view.")
model ViewProperties {
  @doc("User input name of the view. Required.")
  displayName?: string;

  @doc("Cost Management scope to save the view on. This includes 'subscriptions/{subscriptionId}' for subscription scope, 'subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}' for resourceGroup scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}' for Billing Account scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/departments/{departmentId}' for Department scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/enrollmentAccounts/{enrollmentAccountId}' for EnrollmentAccount scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}' for BillingProfile scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/invoiceSections/{invoiceSectionId}' for InvoiceSection scope, 'providers/Microsoft.Management/managementGroups/{managementGroupId}' for Management Group scope, '/providers/Microsoft.CostManagement/externalBillingAccounts/{externalBillingAccountName}' for ExternalBillingAccount scope, and '/providers/Microsoft.CostManagement/externalSubscriptions/{externalSubscriptionName}' for ExternalSubscription scope.")
  scope?: string;

  @doc("Date the user created this view.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;

  @doc("Date when the user last modified this view.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  modifiedOn?: utcDateTime;

  @doc("Date range of the current view.")
  @visibility("read")
  dateRange?: string;

  @doc("Currency of the current view.")
  @visibility("read")
  currency?: string;

  @doc("Query body configuration. Required.")
  query?: ReportConfigDefinition;

  @doc("Chart type of the main view in Cost Analysis. Required.")
  chart?: ChartType;

  @doc("Show costs accumulated over time.")
  accumulated?: AccumulatedType;

  @doc("Metric to use when displaying costs.")
  metric?: MetricType;

  @doc("List of KPIs to show in Cost Analysis UI.")
  kpis?: KpiProperties[];

  @doc("Configuration of 3 sub-views in the Cost Analysis UI.")
  pivots?: PivotProperties[];
}

@doc("The definition of a report config.")
model ReportConfigDefinition {
  @doc("The type of the report. Usage represents actual usage, forecast represents forecasted data and UsageAndForecast represents both usage and forecasted data. Actual usage and forecasted data can be differentiated based on dates.")
  type: ReportType;

  @doc("The time frame for pulling data for the report. If custom, then a specific time period must be provided.")
  timeframe: ReportTimeframeType;

  @doc("Has time period for pulling data for the report.")
  timePeriod?: ReportConfigTimePeriod;

  @doc("Has definition for data in this report config.")
  dataSet?: ReportConfigDataset;

  @doc("If true, report includes monetary commitment.")
  includeMonetaryCommitment?: boolean;
}

@doc("The start and end date for pulling data for the report.")
model ReportConfigTimePeriod {
  @doc("The start date to pull data from.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  from: utcDateTime;

  @doc("The end date to pull data to.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  to: utcDateTime;
}

@doc("The definition of data present in the report.")
model ReportConfigDataset {
  @doc("The granularity of rows in the report.")
  granularity?: ReportGranularityType;

  @doc("Has configuration information for the data in the report. The configuration will be ignored if aggregation and grouping are provided.")
  configuration?: ReportConfigDatasetConfiguration;

  @doc("Dictionary of aggregation expression to use in the report. The key of each item in the dictionary is the alias for the aggregated column. Report can have up to 2 aggregation clauses.")
  aggregation?: Record<ReportConfigAggregation>;

  @doc("Array of group by expression to use in the report. Report can have up to 2 group by clauses.")
  grouping?: ReportConfigGrouping[];

  @doc("Array of order by expression to use in the report.")
  sorting?: ReportConfigSorting[];

  @doc("Has filter expression to use in the report.")
  filter?: ReportConfigFilter;
}

@doc("The configuration of dataset in the report.")
model ReportConfigDatasetConfiguration {
  @doc("Array of column names to be included in the report. Any valid report column name is allowed. If not provided, then report includes all columns.")
  columns?: string[];
}

@doc("The aggregation expression to be used in the report.")
model ReportConfigAggregation {
  @doc("The name of the column to aggregate.")
  name: string;

  @doc("The name of the aggregation function to use.")
  function: FunctionType;
}

@doc("The group by expression to be used in the report.")
model ReportConfigGrouping {
  @doc("Has type of the column to group.")
  type: QueryColumnType;

  @doc("The name of the column to group. This version supports subscription lowest possible grain.")
  name: string;
}

@doc("The order by expression to be used in the report.")
model ReportConfigSorting {
  @doc("Direction of sort.")
  direction?: ReportConfigSortingType;

  @doc("The name of the column to sort.")
  name: string;
}

@doc("The filter expression to be used in the report.")
model ReportConfigFilter {
  @doc("The logical \"AND\" expression. Must have at least 2 items.")
  and?: ReportConfigFilter[];

  @doc("The logical \"OR\" expression. Must have at least 2 items.")
  or?: ReportConfigFilter[];

  @doc("Has comparison expression for a dimension")
  dimensions?: ReportConfigComparisonExpression;

  @doc("Has comparison expression for a tag")
  tags?: ReportConfigComparisonExpression;
}

@doc("The comparison expression to be used in the report.")
model ReportConfigComparisonExpression {
  @doc("The name of the column to use in comparison.")
  name: string;

  @doc("The operator to use for comparison.")
  operator: OperatorType;

  @doc("Array of values to use for comparison")
  values: string[];
}

@doc("Each KPI must contain a 'type' and 'enabled' key.")
model KpiProperties {
  @doc("KPI type (Forecast, Budget).")
  type?: KpiTypeType;

  @doc("ID of resource related to metric (budget).")
  id?: string;

  @doc("show the KPI in the UI?")
  enabled?: boolean;
}

@doc("Each pivot must contain a 'type' and 'name'.")
model PivotProperties {
  @doc("Data type to show in view.")
  type?: PivotTypeType;

  @doc("Data field to show in view.")
  name?: string;
}

@doc("Alert properties.")
model AlertProperties {
  @doc("defines the type of alert")
  definition?: AlertPropertiesDefinition;

  @doc("Alert description")
  description?: string;

  @doc("Source of alert")
  source?: AlertSource;

  @doc("Alert details")
  details?: AlertPropertiesDetails;

  @doc("related budget")
  costEntityId?: string;

  @doc("alert status")
  status?: AlertStatus;

  @doc("dateTime in which alert was created")
  creationTime?: string;

  @doc("dateTime in which alert was closed")
  closeTime?: string;

  @doc("dateTime in which alert was last modified")
  modificationTime?: string;

  @doc("User who last modified the alert")
  statusModificationUserName?: string;

  @doc("dateTime in which the alert status was last modified")
  statusModificationTime?: string;
}

@doc("defines the type of alert")
model AlertPropertiesDefinition {
  @doc("type of alert")
  type?: AlertType;

  @doc("Alert category")
  category?: AlertCategory;

  @doc("Criteria that triggered alert")
  criteria?: AlertCriteria;
}

@doc("Alert details")
model AlertPropertiesDetails {
  @doc("Type of timegrain cadence")
  timeGrainType?: AlertTimeGrainType;

  @doc("datetime of periodStartDate")
  periodStartDate?: string;

  @doc("notificationId that triggered this alert")
  triggeredBy?: string;

  @doc("array of resourceGroups to filter by")
  resourceGroupFilter?: unknown[];

  @doc("array of resources to filter by")
  resourceFilter?: unknown[];

  @doc("array of meters to filter by")
  meterFilter?: unknown[];

  @doc("tags to filter by")
  tagFilter?: Record<unknown>;

  @doc("notification threshold percentage as a decimal which activated this alert")
  threshold?: float32;

  @doc("operator used to compare currentSpend with amount")
  operator?: AlertOperator;

  @doc("budget threshold amount")
  amount?: float32;

  @doc("unit of currency being used")
  unit?: string;

  @doc("current spend")
  currentSpend?: float32;

  @doc("list of emails to contact")
  contactEmails?: string[];

  @doc("list of action groups to broadcast to")
  contactGroups?: string[];

  @doc("list of contact roles")
  contactRoles?: string[];

  @doc("overriding alert")
  overridingAlert?: string;

  @doc("department name")
  departmentName?: string;

  @doc("company name")
  companyName?: string;

  @doc("enrollment number")
  enrollmentNumber?: string;

  @doc("datetime of enrollmentStartDate")
  enrollmentStartDate?: string;

  @doc("datetime of enrollmentEndDate")
  enrollmentEndDate?: string;

  @doc("invoicing threshold")
  invoicingThreshold?: float32;
}

@doc("The request payload to update an alert")
model DismissAlertPayload {
  @doc("Alert properties.")
  properties?: AlertProperties;
}

@doc("The definition of a forecast.")
model ForecastDefinition {
  @doc("The type of the forecast.")
  type: ForecastType;

  @doc("The time frame for pulling data for the forecast. If custom, then a specific time period must be provided.")
  timeframe: ForecastTimeframe;

  @doc("Has time period for pulling data for the forecast.")
  timePeriod?: ForecastTimePeriod;

  @doc("Has definition for data in this forecast.")
  dataset: ForecastDataset;

  @doc("A boolean determining if actualCost will be included.")
  includeActualCost?: boolean;

  @doc("A boolean determining if FreshPartialCost will be included.")
  includeFreshPartialCost?: boolean;
}

@doc("Has time period for pulling data for the forecast.")
model ForecastTimePeriod {
  @doc("The start date to pull data from.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  from: utcDateTime;

  @doc("The end date to pull data to.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  to: utcDateTime;
}

@doc("The definition of data present in the forecast.")
model ForecastDataset {
  @doc("The granularity of rows in the forecast.")
  granularity?: GranularityType;

  @doc("Has configuration information for the data in the export. The configuration will be ignored if aggregation and grouping are provided.")
  configuration?: ForecastDatasetConfiguration;

  @doc("Dictionary of aggregation expression to use in the forecast. The key of each item in the dictionary is the alias for the aggregated column. forecast can have up to 2 aggregation clauses.")
  aggregation: Record<ForecastAggregation>;

  @doc("Has filter expression to use in the forecast.")
  filter?: ForecastFilter;
}

@doc("The configuration of dataset in the forecast.")
model ForecastDatasetConfiguration {
  @doc("Array of column names to be included in the forecast. Any valid forecast column name is allowed. If not provided, then forecast includes all columns.")
  columns?: string[];
}

@doc("The aggregation expression to be used in the forecast.")
model ForecastAggregation {
  @doc("The name of the column to aggregate.")
  name: FunctionName;

  @doc("The name of the aggregation function to use.")
  function: FunctionType;
}

@doc("The filter expression to be used in the export.")
model ForecastFilter {
  @doc("The logical \"AND\" expression. Must have at least 2 items.")
  and?: ForecastFilter[];

  @doc("The logical \"OR\" expression. Must have at least 2 items.")
  or?: ForecastFilter[];

  @doc("Has comparison expression for a dimension")
  dimensions?: ForecastComparisonExpression;

  @doc("Has comparison expression for a tag")
  tags?: ForecastComparisonExpression;
}

@doc("The comparison expression to be used in the forecast.")
model ForecastComparisonExpression {
  @doc("The name of the column to use in comparison.")
  name: string;

  @doc("The operator to use for comparison.")
  operator: ForecastOperatorType;

  @doc("Array of values to use for comparison")
  values: string[];
}

@doc("Result of forecast. It contains all columns listed under groupings and aggregation.")
model ForecastResult extends CostManagementResource {
  @doc("Forecast properties")
  properties?: ForecastProperties;
}

@doc("Forecast properties")
model ForecastProperties {
  @doc("The link (url) to the next page of results.")
  nextLink?: string;

  @doc("Array of columns")
  columns?: ForecastColumn[];

  @doc("Array of rows")
  rows?: unknown[][];
}

@doc("Forecast column properties")
model ForecastColumn {
  @doc("The name of column.")
  name?: string;

  @doc("The type of column.")
  type?: string;
}

@doc("The Resource model definition.")
model CostManagementResource {
  @doc("Resource Id.")
  @visibility("read")
  id?: string;

  @doc("Resource name.")
  @visibility("read")
  name?: string;

  @doc("Resource type.")
  @visibility("read")
  type?: string;

  @doc("Location of the resource.")
  @visibility("read")
  location?: string;

  @doc("SKU of the resource.")
  @visibility("read")
  sku?: string;

  @doc("ETag of the resource.")
  @visibility("read")
  eTag?: string;

  @doc("Resource tags.")
  @visibility("read")
  tags?: Record<string>;
}

@doc("Result of listing dimensions. It contains a list of available dimensions.")
@pagedResult
model DimensionsListResult {
  @doc("The list of dimensions.")
  @visibility("read")
  @items
  value?: Dimension[];
}

@doc("List of Dimension.")
model Dimension extends CostManagementResource {
  @doc("Dimension properties.")
  properties?: DimensionProperties;
}

@doc("Dimension properties.")
model DimensionProperties {
  @doc("Dimension description.")
  @visibility("read")
  description?: string;

  @doc("Filter enabled.")
  @visibility("read")
  filterEnabled?: boolean;

  @doc("Grouping enabled.")
  @visibility("read")
  groupingEnabled?: boolean;

  @doc("Dimension data.")
  data?: string[];

  @doc("Total number of data for the dimension.")
  @visibility("read")
  total?: int32;

  @doc("Dimension category.")
  @visibility("read")
  category?: string;

  @doc("Usage start.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  usageStart?: utcDateTime;

  @doc("Usage end.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  usageEnd?: utcDateTime;

  @doc("The link (url) to the next page of results.")
  @visibility("read")
  nextLink?: string;
}

@doc("The definition of a query.")
model QueryDefinition {
  @doc("The type of the query.")
  type: ExportType;

  @doc("The time frame for pulling data for the query. If custom, then a specific time period must be provided.")
  timeframe: TimeframeType;

  @doc("Has time period for pulling data for the query.")
  timePeriod?: QueryTimePeriod;

  @doc("Has definition for data in this query.")
  dataset: QueryDataset;
}

@doc("The start and end date for pulling data for the query.")
model QueryTimePeriod {
  @doc("The start date to pull data from.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  from: utcDateTime;

  @doc("The end date to pull data to.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  to: utcDateTime;
}

@doc("The definition of data present in the query.")
model QueryDataset {
  @doc("The granularity of rows in the query.")
  granularity?: GranularityType;

  @doc("Has configuration information for the data in the export. The configuration will be ignored if aggregation and grouping are provided.")
  configuration?: QueryDatasetConfiguration;

  @doc("Dictionary of aggregation expression to use in the query. The key of each item in the dictionary is the alias for the aggregated column. Query can have up to 2 aggregation clauses.")
  aggregation?: Record<QueryAggregation>;

  @doc("Array of group by expression to use in the query. Query can have up to 2 group by clauses.")
  grouping?: QueryGrouping[];

  @doc("The filter expression to use in the query. Please reference our Query API REST documentation for how to properly format the filter.")
  filter?: QueryFilter;
}

@doc("The configuration of dataset in the query.")
model QueryDatasetConfiguration {
  @doc("Array of column names to be included in the query. Any valid query column name is allowed. If not provided, then query includes all columns.")
  columns?: string[];
}

@doc("The aggregation expression to be used in the query.")
model QueryAggregation {
  @doc("The name of the column to aggregate.")
  name: string;

  @doc("The name of the aggregation function to use.")
  function: FunctionType;
}

@doc("The group by expression to be used in the query.")
model QueryGrouping {
  @doc("Has type of the column to group.")
  type: QueryColumnType;

  @doc("The name of the column to group.")
  name: string;
}

@doc("The filter expression to be used in the export.")
model QueryFilter {
  @doc("The logical \"AND\" expression. Must have at least 2 items.")
  and?: QueryFilter[];

  @doc("The logical \"OR\" expression. Must have at least 2 items.")
  or?: QueryFilter[];

  @doc("Has comparison expression for a dimension")
  dimensions?: QueryComparisonExpression;

  @doc("Has comparison expression for a tag")
  tags?: QueryComparisonExpression;
}

@doc("The comparison expression to be used in the query.")
model QueryComparisonExpression {
  @doc("The name of the column to use in comparison.")
  name: string;

  @doc("The operator to use for comparison.")
  operator: QueryOperatorType;

  @doc("Array of values to use for comparison")
  values: string[];
}

@doc("Result of query. It contains all columns listed under groupings and aggregation.")
model QueryResult extends CostManagementResource {
  @doc("Query properties")
  properties?: QueryProperties;
}

@doc("Query properties")
model QueryProperties {
  @doc("The link (url) to the next page of results.")
  nextLink?: string;

  @doc("Array of columns")
  columns?: QueryColumn[];

  @doc("Array of rows")
  rows?: unknown[][];
}

@doc("QueryColumn properties")
model QueryColumn {
  @doc("The name of column.")
  name?: string;

  @doc("The type of column.")
  type?: string;
}

@doc("The status of the long running operation.")
model OperationStatus {
  @doc("The status of the long running operation.")
  status?: OperationStatusType;

  @doc("The properties of the resource generated.")
  properties?: ReportURL;
}

@doc("The URL to download the generated report.")
model ReportURL {
  @doc("The CSV file from the reportUrl blob link consists of reservation usage data with the following schema at daily granularity")
  reportUrl?: ReservationReportSchema;

  @doc("The time at which report URL becomes invalid.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  validUntil?: utcDateTime;
}

@doc("The URL to download the generated report.")
model DownloadURL {
  @doc("The time at which report URL becomes invalid/expires in UTC e.g. 2020-12-08T05:55:59.4394737Z.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryTime?: utcDateTime;

  @doc("The time at which report URL becomes invalid/expires in UTC e.g. 2020-12-08T05:55:59.4394737Z.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  validTill?: utcDateTime;

  @doc("The URL to download the generated report.")
  downloadUrl?: string;
}

@doc("Scheduled actions list result. It contains a list of scheduled actions.")
model ScheduledActionListResult is Azure.Core.Page<ScheduledAction>;

@doc("The properties of the scheduled action.")
model ScheduledActionProperties {
  @doc("Scheduled action name.")
  displayName: string;

  @doc("Destination format of the view data. This is optional.")
  fileDestination?: FileDestination;

  @doc("Notification properties based on scheduled action kind.")
  notification: NotificationProperties;

  @doc("Email address of the point of contact that should get the unsubscribe requests and notification emails.")
  notificationEmail?: string;

  @doc("Schedule of the scheduled action.")
  schedule: ScheduleProperties;

  @doc("Cost Management scope like 'subscriptions/{subscriptionId}' for subscription scope, 'subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}' for resourceGroup scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}' for Billing Account scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/departments/{departmentId}' for Department scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/enrollmentAccounts/{enrollmentAccountId}' for EnrollmentAccount scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}' for BillingProfile scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/invoiceSections/{invoiceSectionId}' for InvoiceSection scope, '/providers/Microsoft.CostManagement/externalBillingAccounts/{externalBillingAccountName}' for ExternalBillingAccount scope, and '/providers/Microsoft.CostManagement/externalSubscriptions/{externalSubscriptionName}' for ExternalSubscription scope.")
  scope?: string;

  @doc("Status of the scheduled action.")
  status: ScheduledActionStatus;

  @doc("Cost analysis viewId used for scheduled action. For example, '/providers/Microsoft.CostManagement/views/swaggerExample'")
  viewId: string;
}

@doc("Destination of the view data. This is optional. Currently only CSV format is supported.")
model FileDestination {
  @doc("Destination of the view data. Currently only CSV format is supported.")
  fileFormats?: FileFormat[];
}

@doc("The properties of the scheduled action notification.")
model NotificationProperties {
  @doc("Array of email addresses.")
  to: string[];

  @doc("Locale of the email.")
  language?: string;

  @doc("Optional message to be added in the email. Length is limited to 250 characters.")
  message?: string;

  @doc("Regional format used for formatting date/time and currency values in the email.")
  regionalFormat?: string;

  @doc("Subject of the email. Length is limited to 70 characters.")
  subject: string;
}

@doc("The properties of the schedule.")
model ScheduleProperties {
  @doc("Frequency of the schedule.")
  frequency: ScheduleFrequency;

  @doc("UTC time at which cost analysis data will be emailed.")
  hourOfDay?: int32;

  @doc("Day names in english on which cost analysis data will be emailed. This property is applicable when frequency is Weekly or Monthly.")
  daysOfWeek?: DaysOfWeek[];

  @doc("Weeks in which cost analysis data will be emailed. This property is applicable when frequency is Monthly and used in combination with daysOfWeek.")
  weeksOfMonth?: WeeksOfMonth[];

  @doc("UTC day on which cost analysis data will be emailed. Must be between 1 and 31. This property is applicable when frequency is Monthly and overrides weeksOfMonth or daysOfWeek.")
  dayOfMonth?: int32;

  @doc("The start date and time of the scheduled action (UTC).")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDate: utcDateTime;

  @doc("The end date and time of the scheduled action (UTC).")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDate: utcDateTime;
}

@doc("The Resource model definition.")
model ScheduledActionProxyResource extends ProxyResource {
  @doc("Resource Etag. For update calls, eTag is optional and can be specified to achieve optimistic concurrency. Fetch the resource's eTag by doing a 'GET' call first and then including the latest eTag as part of the request body or 'If-Match' header while performing the update. For create calls, eTag is not required.")
  @visibility("read")
  eTag?: string;

  @doc("Kind of the scheduled action.")
  kind?: ScheduledActionKind;

  @doc("Kind of the scheduled action.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("""
Error response indicates that the service is not able to process the incoming request. The reason is provided in the error message. 

Some Error responses: 

 * 429 TooManyRequests - Request is throttled. Retry after waiting for the time specified in the \"x-ms-ratelimit-microsoft.consumption-retry-after\" header. 

 * 503 ServiceUnavailable - Service is temporarily unavailable. Retry after waiting for the time specified in the \"Retry-After\" header.
""")
@error
model ErrorResponseWithNestedDetails {
  @doc("The details of the error.")
  error?: ErrorDetailsWithNestedDetails;
}

@doc("The details of the error.")
model ErrorDetailsWithNestedDetails extends ErrorDetails {
  @doc("The additional details of the error.")
  @visibility("read")
  details?: ErrorDetailsWithNestedDetails[];
}

@doc("The check availability request body.")
model CheckNameAvailabilityRequest {
  @doc("The name of the resource for which availability needs to be checked.")
  name?: string;

  @doc("The resource type.")
  type?: string;
}

@doc("The check availability result.")
model CheckNameAvailabilityResponse {
  @doc("Indicates if the resource name is available.")
  nameAvailable?: boolean;

  @doc("The reason why the given name is not available.")
  reason?: CheckNameAvailabilityReason;

  @doc("Detailed reason why the given name is available.")
  message?: string;
}

@doc("A Cost management REST API operation.")
model CostManagementOperation extends Operation {
  @doc("Operation id: {provider}/{resource}/{operation}.")
  @visibility("read")
  id?: string;
}

@doc("The properties of the benefit recommendations when scope is 'Single'.")
model SingleScopeBenefitRecommendationProperties
  extends BenefitRecommendationProperties {
  @doc("The subscription ID that this single scope recommendation is for. Applicable only if recommendation is for 'Single' scope.")
  @visibility("read")
  subscriptionId?: string;

  @doc("The resource group that this single scope recommendation is for. Applicable only if recommendation is for 'Single' scope and 'ResourceGroup' request scope.")
  @visibility("read")
  resourceGroup?: string;

  @doc("Benefit scope. For example, Single or Shared.")
  scope: "Single";
}

@doc("The properties of the benefit recommendation when scope is 'Shared'.")
model SharedScopeBenefitRecommendationProperties
  extends BenefitRecommendationProperties {
  @doc("Benefit scope. For example, Single or Shared.")
  scope: "Shared";
}

@doc("The properties of a benefit utilization summary.")
model BenefitUtilizationSummaryProperties {
  @doc("ARM SKU name. For example, 'Compute_Savings_Plan' for savings plan.")
  @visibility("read")
  armSkuName?: string;

  @doc("The benefit ID is the identifier of the benefit.")
  @visibility("read")
  benefitId?: string;

  @doc("The benefit order ID is the identifier for a benefit purchase.")
  @visibility("read")
  benefitOrderId?: string;

  @doc("The benefit type. Supported values: 'SavingsPlan'.")
  benefitType?: BenefitKind;

  @doc("Date corresponding to the utilization summary record. If the grain of data is monthly, value for this field will be first day of the month.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  usageDate?: utcDateTime;
}

@doc("Included Quantity utilization summary resource.")
model IncludedQuantityUtilizationSummary extends BenefitUtilizationSummary {
  @doc("Included Quantity utilization summary properties.")
  properties?: IncludedQuantityUtilizationSummaryProperties;

  @doc("Supported values: 'SavingsPlan'.")
  kind: "IncludedQuantity";
}

@doc("Included Quantity utilization summary properties.")
model IncludedQuantityUtilizationSummaryProperties
  extends BenefitUtilizationSummaryProperties {
  @doc("This is the utilized percentage for the benefit ID.")
  @visibility("read")
  utilizationPercentage?: float32;
}

@doc("Savings plan utilization summary resource.")
model SavingsPlanUtilizationSummary extends BenefitUtilizationSummary {
  @doc("Savings plan utilization summary properties.")
  properties?: SavingsPlanUtilizationSummaryProperties;

  @doc("Supported values: 'SavingsPlan'.")
  kind: "SavingsPlan";
}

@doc("Savings plan utilization summary properties.")
model SavingsPlanUtilizationSummaryProperties
  extends BenefitUtilizationSummaryProperties {
  @doc("This is the average hourly utilization for each date range that corresponds to given grain (Daily, Monthly). Suppose the API call is for usageDate > 2023-03-01 and usageDate < 2022-10-31 at a daily granularity. There will be one record per benefit id for each day. For a single day, the avgUtilizationPercentage value will be equal to the average of the set of values where the set contains 24 utilization percentage entries one for each hour in a specific day.")
  @visibility("read")
  avgUtilizationPercentage?: float32;

  @doc("This is the minimum hourly utilization for each date range that corresponds to given grain (Daily, Monthly). Suppose the API call is for usageDate > 2023-03-01 and usageDate < 2022-10-31 at a daily granularity. There will be one record per benefit id for each day. For a single day, the minUtilizationPercentage value will be equal to the smallest in the set of values where the set contains 24 utilization percentage entries one for each hour in a specific day. If on the day 2022-10-18, the lowest utilization percentage was 10% at hour 4, then the value for the minUtilizationPercentage in the response will be 10%.")
  @visibility("read")
  minUtilizationPercentage?: float32;

  @doc("This is the maximum hourly utilization for each date range that corresponds to given grain (Daily, Monthly). Suppose the API call is for usageDate > 2023-03-01 and usageDate < 2022-10-31 at a daily granularity. There will be one record per benefit id for each day. For a single day, the maxUtilizationPercentage value will be equal to the largest in the set of values where the set contains 24 utilization percentage entries one for each hour in a specific day. If on the day 2022-10-18, the largest utilization percentage was 90% at hour 5, then the value for the maxUtilizationPercentage in the response will be 90%.")
  @visibility("read")
  maxUtilizationPercentage?: float32;
}

@doc("""
Error response indicates that the service is not able to process the incoming request. The reason is provided in the error message. 

Some Error responses: 

 * 400 Bad Request - Invalid Request Payload. Request payload provided is not in a json format or had an invalid member not accepted in the request payload. 

 * 400 Bad Request - Invalid request payload:  can only have either timePeriod or invoiceId or billingPeriod. API only allows data to be pulled for either timePeriod or invoiceId or billingPeriod. Customer should provide only one of these parameters. 

 * 400 Bad Request - Start date must be after . API only allows data to be pulled no older than 13 months from now. 

 * 400 Bad Request - The maximum allowed date range is 1 months. API only allows data to be pulled for 1 month or less. 

 * 429 TooManyRequests - Request is throttled. Retry after waiting for the time specified in the \"retry-after\" header. 

 * 503 ServiceUnavailable - Service is temporarily unavailable. Retry after waiting for the time specified in the \"Retry-After\" header.
""")
model GenerateCostDetailsReportErrorResponse {
  @doc("The details of the error.")
  error?: ErrorDetails;
}

@doc("The definition of a cost detailed report.")
model GenerateCostDetailsReportRequestDefinition {
  @doc("The type of the detailed report. By default ActualCost is provided")
  metric?: CostDetailsMetricType;

  @doc("The specific date range of cost details requested for the report. This parameter cannot be used alongside either the invoiceId or billingPeriod parameters. If a timePeriod, invoiceId or billingPeriod parameter is not provided in the request body the API will return the current month's cost. API only allows data to be pulled for 1 month or less and no older than 13 months. If no timePeriod or billingPeriod or invoiceId is provided the API defaults to the open month time period")
  timePeriod?: CostDetailsTimePeriod;

  @doc("This parameter can be used only by Enterprise Agreement customers. Use the YearMonth(e.g. 202008) format. This parameter cannot be used alongside either the invoiceId or timePeriod parameters. If a timePeriod, invoiceId or billingPeriod parameter is not provided in the request body the API will return the current month's cost.")
  billingPeriod?: string;

  @doc("This parameter can only be used by Microsoft Customer Agreement customers. Additionally, it can only be used at the Billing Profile or Customer scope. This parameter cannot be used alongside either the billingPeriod or timePeriod parameters. If a timePeriod, invoiceId or billingPeriod parameter is not provided in the request body the API will return the current month's cost.")
  invoiceId?: string;
}

@doc("The start and end date for pulling data for the cost detailed report. API only allows data to be pulled for 1 month or less and no older than 13 months.")
model CostDetailsTimePeriod {
  @doc("The start date to pull data from. example format 2020-03-15")
  start: string;

  @doc("The end date to pull data to. example format 2020-03-15")
  end: string;
}

@doc("The result of the long running operation for cost details Api.")
model CostDetailsOperationResults {
  @doc("The id of the long running operation.")
  id?: string;

  @doc("The name of the long running operation.")
  name?: string;

  @doc("The type of the long running operation.")
  type?: string;

  @doc("The status of the cost details operation")
  status?: CostDetailsStatusType;

  @doc("The manifest of the report generated by the operation.")
  manifest?: ReportManifest;

  @doc("The time at which report URL becomes invalid/expires in UTC e.g. 2020-12-08T05:55:59.4394737Z.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  validTill?: utcDateTime;

  @doc("The details of the error.")
  error?: ErrorDetails;
}

@doc("The manifest of the report generated by the operation.")
model ReportManifest {
  @doc("The Manifest version.")
  manifestVersion?: string;

  @doc("The data format of the report")
  dataFormat?: CostDetailsDataFormat;

  @doc("The total number of bytes in all blobs.")
  byteCount?: int32;

  @doc("The total number of blobs.")
  blobCount?: int32;

  @doc("Is the data in compressed format.")
  compressData?: boolean;

  @doc("The context of the Cost Details request.")
  requestContext?: RequestContext;

  @doc("List of blob information generated by this operation.")
  blobs?: BlobInfo[];
}

@doc("The context of the Cost Details request.")
model RequestContext {
  @doc("The request scope of the request.")
  requestScope?: string;

  @doc("The request payload body provided in Cost Details call")
  requestBody?: GenerateCostDetailsReportRequestDefinition;
}

@doc("The blob information generated by this operation.")
model BlobInfo {
  @doc("Link to the blob to download file.")
  blobLink?: string;

  @doc("Bytes in the blob.")
  byteCount?: int32;
}

@doc("""
Error response indicates that the service is not able to process the incoming request. The reason is provided in the error message. 

Some Error responses: 

 * 413 Request Entity Too Large - Request is throttled. The amount of data required to fulfill the request exceeds the maximum size permitted of 2Gb. Please utilize our Exports feature instead. 

 * 429 TooManyRequests - Request is throttled. Retry after waiting for the time specified in the \"x-ms-ratelimit-microsoft.consumption-retry-after\" header. 

 * 503 ServiceUnavailable - Service is temporarily unavailable. Retry after waiting for the time specified in the \"Retry-After\" header.
""")
model GenerateDetailedCostReportErrorResponse {
  @doc("The details of the error.")
  error?: ErrorDetails;
}

@doc("The definition of a cost detailed report.")
model GenerateDetailedCostReportDefinition {
  @doc("The type of the detailed report. By default ActualCost is provided")
  metric?: GenerateDetailedCostReportMetricType;

  @doc("Has time period for pulling data for the cost detailed report. Can only have one of either timePeriod or invoiceId or billingPeriod parameters. If none provided current month cost is provided.")
  timePeriod?: GenerateDetailedCostReportTimePeriod;

  @doc("Billing period in YearMonth(e.g. 202008) format. Only for legacy enterprise customers can use this. Can only have one of either timePeriod or invoiceId or billingPeriod parameters. If none provided current month cost is provided.")
  billingPeriod?: string;

  @doc("Invoice ID for Pay-as-you-go and Microsoft Customer Agreement scopes. Can only have one of either timePeriod or invoiceId or billingPeriod parameters. If none provided current month cost is provided.")
  invoiceId?: string;

  @doc("Customer ID for Microsoft Customer Agreement scopes (Invoice Id is also required for this).")
  customerId?: string;
}

@doc("The start and end date for pulling data for the cost detailed report.")
model GenerateDetailedCostReportTimePeriod {
  @doc("The start date to pull data from. example format 2020-03-15")
  start: string;

  @doc("The end date to pull data to. example format 2020-03-15")
  end: string;
}

@doc("The status of the long running operation for cost detailed report.")
model GenerateDetailedCostReportOperationStatuses {
  @doc("The ID of the long running operation.")
  id?: string;

  @doc("The name of the long running operation.")
  name?: string;

  @doc("The status of the long running operation.")
  status?: Status;

  @doc("The startTime of the operation.")
  startTime?: string;

  @doc("The endTime of the operation.")
  endTime?: string;

  @doc("The type of the long running operation.")
  type?: string;

  @doc("The details of the error.")
  error?: ErrorDetails;

  @doc("The properties of the usage file generated.")
  properties?: DownloadURL;
}

@doc("The status of the long running operation.")
model Status {
  @doc("The status of the long running operation.")
  status?: ReportOperationStatusType;
}

@doc("The result of the long running operation for cost detailed report.")
model GenerateDetailedCostReportOperationResult {
  @doc("The ARM resource id of the long running operation.")
  id?: string;

  @doc("The name of the long running operation.")
  name?: string;

  @doc("The type of the long running operation.")
  type?: string;

  @doc("The properties of the resource generated.")
  properties?: DownloadURL;
}
