import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ClientGenerator.Core;

namespace Microsoft.MachineLearningServices.RunHistory;

// ============================================================
// Common path parameters
// ============================================================

/** Common path parameters for workspace-scoped operations. */
model WorkspacePathParams {
  /** The Azure subscription ID. */
  @path subscriptionId: string;

  /** The name of the resource group. */
  @path resourceGroupName: string;

  /** The name of the workspace. */
  @path workspaceName: string;
}

// ============================================================
// Enums (modeled as unions per TypeSpec convention)
// ============================================================

/** The type of creation source. */
union CreatedFromType {
  string,

  /** Created from a notebook. */
  Notebook: "Notebook",
}

/** The location type of a creation source. */
union CreatedFromLocationType {
  string,

  /** An artifact ID location. */
  ArtifactId: "ArtifactId",
}

/** The mechanism used to consume a dataset. */
union DatasetConsumptionMechanism {
  string,

  /** Direct access. */
  Direct: "Direct",

  /** Mount the dataset. */
  Mount: "Mount",

  /** Download the dataset. */
  Download: "Download",

  /** HDFS access. */
  Hdfs: "Hdfs",
}

/** The consumption type of a dataset lineage. */
union DatasetConsumptionType {
  string,

  /** Used as a run input. */
  RunInput: "RunInput",

  /** Used as a reference. */
  Reference: "Reference",
}

/** The output type of a dataset lineage. */
union DatasetOutputType {
  string,

  /** Produced as run output. */
  RunOutput: "RunOutput",

  /** Produced as a reference. */
  Reference: "Reference",
}

/** The type of a stored procedure parameter. */
union StoredProcedureParameterType {
  string,

  /** String type. */
  String: "String",

  /** Integer type. */
  Int: "Int",

  /** Decimal type. */
  Decimal: "Decimal",

  /** Guid type. */
  Guid: "Guid",

  /** Boolean type. */
  Boolean: "Boolean",

  /** Date type. */
  Date: "Date",
}

/** The view type for filtering experiments. */
union ExperimentViewType {
  string,

  /** Default view. */
  Default: "Default",

  /** Show all experiments. */
  All: "All",

  /** Show only active experiments. */
  ActiveOnly: "ActiveOnly",

  /** Show only archived experiments. */
  ArchivedOnly: "ArchivedOnly",
}

/** The status of a span. */
union SpanStatus {
  string,

  /** Not started. */
  NotStarted: "NotStarted",

  /** Unapproved. */
  Unapproved: "Unapproved",

  /** Pausing. */
  Pausing: "Pausing",

  /** Paused. */
  Paused: "Paused",

  /** Starting. */
  Starting: "Starting",

  /** Preparing. */
  Preparing: "Preparing",

  /** Queued. */
  Queued: "Queued",

  /** Running. */
  Running: "Running",

  /** Finalizing. */
  Finalizing: "Finalizing",

  /** Cancel requested. */
  CancelRequested: "CancelRequested",

  /** Completed. */
  Completed: "Completed",

  /** Failed. */
  Failed: "Failed",

  /** Canceled. */
  Canceled: "Canceled",
}

// ============================================================
// Models
// ============================================================

/** Request to add or modify run service instances. */
model AddOrModifyRunServiceInstancesRequest {
  /** The service instances to add or modify. */
  instances?: Record<ServiceInstance>;
}

/** Details of an Artifact. */
model Artifact {
  /** The identifier of an Artifact. Format of ArtifactId - {Origin}/{Container}/{Path}. */
  artifactId?: string;

  /** The origin of the Artifact creation request. Available origins are 'ExperimentRun', 'LocalUpload', 'WebUpload', 'Dataset', and 'Unknown'. */
  origin?: string;

  /** The name of container. Artifacts can be grouped by container. */
  container?: string;

  /** The path to the Artifact in a container. */
  path?: string;

  /** The Etag of the Artifact. */
  etag?: Azure.Core.eTag;

  /** The Date and Time at which the Artifact is created. The DateTime is in UTC. */
  createdTime?: utcDateTime;

  /** The data path of the artifact. */
  dataPath?: ArtifactDataPath;

  /** Tags for the artifact. */
  tags?: Record<string>;
}

/** Details of an Artifact Content Information. */
model ArtifactContentInformation {
  /** The URI of the content. */
  contentUri?: url;

  /** The origin of the Artifact creation request. Available origins are 'ExperimentRun', 'LocalUpload', 'WebUpload', 'Dataset', and 'Unknown'. */
  origin?: string;

  /** The name of container. Artifacts can be grouped by container. */
  container?: string;

  /** The path to the Artifact in a container. */
  path?: string;

  /** The tags on the artifact. */
  tags?: Record<string>;
}

/** The data path of an artifact. */
model ArtifactDataPath {
  /** The data store name. */
  dataStoreName?: string;

  /** The relative path. */
  relativePath?: string;

  /** The SQL data path. */
  sqlDataPath?: SqlDataPath;
}

/** Details of an Artifact Path. */
model ArtifactPath {
  /** The path to the Artifact in a container. */
  path?: string;

  /** Tags for the artifact path. */
  tags?: Record<string>;
}

/** Contains list of Artifact Paths. */
model ArtifactPathList {
  /** List of Artifact Paths. */
  paths?: ArtifactPath[];
}

