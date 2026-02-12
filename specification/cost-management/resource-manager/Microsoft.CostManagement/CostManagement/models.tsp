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

/**
 * The intended executor of the operation; as in Resource Based Access Control (RBAC) and audit logs UX. Default value is "user,system"
 */
union Origin {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  user: "user",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  system: "system",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `user,system`: "user,system",
}

/**
 * Enum. Indicates the action type. "Internal" refers to actions that are for internal only APIs.
 */
union ActionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Internal: "Internal",
}

/**
 * Category of resource to use for allocation.
 */
union CostAllocationResourceType {
  string,

  /**
   * Indicates an Azure dimension such as a subscription id or resource group name is being used for allocation.
   */
  Dimension: "Dimension",

  /**
   * Allocates cost based on Azure Tag key value pairs.
   */
  Tag: "Tag",
}

/**
 * Method to use for allocating cost. FixedProportion indicates that cost will be split based on specified percentage values.
 */
union CostAllocationPolicyType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FixedProportion: "FixedProportion",
}

/**
 * Current status of the rule.
 */
union RuleStatus {
  string,

  /**
   * Rule is saved but not used to allocate costs.
   */
  NotActive: "NotActive",

  /**
   * Rule is saved and impacting cost allocation.
   */
  Active: "Active",

  /**
   * Rule is saved and cost allocation is being updated. Readonly value that cannot be submitted in a put request.
   */
  Processing: "Processing",
}

/**
 * The reason this name is not available.
 */
union Reason {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AlreadyExists: "AlreadyExists",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Valid: "Valid",
}

/**
 * The number of days used to look back.
 */
union LookBackPeriod {
  string,

  /**
   * 7 days used to look back.
   */
  Last7Days: "Last7Days",

  /**
   * 30 days used to look back.
   */
  Last30Days: "Last30Days",

  /**
   * 60 days used to look back.
   */
  Last60Days: "Last60Days",
}

/**
 * Grain which corresponds to value.
 */
union Grain {
  string,

  /**
   * Hourly grain corresponds to value per hour.
   */
  Hourly: "Hourly",

  /**
   * Hourly grain corresponds to value per day.
   */
  Daily: "Daily",

  /**
   * Hourly grain corresponds to value per month.
   */
  Monthly: "Monthly",
}

/**
 * Grain which corresponds to value.
 */
union Term {
  string,

  /**
   * Benefit term is 1 year.
   */
  P1Y: "P1Y",

  /**
   * Benefit term is 3 years.
   */
  P3Y: "P3Y",
}

/**
 * Kind of the recommendation scope.
 */
union Scope {
  string,

  /**
   * Single scope recommendation.
   */
  Single: "Single",

  /**
   * Shared scope recommendation.
   */
  Shared: "Shared",
}

/**
 * Kind/type of the benefit.
 */
union BenefitKind {
  string,

  /**
   * Benefit is IncludedQuantity.
   */
  IncludedQuantity: "IncludedQuantity",

  /**
   * Benefit is Reservation.
   */
  Reservation: "Reservation",

  /**
   * Benefit is SavingsPlan.
   */
  SavingsPlan: "SavingsPlan",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union GrainParameter {
  string,

  /**
   * Hourly grain corresponds to value per hour.
   */
  Hourly: "Hourly",

  /**
   * Hourly grain corresponds to value per day.
   */
  Daily: "Daily",

  /**
   * Hourly grain corresponds to value per month.
   */
  Monthly: "Monthly",
}

/**
 * Enum representing the status of an async operation.
 */
union OperationStatusType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Running: "Running",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Completed: "Completed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
}

/**
 * The CSV file from the reportUrl and secondaryReportUrl blob link will consist of the following columns of benefit utilization data. UtilizedPercentage will be 0 for savings plans reports and non data bricks reservations. Utilization percentages will be 0 for data bricks reservations.
 */
union BenefitUtilizationSummaryReportSchema {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Kind: "Kind",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AvgUtilizationPercentage: "AvgUtilizationPercentage",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BenefitOrderId: "BenefitOrderId",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BenefitId: "BenefitId",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BenefitType: "BenefitType",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MaxUtilizationPercentage: "MaxUtilizationPercentage",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MinUtilizationPercentage: "MinUtilizationPercentage",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UsageDate: "UsageDate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UtilizedPercentage: "UtilizedPercentage",
}

/**
 * The category of the budget.
 * - 'Cost' defines a Budget.
 * - 'ReservationUtilization' defines a Reservation Utilization Alert Rule.
 */
union CategoryType {
  string,

  /**
   * A Budget that evaluates monetary cost of Azure resources against an amount, and alerts based on a configured notification threshold.
   */
  Cost: "Cost",

  /**
   * An Alert Rule that evaluates the utilization percentage of Azure Reservations, and alerts based on a configured notification threshold.
   */
  ReservationUtilization: "ReservationUtilization",
}

/**
 * The time covered by a budget. Tracking of the amount will be reset based on the time grain.
 *
 * Supported for CategoryType(s): Cost, ReservationUtilization.
 *
 *  Supported timeGrainTypes for **CategoryType: Cost**
 *
 * - Monthly
 * - Quarterly
 * - Annually
 * - BillingMonth*
 * - BillingQuarter*
 * - BillingAnnual*
 *
 *   *only supported for Web Direct customers.
 *
 *  Supported timeGrainTypes for **CategoryType: ReservationUtilization**
 * - Last7Days
 * - Last30Days
 *
 *  Required for CategoryType(s): Cost, ReservationUtilization.
 */
union TimeGrainType {
  string,

  /**
   * The budget will track costs in the current calendar month against the amount.
   *
   *  Supported for CategoryType: Cost only.
   */
  Monthly: "Monthly",

  /**
   * The budget will track costs in the current calendar quarter against the amount.
   *
   *  Supported for CategoryType: Cost only.
   */
  Quarterly: "Quarterly",

  /**
   * The budget will track costs in the current calendar year against the amount.
   *
   *  Supported for CategoryType: Cost only.
   */
  Annually: "Annually",

  /**
   * The budget will track costs in the current billing month against the amount.
   *
   *  Supported for CategoryType: Cost and Web Direct customers only.
   */
  BillingMonth: "BillingMonth",

  /**
   * The budget will track costs in the current billing quarter against the amount.
   *
   *  Supported for CategoryType: Cost and Web Direct customers only.
   */
  BillingQuarter: "BillingQuarter",

  /**
   * The budget will track costs in the current billing year against the amount.
   *
   *  Supported for CategoryType: Cost and Web Direct customers only.
   */
  BillingAnnual: "BillingAnnual",

  /**
   * The Reservation Utilization Alert Rule will evaluate reservations based on their 7-Day utilization percentage.
   *
   *  Supported for CategoryType: ReservationUtilization only.
   */
  Last7Days: "Last7Days",

  /**
   * The Reservation Utilization Alert Rule will evaluate reservations based on their 30-Day utilization percentage.
   *
   *  Supported for CategoryType: ReservationUtilization only.
   */
  Last30Days: "Last30Days",
}

/**
 * The operator to use for comparison.
 */
union BudgetOperatorType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  In: "In",
}

/**
 * The comparison operator.
 *
 *  Supported for CategoryType(s): Cost, ReservationUtilization.
 *
 *  Supported operators for **CategoryType: Cost**
 * - GreaterThan
 * - GreaterThanOrEqualTo
 *
 *  Supported operators for **CategoryType: ReservationUtilization**
 * - LessThan
 */
union BudgetNotificationOperatorType {
  string,

  /**
   * Notification will be triggered if the evaluated cost is the same as threshold value. Note: It’s not recommended to use this OperatorType as there’s low chance of cost being exactly the same as threshold value, leading to missing of your alert. This OperatorType will be deprecated in future.
   *
   *  Supported for CategoryType(s): Cost.
   */
  EqualTo: "EqualTo",

  /**
   * Notification will be triggered if the evaluated cost is greater than the threshold value. Note: This is the recommended OperatorType while configuring Budget Alert.
   *
   *  Supported for CategoryType(s): Cost.
   */
  GreaterThan: "GreaterThan",

  /**
   * Notification will be triggered if the evaluated cost is greater than or equal to the threshold value.
   *
   *  Supported for CategoryType(s): Cost.
   */
  GreaterThanOrEqualTo: "GreaterThanOrEqualTo",

  /**
   * Notification will be triggered if any Reservations in the scope of the Reservation Utilization Alert Rule have a utilization less than the threshold percentage.
   *
   *  Supported for CategoryType(s): ReservationUtilization.
   */
  LessThan: "LessThan",
}

