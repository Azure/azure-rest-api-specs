import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

@armProviderNamespace(ProviderName)
@service({
  title: ProviderName,
  version: "2023-10-01-preview",
})
@useDependency(Azure.Core.Versions.v1_0_Preview_2)
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
@armCommonTypesVersion(CommonTypes.Versions.v5)
namespace Microsoft.CloudHealth;

alias ProviderName = "Microsoft.CloudHealth";

// Regex for all our resource name validations. Up to 60 characters, alphanumeric and hyphens, must start and end with an alphanumeric character
alias resourceNameRegex = "^[a-zA-Z0-9][a-zA-Z0-9-]{1,58}[a-zA-Z0-9]$";

@pattern(resourceNameRegex)
@doc("String with regex validation to match the resource name requirements")
scalar stringResourceName extends string;

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
  name: stringResourceName;

  ...ManagedServiceIdentity;
  ...ResourceSku;
}

@doc("HealthModel properties")
model HealthModelProperties {
  @visibility("read")
  @doc("The data plane endpoint for interacting with health data")
  dataplaneEndpoint?: string;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: HealthModelProvisioningState;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Self-explanatory"
@doc("Health Model provisioning states")
enum HealthModelProvisioningState {
  ...ResourceProvisioningState, // include standard provisioning states
  Creating,
  Deleting,
}

@doc("A signal definition in a health model")
@parentResource(HealthModel)
model SignalDefinition is ProxyResource<SignalDefinitionProperties> {
  @doc("Name of the signal definition. Must be unique within a health model.")
  @key("signalDefinitionName")
  @segment("signaldefinitions")
  @path
  name: stringResourceName;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Self-explanatory"
@doc("Supported signal kinds as discriminator")
enum SignalKind {
  AzureResourceMetric,
  LogAnalyticsQuery,
  PrometheusMetricsQuery,
}

@doc("SignalDefinition properties")
@discriminator("signalKind")
model SignalDefinitionProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: HealthModelProvisioningState;

  @doc("Display name")
  @minLength(1)
  @maxLength(100)
  displayName?: string;

  @doc("Kind of the signal definition")
  signalKind: SignalKind;

  @doc("Interval in which the signal is being evaluated. Defaults to PT1M.")
  refreshInterval?: RefreshInterval = RefreshInterval.PT1M;

  @doc("Optional set of labels (key-value pairs)") // Since Signal Definition is a proxy resource, we cannot use Azure Tags
  labels?: Record<string4096>;

  @doc("Unit of the signal result (e.g. Bytes, MilliSeconds, Percent, Count))")
  @minLength(1)
  @maxLength(100)
  dataUnit?: string;

  @doc("Evaluation rules for the signal definition")
  evaluationRules: EvaluationRule;

  @visibility("read")
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
enum DynamicThresholdModel {
  @doc("Anomaly detection model")
  AnomalyDetection,
}

@doc("Threshold direction for dynamic thresholds")
enum DynamicThresholdDirection {
  @doc("Lower than")
  LowerThan,

  @doc("Greater than")
  GreaterThan,

  @doc("Greater or Lower Than")
  GreaterOrLowerThan,
}

@doc("Refresh interval in ISO duration format")
enum RefreshInterval {
  @doc("One Minute")
  PT1M,

  @doc("Five Minutes")
  PT5M,

  @doc("Ten Minutes")
  PT10M,

  @doc("Thirty Minutes")
  PT30M,

  @doc("One Hour")
  PT1H,

  @doc("Two Hours")
  PT2H,
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

  @doc("Name of the column in the result set to evaluate against the thresholds. Defaults to the first column in the result set if not specified.")
  @minLength(1)
  @maxLength(100)
  valueColumnName?: string;

  @doc("Data type of the result")
  dataType: ResultDataType;
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
enum SignalOperator {
  @doc("Lower than")
  LowerThan,

  @doc("Lower than or equal to")
  LowerOrEquals,

  @doc("Greater than")
  GreaterThan,

  @doc("Greater than or equal to")
  GreaterOrEquals,

  @doc("Equal to")
  Equals,

  @doc("Contains (only applicable for text data type)")
  Contains,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Self-explanatory"
@doc("Metric aggregation type")
enum MetricAggregationType {
  None,
  Average,
  Count,
  Minimum,
  Maximum,
  Total,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Self-explanatory"
@doc("Result data type")
enum ResultDataType {
  Numeric,
  Text,
}

@doc("An authentication setting in a health model")
@parentResource(HealthModel)
model AuthenticationSetting is ProxyResource<AuthenticationSettingProperties> {
  @doc("Name of the authentication setting. Must be unique within a health model.")
  @key("authenticationSettingName")
  @segment("authenticationsettings")
  @path
  name: stringResourceName;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Self-explanatory"
@doc("Supported kinds of authentication settings as discriminator")
enum AuthenticationKind {
  ManagedIdentity,
  // More will be added later here
}

@doc("Authentication setting properties")
@discriminator("authenticationKind")
model AuthenticationSettingProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: HealthModelProvisioningState;

  @doc("Display name")
  @minLength(1)
  @maxLength(100)
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

@doc("An entity (aka node) of a health model")
@parentResource(HealthModel)
model Entity is ProxyResource<EntityProperties> {
  @doc("Name of the entity. Must be unique within a health model.")
  @key("entityName")
  @segment("entities")
  @path
  name: stringResourceName;
}

@doc("Properties which are common across all kinds of entities")
model EntityProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: HealthModelProvisioningState;

  @doc("Display name")
  @minLength(1)
  @maxLength(100)
  displayName?: string;

  @doc("Positioning of the entity on the model canvas")
  canvasPosition?: EntityCoordinates;

  @doc("Visual icon definition. If not set, a default icon is used.")
  icon?: IconDefinition;

  @doc("Health objective as a percentage of time the entity should be healthy.")
  @minValue(0)
  @maxValue(100)
  healthObjective?: float32;

  @doc("Impact of the entity in health state propagation")
  impact?: EntityImpact = EntityImpact.Standard;

  @doc("Optional set of labels (key-value pairs)") // Since Entity is a proxy resource, we cannot use Azure Tags
  labels?: Record<string4096>;

  @doc("Signal groups which are assigned to this entity")
  signals?: SignalGroup;

  @visibility("read")
  @doc("Discovered by which discovery rule. If set, the entity cannot be deleted manually.")
  discoveredBy?: stringResourceName;

  @visibility("read")
  @doc("Date when the entity was (soft-)deleted")
  deletionDate?: utcDateTime;

  @visibility("read")
  @doc("Health state of this entity")
  healthState?: HealthState;
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

@doc("Contains various signal groups that can be assigned to an entity")
model SignalGroup {
  @doc("Azure Resource Signal Group")
  azureResource?: AzureResourceSignalGroup;

  @doc("Log Analytics Signal Group")
  azureLogAnalytics?: LogAnalyticsSignalGroup;

  @doc("Azure Monitor Workspace Signal Group")
  azureMonitorWorkspace?: AzureMonitorWorkspaceSignalGroup;

  @doc("Settings for dependent entities, i.e. child entities")
  dependentEntities?: DependentEntitiesSignalGroup;
}

@doc("Properties for dependent entities, i.e. child entities")
model DependentEntitiesSignalGroup {
  @doc("Minimum number of children entities that need to be healthy in order for this entity to be considered healthy.")
  @minValue(1)
  requiredHealthyChildren?: int32;
}

@doc("A grouping of signal assignments and link to a data source")
model SignalAssignmentGroup {
  @doc("Signal definitions which are assigned to this signal group. All assignments are combined with an OR operator.")
  @extension("x-ms-identifiers", [])
  @maxItems(50)
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
  azureResourceId: ResourceIdentifier;
}

@doc("A grouping of signal assignments for a Log Analytics Workspace")
model LogAnalyticsSignalGroup is SignalAssignmentGroup {
  @doc("Log Analytics Workspace resource ID")
  logAnalyticsWorkspaceResourceId: LogAnalyticsWorkspaceResourceId;

  @doc("Log Analytics workspace ID") // Ideally, we dont need this since we also have the Resource Id. But at the moment we need this ID for querying
  @minLength(36)
  @maxLength(36)
  logAnalyticsWorkspaceId: string;
}

@doc("A grouping of signal assignments for a Azure Monitor Workspace")
model AzureMonitorWorkspaceSignalGroup is SignalAssignmentGroup {
  @doc("Azure Monitor workspace resource ID")
  azureMonitorWorkspaceResourceId: AzureMonitorWorkspaceResourceId;
}

@doc("Type of impact an entity has on health state propagation")
enum EntityImpact {
  @doc("Standard impact")
  Standard,

  @doc("Limited impact")
  Limited,

  @doc("Suppressed impact")
  Suppressed,
}

@doc("Health state of an entity")
enum HealthState {
  @doc("Healthy status")
  Healthy,

  @doc("Degraded status")
  Degraded,

  @doc("Error status (Unhealthy)")
  Error,

  @doc("Unknown status")
  Unknown,

  @doc("Deleted status")
  Deleted,
}

@doc("Visual position of the entity")
model EntityCoordinates {
  @doc("X Coordinate")
  x: float32;

  @doc("Y Coordinate")
  y: float32;
}

scalar LogAnalyticsWorkspaceResourceId
  extends ResourceIdentifier<[
    {
      type: "Microsoft.OperationalInsights/workspaces",
    }
  ]>;

scalar AzureMonitorWorkspaceResourceId
  extends ResourceIdentifier<[
    {
      type: "Microsoft.Monitor/accounts",
    }
  ]>;

@doc("A relationship (aka edge) between two entities in a health model")
@parentResource(HealthModel)
model Relationship is ProxyResource<RelationshipProperties> {
  @doc("Name of the relationship. Must be unique within a health model. For example, a concatenation of parentEntityName and childEntityName can be used as the name.")
  @key("relationshipName")
  @segment("relationships")
  @path
  name: stringResourceName;
}

@doc("Relationship properties")
model RelationshipProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: HealthModelProvisioningState;

  @doc("Resource name of the parent entity")
  @visibility("create", "read") // this cannot be changed
  parentEntityName: stringResourceName;

  @doc("Resource name of the child entity")
  @visibility("create", "read") // this cannot be changed
  childEntityName: stringResourceName;

  @doc("Optional set of labels (key-value pairs)") // Since Relationship is a proxy resource, we cannot use Azure Tags
  labels?: Record<string4096>;

  @visibility("read")
  @doc("Discovered by which discovery rule. If set, the relationship cannot be deleted manually.")
  discoveredBy?: stringResourceName;

  @visibility("read")
  @doc("Date when the relationship was (soft-)deleted")
  deletionDate?: utcDateTime;
}

@doc("A discovery rule which automatically finds entities and relationships in a health model based on an Azure Resource Graph query")
@parentResource(HealthModel)
model DiscoveryRule is ProxyResource<DiscoveryRuleProperties> {
  @doc("Name of the discovery rule. Must be unique within a health model.")
  @key("discoveryRuleName")
  @segment("discoveryrules")
  @path
  name: stringResourceName;
}

@doc("Discovery rule properties")
model DiscoveryRuleProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: HealthModelProvisioningState;

  @doc("Display name")
  @minLength(1)
  @maxLength(100)
  displayName?: string;

  @doc("Azure Resource Graph query text in KQL syntax. The query must return at least a column named 'id' which contains the resource ID of the discovered resources.")
  @minLength(1)
  @maxLength(5000)
  resourceGraphQuery: string;

  @doc("Reference to the name of the authentication setting which is used for querying Azure Resource Graph. The same authentication setting will also be assigned to any discovered entities.")
  authenticationSetting: stringResourceName;

  @doc("Whether to create relationships between the discovered entities based on a set of built-in rules. These relationships cannot be manually deleted.")
  discoverRelationships: DiscoveryRuleRelationshipDiscoveryBehavior;

  @doc("Whether to add all recommended signals to the discovered entities.")
  addRecommendedSignals: DiscoveryRuleRecommendedSignalsBehavior;

  @visibility("read")
  @doc("Date when the discovery rule was (soft-)deleted")
  deletionDate?: utcDateTime;

  @visibility("read")
  @doc("Error message if the last discovery operation failed.")
  errorMessage?: string;

  @visibility("read")
  @doc("Number of discovered entities in the last discovery operation.")
  numberOfDiscoveredEntities?: int32;
}

@doc("Discovery rule relationship discovery behavior")
enum DiscoveryRuleRelationshipDiscoveryBehavior {
  @doc("Automatically attempt to discover relationships")
  Enabled,

  @doc("Do not automatically attempt to discover relationships")
  Disabled,
}

@doc("Discovery rule recommended signal behavior")
enum DiscoveryRuleRecommendedSignalsBehavior {
  @doc("Automatically add recommended signals")
  Enabled,

  @doc("Do not automatically add recommended signals")
  Disabled,
}

alias TimestampQueryParam = {
  @doc("Timestamp to use for the operation. When specified, the version of the resource at this point in time is retrieved. If not specified, the latest version is used.")
  @query
  timestamp?: utcDateTime;
};

@armResourceOperations
interface HealthModels {
  get is ArmResourceRead<HealthModel>;
  create is ArmResourceCreateOrUpdateAsync<HealthModel>;
  update is ArmResourcePatchAsync<HealthModel, HealthModelProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<HealthModel>;
  listByResourceGroup is ArmResourceListByParent<HealthModel>;
  listBySubscription is ArmListBySubscription<HealthModel>;
}

@armResourceOperations
interface SignalDefinitions {
  get is ArmResourceRead<SignalDefinition>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<SignalDefinition>;
  delete is ArmResourceDeleteSync<SignalDefinition>;

  listByParent is ArmResourceListByParent<
    SignalDefinition,
    BaseParameters<SignalDefinition> & TimestampQueryParam
  >;
}

@armResourceOperations
interface AuthenticationSettings {
  get is ArmResourceRead<AuthenticationSetting>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<AuthenticationSetting>;
  delete is ArmResourceDeleteSync<AuthenticationSetting>;

  listByParent is ArmResourceListByParent<AuthenticationSetting>;
}

@armResourceOperations
interface Entities {
  get is ArmResourceRead<Entity>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<Entity>;
  delete is ArmResourceDeleteSync<Entity>;

  listByParent is ArmResourceListByParent<
    Entity,
    BaseParameters<Entity> & TimestampQueryParam
  >;
}

@armResourceOperations
interface Relationships {
  get is ArmResourceRead<Relationship>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<Relationship>;
  delete is ArmResourceDeleteSync<Relationship>;

  listByParent is ArmResourceListByParent<
    Relationship,
    BaseParameters<Relationship> & TimestampQueryParam
  >;
}

@armResourceOperations
interface DiscoveryRules {
  get is ArmResourceRead<DiscoveryRule>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<DiscoveryRule>;
  delete is ArmResourceDeleteSync<DiscoveryRule>;

  listByParent is ArmResourceListByParent<
    DiscoveryRule,
    BaseParameters<DiscoveryRule> & TimestampQueryParam
  >;
}
