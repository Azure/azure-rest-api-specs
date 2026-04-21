import "../common/models.tsp";
import "../servicepatterns.tsp";

namespace Azure.AI.Projects;

@doc("The supported data generation job types.")
union DataGenerationJobType {
  string,

  @doc("Simple question and answers between user and agent.")
  SimpleQnA: "SimpleQnA",

  @doc("Single turn query and response from agent traces.")
  Traces: "Traces",

  @doc("Tool calling conversation between user and agent.")
  ToolUse: "ToolUse",

  @doc("Task helps in providing a scenario description for generating multi turn conversation between user and agent.")
  Task: "Task",
}

@doc("LLM model options for data generation jobs.")
model DataGenerationModelOptions {
  @doc("Base model name used to generate data.")
  `model`: string;
}

@doc("Caller-supplied inputs for a data generation job.")
model DataGenerationJobInputs {
  @doc("The display name of the data generation job.")
  name: string;

  @doc("The sources used for the data generation job.")
  sources: Array<DataGenerationJobSource>;

  @doc("The options for the data generation job.")
  options: DataGenerationJobOptions;

  @doc("The scenario of the data generation job. Either for fine-tuning or evaluation.")
  scenario: DataGenerationJobScenario;
}

@doc("Result produced by a successful data generation job.")
model DataGenerationJobResult {
  @doc("The final job outputs: Azure OpenAI files for fine-tuning, or datasets for evaluation.")
  outputs?: Array<DataGenerationJobOutput>;

  @doc("The number of samples actually generated.")
  generated_samples?: int32;

  @doc("The token usage information for the data generation job.")
  token_usage?: TokenUsage;
}

@doc("Data Generation Job resource.")
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
model DataGenerationJobOutput {
  @doc("The type of the output.")
  type: DataGenerationJobOutputType;
}

model FileDataGenerationJobOutput extends DataGenerationJobOutput {
  @doc("Azure OpenAI file output.")
  type: "File";

  @doc("The id of the output Azure OpenAI file.")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("The filename of the output Azure OpenAI file.")
  @visibility(Lifecycle.Read)
  filename: string;
}

model DatasetDataGenerationJobOutput extends DataGenerationJobOutput {
  @doc("Dataset output.")
  type: "Dataset";

  @doc("The id of the output dataset created.")
  @visibility(Lifecycle.Read)
  id?: string;

  @doc("The name of the output dataset and can be optionally set during job creation time.")
  name?: string;

  @doc("The version of the output dataset.")
  @visibility(Lifecycle.Read)
  version?: string;

  @doc("Description of the output dataset and can be optionally set during job creation time.")
  description?: string;

  @doc("Tag dictionary of the output dataset and can be optionally set during job creation time.")
  tags?: Record<string>;
}

@doc("The supported output file types for a data generation job.")
union DataGenerationJobOutputType {
  string,

  @doc("The generated data is an Azure OpenAI File.")
  File: "File",

  @doc("The generated data is a Dataset.")
  Dataset: "Dataset",
}

@doc("Token usage information for a data generation job.")
model TokenUsage {
  @doc("The number of prompt tokens used.")
  @visibility(Lifecycle.Read)
  prompt_tokens?: int64;

  @doc("The number of completion tokens generated.")
  @visibility(Lifecycle.Read)
  completion_tokens?: int64;

  @doc("Total number of tokens used.")
  @visibility(Lifecycle.Read)
  total_tokens?: int64;
}

@doc("The supported scenarios for a data generation job.")
union DataGenerationJobScenario {
  string,

  @doc("Supervised Fine-tuning scenario.")
  SupervisedFineTuning: "SupervisedFineTuning",

  @doc("Reinforcement Fine-tuning scenario.")
  ReinforcementFineTuning: "ReinforcementFineTuning",

  @doc("Evaluation scenario.")
  Evaluation: "Evaluation",
}

@doc("Options for managing data generation jobs.")
@discriminator("type")
model DataGenerationJobOptions {
  @doc("The data generation job type.")
  type: DataGenerationJobType;

  @doc("Maximum number of samples to generate.")
  max_samples: int32;

  @doc("The proportion of the generated data to be used for training when the data is used for fine-tuning. The rest will be used for validation. Value should be between 0 and 1.")
  train_split?: float32;

  @doc("The LLM model options.")
  model_options?: DataGenerationModelOptions;
}

@doc("The options for a data generation job with SimpleQnA type.")
model SimpleQnADataGenerationJobOptions extends DataGenerationJobOptions {
  @doc("The data generation job type, which is SimpleQnA for this model.")
  type: "SimpleQnA";

  @doc("The question types to generate. Used only for fine-tuning scenarios.")
  question_types?: Array<SimpleQnAFineTuningQuestionType>;
}

@doc("The options for a data generation job with Traces type.")
model TracesDataGenerationJobOptions extends DataGenerationJobOptions {
  @doc("The data generation job type, which is Traces for this model.")
  type: "Traces";
}

@doc("The options for a data generation job with ToolUse type. Used only for fine-tuning scenarios.")
model ToolUseFineTuningDataGenerationJobOptions
  extends DataGenerationJobOptions {
  @doc("The data generation job type, which is ToolUse for this model.")
  type: "ToolUse";
}

@doc("The options for a data generation job with Task type.")
model TaskDataGenerationJobOptions extends DataGenerationJobOptions {
  @doc("The data generation job type, which is Task for this model.")
  type: "Task";
}

@doc("The supported job source types for data generation.")
union DataGenerationJobSource {
  JobSource,
  FileDataGenerationJobSource,
}

@doc("The options for a data generation job with File source, which includes the input files for data generation.")
model FileDataGenerationJobSource {
  @doc("The source type for this job, which is File.")
  type: "File";

  @doc("Input Azure Open AI file id used for data generation.")
  id: string;
}

@doc("The supported question types for SimpleQnA data generation jobs used for fine-tuning scenarios.")
union SimpleQnAFineTuningQuestionType {
  string,

  @doc("Short answer question type.")
  ShortAnswer: "ShortAnswer",

  @doc("Long answer question type.")
  LongAnswer: "LongAnswer",
}