/** Base event is the envelope used to post event data to the Event controller. */
model BaseEvent {
  /** The event timestamp. */
  timestamp?: utcDateTime;

  /** The event name. */
  name?: string;

  /** The event data. */
  data?: string;
}

/** Request to batch add or modify runs. */
model BatchAddOrModifyRunRequest {
  /** The list of runs to add or modify. */
  runs?: CreateRun[];
}

/** Results of the Batch Artifact Content Information request. */
model BatchArtifactContentInformationResult {
  /** Artifact details of the Artifact Ids requested. */
  artifacts?: Record<Artifact>;

  /** Artifact Content Information details of the Artifact Ids requested. */
  artifactContentInformation?: Record<ArtifactContentInformation>;

  /** Errors occurred while fetching the requested Artifact Ids. */
  errors?: Record<ErrorResponse>;
}

/** A batch event command. */
model BatchEventCommand {
  /** The list of events. */
  events?: BaseEvent[];
}

/** Result of a batch event command. */
model BatchEventCommandResult {
  /** The errors that occurred. */
  errors?: KeyValuePairBaseEventErrorResponse[];

  /** The successful event names. */
  successes?: string[];
}

/** A batch of metric values to post. */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API name"
model BatchIMetricV2 {
  /** The metric values. */
  values?: IMetricV2[];

  /** Whether to report errors. */
  reportErrors?: boolean;
}

/** A batch request for run data. */
model BatchRunDataRequest {
  /** The requests keyed by identifier. */
  requests?: Record<GetRunDataRequest>;
}

/** A batch result for run data. */
model BatchRunDataResult {
  /** The successful results keyed by identifier. */
  successfulResults?: Record<GetRunDataResult>;

  /** The failed results keyed by identifier. */
  failedResults?: Record<ErrorResponse>;
}

/** Result of a batch run operation. */
model BatchRunResult {
  /** The runs keyed by run ID. */
  runs?: Record<Run>;

  /** The errors keyed by run ID. */
  errors?: Record<ErrorResponse>;
}

/** Compute information for a run. */
model Compute {
  /** The compute target. */
  target?: string;

  /** The compute target type. */
  targetType?: string;

  /** The VM size. */
  vmSize?: string;

  /** The instance count. */
  instanceCount?: int32;

  /** The GPU count. */
  gpuCount?: int32;

  /** The priority. */
  priority?: string;

  /** The region. */
  region?: string;
}

/** Compute request information. */
model ComputeRequest {
  /** The node count. */
  nodeCount?: int32;

  /** The GPU count. */
  gpuCount?: int32;
}

/** The definition used to create a Run. */
model CreateRun {
  /** The identifier for the run. Run IDs must be less than 256 characters and contain only alphanumeric characters with dashes and underscores. */
  runId?: string;

  /** The parent of the run if the run is hierarchical; otherwise, Null. */
  parentRunId?: string;

  /** The Id of the experiment that created this run. */
  experimentId?: string;

  /** The status of the run. The Status string value maps to the RunStatus Enum. */
  status?: string;

  /** The start time of the run in UTC. */
  startTimeUtc?: utcDateTime;

  /** The end time of the run in UTC. */
  endTimeUtc?: utcDateTime;

  /** The run options. */
  options?: RunOptions;

  /** A virtual run can set an active child run that will override the virtual run status. */
  isVirtual?: boolean;

  /** The display name of the run. */
  displayName?: string;

  /** The name of the run. */
  name?: string;

  /** The data container ID. */
  dataContainerId?: string;

  /** The description of the run. */
  description?: string;

  /** Whether the run is hidden. */
  hidden?: boolean;

  /** The run type. */
  runType?: string;

  /** The run type V2. */
  runTypeV2?: RunTypeV2;

  /** The properties dictionary for the run. Properties are immutable. */
  properties?: Record<string>;

  /** The parameters dictionary for the run. Parameters are immutable. */
  parameters?: Record<string>;

  /** The action URIs for the run. */
  actionUris?: Record<string>;

  /** The script name. */
  scriptName?: string;

  /** The compute target. */
  target?: string;

  /** The unique child run compute targets. */
  uniqueChildRunComputeTargets?: string[];

  /** The tag dictionary for the run. Tags are mutable. */
  tags?: Record<string>;

  /** The settings dictionary for the run. */
  settings?: Record<string>;

  /** The services for the run. */
  services?: Record<EndpointSetting>;

  /** A list of datasets used as input to the run. */
  inputDatasets?: DatasetLineage[];

  /** A list of datasets used as output to the run. */
  outputDatasets?: OutputDatasetLineage[];

  /** The run definition specification. */
  runDefinition?: string;

  /** The job specification. */
  jobSpecification?: string;

  /** The primary metric name. */
  primaryMetricName?: string;

  /** The creation source. */
  createdFrom?: CreatedFrom;

  /** The cancel URI. */
  cancelUri?: string;

  /** The complete URI. */
  completeUri?: string;

  /** The diagnostics URI. */
  diagnosticsUri?: string;

  /** The compute request. */
  computeRequest?: ComputeRequest;

  /** The compute information. */
  compute?: Compute;

  /** Whether to retain for lifetime of workspace. */
  retainForLifetimeOfWorkspace?: boolean;

  /** The queueing information. */
  queueingInfo?: QueueingInfo;

  /** The RunId of the active child on a virtual run. */
  activeChildRunId?: string;

  /** The inputs for the run. */
  inputs?: Record<TypedAssetReference>;

  /** The outputs for the run. */
  outputs?: Record<TypedAssetReference>;
}

