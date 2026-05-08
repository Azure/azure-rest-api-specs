// cSpell:ignore Chatml Grpo Kahneman Mbpp Mmlu Nemo Orpo QLoRA Rlhf Rloo SGLang Tversky VERL Vllm

import "../common/models.tsp";
import "../common/service.tsp";
import "../servicepatterns.tsp";

using TypeSpec.Http;

namespace Azure.AI.Projects;

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Use an extensible union instead of a plain string"
@doc("Distribution configuration of the job. If set, this should be one of Mpi, Tensorflow, PyTorch, Ray, or null.")
@discriminator("distribution_type")
model DistributionConfiguration {
  @doc("Specifies the type of distribution framework.")
  distribution_type: string;
}

@doc("PyTorch distribution configuration.")
model PyTorchDistribution extends DistributionConfiguration {
  @doc("Specifies the type of distribution framework.")
  distribution_type: "pytorch";

  @doc("Number of processes per node.")
  process_count_per_instance?: int32;
}

@doc("MPI distribution configuration.")
model MpiDistribution extends DistributionConfiguration {
  @doc("Specifies the type of distribution framework.")
  distribution_type: "mpi";

  @doc("Number of processes per MPI node.")
  process_count_per_node?: int32;
}

@doc("TensorFlow distribution configuration.")
model TensorFlowDistribution extends DistributionConfiguration {
  @doc("Specifies the type of distribution framework.")
  distribution_type: "tensorflow";

  @doc("Number of workers. If not specified, will default to the instance count.")
  worker_count?: int32;

  @doc("Number of parameter server tasks.")
  parameter_server_count?: int32;
}

@doc("Ray distribution configuration.")
model RayDistribution extends DistributionConfiguration {
  @doc("Specifies the type of distribution framework.")
  distribution_type: "ray";

  @doc("The port of the head Ray process.")
  port?: int32;

  @doc("The address of the Ray head node.")
  address?: string;

  @doc("Whether to start the Ray dashboard GUI.")
  include_dashboard?: boolean;

  @doc("The port to bind the dashboard server to.")
  dashboard_port?: int32;

  @doc("Additional arguments passed to ray start on the head node.")
  head_node_additional_args?: string;

  @doc("Additional arguments passed to ray start on worker nodes.")
  worker_node_additional_args?: string;

  @doc("Whether to expose the Ray Client server port through the AML proxy for remote access. When true, the Ray Client port is registered as an interactive endpoint, enabling remote ray.init() connections via the WebSocket-TCP bridge. When false or omitted, the Ray Client port is not accessible externally.")
  enable_remote_access_client_server?: boolean;

  @doc("The port for the Ray Client server. Defaults to 10001. Only relevant when enable_remote_access_client_server is true.")
  client_server_port?: int32;
}

@doc("Enum to determine the input/output data delivery mode.")
union InputOutputModes {
  string,

  @doc("Read-only mount mode.")
  read_only_mount: "read_only_mount",

  @doc("Read-write mount mode.")
  read_write_mount: "read_write_mount",

  @doc("Download mode.")
  download: "download",

  @doc("Direct mode.")
  direct: "direct",

  @doc("Upload mode.")
  upload: "upload",
}

@doc("Type of job input/output asset.")
union AssetTypes {
  string,

  @doc("URI file asset.")
  uri_file: "uri_file",

  @doc("URI folder asset.")
  uri_folder: "uri_folder",

  @doc("Safetensors model asset.")
  safetensors_model: "safetensors_model",

  @doc("Literal value (inputs only).")
  literal: "literal",
}

@doc("Job input definition.")
model Input {
  @doc("Specifies the type of job input.")
  job_input_type: AssetTypes;

  @doc("Input Asset URI. Required for uri_file, uri_folder, and safetensors_model types.")
  uri?: string;

  @doc("Input Asset Delivery Mode. Applies to uri-based inputs.")
  mode?: InputOutputModes;

  @doc("Literal value. Required for literal type.")
  value?: string;
}

