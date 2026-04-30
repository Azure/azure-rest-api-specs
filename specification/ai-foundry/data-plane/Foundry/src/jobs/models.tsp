import "../common/models.tsp";
import "../common/service.tsp";

using TypeSpec.Http;

namespace Azure.AI.Projects;

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Use an extensible union instead of a plain string"
@doc("Distribution configuration of the job. If set, this should be one of Mpi, Tensorflow, PyTorch, or null.")
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

  @doc("Number of workers. If not specified, will default to the instance count.")
  workerCount?: int32;

  @doc("Number of parameter server tasks.")
  parameterServerCount?: int32;
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

  @doc("Input Asset URI. Required for uri_file, uri_folder, and safetensors_model types.")
  @encodedName("application/json", "uri")
  path?: string;

  @doc("Input Asset Delivery Mode. Applies to uri-based inputs.")
  mode?: InputOutputModes;

  @doc("Literal value. Required for literal type.")
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

  @doc("Base model ID. Applies to safetensors_model outputs.")
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

  @doc("Nodes that user would like to start the service on. If Nodes is not set or set to null, the service will only be started on leader node.")
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

  @doc("Size of the docker container's shared memory block. This should be in the format of (number)(unit) where number as to be greater than 0 and the unit can be one of b(bytes), k(kilobytes), m(megabytes), or g(gigabytes).")
  shmSize?: string;

  @doc("Extra arguments to pass to the Docker run command. This would override any parameters that have already been set by the system, or in this section. This parameter is only supported for Azure ML compute types.")
  dockerArgs?: string;
}