/** Information about how a run was created. */
model CreatedFrom {
  /** The type of creation source. */
  type?: CreatedFromType;

  /** The location type. */
  locationType?: CreatedFromLocationType;

  /** The location. */
  location?: string;
}

/** A dataset identifier. */
model DatasetIdentifier {
  /** The saved dataset ID. */
  savedId?: string;

  /** The registered dataset ID. */
  registeredId?: string;

  /** The registered dataset version. */
  registeredVersion?: string;
}

/** Details about dataset input. */
model DatasetInputDetails {
  /** The input name. */
  inputName?: string;

  /** The mechanism used to consume the dataset. */
  mechanism?: DatasetConsumptionMechanism;

  /** The path on compute. */
  pathOnCompute?: string;
}

/** Dataset lineage information. */
model DatasetLineage {
  /** The dataset identifier. */
  identifier?: DatasetIdentifier;

  /** The consumption type of the dataset. */
  consumptionType?: DatasetConsumptionType;

  /** The input details. */
  inputDetails?: DatasetInputDetails;
}

/** Details about dataset output. */
model DatasetOutputDetails {
  /** The output name. */
  outputName?: string;
}

/** Configuration for delete operations. */
model DeleteConfiguration {
  /** The workspace ID. */
  #suppress "@azure-tools/typespec-azure-core/no-format" "Existing API format"
  @format("uuid")
  workspaceId?: string;

  /** Whether deletion is enabled. */
  isEnabled?: boolean;

  /** The cutoff days. */
  cutoffDays?: int32;
}

/** Result of deleting experiment tags. */
model DeleteExperimentTagsResult {
  /** Errors keyed by tag name. */
  errors?: Record<ErrorResponse>;
}

/** The Tags to modify or delete. */
model DeleteOrModifyTags {
  /** The KV pairs of tags to modify. */
  tagsToModify?: Record<string>;

  /** The list of tags to delete. */
  tagsToDelete?: string[];
}

/** The Services to delete. */
model DeleteRunServices {
  /** The list of Services to delete. */
  servicesToDelete?: string[];
}

/** A command to delete tags. */
model DeleteTagsCommand {
  /** The list of tags to delete. */
  tags?: string[];
}

/** A derived metric key. */
model DerivedMetricKey {
  /** The namespace. */
  `namespace`?: string;

  /** The name. */
  name?: string;

  /** The labels. */
  labels?: string[];

  /** The column names. */
  columnNames?: string[];
}

/** An endpoint setting for a run service. */
model EndpointSetting {
  /** The type of endpoint. */
  type?: string;

  /** The port number. */
  port?: int32;

  /** The SSL thumbprint. */
  sslThumbprint?: string;

  /** The endpoint URL. */
  endpoint?: string;

  /** The proxy endpoint URL. */
  proxyEndpoint?: string;

  /** The status. */
  status?: string;

  /** The error message. */
  errorMessage?: string;

  /** Whether the endpoint is enabled. */
  enabled?: boolean;

  /** Additional properties. */
  properties?: Record<string>;
}

/** The resource management error additional info. */
model ErrorAdditionalInfo {
  /** The additional info type. */
  type?: string;

  /** The additional info. */
  info?: string;
}

/** The error response. */
@clientName("RunHistoryErrorResponse")
model ErrorResponse {
  /** The root error. */
  error?: RootError;

  /** Dictionary containing correlation details for the error. */
  correlation?: Record<string>;

  /** The hosting environment. */
  environment?: string;

  /** The Azure region. */
  location?: string;

  /** The time in UTC. */
  time?: utcDateTime;

  /** Component name where error originated/encountered. */
  componentName?: string;
}

/** An event associated with a run. */
model Event {
  /** Gets the event name. */
  name?: string;

  /** Gets the event timestamp. */
  timestamp?: utcDateTime;

  /** Gets the collection of attributes associated with the event. */
  attributes?: Record<string>;
}

/** An experiment. */
model Experiment {
  /** The experiment ID. */
  experimentId?: string;

  /** The experiment name. */
  name?: string;

  /** The experiment description. */
  description?: string;

  /** The creation time in UTC. */
  createdUtc?: utcDateTime;

  /** The experiment tags. */
  tags?: Record<string>;

  /** The time the experiment was archived. */
  archivedTime?: utcDateTime;

  /** Whether to retain for lifetime of workspace. */
  retainForLifetimeOfWorkspace?: boolean;

  /** The artifact location. */
  artifactLocation?: string;
}

/** Extends Query Params DTO for ViewType. */
model ExperimentQueryParams {
  /** ViewType filters experiments by their archived state. Default is ActiveOnly. */
  viewType?: ExperimentViewType;

  /** Allows for filtering the collection of resources. The expression specified is evaluated for each resource in the collection, and only items where the expression evaluates to true are included in the response. */
  filter?: string;

  /** The continuation token to use for getting the next set of resources. */
  continuationToken?: string;

  /** The comma separated list of resource properties to use for sorting the requested resources. */
  orderBy?: string;

  /** The maximum number of items in the resource collection to be included in the result. */
  top?: int32;
}

