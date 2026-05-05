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

@doc("Training algorithm used by a declarative training job.")
union TrainingAlgorithm {
  string,

  @doc("Supervised fine tuning.")
  Sft: "Sft",

  @doc("Direct preference optimization.")
  Dpo: "Dpo",

  @doc("Kahneman-Tversky optimization.")
  Kto: "Kto",

  @doc("Odds ratio preference optimization.")
  Orpo: "Orpo",

  @doc("Contrastive preference optimization.")
  Cpo: "Cpo",

  @doc("Simple preference optimization.")
  SimPo: "SimPo",

  @doc("Group relative policy optimization.")
  Grpo: "Grpo",

  @doc("Proximal policy optimization.")
  Ppo: "Ppo",

  @doc("REINFORCE leave-one-out.")
  Rloo: "Rloo",

  @doc("REINFORCE++.")
  ReinforcePp: "ReinforcePp",

  @doc("Reward model training.")
  RewardModel: "RewardModel",
}

@doc("Training framework used to lower a declarative training job into an execution command.")
union TrainingFramework {
  string,

  @doc("TRL framework.")
  Trl: "Trl",

  @doc("VERL framework.")
  Verl: "Verl",

  @doc("OpenRLHF framework.")
  OpenRlhf: "OpenRlhf",

  @doc("NeMo RL framework.")
  NemoRl: "NemoRl",

  @doc("Slime framework.")
  Slime: "Slime",

  @doc("TorchForge framework.")
  TorchForge: "TorchForge",
}

@doc("Chat template used to format conversational training data.")
union ChatTemplate {
  string,

  @doc("ChatML template.")
  Chatml: "Chatml",

  @doc("Llama 3 chat template.")
  Llama3: "llama-3",

  @doc("Zephyr chat template.")
  Zephyr: "Zephyr",

  @doc("Gemma chat template.")
  Gemma: "Gemma",

  @doc("Phi 3 chat template.")
  Phi3: "phi-3",
}

@doc("Mapping from logical training fields to columns in the dataset.")
model TrainingColumnMapping {
  @doc("Column containing prompts.")
  prompt?: string;

  @doc("Column containing chosen responses for preference training.")
  chosen?: string;

  @doc("Column containing rejected responses for preference training.")
  rejected?: string;

  @doc("Column containing reference answers or reward context.")
  reference?: string;

  @doc("Column containing chat messages.")
  messages?: string;
}

@doc("Formatting options for conversational training data.")
model TrainingDataFormatConfiguration {
  @doc("Built-in chat template to apply to the dataset.")
  chatTemplate?: ChatTemplate;

  @doc("Path to a custom chat template relative to the job's code directory.")
  chatTemplatePath?: string;
}

@doc("Dataset configuration for a declarative training job.")
model TrainingDatasetConfiguration {
  @doc("Training dataset asset reference.")
  train: string;

  @doc("Optional evaluation dataset asset reference.")
  eval?: string;

  @doc("Mapping from training fields to dataset columns.")
  columns?: TrainingColumnMapping;

  @doc("Conversational data formatting options.")
  dataFormat?: TrainingDataFormatConfiguration;
}

@doc("Reference to a Python callable relative to the job's code directory.")
model TrainingEntryPointReference {
  @doc("Path to the Python callable in module/file.py:function format.")
  entryPoint: string;
}

@doc("Python runtime dependencies for an inline function.")
model TrainingInlineFunctionRuntime {
  @doc("Pip packages to install before invoking the inline function.")
  pip?: string[];
}

@doc("Inline Python function definition for custom training logic.")
model TrainingInlineFunctionConfiguration {
  @doc("Python function definition.")
  def: string;

  @doc("Runtime dependencies for the inline function.")
  runtime?: TrainingInlineFunctionRuntime;
}

@doc("Reward signal configuration for reinforcement or reward model training.")
model TrainingRewardConfiguration {
  @doc("Reward model asset reference.")
  `model`?: string;

  @doc("Python callable used to compute reward scores.")
  function?: TrainingEntryPointReference;

  @doc("Inline Python function used to compute reward scores.")
  @encodedName("application/json", "inline_function")
  inlineFunction?: TrainingInlineFunctionConfiguration;
}

