import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.AlertsManagement;

/**
 * Indicates the type of scheduled query rule. The default is LogAlert.
 */
union Kind {
  string,

  /**
   * LogAlert
   */
  LogAlert: "LogAlert",

  /**
   * EventLogAlert
   */
  EventLogAlert: "EventLogAlert",

  /**
   * LogToMetric
   */
  LogToMetric: "LogToMetric",
}

/**
 * Severity of the alert. Should be an integer between [0-4]. Value of 0 is severest. Relevant and required only for rules of the kind LogAlert.
 */
union AlertSeverity {
  int64,

  /**
   * 0
   */
  `0`: 0,

  /**
   * 1
   */
  `1`: 1,

  /**
   * 2
   */
  `2`: 2,

  /**
   * 3
   */
  `3`: 3,

  /**
   * 4
   */
  `4`: 4,
}

/**
 * Specifies the type of threshold criteria
 */
union CriterionType {
  string,

  /**
   * StaticThresholdCriterion
   */
  StaticThresholdCriterion: "StaticThresholdCriterion",

  /**
   * DynamicThresholdCriterion
   */
  DynamicThresholdCriterion: "DynamicThresholdCriterion",
}

/**
 * Aggregation type. Relevant and required only for rules of the kind LogAlert.
 */
union TimeAggregation {
  string,

  /**
   * Count
   */
  Count: "Count",

  /**
   * Average
   */
  Average: "Average",

  /**
   * Minimum
   */
  Minimum: "Minimum",

  /**
   * Maximum
   */
  Maximum: "Maximum",

  /**
   * Total
   */
  Total: "Total",
}

/**
 * Operator for dimension values
 */
union DimensionOperator {
  string,

  /**
   * Include
   */
  Include: "Include",

  /**
   * Exclude
   */
  Exclude: "Exclude",
}

/**
 * The criteria operator. Relevant and required only for rules of the kind LogAlert.
 */
union ConditionOperator {
  string,

  /**
   * Equals
   */
  Equals: "Equals",

  /**
   * GreaterThan
   */
  GreaterThan: "GreaterThan",

  /**
   * GreaterThanOrEqual
   */
  GreaterThanOrEqual: "GreaterThanOrEqual",

  /**
   * LessThan
   */
  LessThan: "LessThan",

  /**
   * LessThanOrEqual
   */
  LessThanOrEqual: "LessThanOrEqual",

  /**
   * GreaterOrLessThan
   */
  GreaterOrLessThan: "GreaterOrLessThan",
}

/**
 * The state of the alert after the evaluation.
 */
union AlertState {
  string,

  /**
   * NoAlert
   */
  NoAlert: "NoAlert",

  /**
   * Fired
   */
  Fired: "Fired",

  /**
   * Firing
   */
  Firing: "Firing",

  /**
   * Resolving
   */
  Resolving: "Resolving",