/** A request to get run data. */
model GetRunDataRequest {
  /** The run ID. */
  runId?: string;

  /** Whether to select run metadata. */
  selectRunMetadata?: boolean;

  /** Whether to select run definition. */
  selectRunDefinition?: boolean;

  /** Whether to select job specification. */
  selectJobSpecification?: boolean;
}

/** The result of a get run data request. */
model GetRunDataResult {
  /** The run metadata. */
  runMetadata?: Run;

  /** The run definition. */
  runDefinition?: string;

  /** The job specification. */
  jobSpecification?: string;
}

/** A request to get runs by IDs. */
model GetRunsByIds {
  /** The list of run IDs. */
  runIds?: string[];
}

/** A request to get sampled metrics. */
model GetSampledMetricRequest {
  /** The metric name. */
  metricName?: string;

  /** The metric namespace. */
  metricNamespace?: string;
}

/** Sequence of one or many values sharing a common DataContainerId, Name, and Schema. Used only for Post Metrics. */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API name"
model IMetricV2 {
  /** Data container to which this Metric belongs. */
  dataContainerId?: string;

  /** Name identifying this Metric within the Data Container. */
  name?: string;

  /** Schema shared by all values under this Metric. Columns.Keys define the column names and Columns.Values define the column types. */
  columns?: Record<string>;

  /** Namespace for this Metric. */
  `namespace`?: string;

  /** The standard schema ID. */
  #suppress "@azure-tools/typespec-azure-core/no-format" "Existing API format"
  @format("uuid")
  standardSchemaId?: string;

  /** The list of values. */
  value?: MetricV2Value[];
}

/** A nested structure of errors. */
model InnerErrorResponse {
  /** The error code. */
  code?: string;

  /** A nested inner error. */
  innerError?: InnerErrorResponse;
}

/** Cost information for a job. */
model JobCost {
  /** Charged CPU core seconds. */
  chargedCpuCoreSeconds?: float64;

  /** Charged CPU memory megabyte seconds. */
  chargedCpuMemoryMegabyteSeconds?: float64;

  /** Charged GPU seconds. */
  chargedGpuSeconds?: float64;

  /** Charged node utilization seconds. */
  chargedNodeUtilizationSeconds?: float64;
}

/** A key-value pair of BaseEvent and ErrorResponse. */
model KeyValuePairBaseEventErrorResponse {
  /** The event key. */
  key?: BaseEvent;

  /** The error response value. */
  value?: ErrorResponse;
}

/** A key-value pair of string and JToken. */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API name"
model KeyValuePairStringJToken {
  /** The key. */
  key?: string;

  /** The value. */
  value?: string;
}

/** A key-value pair of two strings. */
model KeyValuePairStringString {
  /** The key. */
  key?: string;

  /** The value. */
  value?: string;
}

/** A link associated with a span. */
model Link {
  /** The span context of the link. */
  context?: SpanContext;

  /** Gets the collection of attributes associated with the link. */
  attributes?: Record<string>;
}

/** A request to list generic resource metrics. */
model ListGenericResourceMetrics {
  /** The resource ID. */
  resourceId?: string;

  /** The metric names to list. */
  metricNames?: string[];

  /** The label filters. */
  labelFilters?: Record<string>;

  /** The metric namespace. */
  metricNamespace?: string;

  /** The continuation token. */
  continuationToken?: string;
}

/** A request to list metrics. */
model ListMetrics {
  /** The metric namespace. */
  metricNamespace?: string;

  /** The continuation token. */
  continuationToken?: string;
}

/** A long-running null response. */
model LongRunningNullResponse {}

/** A metric definition. */
model MetricDefinition {
  /** The metric key. */
  metricKey?: DerivedMetricKey;

  /** The metric columns. */
  columns?: Record<string>;

  /** The metric properties. */
  properties?: MetricProperties;
}

/** Properties of a metric. */
model MetricProperties {
  /** String value UX uses to decide how to render your metrics. Ex: azureml.v1.scalar */
  uxMetricType?: string;
}

/** A sampled metric. */
model MetricSample {
  /** The derived label values. */
  derivedLabelValues?: Record<string>;

  /** Whether this is a partial result. */
  isPartialResult?: boolean;

  /** The number of values logged. */
  numValuesLogged?: int64;

  /** Data container to which this Metric belongs. */
  dataContainerId?: string;

  /** Name identifying this Metric within the Data Container. */
  name?: string;

  /** Schema shared by all values under this Metric. Columns.Keys define the column names and Columns.Values define the column types. */
  columns?: Record<string>;

  /** The metric properties. */
  properties?: MetricProperties;

  /** Namespace for this Metric. */
  `namespace`?: string;

  /** The standard schema ID. */
  #suppress "@azure-tools/typespec-azure-core/no-format" "Existing API format"
  @format("uuid")
  standardSchemaId?: string;

  /** The list of values. */
  value?: MetricV2Value[];

  /** The token used in retrieving the next page. If null, there are no additional pages. */
  continuationToken?: string;

  /** The link to the next page constructed using the continuationToken. If null, there are no additional pages. */
  nextLink?: string;
}

