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

@armProviderNamespace("Microsoft.CloudHealth")
@service({
  title: "Microsoft.CloudHealth",
  version: "2023-10-01-preview",
})
@useDependency(Azure.Core.Versions.v1_0_Preview_2)
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.CloudHealth;

// Regex for all our resource name validations
alias resourceNameRegex = "^(?=[a-zA-Z0-9-]{3,60}$)(?!-)(?!.*--)[a-zA-Z0-9]+(?:-[a-zA-Z0-9]+)*$";

@pattern(resourceNameRegex)
scalar stringResourceName extends string;

@maxLength(4096)
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
    @doc("Enabled state of the health model. When disabled, no health data is collected and no health state is propagated.")
    enabledState: EnabledState;

    @visibility("read")
    @doc("The data plane endpoint for interacting with health data")
    dataplaneEndpoint?: string;

    @visibility("read")
    @doc("The status of the last operation.")
    provisioningState?: HealthModelProvisioningState;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Self-explanatory"
@doc("Enabled state of the health model")
enum EnabledState {
    Enabled,
    Disabled,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Self-explanatory"
@doc("Health Model provisioning states")
enum HealthModelProvisioningState {
    ...ResourceProvisioningState, // include standard provisioning states
    Creating,
    Deleting
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
enum SignalKind{
    AzureResourceMetric,
    LogAnalyticsQuery,
    PrometheusMetricsQuery
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
    @knownValues(SignalKind)
    signalKind: string; // Cannot use enum directly due to bug https://github.com/Azure/typespec-azure/issues/3574

    @doc("Interval in which the signal is being evaluated.")
    refreshInterval?: RefreshInterval;

    @doc("Optional set of labels (key-value pairs)") // Since Signal Definition is a proxy resource, we cannot use Azure Tags
    labels?: Record<string4096>;

    @doc("Time range of signal")
    @minLength(1)
    @maxLength(100)
    timeGrain?: string;

    @doc("Unit of the signal result (e.g. Bytes, MilliSeconds, Percent, Count))")
    @minLength(1)
    @maxLength(100)
    dataUnit?: string;

    @doc("Evaluation rules for the signal definition")
    evaluationRules: EvaluationRule;

    @doc("Signal definition enabled state")
    enabledState: SignalEnabledState;

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
    @doc("Operator")
    dynamicThresholdModel: DynamicThresholdModel;

    @doc("ML model sensitivity")
    modelSensitivity?: int32;
}

@doc("ML-based model variants")
enum DynamicThresholdModel {
    @doc("Anomaly detection model")
    AnomalyDetection,
}

@doc("Refresh interval")
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
    signalKind: "AzureResourceMetric";

    @doc("Metric namespace")
    @minLength(1)
    @maxLength(256)
    metricNamespace: string;

    @doc("Name of the metric")
    @minLength(1)
    @maxLength(256)
    metricName: string;

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
    signalKind: "LogAnalyticsQuery";

    @doc("Query text in KQL syntax")
    @minLength(1)
    @maxLength(5000)
    queryText: string;

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
    signalKind: "PrometheusMetricsQuery";

    @doc("Query text in PromQL syntax")
    @minLength(1)
    @maxLength(5000)
    queryText: string;
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
@doc("Signal enabled state")
enum SignalEnabledState {
    Enabled,
    Disabled,
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
enum AuthenticationKind{
    ManagedIdentity,
    Other // for future extensibility, not used yet but linter needs at least two enum values
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
    @knownValues(AuthenticationKind)
    authenticationKind: string; // Cannot use enum directly due to bug https://github.com/Azure/typespec-azure/issues/3574
}

@doc("Authentication setting properties for Azure Managed Identity")
model ManagedIdentityAuthenticationSettingProperties extends AuthenticationSettingProperties {
    @doc("Kind of the authentication setting")
    authenticationKind: "ManagedIdentity";

    @doc("Name of the managed identity to use. Either 'SystemAssigned' or the resourceId of a user-assigned identity.")
    @minLength(1)
    @maxLength(500)
    managedIdentityName: string;
}

@doc("An entity (aka node) a health model")
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