  /**
   * Resolved
   */
  Resolved: "Resolved",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PreviewAlertRuleRequest {
  /**
   * The location of the rule resource.
   */
  location: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties: PreviewAlertRuleRequestProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PreviewAlertRuleRequestProperties {
  /**
   * Specifies the timespan of the preview in ISO 8601 duration format.
   */
  timespan: duration;

  /**
   * The properties of the alert rule to preview.
   */
  scheduledQueryRuleProperties?: LogAlertRuleResource;
}

/**
 * The scheduled query rule resource.
 */
model LogAlertRuleResource {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;

  /**
   * The geo-location where the resource lives
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: string;

  /**
   * Indicates the type of scheduled query rule. The default is LogAlert.
   */
  kind?: Kind;

  /**
   * The rule properties of the resource.
   */
  properties: LogAlertRuleProperties;
}

/**
 * scheduled query rule Definition
 */
model LogAlertRuleProperties {
  /**
   * The description of the scheduled query rule.
   */
  description?: string;

  /**
   * The display name of the alert rule
   */
  displayName?: string;

  /**
   * Severity of the alert. Should be an integer between [0-4]. Value of 0 is severest. Relevant and required only for rules of the kind LogAlert.
   */
  severity?: AlertSeverity;

  /**
   * The flag which indicates whether this scheduled query rule is enabled. Value should be true or false
   */
  enabled?: boolean;

  /**
   * The list of resource id's that this scheduled query rule is scoped to.
   */
  scopes?: string[];

  /**
   * How often the scheduled query rule is evaluated represented in ISO 8601 duration format. Relevant and required only for rules of the kind LogAlert.
   */
  evaluationFrequency?: duration;

  /**
   * The period of time (in ISO 8601 duration format) on which the Alert query will be executed (bin size). Relevant and required only for rules of the kind LogAlert.
   */
  windowSize?: duration;

  /**
   * If specified then overrides the query time range (default is WindowSize*NumberOfEvaluationPeriods). Relevant only for rules of the kind LogAlert.
   */
  overrideQueryTimeRange?: duration;

  /**
   * List of resource type of the target resource(s) on which the alert is created/updated. For example if the scope is a resource group and targetResourceTypes is Microsoft.Compute/virtualMachines, then a different alert will be fired for each virtual machine in the resource group which meet the alert criteria. Relevant only for rules of the kind LogAlert
   */
  targetResourceTypes?: string[];

  /**
   * The rule criteria that defines the conditions of the scheduled query rule.
   */
  criteria?: LogAlertRuleCriteria;
}

/**
 * The rule criteria that defines the conditions of the scheduled query rule.
 */
model LogAlertRuleCriteria {
  /**
   * A list of conditions to evaluate against the specified scopes
   */
  @identifiers(#[])
  allOf?: LogAlertRuleCondition[];
}

/**
 * A condition of the scheduled query rule.
 */
model LogAlertRuleCondition {
  /**
   * Specifies the type of threshold criteria
   */
  criterionType?: CriterionType;

  /**
   * KQL log query alert
   */
  query?: string;

  /**
   * Aggregation type. Relevant and required only for rules of the kind LogAlert.
   */
  timeAggregation?: TimeAggregation;

  /**
   * The column containing the metric measure number. Relevant only for rules of the kind LogAlert.
   */
  metricMeasureColumn?: string;

  /**
   * The column containing the resource id. The content of the column must be a uri formatted as resource id. Relevant only for rules of the kind LogAlert.
   */
  resourceIdColumn?: string;

  /**
   * List of Dimensions conditions
   */
  @identifiers(#[])
  dimensions?: LogAlertRuleDimension[];

  /**
   * The criteria operator. Relevant and required only for rules of the kind LogAlert.
   */
  operator?: ConditionOperator;

  /**
   * the criteria threshold value that activates the alert. Relevant and required only for static threshold rules of the kind LogAlert.
   */
  threshold?: float64;

  /**
   * The extent of deviation required to trigger an alert. Allowed values are 'Low', 'Medium' and 'High'. This will affect how tight the threshold is to the metric series pattern. Relevant and required only for dynamic threshold rules of the kind LogAlert.
   */
  alertSensitivity?: string;

  /**
   * Use this option to set the date from which to start learning the metric historical data and calculate the dynamic thresholds (in ISO8601 format). Relevant only for dynamic threshold rules of the kind LogAlert.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  ignoreDataBefore?: utcDateTime;

  /**
   * The minimum number of violations required within the selected lookback time window required to raise an alert. Relevant only for rules of the kind LogAlert.
   */
  failingPeriods?: LogAlertRuleConditionFailingPeriods;

  /**
   * The name of the metric to be sent. Relevant and required only for rules of the kind LogToMetric.
   */
  metricName?: string;
}

/**
 * Dimension splitting and filtering definition
 */
model LogAlertRuleDimension {
  /**
   * Name of the dimension
   */
  name: string;

  /**
   * Operator for dimension values
   */
  operator: DimensionOperator;

  /**
   * List of dimension values
   */
  values: string[];
}

/**
 * The minimum number of violations required within the selected lookback time window required to raise an alert. Relevant only for rules of the kind LogAlert.
 */
model LogAlertRuleConditionFailingPeriods {
  /**
   * The number of aggregated lookback points. The lookback time window is calculated based on the aggregation granularity (windowSize) and the selected number of aggregated points. Default value is 1
   */
  numberOfEvaluationPeriods?: int64 = 1;

  /**
   * The number of violations to trigger an alert. Should be smaller or equal to numberOfEvaluationPeriods. Default value is 1
   */
  minFailingPeriodsToAlert?: int64 = 1;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PreviewAlertRuleResponse {
  /**
   * An array of rule preview results.
   */
  @identifiers(#[])
  rulePreviewResults?: RulePreviewResult[];
}

/**
 * A rule preview result containing a dimension combination and an array of evaluations.
 */
model RulePreviewResult {
  /**
   * The list of dimensions for the evaluation.
   */
  dimensionCombination?: DimensionNameAndValue[];

  /**
   * An array of evaluations.
   */
  @identifiers(#[])
  evaluations?: Evaluation[];
}

/**
 * Dimension name and value
 */
model DimensionNameAndValue {
  /**
   * Name of the dimension
   */
  name: string;

  /**
   * Value of the dimension
   */
  value: string;
}

/**
 * An evaluation of the alert rule.
 */
model Evaluation {
  /**
   * The time when the evaluation was performed.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  evaluationTime?: utcDateTime;

  /**
   * The state of the alert after the evaluation.
   */
  alertState?: AlertState;

  /**
   * An array of evaluated periods.
   */
  @identifiers(#[])
  evaluatedPeriods?: EvaluatedPeriod[];

  /**
   * Indicates whether the threshold was met for this evaluation.
   */
  thresholdMet?: boolean;
}

/**
 * Details of the evaluated period.
 */
model EvaluatedPeriod {
  /**
   * The timestamp of the evaluated period.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  /**
   * The high threshold value for the evaluation period.
   */
  highThreshold?: float64;

  /**
   * The low threshold value for the evaluation period.
   */
  lowThreshold?: float64;

  /**
   * The metric value for the evaluation period.
   */
  metricValue?: float64;

  /**
   * Indicates whether the threshold was met during the evaluation period.
   */
  thresholdMet?: boolean;
}