/** A metric schema. */
model MetricSchema {
  /** The number of properties. */
  numProperties?: int32;

  /** The schema properties. */
  properties?: MetricSchemaProperty[];
}

/** A property in a metric schema. */
model MetricSchemaProperty {
  /** The property ID. */
  propertyId?: string;

  /** The property name. */
  name?: string;

  /** The property type. */
  type?: string;
}

/** Sequence of one or many values sharing a common DataContainerId, Name, and Schema. */
model MetricV2 {
  /** Data container to which this Metric belongs. */
  dataContainerId?: string;

  /** Name identifying this Metric within the Data Container. */
  name?: string;

  /** Schema shared by all values under this Metric. Columns.Keys define the column names and Columns.Values define the column types. */
  columns?: Record<string>;

  /** The metric properties. */
  properties?: MetricProperties;

  /** Namespace for this Metric. */
  `namespace`?: string;

  /** The standard schema ID. */
  #suppress "@azure-tools/typespec-azure-core/no-format" "Existing API format"
  @format("uuid")
  standardSchemaId?: string;

  /** The list of values. */
  value?: MetricV2Value[];

  /** The token used in retrieving the next page. If null, there are no additional pages. */
  continuationToken?: string;

  /** The link to the next page constructed using the continuationToken. If null, there are no additional pages. */
  nextLink?: string;
}

/** An individual value logged within a Metric. */
model MetricV2Value {
  /** Unique Id for this metric value. Format is either a Guid or a Guid augmented with a suffix. */
  metricId?: string;

  /** Client specified timestamp for this metric value. */
  createdUtc?: utcDateTime;

  /** The step. */
  step?: int64;

  /** Dictionary mapping column names (specified as the keys in MetricV2Dto.Columns) to their values. */
  data?: Record<string>;
}

/** A request to modify an experiment. */
model ModifyExperiment {
  /** The experiment name. */
  name?: string;

  /** The experiment description. */
  description?: string;

  /** The experiment tags. */
  tags?: Record<string>;

  /** Whether to archive the experiment. */
  archive?: boolean;

  /** Whether to retain for lifetime of workspace. */
  retainForLifetimeOfWorkspace?: boolean;
}

/** Output dataset lineage information. */
model OutputDatasetLineage {
  /** The dataset identifier. */
  identifier?: DatasetIdentifier;

  /** The output type of the dataset. */
  outputType?: DatasetOutputType;

  /** The output details. */
  outputDetails?: DatasetOutputDetails;
}

/** A paginated list of ArtifactContentInformations. */
model PaginatedArtifactContentInformationList {
  /** An array of objects of type ArtifactContentInformation. */
  @pageItems
  value?: ArtifactContentInformation[];

  /** The token used in retrieving the next page. If null, there are no additional pages. */
  continuationToken?: string;

  /** The link to the next page constructed using the continuationToken. If null, there are no additional pages. */
  nextLink?: string;
}

/** A paginated list of Artifacts. */
model PaginatedArtifactList {
  /** An array of objects of type Artifact. */
  @pageItems
  value?: Artifact[];

  /** The token used in retrieving the next page. If null, there are no additional pages. */
  continuationToken?: string;

  /** The link to the next page constructed using the continuationToken. If null, there are no additional pages. */
  nextLink?: string;
}

/** A paginated list of Experiments. */
model PaginatedExperimentList {
  /** An array of objects of type Experiment. */
  @pageItems
  value?: Experiment[];

  /** The token used in retrieving the next page. If null, there are no additional pages. */
  continuationToken?: string;

  /** The link to the next page constructed using the continuationToken. If null, there are no additional pages. */
  nextLink?: string;
}

/** A paginated list of MetricDefinitions. */
model PaginatedMetricDefinitionList {
  /** An array of objects of type MetricDefinition. */
  @pageItems
  value?: MetricDefinition[];

  /** The token used in retrieving the next page. If null, there are no additional pages. */
  continuationToken?: string;

  /** The link to the next page constructed using the continuationToken. If null, there are no additional pages. */
  nextLink?: string;
}

/** A paginated list of Runs. */
model PaginatedRunList {
  /** An array of objects of type Run. */
  @pageItems
  value?: Run[];

  /** The token used in retrieving the next page. If null, there are no additional pages. */
  continuationToken?: string;

  /** The link to the next page constructed using the continuationToken. If null, there are no additional pages. */
  nextLink?: string;
}

/** A paginated list of SpanDefinitions. */
model PaginatedSpanDefinitionList {
  /** An array of objects of type SpanDefinition. */
  @pageItems
  value?: SpanDefinition[];

  /** The token used in retrieving the next page. If null, there are no additional pages. */
  continuationToken?: string;

  /** The link to the next page constructed using the continuationToken. If null, there are no additional pages. */
  nextLink?: string;
}

/** An error posting run metrics. */
model PostRunMetricsError {
  /** The metric that caused the error. */
  metric?: IMetricV2;

  /** The error response. */
  errorResponse?: ErrorResponse;
}

/** Result of posting run metrics. */
model PostRunMetricsResult {
  /** The errors that occurred. */
  errors?: PostRunMetricsError[];
}

