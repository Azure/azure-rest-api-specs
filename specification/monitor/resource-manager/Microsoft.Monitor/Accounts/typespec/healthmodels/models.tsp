import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
using Azure.ResourceManager;
using Azure.ClientGenerator.Core;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations API is defined in a separate spec for Microsoft.Monitor namespace (specification/monitor/resource-manager/Microsoft.Monitor/Operations)"
namespace Microsoft.Monitor;

@doc("HealthModel properties")
model HealthModelProperties {
  @visibility(Lifecycle.Read)
  @doc("The data plane endpoint for querying health data")
  queryEndpoint?: string;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: HealthModelProvisioningState;

  @doc("Configure to automatically discover entities from a given scope, such as a Service Group. The discovered entities will be linked to the root entity of the health model.")
  discovery?: ModelDiscoverySettings;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Self-explanatory"
@doc("Health Model provisioning states")
union HealthModelProvisioningState {
  string,
  ResourceProvisioningState, // include standard provisioning states
  Creating: "Creating",
  Deleting: "Deleting",
}

@doc("Settings for automatically discovering entities for the health model.")
model ModelDiscoverySettings {
  @doc("The scope from which entities should be automatically discovered. For example, the resource id of a Service Group.")
  scope: string4096;

  @doc("Whether to add all recommended signals to the discovered entities.")
  addRecommendedSignals: DiscoveryRuleRecommendedSignalsBehavior;

  @doc("Which Managed Identity of the health model to use for discovery. Defaults to SystemAssigned, if not set. Can be set to 'SystemAssigned' or to the resource id of a user-assigned managed identity which is linked to the health model.")
  identity?: string4096;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Self-explanatory"
@doc("Supported signal kinds as discriminator")
union SignalKind {
  string,
  AzureResourceMetric: "AzureResourceMetric",
  LogAnalyticsQuery: "LogAnalyticsQuery",
  PrometheusMetricsQuery: "PrometheusMetricsQuery",
}

@doc("SignalDefinition properties")
@discriminator("signalKind")
model SignalDefinitionProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: HealthModelProvisioningState;

  @doc("Display name")
  @minLength(1)
  @maxLength(260)
  displayName?: string;

  @doc("Kind of the signal definition")
  signalKind: SignalKind;

  @doc("Interval in which the signal is being evaluated. Defaults to PT1M (1 minute).")
  refreshInterval?: RefreshInterval = "PT1M";

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "approved scenario for use as Tags alternative in proxy resource"
  @doc("Optional set of labels (key-value pairs)") // Since Signal Definition is a proxy resource, we cannot use Azure Tags
  tags?: Record<string4096>;

  @doc("Unit of the signal result (e.g. Bytes, MilliSeconds, Percent, Count))")
  @minLength(1)
  @maxLength(100)
  dataUnit?: string;

  @doc("Evaluation rules for the signal definition")
  evaluationRules: EvaluationRule;

  @visibility(Lifecycle.Read)
  @doc("Date when the signal definition was (soft-)deleted")
  deletionDate?: utcDateTime;
}

@doc("Evaluation rule for a signal definition")
model EvaluationRule {
  @doc("Configure to use ML-based dynamic thresholds. When used, degradedRule and unhealthyRule must not be set.")
  dynamicDetectionRule?: DynamicDetectionRule;

  @doc("Degraded rule with static threshold. When used, dynamicDetectionRule must not be set.")
  degradedRule?: ThresholdRule;

  @doc("Unhealthy rule with static threshold. When used, dynamicDetectionRule must not be set.")
  unhealthyRule?: ThresholdRule;
}

@doc("Threshold-based evaluation rule for a signal definition")
model ThresholdRule {
  @doc("Operator how to compare the signal value with the threshold")
  operator: SignalOperator;

  @doc("Threshold value")
  @minLength(1)
  @maxLength(100)
  threshold: string;
}

@doc("ML-based evaluation rule for a signal definition")
model DynamicDetectionRule {
  @doc("ML model to use for dynamic thresholds")
  dynamicThresholdModel: DynamicThresholdModel;

  @doc("ML model sensitivity. Lowest value = high sensitivity. Supported step size = 0.5")
  @minValue(0.0)
  @maxValue(5.0)
  modelSensitivity: float32;

  @doc("Threshold direction")
  dynamicThresholdDirection: DynamicThresholdDirection;

  @doc("Start time of the training in UTC.")
  trainingStartTime?: utcDateTime;
}

@doc("ML-based model variants")
union DynamicThresholdModel {
  string,

  @doc("Anomaly detection model")
  AnomalyDetection: "AnomalyDetection",
}

@doc("Threshold direction for dynamic thresholds")
union DynamicThresholdDirection {
  string,

  @doc("Lower than")
  LowerThan: "LowerThan",

  @doc("Greater than")
  GreaterThan: "GreaterThan",

  @doc("Greater or Lower Than")
  GreaterOrLowerThan: "GreaterOrLowerThan",
}

@doc("Refresh interval in ISO duration format")
union RefreshInterval {
  string,

  @doc("One Minute")
  PT1M: "PT1M",

  @doc("Five Minutes")
  PT5M: "PT5M",

  @doc("Ten Minutes")
  PT10M: "PT10M",

  @doc("Thirty Minutes")
  PT30M: "PT30M",

  @doc("One Hour")
  PT1H: "PT1H",

  @doc("Two Hours")
  PT2H: "PT2H",
}

@doc("Azure Resource Metric Signal Definition properties")
model ResourceMetricSignalDefinitionProperties
  extends SignalDefinitionProperties {
  @doc("Kind of the signal definition")
  signalKind: SignalKind.AzureResourceMetric;

  @doc("Metric namespace")
  @minLength(1)
  @maxLength(256)
  metricNamespace: string;

  @doc("Name of the metric")
  @minLength(1)
  @maxLength(256)
  metricName: string;

  @doc("Time range of signal. ISO duration format like PT10M.")
  @minLength(1)
  @maxLength(100)
  timeGrain: string;

  @doc("Type of aggregation to apply to the metric")
  aggregationType: MetricAggregationType;

  @doc("Optional: Dimension to split by")
  @minLength(1)
  @maxLength(256)
  dimension?: string;

  @doc("Optional: Dimension filter to apply to the dimension. Must only be set if also Dimension is set.")
  @minLength(1)
  @maxLength(256)
  dimensionFilter?: string;
}

@doc("Log Analytics Query Signal Definition properties")
model LogAnalyticsQuerySignalDefinitionProperties
  extends SignalDefinitionProperties {
  @doc("Kind of the signal definition")
  signalKind: SignalKind.LogAnalyticsQuery;

  @doc("Query text in KQL syntax")
  @minLength(1)
  @maxLength(5000)
  queryText: string;

  @doc("Time range of signal. ISO duration format like PT10M. If not specified, the KQL query must define a time range.")
  @minLength(1)
  @maxLength(100)
  timeGrain?: string;

  @doc("Name of the column in the result set to evaluate against the thresholds. Defaults to the first column in the result set if not specified. The column must be numeric.")
  @minLength(1)
  @maxLength(100)
  valueColumnName?: string;
}

@doc("Prometheus Metrics Signal Definition properties")
model PrometheusMetricsSignalDefinitionProperties
  extends SignalDefinitionProperties {
  @doc("Kind of the signal definition")
  signalKind: SignalKind.PrometheusMetricsQuery;

  @doc("Query text in PromQL syntax")
  @minLength(1)
  @maxLength(5000)
  queryText: string;

  @doc("Time range of signal. ISO duration format like PT10M.")
  @minLength(1)
  @maxLength(100)
  timeGrain?: string;
}

@doc("Signal operator")
union SignalOperator {
  string,

  @doc("Less than")
  LessThan: "LessThan",

  @doc("Less than or equal to")
  LessThanOrEqual: "LessThanOrEqual",

  @doc("Greater than")
  GreaterThan: "GreaterThan",

  @doc("Greater than or equal to")
  GreaterThanOrEqual: "GreaterThanOrEqual",

  @doc("Equal to")
  Equal: "Equal",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Self-explanatory"
@doc("Metric aggregation type")
union MetricAggregationType {
  string,
  None: "None",
  Average: "Average",
  Count: "Count",
  Minimum: "Minimum",
  Maximum: "Maximum",
  Total: "Total",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Self-explanatory"
@doc("Supported kinds of authentication settings as discriminator")
union AuthenticationKind {
  string,
  ManagedIdentity: "ManagedIdentity",
  // More will be added later here
}

@doc("Authentication setting properties")
@discriminator("authenticationKind")
model AuthenticationSettingProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: HealthModelProvisioningState;

  @doc("Display name")
  @minLength(1)
  @maxLength(260)
  displayName?: string;

  @doc("Kind of the authentication setting")
  authenticationKind: AuthenticationKind;
}

@doc("Authentication setting properties for Azure Managed Identity")
model ManagedIdentityAuthenticationSettingProperties
  extends AuthenticationSettingProperties {
  @doc("Kind of the authentication setting")
  authenticationKind: AuthenticationKind.ManagedIdentity;

  @doc("Name of the managed identity to use. Either 'SystemAssigned' or the resourceId of a user-assigned identity.")
  @minLength(1)
  @maxLength(500)
  managedIdentityName: string;
}

@doc("Properties which are common across all kinds of entities")
model EntityProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: HealthModelProvisioningState;

  @doc("Display name")
  @minLength(1)
  @maxLength(260)
  displayName?: string;

  @doc("Entity kind")
  @minLength(1)
  @maxLength(260)
  kind?: string = "Default";

  @doc("Positioning of the entity on the model canvas")
  canvasPosition?: EntityCoordinates;

  @doc("Visual icon definition. If not set, a default icon is used.")
  icon?: IconDefinition;

  @doc("Health objective as a percentage of time the entity should be healthy.")
  @minValue(0)
  @maxValue(100)
  healthObjective?: float32;

  @doc("Impact of the entity in health state propagation")
  impact?: EntityImpact = "Standard";

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "approved scenario for use as Tags alternative in proxy resource"
  @doc("Optional set of labels (key-value pairs)") // Since Entity is a proxy resource, we cannot use Azure Tags
  tags?: Record<string4096>;

  @doc("Signal groups which are assigned to this entity")
  signals?: SignalGroup;

  @visibility(Lifecycle.Read)
  @doc("Discovered by which discovery rule. If set, the entity cannot be deleted manually.")
  discoveredBy?: stringResourceName;

  @visibility(Lifecycle.Read)
  @doc("Date when the entity was (soft-)deleted")
  deletionDate?: utcDateTime;

  @visibility(Lifecycle.Read)
  @doc("Health state of this entity")
  healthState?: HealthState;

  @doc("Alert configuration for this entity")
  alerts?: EntityAlerts;
}

@doc("Alert configuration for an entity")
model EntityAlerts {
  @doc("Alert to be triggered on state change to unhealthy")
  unhealthy?: AlertConfiguration;

  @doc("Alert to be triggered on state change to degraded")
  degraded?: AlertConfiguration;
}

@doc("Alert configuration details")
model AlertConfiguration {
  @doc("The severity of triggered alert.")
  severity: AlertSeverity;

  @doc("The alert rule description.")
  @maxLength(1000)
  @minLength(1)
  description?: string;

  @doc("Optional list of action group resource IDs to be notified when the alert is triggered.")
  @maxItems(5)
  @minItems(1)
  actionGroupIds?: armResourceIdentifier<[
    {
      type: "Microsoft.Insights/actionGroups";
    }
  ]>[];
}

@doc("Severity of an alert")
union AlertSeverity {
  string,

  @doc("Critical")
  Sev0: "Sev0",

  @doc("Error")
  Sev1: "Sev1",

  @doc("Warning")
  Sev2: "Sev2",

  @doc("Informational")
  Sev3: "Sev3",

  @doc("Verbose")
  Sev4: "Sev4",
}

@clientName("IconDetails", "csharp")
@doc("Visual icon definition of an entity")
model IconDefinition {
  @doc("Name of the built-in icon, or 'Custom' to use customData")
  @minLength(1)
  @maxLength(100)
  iconName: string;

  @doc("Custom data. Base64-encoded SVG data. If set, this overrides the built-in icon.")
  @minLength(1)
  @maxLength(5000)
  customData?: string;
}

@doc("Contains various signal groups that can be assigned to an entity")
model SignalGroup {
  @doc("Azure Resource Signal Group")
  azureResource?: AzureResourceSignalGroup;

  @doc("Log Analytics Signal Group")
  azureLogAnalytics?: LogAnalyticsSignalGroup;

  @doc("Azure Monitor Workspace Signal Group")
  azureMonitorWorkspace?: AzureMonitorWorkspaceSignalGroup;

  @doc("Settings for dependency signals to control how the health state of child entities influences the health state of the parent entity.")
  dependencies?: DependenciesSignalGroup;
}

@doc("Properties for dependent entities, i.e. child entities")
model DependenciesSignalGroup {
  @doc("Aggregation type for child dependencies.")
  aggregationType: DependenciesAggregationType = DependenciesAggregationType.WorstOf;

  @doc("Degraded threshold for aggregating the propagated health state of child dependencies. Can be either an absolute number that is greater than 0, or a percentage between 1-100%. The entity will be considered degraded when the number of not healthy child dependents (unhealthy, degraded, unknown) is equal to or above the threshold value. Must only be set when AggregationType is 'Thresholds'.")
  degradedThreshold?: string;

  @doc("Unhealthy threshold for aggregating the propagated health state of child dependencies. Can be either an absolute number that is greater than 0, or a percentage between 1-100%. The entity will be considered unhealthy when the number of not healthy child dependents (unhealthy, degraded, unknown) is equal to or above the threshold value. Must only be set when AggregationType is 'Thresholds'.")
  unhealthyThreshold?: string;
}

@doc("Aggregation type for child dependencies.")
union DependenciesAggregationType {
  string,

  @doc("Default behavior: Worst child health state is propagated.")
  WorstOf: "WorstOf",

  @doc("Based on configurable thresholds.")
  Thresholds: "Thresholds",
}

@doc("A grouping of signal assignments and link to a data source")
model SignalAssignmentGroup {
  @doc("Signal definitions which are assigned to this signal group. All assignments are combined with an OR operator.")
  @maxItems(50)
  @identifiers(#["signalDefinitions"])
  signalAssignments?: SignalAssignment[];

  @doc("Reference to the name of the authentication setting which is used for querying the data source")
  authenticationSetting: stringResourceName;
}

@doc("Group of signal definition assignments")
model SignalAssignment {
  @doc("Signal definitions referenced by their names. All definitions are combined with an AND operator.")
  // @maxItems(50) - until the backend supports correlation, we need to limit this to 1
  @maxItems(1)
  @minItems(1)
  signalDefinitions: stringResourceName[];
}

@doc("A grouping of signal assignments for an Azure resource")
model AzureResourceSignalGroup is SignalAssignmentGroup {
  @doc("Azure resource ID")
  azureResourceId: armResourceIdentifier<[]>;
}

@doc("A grouping of signal assignments for a Log Analytics Workspace")
model LogAnalyticsSignalGroup is SignalAssignmentGroup {
  @doc("Log Analytics Workspace resource ID")
  logAnalyticsWorkspaceResourceId: LogAnalyticsWorkspaceResourceId;
}

@doc("A grouping of signal assignments for a Azure Monitor Workspace")
model AzureMonitorWorkspaceSignalGroup is SignalAssignmentGroup {
  @doc("Azure Monitor workspace resource ID")
  azureMonitorWorkspaceResourceId: AzureMonitorWorkspaceResourceId;
}

@doc("Type of impact an entity has on health state propagation")
union EntityImpact {
  string,

  @doc("Standard impact")
  Standard: "Standard",

  @doc("Limited impact")
  Limited: "Limited",

  @doc("Suppressed impact")
  Suppressed: "Suppressed",
}

@doc("Health state of an entity")
union HealthState {
  string,

  @doc("Healthy status")
  Healthy: "Healthy",

  @doc("Degraded status")
  Degraded: "Degraded",

  @doc("Error status (Unhealthy)")
  Error: "Error",

  @doc("Unknown status")
  Unknown: "Unknown",

  @doc("Deleted status")
  Deleted: "Deleted",
}

@doc("Visual position of the entity")
model EntityCoordinates {
  @doc("X Coordinate")
  x: float32;

  @doc("Y Coordinate")
  y: float32;
}

scalar LogAnalyticsWorkspaceResourceId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.OperationalInsights/workspaces",
    }
  ]>;

