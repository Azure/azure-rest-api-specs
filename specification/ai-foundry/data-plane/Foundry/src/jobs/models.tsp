import "../common/models.tsp";
import "../common/service.tsp";
import "../common/servicepatterns.tsp";

using TypeSpec.Http;
using Azure.ClientGenerator.Core;

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

@doc("Delivery modes for asset inputs. Literal inputs do not use a delivery mode. The service uses ReadOnlyMount when an asset input's mode is omitted. Tolerate additional response values; extensibility does not make unsupported request values valid.")
union InputDeliveryMode {
  string,

  @doc("Read-only mount mode.")
  ReadOnlyMount: "ReadOnlyMount",

  @doc("Read-write mount mode.")
  ReadWriteMount: "ReadWriteMount",

  @doc("Download mode.")
  Download: "Download",

  @doc("Direct mode.")
  Direct: "Direct",

  @doc("Evaluation mount mode.")
  EvalMount: "EvalMount",

  @doc("Evaluation download mode.")
  EvalDownload: "EvalDownload",
}

@doc("Delivery modes for job outputs. The service uses ReadWriteMount when omitted. ReadOnlyMount, Download and the evaluation input modes are not output modes. Tolerate additional response values; extensibility does not make unsupported request values valid.")
union OutputDeliveryMode {
  string,

  @doc("Read-write mount mode.")
  ReadWriteMount: "ReadWriteMount",

  @doc("Upload mode.")
  Upload: "Upload",

  @doc("Direct mode.")
  Direct: "Direct",
}

@doc("Input types faithfully supported by the Foundry Training Job mapping. Asset types require a non-empty URI; literal requires a non-empty value instead. Tolerate additional response values; extensibility does not make unsupported request values valid.")
union JobInputType {
  string,

  @doc("URI file asset.")
  UriFile: "uri_file",

  @doc("URI folder asset.")
  UriFolder: "uri_folder",

  @doc("MLTable asset.")
  MLTable: "mltable",

  @doc("Custom model asset.")
  CustomModel: "custom_model",

  @doc("MLflow model asset.")
  MLflowModel: "mlflow_model",

  @doc("Triton model asset.")
  TritonModel: "triton_model",

  @doc("Literal value (inputs only).")
  Literal: "literal",
}

@doc("Output asset types. A literal value is not a job output. Tolerate additional response values; extensibility does not make unsupported request values valid.")
union JobOutputType {
  string,

  @doc("URI file asset.")
  UriFile: "uri_file",

  @doc("URI folder asset.")
  UriFolder: "uri_folder",

  @doc("MLTable asset.")
  MLTable: "mltable",

  @doc("Custom model asset.")
  CustomModel: "custom_model",

  @doc("MLflow model asset.")
  MLflowModel: "mlflow_model",

  @doc("Triton model asset.")
  TritonModel: "triton_model",

  @doc("Safetensors model asset.")
  SafetensorsModel: "safetensors_model",
}

@doc("A job input with type-dependent fields. For literal, supply a non-empty value and omit path/mode. For an asset type, supply a non-empty path (serialized as uri), omit value, and optionally select an input delivery mode. The service validates the required field for the selected type and returns 400 when it is absent or empty. The flat shape and existing jobInputType wire name are retained for compatibility.")
model Input {
  @doc("Specifies the type of job input.")
  @encodedName("application/json", "jobInputType")
  type: JobInputType;

  @doc("Required non-empty asset URI for non-literal inputs. This property is serialized as uri. It is not used for literal inputs; supply value instead.")
  @encodedName("application/json", "uri")
  path?: string;

  @doc("Delivery mode for asset inputs only. Defaults to ReadOnlyMount in the service when omitted. Not used for literal inputs.")
  mode?: InputDeliveryMode;

  @doc("Required non-empty string for literal inputs. Not used for asset inputs; supply path instead.")
  value?: string;
}

