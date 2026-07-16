import "../common/models.tsp";
import "../common/servicepatterns.tsp";

using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

const DataGenerationJobsRequiredPreviews = #{
  conditional_previews: #[FoundryFeaturesOptInKeys.data_generation_jobs_v1_preview],
};

@doc("The supported data generation job types.")
@extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
union DataGenerationJobType {
  string,

  @doc("Simple question and answers between user and agent.")
  simple_qna: "simple_qna",

  @doc("Single turn query and response from agent traces.")
  traces: "traces",

  @doc("Tool calling conversation between user and agent.")
  tool_use: "tool_use",

  @doc("Task generation for evaluation scenarios.")
  task_generation: "task_generation",
}

@doc("LLM model options for data generation jobs.")
@extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
model DataGenerationModelOptions {
  @doc("Base model name used to generate data.")
  `model`: string;
}

@doc("Caller-supplied inputs for a data generation job.")
@extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
model DataGenerationJobInputs {
  @doc("The display name of the data generation job.")
  name: string;

  @doc("The sources used for the data generation job.")
  sources: DataGenerationJobSource[];

  @doc("The options for the data generation job.")
  options: DataGenerationJobOptions;

  @doc("The scenario of the data generation job. Either for fine-tuning or evaluation.")
  scenario: DataGenerationJobScenario;

  @doc("Optional caller-supplied metadata for the job's output. See individual fields for whether they apply to file outputs (fine-tuning scenarios), dataset outputs (evaluation scenario), or both.")
  output_options?: DataGenerationJobOutputOptions;
}

@doc("Output options for data generation job.")
@extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
model DataGenerationJobOutputOptions {
  @doc("Name to assign to the output. Used as the filename for Azure OpenAI file outputs (fine-tuning scenarios) and as the dataset name for dataset outputs (evaluation scenario).")
  name?: string;

  @doc("Description to assign to the output. Applies only to dataset outputs (evaluation scenario); ignored for Azure OpenAI file outputs.")
  description?: string;

  @doc("Tags to assign to the output. Applies only to dataset outputs (evaluation scenario); ignored for Azure OpenAI file outputs.")
  tags?: Record<string>;
}

@doc("Result produced by a successful data generation job.")
@extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
model DataGenerationJobResult {
  @doc("The final job outputs: Azure OpenAI files for fine-tuning, or datasets for evaluation.")
  outputs?: DataGenerationJobOutput[];

  @doc("The number of samples actually generated.")
  generated_samples: int32;

  @doc("The token usage information for the data generation job.")
  token_usage?: DataGenerationTokenUsage;
}

@doc("Data Generation Job resource.")
@extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
model DataGenerationJob
  is JobLike<DataGenerationJobResult, DataGenerationJobInputs> {
  @doc("The timestamp when the job was created, represented in Unix time (seconds since January 1, 1970).")
  @visibility(Lifecycle.Read)
  created_at: FoundryTimestamp;

  @doc("The timestamp when the job was finished, represented in Unix time (seconds since January 1, 1970).")
  @visibility(Lifecycle.Read)
  finished_at?: FoundryTimestamp;
}

@doc("Output information for a data generation job.")
@discriminator("type")
@extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
model DataGenerationJobOutput {
  @doc("The type of the output.")
  type: DataGenerationJobOutputType;
}

@doc("Azure OpenAI file output for a data generation job.")
@extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
model FileDataGenerationJobOutput extends DataGenerationJobOutput {
  @doc("Azure OpenAI file output.")
  type: "file";

  @doc("The id of the output Azure OpenAI file.")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("The filename of the output Azure OpenAI file.")
  @visibility(Lifecycle.Read)
  filename: string;
}