scalar AzureMonitorWorkspaceResourceId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.Monitor/accounts",
    }
  ]>;

@doc("Relationship properties")
model RelationshipProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: HealthModelProvisioningState;

  @doc("Display name")
  @minLength(1)
  @maxLength(260)
  displayName?: string;

  @doc("Resource name of the parent entity")
  @visibility(Lifecycle.Create, Lifecycle.Read) // this cannot be changed
  parentEntityName: stringResourceName;

  @doc("Resource name of the child entity")
  @visibility(Lifecycle.Create, Lifecycle.Read) // this cannot be changed
  childEntityName: stringResourceName;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "approved scenario for use as Tags alternative in proxy resource"
  @doc("Optional set of labels (key-value pairs)") // Since Relationship is a proxy resource, we cannot use Azure Tags
  tags?: Record<string4096>;

  @visibility(Lifecycle.Read)
  @doc("Discovered by which discovery rule. If set, the relationship cannot be deleted manually.")
  discoveredBy?: stringResourceName;

  @visibility(Lifecycle.Read)
  @doc("Date when the relationship was (soft-)deleted")
  deletionDate?: utcDateTime;
}

@doc("Discovery rule relationship discovery behavior")
union DiscoveryRuleKind {
  string,
  ResourceGraphQuery: "ResourceGraphQuery",
  ApplicationInsightsTopology: "ApplicationInsightsTopology",
}

