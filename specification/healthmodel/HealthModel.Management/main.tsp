import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service({
    title: "HealthModel ProviderHub Client",
    version: "2022-11-01-preview",
})
@doc("Microsoft.HealthModel Resource Provider management API.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.HealthModel;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("A HealthModel resource")
model HealthModel is TrackedResource<HealthModelProperties> {
    @doc("Name of health model resource")
    @pattern("^(?=[a-zA-Z0-9-]{3,60}$)(?!-)(?!.*--)[a-zA-Z0-9]+(?:-[a-zA-Z0-9]+)*$")
    @key("healthModelName")
    @path
    @segment("healthmodels")
    name: string;
    ...ManagedServiceIdentity;
}

@doc("HealthModel properties")
model HealthModelProperties {
    @doc("Interval in which the health model state is being evaluated and new snapshots are created.")
    refreshInterval?: RefreshInterval;

    @doc("Active state of the health model")
    activeState: ActiveState;

    @visibility("read")
    @doc("Version number of the model")
    versionNumber?: string;

    @visibility("read")
    @doc("The status of the last operation.")
    provisioningState?: ResourceProvisioningState;

    @doc("The list of nodes in the health model")
    @extension("x-ms-identifiers", ["nodeId"])
    nodes?: Node[];
}

@doc("Active state of the health model")
enum ActiveState {
    Active,
    Inactive,
}

@doc("Refresh interval of the health model")
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

@doc("A Node in the health model")
@discriminator("nodeType")
model Node {
    @doc("Id of the node")
    @pattern("^(?![-_.]*$)[_\\-\\.\\w\\d]{1,40}$")
    nodeId: string;

    @doc("Name of the node")
    @minLength(1)
    @maxLength(100)
    name: string;

    @doc("List of children Node IDs")
    childNodeIds?: string[];

    @doc("Kind of the node")
    nodeKind?: string;

    @doc("Impact of the node in health state propagation")
    impact?: NodeImpact = NodeImpact.Standard;

    @doc("List of queries")
    @extension("x-ms-identifiers", ["queryId"])
    queries?: Query[];

    @doc("Optional query endpoint to use for queries of this node. If not specified, the default endpoint for the respective query will be used.")
    queryEndpoint?: string;

    @doc("Health target in percent")
    @minValue(0)
    @maxValue(100)
    healthTargetPercentage?: float32;

    @doc("Credential to use for queries of this node. Not required on Aggregation Nodes.")
    @minLength(1)
    @maxLength(100)
    credentialId?: string;

    @doc("Visual of the node")
    visual?: NodeVisual;
}

@doc("Aggregation node which does not have any queries itself")
model AggregationNode extends Node {
    @doc("Type of the node")
    nodeType: "AggregationNode";
}

@doc("Node for an Azure Resource data source")
model AzureResourceNode extends Node {
    @doc("Type of the node")
    nodeType: "AzureResourceNode";

    @doc("Azure resource ID")
    azureResourceId: ResourceIdentifier;

    @doc("Log Analytics resource ID")
    @extension(
        "x-ms-arm-id-details",
        {
            allowedResources: ["Microsoft.OperationalInsights/workspaces"],
        }
    )
    logAnalyticsResourceId?: ResourceIdentifier;

    @doc("Log Analytics workspace ID")
    @format("uuid")
    logAnalyticsWorkspaceId?: string;
}

@doc("Node for a Log Analytics data source")
model LogAnalyticsNode extends Node {
    @doc("Type of the node")
    nodeType: "LogAnalyticsNode";

    @doc("Log Analytics resource ID")
    @extension(
        "x-ms-arm-id-details",
        {
            allowedResources: ["Microsoft.OperationalInsights/workspaces"],
        }
    )
    logAnalyticsResourceId: ResourceIdentifier;

    @doc("Log Analytics workspace ID")
    @format("uuid")
    logAnalyticsWorkspaceId: string;
}

@doc("Node for a Prometheus data source")
model PrometheusNode extends Node {
    @doc("Type of the node")
    nodeType: "PrometheusNode";

    @doc("Azure Monitor workspace resource ID")
    @extension(
        "x-ms-arm-id-details",
        {
            allowedResources: ["Microsoft.Monitor/accounts"],
        }
    )
    azureMonitorWorkspaceResourceId: ResourceIdentifier;
}

@doc("Node for a Application Insights data source")
model ApplicationInsightsNode extends Node {
    @doc("Type of the node")
    nodeType: "ApplicationInsightsNode";

    @doc("Application Insights resource ID")
    @extension(
        "x-ms-arm-id-details",
        {
            allowedResources: ["Microsoft.Insights/components"],
        }
    )
    applicationInsightsResourceId: ResourceIdentifier;

    @doc("Log Analytics resource ID")
    @extension(
        "x-ms-arm-id-details",
        {
            allowedResources: ["Microsoft.OperationalInsights/workspaces"],
        }
    )
    logAnalyticsResourceId: ResourceIdentifier;

    @doc("Log Analytics workspace ID")
    @format("uuid")
    logAnalyticsWorkspaceId: string;
}

@doc("Type of impact a node has on health state propagation")
enum NodeImpact {
    Standard,
    Limited,
    Suppressed,
}

@doc("Visual of the node")
model NodeVisual {
    @doc("X Coordinate")
    x: float32;

    @doc("Y Coordinate")
    y: float32;
}

@doc("A Query of a health model node")
@discriminator("queryType")
model Query {
    @doc("Query ID")
    @pattern("^(?![-_.]*$)[_\\-\\.\\w\\d]{1,40}$")
    queryId: string;

    @doc("Degraded threshold")
    @minLength(1)
    @maxLength(100)
    degradedThreshold: string;

    @doc("Unhealthy threshold")
    @minLength(1)
    @maxLength(100)
    unhealthyThreshold: string;

    @doc("Degraded operator")
    degradedOperator: QueryOperator;

    @doc("Unhealthy operator")
    unhealthyOperator: QueryOperator;

    @doc("Time range of the query")
    @minLength(1)
    @maxLength(100)
    timeGrain?: string;

    @doc("Unit of the query result")
    @minLength(1)
    @maxLength(100)
    dataUnit?: string;

    @doc("Query enabled state")
    enabledState: QueryEnabledState;
}

@doc("Query for a Log Analytics data source")
model LogQuery extends Query {
    @doc("Type of the query")
    queryType: "LogQuery";

    @doc("Name of the query")
    @minLength(1)
    @maxLength(100)
    name: string;

    @doc("Query text")
    @minLength(1)
    @maxLength(5000)
    queryText: string;

    @doc("Name of the column in the result set to evaluate against the thresholds. Defaults to 'value' if not specified.")
    @minLength(1)
    @maxLength(100)
    valueColumnName?: string = "value";

    @doc("Data type of the result")
    dataType: ResultDataType;

    @doc("Query Text in encoded format")
    @visibility("read")
    encodedQuery?: string;
}

@doc("Metrics query for an Azure Resource data source")
model ResourceMetricsQuery extends Query {
    @doc("Type of the query")
    queryType: "ResourceMetricsQuery";

    @doc("Name of the metric to query")
    @minLength(1)
    @maxLength(100)
    metricName: string;

    @doc("Metric namespace")
    @minLength(1)
    @maxLength(100)
    metricNamespace: string;

    @doc("Name of the column in the result set to evaluate against the thresholds. Defaults to 'value' if not specified.")
    aggregationType: MetricAggregationType;

    @doc("Optional: Dimension to split by")
    @minLength(1)
    @maxLength(100)
    dimension?: string;

    @doc("Optional: Dimension filter to apply to the dimension. Must only be set if also Dimension is set.")
    @minLength(1)
    @maxLength(100)
    dimensionFilter?: string;
}

@doc("Query for a Prometheus data source")
model PrometheusMetricsQuery extends Query {
    @doc("Type of the query")
    queryType: "PrometheusMetricsQuery";

    @doc("Name of the query")
    @minLength(1)
    @maxLength(100)
    name: string;

    @doc("Query text")
    @minLength(1)
    @maxLength(5000)
    queryText: string;
}

@doc("Result data type")
enum ResultDataType {
    Numeric,
    Text,
}

@doc("Metric aggregation type")
enum MetricAggregationType {
    None,
    Average,
    Count,
    Minimum,
    Maximum,
    Total,
}

@doc("Query operator")
enum QueryOperator {
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

    @doc("Contains")
    Contains,
}

@doc("Query enabled state")
enum QueryEnabledState {
    @doc("Enabled")
    Enabled,

    @doc("Disabled")
    Disabled,
}

@doc("Runstate of the health model")
model RunstateResponse {
    @doc("Version number of the model")
    healthModelVersionNumber: string;

    @doc("Name of the cron job")
    cronJobName?: string;

    @doc("Date when the cron job was created")
    cronJobCreation?: utcDateTime;

    @doc("Date when the cron job was last updated")
    cronJobLastUpdated?: utcDateTime;

    @doc("Date when the cron job was last scheduled")
    lastScheduled?: utcDateTime;

    @doc("Date when the cron job was last successfully run")
    lastSuccessfulRun?: utcDateTime;

    @doc("Cron schedule of the cron job")
    cronSchedule?: string;
}

@doc("A specific version of a health model")
@parentResource(HealthModel)
model HealthModelVersion is ProxyResource<HealthModelVersionProperties> {
    @key("versionNumber")
    @segment("versions")
    @path
    @doc("Version number of a health model")
    @visibility("read")
    name: string;
}

@doc("HealthModel properties")
model HealthModelVersionProperties {
    @visibility("read")
    @doc("The status of the last operation.")
    provisioningState?: ResourceProvisioningState;

    @doc("The list of nodes in the health model")
    @extension("x-ms-identifiers", ["nodeId"])
    @visibility("read")
    nodes?: Node[];
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Health Model Versions cannot be deleted individually."
@armResourceOperations
interface HealthModelVersions
    extends Azure.ResourceManager.ResourceRead<HealthModelVersion> {}

@doc("Request to list the history of a specific node")
model ListNodeHistoryRequest {
    @doc("Id of the node to get history for")
    @pattern("^(?![-_.]*$)[_\\-\\.\\w\\d]{1,40}$")
    nodeId: string;

    @doc("Start time of the time range to filter the results. If not specified, the default is 1 day before the current time.")
    queryFrom?: utcDateTime;

    @doc("End time of the time range to filter the results. If not specified, the default is the current time.")
    queryTo?: utcDateTime;

    @doc("Optional: Timegrain. ISO duration format like PT10M. If set, the result will be aggregated by this interval. If not set, full results including query results for every snapshots are sent.")
    timeGrain?: string;
}

@doc("Request to get health state distribution in a timespan for a node")
model NodeHealthStateDistributionRequest {
    @doc("Id of the node to get history for")
    @pattern("^(?![-_.]*$)[_\\-\\.\\w\\d]{1,40}$")
    nodeId: string;

    @doc("Timespan")
    timespan: NodeStateDistributionTimespan;
}

@doc("Refresh interval of the health model")
enum NodeStateDistributionTimespan {
    @doc("7 days")
    P7D,

    @doc("30 days")
    P30D,

    @doc("90 days")
    P90D,

    @doc("180 days")
    P180D,

    @doc("365 days")
    P365D,
}

@doc("A point-in-time snapshot result of a health model")
@parentResource(HealthModel)
model Snapshot is ProxyResource<SnapshotProperties> {
    @key("snapshotId")
    @segment("snapshots")
    @path
    @doc("Id of the snapshot. Use 'latest' to get the latest snapshot.")
    @visibility("read")
    name: string;
}

@doc("Properties of a snapshot")
model SnapshotProperties {
    @doc("Version number of the model")
    healthModelVersionNumber: string;

    @doc("Time when the snapshot was generated")
    timeGenerated: utcDateTime;

    @doc("Overall state of this snapshot")
    overallState: HealthState;

    @doc("Execution duration of the snapshot")
    executionDuration: string;

    @doc("List of node states in the snapshot")
    @extension("x-ms-identifiers", ["nodeId"])
    nodeStates?: NodeState[];

    @doc("List of query results in the snapshot")
    @extension("x-ms-identifiers", ["nodeId", "queryId"])
    queryResults?: QueryResult[];

    @visibility("read")
    @doc("The status of the last operation.")
    provisioningState?: ResourceProvisioningState;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Snapshots cannot be deleted individually."
@armResourceOperations
interface Snapshots
    extends Azure.ResourceManager.ResourceRead<Snapshot>,
        Azure.ResourceManager.ResourceListByParent<Snapshot> {}

@doc("A point-in-time state of a node in a health model")
model NodeStatePointInTime {
    @doc("Time when the snapshot was generated")
    timeGenerated: utcDateTime;

    @doc("Health state of the node")
    healthState: HealthState;

    @doc("Health score of the node")
    healthScore: float32;

    @doc("List of query states in the snapshot")
    @extension("x-ms-identifiers", ["queryId"])
    queryStates?: QueryState[];
}

@doc("A point-in-time state of a node in a health model")
model NodeState {
    @doc("Id of the node")
    nodeId: string;

    @doc("Time when the snapshot was generated")
    timeGenerated: utcDateTime;

    @doc("Health state of the node")
    healthState: HealthState;

    @doc("Health score of the node")
    healthScore: float32;
}

@doc("A result of a query in a health model")
model QueryResult {
    @doc("Query ID")
    queryId: string;

    @doc("Id of the node")
    nodeId: string;

    @doc("Time when the snapshot was generated")
    timeGenerated: utcDateTime;

    @doc("Execution duration of the query")
    queryExecutionDuration: string;

    @doc("Health state of the query")
    healthState: HealthState;

    @doc("Query result value")
    resultValue?: string;

    @doc("Query result error")
    error?: string;
}

@doc("A state of a query in a health model")
model QueryState {
    @doc("Query ID")
    queryId: string;

    @doc("Health state of the query")
    queryHealthState: HealthState;
}

@doc("Health state of either a node or a query")
enum HealthState {
    Healthy,
    Degraded,
    Unhealthy,
    Unknown,
}

@doc("Distribution of health states of a node in a timespan")
model NodeHealthStateDistribution {
    @doc("Percentage of healthy data points")
    healthyPercentage?: float32;

    @doc("Percentage of degraded data points")
    degradedPercentage?: float32;

    @doc("Percentage of unhealthy data points")
    unhealthyPercentage?: float32;

    @doc("Percentage of unknown data points")
    unknownPercentage?: float32;

    @doc("Total number of data points")
    numberOfDataPoints?: int32;

    @doc("Date when the data was generated")
    dateGenerated?: utcDateTime;

    @doc("Earliest data point")
    earliestDataPoint?: utcDateTime;
}

@armResourceOperations
interface OperationExtensions {
    // Template definition
    @autoRoute
    @armResourceAction(TResource)
    @post
    ArmResourceActionNoRequestBodySync<
        TResource extends Azure.ResourceManager.Foundations.ArmResource,
        TResponse extends object
    >(
        ...ResourceInstanceParameters<
            TResource,
            {
                ...SubscriptionIdParameter;
                ...ResourceGroupParameter;
                ...ApiVersionParameter;
            }
        >
    ): ArmResponse<TResponse> | ErrorResponse;
}

@armResourceOperations
interface HealthModels
    extends TrackedResourceOperations<HealthModel, HealthModelProperties> {
    delete is ArmResourceDeleteSync<HealthModel>;

    @doc("Gets the execution and scheduling state of the health model")
    @action("getRunstate")
    GetRunstate is OperationExtensions.ArmResourceActionNoRequestBodySync<
        HealthModel,
        RunstateResponse
    >;

    @doc("Lists the health state history of a specific node with all its queries")
    @action("listNodeHistory")
    ListNodeHistory is ArmResourceActionSync<
        HealthModel,
        ListNodeHistoryRequest,
        Page<NodeStatePointInTime>,
        {
            ...SubscriptionIdParameter;
            ...ResourceGroupParameter;
            ...ApiVersionParameter;
            ...TopQueryParameter;
        }
    >;

    @doc("Return the health state distribution in a timespan for a node")
    @action("getNodeHealthStateDistribution")
    GetNodeHealthStateDistribution is ArmResourceActionSync<
        HealthModel,
        NodeHealthStateDistributionRequest,
        NodeHealthStateDistribution,
        {
            ...SubscriptionIdParameter;
            ...ResourceGroupParameter;
            ...ApiVersionParameter;
        }
    >;
}
