import "../common/models.tsp";

namespace Azure.AI.Projects;

@doc("The supported data generation job types.")
union DataGenerationJobType {
  string,

  @doc("Simple question and answer between user and agent job type")
  SimpleQnA: "SimpleQnA",

  @doc("Tool use job type")
  ToolUse: "ToolUse",

  @doc("Multi turn conversation between agents and user.")
  MultiTurn: "MultiTurn",
}

@doc("LLM model options for data generation jobs.")
model DataGenerationModelOptions {
  @doc("Base model name used to generate data.")
  model_name: string;
}

@doc("Status values for a data generation job.")
union DataGenerationJobStatus {
  string,

  @doc("Job has been queued and is waiting to start.")
  queued: "queued",

  @doc("Job is currently running.")
  running: "running",

  @doc("Job completed successfully.")
  succeeded: "succeeded",

  @doc("Job failed.")
  failed: "failed",

  @doc("Job was cancelled.")
  cancelled: "cancelled",
}

@doc("Data Generation Job resource.")
model DataGenerationJob {
  @doc("The display name of the data generation job.")
  name: string;

  @doc("The sources used for the data generation job.")
  sources: Array<DataGenerationJobSource>;

  @doc("The options for the data generation job.")
  options: DataGenerationJobOptions;

  @doc("The purpose of the data generation job. Either for fine-tuning supervised training or evaluation.")
  purpose: DataGenerationJobPurpose;

  @doc("The job identifier.")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("The current status of the job.")
  @visibility(Lifecycle.Read)
  status: DataGenerationJobStatus;

  @doc("The output information of the data generation job, which includes the output file type and the identifiers of the generated output.")
  output?: DataGenerationJobOutput;

  @doc("The number of samples actually generated. This field will be populated only after the job is completed.")
  @visibility(Lifecycle.Read)
  generated_samples_count?: int32;

  @doc("The token usage information for the data generation job.")
  @visibility(Lifecycle.Read)
  token_usage?: TokenUsage;

  @doc("The timestamp when the job was created, represented in Unix time (seconds since January 1, 1970).")
  @visibility(Lifecycle.Read)
  created_at: int64;

  @doc("The timestamp when the job was completed, represented in Unix time (seconds since January 1, 1970).")
  @visibility(Lifecycle.Read)
  completed_at?: int64;

  @doc("Error information set only when status is 'failed'.")
  @visibility(Lifecycle.Read)
  error?: ApiError;

  @doc("Additional warnings related to the data generation job execution. These are non-critical issues that do not cause the job to fail but may be important for users to be aware of.")
  @visibility(Lifecycle.Read)
  warnings?: {
    @doc("A human-readable warning message.")
    message?: string;
  };
}

@doc("Output information for a data generation job.")
model DataGenerationJobOutput {
  @doc("The type of the output. If not specified, it will default to File type.")
  type?: DataGenerationJobOutputFileType;

  @doc("The identifiers of the output only available after the job is completed. For Finetuning supervised training jobs with File output type, the size of array will be 2 and for other file types & purpose, this will be always 1.")
  @visibility(Lifecycle.Read)
  ids: Array<string>;
}

@doc("The supported output file types for a data generation job.")
union DataGenerationJobOutputFileType {
  string,

  @doc("The generated data is stored in an Azure OpenAI Files.")
  File: "File",

  @doc("The generated data is stored in an Azure Blob Storage container.")
  Dataset: "Dataset",
}

@doc("Token usage information for a data generation job.")
model TokenUsage {
  @doc("The number of prompt tokens used.")
  @visibility(Lifecycle.Read)
  prompt_tokens?: int32;

  @doc("The number of completion tokens generated.")
  @visibility(Lifecycle.Read)
  completion_tokens?: int32;

  @doc("Total number of tokens used.")
  @visibility(Lifecycle.Read)
  total_tokens?: int32;
}

@doc("The supported purposes for a data generation job.")
union DataGenerationJobPurpose {
  string,

  @doc("Fine-tuning supervised training purpose.")
  SupervisedFineTuning: "SupervisedFineTuning",

  @doc("Reinforcement learning fine-tuning training purpose.")
  ReinforcementFineTuning: "ReinforcementFineTuning",

  @doc("Evaluation purpose.")
  Evaluation: "Evaluation",
}

@doc("The supported source types for a data generation job.")
union DataGenerationJobSourceType {
  string,

  @doc("Traces source type. Data is generated based on input traces such as conversations, tool calls, etc retrieved from the project connected Application Insights.")
  Traces: "Traces",