@doc("LoRA adapter configuration for parameter-efficient fine tuning.")
model TrainingLoraConfiguration {
  @doc("Low-rank dimension.")
  rank: int32;

  @doc("LoRA scaling factor.")
  alpha?: int32;

  @doc("Dropout applied to adapter inputs.")
  dropout?: float64 = 0.05;

  @doc("Linear layers that receive adapters. Use 'auto' to let the framework choose defaults.")
  targetModules?: string = "auto";

  @doc("Whether to enable QLoRA 4-bit base weight loading.")
  quantize?: boolean = false;
}

@doc("Inference engine used for rollout generation during online reinforcement learning.")
union TrainingRolloutEngine {
  string,

  @doc("vLLM inference engine.")
  Vllm: "Vllm",

  @doc("SGLang inference engine.")
  Sglang: "Sglang",

  @doc("Hugging Face generate-based inference.")
  Hf: "Hf",

  @doc("Megatron-Core native inference.")
  MegatronInference: "MegatronInference",
}

@doc("Rollout generation configuration for online reinforcement learning.")
model TrainingRolloutConfiguration {
  @doc("Rollout inference engine.")
  engine: TrainingRolloutEngine;

  @doc("Tensor parallel size used by the rollout engine.")
  tensorParallelSize?: int32 = 1;

  @doc("GPU memory utilization target for the rollout engine, between 0.0 and 1.0.")
  gpuMemoryUtilization?: float64;
}

@doc("Built-in evaluation benchmark.")
union TrainingEvalBenchmark {
  string,

  @doc("Grade School Math 8K benchmark.")
  Gsm8k: "Gsm8k",

  @doc("Massive Multitask Language Understanding benchmark.")
  Mmlu: "Mmlu",

  @doc("Human-written code generation benchmark.")
  Humaneval: "Humaneval",

  @doc("Mostly Basic Python Programs benchmark.")
  Mbpp: "Mbpp",

  @doc("AI2 Reasoning Challenge benchmark.")
  Arc: "Arc",

  @doc("HellaSwag commonsense inference benchmark.")
  Hellaswag: "Hellaswag",
}

@doc("Evaluation configuration for a declarative training job.")
model TrainingEvalConfiguration {
  @doc("Named built-in benchmark. Mutually exclusive with dataset.")
  benchmark?: TrainingEvalBenchmark;

  @doc("Custom evaluation dataset asset reference. Mutually exclusive with benchmark.")
  dataset?: string;

  @doc("Evaluation frequency in training steps. Omit for end-of-training only.")
  everyNSteps?: int32;
}

@doc("Declarative training recipe. When specified, command must be omitted and environmentImageReference is optional.")
model TrainingConfiguration {
  @doc("Training algorithm.")
  algorithm: TrainingAlgorithm;

  @doc("Training framework. If omitted, the service selects a compatible framework.")
  framework?: TrainingFramework;

  @doc("Base model asset reference.")
  `model`: string;

  @doc("Training and optional evaluation datasets.")
  dataset: TrainingDatasetConfiguration;

  @doc("Reward signal configuration.")
  reward?: TrainingRewardConfiguration;

  @doc("LoRA adapter configuration.")
  lora?: TrainingLoraConfiguration;

  @doc("Rollout generation configuration.")
  rollout?: TrainingRolloutConfiguration;

  @doc("Evaluation configuration.")
  eval?: TrainingEvalConfiguration;
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

  @doc("The command to execute on startup of the job. Required when training is not specified, and must be omitted when training is specified.")
  command?: string;

  @doc("ACR path or Azure ML environment reference. Required when training is not specified.")
  environmentImageReference?: string;

  @doc("Declarative training recipe. When specified, the service compiles the recipe into the command and environment used for execution.")
  training?: TrainingConfiguration;

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

  @doc("Number of GPUs requested by the training job.")
  gpuCount?: int32;

  @doc("Distribution configuration of the job. If set, this should be one of Mpi, Tensorflow, PyTorch, or null.")
  distribution?: DistributionConfiguration;

  @doc("Command Job limit.")
  limits?: CommandJobLimits;

  @doc("Queue settings for the job.")
  queueSettings?: QueueSettings;

  @doc("user-assigned managed identity")
  userAssignedIdentityId?: string;

  @doc("Status of the job.")
  @visibility(Lifecycle.Read)
  status?: string;
}

