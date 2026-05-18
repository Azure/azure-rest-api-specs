import "../common/models.tsp";
import "../common/service.tsp";

using TypeSpec.Http;

namespace Azure.AI.Projects;

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Use an extensible union instead of a plain string"
@doc("Distribution configuration of the job.")
@discriminator("distributionType")
model DistributionConfiguration {
  @doc("Specifies the type of distribution framework.")
  distributionType: string;
}

@doc("PyTorch distribution configuration.")
model PyTorchDistribution extends DistributionConfiguration {
  @doc("Specifies the type of distribution framework.")
  distributionType: "PyTorch";

  @doc("Number of processes per node.")
  processCountPerInstance?: int32;
}

@doc("MPI distribution configuration.")
model MpiDistribution extends DistributionConfiguration {
  @doc("Specifies the type of distribution framework.")
  distributionType: "Mpi";

  @doc("Number of processes per MPI node.")
  processCountPerNode?: int32;
}

@doc("TensorFlow distribution configuration.")
model TensorFlowDistribution extends DistributionConfiguration {
  @doc("Specifies the type of distribution framework.")
  distributionType: "TensorFlow";

  @doc("Number of workers.")
  workerCount?: int32;

  @doc("Number of parameter server tasks.")
  parameterServerCount?: int32;
}

@doc("Ray distribution configuration.")
model RayDistribution extends DistributionConfiguration {
  @doc("Specifies the type of distribution framework.")
  distributionType: "Ray";

  @doc("The port of the head Ray process.")
  port?: int32;

  @doc("The address of the Ray head node.")
  address?: string;

  @doc("Whether to start the Ray dashboard GUI.")
  includeDashboard?: boolean;

  @doc("The port to bind the dashboard server to.")
  dashboardPort?: int32;

  @doc("Additional arguments passed to ray start on the head node.")
  headNodeAdditionalArgs?: string;

  @doc("Additional arguments passed to ray start on worker nodes.")
  workerNodeAdditionalArgs?: string;
}

@doc("Enum to determine the input/output data delivery mode.")
union InputOutputModes {
  string,

  @doc("Read-only mount mode.")
  ReadOnlyMount: "ReadOnlyMount",

  @doc("Read-write mount mode.")
  ReadWriteMount: "ReadWriteMount",

  @doc("Download mode.")
  Download: "Download",

  @doc("Direct mode.")
  Direct: "Direct",

  @doc("Upload mode.")
  Upload: "Upload",
}

@doc("Type of job input/output asset.")
union AssetTypes {
  string,

  @doc("URI file asset.")
  UriFile: "uri_file",

  @doc("URI folder asset.")
  UriFolder: "uri_folder",

  @doc("Safetensors model asset.")
  SafetensorsModel: "safetensors_model",

  @doc("Literal value (inputs only).")
  Literal: "literal",
}

@doc("Job input definition.")
model Input {
  @doc("Specifies the type of job input.")
  @encodedName("application/json", "jobInputType")
  type: AssetTypes;

  @doc("Input Asset URI.")
  @encodedName("application/json", "uri")
  path?: string;

  @doc("Input Asset Delivery Mode.")
  mode?: InputOutputModes;

  @doc("Literal value for literal-type inputs.")
  value?: string;
}