@doc("Job output definition.")
model Output {
  @doc("Specifies the type of job output.")
  job_output_type: AssetTypes;

  @doc("Output Asset Delivery Mode.")
  mode?: InputOutputModes;

  @doc("Name of the output data asset to register.")
  asset_name?: string;

  @doc("Version of the output data asset to register.")
  asset_version?: string;

  @doc("Output Asset URI.")
  uri?: string;

  @doc("Base model ID. Applies to safetensors_model outputs.")
  base_model_id?: string;

  @doc("Description for the output.")
  description?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Use an extensible union instead of a plain string"
@doc("Nodes that user would like to start the service on.")
@discriminator("nodes_value_type")
model NodeCollection {
  @doc("Type of the Nodes value.")
  nodes_value_type: string;
}

@doc("All nodes means the service will be running on all of the nodes of the job.")
model AllNodes extends NodeCollection {
  @doc("Type of the Nodes value.")
  nodes_value_type: "all";
}

@doc("Job service endpoint type.")
union JobServiceType {
  string,

  @doc("Studio endpoint.")
  studio: "studio",

  @doc("Experiment tracking endpoint.")
  tracking: "tracking",
}

@doc("Job endpoint definition.")
model JobService {
  @doc("Endpoint type.")
  job_service_type?: JobServiceType;

  @doc("Port for endpoint.")
  port?: int32;

  @doc("Url for endpoint.")
  endpoint?: url;

  @doc("Additional properties to set on the endpoint.")
  properties?: Record<string>;

  @doc("Nodes that user would like to start the service on. If Nodes is not set or set to null, the service will only be started on leader node.")
  nodes?: AllNodes;

  @doc("Status of endpoint.")
  @visibility(Lifecycle.Read)
  status?: string;

  @doc("Any error in the service.")
  @visibility(Lifecycle.Read)
  error_message?: string;
}

@doc("Compute Resource configuration for the job.")
model JobResourceConfiguration {
  @doc("Optional number of instances or nodes used by the compute target.")
  instance_count?: int32;

  @doc("Optional type of VM used as supported by the compute target.")
  instance_type?: string;

  @doc("Additional properties bag.")
  properties?: Record<unknown>;

  @doc("Size of the docker container's shared memory block. This should be in the format of (number)(unit) where number as to be greater than 0 and the unit can be one of b(bytes), k(kilobytes), m(megabytes), or g(gigabytes).")
  shm_size?: string;

  @doc("Extra arguments to pass to the Docker run command. This would override any parameters that have already been set by the system, or in this section. This parameter is only supported for Azure ML compute types.")
  docker_args?: string;
}

@doc("Command Job limit class.")
model CommandJobLimits {
  @doc("JobLimit type.")
  job_limits_type: "command";

  @doc("The max run duration in ISO 8601 format, after which the job will be cancelled. Only supports duration with precision as low as Seconds.")
  @encode(DurationKnownEncoding.ISO8601)
  timeout?: duration;
}

@doc("Queue settings for the job.")
model QueueSettings {
  @doc("Controls the compute job tier.")
  job_tier?: string;
}

@doc("Training algorithm used by a declarative training job.")
union TrainingAlgorithm {
  string,

  @doc("Supervised fine tuning.")
  sft: "sft",

  @doc("Direct preference optimization.")
  dpo: "dpo",

  @doc("Kahneman-Tversky optimization.")
  kto: "kto",

  @doc("Odds ratio preference optimization.")
  orpo: "orpo",

  @doc("Contrastive preference optimization.")
  cpo: "cpo",

  @doc("Simple preference optimization.")
  simpo: "simpo",

  @doc("Group relative policy optimization.")
  grpo: "grpo",

  @doc("Proximal policy optimization.")
  ppo: "ppo",

  @doc("REINFORCE leave-one-out.")
  rloo: "rloo",

  @doc("REINFORCE++.")
  reinforce_pp: "reinforce_pp",

  @doc("Reward model training.")
  reward_model: "reward_model",
}

@doc("Training framework used to lower a declarative training job into an execution command.")
union TrainingFramework {
  string,

  @doc("TRL framework.")
  trl: "trl",

  @doc("VERL framework.")
  verl: "verl",

  @doc("OpenRLHF framework.")
  open_rlhf: "open_rlhf",

  @doc("NeMo RL framework.")
  nemo_rl: "nemo_rl",

  @doc("Slime framework.")
  slime: "slime",

  @doc("TorchForge framework.")
  torch_forge: "torch_forge",
}

@doc("Training framework supported by the interactive Ray job convenience model.")
union InteractiveRayJobFramework {
  @doc("Slime framework.")
  slime: "slime",

  @doc("VERL framework.")
  verl: "verl",
}

@doc("Chat template used to format conversational training data.")
union ChatTemplate {
  string,

  @doc("ChatML template.")
  chatml: "chatml",

  @doc("Llama 3 chat template.")
  llama_3: "llama_3",

  @doc("Zephyr chat template.")
  zephyr: "zephyr",

  @doc("Gemma chat template.")
  gemma: "gemma",

  @doc("Phi 3 chat template.")
  phi_3: "phi_3",
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

  @doc("Column containing responses for KTO or scored reward-model training.")
  response?: string;

  @doc("Column containing binary desirability labels for KTO training.")
  label?: string;

  @doc("Column containing numeric reward scores for scored reward-model training.")
  score?: string;
}

@doc("Formatting options for conversational training data.")
model TrainingDataFormatConfiguration {
  @doc("Built-in chat template to apply to the dataset.")
  chat_template?: ChatTemplate;

  @doc("Path to a custom chat template relative to the job's code directory.")
  chat_template_path?: string;
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
  data_format?: TrainingDataFormatConfiguration;
}

@doc("Reference to a Python callable relative to the job's code directory.")
model TrainingEntryPointReference {
  @doc("Path to the Python callable in module/file.py:function format.")
  entry_point: string;
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

@doc("Reward or judge signal kind.")
union TrainingRewardKind {
  string,

  @doc("Learned reward model judge.")
  `model`: "model",

  @doc("Python callable judge.")
  function: "function",

  @doc("Inline Python callable judge.")
  inline_function: "inline_function",

  @doc("Built-in reward or verifier judge.")
  builtin: "builtin",

  @doc("Foundry evaluator judge.")
  evaluator: "evaluator",

  @doc("Model deployment judge.")
  deployment: "deployment",

  @doc("Composite judge.")
  composite: "composite",
}

@doc("Reward or judge signal configuration for reinforcement or reward model training.")
@discriminator("kind")
model TrainingRewardConfiguration {
  @doc("Reward or judge signal kind.")
  kind: TrainingRewardKind;
}

@doc("Learned reward model used as a judge.")
model TrainingModelRewardConfiguration extends TrainingRewardConfiguration {
  @doc("Reward or judge signal kind, always 'model'.")
  kind: "model";

  @doc("Reward model asset reference used to compute scores.")
  `model`: string;
}

@doc("Python callable used as a judge.")
model TrainingFunctionRewardConfiguration extends TrainingRewardConfiguration {
  @doc("Reward or judge signal kind, always 'function'.")
  kind: "function";

  @doc("Python callable used to compute reward scores.")
  function: TrainingEntryPointReference;
}

@doc("Inline Python function used as a judge.")
model TrainingInlineFunctionRewardConfiguration
  extends TrainingRewardConfiguration {
  @doc("Reward or judge signal kind, always 'inline_function'.")
  kind: "inline_function";

  @doc("Inline Python function used to compute reward scores.")
  inline_function: TrainingInlineFunctionConfiguration;
}

@doc("Built-in reward or verifier type.")
union TrainingBuiltinRewardType {
  string,

  @doc("Exact string match verifier.")
  exact_match: "exact_match",

  @doc("Regular expression verifier.")
  regex: "regex",

  @doc("Math equivalence verifier.")
  math_equivalence: "math_equivalence",

  @doc("Unit test verifier for code generation tasks.")
  unit_tests: "unit_tests",
}

@doc("Built-in reward or verifier used as a judge.")
model TrainingBuiltinRewardConfiguration extends TrainingRewardConfiguration {
  @doc("Reward or judge signal kind, always 'builtin'.")
  kind: "builtin";

  @doc("Built-in reward or verifier type.")
  type: TrainingBuiltinRewardType;

  @doc("Optional verifier configuration.")
  configuration?: Record<unknown>;
}

@doc("Foundry evaluator used as a judge.")
model TrainingEvaluatorRewardConfiguration extends TrainingRewardConfiguration {
  @doc("Reward or judge signal kind, always 'evaluator'.")
  kind: "evaluator";

  @doc("Evaluator asset reference.")
  evaluator: string;

  @doc("Optional evaluator input mapping.")
  input_mapping?: Record<string>;
}

@doc("Model deployment used as an LLM judge.")
model TrainingDeploymentRewardConfiguration
  extends TrainingRewardConfiguration {
  @doc("Reward or judge signal kind, always 'deployment'.")
  kind: "deployment";

  @doc("Model deployment name or resource reference used as the judge.")
  deployment: string;

  @doc("Rubric or scoring instruction for the judge deployment.")
  rubric?: string;
}

@doc("Weighted reward signal used in a composite judge.")
model TrainingWeightedRewardConfiguration {
  @doc("Reward signal.")
  reward: TrainingRewardConfiguration;

  @doc("Weight applied to this reward signal.")
  weight?: float64 = 1.0;
}

@doc("Composite reward or judge made from multiple weighted reward signals.")
model TrainingCompositeRewardConfiguration extends TrainingRewardConfiguration {
  @doc("Reward or judge signal kind, always 'composite'.")
  kind: "composite";

  @doc("Weighted reward signals to combine.")
  rewards: TrainingWeightedRewardConfiguration[];
}

@doc("LoRA adapter configuration for parameter-efficient fine tuning.")
model TrainingLoraConfiguration {
  @doc("Low-rank dimension.")
  rank: int32;

  @doc("LoRA scaling factor.")
  alpha?: int32 = 16;

  @doc("Dropout applied to adapter inputs.")
  dropout?: float64 = 0.05;

  @doc("Linear layers that receive adapters. Use 'auto' to let the framework choose defaults.")
  target_modules?: string = "auto";

  @doc("Whether to enable QLoRA 4-bit base weight loading.")
  quantize?: boolean = false;
}

@doc("Inference engine used for rollout generation during online reinforcement learning.")
union TrainingRolloutEngine {
  string,

  @doc("vLLM inference engine.")
  vllm: "vllm",

  @doc("SGLang inference engine.")
  sglang: "sglang",

  @doc("Hugging Face generate-based inference.")
  hf: "hf",

  @doc("Megatron-Core native inference.")
  megatron_inference: "megatron_inference",
}

@doc("Rollout generation configuration for online reinforcement learning.")
model TrainingRolloutConfiguration {
  @doc("Rollout inference engine.")
  engine: TrainingRolloutEngine;

  @doc("Number of completions to generate for each prompt.")
  num_generations?: int32;

  @doc("Maximum prompt length in tokens.")
  max_prompt_length?: int32;

  @doc("Maximum completion length in tokens.")
  max_completion_length?: int32;

  @doc("Sampling temperature for rollout generation.")
  temperature?: float64;

  @doc("Nucleus sampling probability for rollout generation.")
  top_p?: float64;

  @doc("Stop sequences for rollout generation.")
  stop?: string[];

  @doc("Rollout batch size.")
  batch_size?: int32;

  @doc("Random seed for rollout generation.")
  seed?: int32;

  @doc("Tensor parallel size used by the rollout engine.")
  tensor_parallel_size?: int32 = 1;

  @doc("GPU memory utilization target for the rollout engine, between 0.0 and 1.0.")
  gpu_memory_utilization?: float64;
}

@doc("Built-in evaluation benchmark.")
union TrainingEvalBenchmark {
  string,

  @doc("Grade School Math 8K benchmark.")
  gsm8k: "gsm8k",

  @doc("Massive Multitask Language Understanding benchmark.")
  mmlu: "mmlu",

  @doc("Human-written code generation benchmark.")
  humaneval: "humaneval",

  @doc("Mostly Basic Python Programs benchmark.")
  mbpp: "mbpp",

  @doc("AI2 Reasoning Challenge benchmark.")
  arc: "arc",

  @doc("HellaSwag commonsense inference benchmark.")
  hellaswag: "hellaswag",
}

@doc("Evaluation configuration for a declarative training job.")
model TrainingEvalConfiguration {
  @doc("Named built-in benchmark. Mutually exclusive with dataset.")
  benchmark?: TrainingEvalBenchmark;

  @doc("Custom evaluation dataset asset reference. Mutually exclusive with benchmark.")
  dataset?: string;

  @doc("Evaluation frequency in training steps. Omit for end-of-training only.")
  every_n_steps?: int32;
}

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Use an extensible union for forward-compatible training algorithms."
@doc("Declarative training recipe. When specified, command must be omitted and environment_image_reference is optional.")
@discriminator("algorithm")
model TrainingConfiguration {
  @doc("Training algorithm.")
  algorithm: TrainingAlgorithm;

  @doc("Training framework implementation. If omitted, the service selects a compatible framework for the algorithm and records the resolved framework on the job.")
  framework?: TrainingFramework;

  @doc("Training framework resolved by the service.")
  @visibility(Lifecycle.Read)
  resolved_framework?: TrainingFramework;

  @doc("Version of the resolved training framework used by the service.")
  @visibility(Lifecycle.Read)
  framework_version?: string;

  @doc("Base model asset reference.")
  `model`: string;

  @doc("Training and optional evaluation datasets.")
  dataset: TrainingDatasetConfiguration;

  @doc("Algorithm-specific hyperparameters. Strongly typed SDK helpers may project common hyperparameters into richer language-specific types.")
  hyperparameters?: Record<unknown>;
}

@doc("Supervised fine-tuning recipe.")
model SftTrainingConfiguration extends TrainingConfiguration {
  @doc("Training algorithm, always 'sft'.")
  algorithm: "sft";

  @doc("LoRA adapter configuration.")
  lora?: TrainingLoraConfiguration;

  @doc("Evaluation configuration.")
  eval?: TrainingEvalConfiguration;
}

@doc("Direct preference optimization training recipe.")
model DpoTrainingConfiguration extends TrainingConfiguration {
  @doc("Training algorithm, always 'dpo'.")
  algorithm: "dpo";

  @doc("LoRA adapter configuration.")
  lora?: TrainingLoraConfiguration;

  @doc("Evaluation configuration.")
  eval?: TrainingEvalConfiguration;
}

@doc("Kahneman-Tversky optimization training recipe.")
model KtoTrainingConfiguration extends TrainingConfiguration {
  @doc("Training algorithm, always 'kto'.")
  algorithm: "kto";

  @doc("LoRA adapter configuration.")
  lora?: TrainingLoraConfiguration;

  @doc("Evaluation configuration.")
  eval?: TrainingEvalConfiguration;
}

@doc("Odds ratio preference optimization training recipe.")
model OrpoTrainingConfiguration extends TrainingConfiguration {
  @doc("Training algorithm, always 'orpo'.")
  algorithm: "orpo";

  @doc("LoRA adapter configuration.")
  lora?: TrainingLoraConfiguration;

  @doc("Evaluation configuration.")
  eval?: TrainingEvalConfiguration;
}

@doc("Contrastive preference optimization training recipe.")
model CpoTrainingConfiguration extends TrainingConfiguration {
  @doc("Training algorithm, always 'cpo'.")
  algorithm: "cpo";

  @doc("LoRA adapter configuration.")
  lora?: TrainingLoraConfiguration;

  @doc("Evaluation configuration.")
  eval?: TrainingEvalConfiguration;
}

@doc("Simple preference optimization training recipe.")
model SimPoTrainingConfiguration extends TrainingConfiguration {
  @doc("Training algorithm, always 'simpo'.")
  algorithm: "simpo";

  @doc("LoRA adapter configuration.")
  lora?: TrainingLoraConfiguration;

  @doc("Evaluation configuration.")
  eval?: TrainingEvalConfiguration;
}

@doc("Group relative policy optimization training recipe.")
model GrpoTrainingConfiguration extends TrainingConfiguration {
  @doc("Training algorithm, always 'grpo'.")
  algorithm: "grpo";

  @doc("Reward signal configuration.")
  reward: TrainingRewardConfiguration;

  @doc("LoRA adapter configuration.")
  lora?: TrainingLoraConfiguration;

  @doc("Rollout generation configuration.")
  rollout?: TrainingRolloutConfiguration;

  @doc("Evaluation configuration.")
  eval?: TrainingEvalConfiguration;
}

@doc("Proximal policy optimization training recipe.")
model PpoTrainingConfiguration extends TrainingConfiguration {
  @doc("Training algorithm, always 'ppo'.")
  algorithm: "ppo";

  @doc("Reward signal configuration.")
  reward: TrainingRewardConfiguration;

  @doc("LoRA adapter configuration.")
  lora?: TrainingLoraConfiguration;

  @doc("Rollout generation configuration.")
  rollout?: TrainingRolloutConfiguration;

  @doc("Evaluation configuration.")
  eval?: TrainingEvalConfiguration;
}

@doc("REINFORCE leave-one-out training recipe.")
model RlooTrainingConfiguration extends TrainingConfiguration {
  @doc("Training algorithm, always 'rloo'.")
  algorithm: "rloo";

  @doc("Reward signal configuration.")
  reward: TrainingRewardConfiguration;

  @doc("LoRA adapter configuration.")
  lora?: TrainingLoraConfiguration;

  @doc("Rollout generation configuration.")
  rollout?: TrainingRolloutConfiguration;

  @doc("Evaluation configuration.")
  eval?: TrainingEvalConfiguration;
}

@doc("REINFORCE++ training recipe.")
model ReinforcePpTrainingConfiguration extends TrainingConfiguration {
  @doc("Training algorithm, always 'reinforce_pp'.")
  algorithm: "reinforce_pp";

  @doc("Reward signal configuration.")
  reward: TrainingRewardConfiguration;

  @doc("LoRA adapter configuration.")
  lora?: TrainingLoraConfiguration;

  @doc("Rollout generation configuration.")
  rollout?: TrainingRolloutConfiguration;

  @doc("Evaluation configuration.")
  eval?: TrainingEvalConfiguration;
}

@doc("Reward model training recipe.")
model RewardModelTrainingConfiguration extends TrainingConfiguration {
  @doc("Training algorithm, always 'reward_model'.")
  algorithm: "reward_model";

  @doc("LoRA adapter configuration.")
  lora?: TrainingLoraConfiguration;

  @doc("Evaluation configuration.")
  eval?: TrainingEvalConfiguration;
}

@doc("Declarative training recipe for an interactive Ray job. The framework is limited to Slime and VERL.")
model InteractiveRayJobTrainingConfiguration {
  @doc("Training algorithm.")
  algorithm: TrainingAlgorithm;

  @doc("Training framework implementation for the interactive Ray job.")
  framework: InteractiveRayJobFramework;

  @doc("Base model asset reference.")
  `model`: string;

  @doc("Training and optional evaluation datasets.")
  dataset: TrainingDatasetConfiguration;

  @doc("Algorithm-specific hyperparameters.")
  hyperparameters?: Record<unknown>;

  @doc("Reward or judge signal configuration for reinforcement or reward model training.")
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
  created_by?: string;

  @doc("The type of identity that created the resource.")
  @visibility(Lifecycle.Read)
  created_by_type?: string;

  @doc("The timestamp of resource creation (UTC).")
  @visibility(Lifecycle.Read)
  created_at?: FoundryTimestamp;

  @doc("The identity that last modified the resource.")
  @visibility(Lifecycle.Read)
  last_modified_by?: string;

  @doc("The type of identity that last modified the resource.")
  @visibility(Lifecycle.Read)
  last_modified_by_type?: string;

  @doc("The timestamp of resource last modification (UTC).")
  @visibility(Lifecycle.Read)
  last_modified_at?: FoundryTimestamp;
}

@doc("Type of a job.")
union JobType {
  string,

  @doc("Command job.")
  command: "command",
}

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Use an extensible union instead of a plain string"
@doc("Base properties of a Job.")
@discriminator("job_type")
model JobProperties {
  @doc("Job type.")
  job_type: string;
}

@doc("Properties of a Command Job.")
model CommandJob extends JobProperties {
  @doc("Job type.")
  job_type: "command";

  @doc("The command to execute on startup of the job. Required when training is not specified, and must be omitted when training is specified.")
  command?: string;

  @doc("ACR path or Azure ML environment reference. Required when training is not specified.")
  environment_image_reference?: string;

  @doc("Declarative training recipe. When specified, the service compiles the recipe into the command and environment used for execution.")
  training?: TrainingConfiguration;

  @doc("Display name of job.")
  display_name?: string;

  @doc("The asset description text.")
  description?: string;

  @doc("Tag dictionary. Tags can be added, removed, and updated.")
  tags?: Record<string>;

  @doc("The asset property dictionary.")
  properties?: Record<string>;

  @doc("Code asset reference.")
  code_id?: string;

  @doc("Compute resource ID.")
  compute_id: string;

  @doc("Mapping of input data bindings used in the job.")
  inputs?: Record<Input>;

  @doc("Mapping of output data bindings used in the job.")
  outputs?: Record<Output>;

  @doc("Environment variables included in the job.")
  environment_variables?: Record<string>;

  @doc("Compute Resource configuration for the job.")
  resources?: JobResourceConfiguration;

  @doc("Number of GPUs requested by the training job.")
  gpu_count?: int32;

  @doc("Distribution configuration of the job. If set, this should be one of Mpi, Tensorflow, PyTorch, or null.")
  distribution?: DistributionConfiguration;

  @doc("Command Job limit.")
  limits?: CommandJobLimits;

  @doc("Queue settings for the job.")
  queue_settings?: QueueSettings;

  @doc("user-assigned managed identity")
  user_assigned_identity_id?: string;

  @doc("Status of the job.")
  @visibility(Lifecycle.Read)
  status?: string;
}

@doc("Properties of an interactive Ray training job. This is an SDK convenience shape for creating a command job with Ray distribution.")
model InteractiveRayJobProperties {
  @doc("Job type, always 'command'.")
  job_type: "command";

  @doc("The command to execute on startup of the interactive Ray job. Required when training is not specified, and must be omitted when training is specified.")
  command?: string;

  @doc("ACR path or Azure ML environment reference. Required when training is not specified.")
  environment_image_reference?: string;

  @doc("Declarative training recipe for Slime or VERL running on Ray.")
  training?: InteractiveRayJobTrainingConfiguration;

  @doc("Display name of job.")
  display_name?: string;

  @doc("The asset description text.")
  description?: string;

  @doc("Tag dictionary. Tags can be added, removed, and updated.")
  tags?: Record<string>;

  @doc("The asset property dictionary.")
  properties?: Record<string>;

  @doc("Code asset reference.")
  code_id?: string;

  @doc("Compute resource ID.")
  compute_id: string;

  @doc("Mapping of input data bindings used in the job.")
  inputs?: Record<Input>;

  @doc("Mapping of output data bindings used in the job.")
  outputs?: Record<Output>;

  @doc("Environment variables included in the job.")
  environment_variables?: Record<string>;

  @doc("Compute Resource configuration for the job.")
  resources?: JobResourceConfiguration;

  @doc("Number of GPUs requested by the training job.")
  gpu_count?: int32;

  @doc("Ray distribution configuration for the interactive job.")
  distribution: RayDistribution;

  @doc("Command Job limit.")
  limits?: CommandJobLimits;

  @doc("Queue settings for the job.")
  queue_settings?: QueueSettings;

  @doc("User-assigned managed identity.")
  user_assigned_identity_id?: string;
}

@doc("Training job resource.")
@Rest.resource("training_jobs")
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

  ...CommandJob;

  @doc("The latest execution attempt for the job. This field is omitted unless requested with include=latest_attempt. The same attempt resource is available from /training_jobs/{job_name}/attempts/latest.")
  @visibility(Lifecycle.Read)
  latest_attempt?: JobAttempt;

  @doc("Metadata pertaining to creation and last modification of the resource.")
  @visibility(Lifecycle.Read)
  system_data?: SystemData;
}

@doc("Request body for creating a training job.")
model JobCreate {
  @doc("The name of the training job. This is case-sensitive.")
  name: string;

  ...CommandJob;
}

@doc("Request body for creating an interactive Ray training job. This SDK convenience model uses the same /training_jobs create operation as other command jobs.")
model InteractiveRayJob {
  @doc("The name of the interactive Ray job. This is case-sensitive.")
  name: string;

  ...InteractiveRayJobProperties;
}

@doc("Response returned when a job delete operation is accepted asynchronously.")
model JobDeleteAcceptedResponse {
  @statusCode statusCode: 202;

  @doc("URL to poll for the final result of the delete operation.")
  @header("Location")
  location: string;

  @doc("URL to poll for the status of the delete operation.")
  @header("Operation-Location")
  operation_location?: string;

  @doc("Suggested delay in seconds before polling.")
  @header("Retry-After")
  retry_after?: int32;
}

@doc("Response returned when a job cancel operation is accepted asynchronously.")
model JobCancelAcceptedResponse {
  @statusCode statusCode: 202;

  @doc("URL to poll for the final result of the cancel operation.")
  @header("Location")
  location: string;

  @doc("URL to poll for the status of the cancel operation.")
  @header("Operation-Location")
  operation_location?: string;

  @doc("Suggested delay in seconds before polling.")
  @header("Retry-After")
  retry_after?: int32;
}

@doc("Status of an asynchronous training job operation.")
union JobOperationStatus {
  string,

  @doc("Operation is being processed.")
  in_progress: "in_progress",

  @doc("Operation is deleting resources.")
  deleting: "deleting",

  @doc("Operation completed successfully.")
  succeeded: "succeeded",

  @doc("Operation failed.")
  failed: "failed",

  @doc("Operation was canceled.")
  canceled: "canceled",
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
  started_at?: FoundryTimestamp;

  @doc("Operation end time.")
  @visibility(Lifecycle.Read)
  ended_at?: FoundryTimestamp;

  @doc("Operation completion percentage from 0 to 100.")
  @visibility(Lifecycle.Read)
  percent_complete?: float64;

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
  operation_location?: string;
}

@doc("Specifies which jobs to include in a list result based on their lifecycle state.")
union ListViewType {
  string,

  @doc("Show only active (non-archived) jobs.")
  active_only: "active_only",

  @doc("Show only archived jobs.")
  archived_only: "archived_only",

  @doc("Show all jobs regardless of archived state.")
  all: "all",
}

@doc("Status of a job execution attempt.")
union JobAttemptStatus {
  string,

  @doc("The attempt is queued.")
  queued: "queued",

  @doc("The attempt is running.")
  running: "running",

  @doc("The attempt completed successfully.")
  completed: "completed",

  @doc("The attempt failed.")
  failed: "failed",

  @doc("The attempt was canceled.")
  canceled: "canceled",
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

@doc("Service endpoint details for a training job.")
model TrainingJobService {
  @doc("Service type.")
  @visibility(Lifecycle.Read)
  type?: JobServiceType;

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
  endpoint?: url;

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

@doc("The response data for a requested list of training job items.")
model TrainingJobPagedResult<T> {
  ...AgentsPagedResult<T>;

  @doc("Opaque cursor to pass as the next request's after value when has_more is true.")
  @visibility(Lifecycle.Read)
  next_after?: string;
}

@doc("Compute placement details for a job attempt.")
model JobAttemptComputeDetails {
  @doc("Virtual machine size used for this attempt.")
  @visibility(Lifecycle.Read)
  vm_size?: string;

  @doc("Instance type used for this attempt.")
  @visibility(Lifecycle.Read)
  instance_type?: string;

  @doc("Number of instances allocated to this attempt.")
  @visibility(Lifecycle.Read)
  instance_count?: int32;

  @doc("Number of GPUs allocated to this attempt.")
  @visibility(Lifecycle.Read)
  gpu_count?: int32;

  @doc("Region where this attempt was placed.")
  @visibility(Lifecycle.Read)
  region?: string;

  @doc("Additional backend-specific compute placement properties.")
  @visibility(Lifecycle.Read)
  properties?: Record<string>;
}

@doc("One execution attempt of a training job.")
model JobAttempt {
  @doc("The attempt identifier.")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("The RunHistory run identifier backing this attempt.")
  @visibility(Lifecycle.Read)
  run_id?: string;

  @doc("The job name this attempt belongs to.")
  @visibility(Lifecycle.Read)
  job_name: string;

  @doc("The data container identifier backing this attempt's artifacts and metrics.")
  @visibility(Lifecycle.Read)
  data_container_id?: string;

  @doc("Backend attempt sequence number.")
  @visibility(Lifecycle.Read)
  sequence_number?: int64;

  @doc("The attempt status.")
  @visibility(Lifecycle.Read)
  status?: JobAttemptStatus;

  @doc("Additional status reason.")
  @visibility(Lifecycle.Read)
  status_reason?: string;

  @doc("Time the attempt started.")
  @visibility(Lifecycle.Read)
  started_at?: FoundryTimestamp;

  @doc("Time the attempt ended.")
  @visibility(Lifecycle.Read)
  ended_at?: FoundryTimestamp;

  @doc("Most recent time the attempt started running.")
  @visibility(Lifecycle.Read)
  last_started_at?: FoundryTimestamp;

  @doc("Total compute duration consumed by the attempt.")
  @visibility(Lifecycle.Read)
  @encode(DurationKnownEncoding.ISO8601)
  compute_duration?: duration;

  @doc("Current active compute duration for a running attempt.")
  @visibility(Lifecycle.Read)
  @encode(DurationKnownEncoding.ISO8601)
  current_compute_time?: duration;

  @doc("Queueing details associated with the attempt.")
  @visibility(Lifecycle.Read)
  queueing_info?: Record<unknown>;

  @doc("Compute details associated with the attempt.")
  @visibility(Lifecycle.Read)
  compute_details?: JobAttemptComputeDetails;

  @doc("Terminal error for the attempt, if any.")
  @visibility(Lifecycle.Read)
  error?: JobAttemptError;

  @doc("Warnings emitted for the attempt.")
  @visibility(Lifecycle.Read)
  warnings?: JobAttemptWarning[];

  @doc("Whether this attempt is the current attempt for the job.")
  @visibility(Lifecycle.Read)
  is_latest?: boolean;
}

@doc("Type of a job artifact.")
union JobArtifactType {
  string,

  @doc("A file artifact.")
  file: "file",

  @doc("A directory artifact.")
  directory: "directory",
}

@doc("Storage path details for an artifact.")
model JobArtifactDataPath {
  @doc("Datastore containing the artifact content.")
  @visibility(Lifecycle.Read)
  datastore_name?: string;

  @doc("Path relative to the datastore root.")
  @visibility(Lifecycle.Read)
  relative_path?: string;

  @doc("SQL path information, when the artifact is backed by SQL storage.")
  @visibility(Lifecycle.Read)
  sql_data_path?: Record<unknown>;
}

@doc("Metadata for an artifact produced by or attached to a job.")
model JobArtifact {
  @doc("Backend artifact identifier.")
  @visibility(Lifecycle.Read)
  artifact_id?: string;

  @doc("Artifact origin.")
  @visibility(Lifecycle.Read)
  origin?: string;

  @doc("Artifact container name.")
  @visibility(Lifecycle.Read)
  container?: string;

  @doc("Artifact path relative to the job artifact root.")
  @visibility(Lifecycle.Read)
  path: string;

  @doc("Artifact entity tag.")
  @visibility(Lifecycle.Read)
  etag?: string;

  @doc("Artifact type.")
  @visibility(Lifecycle.Read)
  type: JobArtifactType;

  @doc("Artifact size in bytes.")
  @visibility(Lifecycle.Read)
  size?: int64;

  @doc("Time the artifact was created.")
  @visibility(Lifecycle.Read)
  created_at?: FoundryTimestamp;

  @doc("Time the artifact was last updated.")
  @visibility(Lifecycle.Read)
  updated_at?: FoundryTimestamp;

  @doc("Storage path details for the artifact.")
  @visibility(Lifecycle.Read)
  data_path?: JobArtifactDataPath;

  @doc("Artifact tags.")
  @visibility(Lifecycle.Read)
  tags?: Record<string>;
}

@doc("Content access information for a job artifact.")
model JobArtifactContentInfo {
  @doc("Artifact origin.")
  @visibility(Lifecycle.Read)
  origin?: string;

  @doc("Artifact container name.")
  @visibility(Lifecycle.Read)
  container?: string;

  @doc("Artifact path relative to the job artifact root.")
  @visibility(Lifecycle.Read)
  path: string;

  @doc("Download URI for the artifact content.")
  @visibility(Lifecycle.Read)
  content_uri: url;

  @doc("MIME type of the content.")
  @visibility(Lifecycle.Read)
  content_type?: string;

  @doc("Content length in bytes, when known.")
  @visibility(Lifecycle.Read)
  content_length?: int64;

  @doc("Time the content URI expires.")
  @visibility(Lifecycle.Read)
  expires_at?: FoundryTimestamp;

  @doc("Artifact tags.")
  @visibility(Lifecycle.Read)
  tags?: Record<string>;
}

@doc("The kind of metric emitted by a job.")
union JobMetricType {
  string,

  @doc("Scalar metric values.")
  `scalar`: "scalar",

  @doc("Table metric values.")
  table: "table",

  @doc("Image metric values.")
  image: "image",
}

@doc("One property in a metric schema.")
model JobMetricSchemaProperty {
  @doc("Metric schema property identifier.")
  @visibility(Lifecycle.Read)
  property_id?: string;

  @doc("Metric schema property name.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("Metric schema property type.")
  @visibility(Lifecycle.Read)
  type?: string;
}

@doc("Full metric schema metadata.")
model JobMetricSchema {
  @doc("Number of properties in the schema.")
  @visibility(Lifecycle.Read)
  num_properties?: int32;

  @doc("Metric schema properties.")
  @visibility(Lifecycle.Read)
  properties?: JobMetricSchemaProperty[];
}

@doc("Metadata for a metric emitted by a job or run.")
model JobMetric {
  @doc("Metric name.")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("Run identifier that emitted the metric.")
  @visibility(Lifecycle.Read)
  run_id?: string;

  @doc("Data container identifier that stores the metric.")
  @visibility(Lifecycle.Read)
  data_container_id?: string;

  @doc("Metric type.")
  @visibility(Lifecycle.Read)
  metric_type?: JobMetricType;

  @doc("Metric description.")
  @visibility(Lifecycle.Read)
  description?: string;

  @doc("Metric label.")
  @visibility(Lifecycle.Read)
  label?: string;

  @doc("Number of metric cells.")
  @visibility(Lifecycle.Read)
  num_cells?: int32;

  @doc("Metric data location.")
  @visibility(Lifecycle.Read)
  data_location?: string;

  @doc("Column metadata for structured metric values.")
  @visibility(Lifecycle.Read)
  columns?: Record<string>;

  @doc("Full metric schema metadata.")
  @visibility(Lifecycle.Read)
  schema?: JobMetricSchema;
}

@doc("A metric data point.")
model JobMetricPoint {
  @doc("Metric identifier.")
  @visibility(Lifecycle.Read)
  metric_id?: string;

  @doc("Metric name.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("Run identifier that emitted the metric.")
  @visibility(Lifecycle.Read)
  run_id?: string;

  @doc("Data container identifier that stores the metric.")
  @visibility(Lifecycle.Read)
  data_container_id?: string;

  @doc("Metric type.")
  @visibility(Lifecycle.Read)
  metric_type?: JobMetricType;

  @doc("Metric description.")
  @visibility(Lifecycle.Read)
  description?: string;

  @doc("Metric label.")
  @visibility(Lifecycle.Read)
  label?: string;

  @doc("Number of metric cells.")
  @visibility(Lifecycle.Read)
  num_cells?: int32;

  @doc("Metric data location.")
  @visibility(Lifecycle.Read)
  data_location?: string;

  @doc("Full metric schema metadata.")
  @visibility(Lifecycle.Read)
  schema?: JobMetricSchema;

  @doc("Metric step.")
  @visibility(Lifecycle.Read)
  step?: int64;

  @doc("Time the metric point was created.")
  @visibility(Lifecycle.Read)
  created_at?: FoundryTimestamp;

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
  started_at?: FoundryTimestamp;

  @doc("Aggregate window end.")
  @visibility(Lifecycle.Read)
  ended_at?: FoundryTimestamp;

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
  asset_name?: string;

  @doc("Registered asset version, if the output produced an asset.")
  @visibility(Lifecycle.Read)
  asset_version?: string;

  @doc("Base model ID for model outputs.")
  @visibility(Lifecycle.Read)
  base_model_id?: string;

  @doc("Output description.")
  @visibility(Lifecycle.Read)
  description?: string;
}

alias JobForwardPageQueryParameters = {
  ...PageLimitQueryParameter;
  ...PageAfterQueryParameter;
};

alias JobOrderedPageQueryParameters = JobForwardPageQueryParameters & {
  ...PageOrderQueryParameter;
};

alias JobContinuationListQueryParameters = {
  ...PageAfterQueryParameter;
};

alias JobPagedListQueryParameters = JobForwardPageQueryParameters;

alias JobArtifactListQueryParameters = JobPagedListQueryParameters & {
  @doc("Artifact path prefix to list.")
  @query
  path_prefix?: string;
};

alias JobMetricListQueryParameters = JobPagedListQueryParameters;

alias JobArtifactContentInfoByPrefixQueryParameters = {
  @doc("Artifact path prefix to list download information for. If omitted, download information is returned for the artifact root.")
  @query
  path_prefix?: string;

  ...PageAfterQueryParameter;
};

alias JobServicesQueryParameters = {
  @doc("Node identifier whose service endpoints should be returned. If omitted, leader-node services are returned.")
  @query
  node_id?: int32;
};

alias JobMetricQueryParameters = {
  @doc("Start of the metric time range.")
  @query
  started_at?: FoundryTimestamp;

  @doc("End of the metric time range.")
  @query
  ended_at?: FoundryTimestamp;

  @doc("Minimum metric step to include.")
  @query
  min_step?: int64;

  @doc("Maximum metric step to include.")
  @query
  max_step?: int64;

  @doc("Maximum number of metric points to return.")
  @query
  limit?: int32;
};
