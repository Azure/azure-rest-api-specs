import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Microsoft.Common;

namespace Microsoft.ScheduledQueryRule;

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
   * SimpleLogAlert
   */
  SimpleLogAlert: "SimpleLogAlert",

  /**
   * LogToMetric
   */
  LogToMetric: "LogToMetric",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Key
   */
  Key: "Key",
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
 * Represents a collection of scheduled query rule resources.
 */
model ScheduledQueryRuleResourceCollection
  is Azure.Core.Page<ScheduledQueryRuleResource>;

/**
 * scheduled query rule Definition
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ScheduledQueryRuleProperties {
  /**
   * The api-version used when creating this alert rule
   */
  @visibility(Lifecycle.Read)
  createdWithApiVersion?: string;

  /**
   * True if alert rule is legacy Log Analytic rule
   */
  @visibility(Lifecycle.Read)
  isLegacyLogAnalyticsRule?: boolean;

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
  criteria?: ScheduledQueryRuleCriteria;

  /**
   * Mute actions for the chosen period of time (in ISO 8601 duration format) after the alert is fired. Relevant only for rules of the kind LogAlert.
   */
  muteActionsDuration?: duration;

  /**
   * Actions to invoke when the alert fires.
   */
  actions?: Actions;

  /**
   * The flag which indicates whether this scheduled query rule has been configured to be stored in the customer's storage. The default is false.
   */
  @visibility(Lifecycle.Read)
  isWorkspaceAlertsStorageConfigured?: boolean;

  /**
   * The flag which indicates whether this scheduled query rule should be stored in the customer's storage. The default is false. Relevant only for rules of the kind LogAlert.
   */
  checkWorkspaceAlertsStorageConfigured?: boolean;

  /**
   * The flag which indicates whether the provided query should be validated or not. The default is false. Relevant only for rules of the kind LogAlert.
   */
  skipQueryValidation?: boolean;

  /**
   * The flag that indicates whether the alert should be automatically resolved or not. The default is true. Relevant only for rules of kinds LogAlert and SimpleLogAlert.
   */
  autoMitigate?: boolean;

  /**
   * Defines the configuration for resolving fired alerts. Relevant only for rules of kinds LogAlert and SimpleLogAlert.
   */
  resolveConfiguration?: RuleResolveConfiguration;
}

/**
 * The rule criteria that defines the conditions of the scheduled query rule.
 */
model ScheduledQueryRuleCriteria {
  /**
   * A list of conditions to evaluate against the specified scopes
   */
  @identifiers(#[])
  allOf?: Condition[];
}

/**
 * A condition of the scheduled query rule.
 */
model Condition {
  /**
   * Specifies the type of threshold criteria
   */
  criterionType?: CriterionType;

  /**
   * Log query alert
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
  dimensions?: Dimension[];

  /**
   * The criteria operator. Relevant and required only for rules of the kind LogAlert.
   */
  operator?: ConditionOperator;

  /**
   * the criteria threshold value that activates the alert. Relevant and required only for static threshold rules of the kind LogAlert.
   */
  threshold?: float64;

  /**
   * The extent of deviation required to trigger an alert. Allowed values are 'Low', 'Medium' and 'High'. This will affect how tight the threshold is to the metric series pattern. Relevant only for dynamic threshold rules of the kind LogAlert.
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
  failingPeriods?: ConditionFailingPeriods;

  /**
   * The name of the metric to be sent. Relevant and required only for rules of the kind LogToMetric.
   */
  metricName?: string;

  /**
   * The minimum results count that should be found for triggering an alert. Relevant only for rules of the kind SimpleLogAlert.
   */
  minRecurrenceCount?: int64;
}

/**
 * Dimension splitting and filtering definition
 */
model Dimension {
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
model ConditionFailingPeriods {
  /**
   * The number of aggregated lookback points. The lookback time window is calculated based on the aggregation granularity (windowSize) and the selected number of aggregated points. Default value is 1
   */
  numberOfEvaluationPeriods?: int64 = 1;

  /**
   * The number of violations to trigger an alert. Should be smaller or equal to numberOfEvaluationPeriods. Default value is 1
   */
  minFailingPeriodsToAlert?: int64 = 1;
}

/**
 * Actions to invoke when the alert fires.
 */
model Actions {
  /**
   * Action Group resource Ids to invoke when the alert fires.
   */
  actionGroups?: string[];

  /**
   * The properties of an alert payload.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  customProperties?: Record<string>;

  /**
   * The properties of an action properties.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  actionProperties?: Record<string>;
}

/**
 * TBD. Relevant only for rules of the kind LogAlert.
 */
model RuleResolveConfiguration {
  /**
   * The flag that indicates whether or not to auto resolve a fired alert.
   */
  autoResolved?: boolean;

  /**
   * The duration a rule must evaluate as healthy before the fired alert is automatically resolved represented in ISO 8601 duration format.
   */
  timeToResolve?: duration;
}

/**
 * The scheduled query rule resource for patch operations.
 */
model ScheduledQueryRuleResourcePatch {
  /**
   * The identity of the resource.
   */
  identity?: Identity;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * The scheduled query rule properties of the resource.
   */
  properties?: ScheduledQueryRuleProperties;
}