@doc("Training job resource.")
@Rest.resource("trainingJobs")
model Job {
  @doc("The name of the training job. This is case-sensitive.")
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

  @doc("URL to poll for the final result of the delete operation.")
  @header("Location")
  location: string;

  @doc("URL to poll for the status of the delete operation.")
  @header("Operation-Location")
  operationLocation?: string;

  @doc("Suggested delay in seconds before polling.")
  @header("Retry-After")
  retryAfter?: int32;
}

@doc("Response returned when a job cancel operation is accepted asynchronously.")
model JobCancelAcceptedResponse {
  @statusCode statusCode: 202;

  @doc("URL to poll for the final result of the cancel operation.")
  @header("Location")
  location: string;

  @doc("URL to poll for the status of the cancel operation.")
  @header("Operation-Location")
  operationLocation?: string;

  @doc("Suggested delay in seconds before polling.")
  @header("Retry-After")
  retryAfter?: int32;
}

@doc("Status of an asynchronous training job operation.")
union JobOperationStatus {
  string,

  @doc("Operation is being processed.")
  InProgress: "InProgress",

  @doc("Operation is deleting resources.")
  Deleting: "Deleting",

  @doc("Operation completed successfully.")
  Succeeded: "Succeeded",

  @doc("Operation failed.")
  Failed: "Failed",

  @doc("Operation was canceled.")
  Canceled: "Canceled",
}

@doc("Error details for an asynchronous training job operation.")
model JobOperationError {
  @doc("Machine-readable error code.")
  code?: string;

  @doc("Human-readable error message.")
  message?: string;

  @doc("Additional error information.")
  details?: Record<unknown>;
}