/**
 * Frequency of a notification. Represents how long the notification will be silent after triggering an alert for a threshold breach. If not specified, the frequency will be set by default based on the timeGrain (Weekly when timeGrain: Last7Days, Monthly when timeGrain: Last30Days).
 *
 *  Supported for CategoryType(s): ReservationUtilization.
 */
union Frequency {
  string,

  /**
   * After the threshold breaches and an Alert is fired, no further alerts will be sent until the next calendar day.
   */
  Daily: "Daily",

  /**
   * After the threshold breaches and an Alert is fired, no further alerts will be sent for 7 calendar days.
   */
  Weekly: "Weekly",

  /**
   * After the threshold breaches and an Alert is fired, no further alerts will be sent for 30 calendar days.
   */
  Monthly: "Monthly",
}

/**
 * The type of threshold.
 *
 *  Supported for CategoryType(s): Cost.
 */
union ThresholdType {
  string,

  /**
   * Actual costs budget alerts notify when the actual accrued cost exceeds the allocated budget.
   */
  Actual: "Actual",

  /**
   * Forecasted costs budget alerts provide advanced notification that your spending trends are likely to exceed your allocated budget, as it relies on forecasted cost predictions.
   */
  Forecasted: "Forecasted",
}

/**
 * Language in which the recipient will receive the notification,
 *
 *  Supported for CategoryType(s): Cost, ReservationUtilization.
 */
union CultureCode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `en-us`: "en-us",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `ja-jp`: "ja-jp",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `zh-cn`: "zh-cn",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `de-de`: "de-de",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `es-es`: "es-es",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `fr-fr`: "fr-fr",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `it-it`: "it-it",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `ko-kr`: "ko-kr",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `pt-br`: "pt-br",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `ru-ru`: "ru-ru",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `zh-tw`: "zh-tw",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `cs-cz`: "cs-cz",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `pl-pl`: "pl-pl",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `tr-tr`: "tr-tr",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `da-dk`: "da-dk",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `en-gb`: "en-gb",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `hu-hu`: "hu-hu",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `nb-no`: "nb-no",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `nl-nl`: "nl-nl",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `pt-pt`: "pt-pt",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `sv-se`: "sv-se",
}

/**
 * The status of the export's schedule. If 'Inactive', the export's schedule is paused. To enable export set the status to be Active and then make a PUT request.
 */
union StatusType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Inactive: "Inactive",
}

/**
 * The schedule recurrence.
 */
union RecurrenceType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Daily: "Daily",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Weekly: "Weekly",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Monthly: "Monthly",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Annually: "Annually",
}

/**
 * The format of the export being delivered.
 */
union FormatType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Csv: "Csv",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Parquet: "Parquet",
}

/**
 * The export delivery destination type. Currently only 'AzureBlob' is supported.
 */
union DestinationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureBlob: "AzureBlob",
}

/**
 * The type of the export. Note that 'Usage' is equivalent to 'ActualCost' and is applicable to exports that do not yet provide data for charges or amortization for service reservations.
 */
union ExportType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Usage: "Usage",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ActualCost: "ActualCost",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AmortizedCost: "AmortizedCost",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FocusCost: "FocusCost",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PriceSheet: "PriceSheet",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ReservationTransactions: "ReservationTransactions",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ReservationRecommendations: "ReservationRecommendations",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ReservationDetails: "ReservationDetails",
}

/**
 * The time frame for pulling data for the export. If custom, then a specific time period must be provided.
 */
union TimeframeType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MonthToDate: "MonthToDate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BillingMonthToDate: "BillingMonthToDate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  TheLastMonth: "TheLastMonth",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  TheLastBillingMonth: "TheLastBillingMonth",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  WeekToDate: "WeekToDate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Custom: "Custom",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  TheCurrentMonth: "TheCurrentMonth",
}

/**
 * The granularity of rows in the export. Currently 'Daily' is supported for most cases.
 */
union GranularityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Daily: "Daily",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Monthly: "Monthly",
}

/**
 * The name of the filter. This is currently only supported for Export Definition type of ReservationRecommendations. Supported names are ['ReservationScope', 'LookBackPeriod', 'ResourceType']
 */
union FilterItemNames {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ReservationScope: "ReservationScope",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ResourceType: "ResourceType",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  LookBackPeriod: "LookBackPeriod",
}

/**
 * The type of the export run.
 */
union ExecutionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  OnDemand: "OnDemand",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Scheduled: "Scheduled",
}

/**
 * The last known status of the export run.
 */
union ExecutionStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Queued: "Queued",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Completed: "Completed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Timeout: "Timeout",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NewDataNotAvailable: "NewDataNotAvailable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DataNotAvailable: "DataNotAvailable",
}

/**
 * Allow customers to select overwrite data(OverwritePreviousReport) for exports. This setting will enable overwrite data for the same month in customer storage account. By default set to CreateNewReport.
 */
union DataOverwriteBehaviorType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  OverwritePreviousReport: "OverwritePreviousReport",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CreateNewReport: "CreateNewReport",
}

/**
 * Allow customers to select compress data for exports. This setting will enable destination file compression scheme at runtime. By default set to None. Gzip is for csv and snappy for parquet.
 */
union CompressionModeType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  gzip: "gzip",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  snappy: "snappy",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  none: "none",
}

/**
 * The type of the detailed report. By default ActualCost is provided
 */
union CostDetailsMetricType {
  string,

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
union CostDetailsStatusType {
  string,

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
union CostDetailsDataFormat {
  string,

  /**
   * Csv data format.
   */
  CsvCostDetailsDataFormat: "Csv",
}

/**
 * The type of the detailed report. By default ActualCost is provided
 */
union GenerateDetailedCostReportMetricType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ActualCost: "ActualCost",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AmortizedCost: "AmortizedCost",
}

/**
 * The status of the long running operation.
 */
union ReportOperationStatusType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Completed: "Completed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Queued: "Queued",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NoDataFound: "NoDataFound",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ReadyToDownload: "ReadyToDownload",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  TimedOut: "TimedOut",
}

/**
 * The type of the report. Usage represents actual usage, forecast represents forecasted data and UsageAndForecast represents both usage and forecasted data. Actual usage and forecasted data can be differentiated based on dates.
 */
union ReportType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Usage: "Usage",
}

/**
 * The time frame for pulling data for the report. If custom, then a specific time period must be provided.
 */
union ReportTimeframeType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  WeekToDate: "WeekToDate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MonthToDate: "MonthToDate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  YearToDate: "YearToDate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Custom: "Custom",
}

/**
 * The granularity of rows in the report.
 */
union ReportGranularityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Daily: "Daily",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Monthly: "Monthly",
}

/**
 * The name of the aggregation function to use.
 */
union FunctionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Sum: "Sum",
}

/**
 * The type of the column in the report.
 */
union QueryColumnType {
  string,

  /**
   * The tag associated with the cost data.
   */
  TagKey: "TagKey",

  /**
   * The dimension of cost data.
   */
  Dimension: "Dimension",
}

/**
 * Direction of sort.
 */
union ReportConfigSortingType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Ascending: "Ascending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Descending: "Descending",
}

/**
 * The operator to use for comparison.
 */
union OperatorType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  In: "In",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Contains: "Contains",
}

/**
 * Chart type of the main view in Cost Analysis. Required.
 */
union ChartType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Area: "Area",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Line: "Line",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  StackedColumn: "StackedColumn",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GroupedColumn: "GroupedColumn",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Table: "Table",
}

/**
 * Show costs accumulated over time.
 */
union AccumulatedType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `true`: "true",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `false`: "false",
}

/**
 * Metric to use when displaying costs.
 */
union MetricType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ActualCost: "ActualCost",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AmortizedCost: "AmortizedCost",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AHUB: "AHUB",
}

/**
 * KPI type (Forecast, Budget).
 */
union KpiTypeType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Forecast: "Forecast",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Budget: "Budget",
}

/**
 * Data type to show in view.
 */
union PivotTypeType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Dimension: "Dimension",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  TagKey: "TagKey",
}

/**
 * type of alert
 */
union AlertType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Budget: "Budget",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invoice: "Invoice",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Credit: "Credit",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Quota: "Quota",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  General: "General",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  xCloud: "xCloud",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BudgetForecast: "BudgetForecast",
}

/**
 * Alert category
 */
union AlertCategory {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Cost: "Cost",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Usage: "Usage",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Billing: "Billing",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  System: "System",
}

/**
 * Criteria that triggered alert
 */