@doc("A job output asset, never a literal value. A destination URI is optional at submission: the runtime can materialize the output in job storage and the service can return its resolved URI later. Omit uri to use that behavior. The flat shape and existing jobOutputType wire name are retained for compatibility.")
model Output {
  @doc("Specifies the type of job output.")
  @encodedName("application/json", "jobOutputType")
  type: JobOutputType;

  @doc("Output delivery mode. Defaults to ReadWriteMount in the service when omitted. Input-only delivery modes are not supported.")
  mode?: OutputDeliveryMode;

  @doc("Name of the output data asset to register.")
  assetName?: string | null;

  @doc("Version of the output data asset to register.")
  assetVersion?: string | null;

  @doc("Optional output destination URI. When omitted on submission, the runtime can materialize the output in job storage; a subsequent resource read can include the resolved URI.")
  uri?: string | null;

  @doc("Base model ID.")
  baseModelId?: string | null;

  @doc("Description for the output.")
  description?: string | null;
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
  jobServiceType?: string | null;

  @doc("Port for endpoint.")
  port?: int32 | null;

  @doc("Service-resolved endpoint URI, when available. The caller requests a service using its type, port, properties and nodes; it does not select the endpoint URI. Resource reads can include runtime-resolved endpoints and server-generated Tracking/Studio helper services.")
  @visibility(Lifecycle.Read)
  endpoint?: string | null;

  @doc("Additional properties to set on the endpoint.")
  properties?: Record<string> | null;

  @doc("Nodes that user would like to start the service on.")
  nodes?: AllNodes | null;

  @doc("Status of endpoint.")
  @visibility(Lifecycle.Read)
  status?: string | null;

  @doc("Any error in the service.")
  @visibility(Lifecycle.Read)
  errorMessage?: string | null;
}