@doc("Discovery rule properties")
@discriminator("discoveryRuleKind")
model DiscoveryRuleProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: HealthModelProvisioningState;

  @doc("Display name")
  @minLength(1)
  @maxLength(260)
  displayName?: string;

  @doc("Kind of the discovery rule")
  discoveryRuleKind: DiscoveryRuleKind;

  @doc("Reference to the name of the authentication setting which is used for querying Azure Resource Graph. The same authentication setting will also be assigned to any discovered entities.")
  authenticationSetting: stringResourceName;

  @doc("Whether to create relationships between the discovered entities based on a set of built-in rules. These relationships cannot be manually deleted.")
  discoverRelationships: DiscoveryRuleRelationshipDiscoveryBehavior;

  @doc("Whether to add all recommended signals to the discovered entities.")
  addRecommendedSignals: DiscoveryRuleRecommendedSignalsBehavior;

  @visibility(Lifecycle.Read)
  @doc("Date when the discovery rule was (soft-)deleted.")
  deletionDate?: utcDateTime;

  @visibility(Lifecycle.Read)
  @doc("Error details if the last discovery operation failed.")
  error?: DiscoveryError;

  @visibility(Lifecycle.Read)
  @doc("Name of the entity which represents the discovery rule. Note: It might take a few minutes after creating the discovery rule until the entity is created.")
  entityName: string;
}