union AlertCriteria {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CostThresholdExceeded: "CostThresholdExceeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UsageThresholdExceeded: "UsageThresholdExceeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CreditThresholdApproaching: "CreditThresholdApproaching",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CreditThresholdReached: "CreditThresholdReached",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  QuotaThresholdApproaching: "QuotaThresholdApproaching",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  QuotaThresholdReached: "QuotaThresholdReached",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MultiCurrency: "MultiCurrency",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ForecastCostThresholdExceeded: "ForecastCostThresholdExceeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ForecastUsageThresholdExceeded: "ForecastUsageThresholdExceeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  InvoiceDueDateApproaching: "InvoiceDueDateApproaching",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  InvoiceDueDateReached: "InvoiceDueDateReached",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CrossCloudNewDataAvailable: "CrossCloudNewDataAvailable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CrossCloudCollectionError: "CrossCloudCollectionError",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GeneralThresholdError: "GeneralThresholdError",
}

/**
 * Source of alert
 */
union AlertSource {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Preset: "Preset",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  User: "User",
}

/**
 * Type of timegrain cadence
 */
union AlertTimeGrainType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Monthly: "Monthly",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Quarterly: "Quarterly",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Annually: "Annually",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BillingMonth: "BillingMonth",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BillingQuarter: "BillingQuarter",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BillingAnnual: "BillingAnnual",
}

/**
 * operator used to compare currentSpend with amount
 */
union AlertOperator {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  EqualTo: "EqualTo",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GreaterThan: "GreaterThan",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GreaterThanOrEqualTo: "GreaterThanOrEqualTo",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  LessThan: "LessThan",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  LessThanOrEqualTo: "LessThanOrEqualTo",
}

/**
 * alert status
 */
union AlertStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Overridden: "Overridden",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Resolved: "Resolved",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Dismissed: "Dismissed",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ExternalCloudProviderType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  externalSubscriptions: "externalSubscriptions",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  externalBillingAccounts: "externalBillingAccounts",
}

/**
 * The type of the forecast.
 */
union ForecastType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Usage: "Usage",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ActualCost: "ActualCost",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AmortizedCost: "AmortizedCost",
}

/**
 * The time frame for pulling data for the forecast.
 */
union ForecastTimeframe {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Custom: "Custom",
}

/**
 * The name of the column to aggregate.
 */
union FunctionName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PreTaxCostUSD: "PreTaxCostUSD",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Cost: "Cost",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CostUSD: "CostUSD",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PreTaxCost: "PreTaxCost",
}

/**
 * The operator to use for comparison.
 */
union ForecastOperatorType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  In: "In",
}

/**
 * The operator to use for comparison.
 */
union QueryOperatorType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  In: "In",
}

/**
 * The CSV file from the reportUrl blob link consists of reservation usage data with the following schema at daily granularity
 */
union ReservationReportSchema {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  InstanceFlexibilityGroup: "InstanceFlexibilityGroup",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  InstanceFlexibilityRatio: "InstanceFlexibilityRatio",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  InstanceId: "InstanceId",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Kind: "Kind",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ReservationId: "ReservationId",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ReservationOrderId: "ReservationOrderId",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ReservedHours: "ReservedHours",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SkuName: "SkuName",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  TotalReservedQuantity: "TotalReservedQuantity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UsageDate: "UsageDate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UsedHours: "UsedHours",
}

/**
 * Destination of the view data. Currently only CSV format is supported.
 */
union FileFormat {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Csv: "Csv",
}

/**
 * Frequency of the schedule.
 */
union ScheduleFrequency {
  string,

  /**
   * Cost analysis data will be emailed every day.
   */
  Daily: "Daily",

  /**
   * Cost analysis data will be emailed every week.
   */
  Weekly: "Weekly",

  /**
   * Cost analysis data will be emailed every month.
   */
  Monthly: "Monthly",
}

/**
 * Days of Week.
 */
union DaysOfWeek {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Monday: "Monday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Tuesday: "Tuesday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Wednesday: "Wednesday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Thursday: "Thursday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Friday: "Friday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Saturday: "Saturday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Sunday: "Sunday",
}

/**
 * Weeks of month.
 */
union WeeksOfMonth {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  First: "First",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Second: "Second",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Third: "Third",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Fourth: "Fourth",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Last: "Last",
}

/**
 * Status of the scheduled action.
 */
union ScheduledActionStatus {
  string,

  /**
   * Scheduled action is saved and will be run.
   */
  Enabled: "Enabled",

  /**
   * Scheduled action is expired.
   */
  Expired: "Expired",

  /**
   * Scheduled action is saved but will not be run.
   */
  Disabled: "Disabled",
}

/**
 * Kind of the scheduled action.
 */
union ScheduledActionKind {
  string,

  /**
   * Cost analysis data will be emailed.
   */
  Email: "Email",

  /**
   * Cost anomaly information will be emailed. Available only on subscription scope at daily frequency. If no anomaly is detected on the resource, an email won't be sent.
   */
  InsightAlert: "InsightAlert",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Key: "Key",
}

/**
 * The reason why the given name is not available.
 */
union CheckNameAvailabilityReason {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AlreadyExists: "AlreadyExists",
}

/**
 * Specifies the kind of settings.
 */
union SettingsKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  taginheritance: "taginheritance",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union SettingType {
  string,

  /**
   * This setting applies billing profile, invoice section, subscription and resource group tags to current month's usage data of child resources.
   */
  taginheritance: "taginheritance",
}

/**
 * A Cost management REST API operation.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CostManagementOperation
  extends Azure.ResourceManager.CommonTypes.Operation {
  /**
   * Operation id: {provider}/{resource}/{operation}.
   */
  @visibility(Lifecycle.Read)
  id?: string;
}

/**
 * Result of listing cost allocation rules. It contains a list of available rules in the billing account or enterprise enrollment provided.
 */