@doc("Submitted compute configuration. The service persists the requested settings and resource reads return that persisted configuration, not a resolved-allocation receipt. Runtime VM/SKU and node-count resolution is separate and can differ from the request. Same-name PUTs must preserve submitted configuration; omit unchanged optional configuration when updating metadata. Omit server-owned response fields when constructing a PUT from a GET.")
model JobResourceConfiguration {
  @doc("Requested instance or node count; the service uses 1 when omitted. GPU allocation can resolve a different node count from gpuCount and the selected SKU. Resource reads reflect the persisted requested count rather than guaranteeing the resolved execution node count.")
  instanceCount?: int32;

  @doc("Requested VM type, as supported by the compute target. Virtual cluster targets require an explicit instance type when gpuCount is supplied. The service can select a different partial GPU SKU for execution; that resolved SKU does not replace this persisted request field.")
  instanceType?: string | null;

  @doc("Requested total GPU count, serialized only as resources.gpuCount. Omitted or null means no GPU-count request. Non-null valid values are 1, 2, 4, 8, or multiples of 8 greater than 8; other non-null values are rejected with 400. The value maps to the persisted compute allocation request and is returned at the same location by resource reads. It can determine the execution SKU and node count instead of resources.instanceCount. CPU compute targets ignore the count for placement while retaining the submitted configuration. Virtual cluster targets also require resources.instanceType. This is immutable submitted configuration, not the resolved runtime GPU allocation. There is no top-level gpuCount or capacityUnitCount alias.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @minValue(1)
  gpuCount?: int32 | null;

  @doc("Additional properties bag.")
  properties?: Record<unknown> | null;

  @doc("Size of the docker container's shared memory block.")
  shmSize?: string;

  @doc("Extra arguments to pass to the Docker run command.")
  dockerArgs?: string | null;
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

@doc("User-visible scheduling priority for a job.")
union JobPriority {
  string,

  @doc("Low scheduling priority.")
  Low: "Low",

  @doc("Medium scheduling priority.")
  Mid: "Mid",

  @doc("High scheduling priority.")
  High: "High",
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

@doc("Case-sensitive execution states reported by the job runtime, not operation-monitor states. Runtime-dependent stages can be skipped, and observations are not guaranteed to follow a fixed linear sequence. `Completed`, `Failed`, and `Canceled` are terminal; a terminal job does not transition to another execution state. Other known states are non-terminal. Clients must tolerate additional values and must not infer completion from an absent or unrecognized status.")
union CommandJobStatus {
  string,

  @doc("The job has not started execution.")
  NotStarted: "NotStarted",

  @doc("The job is awaiting approval in a runtime that requires it.")
  Unapproved: "Unapproved",

  @doc("The runtime is pausing execution; this is not a terminal state.")
  Pausing: "Pausing",

  @doc("Execution is paused; this is not a terminal state and does not imply cancellation.")
  Paused: "Paused",

  @doc("The runtime is starting the job.")
  Starting: "Starting",

  @doc("The runtime is preparing the job environment.")
  Preparing: "Preparing",

  @doc("The job is waiting for compute capacity.")
  Queued: "Queued",

  @doc("The training command is executing.")
  Running: "Running",

  @doc("Execution has finished on compute and output collection is in progress; this is not yet a terminal state.")
  Finalizing: "Finalizing",

  @doc("Cancellation has been requested but execution is not confirmed stopped. The final state can be Canceled, Completed, or Failed.")
  CancelRequested: "CancelRequested",

  @doc("Execution and output collection completed successfully. Terminal.")
  Completed: "Completed",

  @doc("Execution failed. Terminal, even when no stored error is available. Inspect the job's error details and log artifacts.")
  Failed: "Failed",

  @doc("Execution was canceled. Terminal; a successful cancellation request alone does not establish this outcome.")
  Canceled: "Canceled",
}

@doc("Stored job-level failure diagnostics returned inside a successful job-resource response. This is a direct error object, not the HTTP error-response envelope. The fields follow the existing resource wire contract, including camel-case `innerError` and `referenceCode`; they are distinct from the HTTP error envelope's `innererror`. Some stored diagnostics are incomplete. Missing or null diagnostic fields do not change a Failed execution outcome. Internal debug information is not part of this contract.")
model CommandJobError {
  @doc("Server-defined failure classification, or null if it was not recorded. Codes are extensible; use recognized codes for programmatic handling, not message text.")
  code: string | null;

  @doc("Human-readable diagnostic information, or null if it was not recorded. Intended for developers; do not parse it for programmatic handling or assume it is localized for end users.")
  message: string | null;

  @doc("A more specific service-defined failure reference, when recorded. Tolerate unrecognized values.")
  referenceCode?: string | null;

  @doc("The failure target, when recorded.")
  target?: string | null;

  @doc("Related structured failure details, when recorded.")
  details?: CommandJobError[] | null;

  @doc("More specific nested diagnostic codes, when recorded. Inspect the deepest code that the client recognizes.")
  innerError?: CommandJobInnerError | null;

  @doc("A URI pointing to additional failure context, when supplied by the runtime. It is not an operation-monitor or artifact-download URI.")
  detailsUri?: url | null;
}

@doc("Nested diagnostic codes in the job-resource error. The existing JSON spelling is `innerError`, including at each nested level.")
model CommandJobInnerError {
  @doc("A more specific server-defined diagnostic code, when recorded.")
  code?: string | null;

  @doc("A further nested diagnostic code, when recorded.")
  innerError?: CommandJobInnerError | null;
}

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Use an extensible union instead of a plain string"
@doc("Base properties of a Job.")
@discriminator("jobType")
model JobProperties {
  @doc("Job type.")
  jobType: string;
}

@doc("A command job's submitted configuration and metadata. Creation-only fields are pinned on the first persisted submission and cannot be changed by a same-name PUT. After submission is tracked, display name, description, tags and additive user properties can change while the job is running or terminal; such changes do not restart execution. The existing public projection returns explicit null for some unset optional fields, as modeled below. Required command, environment and compute fields remain non-null. A null metadata value is not a request to clear it.")
model CommandJob extends JobProperties {
  @doc("Job type.")
  jobType: "Command";

  @doc("The command to execute on startup of the job. Immutable after the initial submission.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  command: string;

  @doc("ACR path of the environment image. Immutable after the initial submission.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  environmentImageReference: string;

  @doc("Mutable display name. Omission or null preserves the current value on update; an empty string clears it. Can be updated on tracked running or terminal jobs without restarting execution. Resource reads can return null when unset.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  displayName?: string | null;

  @doc("Mutable job description. Omission or null preserves the current value on update; an empty string clears it. Resource reads can return null when unset.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  description?: string | null;

  @doc("The name of the experiment the job belongs to. If not set, the job is placed in the \"Default\" experiment. This assignment is immutable after the initial submission.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  experimentName?: string;

  @doc("Mutable tags. A supplied map replaces the entire stored map; omitted or null tags remain unchanged and an empty map clears all tags. Tags can be changed on tracked running or terminal jobs without restarting execution. Resource reads can return null when unset.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  tags?: Record<string> | null;

  @doc("Additive user properties. Updates may add new keys or repeat existing values, but changing an existing value is rejected with 400. Omission or null preserves existing properties; an empty map does not clear them. Resource reads can return null when unset.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  properties?: Record<string> | null;

  @doc("Code asset reference.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @encodedName("application/json", "codeId")
  code?: string | null;

  @doc("Compute resource ID.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @encodedName("application/json", "computeId")
  compute: string;

  @doc("Mapping of input data bindings used in the job.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  inputs?: Record<Input> | null;

  @doc("Mapping of output data bindings used in the job.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  outputs?: Record<Output> | null;

  @doc("Environment variables included in the job.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  environmentVariables?: Record<string> | null;

  @doc("Submitted compute configuration. GPU allocation is specified only by resources.gpuCount. GET returns the persisted request settings, not a guarantee of the runtime-resolved SKU or node count. Preserve submitted settings on same-name replay or omit unchanged optional configuration on a tracked metadata update.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  resources?: JobResourceConfiguration;

  @doc("Distribution configuration of the job.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  distribution?: DistributionConfiguration | null;

  @doc("Command Job limit.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  limits?: CommandJobLimits | null;

  @doc("List of job services.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  services?: Record<JobService> | null;

  @doc("Creation-time queue configuration, not mutable job metadata. A tracked same-name PUT does not provide a queue-setting or priority update.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  queueSettings?: QueueSettings;

  @doc("User-visible scheduling priority for the job.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  priority?: JobPriority | null;

  @doc("user-assigned managed identity")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  userAssignedIdentityId?: string | null;

  @doc("Read-only legacy compatibility flag. Foundry Training Jobs are not archived and this flag is false; this API does not support archiving or resetting the archive flag by PUT. Use delete for soft-deletion.")
  @visibility(Lifecycle.Read)
  isArchived?: boolean;

  @doc("Execution state, not the status of an API request. A job returned with HTTP 200 can be Failed or Canceled. Only Completed, Failed, and Canceled are terminal; other or unrecognized values must not be treated as successful completion. Runtime-dependent stages may be skipped. Cancellation can race with Completed or Failed and does not guarantee Canceled. For Failed, inspect error when available, then use the artifact operations to retrieve log files. Absence of an error does not imply execution success.")
  @visibility(Lifecycle.Read)
  status?: CommandJobStatus;

  @doc("Server-owned stored failure diagnostics for a Failed job, when available. GET and LIST still return successful HTTP responses for failed executions; this is application-level failure information, not an HTTP exception. The property is omitted if no stored failure is available, and no error is projected for other execution states. Inspect recognized code/referenceCode/innerError values and message, then list the job's log artifacts and obtain content information for the selected exact file. Diagnostics or log files are not guaranteed for every failure. Retry execution with a different job name after correcting the submitted configuration; same-name replay does not restart a failed job.")
  @visibility(Lifecycle.Read)
  error?: CommandJobError;
}

@doc("A Foundry Training Job resource whose creation and updates complete independently of its asynchronous execution.")
@Rest.resource("training_jobs")
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

@doc("Legacy-compatible archive view selector. Foundry Training Jobs do not support archiving. ActiveOnly and All select the same non-deleted training jobs; ArchivedOnly returns an empty page after the service validates the other query options. This is not an execution-status filter or an archive mutation capability.")
union ListViewType {
  string,

  @doc("Show non-deleted training jobs. This is the default and has the same FTJ result set as All.")
  ActiveOnly: "ActiveOnly",

  @doc("Return an empty page because training jobs are never archived. Other query options are still validated.")
  ArchivedOnly: "ArchivedOnly",

  @doc("Show non-deleted training jobs, the same FTJ result set as ActiveOnly.")
  All: "All",
}

@doc("A job artifact descriptor. Listing artifacts does not return download credentials.")
model Artifact {
  @doc("The case-sensitive artifact path relative to the job's artifact container.")
  path: string;

  @doc("The artifact content length in bytes, when available. An omitted or null value means the length is unknown; zero identifies an empty file.")
  contentLength?: int64 | null;
}

@doc("A page of artifacts.")
model ArtifactList {
  @doc("The artifacts in the page.")
  @pageItems
  value: Artifact[];

  @doc("The URL to the next page, if more artifacts are available. Follow this URL unchanged rather than constructing a continuation request.")
  @nextLink
  nextLink?: url;
}

@doc("Content access information for one job artifact.")
model ArtifactContentInformation {
  @doc("The case-sensitive artifact path relative to the job's artifact container.")
  path: string;

  @doc("The URI used to download the artifact content. Obtain a new URI from this operation when the current URI expires; storage network restrictions still apply.")
  contentUri: url;

  @doc("The artifact content length in bytes, when available. An omitted or null value means the length is unknown; zero identifies an empty file.")
  contentLength?: int64 | null;
}
