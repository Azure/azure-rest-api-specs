import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace Microsoft.Consumption;

/**
 * The scope associated with reservations details operations. This includes '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}' for BillingAccount scope (legacy), and '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}' for BillingProfile scope (modern).
 */
model ResourceScopeActionScope
  is Azure.ResourceManager.Extension.ScopeParameter;

/**
 * The status of the long running operation.
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union Metrictype {
  string,

  /**
   * Actual cost data.
   */
  ActualCostMetricType: "actualcost",

  /**
   * Amortized cost data.
   */
  AmortizedCostMetricType: "amortizedcost",

  /**
   * Usage data.
   */
  UsageMetricType: "usage",
}

/**
 * Specifies the kind of usage details.
 */
union UsageDetailsKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  legacy: "legacy",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  modern: "modern",
}

/**
 * The category of the budget, whether the budget tracks cost or usage.
 */
union CategoryType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Cost: "Cost",
}

/**
 * The time covered by a budget. Tracking of the amount will be reset based on the time grain. BillingMonth, BillingQuarter, and BillingAnnual are only supported by WD customers
 */
union TimeGrainType {
  string,
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
 * The operator to use for comparison.
 */
union BudgetOperatorType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  In: "In",
}

/**
 * The comparison operator.
 */
union OperatorType {
  string,

  /**
   * Alert will be triggered if the evaluated cost is the same as threshold value. Note: It’s not recommended to use this OperatorType as there’s low chance of cost being exactly the same as threshold value, leading to missing of your alert. This OperatorType will be deprecated in future.
   */
  EqualTo: "EqualTo",

  /**
   * Alert will be triggered if the evaluated cost is greater than the threshold value. Note: This is the recommended OperatorType while configuring Budget Alert.
   */
  GreaterThan: "GreaterThan",

  /**
   * Alert will be triggered if the evaluated cost is greater than or equal to the threshold value.
   */
  GreaterThanOrEqualTo: "GreaterThanOrEqualTo",
}

/**
 * The type of threshold
 */
union ThresholdType {
  string,

  /**
   * Actual costs budget alerts notify when the actual accrued cost exceeds the allocated budget .
   */
  Actual: "Actual",

  /**
   * Forecasted costs budget alerts provide advanced notification that your spending trends are likely to exceed your allocated budget, as it relies on forecasted cost predictions.
   */
  Forecasted: "Forecasted",
}

/**
 * Language in which the recipient will receive the notification
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
 * Specifies the kind of charge summary.
 */
union ChargeSummaryKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  legacy: "legacy",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  modern: "modern",
}

/**
 * The billing frequency.
 */
union BillingFrequency {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Month: "Month",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Quarter: "Quarter",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Year: "Year",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union Datagrain {
  string,

  /**
   * Daily grain of data
   */
  DailyGrain: "daily",

  /**
   * Monthly grain of data
   */
  MonthlyGrain: "monthly",
}

/**
 * Specifies the kind of reservation recommendation.
 */
union ReservationRecommendationKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  legacy: "legacy",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  modern: "modern",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union Scope {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Single: "Single",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Shared: "Shared",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union Term {
  string,

  /**
   * 1 month reservation term
   */
  P1M: "P1M",

  /**
   * 1 year reservation term
   */
  P1Y: "P1Y",

  /**
   * 3 year reservation term
   */
  P3Y: "P3Y",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union LookBackPeriod {
  string,

  /**
   * Use 7 days of data for recommendations
   */
  Last07Days: "Last7Days",

  /**
   * Use 30 days of data for recommendations
   */
  Last30Days: "Last30Days",

  /**
   * Use 60 days of data for recommendations
   */
  Last60Days: "Last60Days",
}

/**
 * Identifies the type of the event.
 */
union EventType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SettledCharges: "SettledCharges",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PendingCharges: "PendingCharges",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PendingAdjustments: "PendingAdjustments",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PendingNewCredit: "PendingNewCredit",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PendingExpiredCredit: "PendingExpiredCredit",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UnKnown: "UnKnown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NewCredit: "NewCredit",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CreditExpired: "CreditExpired",
}

/**
 * The source of the lot.
 */
union LotSource {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PurchasedCredit: "PurchasedCredit",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PromotionalCredit: "PromotionalCredit",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ConsumptionCommitment: "ConsumptionCommitment",
}

/**
 * The status of the lot.
 */
union Status {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Inactive: "Inactive",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Expired: "Expired",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Complete: "Complete",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
}

/**
 * The organization type of the lot.
 */
union OrganizationType {
  string,

  /**
   * Primary organization type for Multi-Entity consumption commitment.
   */
  PrimaryOrganizationType: "Primary",

  /**
   * Contributor organization type for Multi-Entity consumption commitment.
   */
  ContributorOrganizationType: "Contributor",
}

/**
 * Identifier that indicates how the meter is priced.
 */
union PricingModelType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `On Demand`: "On Demand",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Reservation: "Reservation",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Spot: "Spot",
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
  properties?: PricesheetDownloadProperties;
}

/**
 * The properties of the price sheet download.
 */
model PricesheetDownloadProperties {
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
}

/**
 * An usage detail resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("kind")
model UsageDetail extends Azure.ResourceManager.Foundations.Resource {
  /**
   * Specifies the kind of usage details.
   */
  kind: UsageDetailsKind;

  /**
   * The etag for the resource.
   */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  tags?: Record<string>;
}

/**
 * A marketplace resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model Marketplace extends Azure.ResourceManager.Foundations.Resource {
  /**
   * The properties of the marketplace usage detail.
   */
  properties?: MarketplaceProperties;

  /**
   * The etag for the resource.
   */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  tags?: Record<string>;
}

/**
 * The properties of the marketplace usage detail.
 */
model MarketplaceProperties {
  /**
   * The id of the billing period resource that the usage belongs to.
   */
  @visibility(Lifecycle.Read)
  billingPeriodId?: string;

  /**
   * The start of the date time range covered by the usage detail.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  usageStart?: utcDateTime;

  /**
   * The end of the date time range covered by the usage detail.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  usageEnd?: utcDateTime;

  /**
   * The marketplace resource rate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  resourceRate?: decimal;

  /**
   * The type of offer.
   */
  @visibility(Lifecycle.Read)
  offerName?: string;

  /**
   * The name of resource group.
   */
  @visibility(Lifecycle.Read)
  resourceGroup?: string;

  /**
   * Additional information.
   */
  @visibility(Lifecycle.Read)
  additionalInfo?: string;

  /**
   * The order number.
   */
  @visibility(Lifecycle.Read)
  orderNumber?: string;

  /**
   * The name of the resource instance that the usage is about.
   */
  @visibility(Lifecycle.Read)
  instanceName?: string;

  /**
   * The uri of the resource instance that the usage is about.
   */
  @visibility(Lifecycle.Read)
  instanceId?: string;

  /**
   * The ISO currency in which the meter is charged, for example, USD.
   */
  @visibility(Lifecycle.Read)
  currency?: string;

  /**
   * The quantity of usage.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  consumedQuantity?: decimal;

  /**
   * The unit of measure.
   */
  @visibility(Lifecycle.Read)
  unitOfMeasure?: string;

  /**
   * The amount of cost before tax.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  pretaxCost?: decimal;

  /**
   * The estimated usage is subject to change.
   */
  @visibility(Lifecycle.Read)
  isEstimated?: boolean;

  /**
   * The meter id (GUID).
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  meterId?: string;

  /**
   * Subscription guid.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  subscriptionGuid?: string;

  /**
   * Subscription name.
   */
  @visibility(Lifecycle.Read)
  subscriptionName?: string;

  /**
   * Account name.
   */
  @visibility(Lifecycle.Read)
  accountName?: string;

  /**
   * Department name.
   */
  @visibility(Lifecycle.Read)
  departmentName?: string;

  /**
   * Consumed service name.
   */
  @visibility(Lifecycle.Read)
  consumedService?: string;

  /**
   * The cost center of this department if it is a department and a costcenter exists
   */
  @visibility(Lifecycle.Read)
  costCenter?: string;

  /**
   * Additional details of this usage item. By default this is not populated, unless it's specified in $expand.
   */
  @visibility(Lifecycle.Read)
  additionalProperties?: string;

  /**
   * The name of publisher.
   */
  @visibility(Lifecycle.Read)
  publisherName?: string;

  /**
   * The name of plan.
   */
  @visibility(Lifecycle.Read)
  planName?: string;

  /**
   * Flag indicating whether this is a recurring charge or not.
   */
  @visibility(Lifecycle.Read)
  isRecurringCharge?: boolean;
}

/**
 * The properties of the budget.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BudgetProperties {
  /**
   * The category of the budget, whether the budget tracks cost or usage.
   */
  category: CategoryType;

  /**
   * The total amount of cost to track with the budget
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  amount: decimal;

  /**
   * The time covered by a budget. Tracking of the amount will be reset based on the time grain. BillingMonth, BillingQuarter, and BillingAnnual are only supported by WD customers
   */
  timeGrain: TimeGrainType;

  /**
   * Has start and end date of the budget. The start date must be first of the month and should be less than the end date. Budget start date must be on or after June 1, 2017. Future start date should not be more than twelve months. Past start date should  be selected within the timegrain period. There are no restrictions on the end date.
   */
  timePeriod: BudgetTimePeriod;

  /**
   * May be used to filter budgets by user-specified dimensions and/or tags.
   */
  filter?: BudgetFilter;

  /**
   * The current amount of cost which is being tracked for a budget.
   */
  @visibility(Lifecycle.Read)
  currentSpend?: CurrentSpend;

  /**
   * Dictionary of notifications associated with the budget. Budget can have up to five notifications.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  notifications?: Record<Notification>;

  /**
   * The forecasted cost which is being tracked for a budget.
   */
  @visibility(Lifecycle.Read)
  forecastSpend?: ForecastSpend;
}