/** The set of supported filters. */
model QueryParams {
  /** Allows for filtering the collection of resources. The expression specified is evaluated for each resource in the collection, and only items where the expression evaluates to true are included in the response. */
  filter?: string;

  /** The continuation token to use for getting the next set of resources. */
  continuationToken?: string;

  /** The comma separated list of resource properties to use for sorting the requested resources. */
  orderBy?: string;

  /** The maximum number of items in the resource collection to be included in the result. */
  top?: int32;
}

/** Queueing information for a run. */
model QueueingInfo {
  /** The queueing code. */
  code?: string;

  /** The queueing message. */
  message?: string;

  /** The last refresh timestamp. */
  lastRefreshTimestamp?: utcDateTime;
}

/** A request to retrieve full fidelity metrics. */
model RetrieveFullFidelityMetricRequest {
  /** The metric name. */
  metricName?: string;

  /** The continuation token. */
  continuationToken?: string;

  /** The start time. */
  startTime?: utcDateTime;

  /** The end time. */
  endTime?: utcDateTime;

  /** The metric namespace. */
  metricNamespace?: string;
}

/** The root error. */
model RootError {
  /** The service-defined error code. Supported error codes: ServiceError, UserError, ValidationError, AzureStorageError, TransientError, RequestThrottled. */
  code?: string;

  /** The Severity of error. */
  severity?: int32;

  /** A human-readable representation of the error. */
  message?: string;

  /** An unformatted version of the message with no variable substitution. */
  messageFormat?: string;

  /** Value substitutions corresponding to the contents of MessageFormat. */
  messageParameters?: Record<string>;

  /** This code can optionally be set by the system generating the error. It should be set when additional information can be provided through public documentation. */
  referenceCode?: string;

  /** A URI which points to more details about the context of the error. */
  detailsUri?: url;

  /** The target of the error (e.g., the name of the property in error). */
  target?: string;

  /** The related errors that occurred during the request. */
  details?: RootError[];

  /** A nested inner error. */
  innerError?: InnerErrorResponse;

  /** The error additional info. */
  additionalInfo?: ErrorAdditionalInfo[];
}

/** The definition of a Run. */
model Run {
  /** The run number. */
  runNumber?: int32;

  /** The root run ID. */
  rootRunId?: string;

  /** The time the run was created in UTC. */
  createdUtc?: utcDateTime;

  /** The user who created the run. */
  createdBy?: User;

  /** The Id of the user that created the run. */
  userId?: string;

  /** A token used for authenticating a run. */
  token?: string;

  /** The Token expiration time in UTC. */
  tokenExpiryTimeUtc?: utcDateTime;

  /** The error response. */
  error?: ErrorResponse;

  /** A list of warnings that occurred during the run. */
  warnings?: RunDetailsWarning[];

  /** The revision. */
  revision?: int64;

  /** The status revision. */
  statusRevision?: int64;

  /** A system generated Id for the run. */
  #suppress "@azure-tools/typespec-azure-core/no-format" "Existing API format"
  @format("uuid")
  runUuid?: string;

  /** A system generated Id for the run's parent. */
  #suppress "@azure-tools/typespec-azure-core/no-format" "Existing API format"
  @format("uuid")
  parentRunUuid?: string;

  /** A system generated Id for the root of the run's hierarchy. */
  #suppress "@azure-tools/typespec-azure-core/no-format" "Existing API format"
  @format("uuid")
  rootRunUuid?: string;

  /** Indicates if this is a child of a virtual run. */
  hasVirtualParent?: boolean;

  /** The last timestamp when a run transitioned from paused to running. Initialized with StartTimeUtc. */
  lastStartTimeUtc?: utcDateTime;

  /** The cumulative time spent in an active status for an active run. */
  currentComputeTime?: string;

  /** The cumulative time spent in an active status for a terminal run. */
  computeDuration?: string;

  /** A relative start time set as LastStartTimeUtc - ComputeTime for active runs. */
  effectiveStartTimeUtc?: utcDateTime;

  /** The user who last modified the run. */
  lastModifiedBy?: User;

  /** The time the run was last modified in UTC. */
  lastModifiedUtc?: utcDateTime;

  /** The total duration of a run. */
  duration?: string;

  /** The cancelation Reason if the run was canceled. */
  cancelationReason?: string;

  /** The identifier for the run. Run IDs must be less than 256 characters and contain only alphanumeric characters with dashes and underscores. */
  runId?: string;

  /** The parent of the run if the run is hierarchical; otherwise, Null. */
  parentRunId?: string;

  /** The Id of the experiment that created this run. */
  experimentId?: string;

  /** The status of the run. The Status string value maps to the RunStatus Enum. */
  status?: string;

  /** The start time of the run in UTC. */
  startTimeUtc?: utcDateTime;

  /** The end time of the run in UTC. */
  endTimeUtc?: utcDateTime;

  /** The run options. */
  options?: RunOptions;

  /** A virtual run can set an active child run that will override the virtual run status. */
  isVirtual?: boolean;

  /** The display name of the run. */
  displayName?: string;

  /** The name of the run. */
  name?: string;

  /** The data container ID. */
  dataContainerId?: string;

  /** The description of the run. */
  description?: string;

  /** Whether the run is hidden. */
  hidden?: boolean;

  /** The run type. */
  runType?: string;

  /** The run type V2. */
  runTypeV2?: RunTypeV2;

  /** The properties dictionary for the run. Properties are immutable. */
  properties?: Record<string>;

  /** The parameters dictionary for the run. Parameters are immutable. */
  parameters?: Record<string>;

  /** The action URIs for the run. */
  actionUris?: Record<string>;

  /** The script name. */
  scriptName?: string;

  /** The compute target. */
  target?: string;

  /** The unique child run compute targets. */
  uniqueChildRunComputeTargets?: string[];

  /** The tag dictionary for the run. Tags are mutable. */
  tags?: Record<string>;

  /** The settings dictionary for the run. */
  settings?: Record<string>;

  /** The services for the run. */
  services?: Record<EndpointSetting>;

  /** A list of datasets used as input to the run. */
  inputDatasets?: DatasetLineage[];

  /** A list of datasets used as output to the run. */
  outputDatasets?: OutputDatasetLineage[];

  /** The run definition specification. */
  runDefinition?: string;

  /** The job specification. */
  jobSpecification?: string;

  /** The primary metric name. */
  primaryMetricName?: string;

  /** The creation source. */
  createdFrom?: CreatedFrom;

  /** The cancel URI. */
  cancelUri?: string;

  /** The complete URI. */
  completeUri?: string;

  /** The diagnostics URI. */
  diagnosticsUri?: string;

  /** The compute request. */
  computeRequest?: ComputeRequest;

  /** The compute information. */
  compute?: Compute;

  /** Whether to retain for lifetime of workspace. */
  retainForLifetimeOfWorkspace?: boolean;

  /** The queueing information. */
  queueingInfo?: QueueingInfo;

  /** The RunId of the active child on a virtual run. */
  activeChildRunId?: string;

  /** The inputs for the run. */
  inputs?: Record<TypedAssetReference>;

  /** The outputs for the run. */
  outputs?: Record<TypedAssetReference>;
}

