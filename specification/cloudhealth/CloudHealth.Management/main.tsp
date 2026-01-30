import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace(ProviderName)
@service(#{ title: ProviderName })
@armCommonTypesVersion(CommonTypes.Versions.v6)
@versioned(Versions)
namespace Microsoft.CloudHealth;

@doc("API Versions")
enum Versions {
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  @doc("2025-05-01-preview")
  v2025_05_01_preview: "2025-05-01-preview",

  @doc("2026-01-01-preview")
  v2026_01_01_preview: "2026-01-01-preview",
}

alias ProviderName = "Microsoft.CloudHealth";

// Regex for our health model resource name validations. Between 3 and 44 characters, alphanumeric and hyphens, must start with an alphabetic character and end with an alphanumeric character
alias modelResourceNameRegex = "^[a-zA-Z][a-zA-Z0-9-]{1,42}[a-zA-Z0-9]$";

@pattern(modelResourceNameRegex)
@doc("String with regex validation to match the health model resource name requirements")
scalar stringModelResourceName extends string;

// Regex for all our proxy resource name validations. Up to 260 characters, alphanumeric and hyphens, must start and end with an alphanumeric character
alias proxyResourceNameRegex = "^[a-zA-Z0-9][a-zA-Z0-9-]{1,258}[a-zA-Z0-9]$";

@maxLength(4096)
@doc("String with max length validation of 4096 characters")
scalar string4096 extends string;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("A HealthModel resource")
model HealthModel is TrackedResource<HealthModelProperties> {
  @doc("Name of health model resource")
  @key("healthModelName")
  @path
  @segment("healthmodels")
  name: stringModelResourceName;

  ...ManagedServiceIdentityProperty;
}

@doc("HealthModel properties")
model HealthModelProperties {
  @removed(Versions.v2026_01_01_preview)
  @visibility(Lifecycle.Read)
  @doc("The data plane endpoint for interacting with health data")
  dataplaneEndpoint?: string;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: HealthModelProvisioningState;

  @removed(Versions.v2026_01_01_preview)
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

@removed(Versions.v2026_01_01_preview)
@doc("Settings for automatically discovering entities for the health model.")
model ModelDiscoverySettings {
  @doc("The scope from which entities should be automatically discovered. For example, the resource id of a Service Group.")
  scope: string4096;

  @doc("Whether to add all recommended signals to the discovered entities.")
  addRecommendedSignals: DiscoveryRuleRecommendedSignalsBehavior;

  @doc("Which Managed Identity of the health model to use for discovery. Defaults to SystemAssigned, if not set. Can be set to 'SystemAssigned' or to the resource id of a user-assigned managed identity which is linked to the health model.")
  identity?: string4096;
}

@pattern(proxyResourceNameRegex)
@doc("Type for signal definition resource name.")
scalar signalDefinitionName extends string;

@added(Versions.v2026_01_01_preview)
@pattern(proxyResourceNameRegex)
@doc("Type for signal name.")
scalar signalName extends string;

@doc("A signal definition in a health model")
@parentResource(HealthModel)
model SignalDefinition is ProxyResource<SignalDefinitionProperties> {
  @doc("Name of the signal definition. Must be unique within a health model.")
  @key("signalDefinitionName")
  @segment("signaldefinitions")
  @path
  name: signalDefinitionName;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Self-explanatory"
@doc("Supported signal kinds as discriminator")
union SignalKind {
  string,
  AzureResourceMetric: "AzureResourceMetric",
  LogAnalyticsQuery: "LogAnalyticsQuery",
  PrometheusMetricsQuery: "PrometheusMetricsQuery",

  @added(Versions.v2026_01_01_preview)
  ExternalSignal: "ExternalSignal",
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
  @removed(Versions.v2026_01_01_preview)
  @doc("Optional set of labels (key-value pairs)") // Since Signal Definition is a proxy resource, we cannot use Azure Tags
  labels?: Record<string4096>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "approved scenario for use as Tags alternative in proxy resource"
  @added(Versions.v2026_01_01_preview)
  @doc("Optional set of tags (key-value pairs)") // Since Relationship is a proxy resource, we cannot use Azure Tags
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
  @removed(Versions.v2026_01_01_preview)
  @doc("Configure to use ML-based dynamic thresholds. When used, degradedRule and unhealthyRule must not be set.")
  dynamicDetectionRule?: DynamicDetectionRule;

  @doc("Degraded rule with static threshold.")
  @typeChangedFrom(Versions.v2026_01_01_preview, ThresholdRule)
  degradedRule?: ThresholdRuleV2;

  @doc("Unhealthy rule with static threshold.")
  @typeChangedFrom(Versions.v2026_01_01_preview, ThresholdRule)
  @madeRequired(Versions.v2026_01_01_preview)
  unhealthyRule: ThresholdRuleV2;
}

@removed(Versions.v2026_01_01_preview)
@doc("Threshold-based evaluation rule for a signal definition")
model ThresholdRule {
  @doc("Operator how to compare the signal value with the threshold")
  operator: SignalOperator;

  @doc("Threshold value")
  @minLength(1)
  @maxLength(100)
  threshold: string;
}

@added(Versions.v2026_01_01_preview)
@doc("Threshold-based evaluation rule for a signal definition")
model ThresholdRuleV2 {
  @doc("Operator how to compare the signal value with the threshold")
  operator: SignalOperator;

  @doc("Threshold value")
  threshold: float64;
}

@removed(Versions.v2026_01_01_preview)
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

@removed(Versions.v2026_01_01_preview)
@doc("ML-based model variants")
union DynamicThresholdModel {
  string,

  @doc("Anomaly detection model")
  AnomalyDetection: "AnomalyDetection",
}

@removed(Versions.v2026_01_01_preview)
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

  @removed(Versions.v2026_01_01_preview)
  @doc("Lower than")
  LowerThan: "LowerThan",

  @removed(Versions.v2026_01_01_preview)
  @doc("Lower than or equal to")
  LowerOrEquals: "LowerOrEquals",

  @doc("Greater than")
  GreaterThan: "GreaterThan",

  @removed(Versions.v2026_01_01_preview)
  @doc("Greater than or equal to")
  GreaterOrEquals: "GreaterOrEquals",

  @removed(Versions.v2026_01_01_preview)
  @doc("Equal to")
  Equals: "Equals",

  @added(Versions.v2026_01_01_preview)
  @doc("Less than")
  LessThan: "LessThan",

  @added(Versions.v2026_01_01_preview)
  @doc("Less than or equal to")
  LessThanOrEqual: "LessThanOrEqual",

  @added(Versions.v2026_01_01_preview)
  @doc("Greater than or equal to")
  GreaterThanOrEqual: "GreaterThanOrEqual",

  @added(Versions.v2026_01_01_preview)
  @doc("Equal to")
  Equal: "Equal",

  @added(Versions.v2026_01_01_preview)
  @doc("Not equal to")
  NotEqual: "NotEqual",
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

@pattern(proxyResourceNameRegex)
@doc("Type for authentication setting resource name.")
scalar authenticationSettingName extends string;

@doc("An authentication setting in a health model")
@parentResource(HealthModel)
model AuthenticationSetting is ProxyResource<AuthenticationSettingProperties> {
  @doc("Name of the authentication setting. Must be unique within a health model.")
  @key("authenticationSettingName")
  @segment("authenticationsettings")
  @path
  name: authenticationSettingName;
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

@pattern(proxyResourceNameRegex)
@doc("Type for entity resource name.")
scalar entityName extends string;

@doc("An entity (aka node) of a health model")
@parentResource(HealthModel)
model Entity is ProxyResource<EntityProperties> {
  @doc("Name of the entity. Must be unique within a health model.")
  @key("entityName")
  @segment("entities")
  @path
  name: entityName;
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

  @removed(Versions.v2026_01_01_preview)
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
  @removed(Versions.v2026_01_01_preview)
  @doc("Optional set of labels (key-value pairs)") // Since Entity is a proxy resource, we cannot use Azure Tags
  labels?: Record<string4096>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "approved scenario for use as Tags alternative in proxy resource"
  @added(Versions.v2026_01_01_preview)
  @doc("Optional set of tags (key-value pairs)") // Since Relationship is a proxy resource, we cannot use Azure Tags
  tags?: Record<string4096>;

  @removed(Versions.v2026_01_01_preview)
  @doc("Signal groups which are assigned to this entity")
  signals?: SignalGroup;

  @added(Versions.v2026_01_01_preview)
  @doc("Signal groups which are assigned to this entity")
  signalGroups?: SignalGroups;

  @visibility(Lifecycle.Read)
  @doc("Discovered by which discovery rule. If set, the entity cannot be deleted manually.")
  discoveredBy?: discoveryRuleName;

  @visibility(Lifecycle.Read)
  @doc("Date when the entity was (soft-)deleted")
  deletionDate?: utcDateTime;

  @visibility(Lifecycle.Read)
  @doc("Health state of this entity")
  healthState?: HealthState;

  @doc("Alert configuration for this entity")
  alerts?: EntityAlerts;
}

@added(Versions.v2026_01_01_preview)
@doc("Status of a signal")
model SignalStatus {
  @visibility(Lifecycle.Read)
  @doc("Health state of this signal")
  healthState?: HealthState;

  @visibility(Lifecycle.Read)
  @doc("Reported value of the signal")
  value?: float64;

  @visibility(Lifecycle.Read)
  @doc("Timestamp when the value was reported")
  reportedAt?: utcDateTime;

  @visibility(Lifecycle.Read)
  @doc("Error message if the signal status cannot be retrieved")
  error?: string;
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

@removed(Versions.v2026_01_01_preview)
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

@added(Versions.v2026_01_01_preview)
@doc("Contains various signal groups that can be assigned to an entity")
model SignalGroups {
  @doc("Azure Resource Signal Group")
  azureResource?: AzureResourceSignals;

  @doc("Log Analytics Signal Group")
  azureLogAnalytics?: LogAnalyticsSignals;

  @doc("Azure Monitor Workspace Signal Group")
  azureMonitorWorkspace?: AzureMonitorWorkspaceSignals;

  @doc("Settings for dependency signals to control how the health state of child entities influences the health state of the parent entity.")
  dependencies?: DependenciesSignalGroup;

  @doc("List of signals which have been externally submitted for this entity.")
  @visibility(Lifecycle.Read)
  external?: ExternalSignalGroup;
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

@removed(Versions.v2026_01_01_preview)
@doc("A grouping of signal assignments and link to a data source")
model SignalAssignmentGroup {
  @doc("Signal definitions which are assigned to this signal group. All assignments are combined with an OR operator.")
  @maxItems(50)
  @identifiers(#["signalDefinitions"])
  signalAssignments?: SignalAssignment[];

  @doc("Reference to the name of the authentication setting which is used for querying the data source")
  authenticationSetting: authenticationSettingName;
}

@removed(Versions.v2026_01_01_preview)
@doc("Group of signal definition assignments")
model SignalAssignment {
  @doc("Signal definitions referenced by their names. All definitions are combined with an AND operator.")
  // @maxItems(50) - until the backend supports correlation, we need to limit this to 1
  @maxItems(1)
  @minItems(1)
  signalDefinitions: signalDefinitionName[];
}

@added(Versions.v2026_01_01_preview)
@discriminator("signalKind")
@doc("Additional properties for signal instances assigned to an entity")
model SignalInstanceProperties {
  @doc("Kind of the signal instance")
  signalKind: SignalKind;

  @doc("Unique name of the signal within the entity.")
  name: signalName;

  @doc("Optional reference to a signal definition that provides default values.")
  signalDefinitionName?: signalDefinitionName;

  @visibility(Lifecycle.Read)
  @doc("Current status of the signal.")
  status?: SignalStatus;
}

@removed(Versions.v2026_01_01_preview)
@doc("A grouping of signal assignments for an Azure resource")
model AzureResourceSignalGroup is SignalAssignmentGroup {
  @doc("Azure resource ID")
  azureResourceId: armResourceIdentifier<[]>;
}

@removed(Versions.v2026_01_01_preview)
@doc("A grouping of signal assignments for a Log Analytics Workspace")
model LogAnalyticsSignalGroup is SignalAssignmentGroup {
  @doc("Log Analytics Workspace resource ID")
  logAnalyticsWorkspaceResourceId: LogAnalyticsWorkspaceResourceId;
}

@removed(Versions.v2026_01_01_preview)
@doc("A grouping of signal assignments for a Azure Monitor Workspace")
model AzureMonitorWorkspaceSignalGroup is SignalAssignmentGroup {
  @doc("Azure Monitor workspace resource ID")
  azureMonitorWorkspaceResourceId: AzureMonitorWorkspaceResourceId;
}

@added(Versions.v2026_01_01_preview)
@doc("An Azure Resource Metric signal instance assigned to an entity.")
model AzureResourceSignal extends SignalInstanceProperties {
  @doc("Kind of the signal instance")
  signalKind: SignalKind.AzureResourceMetric;

  ...OptionalProperties<OmitProperties<
    ResourceMetricSignalDefinitionProperties,
    "provisioningState" | "deletionDate" | "tags" | "signalKind"
  >>;
}

@added(Versions.v2026_01_01_preview)
@doc("A Log Analytics Query signal instance assigned to an entity.")
model LogAnalyticsSignal extends SignalInstanceProperties {
  @doc("Kind of the signal instance")
  signalKind: SignalKind.LogAnalyticsQuery;

  ...OptionalProperties<OmitProperties<
    LogAnalyticsQuerySignalDefinitionProperties,
    "provisioningState" | "deletionDate" | "tags" | "signalKind"
  >>;
}

@added(Versions.v2026_01_01_preview)
@doc("A Prometheus Metrics Query signal instance assigned to an entity.")
model PrometheusMetricsSignal extends SignalInstanceProperties {
  @doc("Kind of the signal instance")
  signalKind: SignalKind.PrometheusMetricsQuery;

  ...OptionalProperties<OmitProperties<
    PrometheusMetricsSignalDefinitionProperties,
    "provisioningState" | "deletionDate" | "tags" | "signalKind"
  >>;
}

@added(Versions.v2026_01_01_preview)
@doc("A grouping of Azure resource signals")
model AzureResourceSignals {
  @doc("Reference to the name of the authentication setting which is used for querying the data source.")
  authenticationSetting: authenticationSettingName;

  @doc("Azure resource ID")
  azureResourceId: armResourceIdentifier<[]>;

  @doc("Azure resource kind (e.g., 'functionapp'). Populated by the UI for icon rendering. Can be null if not populated.")
  @minLength(0)
  @maxLength(256)
  azureResourceKind?: string;

  @doc("Signals assigned to this group.")
  @maxItems(50)
  @identifiers(#["name"])
  signals?: AzureResourceSignal[];
}

@added(Versions.v2026_01_01_preview)
@doc("A grouping of Log Analytics workspace signals.")
model LogAnalyticsSignals {
  @doc("Reference to the name of the authentication setting which is used for querying the data source.")
  authenticationSetting: authenticationSettingName;

  @doc("Log Analytics workspace resource ID.")
  logAnalyticsWorkspaceResourceId: LogAnalyticsWorkspaceResourceId;

  @doc("Signals assigned to this group.")
  @maxItems(50)
  @identifiers(#["name"])
  signals?: LogAnalyticsSignal[];
}

@added(Versions.v2026_01_01_preview)
@doc("A grouping of Azure Monitor workspace signals.")
model AzureMonitorWorkspaceSignals {
  @doc("Reference to the name of the authentication setting which is used for querying the data source.")
  authenticationSetting: authenticationSettingName;

  @doc("Azure Monitor workspace resource ID.")
  azureMonitorWorkspaceResourceId: AzureMonitorWorkspaceResourceId;

  @doc("Signals assigned to this signal group.")
  @maxItems(50)
  @identifiers(#["name"])
  signals?: PrometheusMetricsSignal[];
}

@added(Versions.v2026_01_01_preview)
@doc("A grouping of externally submitted signals.")
model ExternalSignalGroup {
  @doc("Signals assigned to this signal group.")
  @identifiers(#["name"])
  @visibility(Lifecycle.Read)
  signals?: ExternalSignal[];
}

@added(Versions.v2026_01_01_preview)
@doc("An externally submitted signal instance assigned to an entity.")
model ExternalSignal extends SignalInstanceProperties {
  @doc("Kind of the signal instance")
  signalKind: SignalKind.ExternalSignal;

  @doc("Evaluation rules for the external signal as submitted.")
  evaluationRules?: EvaluationRule;
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

  @removed(Versions.v2026_01_01_preview)
  @doc("Error status (Unhealthy)")
  Error: "Error",

  @added(Versions.v2026_01_01_preview)
  @doc("Unhealthy status")
  Unhealthy: "Unhealthy",

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

@pattern(proxyResourceNameRegex)
@doc("Type for relationship resource name.")
scalar relationshipName extends string;

@doc("A relationship (aka edge) between two entities in a health model")
@parentResource(HealthModel)
model Relationship is ProxyResource<RelationshipProperties> {
  @doc("Name of the relationship. Must be unique within a health model. For example, a concatenation of parentEntityName and childEntityName can be used as the name.")
  @key("relationshipName")
  @segment("relationships")
  @path
  name: relationshipName;
}

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
  parentEntityName: entityName;

  @doc("Resource name of the child entity")
  @visibility(Lifecycle.Create, Lifecycle.Read) // this cannot be changed
  childEntityName: entityName;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "approved scenario for use as Tags alternative in proxy resource"
  @removed(Versions.v2026_01_01_preview)
  @doc("Optional set of labels (key-value pairs)") // Since Relationship is a proxy resource, we cannot use Azure Tags
  labels?: Record<string4096>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "approved scenario for use as Tags alternative in proxy resource"
  @added(Versions.v2026_01_01_preview)
  @doc("Optional set of tags (key-value pairs)") // Since Relationship is a proxy resource, we cannot use Azure Tags
  tags?: Record<string4096>;

  @visibility(Lifecycle.Read)
  @doc("Discovered by which discovery rule. If set, the relationship cannot be deleted manually.")
  discoveredBy?: discoveryRuleName;

  @visibility(Lifecycle.Read)
  @doc("Date when the relationship was (soft-)deleted")
  deletionDate?: utcDateTime;
}

@pattern(proxyResourceNameRegex)
@doc("Type for discovery rule resource name.")
scalar discoveryRuleName extends string;

@doc("A discovery rule which automatically finds entities and relationships in a health model based on an Azure Resource Graph query")
@parentResource(HealthModel)
model DiscoveryRule is ProxyResource<DiscoveryRuleProperties> {
  @doc("Name of the discovery rule. Must be unique within a health model.")
  @key("discoveryRuleName")
  @segment("discoveryrules")
  @path
  name: discoveryRuleName;
}

@doc("Discovery rule properties")
model DiscoveryRuleProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: HealthModelProvisioningState;

  @doc("Display name")
  @minLength(1)
  @maxLength(260)
  displayName?: string;

  @removed(Versions.v2026_01_01_preview)
  @doc("Azure Resource Graph query text in KQL syntax. The query must return at least a column named 'id' which contains the resource ID of the discovered resources.")
  @minLength(1)
  @maxLength(5000)
  resourceGraphQuery: string;

  @doc("Reference to the name of the authentication setting which is used for querying Azure Resource Graph. The same authentication setting will also be assigned to any discovered entities.")
  authenticationSetting: authenticationSettingName;

  @doc("Whether to create relationships between the discovered entities based on a set of built-in rules. These relationships cannot be manually deleted.")
  discoverRelationships: DiscoveryRuleRelationshipDiscoveryBehavior;

  @doc("Whether to add all recommended signals to the discovered entities.")
  addRecommendedSignals: DiscoveryRuleRecommendedSignalsBehavior;

  @added(Versions.v2026_01_01_preview)
  @doc("Specification of the discovery rule defining how entities are discovered.")
  specification: DiscoveryRuleSpecification;

  @visibility(Lifecycle.Read)
  @doc("Date when the discovery rule was (soft-)deleted.")
  deletionDate?: utcDateTime;

  @removed(Versions.v2026_01_01_preview)
  @visibility(Lifecycle.Read)
  @doc("Error message if the last discovery operation failed.")
  errorMessage?: string;

  @added(Versions.v2026_01_01_preview)
  @visibility(Lifecycle.Read)
  @doc("Error details if the last discovery operation failed.")
  error?: DiscoveryError;

  @removed(Versions.v2026_01_01_preview)
  @visibility(Lifecycle.Read)
  @doc("Number of discovered entities in the last discovery operation.")
  numberOfDiscoveredEntities?: int32;

  @visibility(Lifecycle.Read)
  @doc("Name of the entity which represents the discovery rule. Note: It might take a few minutes after creating the discovery rule until the entity is created.")
  entityName: string;
}

@added(Versions.v2026_01_01_preview)
@doc("Base model for discovery rule specifications")
@discriminator("kind")
model DiscoveryRuleSpecification {
  @doc("Kind of the discovery rule specification")
  kind: DiscoveryRuleKind;
}

@added(Versions.v2026_01_01_preview)
@doc("Discovery rule specification for an Azure Resource Graph query")
model ResourceGraphQuerySpecification extends DiscoveryRuleSpecification {
  @doc("Kind of the discovery rule specification")
  kind: DiscoveryRuleKind.ResourceGraphQuery;

  @doc("Azure Resource Graph query text in KQL syntax. The query must return at least a column named 'id' which contains the resource ID of the discovered resources.")
  @minLength(1)
  @maxLength(5000)
  resourceGraphQuery: string;
}

@added(Versions.v2026_01_01_preview)
@doc("Discovery rule specification for an Application Insights topology query")
model ApplicationInsightsTopologySpecification
  extends DiscoveryRuleSpecification {
  @doc("Kind of the discovery rule specification")
  kind: DiscoveryRuleKind.ApplicationInsightsTopology;

  @doc("Application Insights resource ID")
  applicationInsightsResourceId: armResourceIdentifier<[
    {
      type: "Microsoft.Insights/components";
    }
  ]>;
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

@added(Versions.v2026_01_01_preview)
@doc("Discovery rule specification kind discriminator")
union DiscoveryRuleKind {
  string,

  @doc("Azure Resource Graph query based discovery")
  ResourceGraphQuery: "ResourceGraphQuery",

  @doc("Application Insights topology based discovery")
  ApplicationInsightsTopology: "ApplicationInsightsTopology",
}

@added(Versions.v2026_01_01_preview)
@doc("Error details for a failed discovery operation")
model DiscoveryError {
  @visibility(Lifecycle.Read)
  @doc("Error message")
  message: string;

  @visibility(Lifecycle.Read)
  @doc("Additional context information, like resource IDs or query details")
  context?: string[];
}

@added(Versions.v2026_01_01_preview)
@doc("Request body for getting entity health history")
model EntityHistoryRequest {
  @doc("Start time for the history query. Defaults to 24 hours ago if not specified.")
  startAt?: utcDateTime;

  @doc("End time for the history query. Defaults to now if not specified.")
  endAt?: utcDateTime;
}

@added(Versions.v2026_01_01_preview)
@doc("Response containing entity health state transitions")
model EntityHistoryResponse {
  @doc("Name of the entity")
  entityName: entityName;

  @doc("List of health state transitions")
  @identifiers(#["occurredAt"])
  history: HealthStateTransition[];
}

@added(Versions.v2026_01_01_preview)
@doc("A health state transition record")
model HealthStateTransition {
  @doc("Previous health state before the transition")
  previousState: HealthState;

  @doc("New health state after the transition")
  newState: HealthState;

  @doc("Timestamp when the transition occurred")
  occurredAt: utcDateTime;

  @doc("Reason of the transition")
  reason?: string4096;
}

@added(Versions.v2026_01_01_preview)
@doc("Request body for getting signal history")
model SignalHistoryRequest {
  @doc("Name of the signal to get history for")
  signalName: signalName;

  @doc("Start time for the history query. Defaults to 24 hours ago if not specified.")
  startAt?: utcDateTime;

  @doc("End time for the history query. Defaults to now if not specified.")
  endAt?: utcDateTime;
}

@added(Versions.v2026_01_01_preview)
@doc("Response containing signal history")
model SignalHistoryResponse {
  @doc("Name of the entity")
  entityName: entityName;

  @doc("Name of the signal")
  signalName: signalName;

  @doc("Signal history data points")
  @identifiers(#["occurredAt"])
  history: SignalHistoryDataPoint[];
}

@added(Versions.v2026_01_01_preview)
@doc("A data point in the signal time series")
model SignalHistoryDataPoint {
  @doc("Timestamp of the data point")
  occurredAt: utcDateTime;

  @doc("Signal value at this point in time")
  value?: float64;

  @doc("Health state at this point in time")
  healthState: HealthState;

  @doc("Additional context as provided by the submitter")
  additionalContext?: string4096;
}

@added(Versions.v2026_01_01_preview)
@doc("Health report that's submitted for a specific signal")
model HealthReportRequest {
  @doc("Name of the entity signal to report health for")
  signalName: signalName;

  @doc("Health state to report for the signal")
  healthState: HealthState;

  @doc("Reported value of the signal")
  value?: float64;

  @doc("Evaluation rules that were used to determine the reported health state")
  evaluationRules?: HealthReportEvaluationRule;

  @doc("Number of minutes until the health report expires. Defaults to 60 (1 hour) if not specified.")
  @minValue(1)
  @maxValue(10080) // = 1 week
  expiresIn?: int32 = 60;

  @doc("Optional additional context or description for the health report")
  additionalContext?: string4096;
}

@added(Versions.v2026_01_01_preview)
@doc("Evaluation rules for the health report")
model HealthReportEvaluationRule {
  ...EvaluationRule;
}

alias TimestampQueryParam = {
  @doc("Timestamp to use for the operation. When specified, the version of the resource at this point in time is retrieved. If not specified, the latest version is used.")
  @query
  timestamp?: utcDateTime;
};

@armResourceOperations(HealthModel)
interface HealthModels {
  get is ArmResourceRead<HealthModel>;
  create is ArmResourceCreateOrUpdateAsync<HealthModel>;
  @patch(#{ implicitOptionality: true })
  update is ArmCustomPatchAsync<
    HealthModel,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      HealthModel,
      HealthModelProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<HealthModel>;
  listByResourceGroup is ArmResourceListByParent<HealthModel>;
  listBySubscription is ArmListBySubscription<HealthModel>;
}

@armResourceOperations(SignalDefinition)
interface SignalDefinitions {
  get is ArmResourceRead<SignalDefinition>;

  @removed(Versions.v2026_01_01_preview)
  @renamedFrom(Versions.v2026_01_01_preview, "createOrUpdate")
  @sharedRoute
  createOrUpdateV1 is ArmResourceCreateOrReplaceSync<SignalDefinition>;

  @removed(Versions.v2026_01_01_preview)
  @renamedFrom(Versions.v2026_01_01_preview, "delete")
  @sharedRoute
  deleteV1 is ArmResourceDeleteSync<SignalDefinition>;

  @added(Versions.v2026_01_01_preview)
  @sharedRoute
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SignalDefinition>;

  @added(Versions.v2026_01_01_preview)
  @sharedRoute
  delete is ArmResourceDeleteWithoutOkAsync<SignalDefinition>;

  listByHealthModel is ArmResourceListByParent<
    SignalDefinition,
    Azure.ResourceManager.Foundations.BaseParameters<SignalDefinition> &
      TimestampQueryParam
  >;
}

@armResourceOperations(AuthenticationSetting)
interface AuthenticationSettings {
  get is ArmResourceRead<AuthenticationSetting>;

  @removed(Versions.v2026_01_01_preview)
  @renamedFrom(Versions.v2026_01_01_preview, "createOrUpdate")
  @sharedRoute
  createOrUpdateV1 is ArmResourceCreateOrReplaceSync<AuthenticationSetting>;

  @removed(Versions.v2026_01_01_preview)
  @renamedFrom(Versions.v2026_01_01_preview, "delete")
  @sharedRoute
  deleteV1 is ArmResourceDeleteSync<AuthenticationSetting>;

  @added(Versions.v2026_01_01_preview)
  @sharedRoute
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AuthenticationSetting>;

  @added(Versions.v2026_01_01_preview)
  @sharedRoute
  delete is ArmResourceDeleteWithoutOkAsync<AuthenticationSetting>;

  listByHealthModel is ArmResourceListByParent<AuthenticationSetting>;
}

@armResourceOperations(Entity)
interface Entities {
  get is ArmResourceRead<Entity>;

  @removed(Versions.v2026_01_01_preview)
  @renamedFrom(Versions.v2026_01_01_preview, "createOrUpdate")
  @sharedRoute
  createOrUpdateV1 is ArmResourceCreateOrReplaceSync<Entity>;

  @removed(Versions.v2026_01_01_preview)
  @renamedFrom(Versions.v2026_01_01_preview, "delete")
  @sharedRoute
  deleteV1 is ArmResourceDeleteSync<Entity>;

  @added(Versions.v2026_01_01_preview)
  @sharedRoute
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Entity>;

  @added(Versions.v2026_01_01_preview)
  @sharedRoute
  delete is ArmResourceDeleteWithoutOkAsync<Entity>;

  listByHealthModel is ArmResourceListByParent<
    Entity,
    Azure.ResourceManager.Foundations.BaseParameters<Entity> &
      TimestampQueryParam
  >;

  @added(Versions.v2026_01_01_preview)
  @doc("Retrieve the health state transition history for an entity")
  @post
  @action("getHistory")
  getHistory is ArmResourceActionSync<
    Entity,
    EntityHistoryRequest,
    EntityHistoryResponse
  >;

  @added(Versions.v2026_01_01_preview)
  @doc("Retrieve the time series history for a signal on an entity")
  @post
  @action("getSignalHistory")
  getSignalHistory is ArmResourceActionSync<
    Entity,
    SignalHistoryRequest,
    SignalHistoryResponse
  >;

  @added(Versions.v2026_01_01_preview)
  @doc("Ingest a health report for a specific signal on an entity (the entity must already exist)")
  @post
  @action("ingestHealthReport")
  ingestHealthReport is ArmResourceActionNoContentSync<
    Entity,
    HealthReportRequest
  >;
}

@armResourceOperations(Relationship)
interface Relationships {
  get is ArmResourceRead<Relationship>;

  @removed(Versions.v2026_01_01_preview)
  @renamedFrom(Versions.v2026_01_01_preview, "createOrUpdate")
  @sharedRoute
  createOrUpdateV1 is ArmResourceCreateOrReplaceSync<Relationship>;

  @removed(Versions.v2026_01_01_preview)
  @renamedFrom(Versions.v2026_01_01_preview, "delete")
  @sharedRoute
  deleteV1 is ArmResourceDeleteSync<Relationship>;

  @added(Versions.v2026_01_01_preview)
  @sharedRoute
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Relationship>;

  @added(Versions.v2026_01_01_preview)
  @sharedRoute
  delete is ArmResourceDeleteWithoutOkAsync<Relationship>;

  listByHealthModel is ArmResourceListByParent<
    Relationship,
    Azure.ResourceManager.Foundations.BaseParameters<Relationship> &
      TimestampQueryParam
  >;
}

@armResourceOperations(DiscoveryRule)
interface DiscoveryRules {
  get is ArmResourceRead<DiscoveryRule>;

  @removed(Versions.v2026_01_01_preview)
  @renamedFrom(Versions.v2026_01_01_preview, "createOrUpdate")
  @sharedRoute
  createOrUpdateV1 is ArmResourceCreateOrReplaceSync<DiscoveryRule>;

  @removed(Versions.v2026_01_01_preview)
  @renamedFrom(Versions.v2026_01_01_preview, "delete")
  @sharedRoute
  deleteV1 is ArmResourceDeleteSync<DiscoveryRule>;

  @added(Versions.v2026_01_01_preview)
  @sharedRoute
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DiscoveryRule>;

  @added(Versions.v2026_01_01_preview)
  @sharedRoute
  delete is ArmResourceDeleteWithoutOkAsync<DiscoveryRule>;

  listByHealthModel is ArmResourceListByParent<
    DiscoveryRule,
    Azure.ResourceManager.Foundations.BaseParameters<DiscoveryRule> &
      TimestampQueryParam
  >;
}