/**
 * The start and end date for a budget.
 */
model BudgetTimePeriod {
  /**
   * The start date for the budget.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDate: utcDateTime;

  /**
   * The end date for the budget. If not provided, we default this to 10 years from the start date.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDate?: utcDateTime;
}

/**
 * May be used to filter budgets by resource group, resource, or meter.
 */
model BudgetFilter {
  /**
   * The logical "AND" expression. Must have at least 2 items.
   */
  @identifiers(#[])
  @minItems(0)
  and?: BudgetFilterProperties[];

  /**
   * Has comparison expression for a dimension
   */
  dimensions?: BudgetComparisonExpression;

  /**
   * Has comparison expression for a tag
   */
  tags?: BudgetComparisonExpression;
}

/**
 * The Dimensions or Tags to filter a budget by.
 */
model BudgetFilterProperties {
  /**
   * Has comparison expression for a dimension
   */
  dimensions?: BudgetComparisonExpression;

  /**
   * Has comparison expression for a tag
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
 */
model CurrentSpend {
  /**
   * The total amount of cost which is being tracked by the budget.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  amount?: decimal;

  /**
   * The unit of measure for the budget amount.
   */
  @visibility(Lifecycle.Read)
  unit?: string;
}

/**
 * The notification associated with a budget.
 */
model Notification {
  /**
   * The notification is enabled or not.
   */
  enabled: boolean;

  /**
   * The comparison operator.
   */
  operator: OperatorType;

  /**
   * Threshold value associated with a notification. Notification is sent when the cost exceeded the threshold. It is always percent and has to be between 0 and 1000.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  threshold: decimal;

  /**
   * Email addresses to send the budget notification to when the threshold is exceeded. Must have at least one contact email or contact group specified at the Subscription or Resource Group scopes. All other scopes must have at least one contact email specified.
   */
  @minItems(0)
  @maxItems(50)
  contactEmails: string[];

  /**
   * Contact roles to send the budget notification to when the threshold is exceeded.
   */
  contactRoles?: string[];

  /**
   * Action groups to send the budget notification to when the threshold is exceeded. Must be provided as a fully qualified Azure resource id. Only supported at Subscription or Resource Group scopes.
   */
  @minItems(0)
  @maxItems(50)
  contactGroups?: string[];

  /**
   * The type of threshold
   */
  thresholdType?: ThresholdType = ThresholdType.Actual;

  /**
   * Language in which the recipient will receive the notification
   */
  locale?: CultureCode;
}

/**
 * The forecasted cost which is being tracked for a budget.
 */
model ForecastSpend {
  /**
   * The forecasted cost for the total time period which is being tracked by the budget. This value is only provided if the budget contains a forecast alert type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  amount?: decimal;

  /**
   * The unit of measure for the budget amount.
   */
  @visibility(Lifecycle.Read)
  unit?: string;
}

/**
 * A resource listing all tags.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TagsResult extends Azure.ResourceManager.Foundations.ProxyResource {
  /**
   * The properties of the tag.
   */
  properties?: TagProperties;

  /**
   * eTag of the resource. To handle concurrent update scenario, this field will be used to determine whether the user is updating the latest version or not.
   */
  eTag?: string;
}

/**
 * The properties of the tag.
 */
model TagProperties {
  /**
   * A list of Tag.
   */
  @identifiers(#["key"])
  tags?: Tag[];

  /**
   * The link (url) to the next page of results.
   */
  @visibility(Lifecycle.Read)
  nextLink?: string;

  /**
   * The link (url) to the previous page of results.
   */
  @visibility(Lifecycle.Read)
  previousLink?: string;
}

/**
 * The tag resource.
 */
model Tag {
  /**
   * Tag key.
   */
  key?: string;

  /**
   * Tag values.
   */
  value?: string[];
}

/**
 * Result of listing charge summary.
 */
model ChargesListResult {
  /**
   * The list of charge summary
   */
  @visibility(Lifecycle.Read)
  value?: ChargeSummary[];
}

/**
 * A charge summary resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("kind")
model ChargeSummary extends Azure.ResourceManager.Foundations.ProxyResource {
  /**
   * Specifies the kind of charge summary.
   */
  kind: ChargeSummaryKind;

  /**
   * eTag of the resource. To handle concurrent update scenario, this field will be used to determine whether the user is updating the latest version or not.
   */
  eTag?: string;
}

/**
 * A balance resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model Balance extends Azure.ResourceManager.Foundations.Resource {
  /**
   * The properties of the balance.
   */
  properties?: BalanceProperties;

  /**
   * The etag for the resource.
   */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  tags?: Record<string>;
}

/**
 * The properties of the balance.
 */
model BalanceProperties {
  /**
   * The ISO currency in which the meter is charged, for example, USD.
   */
  @visibility(Lifecycle.Read)
  currency?: string;

  /**
   * The beginning balance for the billing period.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  beginningBalance?: decimal;

  /**
   * The ending balance for the billing period (for open periods this will be updated daily).
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  endingBalance?: decimal;

  /**
   * Total new purchase amount.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  newPurchases?: decimal;

  /**
   * Total adjustment amount.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  adjustments?: decimal;

  /**
   * Total Commitment usage.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  utilized?: decimal;

  /**
   * Overage for Azure services.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  serviceOverage?: decimal;

  /**
   * Charges Billed separately.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  chargesBilledSeparately?: decimal;

  /**
   * serviceOverage + chargesBilledSeparately.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  totalOverage?: decimal;

  /**
   * Azure service commitment + total Overage.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  totalUsage?: decimal;

  /**
   * Total charges for Azure Marketplace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  azureMarketplaceServiceCharges?: decimal;

  /**
   * The billing frequency.
   */
  billingFrequency?: BillingFrequency;

  /**
   * Price is hidden or not.
   */
  @visibility(Lifecycle.Read)
  priceHidden?: boolean;

  /**
   * Overage Refunds
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  overageRefund?: decimal;

  /**
   * List of new purchases.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  newPurchasesDetails?: BalancePropertiesNewPurchasesDetailsItem[];

  /**
   * List of Adjustments (Promo credit, SIE credit etc.).
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  adjustmentDetails?: BalancePropertiesAdjustmentDetailsItem[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BalancePropertiesNewPurchasesDetailsItem {
  /**
   * the name of new purchase.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * the value of new purchase.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  value?: decimal;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BalancePropertiesAdjustmentDetailsItem {
  /**
   * the name of new adjustment.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * the value of new adjustment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  value?: decimal;
}

/**
 * reservation summary resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ReservationSummary extends Azure.ResourceManager.Foundations.Resource {
  /**
   * The properties of the reservation summary.
   */
  properties?: ReservationSummaryProperties;

  /**
   * The etag for the resource.
   */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  tags?: Record<string>;
}

/**
 * The properties of the reservation summary.
 */
model ReservationSummaryProperties {
  /**
   * The reservation order ID is the identifier for a reservation purchase. Each reservation order ID represents a single purchase transaction. A reservation order contains reservations. The reservation order specifies the VM size and region for the reservations.
   */
  @visibility(Lifecycle.Read)
  reservationOrderId?: string;

  /**
   * The reservation ID is the identifier of a reservation within a reservation order. Each reservation is the grouping for applying the benefit scope and also specifies the number of instances to which the reservation benefit can be applied to.
   */
  @visibility(Lifecycle.Read)
  reservationId?: string;

  /**
   * This is the ARM Sku name. It can be used to join with the serviceType field in additional info in usage records.
   */
  @visibility(Lifecycle.Read)
  skuName?: string;

  /**
   * This is the total hours reserved. E.g. if reservation for 1 instance was made on 1 PM, this will be 11 hours for that day and 24 hours from subsequent days
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  reservedHours?: decimal;

  /**
   * Data corresponding to the utilization record. If the grain of data is monthly, it will be first day of month.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  usageDate?: utcDateTime;

  /**
   * Total used hours by the reservation
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  usedHours?: decimal;

  /**
   * This is the minimum hourly utilization in the usage time (day or month). E.g. if usage record corresponds to 12/10/2017 and on that for hour 4 and 5, utilization was 10%, this field will return 10% for that day
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  minUtilizationPercentage?: decimal;

  /**
   * This is average utilization for the entire time range. (day or month depending on the grain)
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  avgUtilizationPercentage?: decimal;

  /**
   * This is the maximum hourly utilization in the usage time (day or month). E.g. if usage record corresponds to 12/10/2017 and on that for hour 4 and 5, utilization was 100%, this field will return 100% for that day.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  maxUtilizationPercentage?: decimal;

  /**
   * The reservation kind.
   */
  @visibility(Lifecycle.Read)
  kind?: string;

  /**
   * This is the purchased quantity for the reservationId.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  purchasedQuantity?: decimal;

  /**
   * This is the remaining quantity for the reservationId.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  remainingQuantity?: decimal;

  /**
   * This is the total count of instances that are reserved for the reservationId.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  totalReservedQuantity?: decimal;

  /**
   * This is the used quantity for the reservationId.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  usedQuantity?: decimal;

  /**
   * This is the utilized percentage for the reservation Id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  utilizedPercentage?: decimal;
}

/**
 * reservation detail resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ReservationDetail extends Azure.ResourceManager.Foundations.Resource {
  /**
   * The properties of the reservation detail.
   */
  properties?: ReservationDetailProperties;

  /**
   * The etag for the resource.
   */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  tags?: Record<string>;
}

/**
 * The properties of the reservation detail.
 */
model ReservationDetailProperties {
  /**
   * The reservation order ID is the identifier for a reservation purchase. Each reservation order ID represents a single purchase transaction. A reservation order contains reservations. The reservation order specifies the VM size and region for the reservations.
   */
  @visibility(Lifecycle.Read)
  reservationOrderId?: string;

  /**
   * The instance Flexibility Ratio.
   */
  @visibility(Lifecycle.Read)
  instanceFlexibilityRatio?: string;

  /**
   * The instance Flexibility Group.
   */
  @visibility(Lifecycle.Read)
  instanceFlexibilityGroup?: string;

  /**
   * The reservation ID is the identifier of a reservation within a reservation order. Each reservation is the grouping for applying the benefit scope and also specifies the number of instances to which the reservation benefit can be applied to.
   */
  @visibility(Lifecycle.Read)
  reservationId?: string;

  /**
   * This is the ARM Sku name. It can be used to join with the serviceType field in additional info in usage records.
   */
  @visibility(Lifecycle.Read)
  skuName?: string;

  /**
   * This is the total hours reserved for the day. E.g. if reservation for 1 instance was made on 1 PM, this will be 11 hours for that day and 24 hours from subsequent days.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  reservedHours?: decimal;

  /**
   * The date on which consumption occurred.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  usageDate?: utcDateTime;

  /**
   * This is the total hours used by the instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  usedHours?: decimal;

  /**
   * This identifier is the name of the resource or the fully qualified Resource ID.
   */
  @visibility(Lifecycle.Read)
  instanceId?: string;

  /**
   * This is the total count of instances that are reserved for the reservationId.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  totalReservedQuantity?: decimal;

  /**
   * The reservation kind.
   */
  @visibility(Lifecycle.Read)
  kind?: string;
}

/**
 * A reservation recommendation resource.
 */
@discriminator("kind")
model ReservationRecommendation {
  ...Azure.ResourceManager.Foundations.Resource;
  ...ResourceAttributes;

  /**
   * The etag for the resource.
   */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  tags?: Record<string>;

  /**
   * Specifies the kind of reservation recommendation.
   */
  kind: ReservationRecommendationKind;
}

/**
 * The Resource model definition.
 */
model ResourceAttributes {
  /**
   * Resource location
   */
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * Resource sku
   */
  @visibility(Lifecycle.Read)
  sku?: string;
}

/**
 * Reservation recommendation details.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ReservationRecommendationDetailsModel
  extends Azure.ResourceManager.Foundations.Resource {
  /**
   * Resource Location.
   */
  location?: string;

  /**
   * Resource sku
   */
  sku?: string;

  /**
   * The properties of the reservation recommendation.
   */
  properties?: ReservationRecommendationDetailsProperties;

  /**
   * The etag for the resource.
   */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  tags?: Record<string>;
}