model CostAllocationRuleList {
  /**
   * The list of cost allocation rules.
   */
  @pageItems
  @identifiers(#["id"])
  value?: CostAllocationRuleDefinition[];

  /**
   * URL to get the next set of rule list results if there are any.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The properties of a cost allocation rule
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CostAllocationRuleProperties {
  /**
   * Description of a cost allocation rule.
   */
  description?: string;

  /**
   * Resource information for the cost allocation rule
   */
  details: CostAllocationRuleDetails;

  /**
   * Status of the rule
   */
  status: RuleStatus;

  /**
   * Time at which the rule was created. Rules that change cost for the same resource are applied in order of creation.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  /**
   * Time at which the rule was last updated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedDate?: utcDateTime;
}

/**
 * Resource details of the cost allocation rule
 */
model CostAllocationRuleDetails {
  /**
   * Source resources for cost allocation. At this time, this list can contain no more than one element.
   */
  @identifiers(#["name"])
  sourceResources?: SourceCostAllocationResource[];

  /**
   * Target resources for cost allocation. At this time, this list can contain no more than one element.
   */
  @identifiers(#["name"])
  targetResources?: TargetCostAllocationResource[];
}

/**
 * Source resources for cost allocation
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SourceCostAllocationResource extends CostAllocationResource {
  /**
   * Source Resources for cost allocation. This list cannot contain more than 25 values.
   */
  values: string[];
}

/**
 * Common values for resources for cost allocation
 */
model CostAllocationResource {
  /**
   * Type of resources contained in this cost allocation rule
   */
  resourceType: CostAllocationResourceType;

  /**
   * If resource type is dimension, this must be either ResourceGroupName or SubscriptionId. If resource type is tag, this must be a valid Azure tag
   */
  name: string;
}

/**
 * Target resources for cost allocation.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TargetCostAllocationResource extends CostAllocationResource {
  /**
   * Target resources for cost allocation. This list cannot contain more than 25 values.
   */
  @identifiers(#["name"])
  values: CostAllocationProportion[];

  /**
   * Method of cost allocation for the rule
   */
  policyType: CostAllocationPolicyType;
}

/**
 * Target resources and allocation
 */
model CostAllocationProportion {
  /**
   * Target resource for cost allocation
   */
  name: string;

  /**
   * Percentage of source cost to allocate to this resource. This value can be specified to two decimal places and the total percentage of all resources in this rule must sum to 100.00.
   */
  percentage: float32;
}

/**
 * The cost allocation rule check name availability request
 */
model CostAllocationRuleCheckNameAvailabilityRequest {
  /**
   * Rule name
   */
  name?: string;

  /**
   * Resource type. This is expected to be Microsoft.CostManagement/costAllocationRules
   */
  type?: string;
}

/**
 * The cost allocation rule check name availability response
 */
model CostAllocationRuleCheckNameAvailabilityResponse {
  /**
   * Whether this rule name is available
   */
  nameAvailable?: boolean;

  /**
   * The reason this name is not available
   */
  reason?: Reason;

  /**
   * Error message if the name is not available
   */
  message?: string;
}

/**
 * benefit plan recommendation details.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  firstConsumptionDate?: utcDateTime;

  /**
   * The last usage date used for looking back for computing the recommendations.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastConsumptionDate?: utcDateTime;

  /**
   * The number of days of usage evaluated for computing the recommendations.
   */
  lookBackPeriod?: LookBackPeriod;

  /**
   * The total hours for which the cost is covered. Its equal to number of records in a property 'properties/usage/charges'.
   */
  @visibility(Lifecycle.Read)
  totalHours?: int32;

  /**
   * On-demand charges between firstConsumptionDate and lastConsumptionDate that were used for computing benefit recommendations.
   */
  usage?: RecommendationUsageDetails;

  /**
   * ARM SKU name. 'Compute_Savings_Plan' for SavingsPlan.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  currencyCode?: string;

  /**
   * The current cost without benefit, corresponds to 'totalHours' in the look-back period.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  costWithoutBenefit?: decimal;

  /**
   * The details of the proposed recommendation.
   */
  recommendationDetails?: AllSavingsBenefitDetails;

  /**
   * The list of all benefit recommendations with the recommendation details.
   */
  @visibility(Lifecycle.Read)
  allRecommendationDetails?: AllSavingsList;

  /**
   * Benefit scope. For example, Single or Shared.
   */
  scope: Scope;
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
  @visibility(Lifecycle.Read)
  charges?: decimal[];
}

/**
 * Benefit recommendation details.
 */
model AllSavingsBenefitDetails {
  /**
   * The difference between total cost and benefit cost for the 'totalHours' in the look-back period.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  overageCost?: decimal;

  /**
   * The estimated cost with benefit for the 'totalHours' in the look-back period. It's equal to (commitmentAmount * totalHours)
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  benefitCost?: decimal;

  /**
   * Total cost, which is sum of benefit cost and overage cost.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  totalCost?: decimal;

  /**
   * The amount saved for the 'totalHours' in the look-back period, by purchasing the recommended quantity of the benefit.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  savingsAmount?: decimal;

  /**
   * The savings in percentage for the 'totalHours' in the look-back period, by purchasing the recommended quantity of benefit.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  savingsPercentage?: decimal;

  /**
   * Estimated benefit coverage percentage for the 'totalHours' in the look-back period, with this commitment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  coveragePercentage?: decimal;

  /**
   * The commitment amount at the commitmentGranularity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  commitmentAmount?: decimal;

  /**
   * Estimated average utilization percentage for the 'totalHours' in the look-back period, with this commitment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  averageUtilizationPercentage?: decimal;

  /**
   * Estimated unused portion of the 'benefitCost'.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  wastageCost?: decimal;
}

/**
 * The list of all benefit recommendations with the recommendation details.
 */
model AllSavingsList {
  /**
   * The list of benefit recommendations with the recommendation details..
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  value?: AllSavingsBenefitDetails[];

  /**
   * The link (URL) to the next page of results.
   */
  @visibility(Lifecycle.Read)
  nextLink?: url;
}

/**
 * The benefit resource model definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BenefitResource extends Azure.ResourceManager.CommonTypes.Resource {
  /**
   * Reservation or SavingsPlan.
   */
  kind?: BenefitKind;
}

/**
 * Benefit utilization summary resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("kind")
model BenefitUtilizationSummary
  extends Azure.ResourceManager.CommonTypes.Resource {
  /**
   * Supported values: 'SavingsPlan'.
   */
  kind: BenefitKind;
}

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
  @secret
  reportUrl?: BenefitUtilizationSummaryReportSchema;

  /**
   * Sas url to async benefit utilization summaries report in secondary storage in case of primary outage. Will be empty if the report is in Running or Failed state.
   */
  @secret
  secondaryReportUrl?: BenefitUtilizationSummaryReportSchema;

  /**
   * The date that the sas url provided in reportUrl expires.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  validUntil?: utcDateTime;
}

/**
 * The properties of the budget.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BudgetProperties {
  /**
   * The category of the budget.
   * - 'Cost' defines a Budget.
   * - 'ReservationUtilization' defines a Reservation Utilization Alert Rule.
   */
  category: CategoryType;

  /**
   * The total amount of cost to track with the budget.
   *
   *  Supported for CategoryType(s): Cost.
   *
   *  Required for CategoryType(s): Cost.
   */
  amount?: float32;

  /**
   * The time covered by a budget. Tracking of the amount will be reset based on the time grain.
   *
   * Supported for CategoryType(s): Cost, ReservationUtilization.
   *
   *  Supported timeGrainTypes for **CategoryType: Cost**
   *
   * - Monthly
   * - Quarterly
   * - Annually
   * - BillingMonth*
   * - BillingQuarter*
   * - BillingAnnual*
   *
   *   *only supported for Web Direct customers.
   *
   *  Supported timeGrainTypes for **CategoryType: ReservationUtilization**
   * - Last7Days
   * - Last30Days
   *
   *  Required for CategoryType(s): Cost, ReservationUtilization.
   */
  timeGrain: TimeGrainType;

  /**
   * The time period that defines the active period of the budget. The budget will evaluate data on or after the startDate and will expire on the endDate.
   *
   *  Supported for CategoryType(s): Cost, ReservationUtilization.
   *
   *  Required for CategoryType(s): Cost, ReservationUtilization.
   */
  timePeriod: BudgetTimePeriod;

  /**
   * May be used to filter budgets by user-specified dimensions and/or tags.
   *
   *  Supported for CategoryType(s): Cost, ReservationUtilization.
   */
  filter?: BudgetFilter;

  /**
   * The current amount of cost which is being tracked for a budget.
   *
   *  Supported for CategoryType(s): Cost.
   */
  @visibility(Lifecycle.Read)
  currentSpend?: CurrentSpend;

  /**
   * Dictionary of notifications associated with the budget.
   *
   *  Supported for CategoryType(s): Cost, ReservationUtilization.
   *
   * - Constraints for **CategoryType: Cost** - Budget can have up to 5 notifications with thresholdType: Actual and 5 notifications with thresholdType: Forecasted.
   * - Constraints for **CategoryType: ReservationUtilization** - Only one notification allowed. thresholdType is not applicable.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  notifications?: Record<Notification>;

  /**
   * The forecasted cost which is being tracked for a budget.
   *
   *  Supported for CategoryType(s): Cost.
   */
  @visibility(Lifecycle.Read)
  forecastSpend?: ForecastSpend;
}

/**
 * The time period that defines the active period of the budget. The budget will evaluate data on or after the startDate and will expire on the endDate.
 *
 *  Supported for CategoryType(s): Cost, ReservationUtilization.
 *
 *  Required for CategoryType(s): Cost, ReservationUtilization.
 */
