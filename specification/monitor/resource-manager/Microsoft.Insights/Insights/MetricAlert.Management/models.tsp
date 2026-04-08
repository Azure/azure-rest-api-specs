import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Insights;

/**
 * Specifies the type of the alert criteria. Previously undocumented values might be returned
 */
union Odatatype {
  string,

  /**
   * Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria
   */
  `Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria`: "Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria",

  /**
   * Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria
   */
  `Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria`: "Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria",

  /**
   * Microsoft.Azure.Monitor.WebtestLocationAvailabilityCriteria
   */
  `Microsoft.Azure.Monitor.WebtestLocationAvailabilityCriteria`: "Microsoft.Azure.Monitor.WebtestLocationAvailabilityCriteria",

  /**
   * Microsoft.Azure.Monitor.PromQLCriteria
   */
  `Microsoft.Azure.Monitor.PromQLCriteria`: "Microsoft.Azure.Monitor.PromQLCriteria",
}

/**
 * The criteria operator. Previously undocumented values might be returned
 */
union Operator {
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
}

/**
 * Specifies the type of threshold criteria. Previously undocumented values might be returned
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
 * The criteria time aggregation types. Previously undocumented values might be returned
 */
union AggregationTypeEnum {
  string,

  /**
   * Average
   */
  Average: "Average",

  /**
   * Count
   */
  Count: "Count",

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
 * The operator used to compare the metric value against the threshold. Previously undocumented values might be returned
 */
union DynamicThresholdOperator {
  string,

  /**
   * GreaterThan
   */
  GreaterThan: "GreaterThan",

  /**
   * LessThan
   */
  LessThan: "LessThan",

  /**
   * GreaterOrLessThan
   */
  GreaterOrLessThan: "GreaterOrLessThan",
}

/**
 * The extent of deviation required to trigger an alert. This will affect how tight the threshold is to the metric series pattern. Previously undocumented values might be returned
 */
union DynamicThresholdSensitivity {
  string,

  /**
   * Low
   */
  Low: "Low",

  /**
   * Medium
   */
  Medium: "Medium",

  /**
   * High
   */
  High: "High",
}

/**
 * Type of managed service identity. Previously undocumented values might be returned
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum IdentityType {
  /**
   * SystemAssigned
   */
  SystemAssigned,

  /**
   * UserAssigned
   */
  UserAssigned,

  /**
   * None
   */
  None,
}

/**
 * Represents a collection of alert rule resources.
 */