/**
 * The properties of the reservation recommendation.
 */
model ReservationRecommendationDetailsProperties {
  /**
   * An ISO 4217 currency code identifier for the costs and savings
   */
  @visibility(Lifecycle.Read)
  currency?: string;

  /**
   * Resource specific properties.
   */
  @visibility(Lifecycle.Read)
  resource?: ReservationRecommendationDetailsResourceProperties;

  /**
   * Resource Group.
   */
  @visibility(Lifecycle.Read)
  resourceGroup?: string;

  /**
   * Savings information for the recommendation.
   */
  @visibility(Lifecycle.Read)
  savings?: ReservationRecommendationDetailsSavingsProperties;

  /**
   * Scope of the reservation, ex: Single or Shared.
   */
  @visibility(Lifecycle.Read)
  scope?: string;

  /**
   * Historical usage details used to calculate the estimated savings.
   */
  @visibility(Lifecycle.Read)
  usage?: ReservationRecommendationDetailsUsageProperties;
}

/**
 * Details of the resource.
 */
model ReservationRecommendationDetailsResourceProperties {
  /**
   * List of subscriptions for which the reservation is applied.
   */
  @visibility(Lifecycle.Read)
  appliedScopes?: string[];

  /**
   * On-demand rate of the resource. Most resources use hourly rates, except for BlockBlob, ManagedDisk, Backup, and Azure Files, which use monthly rates. Only hardware rates are included; software rates are excluded.  Note: there could be new resources that use hourly rates in the future.
   */
  @visibility(Lifecycle.Read)
  onDemandRate?: float32;

  /**
   * Azure product ex: Standard_E8s_v3 etc.
   */
  @visibility(Lifecycle.Read)
  product?: string;

  /**
   * Azure resource region ex:EastUS, WestUS etc.
   */
  @visibility(Lifecycle.Read)
  region?: string;

  /**
   * Hourly reservation rate of the resource. Varies based on the term.
   */
  @visibility(Lifecycle.Read)
  reservationRate?: float32;

  /**
   * The azure resource type.
   */
  @visibility(Lifecycle.Read)
  resourceType?: string;
}

/**
 * Details of the estimated savings.
 */