@doc("Job output definition.")
model Output {
  @doc("Specifies the type of job output.")
  @encodedName("application/json", "jobOutputType")
  type: AssetTypes;

  @doc("Output Asset Delivery Mode.")
  mode?: InputOutputModes;

  @doc("Name of the output data asset to register.")
  assetName?: string;

  @doc("Version of the output data asset to register.")
  assetVersion?: string;

  @doc("Output Asset URI.")
  uri?: string;

  @doc("Base model ID.")
  baseModelId?: string;

  @doc("Description for the output.")
  description?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Use an extensible union instead of a plain string"
@doc("Nodes that user would like to start the service on.")
@discriminator("nodesValueType")
model NodeCollection {
  @doc("Type of the Nodes value.")
  nodesValueType: string;
}

@doc("All nodes means the service will be running on all of the nodes of the job.")
model AllNodes extends NodeCollection {
  @doc("Type of the Nodes value.")
  nodesValueType: "All";
}

@doc("Job endpoint definition.")
model JobService {
  @doc("Endpoint type.")
  jobServiceType?: string;

  @doc("Port for endpoint.")
  port?: int32;

  @doc("Url for endpoint.")
  endpoint?: string;

  @doc("Additional properties to set on the endpoint.")
  properties?: Record<string>;

  @doc("Nodes that user would like to start the service on.")
  nodes?: AllNodes;

  @doc("Status of endpoint.")
  @visibility(Lifecycle.Read)
  status?: string;

  @doc("Any error in the service.")
  @visibility(Lifecycle.Read)
  errorMessage?: string;
}

@doc("Compute Resource configuration for the job.")
model JobResourceConfiguration {
  @doc("Optional number of instances or nodes used by the compute target.")
  instanceCount?: int32;

  @doc("Optional type of VM used as supported by the compute target.")
  instanceType?: string;

  @doc("Additional properties bag.")
  properties?: Record<unknown>;

  @doc("Size of the docker container's shared memory block.")
  shmSize?: string;

  @doc("Extra arguments to pass to the Docker run command.")
  dockerArgs?: string;
}

@doc("Command Job limit class.")
model CommandJobLimits {
  @doc("JobLimit type.")
  jobLimitsType: "Command";

  @doc("The max run duration, after which the job will be cancelled.")
  timeout?: duration;
}

@doc("Queue settings for the job.")
model QueueSettings {
  @doc("Controls the compute job tier.")
  jobTier?: string;
}

@doc("Metadata pertaining to creation and last modification of the resource.")
model SystemData {
  @doc("The identity that created the resource.")
  @visibility(Lifecycle.Read)
  createdBy?: string;

  @doc("The type of identity that created the resource.")
  @visibility(Lifecycle.Read)
  createdByType?: string;

  @doc("The timestamp of resource creation (UTC).")
  @visibility(Lifecycle.Read)
  createdAt?: utcDateTime;

  @doc("The identity that last modified the resource.")
  @visibility(Lifecycle.Read)
  lastModifiedBy?: string;

  @doc("The type of identity that last modified the resource.")
  @visibility(Lifecycle.Read)
  lastModifiedByType?: string;

  @doc("The timestamp of resource last modification (UTC).")
  @visibility(Lifecycle.Read)
  lastModifiedAt?: utcDateTime;
}

@doc("Type of a job.")
union JobType {
  string,

  @doc("Command job.")
  Command: "Command",
}

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Use an extensible union instead of a plain string"
@doc("Base properties of a Job.")
@discriminator("jobType")
model JobProperties {
  @doc("Job type.")
  jobType: string;
}

@doc("Properties of a Command Job.")
model CommandJob extends JobProperties {
  @doc("Job type.")
  jobType: "Command";

  @doc("The command to execute on startup of the job.")
  command: string;

  @doc("ACR path of environment.")
  environmentImageReference: string;

  @doc("Display name of job.")
  displayName?: string;

  @doc("The asset description text.")
  description?: string;

  @doc("Tag dictionary. Tags can be added, removed, and updated.")
  tags?: Record<string>;

  @doc("The asset property dictionary.")
  properties?: Record<string>;

  @doc("Code asset reference.")
  @encodedName("application/json", "codeId")
  code?: string;

  @doc("Compute resource ID.")
  @encodedName("application/json", "computeId")
  compute: string;

  @doc("Mapping of input data bindings used in the job.")
  inputs?: Record<Input>;

  @doc("Mapping of output data bindings used in the job.")
  outputs?: Record<Output>;

  @doc("Environment variables included in the job.")
  environmentVariables?: Record<string>;

  @doc("Compute Resource configuration for the job.")
  resources?: JobResourceConfiguration;

  @doc("Distribution configuration of the job.")
  distribution?: DistributionConfiguration;

  @doc("Command Job limit.")
  limits?: CommandJobLimits;

  @doc("List of job services.")
  services?: Record<JobService>;

  @doc("Queue settings for the job.")
  queueSettings?: QueueSettings;

  @doc("user-assigned managed identity")
  userAssignedIdentityId?: string;

  @doc("Number of GPUs to allocate for the job.")
  gpuCount?: int32;

  @doc("Is the asset archived?")
  isArchived?: boolean;

  @doc("Status of the job.")
  @visibility(Lifecycle.Read)
  status?: string;
}

@doc("Job resource.")
@Rest.resource("jobs")
model Job {
  @doc("The name of the Job. This is case-sensitive.")
  @key("name")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The resource ID.")
  @visibility(Lifecycle.Read)
  id?: string;

  @doc("The resource type.")
  @visibility(Lifecycle.Read)
  type?: string;

  @doc("Properties of the job.")
  properties: JobProperties;

  @doc("Metadata pertaining to creation and last modification of the resource.")
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

@doc("Response returned when a job delete operation is accepted asynchronously.")
model JobDeleteAcceptedResponse {
  @statusCode statusCode: 202;

  @doc("URL to poll for the status of the delete operation.")
  @header("Location")
  location: string;

  @doc("Suggested delay in seconds before polling.")
  @header("Retry-After")
  retryAfter?: int32;
}

@doc("Response returned when a job cancel operation is accepted asynchronously.")
model JobCancelAcceptedResponse {
  @statusCode statusCode: 202;

  @doc("URL to poll for the status of the cancel operation.")
  @header("Location")
  location: string;

  @doc("Suggested delay in seconds before polling.")
  @header("Retry-After")
  retryAfter?: int32;
}

@doc("Specifies which jobs to include in a list result based on their lifecycle state.")
union ListViewType {
  string,

  @doc("Show only active (non-archived) jobs.")
  ActiveOnly: "ActiveOnly",

  @doc("Show only archived jobs.")
  ArchivedOnly: "ArchivedOnly",

  @doc("Show all jobs regardless of archived state.")
  All: "All",
}

@doc("The resource management error additional info.")
model ErrorAdditionalInfo {
  @doc("The additional info type.")
  type?: string;

  @doc("The additional info.")
  info?: unknown;
}

@doc("A nested structure of errors.")
model InnerErrorResponse {
  @doc("The error code.")
  code?: string;

  @doc("A nested structure of errors.")
  innerError?: InnerErrorResponse;
}

@doc("The root error.")
model RootError {
  @doc("The service-defined error code.")
  code?: string;

  @doc("The severity of the error.")
  severity?: int32;

  @doc("A human-readable representation of the error.")
  message?: string;

  @doc("An unformatted version of the message with no variable substitution.")
  messageFormat?: string;

  @doc("Value substitutions for the message format.")
  messageParameters?: Record<string>;

  @doc("A reference code for the error.")
  referenceCode?: string;

  @doc("A URI with more details about the error.")
  detailsUri?: string;

  @doc("The target of the error.")
  target?: string;

  @doc("The related errors that occurred during the request.")
  details?: RootError[];

  @doc("A nested structure of errors.")
  innerError?: InnerErrorResponse;

  @doc("The error additional info.")
  additionalInfo?: ErrorAdditionalInfo[];
}

@doc("The error response returned for a job's service instance.")
model JobErrorResponse {
  @doc("The root error.")
  error?: RootError;

  @doc("Dictionary containing correlation details for the error.")
  correlation?: Record<string>;

  @doc("The hosting environment.")
  environment?: string;

  @doc("Location.")
  location?: string;

  @doc("The time in UTC when the error occurred.")
  time?: utcDateTime;

  @doc("Component name where the error originated or was encountered.")
  componentName?: string;
}

@doc("Runtime information about a single interactive service associated with a job's node.")
model ServiceInstance {
  @doc("The service type.")
  type?: string;

  @doc("The port the service is listening on.")
  port?: int32;

  @doc("The current status of the service.")
  status?: string;

  @doc("Error details if the service failed to start.")
  error?: JobErrorResponse;

  @doc("Endpoint URL used to connect to the service.")
  endpoint?: string;

  @doc("Additional service-specific properties.")
  properties?: Record<string>;
}

@doc("Map of service instances running on a job's node, keyed by service name.")
model RunServiceInstances {
  @doc("Service instances running on the node, keyed by service name.")
  instances?: Record<ServiceInstance>;
}

@doc("A warning that occurred during a run.")
model RunDetailsWarning {
  @doc("The source of the warning.")
  source?: string;

  @doc("The warning message.")
  message?: string;
}

@doc("Identity of a user or service principal that created or modified a run.")
model RunUser {
  @doc("A user or service principal's object ID.")
  userObjectId?: string;

  @doc("A user or service principal's PuID.")
  userPuId?: string;

  @doc("A user identity provider.")
  userIdp?: string;

  @doc("A user alternate sec id.")
  userAltSecId?: string;

  @doc("The issuer which issued the token for this user.")
  userIss?: string;

  @doc("A user or service principal's tenant ID.")
  userTenantId?: string;

  @doc("A user's full name or a service principal's app ID.")
  userName?: string;
}

@doc("Cost information for a job run.")
model JobCost {
  @doc("Charged CPU core-seconds.")
  chargedCpuCoreSeconds?: float64;

  @doc("Charged CPU memory megabyte-seconds.")
  chargedCpuMemoryMegabyteSeconds?: float64;

  @doc("Charged GPU seconds.")
  chargedGpuSeconds?: float64;

  @doc("Charged node utilization seconds.")
  chargedNodeUtilizationSeconds?: float64;
}

@doc("Run type categorization.")
model RunTypeV2 {
  @doc("Orchestrator that produced the run.")
  orchestrator?: string;

  @doc("Traits associated with the run.")
  traits?: string[];

  @doc("Attribution of the run.")
  attribution?: string;

  @doc("Compute type used by the run.")
  computeType?: string;
}

@doc("Interactive endpoint setting on a run service.")
model RunEndpointSetting {
  @doc("Endpoint type.")
  type?: string;

  @doc("Port the endpoint listens on.")
  port?: int32;

  @doc("SSL thumbprint for the endpoint.")
  sslThumbprint?: string;

  @doc("Endpoint URL.")
  endpoint?: string;

  @doc("Proxy endpoint URL.")
  proxyEndpoint?: string;

  @doc("Status of the endpoint.")
  status?: string;

  @doc("Error message if the endpoint failed to start.")
  errorMessage?: string;

  @doc("Whether the endpoint is enabled.")
  enabled?: boolean;

  @doc("Additional endpoint properties.")
  properties?: Record<string>;

  @doc("Nodes on which the endpoint is exposed.")
  nodes?: string;
}

@doc("Reference to a typed asset (data, model, etc.) consumed or produced by a run.")
model TypedAssetReference {
  @doc("The asset id.")
  assetId?: string;

  @doc("The asset type.")
  type?: string;
}

@doc("Standard error response payload returned for a run.")
model RunErrorResponse {
  @doc("The top level error that occurred.")
  error?: RootError;

  @doc("Dictionary containing correlation details for the error.")
  correlation?: Record<string>;

  @doc("The hosting environment.")
  environment?: string;

  @doc("The Azure region.")
  location?: string;

  @doc("The time in UTC when the error occurred.")
  time?: utcDateTime;

  @doc("Component name where the error originated or was encountered.")
  componentName?: string;
}

@doc("Runtime details of a job's run, including status, log file URLs, warnings and any error information.")
model RunDetails {
  @doc("The identifier for the run.")
  runId?: string;

  @doc("A system generated id for the run.")
  runUuid?: string;

  @doc("A system generated id for the run's parent.")
  parentRunUuid?: string;

  @doc("A system generated id for the root of the run's hierarchy.")
  rootRunUuid?: string;

  @doc("The name of the compute target where the run is executed.")
  target?: string;

  @doc("The status of the run.")
  status?: string;

  @doc("The parent of the run if the run is hierarchical.")
  parentRunId?: string;

  @doc("An identifier for the data associated with this run.")
  dataContainerId?: string;

  @doc("The creation time of the run in UTC.")
  createdTimeUtc?: utcDateTime;

  @doc("The start time of the run in UTC.")
  startTimeUtc?: utcDateTime;

  @doc("The end time of the run in UTC.")
  endTimeUtc?: utcDateTime;

  @doc("Error details for the run, if any.")
  error?: RunErrorResponse;

  @doc("A list of warnings that occurred during the run.")
  warnings?: RunDetailsWarning[];

  @doc("The tag dictionary for the run. Tags are mutable.")
  tags?: Record<string>;

  @doc("The properties dictionary for the run. Properties are immutable.")
  properties?: Record<string>;

  @doc("The parameters dictionary for the run. Parameters are immutable.")
  parameters?: Record<unknown>;

  @doc("The interactive run services for a run. Services are mutable.")
  services?: Record<RunEndpointSetting>;

  @doc("A list of datasets used as input to the run.")
  inputDatasets?: unknown[];

  @doc("A list of datasets used as output to the run.")
  outputDatasets?: unknown[];

  @doc("The run definition specification.")
  runDefinition?: unknown;

  @doc("Map of log file name to its URL.")
  logFiles?: Record<string>;

  @doc("Job cost information.")
  jobCost?: JobCost;

  @doc("Revision number.")
  revision?: int64;

  @doc("Run type information.")
  runTypeV2?: RunTypeV2;

  @doc("The run settings.")
  settings?: Record<string>;

  @doc("The compute requests.")
  computeRequest?: unknown;

  @doc("The compute record.")
  compute?: unknown;

  @doc("The user that created the run.")
  createdBy?: RunUser;

  @doc("The total compute time for a terminal run.")
  computeDuration?: duration;

  @doc("The effective start time of the run in UTC.")
  effectiveStartTimeUtc?: utcDateTime;

  @doc("The run number.")
  runNumber?: int32;

  @doc("The id of the root run in the hierarchy.")
  rootRunId?: string;

  @doc("The experiment id this run belongs to.")
  experimentId?: string;

  @doc("The id of the user that created the run.")
  userId?: string;

  @doc("Status revision number.")
  statusRevision?: int64;

  @doc("The cumulative compute time for an active run.")
  currentComputeTime?: duration;

  @doc("The last start time of the run in UTC.")
  lastStartTimeUtc?: utcDateTime;

  @doc("The user that last modified the run.")
  lastModifiedBy?: RunUser;

  @doc("The time the run was last modified in UTC.")
  lastModifiedUtc?: utcDateTime;

  @doc("The total duration of the run.")
  duration?: duration;

  @doc("The inputs for the run, keyed by input name.")
  inputs?: Record<TypedAssetReference>;

  @doc("The outputs for the run, keyed by output name.")
  outputs?: Record<TypedAssetReference>;

  @doc("The AttemptId of the most recent attempt.")
  currentAttemptId?: int32;
}

@doc("A job run.")
model Run {
  @doc("The display name of the run.")
  displayName?: string;

  @doc("The name of the run.")
  name?: string;

  @doc("An identifier for the data associated with this run.")
  dataContainerId?: string;

  @doc("A description of the run.")
  description?: string;

  @doc("Whether the run is hidden in run listings.")
  hidden?: boolean;

  @doc("Run type categorization.")
  runType?: string;

  @doc("Run type information.")
  runTypeV2?: RunTypeV2;

  @doc("The properties dictionary for the run.")
  properties?: Record<string>;

  @doc("The parameters dictionary for the run.")
  parameters?: Record<unknown>;

  @doc("Action URIs for the run, keyed by action name.")
  actionUris?: Record<string>;

  @doc("The script name associated with the run.")
  scriptName?: string;

  @doc("The name of the compute target where the run is executed.")
  target?: string;

  @doc("The set of unique compute targets used by child runs.")
  uniqueChildRunComputeTargets?: string[];

  @doc("The tag dictionary for the run. Tags are mutable.")
  tags?: Record<string>;

  @doc("The run settings.")
  settings?: Record<string>;

  @doc("The interactive run services for a run.")
  services?: Record<RunEndpointSetting>;

  @doc("A list of datasets used as input to the run.")
  inputDatasets?: unknown[];

  @doc("A list of datasets used as output to the run.")
  outputDatasets?: unknown[];

  @doc("The run definition specification.")
  runDefinition?: unknown;

  @doc("The job specification")
  jobSpecification?: unknown;

  @doc("The primary metric name for the run.")
  primaryMetricName?: string;

  @doc("Information about the source that created this run.")
  createdFrom?: unknown;

  @doc("URI used to cancel this run.")
  cancelUri?: string;

  @doc("URI used to mark this run as complete.")
  completeUri?: string;

  @doc("URI used to retrieve diagnostics for this run.")
  diagnosticsUri?: string;

  @doc("ARM id of the workspace.")
  virtualWorkspaceStorageArmId?: string;

  @doc("The compute requests for this run.")
  computeRequest?: unknown;

  @doc("The compute record for this run.")
  compute?: unknown;

  @doc("Whether the run should be retained for the lifetime of the workspace (root runs only).")
  retainForLifetimeOfWorkspace?: boolean;

  @doc("Queueing information for this run.")
  queueingInfo?: unknown;

  @doc("The inputs for the run, keyed by input name.")
  inputs?: Record<TypedAssetReference>;

  @doc("The outputs for the run, keyed by output name.")
  outputs?: Record<TypedAssetReference>;

  @doc("The identifier for the run.")
  runId?: string;

  @doc("The parent of the run if the run is hierarchical; otherwise, null.")
  parentRunId?: string;

  @doc("The id of the experiment that created this run.")
  experimentId?: string;

  @doc("The status of the run.")
  status?: string;

  @doc("The start time of the run in UTC.")
  startTimeUtc?: utcDateTime;

  @doc("The end time of the run in UTC.")
  endTimeUtc?: utcDateTime;

  @doc("The schedule that created this run, if it was created by a schedule.")
  scheduleId?: string;

  @doc("The run number.")
  runNumber?: int32;

  @doc("The id of the root run in the hierarchy.")
  rootRunId?: string;

  @doc("The time the run was created in UTC.")
  createdUtc?: utcDateTime;

  @doc("The user that created the run.")
  createdBy?: RunUser;

  @doc("The id of the user that created the run.")
  userId?: string;

  @doc("A token used for authenticating a run.")
  token?: string;

  @doc("The Token expiration time in UTC.")
  tokenExpiryTimeUtc?: utcDateTime;

  @doc("Error details for the run, if any.")
  error?: RunErrorResponse;

  @doc("A list of warnings that occurred during the run.")
  warnings?: RunDetailsWarning[];

  @doc("Revision number.")
  revision?: int64;

  @doc("Status revision number.")
  statusRevision?: int64;

  @doc("A system generated id for the run.")
  runUuid?: string;

  @doc("A system generated id for the run's parent.")
  parentRunUuid?: string;

  @doc("A system generated id for the root of the run's hierarchy.")
  rootRunUuid?: string;

  @doc("The last start time of the run in UTC.")
  lastStartTimeUtc?: utcDateTime;

  @doc("The cumulative compute time for an active run.")
  currentComputeTime?: duration;

  @doc("The total compute time for a terminal run.")
  computeDuration?: duration;

  @doc("The effective start time of the run in UTC.")
  effectiveStartTimeUtc?: utcDateTime;

  @doc("The user that last modified the run.")
  lastModifiedBy?: RunUser;

  @doc("The time the run was last modified in UTC.")
  lastModifiedUtc?: utcDateTime;

  @doc("The total duration of the run.")
  duration?: duration;

  @doc("The cancelation reason if the run was canceled.")
  cancelationReason?: string;

  @doc("The AttemptId of the most recent attempt.")
  currentAttemptId?: int32;
}

@doc("A data store path.")
model ArtifactDataPath {
  @doc("The data store name.")
  dataStoreName?: string;

  @doc("The relative path within the data store.")
  relativePath?: string;

  @doc("SQL data path information.")
  sqlDataPath?: unknown;
}

@doc("An artifact.")
model Artifact {
  @doc("The artifact id.")
  artifactId?: string;

  @doc("The artifact origin.")
  origin: string;

  @doc("The container name.")
  container: string;

  @doc("The artifact path.")
  path: string;

  @doc("The artifact Etag.")
  etag?: string;

  @doc("The artifact creation time in UTC.")
  createdTime?: utcDateTime;

  @doc("The artifact data path.")
  dataPath?: ArtifactDataPath;

  @doc("The artifact tags.")
  tags?: Record<string>;
}

@doc("A page of artifacts.")
model ArtifactList {
  @doc("The artifacts in the page.")
  value: Artifact[];

  @doc("Token for the next page.")
  continuationToken?: string;

  @doc("URL for the next page.")
  nextLink?: string;
}

@doc("Artifact content information.")
model ArtifactContentInformation {
  @doc("The content URI.")
  contentUri?: url;

  @doc("The artifact origin.")
  origin?: string;

  @doc("The container name.")
  container?: string;

  @doc("The artifact path.")
  path?: string;

  @doc("The artifact tags.")
  tags?: Record<string>;

  @doc("The content byte length.")
  contentLength?: int64;
}

@doc("A page of artifact content information.")
model ArtifactContentInformationList {
  @doc("The entries in the page.")
  value: ArtifactContentInformation[];

  @doc("Token for the next page.")
  continuationToken?: string;

  @doc("URL for the next page.")
  nextLink?: string;
}