  @doc("Prompt source type. Data is generated based on input prompts provided by the user or will be extracted from the given Agent. Applicable only for evaluation purpose.")
  Prompt: "Prompt",

  @doc("Seed data files source type. Data is generated based on input seed data files from the given input datasets. Applicable only for fine-tuning training purpose.")
  SeedDataFiles: "SeedDataFiles",
}

@doc("Options for managing data generation jobs.")
@discriminator("type")
model DataGenerationJobOptions {
  @doc("The data generation job type.")
  type: DataGenerationJobType;

  @doc("Maximum number of samples to generate.")
  max_samples_count: int32;

  @doc("The model deployment options. Required only when the data source type is not Traces.")
  model_options?: DataGenerationModelOptions;
}

@doc("The options for a data generation job with SimpleQnA type.")
model SimpleQnADataGenerationJobOptions extends DataGenerationJobOptions {
  @doc("The data generation job type, which is SimpleQnA for this model.")
  type: "SimpleQnA";

  @doc("The question types to generate. If not specified, both short answer and long answer question types will be generated. Applicable only for simple QnA data generation jobs used for supervised fine-tuning training.")
  question_types?: Array<SimpleQnASupervisedFineTuningQuestionType>;
}

@doc("The options for ToolUse data generation job used for fine-tuning supervised training.")
model ToolUseFineTuningDataGenerationJobOptions
  extends DataGenerationJobOptions {
  @doc("The data generation job type, which is ToolUse for this model.")
  type: "ToolUse";
}

@doc("The options for a data generation job with MultiTurn type.")
model MultiTurnDataGenerationJobOptions extends DataGenerationJobOptions {
  @doc("The data generation job type, which is MultiTurn for this model.")
  type: "MultiTurn";
}

@doc("The base source model for a data generation job.")
@discriminator("type")
model DataGenerationJobSource {
  @doc("The type of source.")
  type: DataGenerationJobSourceType;
}

@doc("The options for a data generation job with Traces source used for Evaluation and fine-tuning purposes, which includes the agent name and the time window for fetching traces.")
model TracesDataGenerationJobSource extends DataGenerationJobSource {
  @doc("The source type for this job, which is Traces.")
  type: "Traces";

  @doc("The agent name to fetch the traces for data generation. The traces will be fetched based on the agent name from the project connected Application Insights within the specified time window. If both agent name and agent version are specified, the agent version will be used to fetch the traces.")
  agent_name: string;

  @doc("The agent version to fetch the traces for data generation. If not specified, the latest version of the agent will be used.")
  agent_version?: string;

  @doc("The start of the time window for fetching traces. This defines the beginning of the time range for which traces will be considered for data generation.")
  from_time: utcDateTime;

  @doc("The end of the time window for fetching traces. This defines the end of the time range for which traces will be considered for data generation. If not specified, it will default to the current time, meaning that traces up until now will be considered for data generation.")
  to_time?: utcDateTime;
}

@doc("The options for a data generation job with Prompt source used for Evaluation purpose, which includes the prompt or the agent name to fetch the prompt and other metadata for data generation.")
model PromptDataGenerationJobSource extends DataGenerationJobSource {
  @doc("The source type for this job, which is Prompt.")
  type: "Prompt";

  @doc("The prompt used for data generation. Required if agent name is not specified.")
  prompt?: string;

  @doc("The agent name to fetch the traces for data generation. The traces will be fetched based on the agent name from the project connected Application Insights within the specified time window. If both agent name and agent version are specified, the agent version will be used to fetch the traces.")
  agent_name: string;

  @doc("The agent version to fetch the traces for data generation. If not specified, the latest version of the agent will be used.")
  agent_version?: string;
}

@doc("The options for a data generation job with SeedDataFiles source, which includes the input seed data files for data generation.")
model SeedDataFilesDataGenerationJobSource extends DataGenerationJobSource {
  @doc("The source type for this job, which is SeedDataFiles.")
  type: "SeedDataFiles";

  @doc("Input seed data file references (can be dataset IDs or Azure Open AI file ids) used for data generation. The dataset should already exist before creating the job.")
  seed_data_files: Array<string>;
}

@doc("The supported question types for SimpleQnA data generation jobs used for supervised fine-tuning training.")
union SimpleQnASupervisedFineTuningQuestionType {
  string,

  @doc("Short answer question type.")
  ShortAnswer: "ShortAnswer",

  @doc("Long answer question type.")
  LongAnswer: "LongAnswer",
}