@doc("Dataset output for a data generation job.")
@extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
model DatasetDataGenerationJobOutput extends DataGenerationJobOutput {
  @doc("Dataset output.")
  type: "dataset";

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
@extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
union DataGenerationJobOutputType {
  string,

  @doc("The generated data is an Azure OpenAI File.")
  file: "file",

  @doc("The generated data is a Dataset.")
  dataset: "dataset",
}

@doc("Token usage information for a data generation job.")
@extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
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
@extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
union DataGenerationJobScenario {
  string,

  @doc("Supervised Fine-tuning scenario.")
  supervised_finetuning: "supervised_finetuning",

  @doc("Reinforcement Fine-tuning scenario.")
  reinforcement_finetuning: "reinforcement_finetuning",

  @doc("Evaluation scenario.")
  evaluation: "evaluation",
}

@doc("Options for managing data generation jobs.")
@discriminator("type")
@extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
model DataGenerationJobOptions {
  @doc("The data generation job type.")
  type: DataGenerationJobType;

  @doc("Maximum number of samples to generate.")
  max_samples: int32;

  @doc("The proportion of the generated data to be used for training when the data is used for fine-tuning. The rest will be used for validation. Value should be between 0 and 1.")
  @minValue(0)
  @maxValue(1)
  train_split?: float32;

  @doc("The LLM model options.")
  model_options?: DataGenerationModelOptions;
}

@doc("The options for a data generation job with SimpleQnA type.")
@extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
model SimpleQnADataGenerationJobOptions extends DataGenerationJobOptions {
  @doc("The data generation job type, which is SimpleQnA for this model.")
  type: "simple_qna";

  @doc("The question types to generate. Used only for fine-tuning scenarios.")
  question_types?: SimpleQnAFineTuningQuestionType[];
}

@doc("The options for a data generation job with Traces type.")
@extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
model TracesDataGenerationJobOptions extends DataGenerationJobOptions {
  @doc("The data generation job type, which is Traces for this model.")
  type: "traces";
}

@doc("The options for a task generation data generation job. Use with multiturn evaluation scenarios and with prompt, file, or agent sources. Generated dataset rows include fields such as `id`, `category`, `test_case_description`, and `desired_num_turns`.")
@extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
model TaskGenerationDataGenerationJobOptions extends DataGenerationJobOptions {
  @doc("The data generation job type, which is TaskGeneration for this model.")
  type: "task_generation";
}

@doc("The options for a data generation job with ToolUse type. Used only for fine-tuning scenarios.")
@extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
model ToolUseFineTuningDataGenerationJobOptions
  extends DataGenerationJobOptions {
  @doc("The data generation job type, which is ToolUse for this model.")
  type: "tool_use";
}

@doc("The supported source types for data generation jobs.")
@extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
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
@extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
model DataGenerationJobSource {
  @doc("The type of source.")
  type: DataGenerationJobSourceType;

  ...JobSourceDescription;
}

@doc("Prompt source for data generation jobs — inline text provided by the user.")
@extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
model PromptDataGenerationJobSource extends DataGenerationJobSource {
  ...PromptJobSource;
}

@doc("Agent source for data generation jobs — references an agent to fetch instructions and metadata from.")
@extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
model AgentDataGenerationJobSource extends DataGenerationJobSource {
  ...AgentJobSource;
}

@doc("Traces source for data generation jobs — conversation traces from Application Insights.")
@extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
model TracesDataGenerationJobSource extends DataGenerationJobSource {
  ...TracesJobSource;
}

@doc("File source for data generation jobs — Azure OpenAI file input.")
@extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
model FileDataGenerationJobSource extends DataGenerationJobSource {
  @doc("The source type for this job, which is File.")
  type: "file";

  @doc("Input Azure Open AI file id used for data generation.")
  id: string;
}

@doc("The supported question types for SimpleQnA data generation jobs used for fine-tuning scenarios.")
@extension("x-ms-foundry-meta", DataGenerationJobsRequiredPreviews)
union SimpleQnAFineTuningQuestionType {
  string,

  @doc("Short answer question type.")
  short_answer: "short_answer",

  @doc("Long answer question type.")
  long_answer: "long_answer",
}