model ReservationRecommendationDetailsSavingsProperties {
  /**
   * List of calculated savings.
   */
  @identifiers(#[])
  calculatedSavings?: ReservationRecommendationDetailsCalculatedSavingsProperties[];

  /**
   * Number of days of usage to look back used for computing the recommendation.
   */
  @visibility(Lifecycle.Read)
  lookBackPeriod?: int32;

  /**
   * Number of recommended units of the resource.
   */
  @visibility(Lifecycle.Read)
  recommendedQuantity?: float32;

  /**
   * Term period of the reservation. ex: P1M, P1Y or P3Y.
   */
  @visibility(Lifecycle.Read)
  reservationOrderTerm?: string;

  /**
   * Type of savings, ex: instance.
   */
  @visibility(Lifecycle.Read)
  savingsType?: string;

  /**
   * Measurement unit ex: hour etc.
   */
  @visibility(Lifecycle.Read)
  unitOfMeasure?: string;
}

/**
 * Details of estimated savings. The costs and savings are estimated for the term.
 */
model ReservationRecommendationDetailsCalculatedSavingsProperties {
  /**
   * The cost without reservation. Includes hardware and software cost.
   */
  @visibility(Lifecycle.Read)
  onDemandCost?: float32;

  /**
   * The estimated cost for resource meters that are not covered by the reservation and are billed at pay-as-you-go rates.
   */
  @visibility(Lifecycle.Read)
  overageCost?: float32;

  /**
   * The quantity for calculated savings.
   */
  @visibility(Lifecycle.Read)
  quantity?: float32;

  /**
   * Hardware cost of the resources covered by the reservation.
   */
  @visibility(Lifecycle.Read)
  reservationCost?: float32;

  /**
   * Reservation cost + software cost of the resources covered by the reservation + overage cost.
   */
  @visibility(Lifecycle.Read)
  totalReservationCost?: float32;

  /**
   * The number of reserved units used to calculate savings. Always 1 for virtual machines.
   */
  reservedUnitCount?: float32;

  /**
   * The amount saved by purchasing the recommended quantity of reservation. This is equal to onDemandCost - totalReservationCost.
   */
  @visibility(Lifecycle.Read)
  savings?: float32;
}

/**
 * Details about historical usage data that has been used for computing the recommendation.
 */
model ReservationRecommendationDetailsUsageProperties {
  /**
   * The first usage date used for looking back for computing the recommendation.
   */
  @visibility(Lifecycle.Read)
  firstConsumptionDate?: string;

  /**
   * The last usage date used for looking back for computing the recommendation.
   */
  @visibility(Lifecycle.Read)
  lastConsumptionDate?: string;

  /**
   * What the usage data values represent ex: virtual machine instance.
   */
  @visibility(Lifecycle.Read)
  lookBackUnitType?: string;

  /**
   * The breakdown of historical resource usage.  The values are in the order of usage between the firstConsumptionDate and the lastConsumptionDate.
   */
  @visibility(Lifecycle.Read)
  usageData?: float32[];

  /**
   * The grain of the values represented in the usage data ex: hourly.
   */
  @visibility(Lifecycle.Read)
  usageGrain?: string;
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
model HighCasedErrorResponse {
  /**
   * The details of the error.
   */
  error?: HighCasedErrorDetails;
}

/**
 * The details of the error.
 */
model HighCasedErrorDetails {
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
 * Reservation transaction resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ReservationTransaction
  extends Azure.ResourceManager.Foundations.Resource {
  /**
   * The properties of a legacy reservation transaction.
   */
  properties?: LegacyReservationTransactionProperties;

  /**
   * Resource tags.
   */
  @visibility(Lifecycle.Read)
  tags?: string[];
}

/**
 * The properties of a legacy reservation transaction.
 */
model LegacyReservationTransactionProperties {
  /**
   * The date of the transaction
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  eventDate?: utcDateTime;

  /**
   * The reservation order ID is the identifier for a reservation purchase. Each reservation order ID represents a single purchase transaction. A reservation order contains reservations. The reservation order specifies the VM size and region for the reservations.
   */
  @visibility(Lifecycle.Read)
  reservationOrderId?: string;

  /**
   * The description of the transaction.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * The type of the transaction (Purchase, Cancel or Refund).
   */
  @visibility(Lifecycle.Read)
  eventType?: string;

  /**
   * The quantity of the transaction.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  quantity?: decimal;

  /**
   * The charge of the transaction.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  amount?: decimal;

  /**
   * The ISO currency in which the transaction is charged, for example, USD.
   */
  @visibility(Lifecycle.Read)
  currency?: string;

  /**
   * The name of the reservation order.
   */
  @visibility(Lifecycle.Read)
  reservationOrderName?: string;

  /**
   * The purchasing enrollment.
   */
  @visibility(Lifecycle.Read)
  purchasingEnrollment?: string;

  /**
   * The subscription guid that makes the transaction.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  purchasingSubscriptionGuid?: string;

  /**
   * The subscription name that makes the transaction.
   */
  @visibility(Lifecycle.Read)
  purchasingSubscriptionName?: string;

  /**
   * This is the ARM Sku name. It can be used to join with the serviceType field in additional info in usage records.
   */
  @visibility(Lifecycle.Read)
  armSkuName?: string;

  /**
   * This is the term of the transaction.
   */
  @visibility(Lifecycle.Read)
  term?: string;

  /**
   * The region of the transaction.
   */
  @visibility(Lifecycle.Read)
  region?: string;

  /**
   * The name of the account that makes the transaction.
   */
  @visibility(Lifecycle.Read)
  accountName?: string;

  /**
   * The email of the account owner that makes the transaction.
   */
  @visibility(Lifecycle.Read)
  accountOwnerEmail?: string;

  /**
   * The department name.
   */
  @visibility(Lifecycle.Read)
  departmentName?: string;

  /**
   * The cost center of this department if it is a department and a cost center is provided.
   */
  @visibility(Lifecycle.Read)
  costCenter?: string;

  /**
   * The current enrollment.
   */
  @visibility(Lifecycle.Read)
  currentEnrollment?: string;

  /**
   * The billing frequency, which can be either one-time or recurring.
   */
  @visibility(Lifecycle.Read)
  billingFrequency?: string;

  /**
   * The billing month(yyyyMMdd), on which the event initiated.
   */
  @visibility(Lifecycle.Read)
  billingMonth?: int32;

  /**
   * The monetary commitment amount at the enrollment scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  monetaryCommitment?: decimal;

  /**
   * The overage amount at the enrollment scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  overage?: decimal;
}

/**
 * Modern Reservation transaction resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ModernReservationTransaction
  extends Azure.ResourceManager.Foundations.Resource {
  /**
   * The properties of a modern reservation transaction.
   */
  properties: ModernReservationTransactionProperties;

  /**
   * Resource tags.
   */
  @visibility(Lifecycle.Read)
  tags?: string[];
}

/**
 * The properties of a modern reservation transaction.
 */
model ModernReservationTransactionProperties {
  /**
   * The charge of the transaction.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  amount?: decimal;

  /**
   * This is the ARM Sku name. It can be used to join with the serviceType field in additional info in usage records.
   */
  @visibility(Lifecycle.Read)
  armSkuName?: string;

  /**
   * The billing frequency, which can be either one-time or recurring.
   */
  @visibility(Lifecycle.Read)
  billingFrequency?: string;

  /**
   * Billing profile Id.
   */
  @visibility(Lifecycle.Read)
  billingProfileId?: string;

  /**
   * Billing profile name.
   */
  @visibility(Lifecycle.Read)
  billingProfileName?: string;

  /**
   * The ISO currency in which the transaction is charged, for example, USD.
   */
  @visibility(Lifecycle.Read)
  currency?: string;

  /**
   * The description of the transaction.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * The date of the transaction
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  eventDate?: utcDateTime;

  /**
   * The type of the transaction (Purchase, Cancel or Refund).
   */
  @visibility(Lifecycle.Read)
  eventType?: string;

  /**
   * Invoice Number
   */
  @visibility(Lifecycle.Read)
  invoice?: string;

  /**
   * Invoice Id as on the invoice where the specific transaction appears.
   */
  @visibility(Lifecycle.Read)
  invoiceId?: string;

  /**
   * Invoice Section Id
   */
  @visibility(Lifecycle.Read)
  invoiceSectionId?: string;

  /**
   * Invoice Section Name.
   */
  @visibility(Lifecycle.Read)
  invoiceSectionName?: string;

  /**
   * The subscription guid that makes the transaction.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  purchasingSubscriptionGuid?: string;

  /**
   * The subscription name that makes the transaction.
   */
  @visibility(Lifecycle.Read)
  purchasingSubscriptionName?: string;

  /**
   * The quantity of the transaction.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  quantity?: decimal;

  /**
   * The region of the transaction.
   */
  @visibility(Lifecycle.Read)
  region?: string;

  /**
   * The reservation order ID is the identifier for a reservation purchase. Each reservation order ID represents a single purchase transaction. A reservation order contains reservations. The reservation order specifies the VM size and region for the reservations.
   */
  @visibility(Lifecycle.Read)
  reservationOrderId?: string;

  /**
   * The name of the reservation order.
   */
  @visibility(Lifecycle.Read)
  reservationOrderName?: string;

  /**
   * This is the term of the transaction.
   */
  @visibility(Lifecycle.Read)
  term?: string;
}

/**
 * price sheet result. It contains the pricesheet associated with billing period
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PriceSheetModel {
  /**
   * Price sheet
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["meterId"])
  pricesheets?: PriceSheetProperties[];

  /**
   * The link (url) to the next page of results.
   */
  @visibility(Lifecycle.Read)
  nextLink?: string;

  /**
   * Pricesheet download details.
   */
  @visibility(Lifecycle.Read)
  download?: MeterDetails;
}

/**
 * The properties of the price sheet.
 */
model PriceSheetProperties {
  /**
   * The id of the billing period resource that the usage belongs to.
   */
  @visibility(Lifecycle.Read)
  billingPeriodId?: string;

  /**
   * The meter id (GUID)
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  meterId?: string;

  /**
   * The details about the meter. By default this is not populated, unless it's specified in $expand.
   */
  @visibility(Lifecycle.Read)
  meterDetails?: MeterDetails;

  /**
   * Unit of measure
   */
  @visibility(Lifecycle.Read)
  unitOfMeasure?: string;

  /**
   * Included quality for an offer
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  includedQuantity?: decimal;

  /**
   * Part Number
   */
  @visibility(Lifecycle.Read)
  partNumber?: string;

  /**
   * Unit Price
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  unitPrice?: decimal;

  /**
   * Currency Code
   */
  @visibility(Lifecycle.Read)
  currencyCode?: string;

  /**
   * Offer Id
   */
  @visibility(Lifecycle.Read)
  offerId?: string;

  /**
   * SavingsPlan Details
   */
  @visibility(Lifecycle.Read)
  savingsPlan?: SavingsPlan;
}

/**
 * The properties of the meter detail.
 */
model MeterDetails {
  /**
   * The name of the meter, within the given meter category
   */
  @visibility(Lifecycle.Read)
  meterName?: string;

  /**
   * The category of the meter, for example, 'Cloud services', 'Networking', etc..
   */
  @visibility(Lifecycle.Read)
  meterCategory?: string;

  /**
   * The subcategory of the meter, for example, 'A6 Cloud services', 'ExpressRoute (IXP)', etc..
   */
  @visibility(Lifecycle.Read)
  meterSubCategory?: string;

  /**
   * The unit in which the meter consumption is charged, for example, 'Hours', 'GB', etc.
   */
  @visibility(Lifecycle.Read)
  unit?: string;

  /**
   * The location in which the Azure service is available.
   */
  @visibility(Lifecycle.Read)
  meterLocation?: string;

  /**
   * The total included quantity associated with the offer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  totalIncludedQuantity?: decimal;

  /**
   * The pretax listing price.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  pretaxStandardRate?: decimal;

  /**
   * The name of the service.
   */
  @visibility(Lifecycle.Read)
  serviceName?: string;

  /**
   * The service tier.
   */
  @visibility(Lifecycle.Read)
  serviceTier?: string;
}

/**
 * The properties of the SavingsPlan.
 */
model SavingsPlan {
  /**
   * SavingsPlan term
   */
  @visibility(Lifecycle.Read)
  term?: string;

  /**
   * SavingsPlan Market Price
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  marketPrice?: decimal;

  /**
   * SavingsPlan Effective Price
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  effectivePrice?: decimal;
}

/**
 * A Consumption REST API operation.
 */
model Operation {
  /**
   * Operation Id.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Operation name: {provider}/{resource}/{operation}.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The object that represents the operation.
   */
  display?: OperationDisplay;
}

/**
 * The object that represents the operation.
 */
model OperationDisplay {
  /**
   * Service provider: Microsoft.Consumption.
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /**
   * Resource on which the operation is performed: UsageDetail, etc.
   */
  @visibility(Lifecycle.Read)
  resource?: string;

  /**
   * Operation type: Read, write, delete, etc.
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * Description of the operation.
   */
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * A management group aggregated cost resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ManagementGroupAggregatedCostResult
  extends Azure.ResourceManager.Foundations.Resource {
  /**
   * The properties of the Management Group Aggregated Cost.
   */
  properties?: ManagementGroupAggregatedCostProperties;

  /**
   * The etag for the resource.
   */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  tags?: Record<string>;
}

/**
 * The properties of the Management Group Aggregated Cost.
 */
model ManagementGroupAggregatedCostProperties {
  /**
   * The id of the billing period resource that the aggregated cost belongs to.
   */
  @visibility(Lifecycle.Read)
  billingPeriodId?: string;

  /**
   * The start of the date time range covered by aggregated cost.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  usageStart?: utcDateTime;

  /**
   * The end of the date time range covered by the aggregated cost.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  usageEnd?: utcDateTime;

  /**
   * Azure Charges.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  azureCharges?: decimal;

  /**
   * Marketplace Charges.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  marketplaceCharges?: decimal;

  /**
   * Charges Billed Separately.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  chargesBilledSeparately?: decimal;

  /**
   * The ISO currency in which the meter is charged, for example, USD.
   */
  @visibility(Lifecycle.Read)
  currency?: string;

  /**
   * Children of a management group
   */
  children?: ManagementGroupAggregatedCostResult[];

  /**
   * List of subscription Guids included in the calculation of aggregated cost
   */
  includedSubscriptions?: string[];

  /**
   * List of subscription Guids excluded from the calculation of aggregated cost
   */
  excludedSubscriptions?: string[];
}

/**
 * Result of listing event summary.
 */
model Events {
  /**
   * The list of event summary.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: EventSummary[];

  /**
   * The link (url) to the next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * An event summary resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model EventSummary extends Azure.ResourceManager.Foundations.ProxyResource {
  /**
   * The event properties.
   */
  properties?: EventProperties;

  /**
   * The eTag for the resource.
   */
  @visibility(Lifecycle.Read)
  eTag?: string;
}

/**
 * The event properties.
 */
model EventProperties {
  /**
   * The date of the event.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  transactionDate?: utcDateTime;

  /**
   * The description of the event.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * The amount of new credit or commitment for NewCredit or SettleCharges event.
   */
  @visibility(Lifecycle.Read)
  newCredit?: Amount;

  /**
   * The amount of balance adjustment. The property is not available for ConsumptionCommitment lots.
   */
  @visibility(Lifecycle.Read)
  adjustments?: Amount;

  /**
   * The amount of expired credit or commitment for NewCredit or SettleCharges event.
   */
  @visibility(Lifecycle.Read)
  creditExpired?: Amount;

  /**
   * The amount of charges for events of type SettleCharges and PendingEligibleCharges.
   */
  @visibility(Lifecycle.Read)
  charges?: Amount;

  /**
   * The balance after the event, Note: This will not be returned for Contributor Organization Type in Multi-Entity consumption commitment
   */
  @visibility(Lifecycle.Read)
  closedBalance?: Amount;

  /**
   * Identifier of the billing account.
   */
  @visibility(Lifecycle.Read)
  billingAccountId?: string;

  /**
   * Name of the billing account.
   */
  @visibility(Lifecycle.Read)
  billingAccountDisplayName?: string;

  /**
   * Identifies the type of the event.
   */
  eventType?: EventType;

  /**
   * The number which uniquely identifies the invoice on which the event was billed. This will be empty for unbilled events.
   */
  @visibility(Lifecycle.Read)
  invoiceNumber?: string;

  /**
   * The ID that uniquely identifies the billing profile for which the event happened. The property is only available for billing account of type MicrosoftCustomerAgreement.
   */
  @visibility(Lifecycle.Read)
  billingProfileId?: string;

  /**
   * The display name of the billing profile for which the event happened. The property is only available for billing account of type MicrosoftCustomerAgreement.
   */
  @visibility(Lifecycle.Read)
  billingProfileDisplayName?: string;

  /**
   * The ID that uniquely identifies the lot for which the event happened.
   */
  @visibility(Lifecycle.Read)
  lotId?: string;

  /**
   * Identifies the source of the lot for which the event happened.
   */
  @visibility(Lifecycle.Read)
  lotSource?: string;

  /**
   * Amount of canceled credit.
   */
  @visibility(Lifecycle.Read)
  canceledCredit?: Amount;

  /**
   * The credit currency of the event.
   */
  @visibility(Lifecycle.Read)
  creditCurrency?: string;

  /**
   * The billing currency of the event.
   */
  @visibility(Lifecycle.Read)
  billingCurrency?: string;

  /**
   * The reseller of the event.
   */
  @visibility(Lifecycle.Read)
  reseller?: Reseller;

  /**
   * The amount of expired credit or commitment for NewCredit or SettleCharges event in billing currency.
   */
  @visibility(Lifecycle.Read)
  creditExpiredInBillingCurrency?: AmountWithExchangeRate;

  /**
   * The amount of new credit or commitment for NewCredit or SettleCharges event in billing currency.
   */
  @visibility(Lifecycle.Read)
  newCreditInBillingCurrency?: AmountWithExchangeRate;

  /**
   * The amount of balance adjustment in billing currency.
   */
  @visibility(Lifecycle.Read)
  adjustmentsInBillingCurrency?: AmountWithExchangeRate;

  /**
   * The amount of charges for events of type SettleCharges and PendingEligibleCharges in billing currency.
   */
  @visibility(Lifecycle.Read)
  chargesInBillingCurrency?: AmountWithExchangeRate;

  /**
   * The balance in billing currency after the event, Note: This will not be returned for Contributor Organization Type in Multi-Entity consumption commitment
   */
  @visibility(Lifecycle.Read)
  closedBalanceInBillingCurrency?: AmountWithExchangeRate;

  /**
   * If true, the listed details are based on an estimation and it will be subjected to change.
   */
  @visibility(Lifecycle.Read)
  isEstimatedBalance?: boolean;

  /**
   * The eTag for the resource.
   */
  @visibility(Lifecycle.Read)
  eTag?: string;
}

/**
 * The amount plus currency .
 */
model Amount {
  /**
   * Amount currency.
   */
  @visibility(Lifecycle.Read)
  currency?: string;

  /**
   * Amount.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  value?: decimal;
}

/**
 * The reseller properties.
 */
model Reseller {
  /**
   * The reseller property ID.
   */
  @visibility(Lifecycle.Read)
  resellerId?: string;

  /**
   * The reseller property description.
   */
  @visibility(Lifecycle.Read)
  resellerDescription?: string;
}

/**
 * The amount with exchange rate.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AmountWithExchangeRate extends Amount {
  /**
   * The exchange rate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  exchangeRate?: decimal;

  /**
   * The exchange rate month.
   */
  @visibility(Lifecycle.Read)
  exchangeRateMonth?: int32;
}

/**
 * Result of listing lot summary.
 */
model Lots {
  /**
   * The list of lot summary.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: LotSummary[];

  /**
   * URL to get the next set of operation list results if there are any.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * A lot summary resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LotSummary extends Azure.ResourceManager.Foundations.ProxyResource {
  /**
   * The lot properties.
   */
  properties?: LotProperties;

  /**
   * eTag of the resource. To handle concurrent update scenario, this field will be used to determine whether the user is updating the latest version or not.
   */
  eTag?: string;
}

/**
 * The lot properties.
 */
model LotProperties {
  /**
   * The original amount of a lot, Note: This will not be returned for Contributor Organization Type in Multi-Entity consumption commitment
   */
  @visibility(Lifecycle.Read)
  originalAmount?: Amount;

  /**
   * The balance as of the last invoice.
   */
  @visibility(Lifecycle.Read)
  closedBalance?: Amount;

  /**
   * The source of the lot.
   */
  @visibility(Lifecycle.Read)
  source?: LotSource;

  /**
   * The date when the lot became effective.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDate?: utcDateTime;

  /**
   * The expiration date of a lot.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDate?: utcDateTime;

  /**
   * The po number of the invoice on which the lot was added. This property is not available for ConsumptionCommitment lots.
   */
  @visibility(Lifecycle.Read)
  poNumber?: string;

  /**
   * The date when the lot was added.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  purchasedDate?: utcDateTime;

  /**
   * The status of the lot.
   */
  @visibility(Lifecycle.Read)
  status?: Status;

  /**
   * The currency of the lot.
   */
  @visibility(Lifecycle.Read)
  creditCurrency?: string;

  /**
   * The billing currency of the lot.
   */
  @visibility(Lifecycle.Read)
  billingCurrency?: string;

  /**
   * The original amount of a lot in billing currency,  Note: This will not be returned for Contributor Organization Type in Multi-Entity consumption commitment
   */
  @visibility(Lifecycle.Read)
  originalAmountInBillingCurrency?: AmountWithExchangeRate;

  /**
   * The balance as of the last invoice in billing currency.
   */
  @visibility(Lifecycle.Read)
  closedBalanceInBillingCurrency?: AmountWithExchangeRate;

  /**
   * The reseller of the lot.
   */
  @visibility(Lifecycle.Read)
  reseller?: Reseller;

  /**
   * If true, the listed details are based on an estimation and it will be subjected to change.
   */
  @visibility(Lifecycle.Read)
  isEstimatedBalance?: boolean;

  /**
   * The eTag for the resource.
   */
  @visibility(Lifecycle.Read)
  eTag?: string;

  /**
   * The organization type of the lot.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  OrganizationType?: OrganizationType;

  /**
   * Amount consumed from the commitment.
   */
  @visibility(Lifecycle.Read)
  usedAmount?: Amount;
}

/**
 * The properties of the credit summary.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CreditSummaryProperties {
  /**
   * Summary of balances associated with this credit summary.
   */
  @visibility(Lifecycle.Read)
  balanceSummary?: CreditBalanceSummary;

  /**
   * Pending credit adjustments.
   */
  @visibility(Lifecycle.Read)
  pendingCreditAdjustments?: Amount;

  /**
   * Expired credit.
   */
  @visibility(Lifecycle.Read)
  expiredCredit?: Amount;

  /**
   * Pending eligible charges.
   */
  @visibility(Lifecycle.Read)
  pendingEligibleCharges?: Amount;

  /**
   * The credit currency.
   */
  @visibility(Lifecycle.Read)
  creditCurrency?: string;

  /**
   * The billing currency.
   */
  @visibility(Lifecycle.Read)
  billingCurrency?: string;

  /**
   * Credit's reseller.
   */
  @visibility(Lifecycle.Read)
  reseller?: Reseller;

  /**
   * If true, the listed details are based on an estimation and it will be subjected to change.
   */
  @visibility(Lifecycle.Read)
  isEstimatedBalance?: boolean;

  /**
   * The eTag for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  eTag?: string;
}

/**
 * Summary of credit balances.
 */
model CreditBalanceSummary {
  /**
   * Estimated balance.
   */
  @visibility(Lifecycle.Read)
  estimatedBalance?: Amount;

  /**
   * Current balance.
   */
  @visibility(Lifecycle.Read)
  currentBalance?: Amount;

  /**
   * Estimated balance in billing currency.
   */
  @visibility(Lifecycle.Read)
  estimatedBalanceInBillingCurrency?: AmountWithExchangeRate;
}

/**
 * Legacy usage detail.
 */
model LegacyUsageDetail extends UsageDetail {
  /**
   * Properties for legacy usage details
   */
  properties: LegacyUsageDetailProperties;

  /**
   * Specifies the kind of usage details.
   */
  kind: "legacy";
}

/**
 * The properties of the legacy usage detail.
 */
model LegacyUsageDetailProperties {
  /**
   * Billing Account identifier.
   */
  @visibility(Lifecycle.Read)
  billingAccountId?: string;

  /**
   * Billing Account Name.
   */
  @visibility(Lifecycle.Read)
  billingAccountName?: string;

  /**
   * The billing period start date.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  billingPeriodStartDate?: utcDateTime;

  /**
   * The billing period end date.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  billingPeriodEndDate?: utcDateTime;

  /**
   * Billing Profile identifier.
   */
  @visibility(Lifecycle.Read)
  billingProfileId?: string;

  /**
   * Billing Profile Name.
   */
  @visibility(Lifecycle.Read)
  billingProfileName?: string;

  /**
   * Account Owner Id.
   */
  @visibility(Lifecycle.Read)
  accountOwnerId?: string;

  /**
   * Account Name.
   */
  @visibility(Lifecycle.Read)
  accountName?: string;

  /**
   * Subscription guid.
   */
  @visibility(Lifecycle.Read)
  subscriptionId?: string;

  /**
   * Subscription name.
   */
  @visibility(Lifecycle.Read)
  subscriptionName?: string;

  /**
   * Date for the usage record.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  date?: utcDateTime;

  /**
   * Product name for the consumed service or purchase. Not available for Marketplace.
   */
  @visibility(Lifecycle.Read)
  product?: string;

  /**
   * Part Number of the service used. Can be used to join with the price sheet. Not available for marketplace.
   */
  @visibility(Lifecycle.Read)
  partNumber?: string;

  /**
   * The meter id (GUID). Not available for marketplace. For reserved instance this represents the primary meter for which the reservation was purchased. For the actual VM Size for which the reservation is purchased see productOrderName.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  meterId?: string;

  /**
   * The details about the meter. By default this is not populated, unless it's specified in $expand.
   */
  @visibility(Lifecycle.Read)
  meterDetails?: MeterDetailsResponse;

  /**
   * The usage quantity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  quantity?: decimal;

  /**
   * Effective Price that's charged for the usage.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  effectivePrice?: decimal;

  /**
   * The amount of cost before tax.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  cost?: decimal;

  /**
   * Unit Price is the price applicable to you. (your EA or other contract price).
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  unitPrice?: decimal;

  /**
   * Billing Currency.
   */
  @visibility(Lifecycle.Read)
  billingCurrency?: string;

  /**
   * Resource Location.
   */
  @visibility(Lifecycle.Read)
  resourceLocation?: string;

  /**
   * Consumed service name. Name of the azure resource provider that emits the usage or was purchased. This value is not provided for marketplace usage.
   */
  @visibility(Lifecycle.Read)
  consumedService?: string;

  /**
   * Unique identifier of the Azure Resource Manager usage detail resource.
   */
  @visibility(Lifecycle.Read)
  resourceId?: string;

  /**
   * Resource Name.
   */
  @visibility(Lifecycle.Read)
  resourceName?: string;

  /**
   * Service-specific metadata.
   */
  @visibility(Lifecycle.Read)
  serviceInfo1?: string;

  /**
   * Legacy field with optional service-specific metadata.
   */
  @visibility(Lifecycle.Read)
  serviceInfo2?: string;

  /**
   * Additional details of this usage item. By default this is not populated, unless it's specified in $expand. Use this field to get usage line item specific details such as the actual VM Size (ServiceType) or the ratio in which the reservation discount is applied.
   */
  @visibility(Lifecycle.Read)
  additionalInfo?: string;

  /**
   * Invoice Section Name.
   */
  @visibility(Lifecycle.Read)
  invoiceSection?: string;

  /**
   * The cost center of this department if it is a department and a cost center is provided.
   */
  @visibility(Lifecycle.Read)
  costCenter?: string;

  /**
   * Resource Group Name.
   */
  @visibility(Lifecycle.Read)
  resourceGroup?: string;

  /**
   * ARM resource id of the reservation. Only applies to records relevant to reservations.
   */
  @visibility(Lifecycle.Read)
  reservationId?: string;

  /**
   * User provided display name of the reservation. Last known name for a particular day is populated in the daily data. Only applies to records relevant to reservations.
   */
  @visibility(Lifecycle.Read)
  reservationName?: string;

  /**
   * Product Order Id. For reservations this is the Reservation Order ID.
   */
  @visibility(Lifecycle.Read)
  productOrderId?: string;

  /**
   * Product Order Name. For reservations this is the SKU that was purchased.
   */
  @visibility(Lifecycle.Read)
  productOrderName?: string;

  /**
   * Offer Id. Ex: MS-AZR-0017P, MS-AZR-0148P.
   */
  @visibility(Lifecycle.Read)
  offerId?: string;

  /**
   * Is Azure Credit Eligible.
   */
  @visibility(Lifecycle.Read)
  isAzureCreditEligible?: boolean;

  /**
   * Term (in months). 1 month for monthly recurring purchase. 12 months for a 1 year reservation. 36 months for a 3 year reservation.
   */
  @visibility(Lifecycle.Read)
  term?: string;

  /**
   * Publisher Name.
   */
  @visibility(Lifecycle.Read)
  publisherName?: string;

  /**
   * Publisher Type.
   */
  @visibility(Lifecycle.Read)
  publisherType?: string;

  /**
   * Plan Name.
   */
  @visibility(Lifecycle.Read)
  planName?: string;

  /**
   * Indicates a charge represents credits, usage, a Marketplace purchase, a reservation fee, or a refund.
   */
  @visibility(Lifecycle.Read)
  chargeType?: string;

  /**
   * Indicates how frequently this charge will occur. OneTime for purchases which only happen once, Monthly for fees which recur every month, and UsageBased for charges based on how much a service is used.
   */
  @visibility(Lifecycle.Read)
  frequency?: string;

  /**
   * Retail price for the resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  payGPrice?: decimal;

  /**
   * Unique identifier for the applicable benefit.
   */
  @visibility(Lifecycle.Read)
  benefitId?: string;

  /**
   * Name of the applicable benefit.
   */
  @visibility(Lifecycle.Read)
  benefitName?: string;

  /**
   * Identifier that indicates how the meter is priced.
   */
  @visibility(Lifecycle.Read)
  pricingModel?: PricingModelType;
}

/**
 * The properties of the meter detail.
 */
model MeterDetailsResponse {
  /**
   * The name of the meter, within the given meter category
   */
  @visibility(Lifecycle.Read)
  meterName?: string;

  /**
   * The category of the meter, for example, 'Cloud services', 'Networking', etc..
   */
  @visibility(Lifecycle.Read)
  meterCategory?: string;

  /**
   * The subcategory of the meter, for example, 'A6 Cloud services', 'ExpressRoute (IXP)', etc..
   */
  @visibility(Lifecycle.Read)
  meterSubCategory?: string;

  /**
   * The unit in which the meter consumption is charged, for example, 'Hours', 'GB', etc.
   */
  @visibility(Lifecycle.Read)
  unitOfMeasure?: string;

  /**
   * The service family.
   */
  @visibility(Lifecycle.Read)
  serviceFamily?: string;
}

/**
 * Modern usage detail.
 */
model ModernUsageDetail extends UsageDetail {
  /**
   * Properties for modern usage details
   */
  properties: ModernUsageDetailProperties;

  /**
   * Specifies the kind of usage details.
   */
  kind: "modern";
}

/**
 * The properties of the usage detail.
 */
model ModernUsageDetailProperties {
  /**
   * Billing Account identifier.
   */
  @visibility(Lifecycle.Read)
  billingAccountId?: string;

  /**
   * Effective Price that's charged for the usage.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  effectivePrice?: decimal;

  /**
   * Identifier that indicates how the meter is priced
   */
  @visibility(Lifecycle.Read)
  pricingModel?: PricingModelType;

  /**
   * Name of the Billing Account.
   */
  @visibility(Lifecycle.Read)
  billingAccountName?: string;

  /**
   * Billing Period Start Date as in the invoice.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  billingPeriodStartDate?: utcDateTime;

  /**
   * Billing Period End Date as in the invoice.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  billingPeriodEndDate?: utcDateTime;

  /**
   * Identifier for the billing profile that groups costs across invoices in the a singular billing currency across across the customers who have onboarded the Microsoft customer agreement and the customers in CSP who have made entitlement purchases like SaaS, Marketplace, RI, etc.
   */
  @visibility(Lifecycle.Read)
  billingProfileId?: string;

  /**
   * Name of the billing profile that groups costs across invoices in the a singular billing currency across across the customers who have onboarded the Microsoft customer agreement and the customers in CSP who have made entitlement purchases like SaaS, Marketplace, RI, etc.
   */
  @visibility(Lifecycle.Read)
  billingProfileName?: string;

  /**
   * Unique Microsoft generated identifier for the Azure Subscription.
   */
  @visibility(Lifecycle.Read)
  subscriptionGuid?: string;

  /**
   * Name of the Azure Subscription.
   */
  @visibility(Lifecycle.Read)
  subscriptionName?: string;

  /**
   * Date for the usage record.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  date?: utcDateTime;

  /**
   * Name of the product that has accrued charges by consumption or purchase as listed in the invoice. Not available for Marketplace.
   */
  @visibility(Lifecycle.Read)
  product?: string;

  /**
   * The meter id (GUID). Not available for marketplace. For reserved instance this represents the primary meter for which the reservation was purchased. For the actual VM Size for which the reservation is purchased see productOrderName.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  meterId?: string;

  /**
   * Identifies the name of the meter against which consumption is measured.
   */
  @visibility(Lifecycle.Read)
  meterName?: string;

  /**
   * Identifies the location of the datacenter for certain services that are priced based on datacenter location.
   */
  @visibility(Lifecycle.Read)
  meterRegion?: string;

  /**
   * Identifies the top-level service for the usage.
   */
  @visibility(Lifecycle.Read)
  meterCategory?: string;

  /**
   * Defines the type or sub-category of Azure service that can affect the rate.
   */
  @visibility(Lifecycle.Read)
  meterSubCategory?: string;

  /**
   * List the service family for the product purchased or charged (Example: Storage ; Compute).
   */
  @visibility(Lifecycle.Read)
  serviceFamily?: string;

  /**
   * Measure the quantity purchased or consumed.The amount of the meter used during the billing period.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  quantity?: decimal;

  /**
   * Identifies the Unit that the service is charged in. For example, GB, hours, 10,000 s.
   */
  @visibility(Lifecycle.Read)
  unitOfMeasure?: string;

  /**
   * Instance Name.
   */
  @visibility(Lifecycle.Read)
  instanceName?: string;

  /**
   * Estimated extendedCost or blended cost before tax in USD.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  costInUSD?: decimal;

  /**
   * Unit Price is the price applicable to you. (your EA or other contract price).
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  unitPrice?: decimal;

  /**
   * The currency defining the billed cost.
   */
  @visibility(Lifecycle.Read)
  billingCurrencyCode?: string;

  /**
   * Name of the resource location.
   */
  @visibility(Lifecycle.Read)
  resourceLocation?: string;

  /**
   * Consumed service name. Name of the azure resource provider that emits the usage or was purchased. This value is not provided for marketplace usage.
   */
  @visibility(Lifecycle.Read)
  consumedService?: string;

  /**
   * Service-specific metadata.
   */
  @visibility(Lifecycle.Read)
  serviceInfo1?: string;

  /**
   * Legacy field with optional service-specific metadata.
   */
  @visibility(Lifecycle.Read)
  serviceInfo2?: string;

  /**
   * Additional details of this usage item. Use this field to get usage line item specific details such as the actual VM Size (ServiceType) or the ratio in which the reservation discount is applied.
   */
  @visibility(Lifecycle.Read)
  additionalInfo?: string;

  /**
   * Identifier of the project that is being charged in the invoice. Not applicable for Microsoft Customer Agreements onboarded by partners.
   */
  @visibility(Lifecycle.Read)
  invoiceSectionId?: string;

  /**
   * Name of the project that is being charged in the invoice. Not applicable for Microsoft Customer Agreements onboarded by partners.
   */
  @visibility(Lifecycle.Read)
  invoiceSectionName?: string;

  /**
   * The cost center of this department if it is a department and a cost center is provided.
   */
  @visibility(Lifecycle.Read)
  costCenter?: string;

  /**
   * Name of the Azure resource group used for cohesive lifecycle management of resources.
   */
  @visibility(Lifecycle.Read)
  resourceGroup?: string;

  /**
   * ARM resource id of the reservation. Only applies to records relevant to reservations.
   */
  @visibility(Lifecycle.Read)
  reservationId?: string;

  /**
   * User provided display name of the reservation. Last known name for a particular day is populated in the daily data. Only applies to records relevant to reservations.
   */
  @visibility(Lifecycle.Read)
  reservationName?: string;

  /**
   * The identifier for the asset or Azure plan name that the subscription belongs to. For example: Azure Plan. For reservations this is the Reservation Order ID.
   */
  @visibility(Lifecycle.Read)
  productOrderId?: string;

  /**
   * Product Order Name. For reservations this is the SKU that was purchased.
   */
  @visibility(Lifecycle.Read)
  productOrderName?: string;

  /**
   * Determines if the cost is eligible to be paid for using Azure credits.
   */
  @visibility(Lifecycle.Read)
  isAzureCreditEligible?: boolean;

  /**
   * Term (in months). Displays the term for the validity of the offer. For example. In case of reserved instances it displays 12 months for yearly term of reserved instance. For one time purchases or recurring purchases, the terms displays 1 month; This is not applicable for Azure consumption.
   */
  @visibility(Lifecycle.Read)
  term?: string;

  /**
   * Name of the publisher of the service including Microsoft or Third Party publishers.
   */
  @visibility(Lifecycle.Read)
  publisherName?: string;

  /**
   * Type of publisher that identifies if the publisher is first party, third party reseller or third party agency.
   */
  @visibility(Lifecycle.Read)
  publisherType?: string;

  /**
   * Indicates a charge represents credits, usage, a Marketplace purchase, a reservation fee, or a refund.
   */
  @visibility(Lifecycle.Read)
  chargeType?: string;

  /**
   * Indicates how frequently this charge will occur. OneTime for purchases which only happen once, Monthly for fees which recur every month, and UsageBased for charges based on how much a service is used.
   */
  @visibility(Lifecycle.Read)
  frequency?: string;

  /**
   * ExtendedCost or blended cost before tax in billed currency.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  costInBillingCurrency?: decimal;

  /**
   * ExtendedCost or blended cost before tax in pricing currency to correlate with prices.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  costInPricingCurrency?: decimal;

  /**
   * Exchange rate used in conversion from pricing currency to billing currency.
   */
  @visibility(Lifecycle.Read)
  exchangeRate?: string;

  /**
   * Date on which exchange rate used in conversion from pricing currency to billing currency.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  exchangeRateDate?: utcDateTime;

  /**
   * Invoice ID as on the invoice where the specific transaction appears.
   */
  @visibility(Lifecycle.Read)
  invoiceId?: string;

  /**
   * Reference to an original invoice there is a refund (negative cost). This is populated only when there is a refund.
   */
  @visibility(Lifecycle.Read)
  previousInvoiceId?: string;

  /**
   * Pricing Billing Currency.
   */
  @visibility(Lifecycle.Read)
  pricingCurrencyCode?: string;

  /**
   * Identifier for the product that has accrued charges by consumption or purchase . This is the concatenated key of productId and SkuId in partner center.
   */
  @visibility(Lifecycle.Read)
  productIdentifier?: string;

  /**
   * Resource Location Normalized.
   */
  @visibility(Lifecycle.Read)
  resourceLocationNormalized?: string;

  /**
   * Start date for the rating period when the service usage was rated for charges. The prices for Azure services are determined for the rating period.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  servicePeriodStartDate?: utcDateTime;

  /**
   * End date for the period when the service usage was rated for charges. The prices for Azure services are determined based on the rating period.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  servicePeriodEndDate?: utcDateTime;

  /**
   * Identifier of the customer's AAD tenant.
   */
  @visibility(Lifecycle.Read)
  customerTenantId?: string;

  /**
   * Name of the customer's AAD tenant.
   */
  @visibility(Lifecycle.Read)
  customerName?: string;

  /**
   * Identifier for the partner's AAD tenant.
   */
  @visibility(Lifecycle.Read)
  partnerTenantId?: string;

  /**
   * Name of the partner' AAD tenant.
   */
  @visibility(Lifecycle.Read)
  partnerName?: string;

  /**
   * MPNId for the reseller associated with the subscription.
   */
  @visibility(Lifecycle.Read)
  resellerMpnId?: string;

  /**
   * Reseller Name.
   */
  @visibility(Lifecycle.Read)
  resellerName?: string;

  /**
   * Publisher Id.
   */
  @visibility(Lifecycle.Read)
  publisherId?: string;

  /**
   * Market Price that's charged for the usage.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  marketPrice?: decimal;

  /**
   * Exchange Rate from pricing currency to billing currency.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  exchangeRatePricingToBilling?: decimal;

  /**
   * The amount of PayG cost before tax in billing currency.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  paygCostInBillingCurrency?: decimal;

  /**
   * The amount of PayG cost before tax in US Dollar currency.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  paygCostInUSD?: decimal;

  /**
   * Rate of discount applied if there is a partner earned credit (PEC) based on partner admin link access.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  partnerEarnedCreditRate?: decimal;

  /**
   * Flag to indicate if partner earned credit has been applied or not.
   */
  @visibility(Lifecycle.Read)
  partnerEarnedCreditApplied?: string;

  /**
   * Retail price for the resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  payGPrice?: decimal;

  /**
   * Unique identifier for the applicable benefit.
   */
  @visibility(Lifecycle.Read)
  benefitId?: string;

  /**
   * Name of the applicable benefit.
   */
  @visibility(Lifecycle.Read)
  benefitName?: string;

  /**
   * Identifier for Product Category or Line Of Business, Ex - Azure, Microsoft 365, AWS e.t.c
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /**
   * Name for Cost Allocation Rule.
   */
  @visibility(Lifecycle.Read)
  costAllocationRuleName?: string;
}

/**
 * Legacy reservation recommendation.
 */
model LegacyReservationRecommendation extends ReservationRecommendation {
  /**
   * Properties for legacy reservation recommendation
   */
  properties: LegacyReservationRecommendationProperties;

  /**
   * Specifies the kind of reservation recommendation.
   */
  kind: "legacy";
}

/**
 * The properties of the reservation recommendation.
 */
@discriminator("scope")
model LegacyReservationRecommendationProperties {
  /**
   * The number of days of usage to look back for recommendation.
   */
  @visibility(Lifecycle.Read)
  lookBackPeriod?: string;

  /**
   * The instance Flexibility Ratio.
   */
  @visibility(Lifecycle.Read)
  instanceFlexibilityRatio?: float32;

  /**
   * The instance Flexibility Group.
   */
  @visibility(Lifecycle.Read)
  instanceFlexibilityGroup?: string;

  /**
   * The normalized Size.
   */
  @visibility(Lifecycle.Read)
  normalizedSize?: string;

  /**
   * The recommended Quantity Normalized.
   */
  @visibility(Lifecycle.Read)
  recommendedQuantityNormalized?: float32;

  /**
   * The meter id (GUID)
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  meterId?: string;

  /**
   * The azure resource type.
   */
  @visibility(Lifecycle.Read)
  resourceType?: string;

  /**
   * Term period of the reservation. ex: P1M, P1Y or P3Y.
   */
  @visibility(Lifecycle.Read)
  term?: string;

  /**
   * The total amount of cost without reserved instances.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  costWithNoReservedInstances?: decimal;

  /**
   * Recommended quality for reserved instances.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  recommendedQuantity?: decimal;

  /**
   * The total amount of cost with reserved instances.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  totalCostWithReservedInstances?: decimal;

  /**
   * Total estimated savings with reserved instances.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  netSavings?: decimal;

  /**
   * The usage date for looking back.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  firstUsageDate?: utcDateTime;

  /**
   * Shared or single recommendation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  scope: string;

  /**
   * List of sku properties
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  skuProperties?: SkuProperty[];

  /**
   * The last usage date used for looking back for computing the recommendation.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUsageDate?: utcDateTime;

  /**
   * The total hours for which the cost is covered.
   */
  @visibility(Lifecycle.Read)
  totalHours?: int32;
}

/**
 * The Sku property
 */
model SkuProperty {
  /**
   * The name of sku property.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The value of sku property.
   */
  @visibility(Lifecycle.Read)
  value?: string;
}

/**
 * The properties of the legacy reservation recommendation for single scope.
 */
model LegacySingleScopeReservationRecommendationProperties
  extends LegacyReservationRecommendationProperties {
  /**
   * Subscription id associated with single scoped recommendation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  subscriptionId?: string;

  /**
   * Shared or single recommendation.
   */
  scope: "Single";
}

/**
 * The properties of the legacy reservation recommendation for shared scope.
 */
model LegacySharedScopeReservationRecommendationProperties
  extends LegacyReservationRecommendationProperties {
  /**
   * Shared or single recommendation.
   */
  scope: "Shared";
}

/**
 * Modern reservation recommendation.
 */
model ModernReservationRecommendation extends ReservationRecommendation {
  /**
   * Properties for modern reservation recommendation
   */
  properties: ModernReservationRecommendationProperties;

  /**
   * Specifies the kind of reservation recommendation.
   */
  kind: "modern";
}

/**
 * The properties of the reservation recommendation.
 */
@discriminator("scope")
model ModernReservationRecommendationProperties {
  /**
   * Resource Location.
   */
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * The number of days of usage to look back for recommendation.
   */
  @visibility(Lifecycle.Read)
  lookBackPeriod?: int32;

  /**
   * The instance Flexibility Ratio.
   */
  @visibility(Lifecycle.Read)
  instanceFlexibilityRatio?: float32;

  /**
   * The instance Flexibility Group.
   */
  @visibility(Lifecycle.Read)
  instanceFlexibilityGroup?: string;

  /**
   * The normalized Size.
   */
  @visibility(Lifecycle.Read)
  normalizedSize?: string;

  /**
   * The recommended Quantity Normalized.
   */
  @visibility(Lifecycle.Read)
  recommendedQuantityNormalized?: float32;

  /**
   * The meter id (GUID)
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  meterId?: string;

  /**
   * Term period of the reservation. ex: P1M, P1Y or P3Y.
   */
  @visibility(Lifecycle.Read)
  term?: string;

  /**
   * The total amount of cost without reserved instances.
   */
  @visibility(Lifecycle.Read)
  costWithNoReservedInstances?: Amount;

  /**
   * Recommended quality for reserved instances.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  recommendedQuantity?: decimal;

  /**
   * Resource type.
   */
  @visibility(Lifecycle.Read)
  resourceType?: string;

  /**
   * The total amount of cost with reserved instances.
   */
  @visibility(Lifecycle.Read)
  totalCostWithReservedInstances?: Amount;

  /**
   * Total estimated savings with reserved instances.
   */
  @visibility(Lifecycle.Read)
  netSavings?: Amount;

  /**
   * The usage date for looking back.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  firstUsageDate?: utcDateTime;

  /**
   * Shared or single recommendation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  scope: string;

  /**
   * List of sku properties
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  skuProperties?: SkuProperty[];

  /**
   * This is the ARM Sku name.
   */
  @visibility(Lifecycle.Read)
  skuName?: string;

  /**
   * The last usage date used for looking back for computing the recommendation.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUsageDate?: utcDateTime;

  /**
   * The total hours for which the cost is covered.
   */
  @visibility(Lifecycle.Read)
  totalHours?: int32;
}

/**
 * The properties of the modern reservation recommendation for single scope.
 */
model ModernSingleScopeReservationRecommendationProperties
  extends ModernReservationRecommendationProperties {
  /**
   * Subscription ID associated with single scoped recommendation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  subscriptionId?: string;

  /**
   * Shared or single recommendation.
   */
  scope: "Single";
}

/**
 * The properties of the modern reservation recommendation for shared scope.
 */
model ModernSharedScopeReservationRecommendationProperties
  extends ModernReservationRecommendationProperties {
  /**
   * Shared or single recommendation.
   */
  scope: "Shared";
}

/**
 * Legacy Reservation transaction resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LegacyReservationTransaction extends ReservationTransaction {
  /**
   * The properties of a legacy reservation transaction.
   */
  properties: LegacyReservationTransactionProperties;
}

/**
 * The properties of the price sheet download.
 */
model DownloadProperties {
  /**
   * The link (url) to download the pricesheet.
   */
  @visibility(Lifecycle.Read)
  downloadUrl?: string;

  /**
   * Download link validity.
   */
  @visibility(Lifecycle.Read)
  validTill?: string;
}

/**
 * Legacy charge summary.
 */
model LegacyChargeSummary extends ChargeSummary {
  /**
   * Properties for legacy charge summary
   */
  properties: LegacyChargeSummaryProperties;

  /**
   * Specifies the kind of charge summary.
   */
  kind: "legacy";
}

/**
 * The properties of legacy charge summary.
 */
model LegacyChargeSummaryProperties {
  /**
   * The id of the billing period resource that the charge belongs to.
   */
  @visibility(Lifecycle.Read)
  billingPeriodId?: string;

  /**
   * Usage start date.
   */
  @visibility(Lifecycle.Read)
  usageStart?: string;

  /**
   * Usage end date.
   */
  @visibility(Lifecycle.Read)
  usageEnd?: string;

  /**
   * Azure Charges.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  azureCharges?: decimal;

  /**
   * Charges Billed separately.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  chargesBilledSeparately?: decimal;

  /**
   * Marketplace Charges.
   */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  azureMarketplaceCharges?: decimal;

  /**
   * Currency Code
   */
  @visibility(Lifecycle.Read)
  currency?: string;
}

/**
 * Modern charge summary.
 */
model ModernChargeSummary extends ChargeSummary {
  /**
   * Properties for modern charge summary
   */
  properties: ModernChargeSummaryProperties;

  /**
   * Specifies the kind of charge summary.
   */
  kind: "modern";
}

/**
 * The properties of modern charge summary.
 */
model ModernChargeSummaryProperties {
  /**
   * The id of the billing period resource that the charge belongs to.
   */
  @visibility(Lifecycle.Read)
  billingPeriodId?: string;

  /**
   * Usage start date.
   */
  @visibility(Lifecycle.Read)
  usageStart?: string;

  /**
   * Usage end date.
   */
  @visibility(Lifecycle.Read)
  usageEnd?: string;

  /**
   * Azure Charges.
   */
  @visibility(Lifecycle.Read)
  azureCharges?: Amount;

  /**
   * Charges Billed separately.
   */
  @visibility(Lifecycle.Read)
  chargesBilledSeparately?: Amount;

  /**
   * Marketplace Charges.
   */
  @visibility(Lifecycle.Read)
  marketplaceCharges?: Amount;

  /**
   * Billing Account Id
   */
  @visibility(Lifecycle.Read)
  billingAccountId?: string;

  /**
   * Billing Profile Id
   */
  @visibility(Lifecycle.Read)
  billingProfileId?: string;

  /**
   * Invoice Section Id
   */
  @visibility(Lifecycle.Read)
  invoiceSectionId?: string;

  /**
   * Customer Id
   */
  @visibility(Lifecycle.Read)
  customerId?: string;

  /**
   * Is charge Invoiced
   */
  @visibility(Lifecycle.Read)
  isInvoiced?: boolean;

  /**
   * Subscription guid.
   */
  @visibility(Lifecycle.Read)
  subscriptionId?: string;
}

/**
 * Result of listing reservation details.
 */
model ReservationDetailsListResult {
  /**
   * The list of reservation details.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: ReservationDetail[];

  /**
   * The link (url) to the next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * Result of listing reservation recommendations.
 */
model ModernReservationTransactionsListResult {
  /**
   * The list of reservation recommendations.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: ModernReservationTransaction[];

  /**
   * The link (url) to the next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * Result of listing reservation recommendations.
 */
model ReservationTransactionsListResult {
  /**
   * The list of reservation recommendations.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: ReservationTransaction[];

  /**
   * The link (url) to the next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * Result of listing reservation summaries.
 */
model ReservationSummariesListResult {
  /**
   * The list of reservation summaries.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: ReservationSummary[];

  /**
   * The link (url) to the next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * Result of listing budgets. It contains a list of available budgets in the scope provided.
 */
model BudgetsListResult {
  /**
   * The list of budgets.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: Budget[];

  /**
   * The link (url) to the next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * Result of listing marketplaces. It contains a list of available marketplaces in reverse chronological order by billing period.
 */
model MarketplacesListResult {
  /**
   * The list of marketplaces.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: Marketplace[];

  /**
   * The link (url) to the next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * Result of listing reservation recommendations.
 */
model ReservationRecommendationsListResult {
  /**
   * The list of reservation recommendations.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: ReservationRecommendation[];

  /**
   * The link (url) to the next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;

  /**
   * The link (url) to the previous page of results.
   */
  @visibility(Lifecycle.Read)
  previousLink?: string;
}

/**
 * Result of listing usage details. It contains a list of available usage details in reverse chronological order by billing period.
 */
model UsageDetailsListResult {
  /**
   * The list of usage details.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: UsageDetail[];

  /**
   * The link (url) to the next page of results.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * Result of listing consumption operations. It contains a list of operations and a URL link to get the next set of results.
 */
model OperationListResult {
  /**
   * List of consumption operations supported by the Microsoft.Consumption resource provider.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: Operation[];

  /**
   * URL to get the next set of operation list results if there are any.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}