    @doc("Service level objective")
    @minValue(0)
    @maxValue(100)
    serviceLevelObjective?: float32;

    @doc("Impact of the entity in health state propagation")
    impact?: EntityImpact = EntityImpact.Standard;

    @doc("Optional set of labels (key-value pairs)") // Since Entity is a proxy resource, we cannot use Azure Tags
    labels?: Record<string4096>;

    @doc("Signal groups which are assigned to this entity")
    signals?: SignalGroup;

    @visibility("read")
    @doc("Indicates whether this entity was dynamically discovered. If true, the entity cannot be deleted manually.")
    isDynamicallyDiscovered?: boolean;

    @visibility("read")
    @doc("Date when the entity was (soft-)deleted")
    deletionDate?: utcDateTime;
}

@doc("Visual icon definition of an entity")
model IconDefinition {
    @doc("Name of the built-in icon, or 'Custom' to use customData")
    @minLength(1)
    @maxLength(100)
    icon: string;

    @doc("Custom data. Base64-encoded SVG data. If set, this overrides the built-in icon.")
    @minLength(1)
    @maxLength(5000)
    customData?: string;
}

@doc("Contains various signal groups that can be assigned to an entity")
model SignalGroup {
    @doc("Azure Resource Signal Group. Can only be defined if dynamicAzureResourceDefinition is not defined.")
    azureResource?: AzureResourceSignalGroup;

    @doc("Dynamic Azure Resource Signal Group. Can only be defined if azureResource is not defined.")
    dynamicAzureResources?: DynamicAzureResourcesSignalGroup;

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
    @maxItems(50)
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
    logAnalyticsWorkspaceId: uuid;
}

@doc("A grouping of signal assignments for a Azure Monitor Workspace")
model AzureMonitorWorkspaceSignalGroup is SignalAssignmentGroup {
    @doc("Azure Monitor workspace resource ID")
    azureMonitorWorkspaceResourceId: AzureMonitorWorkspaceResourceId;
}

@doc("A grouping of signal assignments for dynamic Azure Resources")
model DynamicAzureResourcesSignalGroup is SignalAssignmentGroup {
    @doc("Azure Resource Graph query in KQL syntax to select a dynamic set of Azure resources")
    @minLength(1)
    @maxLength(5000)
    azureResourceGraphQuery: string;
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
    @doc("Name of the relationship. Must be unique within a health model. For example, a concatination of parentEntityName and childEntityName can be used as the name.")
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
    @doc("Indicates whether this relationship was dynamically discovered. If true, the relationship cannot be deleted manually.")
    isDynamicallyDiscovered?: boolean;

    @visibility("read")
    @doc("Date when the relationship was (soft-)deleted")
    deletionDate?: utcDateTime;
}

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
interface SignalDefinitions{
    get is ArmResourceRead<SignalDefinition>;
    createOrUpdate is ArmResourceCreateOrUpdateSync<SignalDefinition>;
    delete is ArmResourceDeleteSync<SignalDefinition>;

    listByParent is ArmResourceListByParent<SignalDefinition>;
}


@armResourceOperations
interface AuthenticationSettings {
    get is ArmResourceRead<AuthenticationSetting>;
    createOrUpdate is ArmResourceCreateOrUpdateSync<AuthenticationSetting>;
    delete is ArmResourceDeleteSync<AuthenticationSetting>;

    listByParent is ArmResourceListByParent<AuthenticationSetting>;
}


@armResourceOperations
interface Entities {
    get is ArmResourceRead<Entity>;
    createOrUpdate is ArmResourceCreateOrUpdateSync<Entity>;
    delete is ArmResourceDeleteSync<Entity>;

    listByParent is ArmResourceListByParent<Entity>;
}

@armResourceOperations
interface Relationships {
    get is ArmResourceRead<Relationship>;
    createOrUpdate is ArmResourceCreateOrUpdateSync<Relationship>;
    delete is ArmResourceDeleteSync<Relationship>;

    listByParent is ArmResourceListByParent<Relationship>;
}