model BudgetTimePeriod {
  /**
   * The start date for the budget.
   *
   * - Constraints for **CategoryType: Cost** - Must be first of the month and should be less than the end date. Budget start date must be on or after June 1, 2017. Future start date should not be more than twelve months. Past start date should  be selected within the timegrain period.
   *
   * - Constraints for **CategoryType: ReservationUtilization** - Must be on or after the current date and less than the end date.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDate: utcDateTime;

  /**
   * The end date for the budget.
   *
   * - Constraints for **CategoryType: Cost** - No constraints. If not provided, we default this to 10 years from the start date.
   *
   * - Constraints for **CategoryType: ReservationUtilization** - End date cannot be more than 3 years after the start date.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDate?: utcDateTime;
}

/**
 * May be used to filter budgets by user-specified dimensions and/or tags.
 *
 *  Supported for CategoryType(s): Cost, ReservationUtilization.
 */
model BudgetFilter {
  /**
   * The logical "AND" expression. Must have at least 2 items.
   *
   *  Supported for CategoryType(s): Cost.
   */
  @identifiers(#[])
  @minItems(0)
  and?: BudgetFilterProperties[];

  /**
   * Has comparison expression for a dimension.
   *
   *  Supported for CategoryType(s): Cost, ReservationUtilization.
   *
   * Supported dimension names for **CategoryType: ReservationUtilization**
   * - ReservationId
   * - ReservedResourceType
   */
  dimensions?: BudgetComparisonExpression;

  /**
   * Has comparison expression for a tag.
   *
   *  Supported for CategoryType(s): Cost.
   */
  tags?: BudgetComparisonExpression;
}

/**
 * The Dimensions or Tags to filter a budget by.
 *
 *  Supported for CategoryType(s): Cost, ReservationUtilization.
 */
model BudgetFilterProperties {
  /**
   * Has comparison expression for a dimension.
   *
   *  Supported for CategoryType(s): Cost, ReservationUtilization.
   *
   * Supported dimension names for **CategoryType: ReservationUtilization**
   * - ReservationId
   * - ReservedResourceType
   */
  dimensions?: BudgetComparisonExpression;

  /**
   * Has comparison expression for a tag.
   *
   *  Supported for CategoryType(s): Cost.
   */
  tags?: BudgetComparisonExpression;
}

/**
 * The comparison expression to be used in the budgets.
 */
model BudgetComparisonExpression {
  /**
   * The name of the column to use in comparison.
   */
  name: string;

  /**
   * The operator to use for comparison.
   */
  operator: BudgetOperatorType;

  /**
   * Array of values to use for comparison
   */
  @minItems(0)
  values: string[];
}

/**
 * The current amount of cost which is being tracked for a budget.
 *
 *  Supported for CategoryType(s): Cost.
 */
model CurrentSpend {
  /**
   * The total amount of cost which is being tracked by the budget.
   */
  @visibility(Lifecycle.Read)
  amount?: float32;

  /**
   * The unit of measure for the budget amount.
   */
  @visibility(Lifecycle.Read)
  unit?: string;
}

/**
 * The notification associated with a budget.
 *
 *  Supported for CategoryType(s): Cost, ReservationUtilization.
 */
model Notification {
  /**
   * The notification is enabled or not.
   *
   *  Supported for CategoryType(s): Cost, ReservationUtilization.
   */
  enabled: boolean;

  /**
   * The comparison operator.
   *
   *  Supported for CategoryType(s): Cost, ReservationUtilization.
   *
   *  Supported operators for **CategoryType: Cost**
   * - GreaterThan
   * - GreaterThanOrEqualTo
   *
   *  Supported operators for **CategoryType: ReservationUtilization**
   * - LessThan
   */
  operator: BudgetNotificationOperatorType;

  /**
   * Threshold value associated with a notification. It is always percent with a maximum of 2 decimal places.
   *
   *  Supported for CategoryType(s): Cost, ReservationUtilization.
   *
   *  **CategoryType: Cost** - Must be between 0 and 1000. Notification is sent when the cost exceeded the threshold.
   *
   *  **CategoryType: ReservationUtilization** - Must be between 0 and 100. Notification is sent when a reservation has a utilization percentage below the threshold.
   */
  threshold: float32;

  /**
   * Frequency of a notification. Represents how long the notification will be silent after triggering an alert for a threshold breach. If not specified, the frequency will be set by default based on the timeGrain (Weekly when timeGrain: Last7Days, Monthly when timeGrain: Last30Days).
   *
   *  Supported for CategoryType(s): ReservationUtilization.
   */
  frequency?: Frequency;

  /**
   * Email addresses to send the notification to when the threshold is breached. Must have at least one contact email or contact group specified at the Subscription or Resource Group scopes. All other scopes must have at least one contact email specified.
   *
   *  Supported for CategoryType(s): Cost, ReservationUtilization.
   */
  @minItems(0)
  @maxItems(50)
  contactEmails: string[];

  /**
   * Subscription or Resource Group scopes only. Contact roles to send the notification to when the threshold is breached.
   *
   *  Supported for CategoryType(s): Cost.
   */
  contactRoles?: string[];

  /**
   * Subscription or Resource Group scopes only. Action groups to send the notification to when the threshold is exceeded. Must be provided as a fully qualified Azure resource id.
   *
   *  Supported for CategoryType(s): Cost.
   */
  @minItems(0)
  @maxItems(50)
  contactGroups?: string[];

  /**
   * The type of threshold.
   *
   *  Supported for CategoryType(s): Cost.
   */
  thresholdType?: ThresholdType = ThresholdType.Actual;

  /**
   * Language in which the recipient will receive the notification,
   *
   *  Supported for CategoryType(s): Cost, ReservationUtilization.
   */
  locale?: CultureCode;
}

/**
 * The forecasted cost which is being tracked for a budget.
 *
 *  Supported for CategoryType(s): Cost.
 */
model ForecastSpend {
  /**
   * The forecasted cost for the total time period which is being tracked by the budget. This value is only provided if the budget contains a forecast alert type.
   */
  @visibility(Lifecycle.Read)
  amount?: float32;

  /**
   * The unit of measure for the budget amount.
   */
  @visibility(Lifecycle.Read)
  unit?: string;
}

/**
 * The Resource model definition.
 */
model CostManagementProxyResource {
  /**
   * Resource Id.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * eTag of the resource. To handle concurrent update scenario, this field will be used to determine whether the user is updating the latest version or not.
   */
  eTag?: string;
}

/**
 * Result of listing exports. It contains a list of available exports in the scope provided.
 */
model ExportListResult {
  /**
   * The list of exports.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: Export[];
}

/**
 * The properties of the export.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
   * The status of the export's schedule. If 'Inactive', the export's schedule is paused. To enable export set the status to be Active and then make a PUT request.
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
   * The format of the export being delivered.
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
   * If set to true, exported data will be partitioned by size and placed in a blob directory together with a manifest file.
   */
  partitionData?: boolean;

  /**
   * Allow customers to select overwrite data(OverwritePreviousReport) for exports. This setting will enable overwrite data for the same month in customer storage account. By default set to CreateNewReport.
   */
  dataOverwriteBehavior?: DataOverwriteBehaviorType;

  /**
   * Allow customers to select compress data for exports. This setting will enable destination file compression scheme at runtime. By default set to None. Gzip is for csv and snappy for parquet.
   */
  compressionMode?: CompressionModeType;

  /**
   * The export description set by customer at time of export creation/update.
   */
  exportDescription?: string;

  /**
   * If the export has an active schedule, provides an estimate of the next run time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextRunTimeEstimate?: utcDateTime;

  /**
   * The export suspension reason if export is in SystemSuspended state. This is not populated currently.
   */
  @visibility(Lifecycle.Read)
  systemSuspensionContext?: ExportSuspensionContext;
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
   * The export delivery destination type. Currently only 'AzureBlob' is supported.
   */
  type?: DestinationType;

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
  @secret
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
 * The date range for data in the export. This should only be specified with timeFrame set to 'Custom'. The maximum date range is 1 calendar month.
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
   * The granularity of rows in the export. Currently 'Daily' is supported for most cases.
   */
  granularity?: GranularityType;

  /**
   * The export dataset configuration.
   */
  configuration?: ExportDatasetConfiguration;
}

/**
 * This is on path to deprecation and will not be supported going forward.
 */
model ExportDatasetConfiguration {
  /**
   * Array of column names to be included in the export. If not provided then the export will include all available columns. The available columns can vary by customer channel (see examples).
   */
  columns?: string[];

  /**
   * The data version for the selected for the export. If not provided then the export will default to latest data version.
   */
  dataVersion?: string;

  /**
   * Filters associated with the data sets.
   */
  @identifiers(#["name"])
  filters?: FilterItems[];
}

/**
 * Will contain the filter name and value to operate on. This is currently only supported for Export Definition type of ReservationRecommendations.
 */
model FilterItems {
  /**
   * The name of the filter. This is currently only supported for Export Definition type of ReservationRecommendations. Supported names are ['ReservationScope', 'LookBackPeriod', 'ResourceType']
   */
  name?: FilterItemNames;

  /**
   * Value to filter by. Currently values supported per name are, for 'ReservationScope' supported values are ['Single', 'Shared'], for 'LookBackPeriod' supported values are ['Last7Days', 'Last30Days', 'Last60Days'] and for 'ResourceType' supported values are ['VirtualMachines', 'SQLDatabases', 'PostgreSQL', 'ManagedDisk', 'MySQL', 'RedHat', 'MariaDB', 'RedisCache', 'CosmosDB', 'SqlDataWarehouse', 'SUSELinux', 'AppService', 'BlockBlob', 'AzureDataExplorer', 'VMwareCloudSimple'].
   */
  value?: string;
}

/**
 * Result of listing the run history of an export.
 */
model ExportExecutionListResult {
  /**
   * A list of export runs.
   */
  @visibility(Lifecycle.Read)
  value?: ExportRun[];
}

/**
 * An export run.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
   * The start datetime for the export.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDate?: utcDateTime;

  /**
   * The end datetime for the export.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDate?: utcDateTime;

  /**
   * The name of the exported file.
   */
  fileName?: string;

  /**
   * The manifest file location(URI location) for the exported files.
   */
  manifestFile?: string;

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
 * The details of the error.
 */
model ErrorDetails {
  /**
   * Error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Error message indicating why the operation failed.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * The properties of the export run. This is not populated currently.
 */
model ExportSuspensionContext {
  /**
   * The code for export suspension.
   */
  suspensionCode?: string;

  /**
   * The detailed reason for export suspension.
   */
  suspensionReason?: string;

  /**
   * The time when the export was suspended.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  suspensionTime?: utcDateTime;
}

/**
 * The export run request.
 */
model ExportRunRequest {
  /**
   * Has time period for pulling data for the export.
   */
  timePeriod?: ExportTimePeriod;
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
  @identifiers(#["blobLink"])
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
 *
 * Some Error responses:
 *
 *  * 400 Bad Request - Invalid Request Payload. Request payload provided is not in a json format or had an invalid member not accepted in the request payload.
 *
 *  * 400 Bad Request - Invalid request payload:  can only have either timePeriod or invoiceId or billingPeriod. API only allows data to be pulled for either timePeriod or invoiceId or billingPeriod. Customer should provide only one of these parameters.
 *
 *  * 400 Bad Request - Start date must be after . API only allows data to be pulled no older than 13 months from now.
 *
 *  * 400 Bad Request - The maximum allowed date range is 1 months. API only allows data to be pulled for 1 month or less.
 *
 *  * 429 TooManyRequests - Request is throttled. Retry after waiting for the time specified in the "retry-after" header.
 *
 *  * 503 ServiceUnavailable - Service is temporarily unavailable. Retry after waiting for the time specified in the "Retry-After" header.
 */
@error
model GenerateCostDetailsReportErrorResponse {
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
 * The URL to download the generated report.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DownloadURL {
  /**
   * The time at which report URL becomes invalid/expires in UTC e.g. 2020-12-08T05:55:59.4394737Z.
   */
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  downloadUrl?: string;
}

/**
 * Error response indicates that the service is not able to process the incoming request. The reason is provided in the error message.
 *
 * Some Error responses:
 *
 *  * 413 Request Entity Too Large - Request is throttled. The amount of data required to fulfill the request exceeds the maximum size permitted of 2Gb. Please utilize our Exports feature instead.
 *
 *  * 429 TooManyRequests - Request is throttled. Retry after waiting for the time specified in the "x-ms-ratelimit-microsoft.consumption-retry-after" header.
 *
 *  * 503 ServiceUnavailable - Service is temporarily unavailable. Retry after waiting for the time specified in the "Retry-After" header.
 */
@error
model GenerateDetailedCostReportErrorResponse {
  /**
   * The details of the error.
   */
  error?: ErrorDetails;
}

/**
 * The status of the long running operation.
 */
model Status {
  /**
   * The status of the long running operation.
   */
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  status?: ReportOperationStatusType;
}

/**
 * The properties of the view.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;

  /**
   * Date when the user last modified this view.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  modifiedOn?: utcDateTime;

  /**
   * Date range of the current view.
   */
  dateRange?: string;

  /**
   * Currency of the current view.
   */
  @visibility(Lifecycle.Read)
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
  @identifiers(#["name"])
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  aggregation?: Record<ReportConfigAggregation>;

  /**
   * Array of group by expression to use in the report. Report can have up to 2 group by clauses.
   */
  @identifiers(#["name", "type"])
  @maxItems(2)
  grouping?: ReportConfigGrouping[];

  /**
   * Array of order by expression to use in the report.
   */
  @identifiers(#[])
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
  @identifiers(#[])
  @minItems(2)
  and?: ReportConfigFilter[];

  /**
   * The logical "OR" expression. Must have at least 2 items.
   */
  @identifiers(#[])
  @minItems(2)
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
  @minItems(1)
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
 * Result of alerts.
 */
model AlertsResult {
  /**
   * List of alerts.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: Alert[];

  /**
   * URL to get the next set of alerts results if there are any.
   */
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * Alert properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tagFilter?: unknown;

  /**
   * notification threshold percentage as a decimal which activated this alert
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  threshold?: decimal;

  /**
   * operator used to compare currentSpend with amount
   */
  operator?: AlertOperator;

  /**
   * budget threshold amount
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  amount?: decimal;

  /**
   * unit of currency being used
   */
  unit?: string;

  /**
   * current spend
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @identifiers(#[])
  @minItems(2)
  and?: ForecastFilter[];

  /**
   * The logical "OR" expression. Must have at least 2 items.
   */
  @identifiers(#[])
  @minItems(2)
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
  @minItems(1)
  values: string[];
}

/**
 * Result of forecast. It contains all columns listed under groupings and aggregation.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @identifiers(#["name"])
  columns?: ForecastColumn[];

  /**
   * Array of rows
   */
  @identifiers(#[])
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
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Location of the resource.
   */
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * SKU of the resource.
   */
  @visibility(Lifecycle.Read)
  sku?: string;

  /**
   * ETag of the resource.
   */
  @visibility(Lifecycle.Read)
  eTag?: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  tags?: Record<string>;
}

/**
 * Result of listing dimensions. It contains a list of available dimensions.
 */
model DimensionsListResult {
  /**
   * The list of dimensions.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: Dimension[];

  /**
   * The link (url) to the next page of results.
   */
  @nextLink
  nextLink?: string;
}

/**
 * List of Dimension.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Filter enabled.
   */
  @visibility(Lifecycle.Read)
  filterEnabled?: boolean;

  /**
   * Grouping enabled.
   */
  @visibility(Lifecycle.Read)
  groupingEnabled?: boolean;

  /**
   * Dimension data.
   */
  data?: string[];

  /**
   * Total number of data for the dimension.
   */
  @visibility(Lifecycle.Read)
  total?: int32;

  /**
   * Dimension category.
   */
  @visibility(Lifecycle.Read)
  category?: string;

  /**
   * Usage start.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  usageStart?: utcDateTime;

  /**
   * Usage end.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  usageEnd?: utcDateTime;

  /**
   * The link (url) to the next page of results.
   */
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  aggregation?: Record<QueryAggregation>;

  /**
   * Array of group by expression to use in the query. Query can have up to 2 group by clauses.
   */
  @identifiers(#["name", "type"])
  @maxItems(2)
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
  @identifiers(#[])
  @minItems(2)
  and?: QueryFilter[];

  /**
   * The logical "OR" expression. Must have at least 2 items.
   */
  @identifiers(#[])
  @minItems(2)
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
  @minItems(1)
  values: string[];
}

/**
 * Result of query. It contains all columns listed under groupings and aggregation.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @identifiers(#["name"])
  columns?: QueryColumn[];

  /**
   * Array of rows
   */
  @identifiers(#[])
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ReportURL {
  /**
   * The CSV file from the reportUrl blob link consists of reservation usage data with the following schema at daily granularity
   */
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
model PricesheetDownloadProperties {
  /**
   * The time at which report URL becomes invalid/expires in UTC e.g. 2020-12-08T05:55:59.4394737Z.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryTime?: utcDateTime;

  /**
   * The URL to download the generated report.
   */
  downloadUrl?: string;

  /**
   * The properties in downloaded file
   */
  downloadFileProperties?: MCAPriceSheetProperties;
}

/**
 * The properties of the price sheet.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MCAPriceSheetProperties {
  /**
   * Unique identifier for the billing account.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  billingAccountID?: string;

  /**
   * Name of the billing profile that is set up to receive invoices. The prices in the price sheet are associated with this billing profile.
   */
  @visibility(Lifecycle.Read)
  billingAccountName?: string;

  /**
   * Unique identifier for the billing profile.
   */
  @visibility(Lifecycle.Read)
  billingProfileId?: string;

  /**
   * Name of the billing profile that is set up to receive invoices. The prices in the price sheet are associated with this billing profile.
   */
  @visibility(Lifecycle.Read)
  billingProfileName?: string;

  /**
   * Name of the purchased product plan. Indicates if this pricing is standard Azure Plan pricing, Dev/Test pricing etc.
   *
   *  Currently unavailable for Azure 3rd party and ReservedInstance meters.
   */
  @visibility(Lifecycle.Read)
  productOrderName?: string;

  /**
   * Type of Azure service. For example, Compute, Analytics, and Security.
   */
  @visibility(Lifecycle.Read)
  serviceFamily?: float32;

  /**
   * Name of the product accruing the charges.
   */
  @visibility(Lifecycle.Read)
  product?: string;

  /**
   * Unique identifier for the product whose meter is consumed.
   */
  @visibility(Lifecycle.Read)
  productId?: string;

  /**
   * Unique identifier of the SKU
   */
  @visibility(Lifecycle.Read)
  skuId?: string;

  /**
   * How usage is measured for the service
   */
  @visibility(Lifecycle.Read)
  unitOfMeasure?: string;

  /**
   * Unique identifier of the meter
   */
  @visibility(Lifecycle.Read)
  meterId?: string;

  /**
   * Name of the meter. The meter represents the deployable resource of an Azure service.
   */
  @visibility(Lifecycle.Read)
  meterName?: string;

  /**
   * Name of the meter type
   */
  @visibility(Lifecycle.Read)
  meterType?: string;

  /**
   * Name of the classification category for the meter. For example, Cloud services, Networking, etc.
   */
  @visibility(Lifecycle.Read)
  meterCategory?: string;

  /**
   * Name of the meter subclassification category.
   */
  @visibility(Lifecycle.Read)
  meterSubCategory?: string;

  /**
   * Name of the Azure region where the meter for the service is available.
   */
  @visibility(Lifecycle.Read)
  meterRegion?: string;

  /**
   * Defines the lower bound of the tier range for which prices are defined. For example, if the range is 0 to 100, tierMinimumUnits would be 0.
   */
  @visibility(Lifecycle.Read)
  tierMinimumUnits?: string;

  /**
   * Effective start date of the Price Sheet billing period
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  effectiveStartDate?: utcDateTime;

  /**
   * Effective end date of the Price Sheet billing period
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  effectiveEndDate?: utcDateTime;

  /**
   * The per-unit price at the time of billing for a given product or service, inclusive of any negotiated discounts on top of the market price.
   *
   *  For PriceType ReservedInstance, unit price reflects the total cost of the 1 or 3-year commitment including discounts.
   *
   *  Note: The unit price isn't the same as the effective price in usage details downloads when services have differential prices across tiers.
   *
   *  If services have multi-tiered pricing, the effective price is a blended rate across the tiers and doesn't show a tier-specific unit price. The blended price or effective price is the net price for the consumed quantity spanning across the multiple tiers (where each tier has a specific unit price).
   */
  @visibility(Lifecycle.Read)
  unitPrice?: string;

  /**
   * The unit price at the time the customer signs on or the unit price at the time of service meter GA launch if it is after sign-on.
   *
   *  This is applicable for Enterprise Agreement users
   */
  @visibility(Lifecycle.Read)
  basePrice?: string;

  /**
   * The current list price for a given product or service. This price is without any negotiations and is based on your Microsoft Agreement type.
   *
   *  For PriceType Consumption, market price is reflected as the pay-as-you-go price.
   *
   *  For PriceType Savings Plan, market price reflects the Savings plan benefit on top of pay-as-you-go price for the corresponding commitment term.
   *
   *  For PriceType ReservedInstance, market price reflects the total price of the 1 or 3-year commitment.
   */
  @visibility(Lifecycle.Read)
  marketPrice?: string;

  /**
   * Currency in which all the prices are reflected.
   */
  @visibility(Lifecycle.Read)
  currency?: string;

  /**
   * Currency in which charges are posted.
   */
  @visibility(Lifecycle.Read)
  billingCurrency?: string;

  /**
   * Term length for Azure Savings Plan or Reservation term – one year or three years (P1Y or P3Y)
   */
  @visibility(Lifecycle.Read)
  term?: string;

  /**
   * Price type for a product. For example, an Azure resource with a pay-as-you-go rate with priceType as Consumption. Other price types include ReservedInstance and Savings Plan.
   */
  @visibility(Lifecycle.Read)
  priceType?: string;
}

/**
 * The properties of the price sheet download.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model EAPricesheetDownloadProperties {
  /**
   * The link (url) to download the pricesheet.
   */
  @visibility(Lifecycle.Read)
  downloadUrl?: string;

  /**
   * Download link validity.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  validTill?: utcDateTime;

  /**
   * The properties in downloaded file
   */
  downloadFileProperties?: EAPriceSheetProperties;
}

/**
 * The properties of the EA price sheet. Properties supported with version 2025-03-01 are as below
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model EAPriceSheetProperties {
  /**
   * Unique identifier for the EA billing account.
   */
  @visibility(Lifecycle.Read)
  enrollmentNumber?: string;

  /**
   * Type of Azure service. For example, Compute, Analytics, and Security.
   */
  @visibility(Lifecycle.Read)
  serviceFamily?: float32;

  /**
   * Name of the product accruing the charges.
   */
  @visibility(Lifecycle.Read)
  product?: string;

  /**
   * Unique identifier for the product whose meter is consumed.
   */
  @visibility(Lifecycle.Read)
  productId?: string;

  /**
   * Unique identifier of the SKU
   */
  @visibility(Lifecycle.Read)
  skuId?: string;

  /**
   * How usage is measured for the service. Note: The field “Unit” has been removed with version 2023-11-01 as a duplicate of “UnitofMeasure”, please use the field “UnitOfMeasure”.
   */
  @visibility(Lifecycle.Read)
  unitOfMeasure?: string;

  /**
   * Unique identifier of the meter
   */
  @visibility(Lifecycle.Read)
  meterId?: string;

  /**
   * Name of the meter. The meter represents the deployable resource of an Azure service.
   */
  @visibility(Lifecycle.Read)
  meterName?: string;

  /**
   * Name of the meter type
   */
  @visibility(Lifecycle.Read)
  meterType?: string;

  /**
   * Determines the Azure offer associated with this meter. [Learn more about Azure offers] (https://azure.microsoft.com/en-us/support/legal/offer-details/)
   */
  @visibility(Lifecycle.Read)
  offerId?: string;

  /**
   * Name of the classification category for the meter. For example, Cloud services, Networking, etc.
   */
  @visibility(Lifecycle.Read)
  meterCategory?: string;

  /**
   * Name of the meter subclassification category.
   */
  @visibility(Lifecycle.Read)
  meterSubCategory?: string;

  /**
   * Name of the Azure region where the meter for the service is available.
   */
  @visibility(Lifecycle.Read)
  meterRegion?: string;

  /**
   * Effective start date of the Price Sheet billing period
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  effectiveStartDate?: utcDateTime;

  /**
   * Effective end date of the Price Sheet billing period
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  effectiveEndDate?: utcDateTime;

  /**
   * The per-unit price at the time of billing for a given product or service, inclusive of any negotiated discounts on top of the market price.
   *
   *  For PriceType ReservedInstance, unit price reflects the total cost of the 1 or 3-year commitment including discounts.
   *
   *  Note: The unit price isn't the same as the effective price in usage details downloads when services have differential prices across tiers.
   *
   *  If services have multi-tiered pricing, the effective price is a blended rate across the tiers and doesn't show a tier-specific unit price. The blended price or effective price is the net price for the consumed quantity spanning across the multiple tiers (where each tier has a specific unit price).
   */
  @visibility(Lifecycle.Read)
  unitPrice?: string;

  /**
   * The unit price at the time the customer signs on or the unit price at the time of service meter GA launch if it is after sign-on.
   *
   *  This is applicable for Enterprise Agreement users
   */
  @visibility(Lifecycle.Read)
  basePrice?: string;

  /**
   * The current list price for a given product or service. This price is without any negotiations and is based on your Microsoft Agreement type.
   *
   *  For PriceType Consumption, market price is reflected as the pay-as-you-go price.
   *
   *  For PriceType Savings Plan, market price reflects the Savings plan benefit on top of pay-as-you-go price for the corresponding commitment term.
   *
   *  For PriceType ReservedInstance, market price reflects the total price of the 1 or 3-year commitment.
   *
   *  Note: For EA customers with no negotiations, market price may appear rounded to a different decimal precision than unit price.
   */
  @visibility(Lifecycle.Read)
  marketPrice?: string;

  /**
   * Quantities of a specific service to which an EA customer is entitled to consume without incremental charges.
   */
  @visibility(Lifecycle.Read)
  includedQuantity?: string;

  /**
   * Currency in which the Enterprise Agreement was signed
   */
  @visibility(Lifecycle.Read)
  currencyCode?: string;

  /**
   * Term length for Azure Savings Plan or Reservation term – one year or three years (P1Y or P3Y)
   */
  @visibility(Lifecycle.Read)
  term?: string;

  /**
   * Price type for a product. For example, an Azure resource with a pay-as-you-go rate with priceType as Consumption. Other price types include ReservedInstance and Savings Plan.
   */
  @visibility(Lifecycle.Read)
  priceType?: string;

  /**
   * Part number associated with the meter
   */
  @visibility(Lifecycle.Read)
  partNumber?: string;
}

/**
 * The properties of the scheduled action.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
   * For private scheduled action(Create or Update), scope will be empty.<br /> For shared scheduled action(Create or Update By Scope), Cost Management scope can be 'subscriptions/{subscriptionId}' for subscription scope, 'subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}' for resourceGroup scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}' for Billing Account scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/departments/{departmentId}' for Department scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/enrollmentAccounts/{enrollmentAccountId}' for EnrollmentAccount scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}' for BillingProfile scope, 'providers/Microsoft.Billing/billingAccounts/{billingAccountId}/invoiceSections/{invoiceSectionId}' for InvoiceSection scope, '/providers/Microsoft.CostManagement/externalBillingAccounts/{externalBillingAccountName}' for ExternalBillingAccount scope, and '/providers/Microsoft.CostManagement/externalSubscriptions/{externalSubscriptionName}' for ExternalSubscription scope.
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
  @minItems(1)
  @maxItems(20)
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ScheduledActionProxyResource
  extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * Resource Etag. For update calls, eTag is optional and can be specified to achieve optimistic concurrency. Fetch the resource's eTag by doing a 'GET' call first and then including the latest eTag as part of the request body or 'If-Match' header while performing the update. For create calls, eTag is not required.
   */
  @visibility(Lifecycle.Read)
  eTag?: string;

  /**
   * Kind of the scheduled action.
   */
  kind?: ScheduledActionKind;

  /**
   * Kind of the scheduled action.
   */
  systemData?: SystemData;
}

/**
 * Error response indicates that the service is not able to process the incoming request. The reason is provided in the error message.
 *
 * Some Error responses:
 *
 *  * 429 TooManyRequests - Request is throttled. Retry after waiting for the time specified in the "x-ms-ratelimit-microsoft.consumption-retry-after" header.
 *
 *  * 503 ServiceUnavailable - Service is temporarily unavailable. Retry after waiting for the time specified in the "Retry-After" header.
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ErrorDetailsWithNestedDetails extends ErrorDetails {
  /**
   * The additional details of the error.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  details?: ErrorDetailsWithNestedDetails[];
}

/**
 * Setting list result. It contains a list of settings.
 */
model SettingsListResult {
  /**
   * The list of settings.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["id"])
  @pageItems
  value?: Setting[];
}

/**
 * The properties of the benefit recommendations when scope is 'Single'.
 */
model SingleScopeBenefitRecommendationProperties
  extends BenefitRecommendationProperties {
  /**
   * The subscription ID that this single scope recommendation is for. Applicable only if recommendation is for 'Single' scope.
   */
  @visibility(Lifecycle.Read)
  subscriptionId?: string;

  /**
   * The resource group that this single scope recommendation is for. Applicable only if recommendation is for 'Single' scope and 'ResourceGroup' request scope.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  armSkuName?: string;

  /**
   * The benefit ID is the identifier of the benefit.
   */
  @visibility(Lifecycle.Read)
  benefitId?: string;

  /**
   * The benefit order ID is the identifier for a benefit purchase.
   */
  @visibility(Lifecycle.Read)
  benefitOrderId?: string;

  /**
   * The benefit type. Supported values: 'SavingsPlan'.
   */
  benefitType?: BenefitKind;

  /**
   * Date corresponding to the utilization summary record. If the grain of data is monthly, value for this field will be first day of the month.
   */
  @visibility(Lifecycle.Read)
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model IncludedQuantityUtilizationSummaryProperties
  extends BenefitUtilizationSummaryProperties {
  /**
   * This is the utilized percentage for the benefit ID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SavingsPlanUtilizationSummaryProperties
  extends BenefitUtilizationSummaryProperties {
  /**
   * This is the average hourly utilization for each date range that corresponds to given grain (Daily, Monthly). Suppose the API call is for usageDate > 2025-03-01 and usageDate < 2022-10-31 at a daily granularity. There will be one record per benefit id for each day. For a single day, the avgUtilizationPercentage value will be equal to the average of the set of values where the set contains 24 utilization percentage entries one for each hour in a specific day.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  avgUtilizationPercentage?: decimal;

  /**
   * This is the minimum hourly utilization for each date range that corresponds to given grain (Daily, Monthly). Suppose the API call is for usageDate > 2025-03-01 and usageDate < 2022-10-31 at a daily granularity. There will be one record per benefit id for each day. For a single day, the minUtilizationPercentage value will be equal to the smallest in the set of values where the set contains 24 utilization percentage entries one for each hour in a specific day. If on the day 2022-10-18, the lowest utilization percentage was 10% at hour 4, then the value for the minUtilizationPercentage in the response will be 10%.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  minUtilizationPercentage?: decimal;

  /**
   * This is the maximum hourly utilization for each date range that corresponds to given grain (Daily, Monthly). Suppose the API call is for usageDate > 2025-03-01 and usageDate < 2022-10-31 at a daily granularity. There will be one record per benefit id for each day. For a single day, the maxUtilizationPercentage value will be equal to the largest in the set of values where the set contains 24 utilization percentage entries one for each hour in a specific day. If on the day 2022-10-18, the largest utilization percentage was 90% at hour 5, then the value for the maxUtilizationPercentage in the response will be 90%.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  maxUtilizationPercentage?: decimal;
}

/**
 * Tag Inheritance Setting definition.
 */
model TagInheritanceSetting extends Setting {
  /**
   * The properties of the tag inheritance setting.
   */
  properties?: TagInheritanceProperties;

  /**
   * Specifies the kind of settings.
   */
  kind: "taginheritance";
}

/**
 * The properties of the tag inheritance setting.
 */
model TagInheritanceProperties {
  /**
   * This property defines the behavior when an inherited tag being applied matches a lower scope tag (Eg. Subscription tag matches the resource tag). If set to true - when tags match, the highest scope tags will be applied. Billing profile is the highest scope,  followed by invoice sections, subscriptions and resource groups (allows overriding of lower scope tag values). If set to false - when tags match, the lowest scope tags will be applied. So, if a resource has the same tag as a subscription tag, the resource tag will be applied (does not allow overriding of lower scope tag values).
   */
  preferContainerTags: boolean;
}

/**
 * Result of listing benefit recommendations.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model benefitRecommendationsListResult {
  /**
   * The list of benefit recommendations.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: BenefitRecommendationModel[];

  /**
   * The link (url) to the next page of results.
   */
  @nextLink
  nextLink?: string;
}

/**
 * Result of listing budgets. It contains a list of available budgets in the scope provided.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BudgetsListResult {
  /**
   * The list of budgets.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: Budget[];

  /**
   * The link (url) to the next page of results.\r\nIt's null for now, added for future use.
   */
  @nextLink
  nextLink?: string;
}

/**
 * List of benefit utilization summaries.
 */
model BenefitUtilizationSummariesListResult {
  /**
   * The list of benefit utilization summaries.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: BenefitUtilizationSummary[];

  /**
   * The link (URL) to the next page of results.
   */
  @nextLink
  nextLink?: string;
}

/**
 * Scheduled actions list result. It contains a list of scheduled actions.
 */
model ScheduledActionListResult {
  /**
   * The list of scheduled actions.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: ScheduledAction[];

  /**
   * The link (url) to the next page of results.
   */
  @nextLink
  nextLink?: string;
}

/**
 * Result of listing views. It contains a list of available views.
 */
model ViewListResult {
  /**
   * The list of views.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: View[];

  /**
   * The link (url) to the next page of results.
   */
  @nextLink
  nextLink?: string;
}

/**
 * Error response indicates that the service is not able to process the incoming request. The reason is provided in the error message. \n\nSome Error responses: \n\n * 429 TooManyRequests - Request is throttled. Retry after waiting for the time specified in the \"x-ms-ratelimit-microsoft.consumption-retry-after\" header. \n\n * 503 ServiceUnavailable - Service is temporarily unavailable. Retry after waiting for the time specified in the \"Retry-After\" header.
 */
@error
model ErrorResponse {
  /**
   * The details of the error.
   */
  error?: ErrorDetails;
}

/**
 * Result of listing cost management operations. It contains a list of operations and a URL link to get the next set of results.
 */
model OperationListResult {
  /**
   * List of cost management operations supported by the Microsoft.CostManagement resource provider.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: CostManagementOperation[];

  /**
   * URL to get the next set of operation list results if there are any.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  status?: CostDetailsStatusType;

  /**
   * The manifest of the report generated by the operation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  manifest?: ReportManifest;

  /**
   * The time at which report URL becomes invalid/expires in UTC e.g. 2020-12-08T05:55:59.4394737Z.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  validTill?: utcDateTime;

  /**
   * The details of the error.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  error?: ErrorDetails;
}