/** The details of the run. */
model RunDetails {
  /** The identifier for the run. */
  runId?: string;

  /** A system generated Id for the run. */
  #suppress "@azure-tools/typespec-azure-core/no-format" "Existing API format"
  @format("uuid")
  runUuid?: string;

  /** A system generated Id for the run's parent. */
  #suppress "@azure-tools/typespec-azure-core/no-format" "Existing API format"
  @format("uuid")
  parentRunUuid?: string;

  /** A system generated Id for the root of the run's hierarchy. */
  #suppress "@azure-tools/typespec-azure-core/no-format" "Existing API format"
  @format("uuid")
  rootRunUuid?: string;

  /** The name of the compute target where the run is executed. */
  target?: string;

  /** The status of the run. The Status string value maps to the RunStatus Enum. */
  status?: string;

  /** The parent of the run if the run is hierarchical. */
  parentRunId?: string;

  /** The creation time of the run in UTC. */
  createdTimeUtc?: utcDateTime;

  /** The start time of the run in UTC. */
  startTimeUtc?: utcDateTime;

  /** The end time of the run in UTC. */
  endTimeUtc?: utcDateTime;

  /** The error response. */
  error?: ErrorResponse;

  /** A list of warnings that occurred during the run. */
  warnings?: RunDetailsWarning[];

  /** The tag dictionary for the run. Tags are mutable. */
  tags?: Record<string>;

  /** The properties dictionary for the run. Properties are immutable. */
  properties?: Record<string>;

  /** The parameters dictionary for the run. Parameters are immutable. */
  parameters?: Record<string>;

  /** The interactive run services for a run. Services are mutable. */
  services?: Record<EndpointSetting>;

  /** A list of dataset used as input to the run. */
  inputDatasets?: DatasetLineage[];

  /** A list of dataset used as output to the run. */
  outputDatasets?: OutputDatasetLineage[];

  /** The run definition specification. */
  runDefinition?: string;

  /** The log files. */
  logFiles?: Record<string>;

  /** The job cost. */
  jobCost?: JobCost;

  /** The revision. */
  revision?: int64;

  /** The run type V2. */
  runTypeV2?: RunTypeV2;

  /** The run settings. */
  settings?: Record<string>;

  /** The compute request. */
  computeRequest?: ComputeRequest;

  /** The compute information. */
  compute?: Compute;

  /** The user who created the run. */
  createdBy?: User;

  /** Time spent in an active state for terminal runs. */
  computeDuration?: string;

  /** Relative start time of active runs for ordering and computing active compute duration. */
  effectiveStartTimeUtc?: utcDateTime;

  /** The run number. */
  runNumber?: int32;

  /** The root run ID. */
  rootRunId?: string;

  /** The Id of the user that created the run. */
  userId?: string;

  /** The status revision. */
  statusRevision?: int64;

  /** Indicates if this is a child of a virtual run. */
  hasVirtualParent?: boolean;

  /** The cumulative time spent in an active status for an active run. */
  currentComputeTime?: string;

  /** The last timestamp when a run transitioned from paused to running. Initialized with StartTimeUtc. */
  lastStartTimeUtc?: utcDateTime;

  /** The user who last modified the run. */
  lastModifiedBy?: User;

  /** The time the run was last modified in UTC. */
  lastModifiedUtc?: utcDateTime;

  /** The total duration of a run. */
  duration?: string;

  /** The inputs for the run. */
  inputs?: Record<TypedAssetReference>;

  /** The outputs for the run. */
  outputs?: Record<TypedAssetReference>;
}