model MetricAlertResourceCollection {
  /**
   * The values for the alert rule resources.
   */
  @pageItems
  @identifiers(#["id"])
  value?: MetricAlertResource[];

  /**
   * The URL to get the next set of results.
   */
  @nextLink
  nextLink?: string;
}

/**
 * An alert rule.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MetricAlertProperties {
  /**
   * The description of the metric alert that will be included in the alert email.
   */
  description?: string;

  /**
   * Alert severity {0, 1, 2, 3, 4}
   */
  severity: int32;

  /**
   * The flag that indicates whether the metric alert is enabled.
   */
  enabled: boolean;

  /**
   * The list of resource id's that this metric alert is scoped to. You cannot change the scope of a metric rule based on logs.
   */
  scopes: string[];

  /**
   * How often the metric alert is evaluated represented in ISO 8601 duration format.
   */
  evaluationFrequency: duration;

  /**
   * The period of time (in ISO 8601 duration format) that is used to monitor alert activity based on the threshold.
   */
  windowSize?: duration;

  /**
   * The resource type of the target resource(s) on which the alert is created/updated. Mandatory if the scope contains a subscription, resource group, or more than one resource.
   */
  targetResourceType?: string;

  /**
   * The region of the target resource(s) on which the alert is created/updated. Mandatory if the scope contains a subscription, resource group, or more than one resource.
   */
  targetResourceRegion?: string;

  /**
   * Defines the specific alert criteria information.
   */
  criteria: MetricAlertCriteria;

  /**
   * The flag that indicates whether the alert should be auto resolved or not. The default is true.
   */
  autoMitigate?: boolean;

  /**
   * The configuration for how the alert is resolved. Applicable for PromQLCriteria.
   */
  resolveConfiguration?: ResolveConfiguration;

  /**
   * The array of actions that are performed when the alert rule becomes active, and when an alert condition is resolved.
   */
  @identifiers(#["actionGroupId"])
  actions?: MetricAlertAction[];

  /**
   * Last time the rule was updated in ISO8601 format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTime?: utcDateTime;

  /**
   * The value indicating whether this alert rule is migrated.
   */
  @visibility(Lifecycle.Read)
  isMigrated?: boolean;

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
 * The rule criteria that defines the conditions of the alert rule.
 */
@discriminator("odata.type")
model MetricAlertCriteria {
  ...Record<unknown>;

  /**
   * Specifies the type of the alert criteria. Previously undocumented values might be returned
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `odata.type`: Odatatype;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResolveConfiguration {
  /**
   * Indicates whether the alert should be auto resolved
   */
  autoResolved: boolean;

  /**
   * The time (in ISO 8601 duration format) after which the alert should be auto resolved
   */
  timeToResolve?: duration;
}

/**
 * An alert action.
 */
model MetricAlertAction {
  /**
   * The id of the action group to use.
   */
  actionGroupId?: string;

  /**
   * This field allows specifying custom properties, which would be appended to the alert payload sent as input to the webhook.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  webHookProperties?: Record<string>;
}

/**
 * An azure resource object
 */
model Resource {
  /**
   * Azure resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Azure resource name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Azure resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Resource location
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: string;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * The identity of the resource.
   */
  identity?: Identity;
}

/**
 * Identity for the resource.
 */
model Identity {
  /**
   * The principal ID of resource identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant ID of resource.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * Type of managed service identity. Previously undocumented values might be returned
   */
  type: IdentityType;

  /**
   * The list of user identities associated with the resource. The user identity dictionary key references will be Azure resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentities?: Record<UserIdentityProperties>;
}

/**
 * Properties of the user assigned identity.
 */
model UserIdentityProperties {
  /**
   * The principal ID of resource identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The client ID of resource identity.
   */
  @visibility(Lifecycle.Read)
  clientId?: string;
}

/**
 * Describes the format of Error response.
 */
@error
model ErrorResponse {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  error?: ErrorResponseError;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ErrorResponseError {
  /**
   * Unlocalized string which can be used to programmatically identify the error.
   */
  code?: string;

  /**
   * Describes the error in detail and provides debugging information. If Accept-Language is set in the request, it must be localized to that language.
   */
  message?: string;

  /**
   * The target of the particular error (for example, the name of the property in error).
   */
  target?: string;

  /**
   * An array of additional nested error response info objects, as described by this contract.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  details?: ErrorDetail[];

  /**
   * An array of objects with 'type' and 'info' properties. The schema of 'info' is service-specific and dependent on the 'type' string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalInfo?: ErrorResponseErrorAdditionalInfoItem[];
}

/**
 * Describes details of an error response.
 */
model ErrorDetail {
  /**
   * Unlocalized string which can be used to programmatically identify the error.
   */
  code?: string;

  /**
   * Describes the error in detail and provides debugging information.
   */
  message?: string;

  /**
   * The target of the particular error (for example, the name of the property in error).
   */
  target?: string;

  /**
   * An array of objects with 'type' and 'info' properties. The schema of 'info' is service-specific and dependent on the 'type' string.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalInfo?: ErrorDetailAdditionalInfoItem[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ErrorDetailAdditionalInfoItem {
  /**
   * The type of additional information.
   */
  type?: string;

  /**
   * The additional information specific to the type.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  info?: Record<unknown>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ErrorResponseErrorAdditionalInfoItem {
  /**
   * The type of additional information.
   */
  type?: string;

  /**
   * The additional information specific to the type.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  info?: Record<unknown>;
}

/**
 * The metric alert resource for patch operations.
 */
model MetricAlertResourcePatch {
  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * The identity of the resource.
   */
  identity?: Identity;

  /**
   * The alert rule properties of the resource.
   */
  properties?: MetricAlertPropertiesPatch;
}

/**
 * An alert rule properties for patch.
 */
model MetricAlertPropertiesPatch {
  /**
   * The description of the metric alert that will be included in the alert email.
   */
  description?: string;

  /**
   * Alert severity {0, 1, 2, 3, 4}
   */
  severity?: int32;

  /**
   * The flag that indicates whether the metric alert is enabled.
   */
  enabled?: boolean;

  /**
   * The list of resource id's that this metric alert is scoped to.
   */
  scopes?: string[];

  /**
   * How often the metric alert is evaluated represented in ISO 8601 duration format.
   */
  evaluationFrequency?: duration;

  /**
   * The period of time (in ISO 8601 duration format) that is used to monitor alert activity based on the threshold.
   */
  windowSize?: duration;

  /**
   * The resource type of the target resource(s) on which the alert is created/updated. Mandatory for MultipleResourceMultipleMetricCriteria.
   */
  targetResourceType?: string;

  /**
   * The region of the target resource(s) on which the alert is created/updated. Mandatory for MultipleResourceMultipleMetricCriteria.
   */
  targetResourceRegion?: string;

  /**
   * Defines the specific alert criteria information.
   */
  criteria?: MetricAlertCriteria;

  /**
   * The flag that indicates whether the alert should be auto resolved or not. The default is true.
   */
  autoMitigate?: boolean;

  /**
   * The configuration for how the alert is resolved. Applicable for PromQLCriteria.
   */
  resolveConfiguration?: ResolveConfiguration;

  /**
   * The array of actions that are performed when the alert rule becomes active, and when an alert condition is resolved.
   */
  @identifiers(#["actionGroupId"])
  actions?: MetricAlertAction[];

  /**
   * Last time the rule was updated in ISO8601 format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTime?: utcDateTime;

  /**
   * The value indicating whether this alert rule is migrated.
   */
  @visibility(Lifecycle.Read)
  isMigrated?: boolean;

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
 * Represents a collection of alert rule resources.
 */
model MetricAlertStatusCollection {
  /**
   * The values for the alert rule resources.
   */
  @pageItems
  @identifiers(#["id"])
  value?: MetricAlertStatus[];
}

/**
 * An alert status.
 */
model MetricAlertStatus {
  /**
   * The status name.
   */
  name?: string;

  /**
   * The alert rule arm id.
   */
  id?: string;

  /**
   * The extended resource type name.
   */
  type?: string;

  /**
   * The alert status properties of the metric alert status.
   */
  properties?: MetricAlertStatusProperties;
}

/**
 * An alert status properties.
 */
model MetricAlertStatusProperties {
  /**
   * An object describing the type of the dimensions.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  dimensions?: Record<string>;

  /**
   * Status value
   */
  status?: string;

  /**
   * UTC time when the status was checked.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;
}

/**
 * Specifies the metric alert criteria for a single resource that has multiple metric criteria.
 */
model MetricAlertSingleResourceMultipleMetricCriteria
  extends MetricAlertCriteria {
  /**
   * The list of metric criteria for this 'all of' operation.
   */
  @identifiers(#["name"])
  allOf?: MetricCriteria[];

  /**
   * Specifies the type of the alert criteria. Previously undocumented values might be returned
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `odata.type`: "Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria";
}

/**
 * Criterion to filter metrics.
 */
model MetricCriteria extends MultiMetricCriteria {
  /**
   * The criteria operator. Previously undocumented values might be returned
   */
  operator: Operator;

  /**
   * The criteria threshold value that activates the alert.
   */
  threshold: float64;

  /**
   * Specifies the type of threshold criteria. Previously undocumented values might be returned
   */
  criterionType: "StaticThresholdCriterion";
}

/**
 * The types of conditions for a multi resource alert.
 */
@discriminator("criterionType")
model MultiMetricCriteria {
  ...Record<unknown>;

  /**
   * Specifies the type of threshold criteria. Previously undocumented values might be returned
   */
  criterionType: CriterionType;

  /**
   * Name of the criteria.
   */
  name: string;

  /**
   * Name of the metric.
   */
  metricName: string;

  /**
   * Namespace of the metric.
   */
  metricNamespace?: string;

  /**
   * The criteria time aggregation types. Previously undocumented values might be returned
   */
  timeAggregation: AggregationTypeEnum;

  /**
   * List of dimension conditions.
   */
  @identifiers(#["name"])
  dimensions?: MetricDimension[];

  /**
   * Allows creating an alert rule on a custom metric that isn't yet emitted, by causing the metric validation to be skipped.
   */
  skipMetricValidation?: boolean;
}

/**
 * Specifies a metric dimension.
 */
model MetricDimension {
  /**
   * Name of the dimension.
   */
  name: string;

  /**
   * The dimension operator. Only 'Include' and 'Exclude' are supported
   */
  operator: string;

  /**
   * List of dimension values.
   */
  values: string[];
}

/**
 * Specifies the metric alert rule criteria for a web test resource.
 */
model WebtestLocationAvailabilityCriteria extends MetricAlertCriteria {
  /**
   * The Application Insights web test Id.
   */
  webTestId: string;

  /**
   * The Application Insights resource Id.
   */
  componentId: string;

  /**
   * The number of failed locations.
   */
  failedLocationCount: float32;

  /**
   * Specifies the type of the alert criteria. Previously undocumented values might be returned
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `odata.type`: "Microsoft.Azure.Monitor.WebtestLocationAvailabilityCriteria";
}

/**
 * Specifies the metric alert criteria for multiple resource that has multiple metric criteria.
 */
model MetricAlertMultipleResourceMultipleMetricCriteria
  extends MetricAlertCriteria {
  /**
   * The list of multiple metric criteria for this 'all of' operation.
   */
  @identifiers(#["name"])
  allOf?: MultiMetricCriteria[];

  /**
   * Specifies the type of the alert criteria. Previously undocumented values might be returned
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `odata.type`: "Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria";
}

/**
 * Criterion for dynamic threshold.
 */
model DynamicMetricCriteria extends MultiMetricCriteria {
  /**
   * The operator used to compare the metric value against the threshold. Previously undocumented values might be returned
   */
  operator: DynamicThresholdOperator;

  /**
   * The extent of deviation required to trigger an alert. This will affect how tight the threshold is to the metric series pattern. Previously undocumented values might be returned
   */
  alertSensitivity: DynamicThresholdSensitivity;

  /**
   * The minimum number of violations required within the selected lookback time window required to raise an alert.
   */
  failingPeriods: DynamicThresholdFailingPeriods;

  /**
   * Use this option to set the date from which to start learning the metric historical data and calculate the dynamic thresholds (in ISO8601 format)
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  ignoreDataBefore?: utcDateTime;

  /**
   * Specifies the type of threshold criteria. Previously undocumented values might be returned
   */
  criterionType: "DynamicThresholdCriterion";
}

/**
 * The minimum number of violations required within the selected lookback time window required to raise an alert.
 */
model DynamicThresholdFailingPeriods {
  /**
   * The number of aggregated lookback points. The lookback time window is calculated based on the aggregation granularity (windowSize) and the selected number of aggregated points.
   */
  numberOfEvaluationPeriods: float32;

  /**
   * The number of violations to trigger an alert. Should be smaller or equal to numberOfEvaluationPeriods.
   */
  minFailingPeriodsToAlert: float32;
}

/**
 * Specifies the PromQL criteria for the metric alert resource.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PromQLCriteria extends MetricAlertCriteria {
  /**
   * Configuration for failing periods in query-based alerts.
   */
  failingPeriods?: QueryFailingPeriods;

  /**
   * The list of promQL criteria. Alert will be raised when all conditions are met.
   */
  @identifiers(#["name"])
  allOf?: MultiPromQLCriteria[];

  /**
   * Specifies the type of the alert criteria. Previously undocumented values might be returned
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `odata.type`: "Microsoft.Azure.Monitor.PromQLCriteria";
}

/**
 * Configuration for failing periods in query-based alerts.
 */
model QueryFailingPeriods {
  /**
   * The amount of time (in ISO 8601 duration format) alert must be active before firing.
   */
  for: duration;
}

/**
 * The types of conditions for a multi query metric alert.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@discriminator("criterionType")
model MultiPromQLCriteria {
  /**
   * Specifies the type of threshold criteria. Previously undocumented values might be returned
   */
  criterionType: CriterionType;

  /**
   * Name of the criteria.
   */
  name: string;

  /**
   * The query used to evaluate the alert rule
   */
  query: string;
}

/**
 * The criterion for static prom query.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StaticPromQLCriteria extends MultiPromQLCriteria {
  /**
   * Specifies the type of threshold criteria. Previously undocumented values might be returned
   */
  criterionType: "StaticThresholdCriterion";
}

/**
 * The criterion for dynamic prom query.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DynamicPromQLCriteria extends MultiPromQLCriteria {
  /**
   * The operator used to compare the metric value against the threshold. Previously undocumented values might be returned
   */
  operator: DynamicThresholdOperator;

  /**
   * The extent of deviation required to trigger an alert. This will affect how tight the threshold is to the metric series pattern. Previously undocumented values might be returned
   */
  alertSensitivity: DynamicThresholdSensitivity;

  /**
   * Use this option to set the date from which to start learning the metric historical data and calculate the dynamic thresholds (in ISO8601 format)
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  ignoreDataBefore?: utcDateTime;

  /**
   * Specifies the type of threshold criteria. Previously undocumented values might be returned
   */
  criterionType: "DynamicThresholdCriterion";
}
