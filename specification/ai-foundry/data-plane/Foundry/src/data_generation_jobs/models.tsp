import "../common/models.tsp";
import "../common/servicepatterns.tsp";

using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

const DataGenerationJobsRequiredPreviews = #{
  conditional_previews: #[
    FoundryFeaturesOptInKeys.data_generation_jobs_v1_preview
  ],
};

@doc("The supported data generation job types.")
union DataGenerationJobType {
  string,

  @doc("Simple question and answers between user and agent.")
  simple_qna: "simple_qna",

  @doc("Samples from captured turns in agent traces.")
  traces: "traces",

  @doc("Reconstruction of existing traced conversations for evaluation. This is a preview feature, not synthetic conversation simulation.")
  conversations: "conversations",

  @doc("Tool calling conversation between user and agent.")
  tool_use: "tool_use",

  @doc("Simulation seed for evaluation scenarios.")
  simulation_seed: "simulation_seed",
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("LLM model options for data generation jobs.")
model DataGenerationModelOptions {
  @doc("Base model name used to generate data. For conversation jobs, a nonempty value is required when `generate_test_case_description` or `generate_test_case_rubric` is true. Model options must be omitted for conversation reconstruction when neither description nor rubric generation is enabled.")
  `model`: string;
}

@doc("Caller-supplied inputs for a data generation job.")
@discriminator("scenario")
model DataGenerationJobInputs {
  @doc("The display name of the data generation job.")
  name: string;

  @doc("The sources used for the data generation job.")
  sources: DataGenerationJobSource[];

  @doc("The generation configuration for the data generation job.")
  generation_configuration: DataGenerationJobConfiguration;

  @doc("The scenario of the data generation job. Either for fine-tuning or evaluation.")
  scenario: DataGenerationJobScenario;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("Caller-supplied inputs for an evaluation data generation job.")
model EvaluationDataGenerationJobInputs extends DataGenerationJobInputs {
  @doc("The scenario of the data generation job, which is Evaluation for this model.")
  scenario: DataGenerationJobScenario.evaluation;

  @doc("Optional dataset output configuration for the generated evaluation data.")
  output_configuration?: EvaluationDataGenerationJobOutputConfiguration;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("Caller-supplied inputs for a supervised fine-tuning data generation job. This is a preview feature.")
@extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
model SupervisedFineTuningDataGenerationJobInputs
  extends DataGenerationJobInputs {
  @doc("The scenario of the data generation job, which is Supervised Fine-tuning preview for this model.")
  scenario: DataGenerationJobScenario.supervised_finetuning_preview;

  @doc("Optional file output configuration for the generated supervised fine-tuning data.")
  output_configuration?: SupervisedFineTuningDataGenerationJobOutputConfiguration;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("Caller-supplied inputs for a reinforcement fine-tuning data generation job. This is a preview feature.")
@extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
model ReinforcementFineTuningDataGenerationJobInputs
  extends DataGenerationJobInputs {
  @doc("The scenario of the data generation job, which is Reinforcement Fine-tuning preview for this model.")
  scenario: DataGenerationJobScenario.reinforcement_finetuning_preview;

  @doc("Optional file output configuration for the generated reinforcement fine-tuning data.")
  output_configuration?: ReinforcementFineTuningDataGenerationJobOutputConfiguration;
}

@doc("Dataset output configuration for an evaluation data generation job.")
model EvaluationDataGenerationJobOutputConfiguration {
  @doc("Dataset name to assign to the output.")
  name?: string;

  @doc("Description to assign to the output dataset.")
  description?: string;

  @doc("Tags to assign to the output dataset.")
  tags?: Record<string>;

  @doc("Controls how dataset outputs are written. If omitted, defaults to `overwrite` and creates the next dataset version using only newly generated rows. `merge` combines newly generated rows with the latest existing dataset version and de-duplicates trace rows. For conversation jobs, a newly generated conversation snapshot replaces the existing snapshot of the same conversation, preserving any additional captured turns. Existing conversations without a newly generated replacement remain unchanged. Merging replaces whole conversation snapshots rather than unioning individual turns.")
  write_mode?: DataGenerationJobOutputWriteMode = DataGenerationJobOutputWriteMode.overwrite;
}

@doc("File output configuration for a supervised fine-tuning data generation job. This is a preview feature.")
@extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
model SupervisedFineTuningDataGenerationJobOutputConfiguration {
  @doc("Filename to assign to the generated fine-tuning file.")
  name: string;

  @doc("Controls how file outputs are written. If omitted, defaults to `overwrite` and writes only the newly generated fine-tuning file content.")
  write_mode?: DataGenerationJobOutputWriteMode = DataGenerationJobOutputWriteMode.overwrite;

  @doc("File ID to merge into when `write_mode` is `merge`.")
  merge_file_id?: string;
}

@doc("File output configuration for a reinforcement fine-tuning data generation job. This is a preview feature.")
@extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
model ReinforcementFineTuningDataGenerationJobOutputConfiguration {
  @doc("Filename to assign to the generated fine-tuning file.")
  name: string;

  @doc("Controls how file outputs are written. If omitted, defaults to `overwrite` and writes only the newly generated fine-tuning file content.")
  write_mode?: DataGenerationJobOutputWriteMode = DataGenerationJobOutputWriteMode.overwrite;

  @doc("File ID to merge into when `write_mode` is `merge`.")
  merge_file_id?: string;
}

@doc("The supported write modes for data generation job outputs.")
union DataGenerationJobOutputWriteMode {
  string,

  @doc("Default behavior. Write newly generated output without merging it with an existing output. For dataset outputs, creates the next dataset version using only newly generated rows.")
  overwrite: "overwrite",

  @doc("Merge newly generated output into an existing output. For trace data generation jobs that output evaluation datasets, creates the next dataset version by merging newly generated rows with the latest existing dataset version and de-duping trace rows. For conversation jobs, a newly generated conversation snapshot replaces the existing snapshot of the same conversation, preserving any additional captured turns. Existing conversations without a newly generated replacement remain unchanged. Merging replaces whole conversation snapshots rather than unioning individual turns. For fine-tuning file outputs, merges into the file identified by `merge_file_id`.")
  merge: "merge",
}

@doc("Result produced by a successful data generation job.")
model DataGenerationJobResult {
  @doc("The final job outputs: Azure OpenAI files for fine-tuning, or datasets for evaluation.")
  outputs?: DataGenerationJobOutput[];

  @doc("The number of samples actually generated.")
  generated_samples: int32;

  @doc("The token usage information for the data generation job.")
  token_usage?: DataGenerationTokenUsage;

  @doc("Nonfatal warnings associated with otherwise usable output. `TestCaseDescriptionGenerationIncomplete` indicates that conversation rows were produced but one or more optional descriptions failed. Warning messages do not expose raw provider or model error bodies.")
  warnings?: DataGenerationWarning[];
}

@doc("A nonfatal warning associated with data generation output.")
model DataGenerationWarning {
  @doc("The warning code.")
  code?: string;

  @doc("A safe, human-readable warning message that does not include raw provider or model error bodies.")
  message: string;
}

@doc("Data Generation Job resource.")
@discriminator("scenario")
model DataGenerationJob is JobLike<DataGenerationJobResult, never> {
  @doc("The display name of the data generation job.")
  name: string;

  @doc("The sources used for the data generation job.")
  sources: DataGenerationJobSource[];

  @doc("The effective generation configuration for the data generation job.")
  generation_configuration: DataGenerationJobConfiguration;

  @doc("The scenario of the data generation job. Either for fine-tuning or evaluation.")
  scenario: DataGenerationJobScenario;

  @doc("The timestamp when the job was created, represented in Unix time (seconds since January 1, 1970).")
  @visibility(Lifecycle.Read)
  created_at: FoundryTimestamp;

  @doc("The timestamp when the job was finished, represented in Unix time (seconds since January 1, 1970).")
  @visibility(Lifecycle.Read)
  finished_at?: FoundryTimestamp;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("Evaluation data generation job resource.")
model EvaluationDataGenerationJob extends DataGenerationJob {
  @doc("The scenario of the data generation job, which is Evaluation for this model.")
  scenario: DataGenerationJobScenario.evaluation;

  @doc("Optional dataset output configuration for the generated evaluation data.")
  output_configuration?: EvaluationDataGenerationJobOutputConfiguration;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("Supervised fine-tuning data generation job resource. This is a preview feature.")
@extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
model SupervisedFineTuningDataGenerationJob extends DataGenerationJob {
  @doc("The scenario of the data generation job, which is Supervised Fine-tuning preview for this model.")
  scenario: DataGenerationJobScenario.supervised_finetuning_preview;

  @doc("Optional file output configuration for the generated supervised fine-tuning data.")
  output_configuration?: SupervisedFineTuningDataGenerationJobOutputConfiguration;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("Reinforcement fine-tuning data generation job resource. This is a preview feature.")
@extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
model ReinforcementFineTuningDataGenerationJob extends DataGenerationJob {
  @doc("The scenario of the data generation job, which is Reinforcement Fine-tuning preview for this model.")
  scenario: DataGenerationJobScenario.reinforcement_finetuning_preview;

  @doc("Optional file output configuration for the generated reinforcement fine-tuning data.")
  output_configuration?: ReinforcementFineTuningDataGenerationJobOutputConfiguration;
}

@doc("Output information for a data generation job.")
@discriminator("type")
model DataGenerationJobOutput {
  @doc("The type of the output.")
  type: DataGenerationJobOutputType;
}

@doc("Azure OpenAI file output for a data generation job. This is a preview feature.")
@extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
model FileDataGenerationJobOutput extends DataGenerationJobOutput {
  @doc("Azure OpenAI file output.")
  type: DataGenerationJobOutputType.file;

  @doc("The id of the output Azure OpenAI file.")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("The filename of the output Azure OpenAI file.")
  @visibility(Lifecycle.Read)
  filename: string;
}

@doc("Dataset output for a data generation job.")
model DatasetDataGenerationJobOutput extends DataGenerationJobOutput {
  @doc("Dataset output.")
  type: DataGenerationJobOutputType.dataset;

  @doc("The id of the output dataset created.")
  @visibility(Lifecycle.Read)
  id?: string;

  @doc("The name of the output dataset.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("The version of the output dataset.")
  @visibility(Lifecycle.Read)
  version?: string;

  @doc("Description of the output dataset.")
  @visibility(Lifecycle.Read)
  description?: string;

  @doc("Tag dictionary of the output dataset.")
  @visibility(Lifecycle.Read)
  tags?: Record<string>;
}

@doc("The supported output file types for a data generation job.")
union DataGenerationJobOutputType {
  string,

  @doc("The generated data is an Azure OpenAI File.")
  file: "file",

  @doc("The generated data is a Dataset.")
  dataset: "dataset",
}

@doc("Token usage information for a data generation job.")
model DataGenerationTokenUsage {
  @doc("The number of prompt tokens used.")
  @visibility(Lifecycle.Read)
  prompt_tokens: int64;

  @doc("The number of completion tokens generated.")
  @visibility(Lifecycle.Read)
  completion_tokens: int64;

  @doc("Total number of tokens used.")
  @visibility(Lifecycle.Read)
  total_tokens: int64;
}

@doc("The supported scenarios for a data generation job.")
union DataGenerationJobScenario {
  string,

  @doc("Supervised Fine-tuning preview scenario.")
  supervised_finetuning_preview: "supervised_finetuning_preview",

  @doc("Reinforcement Fine-tuning preview scenario.")
  reinforcement_finetuning_preview: "reinforcement_finetuning_preview",

  @doc("Evaluation scenario.")
  evaluation: "evaluation",
}

@doc("Configuration for managing data generation jobs.")
@discriminator("type")
model DataGenerationJobConfiguration {
  @doc("The data generation job type.")
  type: DataGenerationJobType;

  @doc("The proportion of the generated data to be used for training when the data is used for fine-tuning. The rest will be used for validation. Value should be between 0 and 1.")
  @minValue(0)
  @maxValue(1)
  train_split?: float32;

  @doc("The LLM model options.")
  model_options?: DataGenerationModelOptions;
}

@doc("The configuration for a data generation job with SimpleQnA type.")
model SimpleQnADataGenerationJobConfiguration
  extends DataGenerationJobConfiguration {
  @doc("The data generation job type, which is SimpleQnA for this model.")
  type: DataGenerationJobType.simple_qna;

  @doc("Maximum number of samples to generate, up to service-defined limits.")
  max_samples: int32;

  @doc("The question types to generate. Used only for fine-tuning scenarios.")
  question_types?: SimpleQnAFineTuningQuestionType[];
}

@doc("The configuration for a data generation job with Traces type.")
model TracesDataGenerationJobConfiguration
  extends DataGenerationJobConfiguration {
  @doc("The data generation job type, which is Traces for this model.")
  type: DataGenerationJobType.traces;

  @doc("Maximum number of samples to generate, up to service-defined limits. If omitted, sampling is turned off.")
  max_samples?: int32;

  @doc("Whether to redact private content from traces. When omitted or set to true, private content is redacted. Set to false to opt out of redaction.")
  redact_private_content?: boolean = true;
}

@doc("The configuration for reconstructing existing traced conversations for evaluation, not synthetic conversation simulation. This preview requires `scenario` to be `evaluation`, sources of type `traces`, and the `Foundry-Features: DataGenerationJobs=V1Preview` request header. Conversation-level sampling is implicit; `sample_level` is not supported. Existing trace selection, annotations, and output dataset row schemas are unchanged. Create, get, and list responses preserve `type: conversations`. The service enforces the scenario, source, and conditional model-options requirements. Conversation-level output rows contain `test_case_id`, `messages`, `tool_definitions`, and `metadata`. A successful optional description adds `test_case_description`. If description generation fails, the row is retained with safe row-level status and error metadata, without raw provider or model error bodies.")
model ConversationsDataGenerationJobConfiguration
  extends DataGenerationJobConfiguration {
  @doc("The data generation job type, which is Conversations for this model.")
  type: DataGenerationJobType.conversations;

  @doc("Maximum number of whole conversations to generate, up to service-defined limits. If omitted, sampling is turned off.")
  max_samples?: int32;

  ...PickProperties<
    TracesDataGenerationJobConfiguration,
    "redact_private_content"
  >;

  @doc("Whether to generate an AI-authored test-case description for each reconstructed conversation. This is a preview feature. Defaults to false. When true, requires a nonempty `model_options.model`. Model options must be omitted when neither description nor rubric generation is enabled.")
  generate_test_case_description?: boolean = false;

  @doc("Whether to generate test-case rubric dimensions for each reconstructed conversation. This is a preview feature. When true, requires a nonempty `model_options.model`. Model options must be omitted when neither description nor rubric generation is enabled.")
  generate_test_case_rubric?: boolean;

  @doc("The model used to generate test-case descriptions or rubric dimensions. Required with a nonempty `model` when `generate_test_case_description` or `generate_test_case_rubric` is true; must be omitted otherwise.")
  model_options?: DataGenerationModelOptions;
}

@doc("The configuration for a task generation data generation job. Use with multiturn evaluation scenarios and with prompt, file, or agent sources. Generated dataset rows include fields such as `id`, `category`, `test_case_description`, and `desired_num_turns`.")
model SimulationSeedDataGenerationJobConfiguration
  extends DataGenerationJobConfiguration {
  @doc("The data generation job type, which is SimulationSeed for this model.")
  type: DataGenerationJobType.simulation_seed;
}

@doc("The configuration for a data generation job with ToolUse type. This is a preview feature used only for fine-tuning scenarios.")
@extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
model ToolUseFineTuningDataGenerationJobConfiguration
  extends DataGenerationJobConfiguration {
  @doc("The data generation job type, which is ToolUse for this model.")
  type: DataGenerationJobType.tool_use;

  @doc("Maximum number of samples to generate, up to service-defined limits.")
  max_samples: int32;
}

@doc("The supported source types for data generation jobs.")
union DataGenerationJobSourceType {
  string,

  @doc("Prompt source — inline text provided by the user.")
  prompt: "prompt",

  @doc("Agent source — references an agent.")
  agent: "agent",

  @doc("Traces source — conversation traces from Application Insights.")
  traces: "traces",

  @doc("File source — Azure OpenAI file.")
  file: "file",
}

@doc("The base source model for data generation jobs.")
@discriminator("type")
model DataGenerationJobSource {
  @doc("The type of source.")
  type: DataGenerationJobSourceType;

  ...JobSourceDescription;
}

@doc("Prompt source for data generation jobs — inline text provided by the user.")
model PromptDataGenerationJobSource extends DataGenerationJobSource {
  ...PromptJobSource;
}

@doc("Agent source for data generation jobs — references an agent to fetch instructions and metadata from.")
model AgentDataGenerationJobSource extends DataGenerationJobSource {
  ...AgentJobSource;
}

@doc("Traces source for data generation jobs — conversation traces from Application Insights.")
model TracesDataGenerationJobSource extends DataGenerationJobSource {
  ...TracesJobSource;

  @doc("Optional explicit list of trace IDs to include.")
  trace_ids?: string[];
}

@doc("File source for data generation jobs — Azure OpenAI file input.")
model FileDataGenerationJobSource extends DataGenerationJobSource {
  @doc("The source type for this job, which is File.")
  type: DataGenerationJobSourceType.file;

  @doc("Input Azure Open AI file id used for data generation.")
  id: string;
}

@doc("The supported question types for SimpleQnA data generation jobs used for fine-tuning scenarios. This is a preview feature.")
@extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
union SimpleQnAFineTuningQuestionType {
  string,

  @doc("Short answer question type.")
  short_answer: "short_answer",

  @doc("Long answer question type.")
  long_answer: "long_answer",
}