@doc("Command Job limit class.")
model CommandJobLimits {
  @doc("JobLimit type.")
  jobLimitsType: "Command";

  @doc("The max run duration in ISO 8601 format, after which the job will be cancelled. Only supports duration with precision as low as Seconds.")
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

  @doc("Distribution configuration of the job. If set, this should be one of Mpi, Tensorflow, PyTorch, or null.")
  distribution?: DistributionConfiguration;

  @doc("Command Job limit.")
  limits?: CommandJobLimits;

  @doc("List of job services.")
  @visibility(Lifecycle.Read)
  services?: Record<JobService>;

  @doc("Queue settings for the job.")
  queueSettings?: QueueSettings;

  @doc("user-assigned managed identity")
  userAssignedIdentityId?: string;

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

@doc("Status of a job execution attempt.")
union JobAttemptStatus {
  string,

  @doc("The attempt is queued.")
  Queued: "Queued",

  @doc("The attempt is running.")
  Running: "Running",

  @doc("The attempt completed successfully.")
  Completed: "Completed",

  @doc("The attempt failed.")
  Failed: "Failed",

  @doc("The attempt was canceled.")
  Canceled: "Canceled",
}

@doc("Warning emitted during a job attempt.")
model JobAttemptWarning {
  @doc("Machine-readable warning code.")
  code?: string;

  @doc("Human-readable warning message.")
  message?: string;

  @doc("Additional warning details.")
  details?: Record<unknown>;
}

@doc("Error emitted during a job attempt.")
model JobAttemptError {
  @doc("Machine-readable error code.")
  code?: string;

  @doc("Human-readable error message.")
  message?: string;

  @doc("Additional error details.")
  details?: Record<unknown>;
}

@doc("One execution attempt of a job.")
model JobAttempt {
  @doc("The attempt identifier.")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("The job name this attempt belongs to.")
  @visibility(Lifecycle.Read)
  jobName: string;

  @doc("The attempt status.")
  @visibility(Lifecycle.Read)
  status?: JobAttemptStatus;

  @doc("Additional status reason.")
  @visibility(Lifecycle.Read)
  statusReason?: string;

  @doc("Time the attempt started.")
  @visibility(Lifecycle.Read)
  startTimeUtc?: utcDateTime;

  @doc("Time the attempt ended.")
  @visibility(Lifecycle.Read)
  endTimeUtc?: utcDateTime;

  @doc("Most recent time the attempt started running.")
  @visibility(Lifecycle.Read)
  lastStartTimeUtc?: utcDateTime;

  @doc("Total compute duration consumed by the attempt.")
  @visibility(Lifecycle.Read)
  computeDuration?: duration;

  @doc("Queueing details associated with the attempt.")
  @visibility(Lifecycle.Read)
  queueingInfo?: Record<unknown>;

  @doc("Compute details associated with the attempt.")
  @visibility(Lifecycle.Read)
  computeDetails?: Record<unknown>;

  @doc("Terminal error for the attempt, if any.")
  @visibility(Lifecycle.Read)
  error?: JobAttemptError;

  @doc("Warnings emitted for the attempt.")
  @visibility(Lifecycle.Read)
  warnings?: JobAttemptWarning[];

  @doc("Whether this attempt is the current attempt for the job.")
  @visibility(Lifecycle.Read)
  isCurrent?: boolean;
}

@doc("Type of a job artifact.")
union JobArtifactType {
  string,

  @doc("A file artifact.")
  File: "File",

  @doc("A directory artifact.")
  Directory: "Directory",
}

@doc("Metadata for an artifact produced by or attached to a job.")
model JobArtifact {
  @doc("Artifact path relative to the job artifact root.")
  @visibility(Lifecycle.Read)
  path: string;

  @doc("Artifact type.")
  @visibility(Lifecycle.Read)
  type?: JobArtifactType;

  @doc("Artifact size in bytes.")
  @visibility(Lifecycle.Read)
  size?: int64;

  @doc("Time the artifact was created.")
  @visibility(Lifecycle.Read)
  createdTimeUtc?: utcDateTime;

  @doc("Time the artifact was last updated.")
  @visibility(Lifecycle.Read)
  updatedTimeUtc?: utcDateTime;

  @doc("Service origin of the artifact.")
  @visibility(Lifecycle.Read)
  origin?: string;

  @doc("Diagnostic storage container identifier resolved by the service.")
  @visibility(Lifecycle.Read)
  container?: string;
}

@doc("Content access information for a job artifact.")
model JobArtifactContentInfo {
  @doc("Artifact path relative to the job artifact root.")
  @visibility(Lifecycle.Read)
  path: string;

  @doc("Download URI for the artifact content.")
  @visibility(Lifecycle.Read)
  contentUri?: url;

  @doc("MIME type of the content.")
  @visibility(Lifecycle.Read)
  contentType?: string;

  @doc("Time the content URI expires.")
  @visibility(Lifecycle.Read)
  expiresAtUtc?: utcDateTime;
}

@doc("The kind of metric emitted by a job.")
union JobMetricType {
  string,

  @doc("Scalar metric values.")
  Scalar: "Scalar",

  @doc("Table metric values.")
  Table: "Table",

  @doc("Image metric values.")
  Image: "Image",
}

@doc("Metadata for a metric emitted by a job or attempt.")
model JobMetric {
  @doc("Metric name.")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("Metric type.")
  @visibility(Lifecycle.Read)
  metricType?: JobMetricType;

  @doc("Column metadata for structured metric values.")
  @visibility(Lifecycle.Read)
  columns?: Record<string>;
}

@doc("A metric data point.")
model JobMetricPoint {
  @doc("Metric identifier.")
  @visibility(Lifecycle.Read)
  metricId?: string;

  @doc("Metric step.")
  @visibility(Lifecycle.Read)
  step?: int64;

  @doc("Time the metric point was created.")
  @visibility(Lifecycle.Read)
  createdUtc?: utcDateTime;

  @doc("Metric data values.")
  @visibility(Lifecycle.Read)
  data?: Record<unknown>;
}

@doc("Latest value for a metric.")
model JobMetricLastValue {
  @doc("Metric name.")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("Latest metric point.")
  @visibility(Lifecycle.Read)
  value?: JobMetricPoint;
}

@doc("Aggregated values for a metric.")
model JobMetricAggregate {
  @doc("Metric name.")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("Aggregate window start.")
  @visibility(Lifecycle.Read)
  startUtc?: utcDateTime;

  @doc("Aggregate window end.")
  @visibility(Lifecycle.Read)
  endUtc?: utcDateTime;

  @doc("Aggregate values.")
  @visibility(Lifecycle.Read)
  values?: Record<unknown>;
}

@doc("Sampled values for a metric.")
model JobMetricSample {
  @doc("Metric name.")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("Sampled metric points.")
  @visibility(Lifecycle.Read)
  points: JobMetricPoint[];
}

@doc("Named output produced by a job.")
model JobOutputReference {
  @doc("Output name.")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("Output asset type.")
  @visibility(Lifecycle.Read)
  type?: AssetTypes;

  @doc("Output delivery mode.")
  @visibility(Lifecycle.Read)
  mode?: InputOutputModes;

  @doc("Output storage URI.")
  @visibility(Lifecycle.Read)
  uri?: string;

  @doc("Registered asset name, if the output produced an asset.")
  @visibility(Lifecycle.Read)
  assetName?: string;

  @doc("Registered asset version, if the output produced an asset.")
  @visibility(Lifecycle.Read)
  assetVersion?: string;

  @doc("Base model ID for model outputs.")
  @visibility(Lifecycle.Read)
  baseModelId?: string;

  @doc("Output description.")
  @visibility(Lifecycle.Read)
  description?: string;
}

alias JobChildListQueryParameters = {
  @doc("Maximum number of items to return.")
  @query limit?: int32;

  @doc("Continuation token returned by a previous list request.")
  @query @continuationToken skipToken?: string;
};

alias JobArtifactListQueryParameters = JobChildListQueryParameters & {
  @doc("Artifact path prefix to list.")
  @query pathPrefix?: string;
};

alias JobMetricQueryParameters = {
  @doc("Start of the metric time range.")
  @query startTimeUtc?: utcDateTime;

  @doc("End of the metric time range.")
  @query endTimeUtc?: utcDateTime;

  @doc("Minimum metric step to include.")
  @query minStep?: int64;

  @doc("Maximum metric step to include.")
  @query maxStep?: int64;

  @doc("Maximum number of metric points to return.")
  @query limit?: int32;
};