@doc("Error details for a failed discovery operation")
model DiscoveryError {
  @visibility(Lifecycle.Read)
  @doc("Error message")
  message: string;

  @visibility(Lifecycle.Read)
  @doc("Additional context information, like resource IDs or query details")
  context?: string[];
}

@doc("Discovery rule relationship discovery behavior")
union DiscoveryRuleRelationshipDiscoveryBehavior {
  string,

  @doc("Automatically attempt to discover relationships")
  Enabled: "Enabled",

  @doc("Do not automatically attempt to discover relationships")
  Disabled: "Disabled",
}

@doc("Discovery rule recommended signal behavior")
union DiscoveryRuleRecommendedSignalsBehavior {
  string,

  @doc("Automatically add recommended signals")
  Enabled: "Enabled",

  @doc("Do not automatically add recommended signals")
  Disabled: "Disabled",
}

@doc("Discovery rule properties for an Azure Resource Graph query")
model ResourceGraphQueryDiscoveryRuleProperties
  extends DiscoveryRuleProperties {
  @doc("Kind of the discovery rule")
  discoveryRuleKind: DiscoveryRuleKind.ResourceGraphQuery;

  @doc("Azure Resource Graph query text in KQL syntax. The query must return at least a column named 'id' which contains the resource ID of the discovered resources.")
  @minLength(1)
  @maxLength(5000)
  resourceGraphQuery: string;
}

@doc("Discovery rule properties for an Application Insights topology query")
model ApplicationInsightsTopologyDiscoveryRuleProperties
  extends DiscoveryRuleProperties {
  @doc("Kind of the discovery rule")
  discoveryRuleKind: DiscoveryRuleKind.ApplicationInsightsTopology;

  @doc("Application Insights resource ID")
  applicationInsightsResourceId: armResourceIdentifier<[
    {
      type: "Microsoft.Insights/components";
    }
  ]>;
}