/** A warning that occurred during a run. */
model RunDetailsWarning {
  /** The source of the warning. */
  source?: string;

  /** The warning message. */
  message?: string;
}

/** A run metric. */
model RunMetric {
  /** The run ID. */
  runId?: string;

  /** The metric ID. */
  #suppress "@azure-tools/typespec-azure-core/no-format" "Existing API format"
  @format("uuid")
  metricId?: string;

  /** The data container ID. */
  dataContainerId?: string;

  /** The metric type. */
  metricType?: string;

  /** The creation time in UTC. */
  createdUtc?: utcDateTime;

  /** The metric name. */
  name?: string;

  /** The metric description. */
  description?: string;

  /** The metric label. */
  label?: string;

  /** The number of cells. */
  numCells?: int32;

  /** The data location. */
  dataLocation?: string;

  /** The metric cells. */
  cells?: string[];

  /** The metric schema. */
  schema?: MetricSchema;
}

/** Run options. */
model RunOptions {
  /** Whether to generate a data container ID if not specified. */
  generateDataContainerIdIfNotSpecified?: boolean;
}

/** Service instances for a run. */
model RunServiceInstances {
  /** The service instances keyed by name. */
  instances?: Record<ServiceInstanceResult>;
}

/** Status spans for a run. */
model RunStatusSpans {
  /** The list of spans. */
  spans?: SpanDefinition[];
}

/** The type of a run (V2). */
model RunTypeV2 {
  /** The orchestrator. */
  orchestrator?: string;

  /** The traits. */
  traits?: string[];

  /** The attribution. */
  attribution?: string;

  /** The compute type. */
  computeType?: string;
}

/** A service instance. */
model ServiceInstance {
  /** Whether this is a single node service. */
  isSingleNode?: boolean;

  /** The error message. */
  errorMessage?: string;

  /** The port. */
  port?: int32;

  /** The status. */
  status?: string;

  /** The error response. */
  error?: ErrorResponse;

  /** Additional properties. */
  properties?: Record<string>;
}

/** A service instance result. */
model ServiceInstanceResult {
  /** The type. */
  type?: string;

  /** The port. */
  port?: int32;

  /** The status. */
  status?: string;

  /** The error response. */
  error?: ErrorResponse;

  /** The endpoint. */
  endpoint?: string;

  /** Additional properties. */
  properties?: Record<string>;
}

/** A span context. */
model SpanContext {
  /** Gets the TraceId associated with this span context. */
  traceId?: string;

  /** Gets the SpanId associated with this span context. */
  spanId?: string;

  /** Gets a value indicating whether this span context is remote. */
  isRemote?: boolean;

  /** Gets a value indicating whether this span context is valid. */
  isValid?: boolean;

  /** Gets the Tracestate associated with this span context. */
  tracestate?: KeyValuePairStringString[];
}

/** A span definition. */
model SpanDefinition {
  /** The span context. */
  context?: SpanContext;

  /** Gets span name. */
  name?: string;

  /** Gets span status. OpenTelemetry sets it to map to the RunStatus enum. */
  status?: SpanStatus;

  /** Gets parent span id. */
  parentSpanId?: string;

  /** Gets attributes. */
  attributes?: KeyValuePairStringJToken[];

  /** Gets events. */
  events?: Event[];

  /** Gets links. */
  links?: Link[];

  /** Gets span start timestamp. */
  startTimestamp?: utcDateTime;

  /** Gets span end timestamp. */
  endTimestamp?: utcDateTime;
}

/** A SQL data path. */
model SqlDataPath {
  /** The SQL table name. */
  sqlTableName?: string;

  /** The SQL query. */
  sqlQuery?: string;

  /** The SQL stored procedure name. */
  sqlStoredProcedureName?: string;

  /** The SQL stored procedure parameters. */
  sqlStoredProcedureParams?: StoredProcedureParameter[];
}

/** A stored procedure parameter. */
model StoredProcedureParameter {
  /** The parameter name. */
  name?: string;

  /** The parameter value. */
  value?: string;

  /** The parameter type. */
  type?: StoredProcedureParameterType;
}

/** A typed asset reference. */
model TypedAssetReference {
  /** The asset ID. */
  assetId?: string;

  /** The type. */
  type?: string;
}

/** A user. */
model User {
  /** A user or service principal's object ID. This is EUPI and may only be logged to an approved store. */
  userObjectId?: string;

  /** A user or service principal's PuID. This is PII and should never be logged. */
  userPuId?: string;

  /** A user identity provider. Eg live.com. This is PII and should never be logged. */
  userIdp?: string;

  /** A user alternate sec id. This represents the user in a different identity provider system. */
  userAltSecId?: string;

  /** The issuer which issued the token for this user. This is PII and should never be logged. */
  userIss?: string;

  /** A user or service principal's tenant ID. */
  userTenantId?: string;

  /** A user's full name or a service principal's app ID. This is PII and should never be logged. */
  userName?: string;

  /** A user's Principal name (upn). This is PII and should never be logged. */
  upn?: string;
}