@doc("Asynchronous training job operation resource.")
model JobOperationResource {
  @doc("Operation resource ID.")
  @visibility(Lifecycle.Read)
  id?: string;

  @doc("Operation name.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("Operation status.")
  @visibility(Lifecycle.Read)
  status: JobOperationStatus;

  @doc("Operation result properties.")
  @visibility(Lifecycle.Read)
  properties?: Record<unknown>;

  @doc("Operation start time.")
  @visibility(Lifecycle.Read)
  startTime?: utcDateTime;

  @doc("Operation end time.")
  @visibility(Lifecycle.Read)
  endTime?: utcDateTime;

  @doc("Operation completion percentage from 0 to 100.")
  @visibility(Lifecycle.Read)
  percentComplete?: float64;

  @doc("Operation error information.")
  @visibility(Lifecycle.Read)
  error?: JobOperationError;
}

@doc("Response returned when a training job operation is still in progress.")
model JobOperationAcceptedResponse {
  @statusCode statusCode: 202;

  @doc("URL to poll for the operation result.")
  @header("Location")
  location?: string;

  @doc("URL to poll for the operation status.")
  @header("Operation-Location")
  operationLocation?: string;
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

@doc("Status of a job execution run.")
union JobRunStatus {
  string,

  @doc("The run is queued.")
  Queued: "Queued",

  @doc("The run is running.")
  Running: "Running",

  @doc("The run completed successfully.")
  Completed: "Completed",

  @doc("The run failed.")
  Failed: "Failed",

  @doc("The run was canceled.")
  Canceled: "Canceled",
}

@doc("Warning emitted during a job run.")
model JobRunWarning {
  @doc("Machine-readable warning code.")
  code?: string;

  @doc("Human-readable warning message.")
  message?: string;

  @doc("Additional warning details.")
  details?: Record<unknown>;
}

@doc("Error emitted during a job run.")
model JobRunError {
  @doc("Machine-readable error code.")
  code?: string;

  @doc("Human-readable error message.")
  message?: string;

  @doc("Additional error details.")
  details?: Record<unknown>;
}

@doc("Service endpoint details for a training job.")
model TrainingJobService {
  @doc("Service type.")
  @visibility(Lifecycle.Read)
  type?: string;

  @doc("Service port.")
  @visibility(Lifecycle.Read)
  port?: int32;

  @doc("Service status.")
  @visibility(Lifecycle.Read)
  status?: string;

  @doc("Terminal error for the service, if any.")
  @visibility(Lifecycle.Read)
  error?: Record<unknown>;

  @doc("Service endpoint URI.")
  @visibility(Lifecycle.Read)
  endpoint?: string;

  @doc("Additional service properties.")
  @visibility(Lifecycle.Read)
  properties?: Record<string>;
}

@doc("Services exposed by a training job.")
model TrainingJobServiceCollection {
  @doc("Services keyed by service name.")
  @visibility(Lifecycle.Read)
  services: Record<TrainingJobService>;
}

@doc("Compute placement details for a job run attempt.")
model JobRunComputeDetails {
  @doc("Virtual machine size used for this run attempt.")
  @visibility(Lifecycle.Read)
  vmSize?: string;

  @doc("Instance type used for this run attempt.")
  @visibility(Lifecycle.Read)
  instanceType?: string;

  @doc("Number of instances allocated to this run attempt.")
  @visibility(Lifecycle.Read)
  instanceCount?: int32;

  @doc("Number of GPUs allocated to this run attempt.")
  @visibility(Lifecycle.Read)
  gpuCount?: int32;

  @doc("Region where this run attempt was placed.")
  @visibility(Lifecycle.Read)
  region?: string;

  @doc("Additional backend-specific compute placement properties.")
  @visibility(Lifecycle.Read)
  properties?: Record<string>;
}

@doc("One execution run of a training job.")
model JobRun {
  @doc("The run identifier.")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("The job name this run belongs to.")
  @visibility(Lifecycle.Read)
  jobName: string;

  @doc("The run status.")
  @visibility(Lifecycle.Read)
  status?: JobRunStatus;

  @doc("Additional status reason.")
  @visibility(Lifecycle.Read)
  statusReason?: string;

  @doc("Time the run started.")
  @visibility(Lifecycle.Read)
  startTimeUtc?: utcDateTime;

  @doc("Time the run ended.")
  @visibility(Lifecycle.Read)
  endTimeUtc?: utcDateTime;

  @doc("Most recent time the run started running.")
  @visibility(Lifecycle.Read)
  lastStartTimeUtc?: utcDateTime;

  @doc("Total compute duration consumed by the run.")
  @visibility(Lifecycle.Read)
  computeDuration?: duration;

  @doc("Queueing details associated with the run.")
  @visibility(Lifecycle.Read)
  queueingInfo?: Record<unknown>;

  @doc("Compute details associated with the run.")
  @visibility(Lifecycle.Read)
  computeDetails?: JobRunComputeDetails;

  @doc("Terminal error for the run, if any.")
  @visibility(Lifecycle.Read)
  error?: JobRunError;

  @doc("Warnings emitted for the run.")
  @visibility(Lifecycle.Read)
  warnings?: JobRunWarning[];

  @doc("Whether this run is the current run for the job.")
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

@doc("Metadata for a metric emitted by a job or run.")
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
  @query
  limit?: int32;

  @doc("Continuation token returned by a previous list request.")
  @query
  @continuationToken
  skipToken?: string;
};

alias JobArtifactListQueryParameters = JobChildListQueryParameters & {
  @doc("Artifact path prefix to list.")
  @query
  pathPrefix?: string;
};

alias JobArtifactContentInfoByPrefixQueryParameters = {
  @doc("Artifact path prefix to list download information for. If omitted, download information is returned for the artifact root.")
  @query
  pathPrefix?: string;

  @doc("Continuation token returned by a previous list request.")
  @query
  @continuationToken
  skipToken?: string;
};

alias JobServicesQueryParameters = {
  @doc("Node identifier whose service endpoints should be returned. If omitted, leader-node services are returned.")
  @query
  nodeId?: int32;
};

alias JobMetricQueryParameters = {
  @doc("Start of the metric time range.")
  @query
  startTimeUtc?: utcDateTime;

  @doc("End of the metric time range.")
  @query
  endTimeUtc?: utcDateTime;

  @doc("Minimum metric step to include.")
  @query
  minStep?: int64;

  @doc("Maximum metric step to include.")
  @query
  maxStep?: int64;

  @doc("Maximum number of metric points to return.")
  @query
  limit?: int32;
};
